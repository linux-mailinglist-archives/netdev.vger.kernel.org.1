Return-Path: <netdev+bounces-240109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE6C70A26
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4077735905E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04E36998B;
	Wed, 19 Nov 2025 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fMOSn8y9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E736A03B
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576185; cv=none; b=HhhDp4ffuFocqmDnXMoOceuX1n1TboZGUh9LMaH9Ul6gFFQO/nPQbdLf+T5RSPT7KRxvdJ/tGsw86KxtPvlup25zwHeNuYOGlyxYOLVLsq2RAJJIRAAAucO45fSM+z6vHD7rAJM1s4IfTElLkAl/Dy8FOthsr0nDB5FduzkRsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576185; c=relaxed/simple;
	bh=dC6Un7Xeg0zwe9IZNLAZElEST3GtPJZ++KbAoS2g5+A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rX8Y/Ui4He+h/kheeVvDnFj4RmgoBcn9zRpm5kI8YPStAaT3lq+upmWcZIdq1R94XI+jpfzDZntOJsvha+EXvmKVj7Hv8rIe0J3aab+7s23WQw8O9Sv9axkXfYBgOLZ3XlaWs5erNndk2XW1/gxYGbtWYHVshapNi2fvdEs+ets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=fMOSn8y9; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1763576165; x=1763835365;
	bh=8CK3lRNVujnr6R05doEEiKY/CYmZQfEVi7URoRA52xU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fMOSn8y9KmNbyOWjUHMmcwIkEqvx3rfDUgnVHKGhMJpkhsATC4PgKGS1wkwknhIK/
	 q4/UR9ZyKGbxyoQFWX1Wh/gohEx81qvs+7QWMttt677mVSPhKzrxvPZRCxZtwOOyb0
	 uyHBbdmqlwwvf51fUyh3dwzv+GzAys0PAzMTY5QrBQZrBaQTlWUQ85F8kPCvsBIQ3s
	 tevRoek6GleadhBiFMZ/k7bpMadwyrsQW2XhnEWvOugkzXMCUJ7y77597JDjHYaEvZ
	 P5sVglP7deW3UJj15rePp4ubuyAXZCHwyE9AzVepjEjBWRA5Flu3qj7vPRPmwMtQp5
	 HSXqBY8UQmygw==
Date: Wed, 19 Nov 2025 18:16:00 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH v4 2/2] doc/netlink: Expand nftables specification
Message-ID: <2a8b6847cbb9c4c09a2ddd6663294b8238b044ad.1763574466.git.one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: ff49d579500df6d41b7f78ccb77838aca41ae18f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Getting out some changes I've accumulated while making nftables work
with Rust netlink-bindings. Hopefully, this will be useful upstream.

New enums/flags:
- payload-base
- range-ops
- registers
- numgen-types
- log-level
- log-flags

Added missing enumerations:
- bitwise-ops

New attribute sets:
- log-attrs
- numgen-attrs
- range-attrs
- compat-target-attrs
- compat-match-attrs
- compat-attrs

Added missing attributes:
- table-attrs (pad, owner)
- set-attrs (type, count)

Added missing checks:
- range-attrs
- expr-bitwise-attrs
- compat-target-attrs
- compat-match-attrs
- compat-attrs

Annotated doc comment or associated enum:
- bitwise-ops
- batch-attrs
- verdict-attrs
- expr-payload-attrs

Fixed byte order:
- nft-counter-attrs
- expr-counter-attrs
- rule-compat-attrs

New sub-messsages:
- match
- range
- numgen
- log

New operations:
- getcompat

Filled out operation attributes:
- newtable
- gettable
- deltable
- destroytable
- newchain
- getchain
- delchain
- destroychain
- newrule
- getrule
- getrule-reset
- delrule
- destroyrule
- newset
- getset
- delset
- destroyset
- newsetelem
- getsetelem
- getsetelem-reset
- delsetelem
- destroysetelem
- getgen
- newobj
- getobj
- delobj
- destroyobj
- newflowtable
- getflowtable
- delflowtable
- destroyflowtable

Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/specs/nftables.yaml | 658 ++++++++++++++++++++--
 1 file changed, 609 insertions(+), 49 deletions(-)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netl=
