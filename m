Return-Path: <netdev+bounces-306566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HsiNL8z2UGqP9AIAu9opvQ
	(envelope-from <netdev+bounces-306566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:42:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D65273B5C8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:42:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ks2hJ785;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306566-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306566-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99F9C306D279
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7F142CB0F;
	Fri, 10 Jul 2026 13:39:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376839447C;
	Fri, 10 Jul 2026 13:39:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690788; cv=none; b=Heab8t3NnJtyBSsRNVOa61puk/5zqHyzXOUtbOuTz4+e/GAcpeoVrjfk03B6V4lwuM1BDBpN7LG7gy5OzaBj6i0P4LpN6nK3zBiUJTrMhuRdd4leSjUUkQwRfjfOpTd/0JeL6/unt9R/BJBmL6L6XhoTjo5uzmtHm5X705PnrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690788; c=relaxed/simple;
	bh=U1osheBkR0qMcdG6foeF8K2Ci79hW0vB7TWSWhYAMDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxvQQ3a0IOgXgfR7CjCpFY2CNT7sJgYNILonMjMdun04nAPAs6jorDD3837m0Hx98wAOSsoDwABQihAMNk/e3s/2qaIQEAO/D3y4jAzR3L14TwsZMN1MLnIh1bwpHNelhK60sUPNinl12Oqk+iCPSwhjK9i50BRrUxf4PbdSylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks2hJ785; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597231F000E9;
	Fri, 10 Jul 2026 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783690784;
	bh=Oeaa/6RUweGl7eBicaOJM+p8cWmF6TN7RJD2zBAq1tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ks2hJ785F5mpUypZtVJYcwbuih2GWNXjCWTwZ4aThY9X/9GxFRYdV5N48ort1/IFu
	 h0GsRoZDPhwsb+js+vg8BJiQJRDNipxJCvrg9Z5J9O1ecGVRB2jsrJDFeQt6BNEcHA
	 48u+izeZ+7H5OZJsLUw511PrWXISuVkWCU/nMqkoItuZp/qavYcRJqOp08CycrdRvL
	 F29TzG8FCuUUjhNBZ4xpoF5xxbGWFV8mrq8TmcOLXnJ5Dq33VJJumxZSRcIaQJ+mDB
	 XSpC6tQiNIBdr+pgurb5XY1PfUQS5BdkRhr2SoilUGF2llsaVixyf+6YtqrtR/0r2R
	 pEZUNkxCBDdmw==
Date: Fri, 10 Jul 2026 14:39:39 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: gianfar: fix use-after-free in gfar_enet_open on
 startup_gfar failure
Message-ID: <20260710133939.GY1364329@horms.kernel.org>
References: <20260704234734.1779991-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704234734.1779991-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306566-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D65273B5C8

On Sat, Jul 04, 2026 at 04:47:34PM -0700, Rosen Penev wrote:
> If startup_gfar() fails in gfar_enet_open(), the PHY remains connected
> and IRQs remain requested. Since ndo_open returned an error, IFF_UP is
> not set and ndo_stop (gfar_close) will not be called on unregister,
> leaving the IRQ handlers registered against freed net_device memory
> when the driver is removed.
> 
> Add proper error unwinding: phy_disconnect() and gfar_free_irq() before
> returning the error.
> 
> Fixes: 80ec396cb6b5 ("gianfar: Don't free/request irqs on device reset")
> 

nit: no blank line here

> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 89215e1ddc2d..4b3a5eaadfb5 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -2878,8 +2878,11 @@ static int gfar_enet_open(struct net_device *dev)
>  		return err;
>  
>  	err = startup_gfar(dev);
> -	if (err)
> +	if (err) {
> +		phy_disconnect(dev->phydev);
> +		gfar_free_irq(priv);
>  		return err;
> +	}
>  
>  	return err;
>  }

The AI-generated review on https://netdev-ai.bots.linux.dev/sashiko/ has
the following to say. I'd suggest addressing this using a more
comprehensive patch that makes use of an idiomatic goto ladder to unwind on
error.

  Should the gfar_request_irq() failure path also disconnect the PHY?
  Looking at gfar_enet_open() after this patch:
      err = init_phy(dev);
      if (err)
          return err;
      err = gfar_request_irq(priv);
      if (err)
          return err;
      err = startup_gfar(dev);
      if (err) {
          phy_disconnect(dev->phydev);
          gfar_free_irq(priv);
          return err;
      }
  init_phy() calls of_phy_connect(), which installs the driver's
  adjust_link callback (holding a net_device pointer) into the phy_device.
  If gfar_request_irq() then fails, the function returns without calling
  phy_disconnect().
  Since ndo_open returned an error, IFF_UP is not set and gfar_close()
  will not be called by unregister_netdev(). When the driver is later
  removed (gfar_remove -> unregister_netdev -> free_gfar_dev), the
  net_device is freed while the phy_device still holds a reference to
  it via adjust_link, which is the same use-after-free scenario the
  commit message describes.
  This pre-existed the patch, but since the changelog says it fixes the
  failure of gfar_enet_open() leaving stale references, would it make
  sense to also add phy_disconnect(dev->phydev) to the gfar_request_irq()
  error path, e.g.:
      err = gfar_request_irq(priv);
      if (err) {
          phy_disconnect(dev->phydev);
          return err;
      }

