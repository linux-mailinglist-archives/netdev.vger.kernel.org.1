Return-Path: <netdev+bounces-298689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3w+GEYWLGqSLAQAu9opvQ
	(envelope-from <netdev+bounces-298689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:23:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ED467A21D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cJFUF0f3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298689-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298689-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D8063007510
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F0F385530;
	Fri, 12 Jun 2026 14:23:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3E37475C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:23:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274181; cv=none; b=o9kyiHG/C1Kn1mhGRrZBCH2HigGG3wkMZW5POoNvjsRGfvLZLvshXZbPlEgd+J8gfRGd6/jy2stJ/5XCXyItVV0LpjKCnUvHRVqxbh4UzJvZcKWzZpRHnW0gaUegf112YToIrl2lpTmLdjEc/EZ2yGAhYsqL7c7YT4aTmbm9Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274181; c=relaxed/simple;
	bh=+5Vm+5xN3nA8kqvACP8r30OjPg7hZ7ldhOwR/1ITh8U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sMFP0H3mBJzKzrr8fbvKMs5MqEWlUUMdHiod3goSkYBgnb2J9hfT13ceZKPwX4qStYUzsose1Zt+m5GtjuQ9Bbbhm2mslYco/o0yNhnUWbloD6tIF0SmO2jL0U8R5ppqWVTL+KM6p91CPwE/S5ZLraEXfSLMSB68mgMNaYVXeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJFUF0f3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFD21F00A3A;
	Fri, 12 Jun 2026 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274180;
	bh=ta51XgAIGVGdvHj6EHtz/ar29/xwILx0XBnGPHWF4/4=;
	h=From:Subject:Date:To:Cc;
	b=cJFUF0f3tqhSJ5r8D4P+7ae5TNLHwNIl43VnoU8HHSOlxz6PjBiw8r5kBCpFdYm3t
	 Wl8E9Hr/hXdBA3/kNTgF37nZ8WPrtBYx6od0ugLfCkEzNQ6//lk9ExL1aNRCMtElpm
	 UOW+vZYulB+D9TsuNThEQAu4OgSG6egTXDzd4TotXN1n9wmWZu2j9jUig1+pKq/Y4w
	 gQXgPavd3RiBJ6hnMb1TO7yx66MjXFk6C1NqFVYmkuu3+S8u136WAJ0xSjsUlqAxMR
	 90uwnGq7gZW/Sln8FCOoZr7dq1GJ89DU7RnW+9bxpL2wYu8/FhiJ8+K5EIkeKcTM22
	 zKMBdt8Zr2D2w==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next 0/4] net: dsa: realtek: rtl8366rb: Use generic
 RTL83xx code
Date: Fri, 12 Jun 2026 16:22:49 +0200
Message-Id: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4Xs2Sa0aiP+ivEg9KFrZCHblZAQ/
 t2qx8lkZqUMZWQ6VyspZs48SgG/q6h73OQOx6kwhTrEOnrv1F6nfYzaOh4mHWcMEMsuxaYP/nA
 MvklU4knR8/IbX0hgTrAYXf8mv9snOvt+ads+JC3XXoQAAAA=
X-Change-ID: 20260611-rtl8366rb-improvements-d69f2145219d
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
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
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bang-olufsen.dk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298689-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30ED467A21D

As a follow-up to Luiz's and Alvin's series improvining the
generic handling of the Realtek DSA switches, this small
series brings the RTL8366RB closer to the way things are done
in the RTL8365MB driver.

This patch series switches over to using the generic helpers
for:

- Bridge joining and leaving (isolation)
- STP handling
- Learning enable/disable

It would be appreciated if this doesn't lead to AI-automated
request to fix the entire universe (hi Sashiko, I'm looking
at you but I bet you will do you compulsive C3P0-style review
anyway) since I'm just moving code around so some helper
functions come before their new users. The code itself is
pretty straight-forward.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (4):
      net: dsa: realtek: rtl8366rb: Switch to generic port_bridge* handlers
      net: dsa: realtek: rtl8366rb: Use DSA port iterators
      net: dsa: realtek: rtl8366rb: Disable STP learning on all ports in setup
      net: dsa: realtek: rtl8366rb: Switch to generic learning enablement

 drivers/net/dsa/realtek/rtl8366rb.c | 268 ++++++++++++++++++------------------
 1 file changed, 131 insertions(+), 137 deletions(-)
---
base-commit: dad4d4b92a9b9f0edb8c66deda049da1b62f6089
change-id: 20260611-rtl8366rb-improvements-d69f2145219d

Best regards,
--  
Linus Walleij <linusw@kernel.org>


