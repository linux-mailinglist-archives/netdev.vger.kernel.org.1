Return-Path: <netdev+bounces-26483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871F777ED6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAC828228B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB620FA9;
	Thu, 10 Aug 2023 17:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807A1E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:11:09 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B75B1BF7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:11:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1d03e124so157455766b.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691687463; x=1692292263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMcZZ4VFmGEDUbgSfv9DRVg7AIcU8L2NTtxf+aYfxTQ=;
        b=mEAS+zi8basxALNHBJ3aDdX6gU1Z761xluK9Vhqfh5YH0FrMM7hRiZS1pGJaX0p5MW
         oAT5Ymb9UEu5zCOZy3TC4WAtdrwVyZiaYyc0MAkFJak4k7nVn0gRsFebO0PT0OO6Ta1A
         s0vgOqZVSuzg+EWATTN9YZjDdPsXVLlhgHLAN+j0twIGLMk21Pntw8jqPW8QTcSOQIy4
         eeVfpf6eNldvVi0ZQ/pzfKout155Y105IjSeEU/0QM8XjQVPyCbymqNlu2wpccl4jbei
         vvAWgqvIAajEkoc6T6R0usM0pU8Prl3SIGtUp7hSHu+81EtRk5tX7hmBJ6RFqid5LD+Y
         T9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691687463; x=1692292263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMcZZ4VFmGEDUbgSfv9DRVg7AIcU8L2NTtxf+aYfxTQ=;
        b=LehLju//vmYd07yFS1UyelZesRUFL9x1qrMDFigbX3GQWFTdXLtaMbFwdYjiv/o5LP
         vaL/3/o8aMbvjZj23GRV82kyEMsCFvsqTBJIcUbKvUq48VSkFq8cAE58LBKUy5c8fZ8P
         IimaxBbNbtwNTD61USg8Ei4+jc51rAvFBeoTfQ4BnIJ1J/pHoseOGxn89asBGL1iKBCI
         Z4czJuiVC+tyKeny0cD3dHoPRxP+48wqZyHRi5ekxrvV+qyzh4GAEVo0NCBJ51WVfJUW
         AgOKpJGQLPFo04y3xoQm0qdsexCT57RN4xs11lbeM/0RbYhxCHTpqgVh7oYd23c+Bfv+
         Aypg==
X-Gm-Message-State: AOJu0YzuyxY6jY5UdxTCxfjFNODymyMF+hZI2KubGyC1ideyJQxlHhY6
	LJxOBoaSjpkyhwCYvMHUvfB9mqt1KgFRGg==
X-Google-Smtp-Source: AGHT+IGi7eFE2dKjOPtJD3R4IapFW2Jk2XFSDk4tUQcPJWaBazsyI6LLD7kMVFrD2SrbpaS4V3iqSQ==
X-Received: by 2002:a17:907:77d4:b0:99c:2289:63bc with SMTP id kz20-20020a17090777d400b0099c228963bcmr2525410ejc.74.1691687463229;
        Thu, 10 Aug 2023 10:11:03 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id o27-20020a17090637db00b0099bc8db97bcsm1180834ejc.131.2023.08.10.10.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:11:02 -0700 (PDT)
Date: Thu, 10 Aug 2023 20:11:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Sergei Antonov <saproj@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <20230810171100.dvnsjgjo67hax4ld@skbuf>
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <20230810164441.udjyn7avp3afcwgo@skbuf>
 <ZNUV2VzY01TWVSgk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUV2VzY01TWVSgk@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 05:52:41PM +0100, Russell King (Oracle) wrote:
> I wonder whether we have any implementation using SNI mode. I couldn't
> find anything in the in-kernel dts files for this driver, the only
> dts we have is one that was posted on-list recently, and that was using
> MII at 100Mbps:
> 
> https://lore.kernel.org/r/CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com
> 
> No one would be able to specify "sni" in their dts, so maybe for the
> sake of simplicity, we shouldn't detect whether it's in SNI mode, and
> just use MII, and limit the speed to just 10Mbps?

Based on the fact that "marvell,mv88e6060" is in
dsa_switches_apply_workarounds[], it is technically possible that there
exist boards which use the SNI mode but have no phy-mode and other
phylink properties on the CPU port, and thus they work fine while
skipping phylink. Of course, "possible" != "real".

What I would like is to not discourage the board user to set phy-mode =
"sni" in the device tree if that's what PortMode in the Port Status
Register says that the port is strapped for. I'm afraid that by
intentionally ignoring that bit and putting PHY_INTERFACE_MODE_REVMII in
supported_interfaces, we're kind of suggesting to that person that this
is what is correct, as that is the only thing that would work without
modifying the kernel?

Maybe if we don't want to introduce PHY_INTERFACE_MODE_SNI for fear of a
lack of real users, we could at least detect PortMode=0, and not
populate supported_interfaces, leading to an intentional validation
failure and a comment above that check, stating that phy-mode = "sni" is
not yet implemented?

