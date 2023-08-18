Return-Path: <netdev+bounces-28872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F67810E8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FBD1C2137D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE0B5665;
	Fri, 18 Aug 2023 16:49:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F79374
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:49:49 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA62D64
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:49:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99d90ffed68so473697766b.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692377387; x=1692982187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7OuMJLcq9kmAwDw+PR/CdEVOCZn6qOIPEC8wCf2g+A=;
        b=ZrSJb6Xm7kffpaUGKbSx0DPCFKquPQ+QpjMkOwK9vrElcXvJWylUlNWHHs1DbSo0v7
         CfMR0fdHO8dsX+AZKDLycthv+clTBaaB4vbO9l4gvl2KCTfNbTgCKp0er7kqZrmqE1JC
         Ky4LuOOMBl9fDfKZtY/uVdTGy96IUtXXPz62gQnY3rH8axfZEGtpzOBLz3K98hXcB8So
         524VMWF01b9rn6IzyxuergAbIbylqv0h4ofShV69OvjCFkKNj8T4CeB4vC7Z9zbPlrSP
         AJzpqjaCQv6Uexi+RtKELjtNLA90yDgY5kHuMxBCGUb5d5T7bvfCz5Cpk4GahXm+Sesf
         W/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692377387; x=1692982187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7OuMJLcq9kmAwDw+PR/CdEVOCZn6qOIPEC8wCf2g+A=;
        b=LtTJ61qM4rbvyFwN789Bpq9FdWEtXU1UK+UDUGRBlX0goGyoImzkuiAabZY2HDsP8D
         3pQ78fgR2VtetDqqTmrIIs5XDRc+LyHLbXTMlrBDq/wkESAGTXHSRdKecST/Znano1UV
         OxutgCCRSfFFxGU3uNjqymYQH/835UnxiqgE8KMru987YAgEaQ/4r4UXqYvLTT8TxmAg
         CGPNlaZkCmp2o7onybouq5+CO3v+kG9G/7XrVtVhgkKr3Yy3RCt4owRvBSJebHUw6avz
         VtL5GR1cmvLVg3bCfgQLnQe09qM+Lib43tpUkboEyKFC0nVBkGh3xH3JS239zPT/fgJb
         LUEw==
X-Gm-Message-State: AOJu0YxlZq121AZkwc4FLzEAhfEMv79tuN57hmb5T5WijzhPGx4+kIiD
	Xp1fcs5os6jW5S52V5M5BiQ=
X-Google-Smtp-Source: AGHT+IE5C8orhmxMlgrBcdOV0SiTm6em8ODaNS69YoCxNL1LiPHiY8ykOwfDySGUe1cJeDq/Fo8T9g==
X-Received: by 2002:a17:906:5357:b0:99c:7300:94b8 with SMTP id j23-20020a170906535700b0099c730094b8mr2905875ejo.10.1692377386738;
        Fri, 18 Aug 2023 09:49:46 -0700 (PDT)
Received: from skbuf ([188.25.255.94])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090605d100b00993159ce075sm1369068ejt.210.2023.08.18.09.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:49:46 -0700 (PDT)
Date: Fri, 18 Aug 2023 19:49:44 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230818164944.kkeqywxkyhcjdfrd@skbuf>
References: <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
 <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf>
 <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
 <20230818114055.ovuh33cxanwgc63u@skbuf>
 <ZN9tvW6cbnjJo/9M@shell.armlinux.org.uk>
 <20230818142105.kpbdqmm3lckeja5z@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818142105.kpbdqmm3lckeja5z@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 05:21:05PM +0300, Vladimir Oltean wrote:
> On Fri, Aug 18, 2023 at 02:10:21PM +0100, Russell King (Oracle) wrote:
> > > > The second patch is my patch adding a phylink_get_caps method for
> > > > Realtek drivers - should that allow all "rgmii" interface types,
> > > > or do we want to just allow "rgmii" to encourage the use of the
> > > > [tr]x-internal-delay-ps properties?
> > > 
> > > Same opinion as above. As long as it's understood that the RTL8366RB
> > > MAC, like any other MAC, shouldn't be acting upon the phy-mode when
> > > adding delays, let's just accept all 4 variants, with future support to
> > > be added for [rt]x-internal-delay-ps if there turn out to be
> > > configurable MAC-side delays present.
> > 
> > Yes, I think you're right, because we could have the situation where
> > the CPU side is adding the delays, and the DSA side is not, which
> > should be described in DT as:
> > 
> > 	phy-mode = "rgmii-id";
> > 
> > on the DSA side, and e.g.:
> > 
> > 	phy-mode = "rgmii";
> > 	rx-internal-delay-ps = <2000>;
> > 	tx-internal-delay-ps = <2000>;
> > 
> > on the CPU side. Yes?
> 
> Yes, this is the situation I was thinking of, where the DSA CPU port
> would have "rgmii-id" to denote that the remote side has added the
> delays.
> 
> At least, that would be the intuitive way for me to describe things
> according to our definitions from the documentation.
> 
> (open question: if those remote delays are added through pinctrl-gmii
> rather than through the MAC OF node, would that count towards DSA's
> phy-mode, to make it rgmii-id, or not?)
> 
> Though I agree that I can't see the exact phy-mode breaking anything
> with a fixed link, given this interpretation, even if it's "wrong".

I haven't fully digested this, but would it make sense to say:
"for fixed links, only phy-mode 'rgmii' should be used, since the remote
side is not known, and thus, it is also not known whether it has set up
clock skews in any direction"?

One possible advantage would be that it would make people think a bit
more whether they should add code that applies MAC-side delays in
fixed-link mode based on the phy-mode. If we had that extra recommendation
documented somewhere centrally, doing that wouldn't make a lot of sense.

