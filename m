Return-Path: <netdev+bounces-37799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0507B7383
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 013311C2040D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CA3D98B;
	Tue,  3 Oct 2023 21:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB73D974
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 21:50:26 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A41EA6;
	Tue,  3 Oct 2023 14:50:23 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4547322a756so711510137.3;
        Tue, 03 Oct 2023 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696369822; x=1696974622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF34turnWm8J/YqjdS1MNnVfMeCJf57KTxJRwtve6sE=;
        b=RxYIEjinF4fSHELQM1Z1xRldETLFeXkn0aSSqwquqHP5xyHluy9ATYkNBM1rEzinSE
         wuIhAl6lpMuSuaolWOKhysXhPX/zgwm2+n9qNR6XZN6xFJDkIW0X/ZsqmPlLlk+bBzBm
         NI6dZwFUNKlYJcnVlb9x7jqUNn9j7PtCMvTY+n9nUbbilOU19KABlsly2u8lW3JDv7dO
         JCh4RhLKAJYSY6KYuDAaWpZe/HhPgq9iVChfs76E0/eRhmDoen667+X0bT53tSlXDm5o
         Zfk6bMlW7zTPmUru0KJS9L2aRzy1uhKIGrwR1f+8nPepNKOLt1GLup5cjO2GKoDOVOYc
         ajow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369822; x=1696974622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF34turnWm8J/YqjdS1MNnVfMeCJf57KTxJRwtve6sE=;
        b=ZYAb0Bm8ltnaXlv0B7BNs6w7XlWvF70eSiUmumFXiBqTELnuLg8PKNxU2Cc1moX8KQ
         ggcJ8zBpg+k5PMWNf0oe5Dj2spSEaTJ0INDn4U14GgLUUDeOwBSf8w10hoEA3l5pA0Pu
         dv7HIxM+Fgb1qwQ1h/oQ26z9RGPgnBsYFhxNxn+6QMagsR7AXu2eCIMy/nFtvhfmEGtp
         2STr2HmQFiJ5z6ExiD0DLboPGNFCTH51Ef8ErMwmyP1XSZ/wG9xFLmGwnF96pHP3jq74
         FOoiX8ssVcp1AWILEE5BCISH7ou9l5rxLE+hFsVFYGtj7N1/QWq4GigqUhQ4pVRah66m
         HyHQ==
X-Gm-Message-State: AOJu0YxJfyOBYodXFfReuD4P25Y8VdOfWDQwXddZA550cRRr6ZbfgBuH
	8nMGPmvL+YO109i0f+Kp8gNyuBfJPCdlBE8kBAAtzXuA7squWw==
X-Google-Smtp-Source: AGHT+IEGQMqc/Zr707mbj9Q6RxqzEI3tKpSjBjXaboqdqGvyH0pdU5TNzsqDz/VhDYWzAw52noxYlefn5cEu/vxBN1U=
X-Received: by 2002:a05:6102:8a:b0:44d:4a41:8945 with SMTP id
 t10-20020a056102008a00b0044d4a418945mr566277vsp.8.1696369822461; Tue, 03 Oct
 2023 14:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-3-paweldembicki@gmail.com> <ZQCWoIjvAJZ1Qyii@shell.armlinux.org.uk>
 <20230926230346.xgdsifdnka2iawiz@skbuf> <CAJN1KkwktmT_aV5s8+7i=6CW08R48V4Ru9D+QzwpiON+XF8N_g@mail.gmail.com>
 <52dd8a1c-e0f0-4a24-b6d7-6ba1c9482525@lunn.ch>
In-Reply-To: <52dd8a1c-e0f0-4a24-b6d7-6ba1c9482525@lunn.ch>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Tue, 3 Oct 2023 23:50:11 +0200
Message-ID: <CAJN1KkyoZ-716TvPYbOb8RtREeFy+74Ge2aAm5XBUFxhyXj9sw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] net: dsa: vsc73xx: convert to PHYLINK
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <simon.horman@corigine.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

wt., 3 pa=C5=BA 2023 o 23:32 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > I plan to make rgmii delays configurable from the device tree. Should I=
?
> > a. switch to phy_interface_is_rgmii in the current patch?
> > b. add another patch in this series?
> > c. wait with change to phy_interface_is_rgmii for patch with rgmii
> > delays configuration?
>
> Do you actually need this feature? Does the PHY you are using already
> support fine tuning of the delays?
>

After Vladimir answer I know that it should be a separate change.
I need it for MAC <-> switch connection, the rgmii port connected to
the cpu. At this moment, rgmii delays are hardcoded in vsc73xx_setup
and it should be tunable for the p2020rdb board. I plan to work on it
after the driver becomes usable.

