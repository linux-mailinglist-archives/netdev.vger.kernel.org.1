Return-Path: <netdev+bounces-251474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ87BwyAcGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:28:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C569C52CA4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E98968075F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71B426ED0;
	Tue, 20 Jan 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QizNUo0g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE4426EC8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911722; cv=none; b=c/lABUq74Ba2Q6UbGo65Ze/jAjdz+q4a52LKD345QXOrYjsz6MCMpbEWejyDPYXNo4w+EVmurUFGtQnDbst8JsNlw01imTm6v2ZfrVKe6GH/JEUG8RjUr5R8l77XQXQlg0muCeR70K/45/VVZOCuAXdYpZd3DEyU5G2atMU7RSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911722; c=relaxed/simple;
	bh=gd1z3eeske3ucbvlqbmIhwXBE9gI2ckrbS69izAtAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAsdg7UWZPl4BOoOJQ43pXmu8cPrP7rQlpKiM8EcMwAXILsnOi181FivPpbtsetgL/966GTox3mjS53HUucd8vBGgm5uIIcC3jnuV7T7E+WEcX0PP5Q9BqZy3NUyEaco4IdEMPwka2DffRexiUh/00+w2atP/ZQ+5avcLO/UsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QizNUo0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4280C16AAE;
	Tue, 20 Jan 2026 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911722;
	bh=gd1z3eeske3ucbvlqbmIhwXBE9gI2ckrbS69izAtAjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QizNUo0gIkrv2Do7kitUoLMJJ5AzoJLCMYNxpuhx2T6qEVU/vRaQ1Fo88vr1nyjm7
	 SowYh284zBWHGovRFWO/19h1N37A/czadVtB43LvN0NGItRe9ghvTr36ygAVI58r87
	 5n09kT/qSEazoJrxya3CWtkl9QAxRfVbLQo3fh7kMYBOzA/rww6K5PhsOsKSnyHlre
	 dcDr8niB1oxHBVTr3d8RhY6DWoK+YBcWN/Dcv9RcWDZhUfGuRpwh/WGHx4PB3iqXjp
	 QYvSnT7Bf5i3hxoIzc9LiZJVJSJygUBREam8mBLWjpy6YtVfycQCQp8wI4+VoHpGDY
	 iav9l+V6QsZWw==
Date: Tue, 20 Jan 2026 12:21:58 +0000
From: Simon Horman <horms@kernel.org>
To: jacky_chou@aspeedtech.com
Cc: davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus
 when it exists
Message-ID: <aW9zZpb1RTuhhIqG@horms.kernel.org>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120121407.795529-1-horms@kernel.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: C569C52CA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:14:07PM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/ai-review.html
> ---
> net: ftgmac100: Always register the MDIO bus when it exists
> 
> This patch moves MDIO bus registration earlier in the probe function
> for FARADAY, AST2400, and AST2500 MACs, simplifying the code by
> registering it unconditionally when the hardware has an MDIO controller.
> 
> Note: These issues appear to be fixed later in the series by commits
> 8961daa5f2c0 ("Simplify error handling for ftgmac100_setup_mdio") and
> 046e51399f0f ("Move DT probe into a helper").
> 
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> > index f1cb5dc37919..931fdf3d07d1 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -1957,6 +1957,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
> >  		priv->txdes0_edotr_mask = BIT(15);
> >  	}
> >
> > +	if (priv->mac_id == FTGMAC100_FARADAY ||
> > +	    priv->mac_id == FTGMAC100_AST2400 ||
> > +	    priv->mac_id == FTGMAC100_AST2500) {
> > +		err = ftgmac100_setup_mdio(netdev);
> > +		if (err)
> > +			goto err_phy_connect;
> > +	}
> 
> If ftgmac100_setup_mdio() fails after of_mdiobus_register() returns an
> error, it calls mdiobus_free(priv->mii_bus) but does not set priv->mii_bus
> to NULL. The goto err_phy_connect then leads to ftgmac100_destroy_mdio()
> which checks if (!priv->mii_bus) but finds a dangling pointer, resulting
> in mdiobus_unregister() on freed memory followed by a double free.
> 
> Could this cause a use-after-free and double-free when MDIO registration
> fails? The error path in ftgmac100_setup_mdio() frees mii_bus without
> clearing the pointer, and err_phy_connect eventually calls
> ftgmac100_destroy_mdio() which operates on the stale pointer.
> 
> > +
> > +	if (np && of_get_property(np, "use-ncsi", NULL)) {
> > +		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
> > +		if (err)
> > +			goto err_setup_mdio;
> 
> Since MDIO is now set up before the NCSI probe for FARADAY/AST2400/AST2500,
> if ftgmac100_probe_ncsi() fails, the goto err_setup_mdio skips the MDIO
> cleanup at ftgmac100_destroy_mdio(). Does this leak the mii_bus allocation
> when NCSI probe fails on these MAC variants?
> 
> [ ... ]
> -- 
> pw-bot: changes-requested
> 
> This is an AI-generated review. Report issues at https://example.com

Sorry for the bogus last line here. A local configuration error on my side.
But the rest of what is above is good, IMHO.

