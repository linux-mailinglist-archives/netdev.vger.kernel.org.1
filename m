Return-Path: <netdev+bounces-272611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMS8Em2mxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:46:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A8346F7E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E7DF305462B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC0832B9A9;
	Fri, 27 Mar 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HeH0pLMO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45033507D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626271; cv=none; b=mRd05pXPH0tTCo4+KelV3IteD9WHdq5eyWl9z0zlXZNm4UZhAVxaRJilekPqW01//a6VP/xsaYYHYgu+k1rHOYQt8LxDBmVapfvTv62tnRPV3fErt2m1uJdEWpA5pGXZQoYu/+UAHr4L8WW61O4QvGRTaip+t+uuEdAz0j281RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626271; c=relaxed/simple;
	bh=hr20azAfkG/KGfNTiUk0vQdktjEjZJ8MghEuwkPjOKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6t89uQ+jHCaKr7MAGoQ9UGtizwyq3IwcZEAQltFFP0mDW5NzR94BYbVZv7sIqnm91OLmsqTF3ROpgim9ptlgbG6EDarts7CTcZ22ZHut4iexSJV5lvyDwHzAWM0lpNJNe2Zw636zyl22VmeukdPTqH2We0KmlYNwmncmtk1Eh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HeH0pLMO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F1EFC5874C;
	Fri, 27 Mar 2026 15:44:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D2FF60230;
	Fri, 27 Mar 2026 15:44:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8964710451311;
	Fri, 27 Mar 2026 16:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774626266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FE2lV+kdQhgdA28oqU4nLqQZ2XB6nN171v2auESGnWc=;
	b=HeH0pLMOPxj1J5mtAASxS4h/ZdUhVIt9OlXPSz1aAA6U0+kVI+A1/X/JpwdPeLjYThuPRx
	EzT5KFAEbVy2oCiUrfJ9UgrtcmOsd2JjtKwywGG5WI5xbRRlnNwmjVFTTCFhTCFhbm96cc
	iwFJwbQWmXsHhPYlfxeIFEj8buf75l5ISmvbzBbqHKP1yH3gyUafIcS/z8XR+9kFlMlnP3
	9OfiEqvwRh9JINLhE42Gjg4Dl1yTusf7YO2Db+uhjs9wkZaW1ED5Z2olqj8FUo6AGNRymr
	VflWni1J2MNiBTReuckTeI35geCKdQiDqAQBltbPHdYEaecWXFDgjiuk7FOQpA==
Message-ID: <a5d7aedb-9770-492f-b528-0a28a652279b@bootlin.com>
Date: Fri, 27 Mar 2026 16:44:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: allow PHYs to be attached in
 802.3z inband mode
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>
References: <E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272611-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F2A8346F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,

On 27/03/2026 13:56, Russell King (Oracle) wrote:
> Now that we have proper decision making for inband mode support which
> makes it a "best efforts" feature based on the capabilities of the PHY
> and PCS, we can relax whether we expect and permit a PHY to be
> attached. This is especially true for the 2500BASE-X case which some
> PHYs use without inband on their host side interface for 2.5G speeds,
> but use inband for slower speeds switching to SGMII on their host side
> interface.
> 
> We already have such a case for some qcom-ethqos setups, although
> qcom-ethqos overrides phylink's inband settings by accessing the PCS
> directly at the moment. This should allow qcom-ethqos to transition to
> defaulting to inband when 2500BASE-X or SGMII is specified in its DTS.
> 
> Allow PHYs to be attached when inband mode has been specified, which
> will be necessary to allow inband mode to be used on qcom-ethqos.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 087ac63f9193..1c178038e6f1 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1965,9 +1965,7 @@ EXPORT_SYMBOL_GPL(phylink_destroy);
>   */
>  bool phylink_expects_phy(struct phylink *pl)
>  {
> -	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
> -	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
> -	     phy_interface_mode_is_8023z(pl->link_interface)))
> +	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
>  		return false;
>  	return true;
>  }
> @@ -2206,9 +2204,7 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
>  {
>  	u32 flags = 0;
>  
> -	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
> -		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
> -		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
> +	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
>  		return -EINVAL;
>  
>  	if (pl->phydev)

So I've tested that on my socfpga setup, and I now get this when trying to
bring an interface attached to an SFP up :

  socfpga-dwmac ff702000.ethernet eth1: no phy found

This wasn't showing before because our DT has :

  &gmac1 {
    status = "okay";
    phy-mode = "1000base-x";
    managed = "in-band-status";
    sfp = <&sfp>;
  };

It used to kinda work because the problem was hidden with the use of "1000base-x"
as the PHY mode.

Now with this patch, using "sgmii" or "1000base-x" as the phy-mode doesn't
do any difference, as expected.

The real issue IMO is rather how stmmac_init_phy() behaves, it's guarded by:

  if (!phylink_expects_phy(priv->phylink))
          return 0;

and then tries to find a PHY, failing if there's none. We should probably add
an extra check there to say "if we have a PCS, then it's OK not to have a PHY" ?

Thanks,

Maxime

