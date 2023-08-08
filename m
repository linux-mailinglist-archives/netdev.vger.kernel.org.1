Return-Path: <netdev+bounces-25343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2739C773C35
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FAE1C20FD0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A314292;
	Tue,  8 Aug 2023 15:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BB3C31
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:48:01 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9A583CC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:48:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so4829240f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509679; x=1692114479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nxtamw13aVajS7LnLP/B+Gnu6It4lKYjWeawet8By8=;
        b=fXY57z7CIxsus/lNBpMPuufkegYDM6s1klYLjV/YGHRqj8h8VPilIs4Bwu0DhNyP4I
         S7Vwrx97kp4akSd5R1uLIvEH9A1KTq2abEGYyCnWSHnI8C3+qs05uj07EoLg0nourqse
         O1K3pU2m4Qyr5hrr/baCkjPz+B7mIjkNZmv1W1sEzpggk4vN4DbKUSqJ4O82G1nxSe3B
         FCA5FZYqrSnWBiviEnv0tCxnKE99GJQujsxKQoZW7iIN7hdtn96o2gjv6GtE9gr5FNjH
         DBqk0DKAY/uqx6ot5Nsa3wmwnD29zWMZBLAuJv9TggDr+5kmIlj9P350VciGJqNFoWaq
         vC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509679; x=1692114479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Nxtamw13aVajS7LnLP/B+Gnu6It4lKYjWeawet8By8=;
        b=l6VbrITlM5c45DPG1dGu6SR0JwSVcetBWZGVkxfhZELxqw1sZ2VcqFQqLuq4HrRzG0
         UYtcqmhlIjXZgz59EH6/L8Nh+H86VBccHa3AovFGeUbTbiOPCFwDkpTAMVlysdLKrofH
         +uH9qxYfKXaR42nAjBPEiX/EykBYHY11K4O4xK6DaG6QJMB4096b4NyspP0I6iRbYtDZ
         5faCQ3hpReohlJ9gwHyYTy43LsY9agy0yxw3w3bS4InC6qJ1UkfDk5TbhgKNoVqQK0oM
         WjfU5HmfgaLseSbw5lkQgJQSGtW1swGpIcbDGHFGnERwYbrh+evIO9+LQGAfm+TCSHF+
         IdXQ==
X-Gm-Message-State: AOJu0YwqlHzVcSLw6fFDRFNDTHMDLFjXrKSC/cTrNNu+x7dCrybwguMn
	p9bDxYxVF3+W+6d5r1DtJ/qSLsB4Z5REPVJr
X-Google-Smtp-Source: AGHT+IEgsCqb+LUswu7L73X7ahs3p/ivLy8dshTxhVKh8RXJDYh2eOW2yNFA4gwBKVLvrF9EHDJVdg==
X-Received: by 2002:a50:fe8c:0:b0:522:1fd1:1035 with SMTP id d12-20020a50fe8c000000b005221fd11035mr9596721edt.6.1691502738195;
        Tue, 08 Aug 2023 06:52:18 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id q22-20020a056402041600b005222c160464sm6686830edv.72.2023.08.08.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:52:17 -0700 (PDT)
Date: Tue, 8 Aug 2023 16:52:15 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 01:57:43PM +0100, Russell King (Oracle) wrote:
> Thanks for the r-b.
> 
> At risk of delaying this patch through further discussion... so I'll
> say now that we're going off into discussions about future changes.
> 
> I believe all DSA drivers that provide .phylink_get_caps fill in the
> .mac_capabilities member, which leaves just a few drivers that do not,
> which are:
> 
> $ git grep -l dsa_switch_ops.*= drivers/net/dsa/ | xargs grep -L '\.phylink_get_caps'
> drivers/net/dsa/dsa_loop.c
> drivers/net/dsa/mv88e6060.c
> drivers/net/dsa/realtek/rtl8366rb.c
> drivers/net/dsa/vitesse-vsc73xx-core.c
> 
> I've floated the idea to Linus W and Arinc about setting
> .mac_capabilities in the non-phylink_get_caps path as well, suggesting:

Not sure what you mean by "in the non-phylink_get_caps path" (what is
that other path). Don't you mean that we should implement phylink_get_caps()
for these drivers, to have a unified code flow for everyone?

> 
> 	MAC_1000 | MAC_100 | MAC_10 | MAC_SYM_PAUSE | MAC_ASYM_PAUSE
> 
> support more than 1G speeds. I think the only exception to that may
> be dsa_loop, but as I think that makes use of the old fixed-link
> software emulated PHYs, I believe that would be limited to max. 1G
> as well.

I don't believe that dsa_loop makes use of fixed-link at all. Its user
ports use phy/gmii mode through the non-OF-based dsa_slave_phy_connect()
to the ds->slave_mii_bus, and the CPU port goes through the non-OF code
path ("else" block) here (because dsa_loop_bdinfo.c _is_ non-OF-based):

dsa_port_setup:
	case DSA_PORT_TYPE_CPU:
		if (dp->dn) {
			err = dsa_shared_port_link_register_of(dp);
			if (err)
				break;
			dsa_port_link_registered = true;
		} else {
			dev_warn(ds->dev,
				 "skipping link registration for CPU port %d\n",
				 dp->index);
		}

> If we did set .mac_capabilities, then dsa_port_phylink_validate() would
> always call phylink_generic_validate() for all DSA drivers, and at that
> point, we don't need dsa_port_phylink_validate() anymore as it provides
> nothing that isn't already done inside phylink.
> 
> Once dsa_port_phylink_validate() is gone, then I believe there are no
> drivers populating the .validate method in phylink_mac_ops, which
> then means there is the possibility to remove that method.

Assuming I understand correctly, I agree it would be beneficial for
mv88e6060, rtl8366rb and vsc73xx to populate mac_capabilities and
supported_interfaces.

