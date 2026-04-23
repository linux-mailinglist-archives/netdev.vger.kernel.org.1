Return-Path: <netdev+bounces-280650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Kx2Bw7P6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:49:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C81A44E272
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C86C3044BB7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BA2FFDDE;
	Thu, 23 Apr 2026 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="o7kk9egJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3522F5321
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930468; cv=none; b=cO/BmVx2c8lqRtpqTcjjK3C+xuzAXtcYck8bHjPOJ6QOrAkOG5MXxhx5EUDAffb+Ht+SJk6WSvwnYmibc68vZMZV2Gc3lzdRrfvbHi4ZKlJkB+fW0KlhogTlf2dJzsB16G9LFXQRA2mb+9pGeOWoHwykPbLi9LlPz5va9onNAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930468; c=relaxed/simple;
	bh=MaAL9w4ZShSESQtMxf+DFjEZlvuvw9GICxMAfxEkez0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhqFL9V84aC3B2I5ea77StLkzGmXd7ASuTzCDSYcTWx+kqu7+SLhJJKDvKohhYOLKjR5pTabk9FTlupm9mosnK58J046gEUNCX5l84dWCfSBNf/950Nm58didiPdfEbQ2k0JTlV3o0adPKmIzLz0xVv7XmWf87FzYdT/vmJ0cBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=o7kk9egJ; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so4504169eec.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1776930466; x=1777535266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=225GaYlXhmnl5g0WRCHES8Fr+uEd19yR1Q+pSrskepw=;
        b=o7kk9egJ8SzOF33ulB70M0T1b+R3U7WppXR4ezUPWW2JiQsc4RY6oBsKHE1kyU2i2d
         us74bEE2MyPquW+F6Nvm549R7xHScezM904CkrPY1BCW+JRSbvV4d0mEQdwMKv/4K4OI
         HgU8DpWwBIdYysyhLGMbBAIM7g9/C9BLoiwtltGOFSGX+UYpn3CIs8B5AeM0bWC2Xkvf
         ER1KunkKyhQjT5hXN6MegZ1Ig8qU8pel3soavJCpTMLHKn8Zf4g2YjtJpoAWPrbu8DGP
         v6HmowmU39NGel7EzvGngp/TSsV6k8QdRRjd/JNdp6nRDGmXmKKQy1OvjL+AX96E7wLV
         pLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776930466; x=1777535266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=225GaYlXhmnl5g0WRCHES8Fr+uEd19yR1Q+pSrskepw=;
        b=I94YSP/88TMmVTs5htVZFT3OJS1/PVrBNlBkwBP80YbzTY4oX7GeUzBKu2jiSQrRUK
         PXNJXAJ1tioWIvbpItopFVhE8Kc7dDjolvody12fpxrKKRpUqljUg4eVROUNfM0J7pLL
         EsgGMGzxi0lWsB+OYr53GPBxZctkns8uoqdX9tBHjp00ECos+gEC9QwjEavNPOAKk0zG
         9cwrnOaw9oXvq5wxt23MaVdgOrZ3O/3q+G9D7b7qYUT5BNYPXwS4aV3HKdxa/EKyWKI8
         uN015vxCoYv9YVOdjfZQ9Jt8hleOrYHdbDDcgRwxUBivuBA5xOfv4zKM/sFRz1w0oP+J
         VnEw==
X-Forwarded-Encrypted: i=1; AFNElJ97/CzHGZWjyFToiBhaTWQeWEn78s0DfNIRr7uKAqoDbTt4swWsZG+qZUGMoagk5lg3ZxEqMo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnH42Xf3P6oueePRWijtXDBl1W5edsPuI9ynDY+EzJCyRL5pm6
	LKhPtgNmiaCkBVFNRN0Tcot7dHpFahhiCTwbgC8ZkV7sWM3/eOLN3PFWSJTFYSsp1G4=
