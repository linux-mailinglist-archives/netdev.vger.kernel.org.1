Return-Path: <netdev+bounces-269068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CwiHU/BumkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:14:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E65D2BDF95
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55DB8328F0B4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F53ECBDC;
	Wed, 18 Mar 2026 15:03:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0F3E6381
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846208; cv=none; b=QQxT5ZmujqBboK959qx9dfk6y7HvyswhP/x7eu00xe10wBORkwIvvIadB9wL+5hKdtp7pT+4u8GNi+WRBqS9YMcQ277GF944MxCRmjejyGbENGvVkfeMAjTv5zRvCLf7HVPCD6NeX4EFu96kQNaFJ3dOgn3UY67q9IfqP5Glaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846208; c=relaxed/simple;
	bh=FkE3aEmYq3JFi5GpqJgM6OBmxi48BQXX3kwNVt8fzXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGTnL26jB4PrZ3jgZ2gCPrm/y4fAT0YhdkfbWKmFE1dv/SNqgNGlkVDTpmKVUOrUiR1YuqIzim/o+0mffnMQhSG+H9LqXCjbvGp1zRHUBAsewoLH5KEwiwiKCl6K8+1lHu/raJFXN0fx8Th18FmmhPqyzLu0rB7BKmx6JRQcCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so2428517c88.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846205; x=1774451005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnwqqwAxnRG8s2vaRYDrbUdfVznpcDcr1raRDlnvaSE=;
        b=mAzEQl51xeH5Fivkewfuh6yNY0gTrMfG9Pfqwd2hZsuSg630A2daHE/MXa6raDbtXw
         jO6rYyMkUsktomPuYBZlRRYTQutnBjrxSsr7gCMNJJQ5MBQvC/KFgvtck2bQXIKbZ+9D
         Vpp36XX3NDWriJ9zBbopb6YwaI70znqFRwH6R5Rvjvdl0XJjNAeUgoPiw2+XNY8E85X2
         uNZdUyJX4prCcTD7KuXjvfg2Zb2q/TYNDu/H8AaY8Nk3WmddgfwZojs6jpfz1iFrCEyH
         t2ZUAo2e/vcE8aRB7k7bJl9gU8O+pcmpOx86mqn2kV0nzigzlYj6Y/YrGZqnLqnb9TIy
         87Hg==
X-Gm-Message-State: AOJu0Yw5uO7xs2f3eHzEn4yB/MJkhw0UEDF/rmwClb0O2xwGyvimsgcd
	jX6m5lkBiUPGW998dM45yttL9T9/qIA2qaV1NgzXbNTM0D+QFplyMoMv/yj8
X-Gm-Gg: ATEYQzwOtKVX2AXm6Mviw7m1FfxHGrOEhKshtSHEuIn+SQHMsNbPzWc7cf/R9NDEd1I
	M4GgAKatab/qdiix9qa6YjGaVEEeHvK6NVZZwIR5h1UP5weBXmCLGJOUFHv99h47y+1Zr7yJYAt
	614UWgcM1wsVUOMeWk7jQIQX9CRfDllT7EsGbEVucU+LDNu/5753Zf/L1GaOr9rnOcrUAtrpk1k
	CJ/f8aCkzkRTyPX3fDOCFQZuu/daw4wYVzW+Z9BP9PngpWWZiiygJQRnRWVNxECmkAxmbIuTnas
	fO/5nRKc6CW4a1tX2Tky14uU3HLFgg1ivoEvrUwVoweRvuH1yTMZU9kjJhA+HoZ7hpoFJpiPrp9
	ocSRG0RSdv8TPTQxJ4BnwPFbVQxWpS64dd+L0PQQjW2cmtId08UDsYm4diBS772IzGUMEwe2bdK
	PbGQ6IcBSCg3LapvpauUJ60w7RAQ5ldPEqOAWp47N2ZruvME1sS/59Yh1v7KOeFiGxopQEkJDHp
	qboBqv6ckDyfR0AcSXcJUe3uHjE
X-Received: by 2002:a05:7022:61a:b0:128:cf5c:5362 with SMTP id a92af1059eb24-129a70e0ccbmr2203458c88.12.1773846204437;
        Wed, 18 Mar 2026 08:03:24 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b3e8d34dsm3689514c88.7.2026.03.18.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:24 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 10/13] netdevsim: convert to ndo_set_rx_mode_async
Date: Wed, 18 Mar 2026 08:03:02 -0700
Message-ID: <20260318150305.123900-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269068-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.034];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 0E65D2BDF95
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


