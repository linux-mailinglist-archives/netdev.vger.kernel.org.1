Return-Path: <netdev+bounces-24499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CAB77063F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A89A1C217CF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14802CA7E;
	Fri,  4 Aug 2023 16:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1DBE7C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:46:52 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC16B49E1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:46:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4cdb71f6so3196885e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691167607; x=1691772407;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAa65FhNaSq/W7CDdnihE/ciUHzmXzQcDQo/PCrMzuM=;
        b=kh/fXfhfGs5tHoESmM/PofJleVcGm1uhWv2XNzmtWPg3m60OgkB8SUsKX64hZY8OX9
         BkB+40ZldQ5wO2YCJEQngSKWfMM9+82M6TQNSQs3xF4kbPQPgm152wA73qTB8lbMZrIE
         CL7BFdBL0eQQx64QWGWmIq+97D0uDqsBYy8oNlc8VmfakSA2He+VAAiiVU0c1L7v82Ny
         Qgjrfn89GnO7qgtQqJVMBoCsKkJut8n5zhUFABovP7nMZQ/ZQtZu8+qJod29NYBz40i1
         ctjgat52tAR1fCsbM2O5mLy/L/NuG1efTdYGy+TQbTZxNhFsh+q9ASyZsMXB5yWhp2wv
         RQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167607; x=1691772407;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wAa65FhNaSq/W7CDdnihE/ciUHzmXzQcDQo/PCrMzuM=;
        b=MXoiHlyvwvg4NKDr1XcwtUW2JBSn5BAsEk0MT3Te+tNSnaLTNE4O7xfqylzS8gc3aq
         1ChEc6ZVLwtUax4VWfJEjaaKNuKemG+ygC7dCopTlbZ1ZKI/zEJNDm3iqXCKzugMNiYd
         Cs3Ihrr/3GEmj3h1qblLTjrFX+7bM6WvIlZUi2YFv7AuCxjTjxs9mAntHpTtFqx5jESb
         0JSB7TlYFTvV+5wlZgSHbN6Gn5beYWgC2iDwy/oe4QNI9ER//gZzkvwyUJ8zsieydsVM
         tOZx5WqYLPEAGMLZTlXYL8DlhVsM0246srhTi1rKPi238n9tR44sHDJrV5oz+wSDOZhe
         7Wmw==
X-Gm-Message-State: AOJu0YwZxHsU3D4hhgzeMh2DZsGSDfp68DDzkF7wsvw6m4iIPJeiN5dp
	mY4wTVM9U37XEwVVxdSEVhFpRSiikd8=
X-Google-Smtp-Source: AGHT+IEG6KT4vsYeqft18ZcqRtNndu1kctn5ME1VcGmFP5KYIKZperErPf8rZ+2Xl+ehJ3jVVKG/Uw==
X-Received: by 2002:a05:600c:2193:b0:3fb:f926:4937 with SMTP id e19-20020a05600c219300b003fbf9264937mr1692927wme.31.1691167606908;
        Fri, 04 Aug 2023 09:46:46 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b003fe0a0e03fcsm7224286wmk.12.2023.08.04.09.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 09:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Aug 2023 18:46:45 +0200
Message-Id: <CUJWVSRUAJDL.2U3MGUFOREV8Q@syracuse>
Cc: <stephen@networkplumber.org>, <netdev@vger.kernel.org>
Subject: Re: [iproute2] man: bridge: update bridge link show
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Ido Schimmel" <idosch@idosch.org>
X-Mailer: aerc 0.15.1
References: <20230727172208.2494176-1-nico.escande@gmail.com>
 <ZMY7dzm1Sd/Htg9c@shredder>
In-Reply-To: <ZMY7dzm1Sd/Htg9c@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun Jul 30, 2023 at 12:29 PM CEST, Ido Schimmel wrote:
> Thanks for the patch
>
> On Thu, Jul 27, 2023 at 07:22:08PM +0200, Nicolas Escande wrote:
> > This adds the missing [ master DEVICE ] in the synopsis part and the de=
tailed
> > usage/effects of [ dev DEV ] & [ master DEVICE ] int the detailed synta=
x part
>
> Please use imperative mood [1] in the commit message. Something like:
>
> "
> Add missing man page documentation for the feature added in commit
> 13a5d8fcb41b ("bridge: link: allow filtering on bridge name").
> "
Sure I'll reference both commits that did not add man page description then=
.
>
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#describe-your-changes
>
> >=20
> > Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> > ---
> >  man/man8/bridge.8 | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> > index e0552819..4e7371fc 100644
> > --- a/man/man8/bridge.8
> > +++ b/man/man8/bridge.8
> > @@ -66,7 +66,10 @@ bridge \- show / manipulate bridge addresses and dev=
ices
> >  .ti -8
> >  .BR "bridge link" " [ " show " ] [ "
> >  .B dev
> > -.IR DEV " ]"
> > +.IR DEV " ] ["
> > +.B master
> > +.IR DEVICE " ]"
> > +
> > =20
>
> It doesn't affect the output, but you have a double blank line here.
I'll remove it, I'm quite newbie at that man page stuff
>
> >  .ti -8
> >  .BR "bridge fdb" " { " add " | " append " | " del " | " replace " } "
> > @@ -661,9 +664,15 @@ display current time when using monitor option.
> > =20
> >  .SS bridge link show - list ports configuration for all bridges.
> > =20
> > -This command displays port configuration and flags for all bridges.
> > +This command displays ports configuration and flags for all bridges by=
 default.
> > =20
> > -To display port configuration and flags for a specific bridge, use the
> > +.TP
> > +.BI dev " DEV"
> > +only display the specific bridge port named DEV.
> > +
> > +.TP
> > +.BI master " DEVICE"
> > +only display ports of the bridge named DEVICE. This is quite similar t=
o
>
> I would drop the "quite" and just say "similar".
ok
>
> >  "ip link show master <bridge_device>" command.
> > =20
> >  .SH bridge fdb - forwarding database management
> > --=20
> > 2.41.0
> >=20
> >=20

Thanks for the review, I'll send a v2 then

