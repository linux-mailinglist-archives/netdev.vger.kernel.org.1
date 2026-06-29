Return-Path: <netdev+bounces-302739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PxzVFkGsQmoZ/gkAu9opvQ
	(envelope-from <netdev+bounces-302739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:32:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF56DDC2C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=lkv76iMP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302739-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302739-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBDF031205B6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8B4534A4;
	Mon, 29 Jun 2026 17:26:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FE3F0AB1;
	Mon, 29 Jun 2026 17:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753966; cv=none; b=M/kTUIcmI//2v+lJ3rlx84RQn9OiRxa9ZegkIBthh7JFrSPfHKJDvNn//8xHAjTHpV4+rI1w5xYNwPXAZfkXyzyrqd96pme2shR8IKWS9z22zXJu2hM36tDRUwFeH779Aygq1YtN3t+hELOj7t0ssbeuPoGGJQx4yNSN+0PyuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753966; c=relaxed/simple;
	bh=Wz8F6wfgDYuYsjWvaq0nfBuoX9f5woDLyMTg1gEV52c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1ISJB3xEuMOv9NMU0CkICfAmfg2r6rbLsva36uV3WYDtVBy/g2MSXRU8GUTi5Q2tCpYXBmAzHs9SfmRvXdq5eL3S/nXfKumJmR6QQAsIXDVF4d3jkzobjEX5sXo4U35KE8ycdbLRxKc3aj/X5CLckhnnHTHxPe1i20eF/tiQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=lkv76iMP; arc=none smtp.client-ip=173.37.86.79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1225; q=dns/txt;
  s=iport01; t=1782753965; x=1783963565;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9Vvmc0A1inRMr3zmhnwnNdpnC36sbR/RofUydw34CYw=;
  b=lkv76iMPK70yr9c9hUdsPl5EMHXYbLde8EFTOIOLZYJJV2PJgS7FEKrX
   QY4Ct+Iq/g7SmQETs2Ecrr4tiFnvX1iC4bh1S1mSbCpqaI/vyz1rWVX4u
   fuHDamfFXV/WlZDADp5dbBv6covr4esrDJs2Q2jFL4IKGWriCkL9UbCn0
   x/lO2IzMUVt63vjR8tRYpljePHJBhTUiS8lvPvo9cAgG2+DvCEVbjrR3z
   JrgCzguuAYyap9M/XJTk6ybylqggw42QmFLmnMRN4iQcMWhysoSbhx+Fz
   mgc2M+cTeI7MI4AlcV929JSR4O5HK7dqYBlaNuJSkkwnE66h68fXLKaUY
   Q==;
X-CSE-ConnectionGUID: 5uJPESlER0KVK+1aKU5rkw==
X-CSE-MsgGUID: wICwYu5/TUqW3nJYfrQUCg==
X-IPAS-Result: =?us-ascii?q?A0BFAgDTqUJq/5D/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh4UgWoPAQEBD1EEAQGFBgKNSwImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDuHJ6fzOBA?=
 =?us-ascii?q?YR92UaBZgELFAGBCi6FcYJqAYFwhAY7hEEnG4FJRIR+hCkBg3SCagSDHBKRB?=
 =?us-ascii?q?gk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNFgbB?=
 =?us-ascii?q?wWBHYEVLwQhgQSEfSMfAzl/gTB1WGYVMDWBER4KgVInAwsYDUgRLDcGDhsEP?=
 =?us-ascii?q?QFuB4xdFw+CLQkHgQ4UOIJXlmGNX2uhD4QngWagDwEyl2eTBS6HXQmQdCOkN?=
 =?us-ascii?q?4RogWg8gVkzGggbFYMiUxkPji0WzC8nMj0CBwIHDgMLkWgEgXkBAQ?=
IronPort-Data: A9a23:Hn3SKK0FGtmtUhgBmvbD5RNwkn2cJEfYwER7XKvMYLTBsI5bpzcDz
 mMcX2HXPPmJZGWnLtojPIvioxkHvsTWzNYxGldt3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 bsen+WFYAX7g2AuYzpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGUVwUBaAj/stNWUJw1
 r9BIRMwMwqAmLfjqF67YrEEasULNsLnOsYb/3pn1zycValgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUicC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+OS8a4WLKo3VGq25mG6Hh
 0nZznmkRS0nLePEzxi0/GiVu8TAyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3EOsSdb5Uluzp3vslh0BUdN4EOAg7gyJjK3O7G6xD24IVDNeK9orqMM7WxQuy
 1mP2djpbRR3ubeYT3O17LqYrTqufyMSKAcqYS4CUBtA4NT5pow3pgzAQ8wlE6OviNDxXzbqz
 FiiqiUii7gNpdAE2r/9/l3dhT+o4J/TQWYICh7/RGmp6EZ9IYWifYHtsQed5vdbJ4HfRV6E1
 JQZp/WjACk1JcnlvESwrC8lRdlFO97t3OXgvGNS
IronPort-HdrOrdr: A9a23:s96CPamnhlRAX0khDdP0emMp+urpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:uqMIuWGKGEv4buaQqmI66WwsN/shX0eF70nzYBaxKls0Ur6KHAo=
X-Talos-MUID: 9a23:zeyYbwnMi+ZqslI+YBshdnp9Fex30rnzT3wwiKpdveu1OzZJBhyS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,232,1774310400"; 
   d="scan'208";a="493768977"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Jun 2026 17:25:58 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 6B2FC180004B3;
	Mon, 29 Jun 2026 17:25:57 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 29 Jun 2026 10:25:53 -0700
Subject: [PATCH net-next v10 01/12] enic: cancel tx_hang_reset work on
 device removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-enic-sriov-v2-admin-channel-v2-v10-1-62569af83417@cisco.com>
References: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
In-Reply-To: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753956; l=1239;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=Wz8F6wfgDYuYsjWvaq0nfBuoX9f5woDLyMTg1gEV52c=;
 b=5S2mMrAF20DARmFhZzsZ+ejgRbs8FlVEO51HWkU5nvPnuUPp9fG0UtnMeGK9bwfSEd8c+moHn
 7wWb+UY4eE8AtO30XbxjviCu3KWYRYlNavLcSMUrS4dsVICA8JhtNPv
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FCF56DDC2C

enic_remove() cancels the reset and change_mtu_work items but does not
cancel tx_hang_reset.  A TX timeout that fires while the device is being
removed can schedule enic_tx_hang_reset() so that it runs after
free_netdev(), resulting in a use-after-free.

Cancel tx_hang_reset alongside the other work items before
unregister_netdev().

This is a pre-existing issue, not introduced by the SR-IOV V2 series;
it is included here as an independent fix.

Fixes: 937317c7c109 ("enic: do hang reset only in case of tx timeout")
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e7125b818087..b65796d96efc 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -3012,6 +3012,7 @@ static void enic_remove(struct pci_dev *pdev)
 		struct enic *enic = netdev_priv(netdev);
 
 		cancel_work_sync(&enic->reset);
+		cancel_work_sync(&enic->tx_hang_reset);
 		cancel_work_sync(&enic->change_mtu_work);
 		unregister_netdev(netdev);
 		enic_dev_deinit(enic);

-- 
2.43.0


