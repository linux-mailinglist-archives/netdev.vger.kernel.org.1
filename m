Return-Path: <netdev+bounces-299481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CtMOEbcJMGojMQUAu9opvQ
	(envelope-from <netdev+bounces-299481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9D6870A2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:18:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fRM3ZYbc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299481-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299481-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22970300F614
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A03F9A05;
	Mon, 15 Jun 2026 14:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3763FA5CA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:17:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533037; cv=none; b=l4u407rSoJNS/6D26qEt/lLKg7GUaxRvHxWnO6L+mrjaFSoHPRtqef6PRYLHCD2V8AIbFEOhk5LcUQQGlM9TJEmucQXDYc6ZoMLH5+h0mOUwFgdf+xeu+OzeELb2aeQYzeM4sPCw5Vl3ypTsHeZzdPdNfWYMUS8Wn+dXRCiBXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533037; c=relaxed/simple;
	bh=f61WmIx+hm1+/2AxbT2xxwh9RLHb5jUbD7RVIZwXnTc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/4HZTo74FEvsqVNapD3DGAVx2alnD/3idsFSDxcvyZtxKeiIBW/XXwdObWlgHuq+6tee9VFXYwvih/qB/NKmfpiy40eLfwP5Mdv7OimwJtbHULJ53iYNpNAyWPiJXWw/v69myPMUpeWYbbtFyIcvAGx2/l/fYNOiFXgIqy8B/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRM3ZYbc; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eec22fab7so1463830f8f.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533033; x=1782137833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3UfvMLnftnG86sZpVtOaAoiC3x6zQGxcuXN2h4bzNvU=;
        b=fRM3ZYbc5XZjO0nKw/n7qCYVQ8jMPJvJP85xsUUmwejv5hUANR/p+w4Y7dzp/0zkV3
         zNfbC3EtZb1qrTaOz6ffjxqqYIrOAl3M2eBOWYOdN22rGxx5IrfEWiz4qeRAnPn6uhaF
         3knCgmMxJ9cbQfNlQ0j1JbwKWJDrIdV/7q10mM6gHEUj9/xJ+YtEjaLXq50U110RCJuY
         F4uiZdy31X9Jtza0vif4t3OZ15e1LlGD7c5ioo3JMKoIMt0ix5L//eQG/4FhfwO3bIY+
         F+VInyMYjodBMNorM7kvPGWyDNm5DEeAvltDXumLQqzrXSfTg+CwDF2WkHO4fmnhJx+9
         Mfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533033; x=1782137833;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UfvMLnftnG86sZpVtOaAoiC3x6zQGxcuXN2h4bzNvU=;
        b=qFC77UDijc38I2Cz+nYfv6LOocJLsrX6hNB0JFHFXxTENDF1mNkYKsNrrwO8FJY1Kw
         xWhdPxOecgh6Mndn09aV3er8CLL53mpMvpdOHUuLjB9IxBDiXAKQjf2fxAUN3Xv0Bc6a
         OXkdl69EVb7MEwj3hN88xXjJVFiYqDZdvOsguFMTehfAmZnbMpkncfVLda5F/svTKGRh
         i5acUQE3D6/7EikI6+lh8CVYsHcuOKNSVnLbqmaQ1aJSoEVJIdFd/IXlPtN5bNLefzm6
         sfUhZ5AJF/e9NvigAibiWJMa2vpZLftbRgl5TDga9q7gxrCoM/a6OXE4YrNLnY9Sfi9r
         iBrw==
X-Forwarded-Encrypted: i=1; AFNElJ9Uz18bL9zNqIrZUdiXMVPDziakVCESnY5JdXOHK62HljeBc7fZYnwd6FahEbJ6+WNr9Q2RWCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUt9KBkMfXq8cm+YQKWLDcabwoSRAIE7lJSU9zBQnEsnuhsN3M
	8byMlcQ1jtabs/Dj9OkH/Dj79YnZpvULpzilqu/xBieNFbniVrQ8zShK
X-Gm-Gg: Acq92OEywHEojx5yW6c0yGYS1c+qlA3/3DSwj0Fshb4kuvfjO4yqfbZpy/+kY6oICiW
	KZ+MawtZPgL3x1hXkJLHlJZkXyf8rXx6W2AZscAiPObB8G272RGALWpDhd5rMLC/j9YUcRcAokw
	QOfnaCJ0abJulA8iIcvmVh9SWzzKI/WkCaVbRY/Jx91ldmFZUs8AeG2vrdSiAxeG+L5jcLFeO8c
	CpwsNhEvo98EXOvfNW7hPZdgOhYv9PGNG4iU1M+ZWlbe0NJkM29UC5iNngMDOcmtQ+KV9py6WGJ
	b7SpEa9rWfD6wVGfMTSCdZ/ZMen5e4tRz2OIDMmN/HYU3u0z1/8KOD5DGCfuwdUFub2V335EaRx
	Lr8s5uic4CU/NsSUft0R5qGrpSzNThbEorf+TlT7AFjAFXmk42VUEC+b5Z1ZCu532VklcIDtH/U
	XKAgszN8BQWFEScpgUja8lPJg3tXmRDRc6cL3aVBVmqun1wv6AmW2VBg==
X-Received: by 2002:a5d:5e8c:0:b0:460:51f6:6248 with SMTP id ffacd0b85a97d-4606dbc695bmr19385571f8f.27.1781533032304;
        Mon, 15 Jun 2026 07:17:12 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263923sm35293507f8f.2.2026.06.15.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:17:11 -0700 (PDT)
Message-ID: <6a300967.379593d1.36e868.4f67@mx.google.com>
X-Google-Original-Message-ID: <ajAJY92mipEgxdlA@Ansuel-XPS.>
Date: Mon, 15 Jun 2026 16:17:07 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v7 02/12] net: phylink: introduce internal
 phylink PCS handling
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-3-ansuelsmth@gmail.com>
 <3bbacda3-4225-4536-a4b4-3aa31a47a3aa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbacda3-4225-4536-a4b4-3aa31a47a3aa@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299481-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31A9D6870A2

