Return-Path: <netdev+bounces-227809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EF4BB7CF5
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 19:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F514802F6
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980F2DAFBE;
	Fri,  3 Oct 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AVsnKJe4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45D15853B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514160; cv=none; b=peOAHnroVwayGniwcPm/oCBPbNBkhyk54zk/6VKguSagj8Bux1ZOZUdzcz+/Do+La8olYxwTArSmyLIesC217z2+IBvKN5Nqsy1mzGP+bLhOVVOaqKqkhdT209T5GqcaN4Y8vE//VtuUZ0tuk3HmfGXkYLfiZyEVsST3g9nNyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514160; c=relaxed/simple;
	bh=RFnjkpp9bJl0vgUyh/kbb10f7eWauJpyFG/0eGSaze0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PlgGeZ+/wbu1JQLs1s0ze7aq9Qr8rUzyc9By6A/fT7Kxpiah83txO0NXEJBfZCKB5XAnLtUiPgheO2zQxCeOexxZcjtG8RIJXhwO6JEyGpTWmSL31TnW3r0CwOvr1wJtvri/JY+gkmUc7G2GPRIjI3MeZMt+xZwXS17Sky5QOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=AVsnKJe4; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759514147; x=1759773347;
	bh=ItJJ9f7OZiGfTZNqP16g1lg5kgT7k4W9z+UX6tzUMR4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AVsnKJe4sN9qsqWf6i6JhBVTmYUKcRneIAYIpy1PbZkHJ2SPu+2b2lkadMmLQR5rG
	 ZCH4Xay0TX14pth6D437K1cJhjf5ge3cA3mNixqSqFLC6jr8Znn8Vy82SL/PMePwno
	 SqMJ27PowxeuwX9ojDIsrQx/CX2srut7qC0V54vCHeWoqbcueRnF4920c/sy6TA9Ko
	 zJGKVZPLUdpoPdDGUkbacQsfDKkYmmvthONDevyd2ud0PDhWe8QDZZHzsbyvUWtbgI
	 7zI0Q25IRm/TTg64070sxc4cN/vJeG2piJtle08isi6CqnwzVujpSYGBBhUA6Blhm0
	 tbDxmz9bzdQaQ==
Date: Fri, 03 Oct 2025 17:55:34 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH v2] doc/netlink: Expand nftables specificaion
Message-ID: <20251003175510.1074239-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 585d7b4fd675b231e77d1f59fccf139cf1dfbc50
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
- Allows ynl_gen_rst.py script to handle empty request/reply attribute.

Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/specs/nftables.yaml | 446 ++++++++++++++++++++--
 tools/net/ynl/pyynl/ynl_gen_rst.py        |   2 +
 2 files changed, 407 insertions(+), 41 deletions(-)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netl=
ink/specs/nftables.yaml
index 2ee10d92d..2717084a9 100644
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
@@ -1145,6 +1453,27 @@ sub-messages:
 operations:
   enum-model: directional
   list:
+    -
+      # Defined as nfnl_compat_subsys in net/netfilter/nft_compat.c
+      name: getcompat
+      attribute-set: compat-attrs
+      fixed-header: nfgenmsg
+      doc: Get / dump nft_compat info
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
@@ -1187,12 +1516,17 @@ operations:
       do:
         request:
           value: 0xa01
-          attributes:
-            - name
+          # TODO: attributes
         reply:
           value: 0xa00
+          # TODO: attributes
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
@@ -1239,6 +1573,18 @@ operations:
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
@@ -1270,7 +1616,10 @@ operations:
         request:
           value: 0xa06
           attributes:
-            - name
+            - table
+            - chain
+            - expressions
+            - compat
     -
       name: getrule
       doc: Get / dump rules.
@@ -1279,12 +1628,22 @@ operations:
       do:
         request:
           value: 0xa07
-          attributes:
-            - name
+          # TODO: attributes
         reply:
           value: 0xa06
+          # TODO: attributes
+      dump:
+        request:
           attributes:
-            - name
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
@@ -1293,12 +1652,12 @@ operations:
       do:
         request:
           value: 0xa19
-          attributes:
-            - name
+          # TODO: attributes
         reply:
           value: 0xa06
-          attributes:
-            - name
+          # TODO: attributes
+      dump:
+        reply:
     -
       name: delrule
       doc: Delete an existing rule.
@@ -1307,8 +1666,7 @@ operations:
       do:
         request:
           value: 0xa08
-          attributes:
-            - name
+          # TODO: attributes
     -
       name: destroyrule
       doc: |
@@ -1318,8 +1676,7 @@ operations:
       do:
         request:
           value: 0xa1c
-          attributes:
-            - name
+          # TODO: attributes
     -
       name: newset
       doc: Create a new set.
@@ -1328,8 +1685,7 @@ operations:
       do:
         request:
           value: 0xa09
-          attributes:
-            - name
+          # TODO: attributes
     -
       name: getset
       doc: Get / dump sets.
@@ -1338,12 +1694,16 @@ operations:
       do:
         request:
           value: 0xa0a
-          attributes:
-            - name
+          # TODO: attributes
         reply:
           value: 0xa09
+          # TODO: attributes
+      dump:
+        request:
           attributes:
-            - name
+            - table
+        reply:
+          # TODO: attributes
     -
       name: delset
       doc: Delete an existing set.
@@ -1373,8 +1733,7 @@ operations:
       do:
         request:
           value: 0xa0c
-          attributes:
-            - name
+          # TODO: attributes
     -
       name: getsetelem
       doc: Get / dump set elements.
@@ -1383,12 +1742,12 @@ operations:
       do:
         request:
           value: 0xa0d
-          attributes:
-            - name
+          # TODO: attributes
         reply:
           value: 0xa0c
-          attributes:
-            - name
+          # TODO: attributes
+      dump:
+        reply:
     -
       name: getsetelem-reset
       doc: Get / dump set elements and reset stateful expressions.
@@ -1397,12 +1756,12 @@ operations:
       do:
         request:
           value: 0xa21
-          attributes:
-            - name
+          # TODO: attributes
         reply:
           value: 0xa0c
-          attributes:
-            - name
+          # TODO: attributes
+      dump:
+        reply:
     -
       name: delsetelem
       doc: Delete an existing set element.
@@ -1411,8 +1770,7 @@ operations:
       do:
         request:
           value: 0xa0e
-          attributes:
-            - name
+          # TODO: attributes
     -
       name: destroysetelem
       doc: Delete an existing set element with destroy semantics.
@@ -1421,8 +1779,7 @@ operations:
       do:
         request:
           value: 0xa1e
-          attributes:
-            - name
+          # TODO: attributes
     -
       name: getgen
       doc: Get / dump rule-set generation.
@@ -1431,12 +1788,15 @@ operations:
       do:
         request:
           value: 0xa10
-          attributes:
-            - name
+          # TODO: attributes
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
@@ -1461,6 +1821,8 @@ operations:
           value: 0xa12
           attributes:
             - name
+      dump:
+        reply:
     -
       name: delobj
       doc: Delete an existing stateful object.
@@ -1505,6 +1867,8 @@ operations:
           value: 0xa16
           attributes:
             - name
+      dump:
+        reply:
     -
       name: delflowtable
       doc: Delete an existing flow table.
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_g=
en_rst.py
index 0cb6348e2..35325f37e 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -157,6 +157,8 @@ def parse_do(do_dict: Dict[str, Any], level: int =3D 0)=
 -> str:
     for key in do_dict.keys():
         lines.append(rst_paragraph(bold(key), level + 1))
         if key in ['request', 'reply']:
+            if do_dict[key] is None:
+                continue
--=20
2.49.0



