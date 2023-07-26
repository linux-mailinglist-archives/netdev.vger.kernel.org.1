Return-Path: <netdev+bounces-21352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAFC7635D4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75E71C2126C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3769BE68;
	Wed, 26 Jul 2023 12:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CBCA77
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:05:49 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E819A7
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:05:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb7589b187so10397779e87.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373145; x=1690977945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAEXw+6RA38h/W6nJw+T6IpUa/B0r33gmMC26vdkdK4=;
        b=nJBjr3N11j5i/SMU0Fwgir8luXAhZ7MVGCPET29G0prSRCO6mlmeH1CZ6cuIy/Wda5
         G+Nj8V6zswsmF2hHw2MAlTeThJm+3oRLoOBS4rJG376mD7V/1JIsVk3GbZk2NXR3epSd
         lMNNc0xPABxWuYc+90kpNjJYW5Fw6P9VUdWAgXqZ2kL5zjCbjNLoCFyIxRk05FwtKwZ0
         SHVettuLFvPvBAzmwgQSPzLIiJF7wiZuyFnSBMB57pWMb32fBeOmWcWbMIga+mimk9k3
         x+cIHB9stcIc4arv1V3P930ubhystLElbuFShGJZb3m3e8qBk6jy7eiFgUefSU2zc71f
         BVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373145; x=1690977945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAEXw+6RA38h/W6nJw+T6IpUa/B0r33gmMC26vdkdK4=;
        b=FpJ8r7uuH22BJRqhBvcy9G9ZiO0DKM9jWHnvcXepfenUwLRNJfBwBU3SsbOC0vJNDS
         OeaSogUD8zaUNOjCJxLFUOvnsLqmsbAAC6JABepg4RcRg2Z4T7oktM0Bp+F4O20eUzC+
         xLSkP9XBGYhubQGExi3sKhCZ7E2CtO+YGjoqrHxnkCQ8GoKQ9xiumZc3wGbDE99ps7cs
         jXvnZVcARihpb5fVVJ8vugP5zxFWy9Rs1YELQ5g3ihRRau7/z1zZF+JKYZZnFKhPHmXJ
         iqfX2f22Ie6RnT+hyZ8g8d8Th7GMDkgv9PJIkAjdeliKkb3enjGK/xtF0KzHMlM/U0q7
         HYqA==
X-Gm-Message-State: ABy/qLbAC2Sn4ziyMZFDEG6SLKR1gBv+8jYafrkp7dBTWipVhEjbDJYi
	3sF9WXezX0uU8mDLidZsgiq7I2SJlejrgs+StfY=
X-Google-Smtp-Source: APBJJlFhY20uIKiK7Anfu0/vcVMOJpVH3HbaDJ5654BjtRO+rmM4DWXLnO9UeBTdYSLK3b31hFacYd8cv45b0XoqAOQ=
X-Received: by 2002:ac2:52a6:0:b0:4fb:911b:4e19 with SMTP id
 r6-20020ac252a6000000b004fb911b4e19mr1147466lfm.35.1690373145044; Wed, 26 Jul
 2023 05:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-3-marcin.szycik@linux.intel.com> <ZLqZRFa1VOHHWCqX@smile.fi.intel.com>
 <5775952b-943a-f8ad-55a1-c4d0fd08475f@intel.com> <CAHp75VcFse1_gijfhDkyxhBFtd1d-o5_4RO2j2urSXJ_HuZzyg@mail.gmail.com>
In-Reply-To: <CAHp75VcFse1_gijfhDkyxhBFtd1d-o5_4RO2j2urSXJ_HuZzyg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Jul 2023 15:05:08 +0300
Message-ID: <CAHp75Vev0g09sn4oD07=o7fefziQ06Qz0YOK=zhTKtOcbghBGg@mail.gmail.com>
Subject: Re: [PATCH iwl-next v3 2/6] ip_tunnel: convert __be16 tunnel flags to bitmaps
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, wojciech.drewek@intel.com, 
	michal.swiatkowski@linux.intel.com, davem@davemloft.net, kuba@kernel.org, 
	jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com, 
	simon.horman@corigine.com, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 3:01=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jul 26, 2023 at 2:11=E2=80=AFPM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> > From: Andy Shevchenko <andy@kernel.org>, Yury Norov <yury.norov@gmail.c=
om>
> > Date: Fri, 21 Jul 2023 17:42:12 +0300

...

> > >> +    __set_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);

> > >>      if (flags & BPF_F_ZERO_CSUM_TX)
> > >> -            info->key.tun_flags &=3D ~TUNNEL_CSUM;
> > >> +            __clear_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
> > >
> > > Instead of set/clear, use assign, i.e. __asign_bit().
> >
> > Just to make it clear, you mean
> >
> >         __assign_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags,
> >                      flags & BPF_F_ZERO_CSUM_TX);
> >
> > right?
>
> Yes.

Actually in your case it's an inverted value, but you got the idea.

--=20
With Best Regards,
Andy Shevchenko

