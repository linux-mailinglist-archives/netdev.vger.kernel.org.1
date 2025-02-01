Return-Path: <netdev+bounces-161934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B242A24B6B
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAA2164680
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160991C5D73;
	Sat,  1 Feb 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bH28bz98"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04CA1BC061
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738435122; cv=none; b=ffYEPAjK9KIGq55vzqjTJbt43vfwRW0I1xatVuKyTtGw6zq9Jei9bpTTL0yrU98+pk50pwd8Sk8aoHQEU/rHywnD60u0vhiPrzRbO1h3YCu/1vuOHbg/fuMdLRWrS0GuIjQUzKBmNvWunuptpl5AcilWowgnynQbIrx8h2bze7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738435122; c=relaxed/simple;
	bh=PVKzCczrmhxsfcxdktiO2duG5dQQ7hJbZyUqOtfqeTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9Fg2q216tSQq4KAJ8gaWpXoxUiEuXxUCmo+6JyTmbDc/vvd6vgf6+klETcqQslWOqgZ5O7U++54p8YmVhfeZLpWYveVoq1TKHRswOMs1eRE6QabflPzDe8c585qF/sUyIV+kXozp9bmAYeNTD36uvh3iUtm/ZQ7dTaBUJVklm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bH28bz98; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Iff5s8N0dvZ0ESH7WeG8R6mviuRmJw1x9uc0C7d4vPg=; b=bH28bz98LS5YYmgkSxnvljmJAS
	LvkM5+qAnhBQ11mXmbRDVPYRLJpkOs69LrdnSr/BySzKRsYwWSvziFm6Fp6lFxE1UZpfcFrElR+zz
	cCXZj2z7xdpgrHLB3Ryahh8Xdvo/3ncF039cCsUd8ap3CyuGZGu5PAMORncA9MjlodcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teINu-00A2K9-63; Sat, 01 Feb 2025 19:38:26 +0100
Date: Sat, 1 Feb 2025 19:38:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] net: dsa: sja1105: Use of_get_available_child_by_name()
Message-ID: <5e4243f2-4186-4b97-b39f-3c3dad4a444b@lunn.ch>
References: <20250201164959.51643-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201164959.51643-1-biju.das.jz@bp.renesas.com>

On Sat, Feb 01, 2025 at 04:49:57PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> sja1105_mdiobus_register().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> This patch is only compile tested and depend upon[1]
> [1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
> ---
>  drivers/net/dsa/sja1105/sja1105_mdio.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
> index 84b7169f2974..d73bf5c9525b 100644
> --- a/drivers/net/dsa/sja1105/sja1105_mdio.c
> +++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
> @@ -461,24 +461,21 @@ int sja1105_mdiobus_register(struct dsa_switch *ds)
>  	struct sja1105_private *priv = ds->priv;
>  	const struct sja1105_regs *regs = priv->info->regs;
>  	struct device_node *switch_node = ds->dev->of_node;
> -	struct device_node *mdio_node;
> +	struct device_node *mdio_node _free(device_node) =
> +		of_get_available_child_by_name(switch_node, "mdios");

There is a dislike within netdev for this magical _free() thing, made
worse by it not actually calling kfree() as the name would
suggest. Pleased explicitly put the node.

    Andrew

---
pw-bot: cr

