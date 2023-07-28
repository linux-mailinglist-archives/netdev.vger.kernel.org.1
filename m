Return-Path: <netdev+bounces-22114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A87766179
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C071C217A7
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C715D1;
	Fri, 28 Jul 2023 01:47:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93D7C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:47:25 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4476EF2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:47:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so57236e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508840; x=1691113640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm1gYbFDcg5j5Vi8V4yEePrlSrcnPZjYLr+SXH4vwOw=;
        b=WdbaMnUWaFWX0g3sadRN5u1RF6/arT0wqY3EfBT8Lf64KvCTcJlOgT9kpBkr4/bk05
         CVYb9yv5fmcxCrCR1zXEBydOl3gkEgWuOuKZyYIHWi/6C4XS0l1UGC4sgXB42Im/mV9F
         5x6670+KAJgTPItGFnWdu/WAXZ6DLJvzS4eUR98Ak+XNuSva19N4Y+yWNO+n8HVPb6C0
         etYm06H5rCrLegNBOm6fm2VpqRHmRt8gn48GgJw//sA5mDS7uCyokYE46mHVLyM1wvvl
         x+lrwocNdUsS6ZMvS3oCpPuPyjYNCquNnePHzl/+tt7H0uJKRKCZ7JO43PfpVohXQ3tu
         2dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508840; x=1691113640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm1gYbFDcg5j5Vi8V4yEePrlSrcnPZjYLr+SXH4vwOw=;
        b=ZGOsHqdv3aoDwykV1riThzmu1gWmsbDEZ0o9GPW44cUZdDsCaerFeJnXSuctzyFJeX
         sDlCLy/zXVHbxBdTD2fc9VhNyekKyhVQtkNXDNmtLnDMmMFJ7G/gDFA7po3uBufH1Qna
         NxZFUI77toZwEbJZJliNBl1ZasqxRfPN+CY9sQeJxnO3eI/A/wE9I20HgLMPqX1DXsU7
         pfvmKTtWOst17K5FF/CLQE2ByvHD8Ayh/7AH7aBezAtqBxr0IZ1JdpYEKtDEEo+9jat0
         hK9UnmEXY3t4Yr/R0zDb+lfJoDVReOC0218O/cnJ9gGYfQRgQh+lToUveiXOXUyFfRbK
         A5ag==
X-Gm-Message-State: ABy/qLa8f6ZpJm2xdAVg13GDXs24NtZcerOKBVWjP8k51gIsoiW/25q8
	KNAbkXYShKJFiqbHIhDeR5UqzaNcr6+mQQB8Jh4=
X-Google-Smtp-Source: APBJJlF3wfXSgmojSnvQ5m9sqGoPdSc5VNoFI4Nu07B1CKoKJNFr0spXOvZMfswk+r2Y5/hzGV3eZgmHioMhKLJ3ivs=
X-Received: by 2002:ac2:58cb:0:b0:4f8:1e2a:1de1 with SMTP id
 u11-20020ac258cb000000b004f81e2a1de1mr324875lfo.29.1690508840330; Thu, 27 Jul
 2023 18:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <f626f2e1b9ed10854e96963a14a6e793611bd86b.1690439335.git.chenfeiyang@loongson.cn>
 <26015def-bee6-4427-9da4-ca27de8c1d87@lunn.ch>
In-Reply-To: <26015def-bee6-4427-9da4-ca27de8c1d87@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:47:08 +0800
Message-ID: <CACWXhKmtJCQsPb2AoyxHEMzhxmanmYheM9dKAGdkf7M3fqa75g@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] net: stmmac: dwmac-loongson: Add 64-bit DMA and
 multi-vector support
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

On Thu, Jul 27, 2023 at 6:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     case DWMAC_CORE_3_50:
> > +             fallthrough;
> > +     case DWMAC_CORE_3_70:
>
> You don't need fallthrough here.
>

Hi, Andrew,

OK.

Thanks,
Feiyang

>     Andrew

