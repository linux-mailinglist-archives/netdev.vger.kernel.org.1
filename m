Return-Path: <netdev+bounces-40640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F37C81CF
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90B01C20A50
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA710A05;
	Fri, 13 Oct 2023 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7636D39
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:19:32 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B908F95;
	Fri, 13 Oct 2023 02:19:30 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a82f176860so1124557b3.1;
        Fri, 13 Oct 2023 02:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697188770; x=1697793570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5CgK2Wx+GNw/Df5hg5DrQ7ls2wSN4sfYA/dMLbBbfg=;
        b=GhWLkwT0OCxWoyYnbCd62hgBCXJxPtHhEJwzfLUGA0zGzNzWvVY4cTmSFUYLMvrN/T
         gLkJgiHkuzpiHJjH8ESG1qnIg1RjIyIyPp9+icrRcrbdvsowW91IEsOlEyr/ak4pZRKX
         kIRJkjszaxQZ/Woma5ipKfUUOeZZyE49iMcJI6DsC1aVRNYiY4mbw4IXe1JQqbAlY/s7
         E9QlXI6RvMYQPZi4O8w436xMbFvSgoup4BVXzIJPVdrHyxtt06KABgel0cb/k8CxnFC4
         N5/8W5nH9QueaxFF0q4bFBTmA6MIBUeEPAbr3egX9/72CLWFlmDd6dRI+sfufQk5ZfjL
         nDgw==
X-Gm-Message-State: AOJu0YyLFEtY1QuptWSAbvAavvfdEkLMI2wmJMXudltRqrTU0A7Wy9mD
	CJbks51W6jGt/au/AwpEnlhhGG85c40z9g==
X-Google-Smtp-Source: AGHT+IGd1rP+CFedkE/IqEYRRPVv7KNK7fJO4FYRsUdIYPuQHM85wVJsI/I9oK+6/dm01fdjNh8NPA==
X-Received: by 2002:a81:6587:0:b0:5a1:d352:9fe1 with SMTP id z129-20020a816587000000b005a1d3529fe1mr29299478ywb.42.1697188769633;
        Fri, 13 Oct 2023 02:19:29 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id r14-20020a81c30e000000b005a7c35a1396sm554018ywk.29.2023.10.13.02.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 02:19:28 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a82f176860so1124237b3.1;
        Fri, 13 Oct 2023 02:19:28 -0700 (PDT)
X-Received: by 2002:a0d:eb0b:0:b0:59f:4ef0:b4b6 with SMTP id
 u11-20020a0deb0b000000b0059f4ef0b4b6mr27976058ywe.26.1697188768601; Fri, 13
 Oct 2023 02:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012121618.267315-1-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWAk9kJBGGq9K-RnC0HFZk1XbaosTBO2OW1kpYFPh1Mqg@mail.gmail.com>
 <TYBPR01MB5341F5AAE321E3E373012E4DD8D2A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAMuHMdU9Udd7xX7Us+3T06YMLAb4y0xnSOipN-5c-d-MfpvKdg@mail.gmail.com> <TYBPR01MB5341D9408B9C4EA701E5E5D1D8D2A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341D9408B9C4EA701E5E5D1D8D2A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Oct 2023 11:19:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNrdr8YTQBxzX=7=W+SBtK-uH6CjjUgR9VRj3CpKFh1g@mail.gmail.com>
Message-ID: <CAMuHMdUNrdr8YTQBxzX=7=W+SBtK-uH6CjjUgR9VRj3CpKFh1g@mail.gmail.com>
Subject: Re: [PATCH net-next] rswitch: Add PM ops
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Shimoda-san,

On Fri, Oct 13, 2023 at 10:55=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Friday, October 13, 2023 4:29 PM
> > On Fri, Oct 13, 2023 at 4:10=E2=80=AFAM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > From: Geert Uytterhoeven, Sent: Thursday, October 12, 2023 9:35 PM
> > > > On Thu, Oct 12, 2023 at 2:16=E2=80=AFPM Yoshihiro Shimoda
> > > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > Add PM ops for Suspend to Idle. When the system suspended,
> > > > > the Ethernet Serdes's clock will be stopped. So, this driver need=
s
> > > > > to re-initialize the Ethernet Serdes by phy_init() in
> > > > > renesas_eth_sw_resume(). Otherwise, timeout happened in phy_power=
_on().
> > > > >
> > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.co=
m>

> > > > > --- a/drivers/net/ethernet/renesas/rswitch.c
> > > > > +++ b/drivers/net/ethernet/renesas/rswitch.c
> > > > > @@ -1991,11 +1993,52 @@ static void renesas_eth_sw_remove(struct =
platform_device *pdev)
> > > > >         platform_set_drvdata(pdev, NULL);
> > > > >  }
> > > > >
> > > > > +static int __maybe_unused renesas_eth_sw_suspend(struct device *=
dev)
> > > > > +{
> > > > > +       struct rswitch_private *priv =3D dev_get_drvdata(dev);
> > > > > +       struct net_device *ndev;
> > > > > +       int i;
> > > >
> > > > unsigned int (also below)
> > >
> > > I don't know why unsigned int is needed. Other functions use
> >
> > There's this old mantra "prefer unsigned over signed in C",
> > and a valid port array index here is always unsigned.
>
> I understood it.
>
> > > rswitch_for_each_enabled_port{_continue_reverse}() with int.
> > > Especially, rswitch_for_each_enabled_port_continue_reverse()
> > > has the following code, unsigned int will not work correctly:
> >
> > Oh, there is also a reverse variant, which indeed needs a signed
> > iterator, currently...
> >
> > > ---
> > > #define rswitch_for_each_enabled_port_continue_reverse(priv, i) \
> > >         for (i--; i >=3D 0; i--)                                  \
> >
> > I think this can be made to work with an unsigned iterator using
> >
> >     for (; i-- > 0; )
>
> I think that this loop cannot access index 0 :)

rswitch_for_each_enabled_port_continue_reverse() is meant to be
used in the error path, to tear down all ports that were initialized
succesfully? So i is always the index of the first port that failed to
initialize, i.e. i > 0 on entry.

See "git grep -Ww rswitch_for_each_enabled_port_continue_reverse".

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

