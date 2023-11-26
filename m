Return-Path: <netdev+bounces-51138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78F7F94DD
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BBDB20C34
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D110A14;
	Sun, 26 Nov 2023 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWZtQvt/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D862AB;
	Sun, 26 Nov 2023 10:24:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50ba71356ddso2440961e87.1;
        Sun, 26 Nov 2023 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701023081; x=1701627881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C/uGlnxuMuDdUxZ9ryOoDdOefWXlIx4ao2wXZbsquH8=;
        b=IWZtQvt/3Dl8UBfv4nhKnaoiLeO8NpSi2EODxXKz4xD/iC5+imqA8641kmAvqypCOK
         mGK0Fu1/6ua95pZW5YFDoPc/chERefdopYSo+UwMSKB05qggMpu5/31g3+1wB3W5r4Eo
         tYoWsOWkz52qalwpSRh1yHuMFOXSSPyWwbc2jnx/5lmsMp34ldaDAcR4ccdwsU7Y6xXc
         Anexfhn5NWOBBP9nMBFaj029LmE4PkjOPmzYZ1chxI4IGHzOFZxh9wznbEtb0jnk1/SZ
         QWU0d/FqIgeaKRHCnR1fpDHFvZnyahFGAB4sPi0ejIgW2mHWY14wBrbtZUGLAs8o1FPv
         UhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701023081; x=1701627881;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/uGlnxuMuDdUxZ9ryOoDdOefWXlIx4ao2wXZbsquH8=;
        b=JqrEh93L0sdM3/cJoi64EixWjrN/n+t1nfsn3Cd8ZH6UMkA9qnBq7T5UIVGAjqYznl
         hmQarsIFljhSVnC3zOOZvVscPs3J5iAltWWV3N3BPFrfJxkVi0em+9+STzeP0GJrTsDc
         7HGzfdgDtKvKqOUMveLm+ctMZtxxhWAVZ47LLqF+hTTO0B8fWROtRHpF77+z62QmvSqh
         9/nsZynQiGC+ECyTqX98KXMoNdL4U26fFTOwWIsjDM4/fKeLx5ZuDxjH+0YoPw/wmNAs
         lqVGR89PnydFzM1ELnijkaG9HHI5+LAaoYgOFuuCqKOXLYhwnnuV0CzNTK5kis9aYAUl
         2Ofw==
X-Gm-Message-State: AOJu0YzXGIOEbZPZvOaVhKrsJBNYjLk9+S9F7n2zhraObAwFaXl2+Id9
	+ZHsH68g+glEiJQSFmipmR4=
X-Google-Smtp-Source: AGHT+IFPCeMhwmw31Abui8AUK80VuhrsAEUNtqykwcBuZq5m77KV6axZwO71Mo72oWKCBWCl5Gj46w==
X-Received: by 2002:a05:6512:41b:b0:50b:aa9b:c9ca with SMTP id u27-20020a056512041b00b0050baa9bc9camr2872922lfk.57.1701023080883;
        Sun, 26 Nov 2023 10:24:40 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b0040b42df75fcsm2980792wmb.39.2023.11.26.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 10:24:40 -0800 (PST)
Message-ID: <65638d68.050a0220.17be1.86fe@mx.google.com>
X-Google-Original-Message-ID: <ZWONZeChrhxyT_E3@Ansuel-xps.>
Date: Sun, 26 Nov 2023 19:24:37 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: phy: add support for PHY package MMD
 read/write
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <20231126003748.9600-3-ansuelsmth@gmail.com>
 <4166bb2a-66ef-4757-b05b-7d5d7a415c67@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4166bb2a-66ef-4757-b05b-7d5d7a415c67@lunn.ch>

On Sun, Nov 26, 2023 at 07:14:52PM +0100, Andrew Lunn wrote:
> On Sun, Nov 26, 2023 at 01:37:48AM +0100, Christian Marangi wrote:
> > Some PHY in PHY package may require to read/write MMD regs to correctly
> > configure the PHY package.
> > 
> > Add support for these additional required function in both lock and no
> > lock variant.
> 
> You are assuming the PHY only supports C45 over C22. But what about
> those PHYs which have native C45? And maybe don't have C22 at all?
> 
> You should refactor the code of __phy_read_mmd() into a helper and use
> it here.
>

Have to be honest here and chose the ""easy"" way. Was a little scared
by all the complexity with mmd with C45 and C22... The idea was to add
C22 support for now and if used by others extend the function. But I
guess with the generic approach we are taking it's better to handle it
now. Will update this in v2.

-- 
	Ansuel

