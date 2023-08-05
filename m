Return-Path: <netdev+bounces-24620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D00770E0B
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C4B1C20B10
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 06:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDE1FBE;
	Sat,  5 Aug 2023 06:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22D1FB8
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 06:14:22 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F24ED0
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 23:14:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso4775960e87.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691216059; x=1691820859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKa1gFCEYJcpfcdueW8n7utVtoVqZuZPA9jW6WxZmK8=;
        b=XDc4jAOG1IHe1+C2tA4Ik7dK3fmto5DAG8lnnJnqxVEGXS+Yc39wa0va0N3yCbEpe3
         siMrZdIxy8ySK2wRWpG65KNJxhEaaw6eghzcwwqWT/4+B2zBBvwAbwlzLg3tKrHZLIB6
         zQmnOPTRjh3xOYBiQ87I8uVDQyeAdcgF8LuTrc9ymFxYBOpMgx/VQuiskEe5B6o384Qt
         CWmZx9vzrvhCr8HNBP2SrjB650ccW3snuI4HTi5b4DCir7KJbojp/6BiqB0ozu4nr9+K
         9T4vgaKdtk+IiURM21HUStoVz/8Og6tI9Z//9AQDRUEIsYuq/HGZqhj7YCFuByj33YlQ
         IITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691216059; x=1691820859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKa1gFCEYJcpfcdueW8n7utVtoVqZuZPA9jW6WxZmK8=;
        b=NqR2G/nk/ZeIyZuLcmnbZwJh0YGhWB9bviHAtlNmT7q7UPJkJF5z4j73SBRBHUojil
         YTGa9xUoUe9GTyCVgoqyUQzj4+a37IT2U4LufQF3LuedZJgIFNucQ2aAqjwvlzfvEMY9
         tM5JFVrcyVgkY0JfFhdvdUJOa9AVstuXKV31CJC9+VpepQPm7kIFZZLQNMClexpqYXsy
         TFWAM/N8q6/4YuFpE9T+P6vm64JT/aUf6GQxZAZV2LEiWK55askghjJgSky7gqJqk8oU
         Z9Szi2Ze5X6W5KjjCci20j7nNh3katBRiyGfp/DH2YhHDPGmoeziSqvJfFmLbTIaNvMM
         A0sw==
X-Gm-Message-State: AOJu0Yw1VJqlVf9cBe96xIavDTACnCBs10WQ5s31kwwTZZAWTe3L2Zod
	1n02nM/0aW+zt5SqvrLHjUWF6iaPF9Dbp4oddDw=
X-Google-Smtp-Source: AGHT+IGTTqwv+OJxqTA8sft4Lmd7dfjxsF/kWcDIC/kMk0awlZAWX1qMnB/h9udQgZuXBWB9kBwstvy8ACDkHMW0lqA=
X-Received: by 2002:ac2:4e97:0:b0:4fb:8987:734e with SMTP id
 o23-20020ac24e97000000b004fb8987734emr2376834lfr.68.1691216059117; Fri, 04
 Aug 2023 23:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1691047285.git.chenfeiyang@loongson.cn> <DM4PR12MB5088C3C2209B392C9CED2C9ED309A@DM4PR12MB5088.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5088C3C2209B392C9CED2C9ED309A@DM4PR12MB5088.namprd12.prod.outlook.com>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Sat, 5 Aug 2023 14:14:07 +0800
Message-ID: <CACWXhKmmJxWuVWN51jn6fKtJ-2Gntb67hFq77qa7p_F8+WpnVQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] stmmac: Add Loongson platform support
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

On Sat, Aug 5, 2023 at 1:26=E2=80=AFAM Jose Abreu <Jose.Abreu@synopsys.com>=
 wrote:
>
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> Date: Thu, Aug 03, 2023 at 12:28:02
>
> > Extend stmmac functions and macros for Loongson DWMAC.
> > Add LS7A support for dwmac_loongson.
> >
> > v2 -> v3:
> > * Avoid macros accessing variables that are not passed to them.
> > * Implement a new struct to support 64-bit DMA.
> > * Use feature names rather than 'lgmac' and 'dwmac_is_loongson'.
>
> This is still mixing up with HWIF.
>
> As I tried to highlight before, if you are using a custom IP,
> you need custom callbacks.
>
> As far as I saw, you are mixing dwmac1000_core with
> Loongson registers, which is not what I believe is the best approach.
>

Hi, Jose,

The problem we encounter is that we have three different layouts of
register maps. To avoid mixing up with HWIF, we should use three sets
of callbacks with rather similar logic. Maybe I can extract the common
code blocks to functions, create two additional sets of callbacks,
namely dwmac1000_loongson and dwmac1000_loongson64, and then have the
three sets share these functions?

> I understand that stmmac is confusing and needs a lot of revamp.
> Perhaps we can switch to regmaps first? This way you would have
> a lot more flexibility.
>

If we switch to regmaps, we still need three sets, and I think I need
to revamp more :)

Thanks,
Feiyang

> Thanks,
> Jose

