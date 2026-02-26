Return-Path: <netdev+bounces-261325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN3uG1U7oGmagwQAu9opvQ
	(envelope-from <netdev+bounces-261325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:23:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8CD1A5A7E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B085D306506A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517633C53B;
	Thu, 26 Feb 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTT8yzxw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC94299920;
	Thu, 26 Feb 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108626; cv=none; b=syTW3CydP3nT7hGMDAHvGKLLzgc8iKkrrlL4smtUx4ThXu8Rl+CmWevXIHRpGt/dBQ1rTOYWEKX6slBUqRdwxg/mve8BFDxHZ5ICYmCNuzj8wSODIrZd3oA/H86wFeOKXAGNjZuJlIqA5r34QQz0mxWJpnumFWpP5GHgOUjP2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108626; c=relaxed/simple;
	bh=EHuyXiIbamgacSccW1uh8ZqqgH4yrLHuCBJoewXcNTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBafHVFoWYHzAbTPlV9R/75HuLjUGFEC5s5kOpzdZlF0cshSOOZ1KSlBzL9+21e+p1UA0b0tTRsCgGokL44DNMcIDOZ6mSUYqPPDRWD4zYfC4NFTi3YFIbvi5uPw1UutL9evC7nxMr8aKVDLkLJWwFEFnTFW0DDVTzIQ4FB1Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTT8yzxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33844C116C6;
	Thu, 26 Feb 2026 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772108625;
	bh=EHuyXiIbamgacSccW1uh8ZqqgH4yrLHuCBJoewXcNTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTT8yzxwwJj9obaOQMUuKVdckkw6dYpzRbZkm2AwMvDEb30cTjLqQY7EzffDxq3ZR
	 awoxUro543SWIBYXQuDPIdHDepA/YIVd6DJyfyswI2TqsPmGG/0EveaWbY03UBP7Wu
	 /W41twqYQJh6xgI3XuHJB4+k8oT/li0Tm2XL0qIIVJLagUo2lnVcSgBQNntCGjqRZI
	 m2eZi7TdEgH3arwOsPCoFr8fYuktadtr2hNOHL1RFJ3sqDqqBsUCWS/9rBdheQz/Zb
	 iws+xGLxcFqGN80yVGhKeKFVEOmHJlozOZ4IfAFEXckTD8Le8nfF2zGYcTpbFdzMpU
	 AL4BqWWTFgICg==
Date: Thu, 26 Feb 2026 12:23:41 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"maintainer:OCELOT ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: felix: use kmalloc_flex helper
Message-ID: <aaA7TcdhXQPa_Y1U@horms.kernel.org>
References: <20260225040323.69497-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225040323.69497-1-rosenp@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: BD8CD1A5A7E
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:03:23PM -0800, Rosen Penev wrote:
> A little simpler than using a separate size variable.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/dsa/ocelot/felix_vsc9959.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
> index 8387dd208adb..cb132679fd99 100644
> --- a/drivers/net/dsa/ocelot/felix_vsc9959.c
> +++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
> @@ -2254,7 +2254,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
>  	struct felix_stream_gate *sgi;
>  	struct ocelot_psfp_list *psfp;
>  	struct ocelot_policer pol;
> -	int ret, i, size;
> +	int ret, i;
>  	u64 rate, burst;
>  	u32 index;
>  
> @@ -2271,8 +2271,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
>  	flow_action_for_each(i, a, &f->rule->action) {
>  		switch (a->id) {
>  		case FLOW_ACTION_GATE:
> -			size = struct_size(sgi, entries, a->gate.num_entries);
> -			sgi = kzalloc(size, GFP_KERNEL);
> +			sgi = kzalloc_flex(*sgi, entries, a->gate.num_entries, GFP_KERNEL);

Hi Rosen,

This line is now too long; Kernel code still prefers code to be 80
columns wide or less.

To be honest, I think the improvement here is marginal.
And I lean towards the rule about cleanups applying here.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing checkpatch.pl warnings
  * Addressing Local variable ordering issues
  * Conversions to device-managed APIs (devm_ helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr

