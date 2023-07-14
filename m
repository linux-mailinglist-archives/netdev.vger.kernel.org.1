Return-Path: <netdev+bounces-17742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89324752F47
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AAE1C214CA
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59B815;
	Fri, 14 Jul 2023 02:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A33811
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:16:22 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2F526BA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:16:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso2420763e87.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689300980; x=1691892980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2g/MXvN83ceJtO7KV0hkTCgKaz+BrPyW3/qs/kgHp0=;
        b=bZVdC6fJJOoZ7Ze/VicNX6Niny4G+QmSQTV/MEfOYqussMKjXcVq/4KFuixAJug+rX
         8V2HE+OsqtGprqWR3ROYxFLQr+PoYSdCody8qF43JwoqHtKNH/ZixC2amM8RueVn9x0Q
         e1mjth8XP8uvBxMuq+TcnsR/PcPNSIAywpOtbR0fvft1MbLTh51Ed9G5LmLuywEKSbxf
         IA1a+FBuPTpuHU/Ly5+IXNrlOu7eucOXhtZL87NhodejFhGuG2B08+rHXcAb9r5OxugN
         RKBQwWsWkIsNP6RyvnVMSuJuRuMuuL2II8JIak6rc54mt2XJA2Dh87b+GVdNMaGffo5H
         2q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689300980; x=1691892980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2g/MXvN83ceJtO7KV0hkTCgKaz+BrPyW3/qs/kgHp0=;
        b=EsANiwnBS97ix+liRcpZ4kKdRI/gdZaPvuSAtcU4QHPnSswADAXinmak5V513d3uem
         3rIEW+EJJM5B6EBgZVuMY8Hba7SAjnLUUPXVBN6JoqpQHRYHsUktbT2cMdSOZ74XWX9C
         pEVkrM0TCsh8MQo6zSA5VlJHvELaglr5WWNqpzOtAiu7IrF69GTehi7o4a1E4xj7q0u7
         dm7Q0EUaD9lne2cam22D9Rknbv2KqvQ2iHVqqLZNHfio1a56eyy4/eQRWgtaHeO5Bd4+
         XBquq6wtg55EBZohU1gZpEdUQIQ0CZDCZ+NjeXAJ9SuHNHSm95WR86Ed8zligss5P/68
         U+2g==
X-Gm-Message-State: ABy/qLYzAgUnS7e94unoK+CCWt6mblFmv1fiW3Aq/dx0WJ66UU4JygZD
	X8Bv//vrki1dnaqYOSXBjPlZerpeZIMAnL6F8YE=
X-Google-Smtp-Source: APBJJlGuR/b6EZSldBIkCBY/xGs9SrtbiUUL7b5CnHkQ/yW38NhqfPbt+NmTHfy4QLROSYzwrPoxr3bw3jEqwvzIdzI=
X-Received: by 2002:a05:6512:4011:b0:4f8:5e49:c610 with SMTP id
 br17-20020a056512401100b004f85e49c610mr2875239lfb.35.1689300979729; Thu, 13
 Jul 2023 19:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <2e10d9d1-e963-41fe-b55b-8c19c9c88bd5@lunn.ch>
In-Reply-To: <2e10d9d1-e963-41fe-b55b-8c19c9c88bd5@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 14 Jul 2023 10:16:07 +0800
Message-ID: <CACWXhKkUJCFV8DKeAOGPQCfkn8mBhZvBJBMM8SYVgVKY8JEyRw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] net: phy/stmmac: Add Loongson platform support
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

On Thu, Jul 13, 2023 at 12:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Thu, Jul 13, 2023 at 10:46:52AM +0800, Feiyang Chen wrote:
> > Add driver for Loongson PHY. Extend stmmac functions and macros for
> > Loongson DWMAC. Add LS7A support for dwmac_loongson.
>
> Why is this RFC? What do you actually want comment on?
>

Hi, Andrew,

I marked this patch series as an RFC because I believe it involves
significant changes to the dwmac1000 driver. I want comments on the
design and any alternative suggestions.

Thanks,
Feiyang

>     Andrew

