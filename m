Return-Path: <netdev+bounces-41242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC57CA4BE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932811C208E1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B31D55B;
	Mon, 16 Oct 2023 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMlWe0Ho"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26281CF8D
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:06:43 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A4E8;
	Mon, 16 Oct 2023 03:06:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99357737980so707210366b.2;
        Mon, 16 Oct 2023 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697450801; x=1698055601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1n848vc1DB3y6nZvForDzflBh2Jj0yE5IL1yqGeXagk=;
        b=dMlWe0HoSSUnH3Awtw8mjNBdQz9RRocetA99uORcLUSSoaJ/aFCVZLREOvjWpnCQ9v
         /uTOm64Zlxc/dnyM3mLH3uvcM7ZoA7bu7YaNNtQC+2NjDzy6eMq1kiP4CNJUxHJVK10N
         lSiQi8A1tIkxwf6y4dU+qbj8ZtntUESQwuyj1eG0A5H/gPR27N+980xgTWrWUK9Mhnf7
         xz3Gp8lHUm48xScEszm/rHHLahQShhlRo9zFbSF3hAT8bQZvynyVB93oac4MTeluCFn4
         /4KgB+uNDhuc+8KRn+VWvlf/rzNGmK9B+C3hecMrioqhjQJ5e8eyR7p7SaV3mrU9BZKZ
         ofzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450801; x=1698055601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n848vc1DB3y6nZvForDzflBh2Jj0yE5IL1yqGeXagk=;
        b=txSorO/szTHu7mwRkXjfeyBptainprt25AdJNltNwA3ae2moug2nbZ7qOJ2tJFe3q8
         yILc8sbvQwUtYc4Bvs/CRBuorrqgXO6OSPjgXXwZa/SDB9vl9mlmEtetGanql+y1+PDh
         910M4NKv8asslv4/E/NVuRmfMkFZPPgeE3/f1PSkIt5zYQl5i/0ESY7fRSo5fhyG0sOb
         Ui9nzZ91nh943AkIvi+gjlf4A4X4TVB45NE8Hk2DS7Gh587mgw1Ik/GBRp9q/9jFJtA3
         tsmxFbHN3Sjd1C0eDZPUo2d0fp0473jOlIVcDBIECxe7e4ohKGiXcFdIxTypYRb0Ug1j
         LaqA==
X-Gm-Message-State: AOJu0Yxsuj0JuvtB+Z4q5UtKaWSmDwumOqrXbmt/WdPCY45myBmkv0JC
	ZnHIBp/0ma40TdSmCTLpBTM=
X-Google-Smtp-Source: AGHT+IH+cYPFUivLjV2Xm+dFfJ21iIFN8eG6ywvwMgmHYmFiHPKIHE/AonafT4tltrybgRZB3z4Kgg==
X-Received: by 2002:a17:907:1c25:b0:9bf:b5bc:6c4b with SMTP id nc37-20020a1709071c2500b009bfb5bc6c4bmr4382143ejc.62.1697450800538;
        Mon, 16 Oct 2023 03:06:40 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id ca15-20020a170906a3cf00b009ada9f7217asm3712537ejb.88.2023.10.16.03.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:06:40 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:06:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH net-next v2 1/3] net: phy: micrel: Extend KSZ886X PHY
 Special Ctrl/Status Reg definitions
Message-ID: <20231016100637.6vfkfcilsucq6iki@skbuf>
References: <20231012065502.2928220-1-o.rempel@pengutronix.de>
 <20231012065502.2928220-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012065502.2928220-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 08:55:00AM +0200, Oleksij Rempel wrote:
> Extend 'micrel_phy.h' with additional definitions for KSZ886X PHY
> Special Control/Status Register (Reg 31), for upcoming usage in
> subsequent patches.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

I think you can squash this into patch 2.