X-Gm-Gg: AeBDieu59iWjRNTxefCX4ZN8fKIUHbtEGZx25uIGqs25JZJXsNpj8QYXUHN6MbEiZYA
	tXXHa7M0ldha9o1+Z2NjVURa7ix47VfAbSY211kKTIhUfeD61poBOjWTK5Ieyg9SgyjZGF0GV8p
	PBZgwjmyRjv7j8TlUt1T4umezUkQIcre5/gxdj2kjHAM+iCuqOcLx2+QSe+xXtRhr7Yiwjb4P45
	mhMcp2S/DykAI7FRVGjvw57mmKzvMohnIGZMafPmO6ZNIP5j03rdTcKMGsG6YipXxu8mLooqLjs
	GdZ5nvuWnkYxkw3H/yF7U6Q2nHmhKqk6GHPeaYPr9wESNCyGXiBK2KqIQNlTtwQUfJTY9bNF4uz
	AzheCc10HVGO+Zum3hi04DsjOIdWz7Qjfd7/PFbflFSmKnoNqSPF96TA8w0stW1svUH68j1eKvg
	HlR1vNC8DU1NWulaSlVe8pgJF6ikMojTnEpjxzZVImPqgfenTi4ryoWIe1Y5s3Ey6j9i4WFr6kQ
	/k3x3HovwFRP5onUGyKXMqrNg==
X-Received: by 2002:a05:7300:b58a:b0:2d4:62f0:b2d4 with SMTP id 5a478bee46e88-2e4786461b4mr15087024eec.13.1776930465782;
        Thu, 23 Apr 2026 00:47:45 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2a00:79e0:2ed2:c:c318:833d:66c6:43a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm35028102eec.29.2026.04.23.00.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:47:45 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wolfram Sang <wsa@kernel.org>
Cc: "William A. Kennington III" <william@wkennington.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: mctp i2c: check length before marking flow active
Date: Thu, 23 Apr 2026 00:46:52 -0700
Message-ID: <20260423074741.201460-1-william@wkennington.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260423001517.79219-1-william@wkennington.com>
References: <20260423001517.79219-1-william@wkennington.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wkennington-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280650-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[wkennington.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[william@wkennington.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[wkennington-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wkennington.com:mid,wkennington.com:email]
X-Rspamd-Queue-Id: 6C81A44E272
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, mctp_i2c_get_tx_flow_state() is called before the packet length
sanity check. This function marks a new flow as active in the MCTP core.

If the sanity check fails, mctp_i2c_xmit() returns early without calling
mctp_i2c_lock_nest(). This results in a mismatched locking state: the
flow is active, but the I2C bus lock was never acquired for it.

When the flow is later released, mctp_i2c_release_flow() will see the
active state and queue an unlock marker. The TX thread will then
decrement midev->i2c_lock_count from 0, causing it to underflow to -1.

This underflow permanently breaks the driver's locking logic, allowing
future transmissions to occur without holding the I2C bus lock, leading
to bus collisions and potential hardware hangs.

Move the mctp_i2c_get_tx_flow_state() call to after the length sanity
check to ensure we only transition the flow state if we are actually
going to proceed with the transmission and locking.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/net/mctp/mctp-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 15fe4d1163c1..ee2913758e54 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -496,8 +496,6 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 	u8 *pecp;
 	int rc;
 
-	fs = mctp_i2c_get_tx_flow_state(midev, skb);
-
 	hdr = (void *)skb_mac_header(skb);
 	/* Sanity check that packet contents matches skb length,
 	 * and can't exceed MCTP_I2C_BUFSZ
@@ -509,6 +507,8 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		return;
 	}
 
+	fs = mctp_i2c_get_tx_flow_state(midev, skb);
+
 	if (skb_tailroom(skb) >= 1) {
 		/* Linear case with space, we can just append the PEC */
 		skb_put(skb, 1);
-- 
2.54.0.545.g6539524ca2-goog


