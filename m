Return-Path: <netdev+bounces-304270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5HaDWvNRmpodwsAu9opvQ
	(envelope-from <netdev+bounces-304270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:43:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D56FCC91
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:43:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=KIn0SrjD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304270-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304270-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F85030056E4
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EBD38D6B8;
	Thu,  2 Jul 2026 20:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D801433E74;
	Thu,  2 Jul 2026 20:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024992; cv=none; b=k7C118m1TequN+N30F5dh4MeBJTCqROoM4PLuw0FiI7vmBszN5eG7ZYvFA5+dqERpMs75rl3uS4ewVW+htnw96Y1Ykx2CDqR5s8m6n4wyk48uVtMR8EF8tG7816xmqHOP0nJvJBfLUVTggf9e9ywSrs74aBs+3iki9w2uh0dCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024992; c=relaxed/simple;
	bh=2z9E1TaermI6oB6YCmVVw6+0GKLKmoenV71vgTpEZPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0UzkbYQIcpWOjUiwBGh6YpwMM1Ba1CTTUlqDxTGp0QHcT9PxU1hJXmtWmeN0+7QfO+yxfnCckRCsExpCkUVa/ck5CALurBlRpoNQK0lgM6DTaLhDG5WB5SPUC0aVs39t4Cb3lzLS6NkHWHTj3C3ZzBJphnrlGRQA7lK9yIe7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KIn0SrjD; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0XnzerovzKYsbDQGBTbWNWVrTwreF16VtzdO22UwIsE=; b=KIn0SrjDx9KCuzPPsEBmJiGrzy
	QZp6u/nKSNBTK3WhDzpm3MIsg48inh3lIL8JnMfTp5Q6qoBAdYHR2JDdY6kwtPbFwrPHpt5onCT/U
	0utU269xOOYV+QTHoE4n/oeOpFEjhw5xh2QOyWKjnDZquWiwxN+a/sMLJh2yOx7ZbHG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfOFV-00AR77-1n; Thu, 02 Jul 2026 22:43:05 +0200
Date: Thu, 2 Jul 2026 22:43:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next] net: dsa: qca8k: fall back to ethernet-ports
 node name for LEDs
Message-ID: <c34ea180-dd91-4ed7-a3fc-49dd66381a40@lunn.ch>
References: <20260630015137.1591152-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630015137.1591152-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304270-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 304D56FCC91

On Mon, Jun 29, 2026 at 06:51:37PM -0700, Rosen Penev wrote:
> The device tree binding allows both "ports" and "ethernet-ports" as
> the container node name.  Try "ethernet-ports" when "ports" is absent
> so that newer DTBs with the preferred name work.
> 
> This matches the handling already present in qca8k-8xxx.c
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

