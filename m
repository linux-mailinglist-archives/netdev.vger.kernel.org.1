Return-Path: <netdev+bounces-51661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B73A7FB9C7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3771C212D7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A34F8A0;
	Tue, 28 Nov 2023 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAbRtY9p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3007B94;
	Tue, 28 Nov 2023 03:57:54 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso3902033a12.0;
        Tue, 28 Nov 2023 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701172673; x=1701777473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Au9nUxhJpxLlowC1DWuTT8wE7HwJxWHLoh0Fk+7NDQE=;
        b=GAbRtY9p0mIrzZJtEvNySXPDDKKHOmT0e8m0NZePIaGZqeJyxvCxY8GTX+m8CMbKLS
         NYWK0THLWte29a/6Hk2qNISh/ltVFAl+Cf/2vbLo0KKOjCIJqx1AFy0bIAZcHlwaMkM5
         ryieiSct2C3BlQewg+cWieeeL+2wtEBNyk6KA4eS9F0q4O3Ll9beECL19qSHE2LY7t+h
         c+0CnyuJwfKutZDustGwXkb40yY0kumtXPNXPJdZuJJQOU3Z2V84te8LHRWhxVOvNKS1
         SPnf3s5zHMJOAHcIMjkub3/Gm8RLhJaUhhaF4nJ3T1v6S5k7VKg4YjDyVTCFeho86ASJ
         11rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172673; x=1701777473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au9nUxhJpxLlowC1DWuTT8wE7HwJxWHLoh0Fk+7NDQE=;
        b=txb1i3ILprk0Nt+JbfXmOYtCxfN1mMOsV5yiu35dDFNFNCffBVAFv4WgjmSa2NCp1E
         pj+ImON7HhWqMbmVIeayr3HHj/ZnL1crZ705cWCBHNo7itjIjjDcH3Nl5bEoN/JxjFlr
         wKkYx2Y3CVn7copKSXyu6tLan8bhDsG1tpRYnuobVmSgFTcpk+5mg6rF2bW4irx19Twe
         XgJm90Ob42zZ14NFNCuYldgbqqPBcNxlI1PMs8JcX22fea1mhDE84rAuMrPs50h54dH3
         eg4Sa5kPbzhGVYxd5VGxOgAmxXmKXBnE7AGSSWSaIcGq3h8IEq/ctQdXR0EAadPbw/6T
         8G3w==
X-Gm-Message-State: AOJu0YxHzaz5ii8BnZKyvjVf7nXo7HUFq4iN0dG/WjQRkYIyeI+Mfp0i
	sMdn8SGPGhYZhgMYVpCk+8r+ejH6e8O7Jbq2Qyw=
X-Google-Smtp-Source: AGHT+IGI8GYlTLMr6TPAatbYN+qbZr2mza5gojB/P51PZL4deCMh9vGGPnl49tL4WUqHCCgnU8l9jN2GK6+bDluqwi0=
X-Received: by 2002:a17:90a:e7cf:b0:280:215e:7ae2 with SMTP id
 kb15-20020a17090ae7cf00b00280215e7ae2mr17609369pjb.2.1701172673606; Tue, 28
 Nov 2023 03:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117100958.425354-1-robimarko@gmail.com> <20231117100958.425354-2-robimarko@gmail.com>
 <ZVdg+vFb46aFRtC0@shell.armlinux.org.uk>
In-Reply-To: <ZVdg+vFb46aFRtC0@shell.armlinux.org.uk>
From: Robert Marko <robimarko@gmail.com>
Date: Tue, 28 Nov 2023 12:57:42 +0100
Message-ID: <CAOX2RU5QWDPguJ1izfipfiGzCO1muFaJQ8=h9PAUD36jdZiUEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: enable USXGMII autoneg
 on AQR107
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Nov 2023 at 13:47, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Nov 17, 2023 at 11:09:49AM +0100, Robert Marko wrote:
> > In case USXGMII is being used as the PHY interface mode then USXGMII
> > autoneg must be enabled as well.
> >
> > HW defaults to USXGMII autoneg being disabled which then results in
> > autoneg timeout, so enable it in case USXGMII is used.
>
> I was led to believe that the bitfield in bits 8:7 of the
> VEND1_GLOBAL_CFG_* registers, when set to value '1' is something
> to do with selecting USXGMII mode as opposed to 10GBASE-R. Could
> you look in to that and whether that is the more correct way of
> configuring the PHY for USXGMII mode?

Hi,

bits 8:7 in the VEND1_GLOBAL_CFG_* are used to configure the rate
adaptation method.
With the following allowed values:
0 (Default) = No rate adaptation
1 = USX rate adaptation
2 = Pause rate adaptation

I dont think that is related to the issue I am facing here which is
that by default
Bit 3 in the PHY XS Transmit (XAUI Rx) Reserved Vendor Provisioning 2 register
is set to 0.

This means that USX Autoneg Control For MAC is disabled and in USXGMII mode
auto-negotiation between the PHY and MAC will fail/timeout.

I have checked various vendor drivers and they all enable this bit in
case USXGMII
is used.

Regards,
Robert

>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

