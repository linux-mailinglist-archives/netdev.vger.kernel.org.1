Return-Path: <netdev+bounces-300904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BTQbC4RYOGpQbQcAu9opvQ
	(envelope-from <netdev+bounces-300904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3066AB9A0
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:32:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="aU/KXID3";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300904-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300904-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 954413001F8E
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7792857FA;
	Sun, 21 Jun 2026 21:32:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF223E342;
	Sun, 21 Jun 2026 21:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077566; cv=none; b=MEacOW0RstHnyCv3JxfGedTalQOmuex7WE24pAoYAk1QdQIEbOVvf5KinDX8OS3ZjRz7tHFW/PGfOMGju5c1wFn+ilLBIV9s7lSP5sjoku6PS+ahHSkks0zlcSx6rDGf0Xd0MpCilQPC7crHdhZe5Usydr2aoI1BxL8J2nEmSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077566; c=relaxed/simple;
	bh=B3OzuQue4xcBDCDEsE6Fy43nNHe3Pi7L4kWzy2hc8Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THjb74DIN6FrErXAMKkGLbFmhLg1CRj8yuo2bn2Enemz/NQ2l7QpI7UjoiQCIeuKjzYsdD9DvYtkFq39sIvCCpiRn7IqyLhxpvHQ3pDkkXSTgBiXgytTg16+srBee3IrogTTl5CTMpKers8rAsXYTml4Hs8cGm8+FbufMf5OLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU/KXID3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D5F1F000E9;
	Sun, 21 Jun 2026 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782077565;
	bh=EHJDaH5l99xOOoLRUD/4SgFWm6IU9UxSGvGJPVO/DLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aU/KXID3RDWfqmi4sAa96brSYGWpmV0dLbRgbRHa+TGyExTMVwNDxmBs5pR0/O5rm
	 8NsXLJ5EkFlNDpMEhKbwpvGPbjRaYWCroM/mHUorkPhOyG5q1PWcrQDYFXmOJYVI81
	 sDTnUyI1xZpwjUZ7Dv8IuErMiuHeR1pOT2bSjgpSrrZRCRz/8Pk9NrbyrW3K/C6RCI
	 d7uVq/arZistvdSULvet7k+L4v/5CTg1hBi7SOago7z4BokzTTPGT8kTMAM+0iJkUp
	 uZAppk3KGUYPQKZF/qDZkmNLSJyZrI2HTdv2OmkLO2e/tO9uzwrt60mHGP6xyvP6Sz
	 eLQEBxvdKleew==
Date: Sun, 21 Jun 2026 14:32:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Corey Leavitt
 <corey@leavitt.info>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: pse-pd: decouple controller lookup
 from MDIO probe
Message-ID: <20260621143243.1bb43f20@kernel.org>
In-Reply-To: <20260620112440.1734404-1-github@szelinsky.de>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
	<20260620112440.1734404-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300904-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,leavitt.info,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D3066AB9A0

On Sat, 20 Jun 2026 13:24:36 +0200 Carlo Szelinsky wrote:
> This is v2 of Corey's RFC [1]. Corey is busy at the moment, so I'm picking
> it up to unblock everyone. The design is unchanged. The main thing v2
> fixes is the SFP deadlock Jonas reported, plus a couple of smaller points
> from the review.

net-next is closed during the merge window. We can merge the first
patch, tho, if you repost is separately for net, since it's a fix.
-- 
pw-bot: defer

