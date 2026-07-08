Return-Path: <netdev+bounces-305960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N8l+IqiaTmrPQQIAu9opvQ
	(envelope-from <netdev+bounces-305960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:44:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D210729A7F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:44:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="zmAi/Mj+";
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="K/PRFZrV";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305960-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305960-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48FF310ED30
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67564D90A0;
	Wed,  8 Jul 2026 18:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D54CA28C;
	Wed,  8 Jul 2026 18:40:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536021; cv=none; b=eIFrwBHipmydoi0OIg0TRrDHNTLg0B3Tyocbo8U8GFcYUvj8H/1lCpCRFwZblxe1v1tY4Re6mO4vSH+IDjhX66gdGJebnTNp1F28ZIORUuBKaQMMMD51fi2ggpUvG84vwNAIZngGulsvQsEhgxfgBo1M5dOTAIPXoyWPMwn4FTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536021; c=relaxed/simple;
	bh=l4oJeMVaH60hSAhPsZXtIKc3/sAxYN/CnAKXqLfsiMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzV7t72H65PY/Oe/DTuy+9rzU+nL7T+vwgNnaT1KBa1/1TBEEHT7h2+oD/RaIlQq0qJpZ+78bM3puXUGJAYhGEUpTfoe5V7m5mD1P2ERKqXGj4/treWN9AEKo+A0OWG9ry5wv3nj816I+8zs77aGwaiRcvdWjQJLfolKeFiTEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zmAi/Mj+; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=K/PRFZrV; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536012;
	bh=l4oJeMVaH60hSAhPsZXtIKc3/sAxYN/CnAKXqLfsiMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zmAi/Mj+At+Vwn8ywvOrbtHgTsIgcBH9oEZalvqY/BI1KJR1yLYtf7zCsOQer+dsJ
	 2Zwnv5MEggzuOhdqU9E1AtwL4g8NFUSAwpYcTMmEzaXRPPDrX3SITKbdswQ+dWiXCh
	 i15ptekoC1yHLbKlGAeICISXWdglnKZUOxObK7oKIQvL4uzHxUdPnCSYMeabNa//C+
	 ZDqwj8QXpT5XlT8IQjTEDm1JuZcivbzf7VjpZYT5RZ7p05fBI7Af2ZU4udnsLi1OL1
	 3qKyxdeF26mHKRYyd8m5N1gjYNoV390aL/jENUK+BxSY4SyWOeSltik/GMQszgXTnU
	 tOW4eXK6XJ12Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3F12F49448; Wed,  8 Jul 2026 18:40:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536006;
	bh=l4oJeMVaH60hSAhPsZXtIKc3/sAxYN/CnAKXqLfsiMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K/PRFZrVX4Q7wHIPqedJkJLdDHQT7/ig3nl/jTEHtwF3B6TwX+kYow77UaDLmwEZD
	 o6sLF8FDevT90b/q26EKlw/DzLuTgxOBvxqEr/yncqFPqKvYeuSlI4gUizlBHULMDE
	 tUH7gRp8h5hpeVoqt6LGpM101TJj0HYHkemBgTbWUDH7bdu9SyGaSluIclKVHomdXw
	 2Z+uCZDF7NTLgXX/ZJAoNp6cQdl7VbHuUHK5rd48ojJj4Yh1o2ZX0agXQwz9S3IHaB
	 CfVPA6cXBDOqwuoOCM+5e/P78YT3rV6IfAtNDLnQQI2lh6k9+9axHa8F9QCB8+D58Y
	 nNzgWJaqTlmUw==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2E8D2493DD;
	Wed,  8 Jul 2026 18:40:06 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:13 +0200
Subject: [PATCH net-next v2 07/12] ax88179_178a: Obtain speed and duplex
 from Interrupt URB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-7-0800fedb2e16@birger-koblitz.de>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
In-Reply-To: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305960-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@birger-koblitz.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D210729A7F

For newer AX179A/772D firmwares and the AX88279, the
interrupt URB response also contains information on the Ethernet
speed and duplex status. Read this in order to use it to configure
the link.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 94820dd1e7e4cbbcd2028783288615eef79b16e2..5f3a6d85cc4054e43e085531fcd715a990d87c6a 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -490,6 +490,7 @@ static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 
 static void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
+	struct ax88179_data *data = dev->driver_priv;
 	struct ax88179_int_data *event;
 	u32 link;
 
@@ -500,6 +501,9 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 	le32_to_cpus((void *)&event->intdata1);
 
 	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
+	data->speed = (((__force u32)event->intdata1) >> 8) & 0x7;
+	data->full_duplex = (((__force u32)event->intdata1) >> 12) & 0x1;
+	data->link = link;
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);

-- 
2.47.3


