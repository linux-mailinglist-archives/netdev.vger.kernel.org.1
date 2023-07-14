Return-Path: <netdev+bounces-17748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E6A752F60
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CCD281849
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DB81C;
	Fri, 14 Jul 2023 02:27:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE83EC8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:27:25 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A69273E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:27:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7589b187so2420742e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689301642; x=1691893642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QjYIpy7xP8DMRQSEFqDvT4XVNXsg22AxVySZOvYUqA=;
        b=MQDGYViNKUs/ToyMwdzEU3VXSEmLtcL4OZwTI9m7eHi9mWiBdORVRyjXtQOvlfUDVO
         G4Amc5c9FRO33I40Uj+Dl1DULQzJyfkfxaHFqk/UOt63fIuAIx+u/HQxPd0V3xzyGFa9
         F1Y9SXBFzi9XdKzOv6r3kmbTFb2G5zUi2U00hceGPaT6EcodYYNYw8R0rbsDhNQRo9p4
         1Hby64kdlJulyDqy+K1+mtrEdwD3ljhV7n+lzhK5GFcgXvcl9sNiy9BY65w53OaA+zHT
         0v1GA294SiSWglcjInogP4MqGzeFl4nvH4umiZsDag4HfSDPfA3qifiPkOt3/jZSftwv
         ugCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689301642; x=1691893642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QjYIpy7xP8DMRQSEFqDvT4XVNXsg22AxVySZOvYUqA=;
        b=dnQWPf86YgR1dgj/55xFdVNs5eqCoig7OcO+dqt0ZzbcPjQnrmX//PbE/z0cGP7hFl
         elQB6l9fh1YKpapGL6k6jZpzwBgUHf5oz6if5LNvj9pX4twolyxq6fRI0L1ul3D/AmxJ
         dAbu495XYAe6SoIbZjUt5aQp309UuyWOifm1Skk7sdpE+FjAACMU6ECiQNxzRUVsv6HG
         rRwFph0qg3+jZjc5vtcD6l59v8blvEUE/0U9aZFprgZKvOHi5gNIu/15LAfzgRsQ9Krh
         y3ccm4bRbKHiFIlOcxAeDkgzCooRDnnAF0/oPAm24LQCHoYqjtqC6Mfui3iTC8cslyBx
         JoSA==
X-Gm-Message-State: ABy/qLaRpHzsWWdGvcUA3CKIrS3DT8iopBcolXBzU8I72HN2ydO0ZfH7
	kfOhMD7Ne7bnW3VgmWFCwGHDbkKgq4XvhpDpbWM=
X-Google-Smtp-Source: APBJJlFUoixFhld5+Sc4wTb/QLucmlL2H0eqJxxPuIDBzcH4KYML2HGrxrU7S13KSW864n/hzAEW5bgKP9buvO0IakM=
X-Received: by 2002:a05:6512:3ca5:b0:4f9:6c44:1bf3 with SMTP id
 h37-20020a0565123ca500b004f96c441bf3mr2958048lfv.62.1689301642370; Thu, 13
 Jul 2023 19:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
 <ZK+wdvepjYPigfOh@shell.armlinux.org.uk>
In-Reply-To: <ZK+wdvepjYPigfOh@shell.armlinux.org.uk>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 14 Jul 2023 10:27:10 +0800
Message-ID: <CACWXhKmPgiPXKJiBJjcAtWbY6Agb55XjqwDKdgiJuP5Se4r4Yw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] net: stmmac: dwmac-loongson: Add GNET support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	chenhuacai@loongson.cn, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 4:06=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jul 13, 2023 at 10:49:38AM +0800, Feiyang Chen wrote:
> > Add GNET support. Use the fix_mac_speed() callback to workaround
> > issues with the Loongson PHY.
>
> It would be good to document what those issue(s) are, and if they are a
> PHY issue, why they need to be resolved in a MAC driver rather than
> using the PHY driver's link_change_notify().
>

Hi, Russell,

There is an issue with the synchronization between the network card
and the PHY. I believe that I am unable to access certain bits of the
network card's registers within the PHY driver.

Thanks,
Feiyang

> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

