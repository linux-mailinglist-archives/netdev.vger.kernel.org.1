Return-Path: <netdev+bounces-304722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+R1LZZhSWrU0wAAu9opvQ
	(envelope-from <netdev+bounces-304722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:40:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E2708452
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:40:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Um6KMpPu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304722-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304722-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 686C7300CEBC
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C8231F985;
	Sat,  4 Jul 2026 19:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14C322749;
	Sat,  4 Jul 2026 19:39:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193992; cv=none; b=tNUTfDKkPyAKxU13nc66KcHXM0PJ0ZwtTsuSeJ7B5eMUBo5ymRjIWvtxBgvHuBUlL+xr79NggwI1XQbGRFZhueL2VBmewBJ9jO334XsKaVWIOLXfKsr3ZKv7ktmJ6BOMJVOgqt9gqNyAkwjHYb1eKJreQVPylSZIZ1dYu+HYQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193992; c=relaxed/simple;
	bh=hg8iabcFIbap/ynQls0mcJx6AM2EhUOOGizDrln07Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZFSQlbPgmAVx4afPPPmglIcyUoN8xSrF/7JCOI+y7MQDSPsTszN92VkPq6N95pnIFD89fRQD3ogpUIxR6KKH0f8wJR61gM9iDl9nglGLMFMSZ201HM9llzPjuUWlMS9emHgcfSOSi+nhaxQ3mrq1mGuL2YU6BwPhFihEOzjYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um6KMpPu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81C91F00A3E;
	Sat,  4 Jul 2026 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193990;
	bh=Zx7rvW5ZY9Px9CVnzO/KcJSO7h1jSduZQlE1l8PfwWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Um6KMpPu1pmJrBljNuhW6XIIW8lYpljWDkzJEn5I3NKlXlV6MimX+hsIf6p5iyRTH
	 EwbHfOO5EaLBhAcOtAmsNuVvZ452z342bA6E6dPEZyTVPW14JIcqxKW8TG550Vsq8a
	 GFDyGyKwEmk1a2paBfKbzA246JAAQdItNvS6K9hTjbrVQeBig4qDPgLbnptGNRahEs
	 LSk2V1u6rqiBTxuRMrVlOZvPa1B+uOt9RvWRjkjw4FmiYZ/iebUKQbC6O5JnGZHDXf
	 8gyVglNeaCnau8Ls5PDpyNBddetOiYmLP/f8KPHPJP3IaXvwjT0SQYytbjKb8ydizp
	 EuqNtteW8snMg==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 04 Jul 2026 21:39:34 +0200
Subject: [PATCH net-next v7 2/5] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-ks8995-to-ksz8-v7-2-2af0eaa545a8@kernel.org>
References: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
In-Reply-To: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:Woojung.Huh@microchip.com,m:devicetree@vger.kernel.org,m:linusw@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304722-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 674E2708452

The KSZ8995XA is just like the KSZ8795 and KSZ8864 a Micrel
product. It was renamed from KS8995XA to KSZ8995XA at some point,
but it has the same properties as the KS8995XA.

Be careful to use the full product name in this new compatible:
there is also KSZ8995MA and KSZ8995E which are not compatible
with the KS8995XA.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 8d4a3a9a33fc..4ed13870ed3a 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -23,6 +23,7 @@ properties:
       - microchip,ksz8864  # 4-port version of KSZ8895 family switch
       - microchip,ksz8873
       - microchip,ksz8895  # 5-port version of KSZ8895 family switch
+      - microchip,ksz8995xa
       - microchip,ksz9477
       - microchip,ksz9897
       - microchip,ksz9896

-- 
2.54.0


