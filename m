Return-Path: <netdev+bounces-22112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B853A766174
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF028259F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CFE15CC;
	Fri, 28 Jul 2023 01:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FC15C3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:45:57 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C7F2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:45:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2811745e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508755; x=1691113555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yyz+QOPnTCmJDH2mcI7Jd4URwi0CMO5PT6P34rUHZc=;
        b=eUczXDLCXgtgG1jVtwtgDgj9HtNPXbYz69ZipKt6Q1D9mp0tcHF+vL9BeGSgVxujR0
         CY7uUhgcXH3aJ7SiZre9jqU2/vrOb5sYvZ0qM4ffgV56O9YHlo015wykg47gzvalNoXD
         /7/4qdbHl29Sdjd/MajN4SlPP12eg0q5ECt50OqycuFpMgVx6O0l/xEgsALYKZHe3nk2
         d4crzOjUeAxutQwb++UJQYgJ1dziKyLgFy3XE6Iz1dmgiulhDgGk85qjqo7atCucPIvN
         sEiSubmvjFXHsUiYUZ7s06O0eRzUQgZDPtHQpD3TO3B5s0cXLHsTx5Epfeer2go8UlYR
         myow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508755; x=1691113555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yyz+QOPnTCmJDH2mcI7Jd4URwi0CMO5PT6P34rUHZc=;
        b=DGPYt5mS5WdYzS//MOvys6XSRXcAnRkPpw/35PZ13a325hSX6+gZokEJcvO1dDJ6PS
         OcXYuzeOLo01TOlGFFKUuSEhP8yYzZ2myP9IgEBFeDfcVVIQNTa3pZh3vcmUX0mrCxuD
         iNMkHluLg0thNJqPSHqYsBtroeV2qK+AA773JRdPszxqZ4n+s5/30tmHoOopaxIob2tW
         9po+duT2SBN5QsxMaRKNuyoSTFrA4NdpMu3VnDtz+Z1xdaIES8xdpAa/oUCXT3xLZBt3
         KwQ/23D+Q0l4rE4fNdwdt8zawDTmhgn5oP/siLxeLRLPQDF+abDnj6+TCKq01Pl9WAam
         cJZg==
X-Gm-Message-State: ABy/qLbAZZrBPJbCCgga7DmyLq1n808v6nT+DIpoRRGWpJXhJOXqg/fW
	T5XhA//eZAxXMHiAqGxxKOKEnZOh6FnSjDOnnJQ=
X-Google-Smtp-Source: APBJJlFTX51B17BAYAKagPQdYNaJLvIRaYq5TT3/2yqQbBl/G5EanVIn7evMpSOeq/634KLkr4sgPP8ZA3mX0/AU73s=
X-Received: by 2002:a05:6512:ac2:b0:4fb:9631:4bb with SMTP id
 n2-20020a0565120ac200b004fb963104bbmr704018lfu.11.1690508754561; Thu, 27 Jul
 2023 18:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <a752f67c6cfe481a2329f1f4b477ff962c46f515.1690439335.git.chenfeiyang@loongson.cn>
 <30e8518e-4862-4aa5-afda-2f511dde2b44@lunn.ch>
In-Reply-To: <30e8518e-4862-4aa5-afda-2f511dde2b44@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:45:42 +0800
Message-ID: <CACWXhKkYY_g6Eo3G3TVT-AzGRa-HP2fTu9biQ6OtpPh7_hh5HQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] net: stmmac: dwmac1000: Add Loongson register definitions
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

On Thu, Jul 27, 2023 at 5:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  /* GMAC HW ADDR regs */
> > -#define GMAC_ADDR_HIGH(reg)  ((reg > 15) ? 0x00000800 + (reg - 16) * 8=
 : \
> > +#define GMAC_ADDR_HIGH(reg, x)       ((reg > 15) ? 0x00000800 + (reg -=
 16) * 8 * (x) : \
> >                                0x00000040 + (reg * 8))
>
> please give x a more descriptive name.
>

Hi, Andrew,

The x is now related to the dwmac_is_loongson flag. I'll try to use
another method.

Thanks,
Feiyang

>        Andrew

