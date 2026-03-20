Return-Path: <netdev+bounces-269919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAnFAG9RvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:53:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971AC2DB645
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D83E330022E2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F71339B1;
	Fri, 20 Mar 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgY+YEi7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FED3BA23B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014826; cv=none; b=frk0t6LyssY576XwV8k/PzZsCIIEbNvcp09SaOx6LXtigWRU31YrbjxlU8qjAaGQ/JPuu9UJAR+LtQEaDcRt+OmWc5clY9h26rytjTp9SLqZi36jnzdpuz/QQcyl3j41iWZOFHh9N9dkbtWwhK46e0Tv2q5m7/fbaXpd9VCmkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014826; c=relaxed/simple;
	bh=nsansbrA9exd4wl5vfPa+yMLVXrtAYJN0VW+tgOTLXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdZTDkJimKR4VNl7NHsgVNO1YYrm3yuPO2Ekv1H3h6kl3oK92rQdHltio59MTyodiA3YesA8bsE9gKZs3DylQwoBFOVWlO97soaZuiNXKgCpk306IQa06O5dllL1ic8K7VsGMf6lSK8kFChLLNRhDVDUaChdPLfOQyC/TPsT350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgY+YEi7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774014818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/EP253Ita56izT2rWbDKalNcQ8a/uClSIqHZjfuXQU0=;
	b=ZgY+YEi7OgC/SZES2EYaMaD/w/GnE2anP4eQ5MlRf/LdiyWJdaPk/0cjwi3riLJHKt35M1
	YKh3L2aekv2tB3UGWUuXYpeYyeaxyhh/5m02czVb8TyFluY7X5UbxiWl8kzzdaDv7gUJpi
	xwt/WknU0YpiTkm9id8Fpa5EQEcGhNE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-QFNSuCzfONOXi7UmaxPa2g-1; Fri,
 20 Mar 2026 09:53:35 -0400
X-MC-Unique: QFNSuCzfONOXi7UmaxPa2g-1
X-Mimecast-MFC-AGG-ID: QFNSuCzfONOXi7UmaxPa2g_1774014814
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B980719560AF;
	Fri, 20 Mar 2026 13:53:33 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2335B195394A;
	Fri, 20 Mar 2026 13:53:29 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] iavf: fix wrong VLAN mask for legacy Rx descriptors L2TAG2
Date: Fri, 20 Mar 2026 14:53:26 +0100
Message-ID: <20260320135326.1171433-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269919-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.896];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 971AC2DB645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support legacy and flex descriptors")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 1d8cf29cb65ac5..5bb1de1cfd33b1 100644
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
2.52.0


