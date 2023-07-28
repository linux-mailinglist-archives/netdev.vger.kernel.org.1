Return-Path: <netdev+bounces-22107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8976615A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F067C2825AD
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181FC15C3;
	Fri, 28 Jul 2023 01:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C715C1
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:36:23 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4743E3584
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:36:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f954d7309fso1978191e87.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508180; x=1691112980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBY4dqR8k6VkxPBBD1QDAVOvsIKWDS67oRxcN+6z7R4=;
        b=OdXU97AfLvUjjWYfRGF8Yq2orD02N8VH5dISv4o2HIBNcxoXWkX0dJWzFa6N+FAxzC
         XB6+d+XSAX88Vzj1vwNT68ObRxmYsUN7wWafRYg9qahGBj6VP8MqcyRus5JFOFvX8VRC
         uVtB2stZhsqBnqSY/tm6xpSV+GkpN5KKQqRC+JBRRokPF54a5T8jnQvyctiahw0d71Qd
         0hQ0GMbCe6UfzOAyxLf99/Z0bEmOyNSGhKot0M+En7SklvlCxQFFjsqz9aM8gnY9hMpz
         FrUQxTHe5OWx9oRUIn1NG9V55JWWMYJ8GG9QPJGdTs+xWzwsrBlaXN159fMJ93JE4y+N
         zPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508180; x=1691112980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBY4dqR8k6VkxPBBD1QDAVOvsIKWDS67oRxcN+6z7R4=;
        b=L8RCwJfdz14C8mvOO0ThOl0UKUf4L7YlYIz7J+9WKEiMj9DVyFjTRbSJpwY7yFiOEi
         vu328t1TkMX+Lcwi+jpf03qPYOpiXmLePthGZ2pZN6WMqF12+eQpPa4FBTVQ6QGIWw15
         ZhCWjQ9Rh9exrvSdIeIO1wEuP3HM58fkVzTdBkWkaIqZkpSEexS15Z0uqMqu7jzPyzrY
         BOqcxtB+P7/mYY8IsG9/y0ycCVgaRIYkI8LycncMLRD1S2n5egqj62/t0oP5s86Yn6SH
         j+smHk5MyiOY1huDq5euBCl52bLHcGrZroT9AUB4H4OOqsLahK2086HWM2M1IOvbvGCw
         mBtw==
X-Gm-Message-State: ABy/qLaW0KAgxB4sxHwPo8i1ipDPRiWsbsn8xLBwhMdbnJbCTSOCw9cI
	htfeffNsDxFm0HMA78JNYatObzxHfXJjAgNs4K0=
X-Google-Smtp-Source: APBJJlHgwB5gToyjMVHyY8YGLO7HADwdYYX5FTUcl+sxURYeMOlncTnSwDZJa6Zi/Zx1j8hiJcxH6uvOGCgmmHey1cw=
X-Received: by 2002:ac2:5055:0:b0:4f9:dac6:2f3d with SMTP id
 a21-20020ac25055000000b004f9dac62f3dmr345770lfm.13.1690508180156; Thu, 27 Jul
 2023 18:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <DM4PR12MB50880AA9F0C93F86B0A7A308D301A@DM4PR12MB5088.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB50880AA9F0C93F86B0A7A308D301A@DM4PR12MB5088.namprd12.prod.outlook.com>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:36:08 +0800
Message-ID: <CACWXhK=qGZA=_5PyTpjfdUmtBabtYo7eammoeX87y6vQ+B3NQw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] stmmac: Add Loongson platform support
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>, 
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, 
	"chenhuacai@loongson.cn" <chenhuacai@loongson.cn>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
	"dongbiao@loongson.cn" <dongbiao@loongson.cn>, 
	"loongson-kernel@lists.loongnix.cn" <loongson-kernel@lists.loongnix.cn>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 5:02=E2=80=AFPM Jose Abreu <Jose.Abreu@synopsys.com=
> wrote:
>
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> Date: Thu, Jul 27, 2023 at 08:15:44
>
> > Extend stmmac functions and macros for Loongson DWMAC.
> > Add LS7A support for dwmac_loongson.
> >
> > Feiyang Chen (10):
> >   net: stmmac: Pass stmmac_priv and chan in some callbacks
> >   net: stmmac: dwmac1000: Allow platforms to choose some register
> >     offsets
> >   net: stmmac: dwmac1000: Add multi-channel support
> >   net: stmmac: dwmac1000: Add 64-bit DMA support
> >   net: stmmac: dwmac1000: Add Loongson register definitions
> >   net: stmmac: Add Loongson HWIF entry
> >   net: stmmac: dwmac-loongson: Add LS7A support
> >   net: stmmac: dwmac-loongson: Disable flow control for GMAC
> >   net: stmmac: dwmac-loongson: Add 64-bit DMA and multi-vector support
> >   net: stmmac: dwmac-loongson: Add GNET support
>
> I took a quick look at your patches and I'm thinking whether this is the =
correct way to go.
> You are mixing up the stmmac generic layer by adding the Loongson HWIF en=
try.
> The whole idea of HWIF was to have it independent of vendor specific logi=
c.
>
> Can you devise another alternative without mixing up the HWIF?
>

Hi, Jose,

OK, I will try.

Thanks,
Feiyang

> Thanks,
> Jose

