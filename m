Return-Path: <netdev+bounces-22116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B629176617F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30971C21785
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520B17D1;
	Fri, 28 Jul 2023 01:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D815D1
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:51:55 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D9F2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:51:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so1293881fa.3
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690509112; x=1691113912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spl6msirgwM12Bz3dNNSl2svImPXOjpVr2B1RLvkZXY=;
        b=DwhhtH676J+xnO7Ti6I5DxRcKK1/tNIiUspuBI2YPxQbBzWU23RspV7Z8ZIQ1Qn4WP
         nzyVMC8VSYzI3UGV85rrIyEQ3RKhqyYcs1Q9Moy6o1muJnUi0SKzgiKh7lW9qn21TDjB
         hwnreAuKolsWCAl/trzGZTbWEZVgicqIcztfZ9dh4x1idm4VMtQ7GDopkOpQISulzIwl
         iw3g8RqM2xLBmnlqH0oC6WXQ7WD4R2yyGvdvXwIBAJSgPG79eTcHfaSp4kFNlBQA+Jky
         GglqPSj6325MHZBm9xUJFLJu7zlz9eVJFr3DTrOAZHm4XgY99xUgfyibeb+cSc3kJC2B
         hrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690509112; x=1691113912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spl6msirgwM12Bz3dNNSl2svImPXOjpVr2B1RLvkZXY=;
        b=dFYx1uQFEmgIux8EpJ163pZadIA3fJXTpGQaXoRJdz8yuHGEg+g5iIYwpVXjpFUL3k
         65NhwAE1txQjmDC26kxvENDXouB2tnvStYHeiwdOpGtvOqbGC4w8l0gKc50PPFNg3lAJ
         z+Y9A8b7ltKx5mEJi1j17ganalWsqJhx8ceH2nk62NtkDQf05c149veVUgCkALbxXbui
         De2IReBZXBuJtLtD0Oz3lQ3li3DIGjZwj/VosT2FTUxYLiZONJHp1wJ6h9SZ0rTd4Qwa
         U+kZdAvsy+wFMPT/WNaPfhhNPvsLXjFl5ccIKoajIzs6gwm0n/I4MhAati/YX6PycZbZ
         AdKQ==
X-Gm-Message-State: ABy/qLaMaVJ1QYLur7kp8DQbisWfzuVa2Hp6papUKwZ+kkD4CIh3JRCw
	2IymHjeeoxi82im5I4RH/PkY8awaZaUD5ww/iPg=
X-Google-Smtp-Source: APBJJlELIy6CzI7EadvaDv1i5jG2qBH+5qOGvagZFAIrDNAR32mZVOSW6K2uYyaAw2I57TwBIT220Ok980xXve9eHKM=
X-Received: by 2002:a2e:8816:0:b0:2b9:ac48:d7fe with SMTP id
 x22-20020a2e8816000000b002b9ac48d7femr523226ljh.38.1690509111900; Thu, 27 Jul
 2023 18:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <373259d4ac9ac0b9e1e64ad96d60a9bbd35b85aa.1690439335.git.chenfeiyang@loongson.cn>
 <51338bc8-92b0-4aab-92f8-1e5d178b05d7@lunn.ch>
In-Reply-To: <51338bc8-92b0-4aab-92f8-1e5d178b05d7@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:51:40 +0800
Message-ID: <CACWXhKm9Qu3CUjGpqa_5dx74MDVHODKVrsotTi0+V03zDBVqwg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] net: stmmac: dwmac1000: Add multi-channel support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	linux@armlinux.org.uk, dongbiao@loongson.cn, 
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 5:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 27, 2023 at 03:15:46PM +0800, Feiyang Chen wrote:
> > Some platforms have dwmac1000 implementations that support multi-
> > channel. Extend the functions to add multi-channel support.
> >
> > +     priv->plat->dwmac_is_loongson =3D false;
>
> I don't know this driver, so my comments could be wrong...
>
> Is this specific to loongson, or multi-channel? If you look at the
> other bool in plat, they are all for features, not machines? Could
> this actually be called priv->multi_chan_en ?
>

Hi, Andrew,

It is specific to loongson. I think I can add some features instead of
using dwmac_is_loongson.

Thanks,
Feiyang

>      Andrew

