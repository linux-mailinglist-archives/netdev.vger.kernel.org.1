Return-Path: <netdev+bounces-278664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGbTCB4n32nmPQAAu9opvQ
	(envelope-from <netdev+bounces-278664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:50:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BEC400971
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A3AC304620E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363693845A6;
	Wed, 15 Apr 2026 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnU0bgcd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF5382284
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232174; cv=none; b=eDoTGwwyifn9G9jHatNd6qYfZyFxQ/0d+71sET5iV4ZUL7B8RpcPDwvnQEP0GkakSZ6DBr6p/mLkIGc742sKcqo95Q2ih+NgkYruyAKfcwK+TBtCoZNT24DTiRDJATUuzXTeKs7xnQxIT7xgiXxBVIj8dgFTgTNo4r2oKQ96QkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232174; c=relaxed/simple;
	bh=xOsgiZoWg1slPORAJP9F+0cKRf7cxtIlMg2hWoa6V78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCiLF65OH1HH7yVrNLOZkxBc+B178Bi3xeim0cz5SY+XduEaOotJhlpQpzbIQvmGUvOc5u/5j1JBePMqCBmaDwbuZ0sEC8iyo5kYpLKEcCn2BR9Dny08e7qIEA32IJXYYDWc8BDPvtLjMsUo0PtJHqm7oU8cFUlWuVS/yuq/qq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnU0bgcd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232171; x=1807768171;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xOsgiZoWg1slPORAJP9F+0cKRf7cxtIlMg2hWoa6V78=;
  b=NnU0bgcddPHDfHmfvekclHVM6hTeuSr06sUTvKZkzMdty3ruA2dk0X3u
   1hqkmEu2/F9wkaiuXNf0TMyQJOa+R0DnnHQOuzDR2jh9Gl8a27rfw68jZ
   j/DNxwVYxoJEhr83AjwrDkr2nFj//2BAVoJMEtJzicO0Te5ObDMVtGVRh
   64MGMyKqzWJqKUXFx5kIEkmEoYTNmXOttBtasrI3D4kUJNpDY4WANY3QJ
   yyeRhShRJ4QQFkKUE9Xv+4AkxznvGhX19kKtEeh98BMecclxXrJDvFmIm
   MBWh8EVN8gq7uZDYNAJcakCvKwekjqZ0XCvnIuzcAu0LFWEzbkGzpfCYd
   w==;
X-CSE-ConnectionGUID: 0GF42zg2RfGzcR7BCAPIZw==
X-CSE-MsgGUID: koe4v8iVS62KrJsaavoVdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105979"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105979"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
X-CSE-ConnectionGUID: htlpx9pLTQW3pQcStoOSNg==
X-CSE-MsgGUID: kP4cd206TYara0Wbecoi4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714825"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:48:06 -0700
Subject: [PATCH net 11/13] iavf: fix wrong VLAN mask for legacy Rx
 descriptors L2TAG2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-11-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=rG0unpfrFaCq8s2EY9EFqMvh6tkLJJH7j6pBClc21ok=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ao9Va9P+lSpmM97dcV9AceHvyblFp3hrf3VoijG11
 hXZc5d1lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMJG+SYwM3zvYE9bYPBWd80Qw
 65YZz0+vBC6pva7bj5suWrc1c3FBByPD5ZQfdesniOVE7gzO0PSap7k0Kmvr3/tRhvsL1vKf5tJ
 jBAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278664-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,mpg.de:email]
X-Rspamd-Queue-Id: B2BEC400971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Petr Oros <poros@redhat.com>

The IAVF_RXD_LEGACY_L2TAG2_M mask was incorrectly defined as
GENMASK_ULL(63, 32), extracting 32 bits from qw2 instead of the
16-bit VLAN tag. In the legacy Rx descriptor layout, the 2nd L2TAG2
(VLAN tag) occupies bits 63:48 of qw2, not 63:32.

The oversized mask causes FIELD_GET to return a 32-bit value where the
actual VLAN tag sits in bits 31:16. When this value is passed to
iavf_receive_skb() as a u16 parameter, it gets truncated to the lower
16 bits (which contain the 1st L2TAG2, typically zero). As a result,
__vlan_hwaccel_put_tag() is never called and software VLAN interfaces
on VFs receive no traffic.

This affects VFs behind ice PF (VIRTCHNL VLAN v2) when the PF
advertises VLAN stripping into L2TAG2_2 and legacy descriptors are
used.

The flex descriptor path already uses the correct mask
(IAVF_RXD_FLEX_L2TAG2_2_M = GENMASK_ULL(63, 48)).

Reproducer:
 1. Create 2 VFs on ice PF (echo 2 > sriov_numvfs)
 2. Disable spoofchk on both VFs
 3. Move each VF into a separate network namespace
 4. On each VF: create VLAN interface (e.g. vlan 198), assign IP,
    bring up
 5. Set rx-vlan-offload OFF on both VFs
 6. Ping between VLAN interfaces -> expect PASS
    (VLAN tag stays in packet data, kernel matches in-band)
 7. Set rx-vlan-offload ON on both VFs
 8. Ping between VLAN interfaces -> expect FAIL if bug present
    (HW strips VLAN tag into descriptor L2TAG2 field, wrong mask
    extracts bits 47:32 instead of 63:48, truncated to u16 -> zero,
    __vlan_hwaccel_put_tag() never called, packet delivered to parent
    interface, not VLAN interface)

The reproducer requires legacy Rx descriptors. On modern ice + iavf
with full PTP support, flex descriptors are always negotiated and the
buggy legacy path is never reached. Flex descriptors require all of:
 - CONFIG_PTP_1588_CLOCK enabled
 - VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC granted by PF
 - PTP capabilities negotiated (VIRTCHNL_VF_CAP_PTP)
 - VIRTCHNL_1588_PTP_CAP_RX_TSTAMP supported
 - VIRTCHNL_RXDID_2_FLEX_SQ_NIC present in DDP profile

If any condition is not met, iavf_select_rx_desc_format() falls back
to legacy descriptors (RXDID=1) and the wrong L2TAG2 mask is hit.

Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support legacy and flex descriptors")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 1d8cf29cb65a..5bb1de1cfd33 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -277,7 +277,7 @@ struct iavf_rx_desc {
 /* L2 Tag 2 Presence */
 #define IAVF_RXD_LEGACY_L2TAG2P_M		BIT(0)
 /* Stripped S-TAG VLAN from the receive packet */
-#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 32)
+#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 48)
 /* Stripped S-TAG VLAN from the receive packet */
 #define IAVF_RXD_FLEX_L2TAG2_2_M		GENMASK_ULL(63, 48)
 /* The packet is a UDP tunneled packet */

-- 
2.53.0.1066.g1eceb487f285


