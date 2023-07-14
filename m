Return-Path: <netdev+bounces-17743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC8752F49
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506A2281E68
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5D81C;
	Fri, 14 Jul 2023 02:16:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6F809
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:16:34 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B72707
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:16:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso21518771fa.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689300990; x=1691892990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4cbxLvx9uukqwC3ST3XVi//0HD0ikRNdUx1Ub10ekE=;
        b=jMTvlQrsZDr6AKA/H9kXnJZ4BZD3H+pxm0xSo2oNJPXj+DmDtBWEQqgFcvrN6UH+as
         nOIuPnE5typjxKOAy4rfJ7i/aFzSbHXltTW5kqef+gf3XlZ3m7PCbtCPu68SAK443BbR
         UjXb9J031SvOKGPzM3vEkcDKTR2iQxEhLuQRsYwJeTgkXCiCMTxSCoR0EBrahnJsvUMR
         FM+IA3iL+l40v0qU6EVDibVKJKc8KoL1i8FARTdHTt91Tm++M3cEji3eSmE298h95P96
         MgKDkAPytf4A3HiZIIDoRcrpHkrhPUSWjehWYnRJn89gcTOT5YqM8uHvpIp028bNFl+h
         wgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689300990; x=1691892990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4cbxLvx9uukqwC3ST3XVi//0HD0ikRNdUx1Ub10ekE=;
        b=h9k4x8XpGaqqrsgiWgLKkaHQF2kf1RGI3aXbNtWmi7gHMh0bMuNyyWAJGAEgiGmgi4
         TLbfPM2opHnNDndUM3EAVM65HQBavhQQTTcga7JMcoLsTipFi4LZCIcrkMpcGKGz/OXV
         iZGwYjaLBC3gEXDTy3twd/VnllhLTXzaaHTlE/JGLL41y3gjdTSgpIo6XGLjA30iQ/GR
         mx64fHOzxNci//qpw3i24InAzCVSJqT2Axle6Ygljl8Q90E3S/Ftlath82fI4gKLomtN
         3biQMH0z7d3TC9NLiShDKsNXJ3d0SdFYqkw7AzW95DTvaX0GKB+xdeT2GaYjoRQ2X+61
         m8sQ==
X-Gm-Message-State: ABy/qLaBuDHyRGz0UmBjJSLCKstPp6N6OlgTWEd5wVNoZsllZEAY07n8
	+FssgW/a7OsHQPK6bYNDs8Put8VG7cDubt4Iaqs=
X-Google-Smtp-Source: APBJJlHIpHlJOcS+oulRd+xIOlCCQm1kL+13HmXP2W6vLtW443zx5o6D0wzT5oPeRQA9am54WYO7dv9mE72JhlFi3UU=
X-Received: by 2002:a2e:9691:0:b0:2b6:3651:f12f with SMTP id
 q17-20020a2e9691000000b002b63651f12fmr2884902lji.3.1689300990481; Thu, 13 Jul
 2023 19:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <a200a15b1178dd8f6b80a925b927d30d4e841c3c.1689215889.git.chenfeiyang@loongson.cn>
 <0ed12e00-4ca8-43dd-a383-ba6380f21418@lunn.ch>
In-Reply-To: <0ed12e00-4ca8-43dd-a383-ba6380f21418@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 14 Jul 2023 10:16:17 +0800
Message-ID: <CACWXhKnZcY+hA-QQco911G5E5Zs4MJPN+xA8iRX6BfhfgSDr+A@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] net: stmmac: Pass stmmac_priv and chan in some callbacks
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 12:02=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Thu, Jul 13, 2023 at 10:46:54AM +0800, Feiyang Chen wrote:
> > Like commit 1d84b487bc2d90 ("net: stmmac: Pass stmmac_priv in some
> > callbacks"), passing stmmac_priv and chan to more callbacks and
> > adjust the callbacks accordingly.
>
> Commit messages don't say what a patch does, you can see that from
> reading the patch. The commit message should explain why it is doing
> something.
>

Hi, Andrew,

Alright, I will make improvements in the next version.

Thanks,
Feiyang

>         Andrew

