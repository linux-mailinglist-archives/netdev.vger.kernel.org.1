Return-Path: <netdev+bounces-17766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A21D753028
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC181C214C1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6702620F4;
	Fri, 14 Jul 2023 03:51:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4461C28
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:51:15 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E1E26B2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:51:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so5638543a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689306672; x=1691898672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyKf1XbbnW8HJAfUKwEUwFLcaHpJ2mTPwQIpwLo6HZg=;
        b=Fa8aGhNjOQZ7cDzxOzqLKGl9/5hqTIJoetN7YFHMnCtRu838IwVJOzlV+8gcFcmJu5
         gQIlBbPay/aHzCCVyz5n/apxIU7xJUWTQRuJpVSGlUE88eTn3H8jnr27Vnh5KgmbcEAq
         Ii06z+HP2uU+EpYuEIh7GVOr0frVnasktqKAJj43devvgLxS2vpy27KSaGHJwRgCEbcZ
         kAOxRSvB+OkdSYHJttqq8m4oX+Op7hVcpfJ3MRrmyiH+q58wRZbY2D6wU0JARDg0SE1C
         HpHgC9hVu8SoR8490w4kp+Dop0ZM9sSolMp+lyRPdkQfHN+okAgQzbylXLMoAAx+5l5H
         nc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689306672; x=1691898672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyKf1XbbnW8HJAfUKwEUwFLcaHpJ2mTPwQIpwLo6HZg=;
        b=eioUrfDdgOUWZRgyvlCUOkXEAPLiyo9NHda2RV21oeoE5x0NfZgOfHh2pSmkYDkiSo
         tizTqiAOoptVBinKNiFetTHngds3BCFzf8cTgOnmjl44OvBBgkkstfBGo8NUNExo20OQ
         mVMOtJnt3n2EZ3Dw8NYlgJPq7hf2b++bI4G53wE2/8fIwpWBVKStmrgEph8VPh4Eqnd1
         yBoaclrbliM1FJjTn3KP2Xu+MUllD6Hve5qb0Z5gSfQqIA4Mp8JlsPrxEeMnZzRq+HQJ
         Xgv8DWnaLJt17pF+lnZo9+hHyQh5o0HVx6NHiv9goeoI5vbaljxo2mbspWM7YuDHVP/n
         CQvw==
X-Gm-Message-State: ABy/qLYUbqRfB9NbVgbDH1mbz5IhLLvFcAPHUZj8SBXF2XF0lvCYeCIv
	fFaP4HnbrbcfJMWgnUcwtmQ=
X-Google-Smtp-Source: APBJJlELJDZEm2+t2q99N3NF6LoBeMMzTSIurLAy/myRfNlIfdF5J+EBxrtZUwGuCrAE2MRIWNav5Q==
X-Received: by 2002:a17:907:3e9a:b0:98e:4f1:f987 with SMTP id hs26-20020a1709073e9a00b0098e04f1f987mr1964749ejc.3.1689306672080;
        Thu, 13 Jul 2023 20:51:12 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:69e:4230:6206:d9a0])
        by smtp.gmail.com with ESMTPSA id p27-20020a170906141b00b00977eec7b7e8sm4791100ejc.68.2023.07.13.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 20:51:11 -0700 (PDT)
Date: Fri, 14 Jul 2023 05:51:10 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: add the link modes for
 1000BASE-T1 Ethernet PHY
Message-ID: <ZLDGLqRuzKhtSALY@eichest-laptop>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-2-eichest@gmail.com>
 <cad4c420-470d-497a-9a1d-a43654af9a7e@lunn.ch>
 <ZLAFzaN7IRzerGpX@eichest-laptop>
 <f33be5e3-cfb4-473f-8669-58e1982d2a17@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33be5e3-cfb4-473f-8669-58e1982d2a17@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 05:18:02PM +0200, Andrew Lunn wrote:
> 
> **
>  * genphy_c45_baset1_able - checks if the PMA has BASE-T1 extended abilities
>  * @phydev: target phy_device struct
>  */
> static bool genphy_c45_baset1_able(struct phy_device *phydev)
> {
>         int val;
> 
>         if (phydev->pma_extable == -ENODATA) {
>                 val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
>                 if (val < 0)
>                         return false;
> 
>                 phydev->pma_extable = val;
>         }
> 
>         return !!(phydev->pma_extable & MDIO_PMA_EXTABLE_BT1);
> }
> 
> This is rather odd, but might help you. You already have a workaround
> in mv88q2xxx_config_init(). Have you tried adding a get_features()
> callback with sets phydev->pma_extable to the correct value, and then
> calls genphy_c45_pma_read_abilities()?
> 
> Please also report the bug in the PHY to Marvell. Maybe a later
> revision might have it fixed.

Thanks for the suggestion. Unfortunately,
genphy_c45_pma_read_abilities() directly reads from the PHY registers.
Therefore, I can't use the pma_extable. But probably I can just set the
missing features in get_features for this PHY. I will see what I can do
here.

Thanks,
Stefan

