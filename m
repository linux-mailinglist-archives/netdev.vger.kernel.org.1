Return-Path: <netdev+bounces-227655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C53BB4F00
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 20:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0993A9464
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 18:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BAA27815D;
	Thu,  2 Oct 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="A6+uUV1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72012C544
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431034; cv=none; b=D5VbjoPSCMnUrDpBqX7F3l2/8PuNW4QgraACytbJbE1e1ZfaOg6V5/wQUFOKYPxXK+867NGOncVHg2TFTz/Jv6QZExuia/eB8pE+vIBRhCVxF6kdFIGf6TvCTaq7zXA4XJhPptWPKJsmigPBfa6mvOJgG63Ep6Yi+eQd/Ow1J60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431034; c=relaxed/simple;
	bh=cuHNoaoQA/mYdX1NkFEm1CO6fGng6aG/zV5xSrLtLBQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HJ5fjQc8FVKa/Uq4QJNrrt7rs2gT843orqTapn5Cfi/3nuM8uIlIecRCWZmldXuik8ttmDMMOZK2Urh7TmvI5yaErepTjt5cH5DSKdHCqt/ovmhAcXbFnr9xG0XeHeaA9bpCO7rHjJF59dS15bu8Kbnmn23QCJc0xVT+zk81eMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=A6+uUV1n; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759431023; x=1759690223;
	bh=OP1dpDq9XetQX//ukKFyQdJPDdo74hX57NwwRzRrkzY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A6+uUV1ntdMGpuj+iwe1+SG8TMPGxK1+rXQMMYSNRRqLMPtFtn3Lm8ffIYmMCvohD
	 8QOIBEQJFS7NMROsMbbPMCLC3Qa+/BYRSlTN9r4DztDOkk0wWNt8K2xQtX8XdLeRkf
	 F4unXv/zoLVckiyD+DUkXStRHi2BaxxZIh5Nlsjc/fZcNV7rdBL5XmHmzAizQgmo01
	 +Cl6Zzmagb0T05BzXGkVwASjvs/RpxzjPwen7dadYYDHkv1QI3aDGsggheYbfklZ2h
	 V6LCttbp9J1p17+H5SgvQ8941V9pOY7na7ihF16a+bVT2uzz8fCcihDjm5+SpAyb0l
	 YEznL9gGDdVnw==
Date: Thu, 02 Oct 2025 18:50:17 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH] doc/netlink: Expand nftables specification
Message-ID: <20251002184950.1033210-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: f08317cb0d8c4ba3703a9c91c195a490821181af
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Getting out changes I've accumulated while making nftables spec to work wit=
h
Rust netlink-bindings. Hopefully, this will be useful upstream.

This patch:

- Adds missing byte order annotations.
- Fills out attributes in some operations.
- Replaces non-existent "name" attribute with todo comment.
- Adds some missing sub-messages (and associated attributes).
- Adds (copies over) documentation for some attributes / enum entries.
- Adds "getcompat" operation defined in nft_compat.c .

Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/specs/nftables.yaml | 433 ++++++++++++++++++++--
 1 file changed, 408 insertions(+), 25 deletions(-)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netl=
ink/specs/nftables.yaml
index 2ee10d92d..fac0cf483 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -66,9 +66,22 @@ definitions:
     name: bitwise-ops
     type: enum
     entries:
-      - bool
+      -
+        name: mask-xor # aka bool (old name)
+        doc: |
+          mask-and-xor operation used to implement NOT, AND, OR and XOR bo=
olean operations
+            dreg =3D (sreg & mask) ^ xor
+          with these mask and xor values:
+                    mask    xor
+            NOT:    1       1
+            OR:     ~x      x
+            XOR:    1       x
+            AND:    x       0
       - lshift
       - rshift
+      - and
+      - or
+      - xor
   -
     name: cmp-ops
     type: enum
@@ -225,14 +238,216 @@ definitions:
       - icmp-unreach
       - tcp-rst
       - icmpx-unreach
