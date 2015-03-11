<?xml version="1.0"?>
<!--
   Schematron epubcheck schema: verify if EPUB conforms to
   minimal  profile (well-formed, no DRM).
   Based on output of epubcheck using -out switch, which results in XML output that follows
   the JHOVE schema.

-->
<s:schema xmlns:s="http://purl.oclc.org/dsdl/schematron">
<s:ns uri="http://hul.harvard.edu/ois/xml/ns/jhove" prefix="jh"/>

  <!-- Status level checks -->
  <s:pattern name="WellFormedEpubCheck">
    <s:rule context="/jh:jhove/jh:repInfo">
      <s:assert test="(jh:status = 'Well-formed')">not well-formed epub</s:assert>
    </s:rule>
  </s:pattern>

  <s:pattern name="encryptedResource">
    <s:rule context="/jh:jhove/jh:repInfo/jh:messages">
      <s:assert test="count(jh:message[contains(.,'cannot be decrypted')])=0">Encrypted resource detected</s:assert>
    </s:rule>
  </s:pattern>

  <!-- Top-level properties checks -->
  <s:pattern name="DRMDetectionEpubCheck">
    <s:rule context="/jh:jhove/jh:repInfo/jh:properties/jh:property">
      <!-- Encryption -->
      <s:assert test="(jh:name = 'hasEncryption' and jh:values/jh:value ='false') or (jh:name != 'hasEncryption')">Encryption detected</s:assert>
    </s:rule>
  </s:pattern>

</s:schema>
