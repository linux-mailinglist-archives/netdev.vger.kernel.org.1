Return-Path: <netdev+bounces-301842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JVQeHfyTPGpQpggAu9opvQ
	(envelope-from <netdev+bounces-301842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:35:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A966C2682
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:35:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Eg4rQ8/9";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301842-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12F4E3004426
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7592F691D;
	Thu, 25 Jun 2026 02:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9B2C0F7F;
	Thu, 25 Jun 2026 02:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354934; cv=none; b=A/dEYMefD155r3fJ2OhMgD/lpk+zeAOImOd51B9IbjNZxSUS5NM6uqz/HcYorvgt1+So1gK+YES8aRnH+4A8Y+88Usks6nYiNPCTcFwGp7Y8ATl+awl6XUEhLl4DYeFiJX2Xu4TcQcy7nSGr9xDCYTpqSbUIG4iTgCTgxx7mtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354934; c=relaxed/simple;
	bh=Tx/nABsS6Bk0T4AsscFUEDdFzZ9oI4CKHnYX+q/rf9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taHl+HCBQn+ySmYYtuAcvpNI2HPTd/6bL3y+22+hYHQcpOMdXChq+kCkwM8xy6hxQV6nlOmv/yfUZpyQsFXFeraufo3cbpyrU43jKlB+L2XsIrjG82ex7LCTzB9ERneZwjbTp5Q3kKh+El1L86o0QvQIZ/CfkFKyklW8wRB8/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg4rQ8/9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444041F000E9;
	Thu, 25 Jun 2026 02:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354933;
	bh=5W/I/MnZpjgwv9HbFL2VX4INISjg2IA5aSi2PVZHso4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Eg4rQ8/9/BedKzweZfHM1LL4Ifxid/js3v+bbQ2ZVL7/AvIgq/8prRPjIEz2jm52C
	 pwrFMGn8x5W/KxnX5aUi95giPFtkzRnJ7/TwXmocp9Jc1EgvoM1e0UtKFvn1J3+dpD
	 aPt3LzpQuUKatMobwSlhIDXYyd9NHN9u+gpLrd86dp9v4pC3mJacdQde4l91KTiCbp
	 GSVSrta+XaY642rYKWDsjK1hQ8Lx6zdsFOzMhcIb4X4uSSYvBGS6ZCNrgtfeCzXg6z
	 ClDcbILSNwLUkSjFxIzvbUMO1S+aMQzJEwJtk4CkI2dSzn3NDspD0JdsrVXCHabicb
	 MP5qWujiPRkcQ==
Date: Wed, 24 Jun 2026 19:35:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v3 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
Message-ID: <20260624193532.64caeb52@kernel.org>
In-Reply-To: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301842-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shital.gandhi45@gmail.com,m:wellslutw@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,m:shitalgandhi45@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9A966C2682

On Tue, 23 Jun 2026 12:11:41 +0530 Shitalkumar Gandhi wrote:
> Shitalkumar Gandhi (2):
>   net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
>   net: ethernet: sunplus: spl2sw: fix multiple of_node refcount leaks in
>     probe

Only the first patch reached the list

