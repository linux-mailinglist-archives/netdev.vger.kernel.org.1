Return-Path: <netdev+bounces-92614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B18B81AB
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68921C21CFF
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E521A0AF0;
	Tue, 30 Apr 2024 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E0HmGlJJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37342F9D6
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510701; cv=none; b=pD1xPkf040Zlc42hp9YfTERC8mylmZgmDQOPjIyuC68UPmUlx8KAFvbGznL+Ox106DwjE05LZp/HIB2n21gwXhtWYMBhFnN8gGPPQUR2S7vFqpN/0yJhHpyvNxfxWU/MwC3r9vWPV8vOdCRMKLJoOiDPpv7XbdSySNHC+G5M6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510701; c=relaxed/simple;
	bh=z8XC2flYkdhbFz5hu7SXEjyyLoN0Ve9t2EZ6PngZsHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvCmGwNdorABYj6Te//pLojEAYfiSoWY/TP+2gSeJ1FdSyZF2/SQmATGPFJu6a9BQj/EWhiIGrij7GJYPs6LNh9C0RWHBvxY3FlTnbS5bsU38vpg+xEpGb6DpD7E99eMRYKgxPcDSHUPLB6b7YaKtrGOTSyJT8nC207e9HlGQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E0HmGlJJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i9Xt/h20JUARTLQqDjiRuSQgrh0323nH5Vk3X0J2Xg8=; b=E0HmGlJJlfH3lW42ii87IwXtAk
	/JMb3ho9pmecUNMuowcmfXnZ55WBKzpqhyVsDCzQqxTYzkkll5VUfwmikZBA/CkkATSeku00IIegh
	ilDF30ebsfAvOOYfMtalWcxWsYesVCek83ZFmBe7NGHZRi8dXJzsq23D5P72c3hrv23M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1uYL-00ENwW-9C; Tue, 30 Apr 2024 22:58:17 +0200
Date: Tue, 30 Apr 2024 22:58:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v3 6/6] net: tn40xx: add PHYLIB support
Message-ID: <9ec24d8f-62c4-4894-866a-b4ac448aaa9b@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
 <20240429043827.44407-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429043827.44407-7-fujita.tomonori@gmail.com>

On Mon, Apr 29, 2024 at 01:38:27PM +0900, FUJITA Tomonori wrote:
> This patch adds supports for multiple PHY hardware with PHYLIB. The
> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
> 
> For now, the PCI ID table of this driver enables adapters using only
> QT2025 PHY. I've tested this driver and the QT2025 PHY driver with
> Edimax EN-9320 10G adapter.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/ethernet/tehuti/Kconfig    |  2 +
>  drivers/net/ethernet/tehuti/Makefile   |  2 +-
>  drivers/net/ethernet/tehuti/tn40.c     | 34 +++++++++++---
>  drivers/net/ethernet/tehuti/tn40.h     |  7 +++
>  drivers/net/ethernet/tehuti/tn40_phy.c | 61 ++++++++++++++++++++++++++
>  5 files changed, 99 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
> 
> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
> index 4198fd59e42e..94fda9fd4cc0 100644
> --- a/drivers/net/ethernet/tehuti/Kconfig
> +++ b/drivers/net/ethernet/tehuti/Kconfig
> @@ -27,6 +27,8 @@ config TEHUTI_TN40
>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
>  	depends on PCI
>  	select FW_LOADER
> +	select PHYLIB
> +	select PHYLINK

You don't need both. PHYLINK will pull in PHYLIB.

> @@ -1179,21 +1179,25 @@ static void tn40_link_changed(struct tn40_priv *priv)
>  	u32 link = tn40_read_reg(priv,
>  				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>  	if (!link) {
> -		if (netif_carrier_ok(priv->ndev) && priv->link)
> +		if (netif_carrier_ok(priv->ndev) && priv->link) {
>  			netif_stop_queue(priv->ndev);
> +			phylink_mac_change(priv->phylink, false);
> +		}
>  
>  		priv->link = 0;
>  		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
>  			/* MAC reset */
>  			tn40_set_link_speed(priv, 0);
> +			tn40_set_link_speed(priv, priv->phydev->speed);

You should not be references priv->phydev if you are using
phylink. When phylink is managing an SFP, there might not be a phydev.
phylink will tell you the speed when it calls your tn40_mac_config()
callback.

I suggest you read the documentation in include/linux/phylink.h
because this is very wrong.

	Andrew

