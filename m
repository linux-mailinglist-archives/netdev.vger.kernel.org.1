Return-Path: <netdev+bounces-306796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JYVRAC8QUmqTLgMAu9opvQ
	(envelope-from <netdev+bounces-306796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:43:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD774115C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:43:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Ci+SD/uS";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306796-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306796-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECC9B3004620
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC07392C4B;
	Sat, 11 Jul 2026 09:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3B3921F6
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783762988; cv=none; b=YYi34uO/ETaJii//eztu7ZdaED69AQzOTYdtD+y+rlSPRfUnBEPEjpjK2BSA5jfvBvbWD4sDoRTFZoMClvo6Au/76QepXQTowcy7Gv52Kc5iwBA8ZGKzAF7sDcBFK30kJifNvoRYkoNZvNohqWZ2vNgZ3N6Jqj096KkI7BWZpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783762988; c=relaxed/simple;
	bh=4/OveUaPFLEtTwIsyLRmNCFGeqFMYt4l6j3kWcE4VGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YlOmZ3hnr+TiyJXWR6qWFp2hVdd2auC+lYXVQ/RtM9EeDOHZe8BwaiHnKTUhpBXOoxVbrrNd4BLafnFOJWUpDSyK7ZUDQ2Ybav6OKKysaAKGP2yMWnmSvGH1DyhL5CDZuKJAIpe4fsf5g/m1uBHRlIytgmFURUV90BkODd0fWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci+SD/uS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D381F000E9;
	Sat, 11 Jul 2026 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783762986;
	bh=fcFM2DEyo0/UtZq49jKGjdddgQFFKjYqGVGv0aRtLaQ=;
	h=From:Date:Subject:To:Cc;
	b=Ci+SD/uSEwpbO04jlGuuw2r5a7nnMmt8ZonU5ePg4RD1Zk2niPmOtyQeeQuWAIp5D
	 WNUree4pWkUc/agdhhKVe/bkR3pcULP3Pav2LzDLarmS/5g+7y1XZmZjs8amnzbjY6
	 MyxtVdzYvhpOG+78PlsYaHTe8pxaxO9Nx6C7b/CWd2MqoEZYi6Q6Xt5vKBPuBfXu1z
	 AwgETRoSTYu3dN9PBardmHf1F1PF8HD3kivdqadtfI5TQSbiHAf67m4rgXW1KfeD4D
	 6+cgU8zxuWzbD4/4cAPtFvomXRg0X9ECe/uyXFGTEb12m3juXtZcgGP+h3C4Lvw+J1
	 HcWqzekHIz/6A==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 11 Jul 2026 11:43:02 +0200
Subject: [PATCH net-next] net: dsa: realtek: rtl8366rb: Fix up port
 isolation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6Xs2YU0kVj9FfGQxlddkSi7UQql/
 27U4zDMLGRQgdGhW0jxFpNHadBvOsrXVC5gOTcm73x0O+dZ630IMerIk8wwTvswDaFH9mlLrXo
 qfqJFRyqoXDBXOv2NvcYbcv0OaV0/Ns4Odn0AAAA=
X-Change-ID: 20260702-rtl8366rb-fixes-a93f831ec2a4
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306796-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EFD774115C

Sashiko reports that we incorrectly disable isolation in the setup
loop while what we want to do is to enable it.

Just delete this setting: the next loop in the setup code, over the
user ports, isolate all the ports from each other, so only the CPU
port can see them.

Fix up the comments so it is clear what is going on, including a
missing word in the helper function.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://sashiko.dev/#/patchset/20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index d2fa8ff6a5d0..e615814049c1 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -794,8 +794,8 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int port,
 					u32 mask)
 {
-	/* Bit 0 enables isolation so set this if we enable isolation
-	 * any of the ports an clear it if we disable on all of them.
+	/* Bit 0 enables isolation so set this if we enable isolation on
+	 * any of the ports and clear it if we disable on all of them.
 	 */
 	if (mask)
 		mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;
@@ -950,11 +950,6 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 		 */
 		rtl8366rb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
 
-		/* Start with all ports completely isolated */
-		ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);
-		if (ret)
-			return ret;
-
 		/* Disable learning */
 		ret = rtl8366rb_port_set_learning(priv, dp->index, false);
 		if (ret)
@@ -974,7 +969,7 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 		if (!dsa_port_is_user(dp))
 			continue;
 
-		/* Forward only to the CPU */
+		/* Forward only to the CPU, isolate from all other ports */
 		ret = rtl8366rb_port_set_isolation(priv, dp->index, upports_mask);
 		if (ret)
 			return ret;

---
base-commit: 23dad2d088dfc82cae1f5a936f8ff7ffebb38dd9
change-id: 20260702-rtl8366rb-fixes-a93f831ec2a4

Best regards,
--  
Linus Walleij <linusw@kernel.org>