ink/specs/nftables.yaml
index cce88819b..da786be5b 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -4,7 +4,7 @@ name: nftables
 protocol: netlink-raw
 protonum: 12
=20
-doc: >-
+doc: |
   Netfilter nftables configuration over netlink.
=20
 definitions:
@@ -66,9 +66,22 @@ definitions:
     name: bitwise-ops
     type: enum
     entries:
-      - bool
+      -
+        name: mask-xor  # aka bool (old name)
+        doc: |
+          mask-and-xor operation used to implement NOT, AND, OR and XOR
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
@@ -225,19 +238,221 @@ definitions:
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
+      - reg-verdict
+      - reg-1
+      - reg-2
+      - reg-3
+      - reg-4
+      -
+        name: reg32-00
+        value: 8
+      - reg32-01
+      - reg32-02
+      - reg32-03
+      - reg32-04
+      - reg32-05
+      - reg32-06
+      - reg32-07
+      - reg32-08
+      - reg32-09
+      - reg32-10
+      - reg32-11
+      - reg32-12
+      - reg32-13
+      - reg32-14
+      - reg32-15
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
+      -
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
       -
         name: genid
+        doc: generation ID for this changeset
         type: u32
         byte-order: big-endian
   -
@@ -264,10 +479,18 @@ attribute-sets:
         type: u64
         byte-order: big-endian
         doc: numeric handle of the table
+      -
+        name: pad
+        type: pad
       -
         name: userdata
         type: binary
         doc: user data
+      -
+        name: owner
+        type: u32
+        byte-order: big-endian
+        doc: owner of this table through netlink portID
   -
     name: chain-attrs
     attributes:
@@ -371,9 +594,11 @@ attribute-sets:
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
@@ -443,15 +668,18 @@ attribute-sets:
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
@@ -540,6 +768,15 @@ attribute-sets:
         type: nest
         nested-attributes: set-list-attrs
         doc: list of expressions
+      -
+        name: type
+        type: string
+        doc: set backend type
+      -
+        name: count
+        type: u32
+        byte-order: big-endian
+        doc: number of set elements
   -
     name: set-desc-attrs
     attributes:
@@ -793,6 +1030,8 @@ attribute-sets:
         type: u32
         byte-order: big-endian
         enum: bitwise-ops
+        checks:
+          max: 255
       -
         name: data
         type: nest
@@ -814,6 +1053,7 @@ attribute-sets:
         type: nest
         nested-attributes: data-attrs
   -
+    # Defined as nft_data_attributes in include/linux/netfilter/nf_tables.=
h
     name: data-attrs
     attributes:
       -
@@ -829,25 +1069,31 @@ attribute-sets:
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
+        byte-order: big-endian
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
@@ -915,7 +1161,7 @@ attribute-sets:
         type: string
         doc: Name of set to use
       -
-        name: set id
+        name: set-id
         type: u32
         byte-order: big-endian
         doc: ID of set to use
@@ -982,38 +1228,51 @@ attribute-sets:
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
@@ -1079,6 +1338,59 @@ attribute-sets:
         type: u32
         byte-order: big-endian
         doc: id of object map
+  -
+    # Defined in include/uapi/linux/netfilter/nf_tables_compat.h
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
+      -
+        name: info
+        type: binary
+  -
+    # Defined in include/uapi/linux/netfilter/nf_tables_compat.h
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
@@ -1132,6 +1444,21 @@ sub-messages:
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
+        # There're more sub-messages to go:
+        #   grep -A10 nft_expr_type
+        # and look for .name\s*=3D\s*"..."
   -
     name: obj-data
     formats:
@@ -1145,6 +1472,31 @@ sub-messages:
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
+          attributes:
+            - name
+            - rev
+            - type
     -
       name: batch-begin
       doc: Start a batch of operations
@@ -1178,7 +1530,10 @@ operations:
         request:
           value: 0xa00
           attributes:
