Return-Path: <netdev+bounces-251963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF3xEkEQcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-251963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:43:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E172E5AB13
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30EF07CDABD
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DB478E24;
	Wed, 21 Jan 2026 15:56:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD7248893
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010984; cv=none; b=Mb1yzdWjPwyBCzK4I4uDampd8GyfcmRYLCyS0p6pZndHLuvuLIHzLYq7rl3WPrAIvyNNzuQ2568F2Y8ZIgHMZ3nxFrvWN9ySiMyilZKCqXC6JuG98PATwrPb9svgkHXMrKdgVM0H6cIxWXvvQh8kEgYMEjlzJlUbE4/qRFEBqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010984; c=relaxed/simple;
	bh=bJbfYoi9ePT6GJvQe190QXenIvJlnJbG5gCYyHOYLyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDBn7xiVAKAY0HXivYFagbnOIekgEQI6Y5noIG5myXR6AD/gZIDz39OtFggmktWTqvp6NZ+EUv3Z4LiQgX25f/hpAZ/MBeq7nxfRsbE5YjqzbD8Ip8nTyJ6qJQsrjmbACopojF1RB9n0QmOLJFwdaq52HBZDfQj2l0j6C7LqCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cfda2de4efso5764620a34.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010980; x=1769615780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0dc9BpwHRAb/FF2L8Jh14J11cIizVUqlWjJq5crcpt8=;
        b=ID4IbmX2sTtjNJRbFhLF++oowSPxJlGl3/tkO1VumeYb6GgyL2ozh473qvsOzQa+TW
         y3Fmww9Y88FTY2GV9Er9FuhEoBOLATPdS3GIs7iP4ifeUlF00ko1WL7JRFjlfGVjwn9c
         3+7hN3JSoJPdH5cFZz1isepQ2qtX5FDT7dbmmzyoIXI0TauTGPm0V6EXQYUh9dY2vG7y
         g5A23lSwJh9tKm3p4GuwRuat+SZ5VnBmyl/+eYnvjBQXBl+BXHX00uLmE4hTWufc0jNT
         xDnkU5MukMabHuFsoH6vkjLcIL8imp1cGuVirhDUHmVJFLrM9287Hr7x7vkgxjTvqFuX
         RrtQ==
X-Gm-Message-State: AOJu0YzriMStjUt44pQ5Km+bEv9jgZy2JPxAxfYxM0hcKt8mI23iKPG+
	5gp0bRPSyzXBIqB38x+ypDTbIukNXmAgjd1QcdTO0e05PZPQ8ejIrIYd
X-Gm-Gg: AZuq6aKM7yImvzclUjPP4IRRt6QS1xx3lkxV8nQnUctw8ZYsb7YVvQGGRROGl+7WsBT
	q0Q/s+tqFwxeJPKriVzunb6OJSJMPRBjqNbd/naNn1uJxmaY3J18AFdrhfSzWyLk6RmzERaDQ58
	j+3/fD3jQwu7LReenA32yUMqqfJww2JGhdVEJH4XVpyM09iG5gMgZ5FJr5+fW/smSJnkbT4GM/J
	J3Ury++TYYTKSsEYhsfswWRDY0oNY16v94BtstChmFgCkT7oOiiTj2UOxqDQHFBTezhlojzg03Z
	R0QT5vAhny8Q4BqC/ub7DXwMd//QQAds8lEa3PIRV7OcVc53cdxugpNPEJWx/ODyqdhaNdgXrD6
	juVCW7rGA0xB80niX79u5hA+v4W7DcnLvQ1faEzwyN9xJfrmtIhwRWgWTmar+JOdfWNNYO4ctHa
	nT1Q==
X-Received: by 2002:a05:6830:34a3:b0:7cf:da36:4c7e with SMTP id 46e09a7af769-7cfded34418mr11426838a34.8.1769010980605;
        Wed, 21 Jan 2026 07:56:20 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b5a74sm10537443a34.29.2026.01.21.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:38 -0800
