Return-Path: <netdev+bounces-263221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEVPG7vqpmnjZgAAu9opvQ
	(envelope-from <netdev+bounces-263221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:05:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 154FB1F108E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 682EA30AE6B5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA57369979;
	Tue,  3 Mar 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kp80WY9m"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302636654B;
	Tue,  3 Mar 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546081; cv=none; b=gLx3bBUldZKp0tG7wNOEMI3823fbcrN2eYnKqQ+PWOitddX6y90h2lJ7QbOOlntec3tHxytEPtTAbVqM5MOFEoLIjW3WaqeOOB2RjEWPpcHyKH35mHxhwZlDxadtcxrz6lLYo2k/WzpQ+MNpFagnczVihtQmruCRZNnhtOj0e4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546081; c=relaxed/simple;
	bh=SMMr1PdcU/OF0EiAehRqWWuHFzTL+3hjgw3LMCb1gTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKxrjv4vBQbQyFjzfvnPKutH7KMlSWxbXTaR8Je54dWdl/iMn/FRIvYEoPUkQpqETs6ywVw2RM6OMknb1aKwIBsgrXM/5elIGfM4iCRkKHZMqIdpkXHgAlIKW3X3PG+M4+f9vM0DqYEL1tQcx/cWcuadseOY5+LiIYcW2SzLPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kp80WY9m; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C9F4A4E42500;
	Tue,  3 Mar 2026 13:54:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DCA15FF29;
	Tue,  3 Mar 2026 13:54:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F2C2103696DA;
	Tue,  3 Mar 2026 14:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772546075; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tIAzdhsujhMcPbHTHBP9SpG8Mzlw5Ly5rGbW+sw5+Ww=;
	b=Kp80WY9mw07Du0z+vZQ4XxyWYiItSZww+0eroe07Q03DlcDZziTXVhKLeAABBAxLiLbreU
	82COeyY2lenO17EmdLdEuPd+0TbYq/3yKBOyjT6dmb5n68/qqWpua2ZOdl71FBKGWOWhDa
	eOliQ5rNQooUDqAJwkpk9LJJsaMh3yAsGFQsDAhhUGZcUFC4HQCdZc2gHIZH+6YpShjrPa
	0VwZ06A+8e/W1G2sbgOGljkv0ht+j/7ZmY+9OjpV2tQfeurEb0gUXi5/7kLEMNOxz973Uv
	qMC15a+u74tqKXlTPc4XAKUF73gBz48W9UrVB+rjA3RUkO7XOAt6c3fYpeCbeQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 03 Mar 2026 14:54:26 +0100
Subject: [PATCH net-next 1/2] dt-bindings: net: sff,sfp: Describe power
 supply pins
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-sfp-regulators-v1-1-7101ae34cb84@bootlin.com>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
In-Reply-To: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
To: Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 154FB1F108E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263221-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

SFP cages and soldered-on SFF transceivers have two separate power supply
pins: one for the transmitter circuit, and one for the receiver circuit.

Describe these two pins and the regulators supplying them.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 Documentation/devicetree/bindings/net/sff,sfp.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sff,sfp.yaml b/Documentation/devicetree/bindings/net/sff,sfp.yaml
index 15616ad737f57..95729cf694a7d 100644
--- a/Documentation/devicetree/bindings/net/sff,sfp.yaml
+++ b/Documentation/devicetree/bindings/net/sff,sfp.yaml
@@ -68,6 +68,14 @@ properties:
       output gpio signal (SFP+ only), low - low Tx rate, high - high Tx rate. Must
       not be present for SFF modules
 
+  vccr-supply:
+    description:
+      Phandle to a regulator supplying the receiver power (AKA VccR) pin.
+
+  vcct-supply:
+    description:
+      Phandle to a regulator supplying the transmitter power (AKA VccT) pin.
+
 allOf:
   - if:
       properties:

-- 
2.52.0