+            # Mentioned in nf_tables_newtable()
             - name
+            - flags
+            - userdata
     -
       name: gettable
       doc: Get / dump tables.
@@ -1188,11 +1543,21 @@ operations:
         request:
           value: 0xa01
           attributes:
+            # Mentioned in nf_tables_gettable()
             - name
         reply:
           value: 0xa00
-          attributes:
+          attributes: &get-table
+            # Mentioned in nf_tables_fill_table_info()
             - name
+            - use
+            - handle
+            - flags
+            - owner
+            - userdata
+      dump:
+        reply:
+          attributes: *get-table
     -
       name: deltable
       doc: Delete an existing table.
@@ -1201,8 +1566,10 @@ operations:
       do:
         request:
           value: 0xa02
-          attributes:
+          attributes: &del-table
+            # Mentioned in nf_tables_deltable()
             - name
+            - handle
     -
       name: destroytable
       doc: |
@@ -1213,8 +1580,7 @@ operations:
       do:
         request:
           value: 0xa1a
-          attributes:
-            - name
+          attributes: *del-table
     -
       name: newchain
       doc: Create a new chain.
@@ -1224,7 +1590,23 @@ operations:
         request:
           value: 0xa03
           attributes:
+            # Mentioned in nf_tables_newchain()
+            - table
+            - handle
+            - policy
+            - flags
+            # Mentioned in nf_tables_updchain()
+            - hook
+            - name
+            - counters
+            - policy
+            # Mentioned in nf_tables_addchain()
+            - hook
             - name
+            - counters
+            - userdata
+            # Mentioned in nft_chain_parse_hook()
+            - type
     -
       name: getchain
       doc: Get / dump chains.
@@ -1234,11 +1616,27 @@ operations:
         request:
           value: 0xa04
           attributes:
+            # Mentioned in nf_tables_getchain()
+            - table
             - name
         reply:
           value: 0xa03
-          attributes:
+          attributes: &get-chain
+            # Mentioned in nf_tables_fill_chain_info()
+            - table
             - name
+            - handle
+            - hook
+            - policy
+            - type
+            - flags
+            - counters
+            - id
+            - use
+            - userdata
+      dump:
+        reply:
+          attributes: *get-chain
     -
       name: delchain
       doc: Delete an existing chain.
@@ -1247,8 +1645,12 @@ operations:
       do:
         request:
           value: 0xa05
-          attributes:
+          attributes: &del-chain
+            # Mentioned in nf_tables_delchain()
+            - table
+            - handle
             - name
+            - hook
     -
       name: destroychain
       doc: |
@@ -1259,8 +1661,7 @@ operations:
       do:
         request:
           value: 0xa1b
-          attributes:
-            - name
+          attributes: *del-chain
     -
       name: newrule
       doc: Create a new rule.
@@ -1270,7 +1671,16 @@ operations:
         request:
           value: 0xa06
           attributes:
-            - name
+            # Mentioned in nf_tables_newrule()
+            - table
+            - chain
+            - chain-id
+            - handle
+            - position
+            - position-id
+            - expressions
+            - userdata
+            - compat
     -
       name: getrule
       doc: Get / dump rules.
@@ -1279,12 +1689,30 @@ operations:
       do:
         request:
           value: 0xa07
-          attributes:
-            - name
+          attributes: &get-rule-request
+            # Mentioned in nf_tables_getrule_single()
+            - table
+            - chain
+            - handle
         reply:
           value: 0xa06
+          attributes: &get-rule
+            # Mentioned in nf_tables_fill_rule_info()
+            - table
+            - chain
+            - handle
+            - position
+            - expressions
+            - userdata
+      dump:
+        request:
           attributes:
-            - name
+            # Mentioned in nf_tables_dump_rules_start()
+            - table
+            - chain
+        reply:
+          attributes: *get-rule
+
     -
       name: getrule-reset
       doc: Get / dump rules and reset stateful expressions.
@@ -1293,12 +1721,15 @@ operations:
       do:
         request:
           value: 0xa19
