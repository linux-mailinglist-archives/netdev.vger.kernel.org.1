Return-Path: <netdev+bounces-304647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qSNyAan8R2pQigAAu9opvQ
	(envelope-from <netdev+bounces-304647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:17:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65873704D47
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:17:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=CE2HxS8a;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304647-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304647-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD42530D4F7F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8CC30D3F3;
	Fri,  3 Jul 2026 18:10:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920432DC78C;
	Fri,  3 Jul 2026 18:10:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102206; cv=none; b=CqUMWutv1S1PZRutD3JxRCK+VoxXrJM0+otBFjd6GtFjJeyi/pM0enkMnZ0UgxR/4JwU2WSfWU58DdzyLmaWqd15YeyWmhao+rltwpMwvcI6gl+hBkuaoi0ykg1E4UknRIg0ogJm9jgKWvzO5h9aejBx1sDgzL+gUbPBcSI9jiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102206; c=relaxed/simple;
	bh=Wz8F6wfgDYuYsjWvaq0nfBuoX9f5woDLyMTg1gEV52c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ii5fNWttVtxfSjQ8BvPFBwkWjI/zPSgIilHwq1D9E6VOuahRV+zY3R7B6CMVL8AI59qc79SIF+9lyP2H7WBC8BqSUbEO5p4GlztcGJjYJj8MGVD44I6ovHwZ2sm6yZEIfrszjKY1KK+wxZkewDABmO2pGTT5NcF5hv7l8B7wFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=CE2HxS8a; arc=none smtp.client-ip=173.37.86.78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1225; q=dns/txt;
  s=iport01; t=1783102205; x=1784311805;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9Vvmc0A1inRMr3zmhnwnNdpnC36sbR/RofUydw34CYw=;
  b=CE2HxS8aCZP79gk5qPPodE5QSnBAhO9r656U4sXe47BZmWTEEI+WYddW
   x1FstDkmp5fhePzKwmSazRrLsQthMNTKAgDgDSvSSQOw3Nh9yE28YouA6
   oC/0YOMBv6dih3RhN7gslCcV8qSVkP9ld7dOLyQsdgN6Lng4wIjB2vkDm
   09rnPWtgnHh9MJLv/aoqfXpDMNO4v/sN8xoM9BqTnXRCCO16M6iNEtp4j
   CMNenzTUpvwtr/3XaEneaL3AmD1kcT6sORxot2+NjIwKaKQ59anVAg0yV
   75usug5f5hTpyLDGFTDaeJ9ofdCgQxxZ7nxK4OkLsh1M72BqTIjsVgU2Z
   g==;
X-CSE-ConnectionGUID: JrZyx4kcSSeGMAl/qJAEWw==
X-CSE-MsgGUID: eG0DouJoSnKZhrPMuD91mA==
X-IPAS-Result: =?us-ascii?q?A0BFAgBV+Udq/5P/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh4UgWoPAQEBD1EEAQGFBgKNSwImNAkOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDvAV6fzOBA?=
 =?us-ascii?q?YR92UaBZgELFAGBCi6FcYJqAYFwhAY7hEEnG4FJRIR+hCkBg3SCagSDHBKRH?=
 =?us-ascii?q?wk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYFQIULw8EFjIdcAwnEiwXNFgbB?=
 =?us-ascii?q?wWBHYEVMQQhgQSEeSMfAzl/gTB1SnkzgQIBEh4KgVKBJgMLGA1IESw3Bg4bB?=
 =?us-ascii?q?D0BbgeNABcPgi0JB4EOFDiCV5ZhjV9roQ+EJ4FmoA8BMpdnkwUuh10JkHQjp?=
 =?us-ascii?q?DeEaIFoPIFZMxoIGxWDIlMZD44tFtI6JzI9AgcCBw4DC5FoBIF5AQE?=
IronPort-Data: A9a23:MbFYYqmgAWV+w6DI2Fp1iXzo5gxBJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbDziGPvrbajHzLdgjb4q2oB4G7cKAn981GgNkpCo3EVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpLs/nb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05Fa8CyPdnXWJFz
 scVBxUkaleapcub/63uH4GAhux7RCXqFJkUtnclyXTSCuwrBMmbBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZT/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKIIofaGZ4MwxjwS
 mTu8kuhLhYHFtukzxm38miUo/LjzHr+cddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ8E5cTz5YI+lBTCSv59H6OvyN74Azf9x
 3aNtidWr7MekcIGyY2l8l3dxTGhvJ7ESkgy/Aq/Y46+xhlyaIjgY8mj7kLWqK8Yao2YVVKG+
 nMDnqBy8dwzMH1ErwTVKM1lIV1jz6/t3OH06bK3I6Qcyg==
IronPort-HdrOrdr: A9a23:Z7k0Fa7+6tNI1wvTOAPXwD7XdLJyesId70hD6qm+c20wTiX+ra
 GTdZUguyMc5wx9ZJhNo7q90ey7MBHhHP1OjrX5Q43DYOCOggLBR72Kr7GSoAEIcBeTygcy79
 YET4FOTPD9ElR+i9/3+02bH8ZI+qj/zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefnghOXNALu
 v62uN34xy9ZH8QcsO3QlMBX+TFupn3saiOW29/O/bigzP+9w9BL9XBYmOl4is=
X-Talos-CUID: =?us-ascii?q?9a23=3A9gkMbmiMd+EUUvzB7LWg4/hLqjJuUGfv3WeMIES?=
 =?us-ascii?q?DMmtGbZSRDkay0Y5bjJ87?=
X-Talos-MUID: 9a23:rVa9ZwtnZYOpDd0Lcc2niR46GMB1waOVDmM/kY8+ntSoZHV1EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="503843156"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:08:56 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id A711918000A71;
	Fri,  3 Jul 2026 18:08:55 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:08:50 -0700
Subject: [PATCH net-next v11 01/12] enic: cancel tx_hang_reset work on
 device removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-1-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=1239;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=Wz8F6wfgDYuYsjWvaq0nfBuoX9f5woDLyMTg1gEV52c=;
 b=7QqHva8rUG5G0BKhTJ2DB0kZosyC7jcukLym/gnE+u2beE7KomVSjYGX5/YonyWXkyDYsvXCb
 8p9Ifnns532AbgcGQXgrXCwDTtXDUl2fqURH31POFAUHzeSi4SbiV02
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304647-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65873704D47

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


