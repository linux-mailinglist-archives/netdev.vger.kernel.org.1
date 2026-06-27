Return-Path: <netdev+bounces-302334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vEvmFxvDP2oIYAkAu9opvQ
	(envelope-from <netdev+bounces-302334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 14:33:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C86D1EF5
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 14:33:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AgyuloEC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302334-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302334-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672053017012
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA443AE18D;
	Sat, 27 Jun 2026 12:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF939023C
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 12:33:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782563606; cv=none; b=TXhyJP2K4Dm+Nv7NGgG7VaVXUlXVH5RPWF1ldeEokuVUQwzT0DQqHpMEYUZfTrSo3ZGlr9PSkLM78faS6ia72wcRruyvvssOhnlXrovCaLYo7UP/Eu5xjcVDglWTkeXpgXUlTqT8vsDdFpvdfKLy80yj+8TEfllH/5hYB3I3iSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782563606; c=relaxed/simple;
	bh=xbxEDsydXJAiVLZ5Cf6Ao9KnDZgjCNf+AXTfOmlvxNE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzd3PCnFV0mP+Fj984zyIImLyDv1Mqpn967UJgf1m3YXWxmODOOmRpWNf1OOcxKeHkqHI69Xq04RbqSZmg1nHLoUKal1VenFnqBW3b/5R8Wx7ZL+TM1dPr/ZIdGVSef8ixFFIdbLFOjd938UvvjlREvb4lO/4bxxiEsk+jVvwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgyuloEC; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4926fe5be4bso10064585e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782563603; x=1783168403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3PtIUvxIw7trdusrNOr6fjoOoHqmRqU46S4I9pGH/As=;
        b=AgyuloECDvljj+zNbL0P+qIrINEor1sZ9+0/a9u0sgF7Dleosnhz7g+jY7RDhcH6ti
         gExi1fpzghcXdeNihRErkiGHyr/xSKc5pI7t03RIKm7Xf+Gyn46IPGP9q3+SW4fokK+B
         Ufvz9/f6O2WzYnOwdpFOOiDtcuPRNJiXef3uJUbxwoY6XMRidJNuM+Pv+t/lcffz80DX
         cr4PFnkzY0Nf0RbvzwP58Lrj05sXlXdzNyfLLFCPmtXQ+q+N/3skOSBiAdDlbGJQgCwt
         awiTfNImWQ8DU6Q446B+CtywAf2tTl4w/F5cu/2CQoBZG/5W+Mshbv0BBMPdW0WdJrN4
         D86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782563603; x=1783168403;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PtIUvxIw7trdusrNOr6fjoOoHqmRqU46S4I9pGH/As=;
        b=lm2cc7XANafqCboUOC9EVRl5bEwTMruTV56OgSvMC9XEAIWHfYVVH47HwweDbMWFwX
         bdJZrIVnUfr00DoxXg3WyoKd4vOhKmeV+s6FU9W1Sj+jLbrsjrqMgc0jZNun6SqxwV+4
         YnBFVAtak4q5PiCFjZakmdwqD0XeFZieha9OqztBFUJB8EtdZpvW9oGF8/9lr7rAmCYn
         6jujXeexC+0ZteHs/p6mlyXFwbBdCk/WE4qpF/7l3L/etfA4ynxQBx4/Q6+AfZjmJ0yM
         8Pu4GwOUzcYa+YxmEetYE3orRGDGd51y+OfjZtUH5L2V9D/4jWaNlKDAfAvb379Arp88
         DU/g==
X-Forwarded-Encrypted: i=1; AFNElJ9Ow7eaNdcQ4hJhqPBAAXjWQRBeKPV0aeI21Tf3eMVnUuJZyzpPukyp1eUBdr2s58lEFPzRkks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uRZ+rpL8ii/oKBqxPFxi7Rg5/yiMxVK38bjKNYFhJuFCOmhL
	Vezh2Qew3C15ZyY/au0SOSXWnc2cHdaZfhTpVafb7kWKWc1FLNNUL3Dp
X-Gm-Gg: AfdE7cn4BRpEi3m6RdZvPMUK5qfXwXvuk6T1V/Mn2NmDeu3xsnBkk6Q+2yFbAjYaluC
	H0544DDWkvIsOST7nmg+qa4fbt1bGhmp6/U4rUy7x1dDoYUSpjmm3ViiymUViKoFbTphZIndsA9
	lFZ2aX7yqRc8/CtvRllxgPPTKYe7h9nsgES7Iv1D6mCaW07fak0DE37qGIx5bZ8cjrUvfb8VHAM
	ZDd++W8F1fpsi6vKYcRI9KFcvsu4G0MOK6Kdg8FDbniEcQd2paYYHJGxX9gJx1QdXUfMWTRcgHH
	9w9mcN95Ixj366H6t7cam/WyUXf/dnzAVsCeShCR2NubtMJCi0gudSUDn0UHDrkm7M4RTVjaNtv
	2s75zoTGBPCZUN3IygLbjjum7iAZZL7oYyb8/Fr5TmZpazECJxzFMs9mt4CjOhnL4xce7qx56Fz
	Nt54r/iOfKdm1zFbymmvmPThpv6G1r7sCQlrUYF0/2njdD
X-Received: by 2002:a05:600c:81c5:b0:492:4ff5:fb9e with SMTP id 5b1f17b1804b1-4926fcade65mr62722535e9.37.1782563603146;
        Sat, 27 Jun 2026 05:33:23 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-89-195.ip49.fastwebnet.it. [93.34.89.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690a1a85sm271536875e9.15.2026.06.27.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 05:33:22 -0700 (PDT)
Message-ID: <6a3fc312.6161eb1e.3441bb.c0de@mx.google.com>
X-Google-Original-Message-ID: <aj_DD_djHkw7CLZ4@Ansuel-XPS.>
Date: Sat, 27 Jun 2026 14:33:19 +0200
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
Subject: Re: [RFC PATCH net-next v8 03/12] net: phylink: add
 phylink_release_pcs() to externally release a PCS
References: <20260618125752.1223-1-ansuelsmth@gmail.com>
 <20260618125752.1223-4-ansuelsmth@gmail.com>
 <a271385e-302d-45c7-a1df-aebd380b427b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a271385e-302d-45c7-a1df-aebd380b427b@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302334-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 048C86D1EF5

On Thu, Jun 25, 2026 at 04:13:14PM +0200, Maxime Chevallier wrote:
> Hello Christian,
> 
> On 6/18/26 14:57, Christian Marangi wrote:
> > Add phylink_release_pcs() to externally release a PCS from a phylink
> > instance. This can be used to handle case when a single PCS needs to be
> > removed and the phylink instance needs to be refreshed.
> > 
> > On calling phylink_release_pcs(), the PCS will be removed from the
> > phylink internal PCS list and the phylink supported_interfaces value is
> > reparsed with the remaining PCS interfaces.
> > 
> > Also a phylink resolve is triggered to handle the PCS removal.
> > 
> > The flag force_major_config is set to make phylink resolve reconfigure
> > the interface (even if it didn't change).
> > This is needed to handle the special case when the current PCS used
> > by phylink is removed and a major_config is needed to propagae the
> > configuration change. With this option enabled we also force mac_config
> > even if the PHY link is not up for the in-band case.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/phylink.c | 56 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/phylink.h   |  2 ++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index c38bcd43b8c8..064d6f5a06da 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -158,6 +158,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
> >  static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
> >  
> >  static void phylink_run_resolve(struct phylink *pl);
> > +static void phylink_link_down(struct phylink *pl);
> > +static void phylink_pcs_disable(struct phylink_pcs *pcs);
> >  
> >  /**
> >   * phylink_set_port_modes() - set the port type modes in the ethtool mask
> > @@ -918,6 +920,60 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
> >  	}
> >  }
> >  
> > +/**
> > + * phylink_release_pcs - Removes a PCS from the phylink PCS available list
> > + * @pcs: a pointer to the phylink_pcs struct to be released
> > + *
> > + * This function release a PCS from the phylink PCS available list if
> > + * actually in use. It also refreshes the supported interfaces of the
> > + * phylink instance by copying the supported interfaces from the phylink
> > + * conf and merging the supported interfaces of the remaining available PCS
> > + * in the list and trigger a resolve.
> > + */
> > +void phylink_release_pcs(struct phylink_pcs *pcs)
> > +{
> > +	struct phylink *pl;
> > +
> > +	ASSERT_RTNL();
> > +
> > +	pl = pcs->phylink;
> > +	if (!pl)
> > +		return;
> > +
> > +	mutex_lock(&pl->state_mutex);
> > +
> > +	list_del(&pcs->list);
> > +	pcs->phylink = NULL;
> > +
> > +	/*
> > +	 * Check if we are removing the PCS currently
> > +	 * in use by phylink. If this is the case, tear down
> > +	 * the link, force phylink resolve to reconfigure the
> > +	 * interface mode, disable the current PCS and set the
> > +	 * phylink PCS to NULL.
> > +	 */
> > +	if (pl->pcs == pcs) {
> > +		phylink_link_down(pl);
> > +		phylink_pcs_disable(pl->pcs);
> > +
> > +		pl->force_major_config = true;
> > +		pl->pcs = NULL;
> > +	}
> > +
> > +	mutex_unlock(&pl->state_mutex);
> > +
> > +	/* Refresh supported interfaces */
> > +	phy_interface_copy(pl->supported_interfaces,
> > +			   pl->config->supported_interfaces);
> > +	list_for_each_entry(pcs, &pl->pcs_list, list)
> > +		phy_interface_or(pl->supported_interfaces,
> > +				 pl->supported_interfaces,
> > +				 pcs->supported_interfaces);
> 
> I've given more thought to that 'supported_interfaces' thing. This
> patchset redefines the meaning of
> 
>   pl->config->supported_interfaces
> 
> Currently, it's filled by the MAC driver and means "Every interface
> we can support, including the ones provided by PCSs that we can use
> with this MAC".
> 
> It now becomes "Every interface we support without needing a PCS", at
> least the way I understand that.
>

Wait but with the current code using the OR logic, it still follows
"Every interface we can support...". The modes that needs a PCS are
specificed with the pcs_interfaces mask in phylink_config.

The late add and release operates on the phylink supported_interfaces ONLY
when the MAC didn't specify support for it (by removing it as only the PCS
will declare support for it)

The confusion is present because everything is validated later on
major_config so those supported_interfaces are just an HINT that are later
verified with get_caps and with the pcs_validate OPs.

Adding the supported_interfaces to phylink is really to keep an original
reference of the value. This is to address a pattern I have notice where
the MAC driver always OR the interfaces with the one supported by the PCS.
(I remember it was pointed out by Russell)

But I'm more than open to discussion as this is something marginal to the
whole implementation, I'm also questioning if this OR is actually useful to
anything on the nth tought on this.

One thing that I notice is that parsing this early with AND might be
problematic at phylink_create, but I still have to evaluate that.

My take is that would be good to have some review also on the other logic
as I think I reached a point where Sashiko starts to comments on more or
less unreal problem.

> It's not an error in your code, but I think this is worth documenting
> somewhere as this changes one the things that's already fairly
> error-prone in new drivers.
> 
> I don't know to what extent people use that, be we have a porting guide
> that explains how to use phylink in a MAC driver, maybe an update in there
> would be nice as well :
> 
> https://docs.kernel.org/networking/sfp-phylink.html#rough-guide-to-converting-a-network-driver-to-sfp-phylink
> 
> Maxime
> 
> 

-- 
	Ansuel