-          attributes:
-            - name
+          attributes: *get-rule-request
         reply:
           value: 0xa06
-          attributes:
-            - name
+          attributes: *get-rule
+      dump:
+        request:
+          attributes: *get-rule-request
+        reply:
+          attributes: *get-rule
     -
       name: delrule
       doc: Delete an existing rule.
@@ -1307,8 +1738,11 @@ operations:
       do:
         request:
           value: 0xa08
-          attributes:
-            - name
+          attributes: &del-rule
+            - table
+            - chain
+            - handle
+            - id
     -
       name: destroyrule
       doc: |
@@ -1318,8 +1752,7 @@ operations:
       do:
         request:
           value: 0xa1c
-          attributes:
-            - name
+          attributes: *del-rule
     -
       name: newset
       doc: Create a new set.
@@ -1329,7 +1762,24 @@ operations:
         request:
           value: 0xa09
           attributes:
+            # Mentioned in nf_tables_newset()
+            - table
             - name
+            - key-len
+            - id
+            - key-type
+            - key-len
+            - flags
+            - data-type
+            - data-len
+            - obj-type
+            - timeout
+            - gc-interval
+            - policy
+            - desc
+            - table
+            - name
+            - userdata
     -
       name: getset
       doc: Get / dump sets.
@@ -1339,11 +1789,35 @@ operations:
         request:
           value: 0xa0a
           attributes:
+            # Mentioned in nf_tables_getset()
+            - table
             - name
         reply:
           value: 0xa09
-          attributes:
+          attributes: &get-set
+            # Mentioned in nf_tables_fill_set()
+            - table
             - name
+            - handle
+            - flags
+            - key-len
+            - key-type
+            - data-type
+            - data-len
+            - obj-type
+            - gc-interval
+            - policy
+            - userdata
+            - desc
+            - expr
+            - expressions
+      dump:
+        request:
+          attributes:
+            # Mentioned in nf_tables_getset()
+            - table
+        reply:
+          attributes: *get-set
     -
       name: delset
       doc: Delete an existing set.
@@ -1352,7 +1826,10 @@ operations:
       do:
         request:
           value: 0xa0b
-          attributes:
+          attributes: &del-set
+            # Mentioned in nf_tables_delset()
+            - table
+            - handle
             - name
     -
       name: destroyset
@@ -1363,8 +1840,7 @@ operations:
       do:
         request:
           value: 0xa1d
-          attributes:
-            - name
+          attributes: *del-set
     -
       name: newsetelem
       doc: Create a new set element.
@@ -1374,7 +1850,11 @@ operations:
         request:
           value: 0xa0c
           attributes:
-            - name
+            # Mentioned in nf_tables_newsetelem()
+            - table
+            - set
+            - set-id
+            - elements
     -
       name: getsetelem
       doc: Get / dump set elements.
@@ -1384,11 +1864,27 @@ operations:
         request:
           value: 0xa0d
           attributes:
-            - name
+            # Mentioned in nf_tables_getsetelem()
+            - table
+            - set
+            - elements
         reply:
           value: 0xa0c
           attributes:
-            - name
+            # Mentioned in nf_tables_fill_setelem_info()
+            - elements
+      dump:
+        request:
+          attributes: &dump-set-request
+            # Mentioned in nft_set_dump_ctx_init()
+            - table
+            - set
+        reply:
+          attributes: &dump-set
+            # Mentioned in nf_tables_dump_set()
+            - table
+            - set
+            - elements
     -
       name: getsetelem-reset
       doc: Get / dump set elements and reset stateful expressions.
@@ -1398,11 +1894,20 @@ operations:
         request:
           value: 0xa21
           attributes:
-            - name
+            # Mentioned in nf_tables_getsetelem_reset()
+            - elements
         reply:
           value: 0xa0c
           attributes:
-            - name
+            # Mentioned in nf_tables_dumpreset_set()
+            - table
+            - set
+            - elements
+      dump:
+        request:
+          attributes: *dump-set-request
+        reply:
+          attributes: *dump-set
     -
       name: delsetelem
       doc: Delete an existing set element.
