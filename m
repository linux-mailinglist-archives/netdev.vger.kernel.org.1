Return-Path: <netdev+bounces-296718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Glu9HnoqJ2pkswIAu9opvQ
	(envelope-from <netdev+bounces-296718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:47:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9C65A860
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:47:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f7oMZK5c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296718-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 727E0302AEF1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2F3A1A29;
	Mon,  8 Jun 2026 20:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AE367295;
	Mon,  8 Jun 2026 20:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951582; cv=none; b=PDHre0miZVsZOvgrnyGwfKDsfFpLsnOC+bGUElHD9GBtFQEICOcq/k9Umi6K36RySuQINteinPwis0BVF5CRMC32FHP2RxebxslNgVzxOemf37ehL53JfoLvP+nFFflro1mc3kYqkpq4G4VxTgt77UmuT0CYQQaSXIVefUeLDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951582; c=relaxed/simple;
	bh=7F9jn/fEdMi13tnEYtwc9oUqIgD2eqhkP6jhWfbtbeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slSyizLHjL6ocymnQl+1qYxKu4amqqDkbtEEzOxxbpv0pYEYpnucSkOCxQEhITp/OCReCHbS7Rr0TCbsl272oSQjZwbjHhcTkHQfUeeJZu5CzSOETPBEeS77E6Pms0b5nIK+GHiRxYJl2Atp//XMwdeobMA1ULpzBh1swMVEC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7oMZK5c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93AA1F00898;
	Mon,  8 Jun 2026 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951581;
	bh=bWIBY5LUl28yp5MsbXoMql0yAtjBrajs5SLSANim5yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f7oMZK5cCZFS1D519w2gfmLagDibUdphM/mqhB5JatxX/YENzI9XKQ/iEklWMUn6F
	 jRTrpH1XRV88COxVUfnLMTN/yKa0JMQddqlFlS5YOG+DAo9Za6XZIgGELeWEMZSVr1
	 xfWTcdOSFokDIkHdPKJ2HgqDvYeoXl1BG3mLthOP/3WSUCov/W04sQWJu7T+IYtI3n
	 YAfDRPn+xbRNYwIWQnyu5kxQu5sdft67zjTCVDJL0rEyZcw83L1ITb8m862JABqxGG
	 pTKqMADLBVZy7MmkEq2ozn9d/jROIl1aLMCeDMKWBFDpqBicM4vrMgomjBFJIU5f0R
	 z17YV58pKWWGg==
Date: Mon, 8 Jun 2026 13:46:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/12] dpaa2-switch: add support for LAG
 offload
Message-ID: <20260608134620.3ff18124@kernel.org>
In-Reply-To: <20260608134533.1c913041@kernel.org>
References: <20260603143623.3712024-3-ioana.ciornei@nxp.com>
	<20260606021047.4124576-1-kuba@kernel.org>
	<7qgoy4ksmvswiaikzjzgiribtglsftmu3nfzhyem2uom5va63s@w4ruzw4fzzba>
	<20260608134533.1c913041@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296718-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67D9C65A860

On Mon, 8 Jun 2026 13:45:33 -0700 Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 12:14:07 +0300 Ioana Ciornei wrote:
> > Please let me know how I should proceed.  
> 
> TBH I saw ~30 bugs and assumed that at least one of them must be real.
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com
> and
> https://sashiko.dev/#/patchset/20260603143623.3712024-2-ioana.ciornei@nxp.com
> 
> LMK if all are actually false positives. If not just ignore the silly
> ones. 

Well, I say "just ignore" - sometimes the AI being confused means that
code is hard to understand, even for humans. So I should have say
"exercise some judgment", I guess.

