Return-Path: <netdev+bounces-24621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A60C770E0D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F991C20F0B
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7EF1FC5;
	Sat,  5 Aug 2023 06:15:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C817C6
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 06:15:20 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA2F4ED0
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 23:15:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe3678010eso4760770e87.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691216117; x=1691820917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4M7nMTGRw7KfcQ96lwyRUaadHg5/rmosqdVLwPSAnI=;
        b=roA6BYlwpOXOuJve46gTJ3PcQBuIzIF4yYfbR0rpC65W9qV0RpWi1t5dhzf0Yzh5Cp
         UDfeBDCFBvdfH5nrCcIPqhotxrBWNfbpgEVrp2xmTozpCafdJLN6nRYBYMxsAk3gAGC5
         lyYuOiClTrlj5P7ltNbAbi3SpCz/hiTcQnU3owuvaFa5XL2D6FVhKcqPzuC5PmO3ktu8
         Pwlc9W0AgSp7Nh0ivMdKRzNlUPb8NG+6gNoQZD7nftKzz9y/eZa9FRs8yPCM13sU3GI9
         F4NqtUbgKJ9iH8F1xKZu/FrLQQBb/ADN0k1JjWHb2R3qLfcDMC9FBS1eeSE+T09OAEkb
         WvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691216117; x=1691820917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4M7nMTGRw7KfcQ96lwyRUaadHg5/rmosqdVLwPSAnI=;
        b=bZlVc+GBoWBYCu/PVutVMd9ng3dy7XSnc1Kek7mLNcMdRlIG0Z4wBQ6c0k1SqCi/lq
         1lxjqZsK0UF3Owfryx/3hE9St83avrCv7ETtGjxwDUTPq3J4B6AZ7iIGIinHw8BM+EgY
         NTgfzgVxDCM/3YNvT7Y8pQQ4/KXLlYD3JHdFjKU22ZilZVzav12IVvSoU7mJcIzu4rn5
         r7JMiT0DNi+6/HckxzB5/32ZUkDuraqLlmkZcReH7IV1aBrFa19XExzjYOFmXfrBC146
         oJAg12bR+5HJLyUiNt3+tL37R8IP+0rKcxXJLVQnFj0z73CqW05/kCSrV+AVzKQAYxNk
         rGKQ==
X-Gm-Message-State: AOJu0YzlaqbB9uwBqNeX3sJa/QvN52bmuGUFI1XtDV+PFrWxlPeUPhrP
	hJJO9jpYja+xmuYgDa6fuA2uubXnxPO5EjdmGdw=
X-Google-Smtp-Source: AGHT+IHTtLwOEGQZl+ohLm6pAe7c30jvFwwLmwdijBjjcIS9kpvbLH4m0JCiNdKuIauEuR9VqNABxtPvJv24CMVazBo=
X-Received: by 2002:a05:6512:3b7:b0:4fb:81f2:422b with SMTP id
 v23-20020a05651203b700b004fb81f2422bmr2176422lfp.54.1691216116956; Fri, 04
 Aug 2023 23:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1691047285.git.chenfeiyang@loongson.cn> <021e4047c3b0f2c462e1aa891e25ae710705ed29.1691047285.git.chenfeiyang@loongson.cn>
 <DM4PR12MB50880DE89F513EFED10E2B95D309A@DM4PR12MB5088.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB50880DE89F513EFED10E2B95D309A@DM4PR12MB5088.namprd12.prod.outlook.com>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Sat, 5 Aug 2023 14:15:05 +0800
Message-ID: <CACWXhKmOo9JHsjex=8i6UuBdAxqFUGP58zcWn3KjGgNqucewQw@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] net: stmmac: dwmac-loongson: Disable flow
 control for GMAC
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 5, 2023 at 1:29=E2=80=AFAM Jose Abreu <Jose.Abreu@synopsys.com>=
 wrote:
>
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> Date: Thu, Aug 03, 2023 at 12:30:35
>
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -360,5 +360,6 @@ struct plat_stmmacenet_data {
> >       bool dma_reset_times;
> >       u32 control_value;
> >       u32 irq_flags;
> > +     bool disable_flow_control;
> >  };
> >  #endif
>
> This (and other patches of this series) use a bool flag instead of the
> Recently added bitfield flags, can you please switch to the bitfield flag=
s?
>

Hi, Jose,

OK.

Thanks,
Feiyang

> Thanks,
> Jose

