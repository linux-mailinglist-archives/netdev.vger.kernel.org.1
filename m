Return-Path: <netdev+bounces-298498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VI74JRi6K2pADQQAu9opvQ
	(envelope-from <netdev+bounces-298498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C4F6776CC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:49:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=icc6qYlL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298498-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298498-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE5093018F76
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5F3E44E1;
	Fri, 12 Jun 2026 07:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F23E1717
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250496; cv=none; b=CPfOITmHf7VowoZAE4L7eEde969WgBPJp1AKhU6SUWMHD52xdK/qptQWS9EVJK7lp1qGmx2cqsuUPCxG80VF/38SjkqyhKP4VM54nnvsYtSSa2sOcaOjmi3ey82s1koHUDn4VjFbGjz07Et+VAFn12sbq6iaRc9IEkaIuADiYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250496; c=relaxed/simple;
	bh=oNLY3ukoRq+rC0b6PZQ6shuOVitA0M6vaKwbsunNmtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I13LsMbfPPJRtp3rbIQEe0ZaDNhQYKfAQY4G9gJBQQkSXngVGZ0UZVQIm5hLXk4agrGu5n/zKfbmDVoZEABJvXUSKob92g4tgjjCCFWpHnFIcvJpb595qEWpEymnkr1CHxSd3BAklQIzjCoeqUe44cZt6gCj/NZBEBmlsAdMio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=icc6qYlL; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EE9EF2083F;
	Fri, 12 Jun 2026 09:48:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2z5Kw1k30IiT; Fri, 12 Jun 2026 09:48:07 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C78C3206E9;
	Fri, 12 Jun 2026 09:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C78C3206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250487;
	bh=fgtygrf5qBXVWgxVfye9TxEnu5PZQRDTuPd9ViVbxxU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=icc6qYlL+jjnV2iVVzaqrTX8zVUJN3cUHmp1jljDtS1tAlP0Nb8umgsu+TVQ3SPM0
	 Kqr0MGOpJ8Ks/2mDeZ9YSQv+9zhVf2Y/Ce9NFtEpwFDMfXKFo/AO4ZFRaWjzy5w0la
	 kiMnFKJrvrjrYcAUn3ZPUQBnqKrHdq2IBnulPeS43Mg4JE7aDQmZ8AcDCs8jdR4Wkr
	 drUsKCbkF28Jl6u0nrgkbMyEB3TTsEVOjBs45H5GZ/O5dexpf6zAuP5N8/FO0B7WWg
	 EFCvqr9eI9XHR1dweM6x4BM4jH0+wZB/PSYD28JhXf+eXEDR2kYqO+iZghA5s9yNKM
	 WCf0xGnfKZTGA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:07 +0200
Received: (nullmailer pid 1768317 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 18/18] xfrm: add documentation for XFRM_MSG_MIGRATE_STATE
Date: Fri, 12 Jun 2026 09:46:34 +0200
Message-ID: <20260612074725.1760473-19-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298498-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97C4F6776CC

From: Antony Antony <antony.antony@secunet.com>

Add documentation for the new XFRM_MSG_MIGRATE_STATE netlink message,
which migrates a single SA identified by SPI and mark without involving
policies.

The document covers the motivation and design differences from the
existing XFRM_MSG_MIGRATE, the SA lookup mechanism, supported attributes
with their omit-to-inherit semantics, and usage examples.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 Documentation/networking/xfrm/index.rst       |   1 +
 .../networking/xfrm/xfrm_migrate_state.rst    | 274 ++++++++++++++++++
 2 files changed, 275 insertions(+)
 create mode 100644 Documentation/networking/xfrm/xfrm_migrate_state.rst

diff --git a/Documentation/networking/xfrm/index.rst b/Documentation/networking/xfrm/index.rst
index 7d866da836fe..90191848f8db 100644
--- a/Documentation/networking/xfrm/index.rst
+++ b/Documentation/networking/xfrm/index.rst
@@ -9,5 +9,6 @@ XFRM Framework
 
    xfrm_device
    xfrm_proc
+   xfrm_migrate_state
    xfrm_sync
    xfrm_sysctl
diff --git a/Documentation/networking/xfrm/xfrm_migrate_state.rst b/Documentation/networking/xfrm/xfrm_migrate_state.rst
new file mode 100644
index 000000000000..9d53cb22b007
--- /dev/null
+++ b/Documentation/networking/xfrm/xfrm_migrate_state.rst
@@ -0,0 +1,274 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+XFRM SA Migrate State
+=====================
+
+Overview
+========
+
+``XFRM_MSG_MIGRATE_STATE`` migrates a single SA, looked up using SPI and
+mark, without involving policies. Unlike ``XFRM_MSG_MIGRATE``, which couples
+SA and policy migration and allows migrating multiple SAs in one call, this
+interface identifies the SA unambiguously via SPI and supports changing
+the reqid, addresses, encapsulation, selector, and offload.
+
+Because IKE daemons can manage policies independently of
+the kernel, this interface allows precise per-SA migration without
+requiring policy involvement. Optional netlink attributes follow an
+omit-to-inherit model: omitting an attribute preserves the value from
+the old SA. The ``flags`` field controls two exceptions: hardware offload
+is inherited by default and can be suppressed with
+``XFRM_MIGRATE_STATE_CLEAR_OFFLOAD`` or overridden with ``XFRMA_OFFLOAD_DEV``;
+the new selector is taken from ``new_sel`` by default and can instead be
+derived from the new addresses with ``XFRM_MIGRATE_STATE_UPDATE_H2H_SEL``.
+
+SA Identification
+=================
+
+The struct is defined in ``include/uapi/linux/xfrm.h``. The SA is looked
+up using ``xfrm_state_lookup()`` with ``id.spi``,
+``id.daddr``, ``id.proto``, ``id.family``, and
+``old_mark.v & old_mark.m`` as the mark key::
+
+    struct xfrm_user_migrate_state {
+        struct xfrm_usersa_id  id;       /* spi, daddr, proto, family */
+        xfrm_address_t         new_daddr;
+        xfrm_address_t         new_saddr;
+        struct xfrm_mark       old_mark; /* SA lookup: key = v & m */
+        struct xfrm_selector   new_sel;  /* new selector (see Flags) */
+        __u32                  new_reqid;
+        __u32                  flags;    /* XFRM_MIGRATE_STATE_* */
+        __u16                  new_family;
+        __u16                  reserved;  /* must be zero */
+    };
+
+The ``reserved`` field must be set to zero; the kernel rejects any
+other value with ``-EINVAL``.
+
+Supported Attributes
+====================
+
+The following fields in ``xfrm_user_migrate_state`` are always explicit
+and are not inherited from the existing SA. Passing zero is not equivalent
+to "keep unchanged" — zero is used as-is:
+
+- ``new_daddr`` - new destination address
+- ``new_saddr`` - new source address
+- ``new_family`` - new address family
+- ``new_reqid`` - new reqid (0 = no reqid)
+- ``new_sel`` - new selector; used when ``XFRM_MIGRATE_STATE_UPDATE_H2H_SEL`` is
+  not set (see `Flags`_ below)
+- ``flags`` - bitmask of ``XFRM_MIGRATE_STATE_*`` flags (see `Flags`_ below)
+
+The following netlink attributes are also accepted. Omitting an attribute
+inherits the value from the existing SA (omit-to-inherit).
+
+.. list-table::
+   :widths: 30 70
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``XFRMA_MARK``
+     - Mark on the migrated SA (``struct xfrm_mark``). Absent inherits
+       ``old_mark``. To use no mark on the new SA, send ``XFRMA_MARK``
+       with ``{0, 0}``.
+   * - ``XFRMA_ENCAP``
+     - UDP encapsulation template; only ``UDP_ENCAP_ESPINUDP`` is supported.
+       Set ``encap_type=0`` to remove encap.
+   * - ``XFRMA_OFFLOAD_DEV``
+     - Hardware offload configuration (``struct xfrm_user_offload``). Absent
+       copies offload from the existing SA. When
+       ``XFRM_MIGRATE_STATE_CLEAR_OFFLOAD`` is set in ``flags``, the new SA has
+       no offload; this flag is mutually exclusive with ``XFRMA_OFFLOAD_DEV``
+       and sending both returns ``-EINVAL``.
+   * - ``XFRMA_SET_MARK``
+     - Output mark on the migrated SA; pair with ``XFRMA_SET_MARK_MASK``.
+       Send 0 to clear.
+   * - ``XFRMA_NAT_KEEPALIVE_INTERVAL``
+     - NAT keepalive interval in seconds. Requires encap. Send 0 to clear.
+       Automatically cleared when encap is removed; setting a non-zero
+       value without encap returns ``-EINVAL``.
+   * - ``XFRMA_MTIMER_THRESH``
+     - Mapping maxage threshold. Only valid on input SAs; setting on an
+       output SA returns ``-EINVAL``. Requires encap. Send 0 to clear.
+       Automatically cleared when encap is removed; setting a non-zero
+       value without encap returns ``-EINVAL``.
+
+The following SA properties are immutable and cannot be changed via
+``XFRM_MSG_MIGRATE_STATE``: algorithms (``XFRMA_ALG_*``), replay state,
+direction (``XFRMA_SA_DIR``), and security context (``XFRMA_SEC_CTX``).
+
+Flags
+=====
+
+The ``flags`` field in ``xfrm_user_migrate_state`` controls optional
+migration behaviour. Unknown flag bits are rejected with ``-EINVAL``; the
+extended ACK message identifies the unrecognised bits (e.g. ``"Unknown flags:
+0x4"``). Userspace can use ``XFRM_MIGRATE_STATE_KNOWN_FLAGS`` (defined in
+``<linux/xfrm.h>``) to validate flags before sending; note that this constant
+reflects the flags known to the header version userspace was compiled against,
+which may differ from what the running kernel accepts.
+
+.. list-table::
+   :widths: 40 60
+   :header-rows: 1
+
+   * - Flag
+     - Description
+   * - ``XFRM_MIGRATE_STATE_CLEAR_OFFLOAD``
+     - When set, the new SA has no hardware offload even when
+       ``XFRMA_OFFLOAD_DEV`` is absent. Without this flag, omitting
+       ``XFRMA_OFFLOAD_DEV`` copies the existing offload to the new SA.
+       Mutually exclusive with ``XFRMA_OFFLOAD_DEV``; sending both
+       returns ``-EINVAL``.
+   * - ``XFRM_MIGRATE_STATE_UPDATE_H2H_SEL``
+     - When set, the kernel validates that the existing SA selector is a
+       single-host entry matching the SA addresses (``prefixlen_s ==
+       prefixlen_d`` equal to 32 for IPv4 or 128 for IPv6, and addresses
+       matching ``id.daddr`` and ``props.saddr``). If the check passes,
+       the new selector is derived from ``new_daddr`` and ``new_saddr``
+       with the single-host mask for ``new_family``. A mismatch returns
+       ``-EINVAL``. When this flag is not set, ``new_sel`` is used as-is
+       for the migrated SA.
+
+Migration Steps
+===============
+
+Outgoing SA
+-----------
+
+To prevent cleartext traffic leaks, install a block policy before
+migrating:
+
+#. Install a block policy to drop traffic on the affected selector.
+#. Remove the old policy.
+#. Call ``XFRM_MSG_MIGRATE_STATE`` for each SA.
+#. Reinstall the policies.
+#. Remove the block policy.
+
+If AES-GCM is in use, the block policy also prevents IV reuse during
+the migration window. For other AEADs this step is not required for
+IV safety, but skipping it allows a brief cleartext window.
+
+Incoming SA
+-----------
+
+No block policy is needed. ``XFRM_MSG_MIGRATE_STATE`` atomically
+transfers the sequence number and replay window from the old SA to
+the new SA, so the new SA continues replay protection without a gap.
+Call ``XFRM_MSG_MIGRATE_STATE`` for each SA directly.
+
+When accepting incoming traffic, be liberal during the migration
+window: packets sent by the remote peer before it completed its own
+migration may arrive out of order or slightly late. Dropping them
+unnecessarily causes packet loss. A generous replay window reduces
+the impact of reordering during migration.
+
+Block Policy and IV Safety
+--------------------------
+
+AES-GCM IV uniqueness is critical: reusing a (key, IV) pair allows
+an attacker to recover the authentication subkey and forge
+authentication tags, breaking both confidentiality and integrity.
+This concern applies to outgoing SAs only — the remote peer controls
+IV generation on incoming traffic.
+
+``XFRM_MSG_MIGRATE_STATE`` atomically copies the sequence number and
+replay window from the old SA to the new SA and deletes the old SA.
+The block policy serves two purposes: it prevents cleartext traffic
+leaks during the migration window, and for AES-GCM it prevents IV
+reuse by ensuring no outgoing packets are sent under the same key.
+The atomic copy of the sequence number and replay window complements
+this — together they eliminate both risks during migration.
+The atomic copy also serves incoming SAs, ensuring replay protection
+continues without a gap across the migration.
+
+Feature Detection
+=================
+
+Userspace can probe for kernel support by sending a minimal
+``XFRM_MSG_MIGRATE_STATE`` message with a non-zero non-existent SPI:
+
+- ``-EINVAL``: kernel predates ``XFRM_MSG_MIGRATE_STATE``; message type
+  is out of range
+- ``-ENOPROTOOPT``: message type is known but ``CONFIG_XFRM_MIGRATE``
+  is not enabled
+- ``-ESRCH``: supported (SPI not found)
+
+Userspace Notification on Success
+=================================
+
+On successful migration the kernel multicasts an
+``XFRM_MSG_MIGRATE_STATE`` message to the ``XFRMNLGRP_MIGRATE`` group.
+The fixed header is ``struct xfrm_user_migrate_state`` copied from the
+request, followed by the same set of netlink attributes that are
+accepted as input, with the differences noted below.
+
+Differences from the request
+-----------------------------
+
+.. list-table::
+   :widths: 25 75
+   :header-rows: 1
+
+   * - Field / Attribute
+     - Difference
+   * - ``new_sel``
+     - Contains the actual selector of the newly installed SA, not the
+       ``new_sel`` from the request. When
+       ``XFRM_MIGRATE_STATE_UPDATE_H2H_SEL`` is set the kernel derives the
+       selector from ``new_daddr`` / ``new_saddr``; the caller's
+       ``new_sel`` field is ignored in that case. The notification
+       always carries the real selector of the new SA.
+   * - ``XFRMA_SA_DIR``
+     - Present in the notification (set from the direction of the new
+       SA) but **not accepted as input** — direction is immutable.
+   * - ``flags``
+     - Echoed back as-is. ``XFRM_MIGRATE_STATE_CLEAR_OFFLOAD`` and
+       ``XFRM_MIGRATE_STATE_UPDATE_H2H_SEL`` describe the request that was
+       made, not a property of the resulting SA.
+
+Attributes in the notification
+-------------------------------
+
+.. list-table::
+   :widths: 30 70
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``XFRMA_ENCAP``
+     - UDP encapsulation template, if configured on the new SA.
+   * - ``XFRMA_OFFLOAD_DEV``
+     - Hardware offload configuration, if active on the new SA.
+   * - ``XFRMA_MARK``
+     - Mark on the new SA, if set.
+   * - ``XFRMA_SET_MARK``
+     - Output mark on the new SA, if set.
+   * - ``XFRMA_SET_MARK_MASK``
+     - Output mark mask, present together with ``XFRMA_SET_MARK``.
+   * - ``XFRMA_MTIMER_THRESH``
+     - Mapping maxage threshold, if non-zero.
+   * - ``XFRMA_NAT_KEEPALIVE_INTERVAL``
+     - NAT keepalive interval, if non-zero.
+   * - ``XFRMA_SA_DIR``
+     - Direction of the new SA.
+
+Error Handling
+==============
+
+If the target SA tuple (new daddr, SPI, proto, new family) is already
+occupied, the operation returns ``-EEXIST`` before the migration begins.
+The old SA remains intact and the operation is safe to retry after
+resolving the conflict.
+
+If the target SA is deleted before the migration completes, the operation
+returns ``-ESRCH``. No new SA is installed. Userspace should verify the
+current SA state before retrying.
+
+If the multicast notification (``XFRMNLGRP_MIGRATE``) fails to send,
+the migration itself has already completed successfully and the new SA
+is installed. The operation returns success, 0, with an extack warning,
+but listeners will not receive the migration event.
-- 
2.43.0