+  -
+    # Defined in include/linux/netfilter/nf_tables.h
+    name: payload-base
+    type: enum
+    entries:
+      - link-layer-header
+      - network-header
+      - transport-header
+      - inner-header
+      - tun-header
+  -
+    # Defined in include/linux/netfilter/nf_tables.h
+    name: range-ops
+    doc: Range operator
+    type: enum
+    entries:
+      - eq
+      - neq
+  -
+    # Defined in include/linux/netfilter/nf_tables.h
+    name: registers
+    doc: |
+      nf_tables registers.
+      nf_tables used to have five registers: a verdict register and four d=
ata
+      registers of size 16. The data registers have been changed to 16 reg=
isters
+      of size 4. For compatibility reasons, the NFT_REG_[1-4] registers st=
ill
+      map to areas of size 16, the 4 byte registers are addressed using
+      NFT_REG32_00 - NFT_REG32_15.
+    type: enum
+    entries:
+      - reg_verdict
+      - reg_1
+      - reg_2
+      - reg_3
+      - reg_4
+      -
+        name: reg32_00
+        value: 8
+      - reg32_01
+      - reg32_02
+      - reg32_03
+      - reg32_04
+      - reg32_05
+      - reg32_06
+      - reg32_07
+      - reg32_08
+      - reg32_09
+      - reg32_10
+      - reg32_11
+      - reg32_12
+      - reg32_13
+      - reg32_14
+      - reg32_15
+  -
+    # Defined in include/linux/netfilter/nf_tables.h
+    name: numgen-types
+    type: enum
+    entries:
+      - incremental
+      - random
+  -
+    name: log-level
+    doc: nf_tables log levels
+    type: enum
+    entries:
+      -
+        name: emerg
+        doc: system is unusable
+      -
+        name: alert
+        doc: action must be taken immediately
+      -
+        name: crit
+        doc: critical conditions
+      -
+        name: err
+        doc: error conditions
+      -
+        name: warning
+        doc: warning conditions
+      -
+        name: notice
+        doc: normal but significant condition
+      -
+        name: info
+        doc: informational
+      -
+        name: debug
+        doc: debug-level messages
+      -
+        name: audit
+        doc: enabling audit logging
+  -
+    # Defined in include/uapi/linux/netfilter/nf_log.h
+    name: log-flags
+    doc: nf_tables log flags
+    type: flags
+    entries:
+      -=20
+        name: tcpseq
+        doc: Log TCP sequence numbers
+      -
+        name: tcpopt
+        doc: Log TCP options
+      -
+        name: ipopt
+        doc: Log IP options
+      -
+        name: uid
+        doc: Log UID owning local socket
+      -
+        name: nflog
+        doc: Unsupported, don't reuse
+      -
+        name: macdecode
+        doc: Decode MAC header
=20
 attribute-sets:
   -
-    name: empty-attrs
+    # Defined in include/linux/netfilter/nf_tables.h
+    name: log-attrs
+    doc: log expression netlink attributes
     attributes:
+      # Mentioned in nft_log_init()
       -
-        name: name
+        name: group
+        doc: netlink group to send messages to
+        type: u16
+        byte-order: big-endian
+      -
+        name: prefix
+        doc: prefix to prepend to log messages
         type: string
+      -
+        name: snaplen
+        doc: length of payload to include in netlink message
+        type: u32
+        byte-order: big-endian
+      -
+        name: qthreshold
+        doc: queue threshold
+        type: u16
+        byte-order: big-endian
+      -
+        name: level
+        doc: log level
+        type: u32
+        enum: log-level
+        byte-order: big-endian
+      -
+        name: flags
+        doc: logging flags
+        type: u32
+        enum: log-flags
+        byte-order: big-endian
+
+  -
+    # Defined in include/linux/netfilter/nf_tables.h
+    name: numgen-attrs
+    doc: nf_tables number generator expression netlink attributes
+    attributes:
+      -
+        name: dreg
+        doc: destination register
+        type: u32
+        enum: registers
+      -
+        name: modulus
+        doc: maximum counter value
+        type: u32
+        byte-order: big-endian
+      -
+        name: type
+        doc: operation type
+        type: u32
+        byte-order: big-endian
+        enum: numgen-types
+      -
+        name: offset
+        doc: offset to be added to the counter
+        type: u32
+        byte-order: big-endian
+  -
+    # Defined in net/netfilter/nft_range.c
+    name: range-attrs
+    attributes:
+      -
+        name: sreg
+        doc: source register of data to compare
+        type: u32
+        byte-order: big-endian
+        enum: registers
+      -
+        name: op
+        doc: cmp operation
+        type: u32
+        byte-order: big-endian
+        enum: range-ops
+        checks:
+          max: 256
+      -
+        name: from-data
+        doc: data range from
+        type: nest
+        nested-attributes: data-attrs
+      -
+        name: to-data
+        doc: data range to
+        type: nest
+        nested-attributes: data-attrs
   -
     name: batch-attrs
     attributes:
@@ -371,9 +586,11 @@ attribute-sets:
       -
         name: bytes
         type: u64
+        byte-order: big-endian
       -
         name: packets
         type: u64
+        byte-order: big-endian
   -
     name: rule-attrs
     attributes:
@@ -443,15 +660,18 @@ attribute-sets:
         selector: name
         doc: type specific data
   -
+    # Mentioned in nft_parse_compat() in net/netfilter/nft_compat.c
     name: rule-compat-attrs
     attributes:
       -
         name: proto
