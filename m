Return-Path: <netdev+bounces-26528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4198778019
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FB71C20DD1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497B21D35;
	Thu, 10 Aug 2023 18:17:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1C2151A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:17:47 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3D1703
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:17:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso1918797e87.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691691464; x=1692296264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbHNOv2YoHSmaU9m94R3xgmK8eXS8C7q+DMr3v5hDAM=;
        b=WItw4QYP2bUApQAjkzlilZUzcaz/EKVu7CUTJxqUosRaTMIFyPxnM5ewtGFBZNGpXg
         atUtBeAGkrz9dxv2OreebjvFK/+WiEkuNHZMArjW4XZxNVbnyuJqz+q9CFdgn4SW+uSo
         eS2ImkoLokVpR2tN439JF0Edj4KuOa04ZJOQ+7g8gRjqqGLccyAltIAlSy4KLsYo0ADI
         v9THMHAOnGie7+2YAG6OSRpyFZBBBvqBzVzDZc3RxX0QPNy0h8knZhPki7PRb4ovbQ4j
         yokUuPpuRFboKuYqj37lcSpIhWq5JXBbkddrZwmR3nTmF3fMlBI4iGoVDEwI4d3cj3Hy
         adYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691464; x=1692296264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbHNOv2YoHSmaU9m94R3xgmK8eXS8C7q+DMr3v5hDAM=;
        b=TnlJ2Y/akajg10XyF/BFxBTmFEC3leLbf3OVFxW00ZoH+CXk3LQ7os5lVTYA/BD1Sd
         SHBFyKv7qsc0w7PqPLXomquakAcnffMJrtBG/tvToyj+hDL5jlFLkUy7cYr+uVZW6KYW
         mgY+Nmy7tOv1YtDFs0EybPEKmkK/4nsdm0EvHXRRYZsGIViPrrJWZUEntc0XV2NXGK+p
         7MSnX6O+voYWvuXBjHrLzDO9gBVXJTf/x+JjbjTK7forWgHkGK1UKzUIvULKMYanfZlg
         4y9pOiui4HAq78Ixoz9ga16w7NFclzHQHSMQbKK7xd5B967zgmhtsJvPnjU4O/irvMxP
         23zg==
X-Gm-Message-State: AOJu0Yye1KIs3ldSsXKqgdpmPVq3DdXU4a5yxFzJGpX6BLTELKeej8+S
	ESxod77MHXQUAEknXbT+5AeZEmntO0KYu9o9N5o=
X-Google-Smtp-Source: AGHT+IF6TShQSWVCbpmkLCowpu6+S3OlsnXOWuFp+lHCxh2b55AppefTMF82eQmlGIJ13tmgJq7oCa7WXbqTLVN/e9g=
X-Received: by 2002:a05:6512:e93:b0:4f8:e4e9:499e with SMTP id
 bi19-20020a0565120e9300b004f8e4e9499emr3072051lfb.12.1691691464053; Thu, 10
 Aug 2023 11:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk> <20230810164441.udjyn7avp3afcwgo@skbuf>
 <ZNUV2VzY01TWVSgk@shell.armlinux.org.uk> <20230810171100.dvnsjgjo67hax4ld@skbuf>
 <ZNUglYF2Xy63l4aZ@shell.armlinux.org.uk>
In-Reply-To: <ZNUglYF2Xy63l4aZ@shell.armlinux.org.uk>
From: Sergei Antonov <saproj@gmail.com>
Date: Thu, 10 Aug 2023 21:17:33 +0300
Message-ID: <CABikg9zcNED55rjnq9a9ZTjp8pCKXWs9HBy5r2KAdECP1Dm8vg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps implementation
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 10 Aug 2023 at 20:38, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 10, 2023 at 08:11:00PM +0300, Vladimir Oltean wrote:
> > On Thu, Aug 10, 2023 at 05:52:41PM +0100, Russell King (Oracle) wrote:
> > > I wonder whether we have any implementation using SNI mode. I couldn't
> > > find anything in the in-kernel dts files for this driver, the only
> > > dts we have is one that was posted on-list recently, and that was using
> > > MII at 100Mbps:
> > >
> > > https://lore.kernel.org/r/CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com
> > >
> > > No one would be able to specify "sni" in their dts, so maybe for the
> > > sake of simplicity, we shouldn't detect whether it's in SNI mode, and
> > > just use MII, and limit the speed to just 10Mbps?
> >
> > Based on the fact that "marvell,mv88e6060" is in
> > dsa_switches_apply_workarounds[], it is technically possible that there
> > exist boards which use the SNI mode but have no phy-mode and other
> > phylink properties on the CPU port, and thus they work fine while
> > skipping phylink. Of course, "possible" != "real".
>
> What I meant is that there are no in-tree users of the Marvell 88E6060
> DSA driver. It looks like it was contributed in 2008. Whether it had
> users between the date that it was contributed and today I don't know.
>
> All that I can see is that the only users of it are out-of-tree users,
> which means we have the maintenance burden from the driver but no
> apparent platforms that make use of it, and no way to test it (other
> than if one of those out-of-tree users pops up, such as like last
> month.)

I am planning to submit a platform using "marvell,mv88e6060". For the
next release cycle hopefully.
Our should I rather try to move MV88E6060 support to /mv88e6xxx?

