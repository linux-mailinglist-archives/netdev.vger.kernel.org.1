Return-Path: <netdev+bounces-260544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL/KDZGsnWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:50:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3FE188000
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29AFB30E995C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC8439E6F7;
	Tue, 24 Feb 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nyZqpTg9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61639E6E9;
	Tue, 24 Feb 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940124; cv=none; b=h+Cwm89zIfMS01qKsD3nasWonhGB0ZEEPQMZTHbvgElWwZQDlUlXRJv3Hw5ZIUgcRrxPfEFL0QygN8luiiwjO2kPfgUdQK+ltOvf3Y0E7TzjncfXBDtc+mfn6uI/bVAhzRpH2fwktaO2iYwxoXjf09fwuMI7zYLcubyySvW2IZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940124; c=relaxed/simple;
	bh=6Hym5RA+UBgpjOdrDv4aQcJ1KEmhz2ZuEJgu12PwmGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZYsEmHtYtx043bb7Au1TsyorrqDMVMzEvj4gaDpmfBxJrH4BNalNviqWObhrNu3/db51wPRae7/nccsRNhbemVqqxAZ38ChMUXGqGc53T/Y8VAsbjQczs3JXly6Xead2q68vG8FvES0FUJM+d2/cwDPt7vRC2oz2+r9Nk39100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nyZqpTg9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AfqC3RCbaeXmI3EGBYL7wbJk6CjvN12abAAIxhNiZvs=; b=nyZqpTg9s21au/3eITtMN6BwvO
	Wln/sSsRw2g9vsqQrQJaLH4NxvPggZR9hZUdJt9oeMXrFypOQIbC3UrvKt03LiRMX4hxK+BC6I3ac
	Wo05LPEg3ijPdS9dFX5iaUCaJ900I8sTcKSOgT3q288IBQ0AngaiYVaJEf1WiuqGqKJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vusZE-008bqe-AW; Tue, 24 Feb 2026 14:35:12 +0100
Date: Tue, 24 Feb 2026 14:35:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: dsa: yt921x: Refactor port error
 message
Message-ID: <c9f550e7-9723-414c-b60a-13573cf9f835@lunn.ch>
References: <20260224112411.1561917-1-mmyangfl@gmail.com>
 <20260224112411.1561917-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224112411.1561917-2-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260544-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 5E3FE188000
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:24:05PM +0800, David Yang wrote:
> Sometimes we might get error from the underlying bus, but the return
> type of the function is void, so an error message is desired here. There
> are many instances of the same pattern, refactor it.
>  
> +static void
> +print_port_err(const struct device *dev, int port, int res, const char *action)

Please use the prefix yt921x_.

> +{
> +	dev_err(dev, "Failed to %s port %d: %i\n", action, port, res);
> +}
> +
>  static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
>  {
>  	WARN_ON(!mutex_is_locked(&priv->reg_lock));
> @@ -721,8 +727,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			mib->tx_jumbo;
>  
>  	if (res)
> -		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> -			port, res);
> +		print_port_err(dev, port, res, "read stats for");

The thing about dev_err() is that everybody knows what it does. What
does print_port_err() do? yt921x_port_dev_err() would at least give a
better idea what it does, but being so long, do you actually save
anything?

So i don't know if this patch is actually useful.

   Andrew