-        type: binary
+        type: u32
+        byte-order: big-endian
         doc: numeric value of the handled protocol
       -
         name: flags
-        type: binary
+        type: u32
+        byte-order: big-endian
         doc: bitmask of flags
   -
     name: set-attrs
@@ -814,6 +1034,7 @@ attribute-sets:
         type: nest
         nested-attributes: data-attrs
   -
+    # Defined as nft_data_attributes in include/linux/netfilter/nf_tables.=
h
     name: data-attrs
     attributes:
       -
@@ -829,25 +1050,31 @@ attribute-sets:
     attributes:
       -
         name: code
+        doc: nf_tables verdict
         type: u32
         byte-order: big-endian
         enum: verdict-code
       -
         name: chain
+        doc: jump target chain name
         type: string
       -
         name: chain-id
+        doc: jump target chain ID
         type: u32
+        byte-order: big-endian # Accessed in nft_chain_lookup_byid
   -
     name: expr-counter-attrs
     attributes:
       -
         name: bytes
         type: u64
+        byte-order: big-endian
         doc: Number of bytes
       -
         name: packets
         type: u64
+        byte-order: big-endian
         doc: Number of packets
       -
         name: pad
@@ -982,38 +1209,51 @@ attribute-sets:
         enum: nat-range-flags
         enum-as-flags: true
   -
+    # Defined as nft_payload_attributes in include/linux/netfilter/nf_tabl=
es.h
     name: expr-payload-attrs
+    doc: nf_tables payload expression netlink attributes
     attributes:
       -
         name: dreg
+        doc: destination register to load data into
         type: u32
         byte-order: big-endian
+        enum: registers
       -
         name: base
+        doc: payload base
         type: u32
+        enum: payload-base
         byte-order: big-endian
       -
         name: offset
+        doc: payload offset relative to base
         type: u32
         byte-order: big-endian
       -
         name: len
+        doc: payload length
         type: u32
         byte-order: big-endian
       -
         name: sreg
+        doc: source register to load data from
         type: u32
         byte-order: big-endian
+        enum: registers
       -
         name: csum-type
+        doc: checksum type
         type: u32
         byte-order: big-endian
       -
         name: csum-offset
+        doc: checksum offset relative to base
         type: u32
         byte-order: big-endian
       -
         name: csum-flags
+        doc: checksum flags
         type: u32
         byte-order: big-endian
   -
@@ -1079,6 +1319,61 @@ attribute-sets:
         type: u32
         byte-order: big-endian
         doc: id of object map
+  -
+    # Defined as nft_target_attributes in include/uapi/linux/netfilter/nf_=
tables_compat.h
+    name: compat-target-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        checks:
+          max-len: 32
+      -
+        name: rev
+        type: u32
+        byte-order: big-endian
+        checks:
+          max: 255
+      -
+        name: info
+        type: binary
+  -
+    # Defined as nft_match_attributes in include/uapi/linux/netfilter/nf_t=
ables_compat.h
+    name: compat-match-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        checks:
+          max-len: 32
+      -
+        name: rev
+        type: u32
+        byte-order: big-endian
+        checks:
+          max: 255
+      -
+        name: info
+        type: binary
+  -
+    # Defined in include/uapi/linux/netfilter/nf_tables_compat.h
+    name: compat-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        checks:
+          max-len: 32
+      -
+        name: rev
+        type: u32
+        byte-order: big-endian
+        checks:
+          max: 255
+      -
+        name: type
+        type: u32
+        byte-order: big-endian
=20
 sub-messages:
   -
@@ -1132,6 +1427,19 @@ sub-messages:
       -
         value: tproxy
         attribute-set: expr-tproxy-attrs
+      -
+        value: match
+        attribute-set: compat-match-attrs
+      -
+        value: range
+        attribute-set: range-attrs
+      -
+        value: numgen
+        attribute-set: numgen-attrs
+      -
+        value: log
+        attribute-set: log-attrs
+      # There're more to go: grep -A10 nft_expr_type and look for .name\s*=
=3D\s*"..."
   -
     name: obj-data
     formats:
@@ -1145,6 +1453,26 @@ sub-messages:
 operations:
   enum-model: directional
   list:
+    -
+      # Defined as nfnl_compat_subsys in net/netfilter/nft_compat.c
+      name: getcompat
+      attribute-set: compat-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xb00
+          attributes:
+            - name
+            - rev
+            - type
+        reply:
+          value: 0xb00
+          attributes:
+            - name
+            - rev
+            - type
+      dump:
+        reply:
     -
       name: batch-begin
       doc: Start a batch of operations
@@ -1188,11 +1516,18 @@ operations:
         request:
           value: 0xa01
           attributes:
-            - name
+            # TODO:
         reply:
           value: 0xa00
+          attributes:
+            # TODO:
+      dump:
+        reply:
           attributes:
             - name
+            - use
+            - handle
+            - flags
     -
       name: deltable
       doc: Delete an existing table.
@@ -1239,6 +1574,18 @@ operations:
           value: 0xa03
           attributes:
             - name
+      dump:
+        reply:
+          attributes:
+            - table
+            - name
+            - handle
+            - hook
+            - policy
+            - type
+            - counters
+            - id
+            - use
     -
       name: delchain
       doc: Delete an existing chain.
@@ -1270,7 +1617,11 @@ operations:
         request:
           value: 0xa06
           attributes:
-            - name
+            - table
+            - chain
+            - expressions
+            - compat
+        reply:
     -
       name: getrule
       doc: Get / dump rules.
@@ -1280,11 +1631,23 @@ operations:
         request:
           value: 0xa07
           attributes:
-            - name
+            # TODO:
         reply:
           value: 0xa06
           attributes:
-            - name
+            # TODO:
+      dump:
+        request:
+          attributes:
+            - table
+            - chain
+        reply:
+          attributes:
+            - table
+            - chain
+            - handle
+            - position
+            - expressions
     -
       name: getrule-reset
       doc: Get / dump rules and reset stateful expressions.
@@ -1294,11 +1657,13 @@ operations:
         request:
           value: 0xa19
           attributes:
-            - name
+            # TODO:
         reply:
           value: 0xa06
           attributes:
-            - name
+            # TODO:
+      dump:
+        reply:
     -
       name: delrule
       doc: Delete an existing rule.
@@ -1308,7 +1673,7 @@ operations:
         request:
           value: 0xa08
           attributes:
-            - name
+            # TODO:
     -
       name: destroyrule
       doc: |
@@ -1319,7 +1684,7 @@ operations:
         request:
           value: 0xa1c
           attributes:
-            - name
+            # TODO:
     -
       name: newset
       doc: Create a new set.
@@ -1329,7 +1694,7 @@ operations:
         request:
           value: 0xa09
           attributes:
-            - name
+            # TODO:
     -
       name: getset
       doc: Get / dump sets.
@@ -1339,11 +1704,17 @@ operations:
         request:
           value: 0xa0a
           attributes:
-            - name
+            # TODO:
         reply:
           value: 0xa09
           attributes:
-            - name
+            # TODO:
+      dump:
+        request:
+          attributes:
+            - table
+        reply:
+          # TODO:
     -
       name: delset
       doc: Delete an existing set.
@@ -1374,7 +1745,7 @@ operations:
         request:
           value: 0xa0c
           attributes:
-            - name
+            # TODO:
     -
       name: getsetelem
       doc: Get / dump set elements.
@@ -1384,11 +1755,13 @@ operations:
         request:
           value: 0xa0d
           attributes:
-            - name
+            # TODO:
         reply:
           value: 0xa0c
           attributes:
-            - name
+            # TODO:
+      dump:
+        reply:
     -
       name: getsetelem-reset
       doc: Get / dump set elements and reset stateful expressions.
@@ -1398,11 +1771,13 @@ operations:
         request:
           value: 0xa21
           attributes:
-            - name
+            # TODO:
         reply:
           value: 0xa0c
           attributes:
-            - name
+            # TODO:
+      dump:
+        reply:
     -
       name: delsetelem
       doc: Delete an existing set element.
@@ -1412,7 +1787,7 @@ operations:
         request:
           value: 0xa0e
           attributes:
-            - name
+            # TODO:
     -
       name: destroysetelem
       doc: Delete an existing set element with destroy semantics.
@@ -1422,7 +1797,7 @@ operations:
         request:
           value: 0xa1e
           attributes:
-            - name
+            # TODO:
     -
       name: getgen
       doc: Get / dump rule-set generation.
@@ -1432,11 +1807,15 @@ operations:
         request:
           value: 0xa10
           attributes:
-            - name
+            # TODO:
         reply:
           value: 0xa0f
           attributes:
-            - name
+            - id
+            - proc-pid
+            - proc-name
+      dump:
+        reply:
     -
       name: newobj
       doc: Create a new stateful object.
@@ -1461,6 +1840,8 @@ operations:
           value: 0xa12
           attributes:
             - name
+      dump:
+        reply:
     -
       name: delobj
       doc: Delete an existing stateful object.
@@ -1505,6 +1886,8 @@ operations:
           value: 0xa16
           attributes:
             - name
+      dump:
+        reply:
     -
       name: delflowtable
       doc: Delete an existing flow table.
--=20
2.49.0



