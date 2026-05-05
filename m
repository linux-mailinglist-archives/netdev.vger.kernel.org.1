Return-Path: <netdev+bounces-284549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMIdEdk3+mnHKwMAu9opvQ
	(envelope-from <netdev+bounces-284549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:32:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70D4D2B90
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36183118973
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269F64ADD81;
	Tue,  5 May 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvDXuRF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5984ADD85
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005650; cv=none; b=GkG5n7OFFOrqEjlMVb/Gac1g6cZ+G9t06om7mTg6vjaKhfw/52NgdPG61lT6mIRulGN/E/H5DzRdUAaVQ7Ndjk6J60wkS/XQycqXNyp4t1e6qVDCSSSWlIqJKmNhndjYWn0cCBL3Z4JoF4n94n3MybwrfeZbliZ9cohWVIYEfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005650; c=relaxed/simple;
	bh=ZcRVlQJeNRXK2M0MgaksgKzLa1cJRySbcnQ11oZN5aQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kz5BvpANvzBLR3H/jMzKlozmaUvMSMauFZHihZwzbqjGFN0GeDQgwMNAaBgYgH5rxwVCoz1zXubAKpW3dTkWSiEPxUs+C1/MMhtUbJUKDvNZhYSuOV/dCHKjDug4IucDbfeKJ0U3ntPUJtFsHr0aoy3ojAX19zX0YbjhECcPSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvDXuRF+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d102471a4so23157465e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005647; x=1778610447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0DEjqI/MjSZk63smQxo8R3imVIUNR3yg/nfskjDHjk=;
        b=SvDXuRF+lFDJDRyv0I8OXmIcdJARFI1sg6o7DOVddSkaL6GUdT6tVYmoXfv+reMhFY
         rAIDvjbmAxK502EY8vB6qfY3hnwzclVxM8R2D9lNBiIDwDd127gZQ5TLG5WWL2HS542v
         cNmdOHwJ+AYPV/cgr9rKU3ewukdgqOkSRwcidOJP4XE1rz32VzM4jDd+CBqBpXRkZ/ss
         E8QFTUO99VIgUVCdMM6EjwmBogtd3PwKDrc8RS6mS1AMi8AdYhMP2xfxWWoGO6Zakvfl
         Bm6XmkZYH63uSC9BoBELc/1RTtQ2EyNFApjxDMK5OE1Kz7Z+D9CiIJqs7vMa/nJsNlVh
         7jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005647; x=1778610447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0DEjqI/MjSZk63smQxo8R3imVIUNR3yg/nfskjDHjk=;
        b=F+qIjR8Tnx3HuZI0bRgAvlHvjQSoJjG4RQr+eueaGXeiYxDjF59jRbeocEnKI5xVum
         sHRAFQ7w0AuOVIzeRsC/FfdDDXN8OhWsppy8El433/tVYCgmI6rPWDwEgY1MMBNHwMg2
         bAMVIuz0yDGG3ojMq0Riy/xaDH//bP6MsuPDDy05Vbf7S55D1sqUwQgPsLHCNy1En4AH
         H5DzKH/7XnGz60wtDOIX94PxM1jTCAM9FPPQ9GY1lvBq3cDm2/jXwwXDlcdQS+Zx76FF
         gvZpZ1uClDLu/xf19Cdc0CHB3Qz9tmCElcvt+heW1CWasjaIwdWx+AcQfFM08AcKw5PX
         51Nw==
X-Forwarded-Encrypted: i=1; AFNElJ9NWqusfiLcruJ34iYUEWSBkGVLrKzNmxrWo6FlpSGFeRXjWah+3sHZmxZp649IFAQskPdaYEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91d4+CSULpjQ1ArKtVXOpwUZLq9T87ZxHpX8alkaKC1/TJNWY
	Cnku+N4gmXaiFQZLW4p6qqdc54/utrAeqRorvWYePE/aeyiHbChDKf1i
X-Gm-Gg: AeBDieuxE2x4GaZqnjBdPitSrtCM9fImFRDRlvqkFeRHpNu1wyRMeBymn/nBrvdpxem
	VPtqysW7LMIw/FQ6CNy7O/RCQas9V99rWqQnpwtxHoG7rM70rd3qj8KQb1yg4Nn5hQrjvaTDZv+
	9r3M3ebQabG0G+DB5GX+PJE09/MOB6nGwQS0eMnJOhkBo+j9/lGrijev3PXVIMCXmkYh3u6f1K0
	62+3ke6rt1xPYLgNl5yk5EuFT4y+dN9NW+4QMeE3GhWEFch5TEN/5107/QcSYJp2vrVcQvoo6Ur
	qYfEVNMF5QABAdq8cj8RPhLcH+FscYMty4PU+oiBd2BtgNigEfnPTbvimWCbqPYnLxEh4Nd9X6b
	J7xZX0S+rhr2N1W/whob84iU2h3oENiHQOhils0qIuyluwR3B5/fiXjDEqe0UVgFNXG19+7VOwh
	aalC88mV0z1hzWFotLHkvx/cRTGZ2yTJpo3P+AXRVseUmI0ZVv38lChRuN5It7yjIiKO7BZkd0O
	Xvgo8c=
X-Received: by 2002:a05:600c:a412:b0:48b:339:73cf with SMTP id 5b1f17b1804b1-48e51f184ebmr5001945e9.1.1778005646464;
        Tue, 05 May 2026 11:27:26 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next RFC PATCH v5 01/10] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Tue,  5 May 2026 20:27:02 +0200