@@ -1411,8 +1916,11 @@ operations:
       do:
         request:
           value: 0xa0e
-          attributes:
-            - name
+          attributes: &del-setelem
+            # Mentioned in nf_tables_delsetelem()
+            - table
+            - set
+            - elements
     -
       name: destroysetelem
       doc: Delete an existing set element with destroy semantics.
@@ -1421,8 +1929,7 @@ operations:
       do:
         request:
           value: 0xa1e
-          attributes:
-            - name
+          attributes: *del-setelem
     -
       name: getgen
       doc: Get / dump rule-set generation.
@@ -1431,12 +1938,16 @@ operations:
       do:
         request:
           value: 0xa10
-          attributes:
-            - name
         reply:
           value: 0xa0f
-          attributes:
-            - name
+          attributes: &get-gen
+            # Mentioned in nf_tables_fill_gen_info()
+            - id
+            - proc-pid
+            - proc-name
+      dump:
+        reply:
+          attributes: *get-gen
     -
       name: newobj
       doc: Create a new stateful object.
@@ -1446,7 +1957,12 @@ operations:
         request:
           value: 0xa12
           attributes:
+            # Mentioned in nf_tables_newobj()
+            - type
             - name
+            - data
+            - table
+            - userdata
     -
       name: getobj
       doc: Get / dump stateful objects.
@@ -1456,11 +1972,29 @@ operations:
         request:
           value: 0xa13
           attributes:
+            # Mentioned in nf_tables_getobj_single()
             - name
+            - type
+            - table
         reply:
           value: 0xa12
-          attributes:
+          attributes: &obj-info
+            # Mentioned in nf_tables_fill_obj_info()
+            - table
             - name
+            - type
+            - handle
+            - use
+            - data
+            - userdata
+      dump:
+        request:
+          attributes:
+            # Mentioned in nf_tables_dump_obj_start()
+            - table
+            - type
+        reply:
+          attributes: *obj-info
     -
       name: delobj
       doc: Delete an existing stateful object.
@@ -1470,7 +2004,11 @@ operations:
         request:
           value: 0xa14
           attributes:
+            # Mentioned in nf_tables_delobj()
+            - table
             - name
+            - type
+            - handle
     -
       name: destroyobj
       doc: Delete an existing stateful object with destroy semantics.
@@ -1480,7 +2018,11 @@ operations:
         request:
           value: 0xa1f
           attributes:
+            # Mentioned in nf_tables_delobj()
+            - table
             - name
+            - type
+            - handle
     -
       name: newflowtable
       doc: Create a new flow table.
@@ -1490,7 +2032,11 @@ operations:
         request:
           value: 0xa16
           attributes:
+            # Mentioned in nf_tables_newflowtable()
+            - table
             - name
+            - hook
+            - flags
     -
       name: getflowtable
       doc: Get / dump flow tables.
@@ -1500,11 +2046,22 @@ operations:
         request:
           value: 0xa17
           attributes:
+            # Mentioned in nf_tables_getflowtable()
             - name
+            - table
         reply:
           value: 0xa16
-          attributes:
+          attributes: &flowtable-info
+            # Mentioned in nf_tables_fill_flowtable_info()
+            - table
             - name
+            - handle
+            - use
+            - flags
+            - hook
+      dump:
+        reply:
+          attributes: *flowtable-info
     -
       name: delflowtable
       doc: Delete an existing flow table.
@@ -1513,8 +2070,12 @@ operations:
       do:
         request:
           value: 0xa18
-          attributes:
+          attributes: &del-flowtable
+            # Mentioned in nf_tables_delflowtable()
+            - table
             - name
+            - handle
+            - hook
     -
       name: destroyflowtable
       doc: Delete an existing flow table with destroy semantics.
@@ -1523,8 +2084,7 @@ operations:
       do:
         request:
           value: 0xa20
-          attributes:
-            - name
+          attributes: *del-flowtable
=20
 mcast-groups:
   list:
--=20
2.50.1



