Return-Path: <netdev+bounces-274733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMZ6KaT0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF038EEEB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D3BC3047C69
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE433D9DD3;
	Thu,  2 Apr 2026 22:55:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958D3D811B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170551; cv=none; b=S05oNVLqVZED1adb5FzY4eSlYxgdp2ohYVG9ZlRVEl54p3Mq3FNwEFYeSb+h4aqaXsWtpCy8udJ3NMqEM0IqPj8TGpyp97wZGxRTGAqPzFrg9hfYJCsHgRNUFQiKT3rZft4Gye5UgYXhiZct/FKM33cEHWdtP6HePJkfdaRWPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170551; c=relaxed/simple;
	bh=Jm9nwGZjhZZeatqCxi8/bWT1kO5c8q5DfJQgvX6wLs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYc7pFMaKINVXpm/0Nz0+qlab1+SCJx5I4DgTNEvyumUFwq/xkbCxspHWU2bgzpMdNs6xuGkXXV+SnqMRwkUdwydOrVDp8wzQzZdf20ilNisVVJ4hagRMvddDTldhkZu6Q11gdHbt0DSrpJaMjdvjmscK3bGMilQSG8aAnnrr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so792211c88.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170547; x=1775775347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjbmQA+UAvJNFroRTtaphpH50vddoyQfB2DIkNU0HGo=;
        b=gwRMaraelf2Xplkh44a7B4tt8s/cWs2HqNV6KABr7qQ2MNyoNswimKunyZSZkA5ww3
         b1q/orD0Ju7Z4u36DNRKHdt+l8dGPUi2xYCnATF0n2HUqTFlriIWO+cvHnrC7cJ62a5h
         iOX3xW9JgDkQvXrge+ufNeJuPwmimLsGor3LD1cf+4Gdgt9XU1YKCSgZ+5n3OPHRmCVj
         lb+NM+YSegqwouZHp2pDqnc/XfXuwUWZbUtNYqepalI4aevo8kSXMKyKyU+kAfFmXPY/
         KAFsLMJDlzG5FJrjeK9E05lQuxp/loYVQlXQte8C3bBLQ+2Zjespe5+7VfnLOAVM38M2
         D1Qw==
X-Gm-Message-State: AOJu0Ywj3tA5u9YZ4GWjSdrREnawLmvgrCsbYGLo3Ffrvn1PRIqZHTv9
	AZlghWjlq4PILqJRHINPIt0NhMVfPF8+ShUndC18XTpl/1oqy1dRyKZmIm5Y
X-Gm-Gg: AeBDies/d7vWEHaiZKC4cIoiA0VJaSj072bH3SGUCZAlCwwXL/Gvo6yz+51zKhhczki
	m04DnD3wylnnwt5XY7I1CY8X3pNiILVRE6og0hoJP2e9kTP//vTzhbA9HU6WPeT+g//t0FSojt/
	i0ZdAvd3U2uoubMKE3UuVDveonYIFYhxxesipxDONLbxwpcrWHbQZ3KVrTuJkNA5Ohry6B1fyCG
	cHaTun1LV+3X3VWM3d8e637UbnPhpSuyTpaONLJD9fdieVd+xBPu+5GlVdFfZEX+uQnFdyQJquT
	UwcHYc5ZxkiDzcfdzl5vGTHuv4xoVcJICJfEC9ZDE045cXXQu2u/ftAmius02SeFRzSr132T+cW
	1lCyFXH9PNV8n3uGugG5l3BccvvvILFnfrKuuTCUX+VarhQem2xggixubM+mIU04taUrcMweUt+
	2zp/lMVE9k/spZ9odqCE7D+/mxFPgN0+ctfYGiSxH9ARtQpd7RXsB2RIsCZ9ctg64M5CcUyywkE
	sZNS9ALZpiHbw3YBg==
X-Received: by 2002:a05:7301:434b:b0:2c8:6361:ab38 with SMTP id 5a478bee46e88-2cbfa5c1258mr542426eec.15.1775170546990;
        Thu, 02 Apr 2026 15:55:46 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba62d7590sm1974819eec.24.2026.04.02.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:46 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 10/14] netdevsim: convert to ndo_set_rx_mode_async
Date: Thu,  2 Apr 2026 15:55:31 -0700
Message-ID: <20260402225535.4124525-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-274733-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADBF038EEEB
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
index c71b8d116f18..73edc4817d62 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -185,7 +185,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void nsim_set_rx_mode(struct net_device *dev)
+static void nsim_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -593,7 +595,7 @@ static const struct net_shaper_ops nsim_shaper_ops = {
 
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
@@ -616,7 +618,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-- 
2.53.0


