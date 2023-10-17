Return-Path: <netdev+bounces-41994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6317CC8F7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA8C1C20C3C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B42D031;
	Tue, 17 Oct 2023 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilVCBkDi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9052D034
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:37:45 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7094;
	Tue, 17 Oct 2023 09:37:44 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7dd65052aso80331317b3.0;
        Tue, 17 Oct 2023 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697560663; x=1698165463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NorG2GdjjtD2Uger6OsxVjsTdk016IzEJmN5x8jpF9Y=;
        b=ilVCBkDi1rKOTMw0afudl7pmlP9AWEHwx8IsI6285FpgqYLpvmf+MJnUf7OrNS2cea
         DJulZrWaeVAwm88eeqaDFj405bTAePJ6GWODoYxwqCb9y7c6GCMOAfDrvGzIcrvb8ab8
         t+0o5Un/UHKJja8S4wb8DoMQ+l2S2d/9lnoqiEMC5NVs95PoAMQq+MWcf2c+gS8r4g6E
         FlSKyuzmcHuOHZcOiPJC3HVBxbD7PslJTBZCckN6sVN5vWpxUzXjka3k2hGr6D5inmvJ
         JIKcqslIbT1BvGaFQgzvYC8nfLIAG1itXkV5hyRaLtbRtXssxQ+6HImKhkneK96pqVxb
         9/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560663; x=1698165463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NorG2GdjjtD2Uger6OsxVjsTdk016IzEJmN5x8jpF9Y=;
        b=R+6uxJ2oDiw4F6Z/sw/HXPX9f0vWuhnT6IduBNzxEQw2V+pXSykuBx8qpKqweqlSag
         h9JdFvPuABmkNSfDcaXCUI5SbH63IFlpD/Lrgkl+jiOZzldX/QMhtnu9OS5X75nilASA
         OtMASHezSRsR975y3GLrkbR7hXPB3wjHgsiARBSvWqcDAOp5cNfcuTrxwCXnvVw7FVPo
         44JJuTse/J/q0BoaAR5DuKDxWsIxuBbSy3Y0SPn8wMNJmdmPgljHMIdo7xIpORix3KxZ
         DEYxpxSIgkKqEXd63Lkif3h/OKtMT/p8AHLSGFDAHfF0HSeVWStfVqj4TnWekkHr10z7
         /bEA==
X-Gm-Message-State: AOJu0YyvoMITePlUfYksvaN1sQ6WDOULFkb5BKzBqcx8/TF2XBzMbw2U
	yscOur09CV7pa50TlJ5l3tk=
X-Google-Smtp-Source: AGHT+IH2OujYG+98LT+C23FwlzuIWsB/3pXU3kwRMxVMkJdNtpaU+rBEGUrl/uqZR1ghWbY7OQmSIQ==
X-Received: by 2002:a05:690c:f0f:b0:59b:5170:a0f3 with SMTP id dc15-20020a05690c0f0f00b0059b5170a0f3mr3919565ywb.36.1697560663545;
        Tue, 17 Oct 2023 09:37:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t6-20020a05620a450600b0077772296f9dsm787953qkp.126.2023.10.17.09.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:37:42 -0700 (PDT)
Message-ID: <60787e41-e137-43d7-8fd0-59818cfbb536@gmail.com>
Date: Tue, 17 Oct 2023 09:37:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: mdio-mux: fix C45 access returning -EIO after
 API change
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
References: <20231017143144.3212657-1-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231017143144.3212657-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 07:31, Vladimir Oltean wrote:
> The mii_bus API conversion to read_c45() and write_c45() did not cover
> the mdio-mux driver before read() and write() were made C22-only.
> 
> This broke arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso.
> The -EOPNOTSUPP from mdiobus_c45_read() is transformed by
> get_phy_c45_devs_in_pkg() into -EIO, is further propagated to
> of_mdiobus_register() and this makes the mdio-mux driver fail to probe
> the entire child buses, not just the PHYs that cause access errors.
> 
> Fix the regression by introducing special c45 read and write accessors
> to mdio-mux which forward the operation to the parent MDIO bus.
> 
> Fixes: db1a63aed89c ("net: phy: Remove fallback to old C45 method")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


