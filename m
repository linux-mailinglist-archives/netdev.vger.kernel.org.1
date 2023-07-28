Return-Path: <netdev+bounces-22113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79605766177
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3361D2825D8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1115D1;
	Fri, 28 Jul 2023 01:46:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7D7C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:46:55 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCBF2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:46:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe0c566788so2835058e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690508812; x=1691113612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxKgytFLxzXVyJZBJwebLIhb8nwv4d9rqhg53vYef1Y=;
        b=qgDbTIJf7vNP10O6CyjC7aJa8EbZMGCRFIf9fRH0TWJups1odl5BlgLJKPp9GrPvxB
         p3V0XvmQIOKGLBkVfuE6FhnxK/HOFsWMdi8MAB2woquak0c/9/ZO2mgDlaxfUM2ANO/T
         aMlZjEzAQYwTWKCBeFQ4gVkzcp3FaA3kWsW/nyPOuQmFa+xIigB07msYsic5LHOKiG37
         18Ay/bVKAs9GD5F7Lv3nQsULoB9oUlix2ItLt+ggZsN+zk1VeK3TeEzeCWqxfOyvdhgM
         PwuLJbvVgiXL1XhG4RCGSpo1LQ13hrqSEM79GtRlSfuPH7wzIpN4oaodL7ycna9TUwc9
         qq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508812; x=1691113612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxKgytFLxzXVyJZBJwebLIhb8nwv4d9rqhg53vYef1Y=;
        b=b+MiP0bsz8SFODa/I2Vi+rrJpZmnLRkoJrpqiuKXS88/h33DP1rE1VI6+ejcB9bG4s
         pbWVy9xmluIsu1PGAfddv+FKXDrefYNua3fpFdAV9h08y9GuBwl05Z+UqviqamWi8Rnk
         pcWNau7yebZzd2BLLmWGgnp/nXLJSO8zEEJWt7sdMIs569V/QyEpocditZEFRi1me1lY
         lHDZwCU9W/+i2s9hUVGBvlnCOJGTA5DNkC8dUNchZiTvuIHfBRAPQI/LZOfigslp/Msf
         WG4ejYliu0e6IPpdU58++x0g/5fY3hqiY0eZBdy9iem4TFKm/oDo5Th3KqnbHPeLxii0
         ZYPg==
X-Gm-Message-State: ABy/qLZoRKSVfVqqBzhl9jvce9ZCqa7IUSadMsqxxTkG66qWKeENfr0b
	+NNOLLXrek3oAddyGoTfsc/dxH9HsRDJmBMD3Sg=
X-Google-Smtp-Source: APBJJlGIArvhwpZZCRhnfuAR+rY9ZKw6xESIhjzfTfichxQnRgzkX5C4oTqzLUENfoH0WF2ZMdIfj6L/kML0zMcBB6U=
X-Received: by 2002:a19:ca03:0:b0:4fb:8771:e898 with SMTP id
 a3-20020a19ca03000000b004fb8771e898mr490409lfg.15.1690508811655; Thu, 27 Jul
 2023 18:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690439335.git.chenfeiyang@loongson.cn> <0ec0ae938964697010b3d035b7885e4dda89b012.1690439335.git.chenfeiyang@loongson.cn>
 <38591e4c-c4f1-4b6e-a9fb-57f349735bb0@lunn.ch>
In-Reply-To: <38591e4c-c4f1-4b6e-a9fb-57f349735bb0@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Fri, 28 Jul 2023 09:46:39 +0800
Message-ID: <CACWXhK=mBiD4cBRWixiiPh4UVppLVH-TH5SA1Ab2MrBpQtGmvQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] net: stmmac: dwmac-loongson: Disable flow
 control for GMAC
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

On Thu, Jul 27, 2023 at 6:36=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 27, 2023 at 03:18:51PM +0800, Feiyang Chen wrote:
> > Loongson GMAC does not support Flow Control featurei. Use
>
> No i in feature.
>

Hi, Andrew,

Sorry for the typo.

Thanks,
Feiyang

>    Andrew