On Mon, Jun 15, 2026 at 03:31:20PM +0200, Maxime Chevallier wrote:
> Hi Christian,
> 
> On 6/15/26 14:29, Christian Marangi wrote:
> > Introduce internal handling of PCS for phylink. This is an alternative
> > way to .mac_select_pcs that moves the selection logic of the PCS entirely
> > to phylink with the usage of the supported_interface value in the PCS
> > struct.
> > 
> > MAC should now provide a callback to fill the available PCS in
> > phylink_config in .fill_available_pcs and fill the .num_possible_pcs with
> > the number of elements in the array. MAC should also define a new bitmap,
> > pcs_interfaces, in phylink_config to define for what interface mode a
> > dedicated PCS is required.
> > 
> > On phylink_create(), an array of PCS pointer is allocated of size
> > .num_possible_pcs from phylink_config and .fill_available_pcs from
> > phylink_config is called passing as args the just allocated array and
> > the number of possible element in it.
> > 
> > MAC will fill this passed array with all the available PCS.
> > 
> > This array is then parsed and a linked list of PCS is created based on
> > the allocated PCS array filled by MAC via .fill_available_pcs().
> > 
> > Every PCS in phylink PCS list gets then linked to the phylink instance
> > by setting the phylink value in phylink_pcs struct to the phylink instance.
> > Also the supported_interface value in phylink struct is updated with
> > the new supported_interface from the provided PCS.
> > 
> > On phylink_destroy(), every PCS in phylink PCS list is unlinked from the
> > phylink instance by setting the phylink value in phylink_pcs struct to NULL
> > and removed from the PCS list.
> > 
> > phylink_validate_mac_and_pcs(), phylink_major_config() and
> > phylink_inband_caps() are updated to support this new implementation
> > with the PCS list stored in phylink.
> > 
> > They will make use of phylink_validate_pcs_interface() that will loop
> > for every PCS in the phylink PCS available list and find one that supports
> > the passed interface.
> > 
> > phylink_validate_pcs_interface() applies the same logic of .mac_select_pcs
> > where if a supported_interface value is not set for the PCS struct, then
> > it's assumed every interface is supported.
> > 
> > A MAC is required to implement either a .mac_select_pcs or make use of
> > the PCS list implementation. Implementing both will result in a fail
> > on phylink_create().
> > 
> > A MAC defining .num_possible_pcs in phylink_config MUST also define a
> > .fill_available_pcs or phylink_create() will fail with an negative error.
> > 
> > phylink value in phylink_pcs struct with this implementation is used to
> > track from PCS side when it's attached to a phylink instance. PCS driver
> > will make use of this information to correctly detach from a phylink
> > instance if needed.
> > 
> > phylink_pcs_change() is also changed to verify that the PCS that triggered
> > a link change is the one that is currently used by the phylink instance.
> > 
> > The .mac_select_pcs implementation is not changed but it's expected that
> > every MAC driver migrates to the new implementation to later deprecate
> > and remove .mac_select_pcs.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> 
> [...]
> 
> > @@ -1872,10 +1993,28 @@ struct phylink *phylink_create(struct phylink_config *config,
> >  	mutex_init(&pl->phydev_mutex);
> >  	mutex_init(&pl->state_mutex);
> >  	INIT_WORK(&pl->resolve, phylink_resolve);
> > +	INIT_LIST_HEAD(&pl->pcs_list);
> > +
> > +	/* Fill the PCS list with available PCS from phylink config */
> > +	ret = phylink_fill_available_pcs(pl, config);
> > +	if (ret < 0) {
> > +		kfree(pl);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	/* Link available PCS to phylink */
> > +	list_for_each_entry(pcs, &pl->pcs_list, list)
> > +		pcs->phylink = pl;
> >  
> >  	phy_interface_copy(pl->supported_interfaces,
> >  			   config->supported_interfaces);
> >  
> > +	/* Update supported interfaces */
> > +	list_for_each_entry(pcs, &pl->pcs_list, list)
> > +		phy_interface_or(pl->supported_interfaces,
> > +				 pl->supported_interfaces,
> > +				 pcs->supported_interfaces);
> > +
> 
> I'm not entirely sure about that, we may need to restrict the supported_interfaces
> from the MAC.
> 
> As an example, take mvpp2. We have 2 PCSs, one for BaseX/SGMII, one for BaseR. But
> if we don't have a comphy (generic PHY) device, then we can't use all the
> combination of modes our PCSs can provide :
> 
> https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c#L7074
> 
> These aren't external PCS IPs, but from what I understand you'd like to
> handle these the same way as purely external PCSs, right ?
> 
> I'd say the MAC driver utltimately has the knowledge of all possible interfaces.
> 
> The way I see it, it's probably safer to let the MAC give a wide range of interfaces,
> and filter that down with what the PCSs can provide (i.e. turn that or into an and,
> while handling the case where the pcs supported interfaces is empty).
> 
> What do you think ?
>

The idea is that supported_interface is a mask of every possible interface
from MAC and PCS. Then it's phylink_validate_mac_and_pcs that actually use
that mask and validates it on both MAC and PCS.

This is why the OR was used instead of AND. The idea is to have the PCS as
external standalone entry (even if they are internal to the MAC). So each
entry should have they own set of supported mask.

The previous patch and this try to address this problem where phylink is
actually clueless of what is actually supported exactly because it's has
been given MAC too much freedom of modelling limitation internally.

I feel limitation should be handled by their dedicated function with
.pcs_validate and .mac_get_caps.

Just my idea on this, if needed it's totally ok to simplify this and let
MAC entirely handle the mask. (but I feel the current idea of phylink code
was to have a generic mask in supported_interfaces and then verify MAC and
PCS in phylink_validate_mac_and_pcs())

But by thinking on it more, following your case of mvpp2, with this new
PCS:

- You need a PCS for the .get_state.
- And such PCS will have the supported interface set 1000baseX and
  2500BaseX (as that is what is actually supported in HW)

Either some magic is done in .pcs_validate to deny changing the interface
that was initially configured or this gets limited at the
supported_interface configured by the MAC.

I need to check if this might be problematic for the other driver where
this is being used on OpenWrt but maybe changing the logic to an AND might
be sensible for these kind of case.

(for the other it shouldn't change anything)

-- 
	Ansuel

