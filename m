Return-Path: <netdev+bounces-298793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LZFAGl1zLGrcQwQAu9opvQ
	(envelope-from <netdev+bounces-298793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348267C689
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=labxXYwW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298793-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298793-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBDC2315DAD4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB5377ECC;
	Fri, 12 Jun 2026 21:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2437754B;
	Fri, 12 Jun 2026 21:00:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781298008; cv=none; b=jYg46Yo+t7C0murBATPIlHu7YS8XuYyCwBdfqXl3UE+U7/lmXo3uG8onjRahmxXC8O8hKR9rPN3Uu3o9yeOh+gFuAJ5PsMIKucKTrR4ATSv4ytvaBsC1zgB+Vq3ySm+Riq+UUAm62C9zlb0E0NkmIa8xtFRpdm/fFoS0CWwkQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781298008; c=relaxed/simple;
	bh=MnTlWXnA9OYO+S+1hQYbFnesde3b0uOWEzzavhIGK9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRiDGTFtfL44bJSflq3rAqOM+Lxy7E7rKgRnPkUxpXHWRHcbGAo2hWWLcU/S38G4xzz823O4sppA2ShiAFjelDTuEQDr8AS03525R8ZfEMBBNGlBT9IDQ75zyYlpf5/dLQIdWLr161/h/9mBUZ9xcclNltDt+WzC3qaQVQnHui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=labxXYwW; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75287A4F82;
	Fri, 12 Jun 2026 23:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781298003; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8rgv1C1KYhvNmP9EhM2vaA6On3DtJ3+S9NABs+9QcAw=;
	b=labxXYwWpClV0ZsjpfV2pZGB2j9GrgyemghJq3wU+aR/sgOY9kprwb1VUrWX3X6vwVSgGm
	BQsHlW4U7m6waP1gbHgDMhVVHjmSCrpk0VBNsKI4H9+9Jb+g4Iu5W8nb4S2glmM76Q3vG8
	eKs+Og1RZrWU8OTMuUp0Yvi7UrfFBaqE0dWsMy6btPD/qOpK/J24TQXuuzsCpR2/r4tSoV
	Kfna4dvxWudcZGvI7mnojDgacl8yZZN781IQt8w+6/gwE5DCf5/ZYGEdMV7LZJDTIZ7v+P
	6ZSX3g4J0Dr07/WdXfarIKKIN0niwktEU0KqaWVxmiYTvaWCCy7Vn9KpL+2yeA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 3/3] net: bcmgenet: allocate a single-queue netdev
Date: Fri, 12 Jun 2026 22:59:15 +0200
Message-ID: <20260612205915.3156127-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612205915.3156127-1-nb@tipi-net.de>
References: <20260612205915.3156127-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298793-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0348267C689

The driver only uses TX ring 0 and RX ring 0, so allocating a netdev
with GENET_MAX_MQ_CNT + 1 = 5 TX and 5 RX slots leaves four of each
unused. Switch to alloc_etherdev() which allocates exactly one queue
of each kind.

No functional change: netif_set_real_num_{tx,rx}_queues() already
clamps the visible queue count to 1.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 25f339eb304f..001bd445b110 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3915,9 +3915,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	unsigned int i;
 	int err = -EIO;
 
-	/* Up to GENET_MAX_MQ_CNT + 1 TX queues and RX queues */
-	dev = alloc_etherdev_mqs(sizeof(*priv), GENET_MAX_MQ_CNT + 1,
-				 GENET_MAX_MQ_CNT + 1);
+	dev = alloc_etherdev(sizeof(*priv));
 	if (!dev) {
 		dev_err(&pdev->dev, "can't allocate net device\n");
 		return -ENOMEM;
-- 
2.53.0


