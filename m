Return-Path: <netdev+bounces-267493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EBYD9YptGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:14:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8E285B65
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87F0C3025F38
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A63B19CE;
	Fri, 13 Mar 2026 14:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118283B19D2
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413485; cv=none; b=GBpby7ZpuSQbW7w44pjLSldnsVBJk+QhukuvMghP6MbzcojM4Ti0Rh62UgY5B9U4N5ruBtYOyrnmhMXExzX+RFT/9NPOlMF4JkVrBatYGoKTrhPFLzEhFg9Nh9twdV+boYenlu6fMUh2aChxH0K+Yzh4I20NKkpwPzEQajhSgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413485; c=relaxed/simple;
	bh=FkE3aEmYq3JFi5GpqJgM6OBmxi48BQXX3kwNVt8fzXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mb0q4Ktqkgj6LZym64h2ekmPg55Ju/5kQG6b7vGeYQNOzssDA5yxHdSmZD4t0AyYGxg4BFAADqHITXiHtW3PzhH4Km1dLAfbjdpxpD2qLzd3pKyneuSIw7mgltDx1QAvjqORjZUGtVPvOObmhaMNdeWNlrtpe85TPJw1aTzoTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1271257ae53so3486526c88.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413483; x=1774018283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnwqqwAxnRG8s2vaRYDrbUdfVznpcDcr1raRDlnvaSE=;
        b=pxVLWxc1augo3utcrTco+7Roc1mQKo/CPecguMCsiWjUhgAxSHynLV6dGMYbjtcvvF
         h0MZoknSWE84/DNkpRoVMjlejJXP4GwC9UTMvFqSjsSeFfW4FyXcXvb8RKF2IlOrFWPo
         WVY9lsP1KSu6pWJZicA1TRHimBAL3zhhyeAq76z7GcIWCqVWmK4TNpSrHwsHKLfMUtDm
         A6JKLHu1/4T6nU4i2id8REkuZn8X4KVihrSX7uhrgX87gHyKBGnL5uCAUTXfrQfC3P1g
         2QHxj8t7bc4uGq6KQPmPSlazVBdKlf78dYdBU7z26dMCvm9hfQK7rvuVaXPaCxtM2bWF
         dhyQ==
X-Gm-Message-State: AOJu0YxHsTxKcVfDXw7nd5A26rRqme45FZspzkkY7/V30OnYfUASUPuK
	+AfCtkOyCExf/Bb88jgad6flzPjVtqYG2tl352/KXGYSQ/UiKmxofWD+uG0r
X-Gm-Gg: ATEYQzwdl1yT2j+nN4W1T89xUtFWriwSDmt0rLaf3VCiKGzEwch+MTSWsRu4MloHMJ9
	pWG/UNe3/ILl64q9g+bgBzwMHo0TdIuCnEOKTbhxaskKjaff50dC2BUEuiiaGZUxUTqQdkTWjny
	lphVxs9vb2sQAVwJ2crsnZqRoIpOO9oK5gfLkhhUKvLezxssPGUOYqbqYARkfxIrUvoR+zvJi3d
	vY675wG3W/fAVbRXQ+fm8xSAFugOdETxfW99xFcJnizakmzGxSR+pTE9875xGS/Dnbc2qcr7y2r
	LcmYfB0I1NHX/GfZz1z1zGksqpUZ+XlUVjtAPqKQ3u0WyyTr9irv6cLlbRi1F87P/chPqNpVKjq
	WvTQv6k+uCEN5BVXKtQBW7FGuQRPMaBcYtpbF8+4w607F4a58Q27h1xzxrK0eFcOTtKJt7lJcOw
	tYoefBxfXavNGZBq6hN+yJjTVYF1ci0sJiL3W1dDT+DVPvLEoToCFE1Ylovfc6z4ulJLl70lfSJ
	d5QcxlcL6TiQk1sgg==
X-Received: by 2002:a05:7022:6b9a:b0:128:cda8:39fa with SMTP id a92af1059eb24-128f3c5add4mr1718245c88.0.1773413483097;
        Fri, 13 Mar 2026 07:51:23 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f639d1e4sm2220832c88.13.2026.03.13.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:22 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 08/11] netdevsim: convert to ndo_set_rx_mode_async
Date: Fri, 13 Mar 2026 07:51:10 -0700
Message-ID: <20260313145113.1424442-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267493-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 3EB8E285B65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert netdevsim from ndo_set_rx_mode to ndo_set_rx_mode_async.
The callback is a no-op stub so just update the signature and
ops struct wiring.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5ec028a00c62..9c9217792125 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -182,7 +182,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void nsim_set_rx_mode(struct net_device *dev)
+static void nsim_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -641,7 +643,7 @@ static const struct net_shaper_ops nsim_shaper_ops = {
 
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
@@ -664,7 +666,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-- 
2.53.0


