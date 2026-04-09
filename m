Return-Path: <netdev+bounces-276755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAIwGvDt1mlYJwgAu9opvQ
	(envelope-from <netdev+bounces-276755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:08:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6963C4E53
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F65A3010B64
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F2EF9D9;
	Thu,  9 Apr 2026 00:08:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6E28E0F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775693293; cv=none; b=TEOU5XxsZiwep4ckwjjKnbCm/vb8s04qt6+Y59p8kHsOSQBYdMlNPiZtnGjywmY+JhkvRBV+rEDQa4QmIi+8iAFY7ceFWGdCosIXYpc+bafr2DxGWpQ6g5wt70KcBeo2e2M+VFnJo5NJLT+vA6IJM4uRnczs/ZANyMh1c9hbqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775693293; c=relaxed/simple;
	bh=lFEuiPp9y51MB+9Kl6vQv4KZ1R438yd+jl1epsBacHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zm9JaIut2L4XzxMszmEhedSYL2XrqH2OloNRiYz+qumSzhLsYJYqQogtbE6XZJWzV02v4XnLbsSpUR+ccmu08bB7qDc3Iqz9fN2eAtmRDVyv/PzujCrQr1zodtOBctGEJvvYDyzBvjyPFzoZW3fkq9LnxXdkNrTdzCaJ9bdMZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4frgHl6zhxzHnGjf;
	Thu,  9 Apr 2026 08:08:03 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (unknown [7.214.147.1])
	by mail.maildlp.com (Postfix) with ESMTPS id 2577140569;
	Thu,  9 Apr 2026 08:08:07 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.168.74) by
 dubpeml500004.china.huawei.com (7.214.147.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Apr 2026 01:08:02 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>, <netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <salil.mehta@opnsrc.net>, <shenjian15@huawei.com>, <shaojijie@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>
Subject: [PATCH] MAINTAINERS: Remove Salil Mehta as HiSilicon HNS3/HNS Ethernet maintainer
Date: Thu, 9 Apr 2026 01:04:30 +0100
Message-ID: <20260409000430.7217-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dubpeml500004.china.huawei.com (7.214.147.1)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276755-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[salil.mehta@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hisilicon.com:url,tislabs.com:email,opnsrc.net:email]
X-Rspamd-Queue-Id: CF6963C4E53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Salil Mehta <salil.mehta@opnsrc.net>

Closing this chapter and a long wonderful journey with my team, I sign off one
last time with my Huawei email address. Remove my maintainer entry for the
HiSilicon HNS and HNS3 10G/100G Ethernet drivers, and add a CREDITS entry for
my co-authorship and maintenance contributions to these drivers.

Link: https://lore.kernel.org/netdev/259cd032-2ccb-452b-8524-75bc7162e138@huawei.com/
Cc: Jian Shen <shenjian15@huawei.com>
Cc: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 CREDITS     | 10 ++++++++++
 MAINTAINERS |  2 --
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 9091bac3d2da..a03b00452a1e 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3592,6 +3592,16 @@ E: wsalamon@tislabs.com
 E: wsalamon@nai.com
 D: portions of the Linux Security Module (LSM) framework and security modules
 
+N: Salil Mehta
+E: salil.mehta@opnsrc.net
+D: Co-authored Huawei/HiSilicon Kunpeng 920 SoC HNS3 PF and VF 100G
+D: Ethernet driver
+D: Co-authored Huawei/HiSilicon Kunpeng 916 SoC HNS 10G Ethernet
+D: driver enhancements
+D: Maintained Huawei/HiSilicon HNS and HNS3 10G/100G Ethernet drivers
+D: for Kunpeng 916 family, 920 family of SoCs
+S: Cambridge, Cambridgeshire, United Kingdom
+
 N: Robert Sanders
 E: gt8134b@prism.gatech.edu
 D: Dosemu
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1e6d3acbac..97d0bc3108de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11530,7 +11530,6 @@ F:	drivers/bus/hisi_lpc.c
 
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
 M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
 M:	Jijie Shao <shaojijie@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -11545,7 +11544,6 @@ F:	drivers/net/ethernet/hisilicon/hibmcge/
 
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
-- 
2.34.1


