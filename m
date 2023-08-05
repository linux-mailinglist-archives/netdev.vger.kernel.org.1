Return-Path: <netdev+bounces-24607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF49770CD4
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A400282703
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD25136D;
	Sat,  5 Aug 2023 01:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DC10E3
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:03:44 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA364EE1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 18:03:43 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so63701cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 18:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691197422; x=1691802222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+SuaTtMx9fDim3CvSX0GbYJTZyNduayXRPq9NXsUpY=;
        b=xlaH5o/2Du//Lhkw+QJfIXnQDpGhOnhXk+WBTlLIsphjc5+zZda4bKm1edQX6vpIpm
         ZQLJRUy4mOUWizuaWw9dgsBvC1KU1Sig9Cq6hvqTNYBxIzGAFYqDndcllDb4UURx5nEB
         Qo5Jq4A1qOpfKC6QcVjQEGfeDKGwb2jn4x4aY/avzEZjx23mUyM9pL9sZsxPMfRP5sdh
         gv+8GHwDJVdL0V0lIWMlidwirv62U8uZivM5xYu3nMLv1Ey6SFrn+zDaDA8dg6eecFbd
         UhbIc/82/8hXA+BVfzSSUDJzAzSL70QiBANiCyKIhMN4RDRJKHymP+Ql/rHT7LC8T7Ci
         RGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691197422; x=1691802222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+SuaTtMx9fDim3CvSX0GbYJTZyNduayXRPq9NXsUpY=;
        b=WAGLuxkQIA5waSm/ZUVu8ltLe5HhTIW6svGojb48g/e78ReOJgMzDWcBAsVaFfIrsc
         8db/QZ+8hHLF+Cdk1GNWggIcIsTKBb5rzFgxTkdXCUlQ+cI8iH/PIspDvZ9rpzM9ShKE
         zbCyVjW3VfMuZdqkQXnxgRpTCGQwOJUf0Muedgs0ZKJZKQSsj23irM3KezpHpZeMCBga
         JTNYhuNsU1WDCYErOCzrFRGHtzk4X8DnWgv0jkWGdU5o0PNWuoweq6eL0FKxLFk0Lsrl
         GbOR164cVwwK/3of2ym8m/FULdT17s5QP5Dy0H8vVvlNpdFHMgM8uadkSCdOCaBTWpEJ
         j28w==
X-Gm-Message-State: AOJu0YwK1b/S69w42PjfzSgkKkQPvvhPnvaXajVSSVuJyfu13u0FKalG
	kZSTTFM1dqTmXRZCUpesbzjUlNjaXyx3IKthKDsEsPV8DwArArFwMOE=
X-Google-Smtp-Source: AGHT+IGrgDjIbotpr/rVYZNba7hRTEfFCbLtlI3F0MRZR9VUXW493ijR0Z69OnSDdRKOOVZra9+lfctjEcTZedl83UM=
X-Received: by 2002:a05:622a:64c:b0:3ef:3361:75d5 with SMTP id
 a12-20020a05622a064c00b003ef336175d5mr62002qtb.11.1691197422088; Fri, 04 Aug
 2023 18:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com> <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
In-Reply-To: <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 4 Aug 2023 18:03:05 -0700
Message-ID: <CAGETcx9zcdHtdqgH4xbgAFj1qPqJoUub9wv1DKiBuXQZmCHKEA@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Rob Herring <robh@kernel.org>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 1:22=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> +Saravana

I'll look into this next week and reply.

-Saravana

>
> On Fri, Aug 4, 2023 at 11:52=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> =
wrote:
> >
> > On 2023-08-04, Rob Herring <robh@kernel.org> wrote:
> > > On Fri, Aug 4, 2023 at 10:54=E2=80=AFAM Nick Bowler <nbowler@draconx.=
ca> wrote:
> > >> Oh, I get it, to include this driver I need to also enable:
> > >>
> > >>   CONFIG_RESET_CONTROLLER=3Dy
> > >>
> > >> Setting this fixes 6.4.  Perhaps CONFIG_ARCH_ZYNQMP should select it=
?
> > >
> > > Maybe. Do other platforms do that?
> >
> > Of the ~40 platforms in arch/arm64/Kconfig.platforms, there appear to
> > be 5 that do select it.
>
> Then selecting should be okay. Unless there's a desire for resets to
> remain optional (which is going to rely on the timeout).
>
> > >> However, even with this option enabled, 6.5-rc4 remains broken (no
> > >> change in behaviour wrt. the network device).  I will bisect this
> > >> now.
> > >
> > > It would be good to know why the deferred probe timeout doesn't work.
> > > If you disable modules, the kernel shouldn't wait past late_initcall.
> > > Though this functionality keeps getting tweaked, so I may be off on
> > > the current behavior.
> >
> > I don't know about the deferred probe timeout, but I bisected the 6.5-r=
c4
> > breakage to this commit:
> >
> >   commit c720a1f5e6ee8cb39c28435efc0819cec84d6ee2
> >   Author: Michal Simek <michal.simek@amd.com>
> >   Date:   Mon May 22 16:59:48 2023 +0200
> >
> >       arm64: zynqmp: Describe TI phy as ethernet-phy-id
>
> I don't see anything obviously problematic with that commit. (The
> #phy-cells property added is wrong as ethernet phys don't use the phy
> binding, but that should just be ignored). I'd check if the phy probed
> and has a DT node associated with it.
>
> fw_devlink tracks parent-child dependencies and maybe changing to
> parent-grandchild affected that. We don't yet track 'phy-handle'
> dependencies, but we'd have a circular one here if we did (though that
> should be handled). Does "fw_devlink=3Doff" help?
>
> > So, reverting that on master appears to correct the issue (together wit=
h
> > setting CONFIG_RESET_CONTROLLER=3Dy).