Subject: [PATCH net-next 1/9] net: benet: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-1-07655be56bcf@debian.org>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
In-Reply-To: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=leitao@debian.org;
 h=from:subject:message-id; bh=bJbfYoi9ePT6GJvQe190QXenIvJlnJbG5gCYyHOYLyw=;
 b=owEBbAKT/ZANAwAIATWjk5/8eHdtAcsmYgBpcPchCHxqClAg62HFeFAbMUPfCD84HYKp+kg8Y
 i/NEdAJ4MWJAjIEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bbMSD/YiyXHZnrDbsbyzXsekkJF8wGQm8LZpBCwBjpqlmXQJrnLP0W0wE13XKmuWQhINTucgY3l
 PLMJW6H0Rv+97H/qPjnapi09wOKxEJysm6NkE3uq3qitja+AdkOsgnBUd7R10UYGND+Yd43LQAO
 bUYb5VeMFLVU7SNfdOIKO0ktpnbuUFXKXRlFEL0w+5q+EOpJShFdb8l65n+SCKgK/4m1uyBPLZj
 xpZ9LOf4hl45EsABkRQIXGc71tBlqtpvcyzo0lltZHa0FNpTEu9e93bmRGK8GmFLqlSFu3Vh6su
 KLRcTkll/+NlBneEbd3uqlHMVPBFMkQ64C6Cs28/69w+DzcvXwnQxJfS8ATSui5GtibOsp3yM61
 bZuApi8NGJCBQ+gBaKgnqfu2qXZyZdyENmAZ6/S7bRbB5ZWUmC1rwCn1ZvTkOoXPp4J7ehwKgaO
 m756KVYP65F4DbsAoEc0LaaiFORa7OxJ3rhk4bztDt+8Av7/sUFwlhSfC4dmujMkSIiM/1noxWR
 5K5MqZYwQlxWzz7wd2hjSDbGC1bYtTXOazDO7a8jCACSdoDwEty0/sIiDu4yzto73wKAwoNCPZr
 mdQYldtkShmobp6SldWy1h2ELbmREQkeuvxCClQAAFYNBxMHg78eNSNOLgLe7EnFkmLvFAQablG
 d06e/Vh/5IkuC
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251963-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E172E5AB13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by be_get_rxnfc(),
remove the function entirely.

Since the be_multi_rxq() check in be_get_rxnfc() previously blocked RSS
configuration on single-queue setups (via ethtool core validation), add
an equivalent check to be_set_rxfh() to preserve this behavior, as
suggested by Jakub.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/emulex/benet/be_ethtool.c | 37 ++++++++++----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f55f1fd5d90fd..87dbbd5b7f4e6 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -1073,6 +1073,13 @@ static void be_set_msg_level(struct net_device *netdev, u32 level)
 	adapter->msg_enable = level;
 }
 
+static u32 be_get_rx_ring_count(struct net_device *netdev)
+{
+	struct be_adapter *adapter = netdev_priv(netdev);
+
+	return adapter->num_rx_qs;
+}
+
 static int be_get_rxfh_fields(struct net_device *netdev,
 			      struct ethtool_rxfh_fields *cmd)
 {
@@ -1117,28 +1124,6 @@ static int be_get_rxfh_fields(struct net_device *netdev,
 	return 0;
 }
 
-static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
-			u32 *rule_locs)
-{
-	struct be_adapter *adapter = netdev_priv(netdev);
-
-	if (!be_multi_rxq(adapter)) {
-		dev_info(&adapter->pdev->dev,
-			 "ethtool::get_rxnfc: RX flow hashing is disabled\n");
-		return -EINVAL;
-	}
-
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_qs;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int be_set_rxfh_fields(struct net_device *netdev,
 			      const struct ethtool_rxfh_fields *cmd,
 			      struct netlink_ext_ack *extack)
@@ -1293,6 +1278,12 @@ static int be_set_rxfh(struct net_device *netdev,
 	u8 *hkey = rxfh->key;
 	u8 rsstable[RSS_INDIR_TABLE_LEN];
 
+	if (!be_multi_rxq(adapter)) {
+		dev_info(&adapter->pdev->dev,
+			 "ethtool::set_rxfh: RX flow hashing is disabled\n");
+		return -EINVAL;
+	}
+
 	/* We do not allow change in unsupported parameters */
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
@@ -1441,7 +1432,7 @@ const struct ethtool_ops be_ethtool_ops = {
 	.get_ethtool_stats = be_get_ethtool_stats,
 	.flash_device = be_do_flash,
 	.self_test = be_self_test,
-	.get_rxnfc = be_get_rxnfc,
+	.get_rx_ring_count = be_get_rx_ring_count,
 	.get_rxfh_fields = be_get_rxfh_fields,
 	.set_rxfh_fields = be_set_rxfh_fields,
 	.get_rxfh_indir_size = be_get_rxfh_indir_size,

-- 
2.47.3