Message-ID: <20260505182713.27644-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505182713.27644-1-ansuelsmth@gmail.com>
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B70D4D2B90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284549-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add in phylink struct a copy of supported_interfaces from phylink_config
and make use of that instead of relying on phylink_config value.

This in preparation for support of PCS handling internally to phylink
where a PCS can be removed or added after the phylink is created and we
need both a reference of the supported_interfaces value from
phylink_config and an internal value that can be updated with the new
PCS info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..4d59c0dd78db 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -60,6 +60,11 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* What interface are supported by the current link.
+	 * Can change on removal or addition of new PCS.
+	 */
+	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+
 	/* The current settings */
 	phy_interface_t cur_interface;
 
@@ -629,7 +634,7 @@ static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
 static int phylink_validate(struct phylink *pl, unsigned long *supported,
 			    struct phylink_link_state *state)
 {
-	const unsigned long *interfaces = pl->config->supported_interfaces;
+	const unsigned long *interfaces = pl->supported_interfaces;
 
 	if (state->interface == PHY_INTERFACE_MODE_NA)
 		return phylink_validate_mask(pl, NULL, supported, state,
@@ -1868,6 +1873,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   config->supported_interfaces);
+
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
@@ -2026,7 +2034,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2828,12 +2836,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
 		return interface;
 	}
 
-	if (!test_bit(interface, pl->config->supported_interfaces)) {
+	if (!test_bit(interface, pl->supported_interfaces)) {
 		phylink_err(pl,
 			    "selection of interface failed, SFP selected %s (%u) but MAC supports %*pbl\n",
 			    phy_modes(interface), interface,
 			    (int)PHY_INTERFACE_MODE_MAX,
-			    pl->config->supported_interfaces);
+			    pl->supported_interfaces);
 		return PHY_INTERFACE_MODE_NA;
 	}
 
@@ -3761,14 +3769,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
 	phylink_dbg(pl, "optical SFP: interfaces=[mac=%*pbl, sfp=%*pbl]\n",
 		    (int)PHY_INTERFACE_MODE_MAX,
-		    pl->config->supported_interfaces,
+		    pl->supported_interfaces,
 		    (int)PHY_INTERFACE_MODE_MAX,
 		    pl->sfp_interfaces);
 
 	/* Find the union of the supported interfaces by the PCS/MAC and
 	 * the SFP module.
 	 */
-	phy_interface_and(pl->sfp_interfaces, pl->config->supported_interfaces,
+	phy_interface_and(pl->sfp_interfaces, pl->supported_interfaces,
 			  pl->sfp_interfaces);
 	if (phy_interface_empty(pl->sfp_interfaces)) {
 		phylink_err(pl, "unsupported SFP module: no common interface modes\n");
@@ -3939,7 +3947,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.53.0


