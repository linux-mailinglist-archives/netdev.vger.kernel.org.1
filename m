Return-Path: <netdev+bounces-302851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Db0Hsz6QmrVLAoAu9opvQ
	(envelope-from <netdev+bounces-302851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB0A6DF265
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:07:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YERhWV5Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302851-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302851-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A92D300E297
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0203C4577;
	Mon, 29 Jun 2026 23:07:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01242314D37;
	Mon, 29 Jun 2026 23:07:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774472; cv=none; b=YBNkmMdhyzGo/E1r7CpCwB6qua6n4OyLz2urh28nlW33yi7B+Q1GLxoXZTjWqXoOtkgBdjzhm6A7J4hFHDAPN8xAkvZ8ZVS2CX/WjDaij8rPBrp4n5kAhlpfRPwVwusLsulUeGft/491SSpruhhlJFv4pr8RmMhUloqixIeb6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774472; c=relaxed/simple;
	bh=0b98DQegh8h5rfdnujJR+hjTymj8BBlMOubiJy/+8G4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxHfNrltWrb20jtonFfjEYYg/clkbvlEepn1ugKamXwwSkZ8yE7BEtarL5Lo6Z5nsE305dHjew8fvi48J3eZzImMB+sZ9qcdkbDUQHSzm7ojX8sydjMKBiMzAQG+wtYJ32fqKBqQbVPO5BRml50BuRaDYxfiPKba+t5zg+fiMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YERhWV5Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355471F000E9;
	Mon, 29 Jun 2026 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774471;
	bh=mxQBa5sXfIaVTFTHSBvuqdLuv/xmtYKlIj0I76zVS3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YERhWV5YRiFMFBvr6nnFiSiiw2LE+fFOXCh7RvlV5NTbI4g1eqXNC0TUL2fcSbbNF
	 cqABYon7+d0B3ueLlL7oNzteEc8ayH9DHflacO5gXEsKcTjMnzzG4IlwB45gutJYfX
	 HQm0htIin2oJyP0xqtb0NoOjWgBpVamkL9Qtxz3Jma/HG7aCt+cwzdMLY3Ov7zw9pn
	 veMezZyifLkRUTMM2MjQTit7cXhv2tfcd/JDUO7z+wx9a0vcPiE9/2ME3Pgp3qwy9f
	 Ps1JGFnyCrDl1m19QnY8gLwcDyC9XzOe92xEz0RP92nfF1jwjEztDMvDngmh2imv2F
	 YRG2CnNfJzxIw==
Date: Mon, 29 Jun 2026 16:07:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <maxime.chevallier@bootlin.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/7] r8169: add support for phylink
Message-ID: <20260629160750.0a84e5e8@kernel.org>
In-Reply-To: <20260629060931.1006-1-javen_xu@realsil.com.cn>
References: <20260629060931.1006-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302851-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FB0A6DF265

On Mon, 29 Jun 2026 14:09:24 +0800 javen wrote:
> This series patch adds support for phylink. RTL8116af is a fiber mode
> card, link status and speed can not be read from standard phy reg. So
> we read link status and speed from serdes reg by pcs. So as RTL8127atf.

Sorry, but net-next was still closed when you posted.
It'd be unfair towards those who follow the announcements to consider
this posting, you'll have to resend.
-- 
pw-bot: defer

