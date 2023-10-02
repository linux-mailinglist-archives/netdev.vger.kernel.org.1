Return-Path: <netdev+bounces-37405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D527B5381
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 070621C2088D
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433515EBF;
	Mon,  2 Oct 2023 12:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2951CA74
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:59:41 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF6B3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:59:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so11609a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696251578; x=1696856378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQNNYMHbbXj3ScZMcNdV4XQ6wHyCHAuYoxBdko5O+4A=;
        b=0PDiaFSMm6iwO/VjG8wRRn6MiyBOZPfWWK+YtALG7HW+v5C40qXKFl86mS3Gk2Ms/s
         pcoJNxbU7a9jTnuCU06TDLjEmS1SdZJ3Gydj0DAuckO3QoE3jFeQ+wNsfsBs7SVSsRlT
         8vPrsInaQZPpt78+xIqHZaR91wZG74HfqfnkFFZ66RqW5FokfO+LTlBBAS7x3bksuyEy
         xkaJfNppxlxv/IBJzHDgz/nAzRuI7IMDz0MCFmXu4pY6hqWB2QFj1ts+xsqfUNTMot1M
         JG1j36oPbMuI3EfQsLmS8Y9i675L4QB7a7hX/jOH+Gs29aj/Ws1e5CATrPdUe3ld9OG5
         hIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696251578; x=1696856378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQNNYMHbbXj3ScZMcNdV4XQ6wHyCHAuYoxBdko5O+4A=;
        b=nOGmJvHVNoTul9L01E197VbCW7EDGp6u8bRHlNG14fUuC+fHYXJOZI2JbzZo1FFggc
         qROlDTUTW/q1Mecf+H8Cxbg6+PdqjKfEWVhHoYeIeF0vq5LG1sVg99CcbMZu882A7FST
         9/TuUcEFQpa1CjEjBREDL4qb0s4y9aeYKo0P3ZdgSU5q4nH79HO+lSKpbcH24a0ljE3j
         3n7oNE98Q7m9MDGZW7qG57ToSBk/ppE8ItJvoeVyGDRHxXVD/7weIRBzVVIYWIrWKSkS
         GEQfb/wnYJg4kplILbktLlJVzSod+3iVt2SJRgCY9R6KvJQCeamx5IrRUw2pfxMr8U2t
         RuOQ==
X-Gm-Message-State: AOJu0YyTh8fp0+TSrhOWj7+J3K2ZrAahjSXeCfy3P+ZH7mBEUVskTSBY
	F4GQFIjHiGl5xIY8BL3ntZqwGe/jppScRfaNuZHLCQ==
X-Google-Smtp-Source: AGHT+IHioJWOPzoI5EaTx/MPQvZESSXI2u2AEjqrkEOsD9g2pkbMR/w1XAKTmdUWaRmWmyFQohh7L3YNRqOavMQhIcw=
X-Received: by 2002:a50:8d17:0:b0:52f:5697:8dec with SMTP id
 s23-20020a508d17000000b0052f56978decmr116826eds.4.1696251577874; Mon, 02 Oct
 2023 05:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com> <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com> <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
 <651ab7b8.050a0220.e15ed.9d6a@mx.google.com> <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
 <651abb07.050a0220.5435c.9eae@mx.google.com> <CANn89iLHMOh9Axt3xquzPjx0Dfn6obmSZJFSpzH51TKAN_nPqQ@mail.gmail.com>
 <651abda3.df0a0220.a04f0.12df@mx.google.com> <CANn89iLKBqsV6=jP1viSNMpA1W8r5mJEitjH3+RU5gEOQFYEtg@mail.gmail.com>
In-Reply-To: <CANn89iLKBqsV6=jP1viSNMpA1W8r5mJEitjH3+RU5gEOQFYEtg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Oct 2023 14:59:26 +0200
Message-ID: <CANn89iKuTLk+pWGxR36VgWUVnz2inYdqPvJP6_e8nu4TRgUO=w@mail.gmail.com>
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Raju Rangoju <rajur@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 2:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Oct 2, 2023 at 2:55=E2=80=AFPM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
> >
> > On Mon, Oct 02, 2023 at 02:49:11PM +0200, Eric Dumazet wrote:
> > > On Mon, Oct 2, 2023 at 2:43=E2=80=AFPM Christian Marangi <ansuelsmth@=
gmail.com> wrote:
> > > >
> > > > On Mon, Oct 02, 2023 at 02:35:22PM +0200, Eric Dumazet wrote:
> > > > > On Mon, Oct 2, 2023 at 2:29=E2=80=AFPM Christian Marangi <ansuels=
mth@gmail.com> wrote:
> > > > >
> > > > > > Ehhh the idea here was to reduce code duplication since the ver=
y same
> > > > > > test will be done in stmmac. So I guess this code cleanup is a =
NACK and
> > > > > > I have to duplicate the test in the stmmac driver.
> > > > >
> > > > > I simply wanted to add a comment in front of this function/helper=
,
> > > > > advising not using it unless absolutely needed.
> > > > >
> > > > > Thus my question "In which context is it safe to call this helper=
 ?"
> > > > >
> > > > > As long as it was private with a driver, I did not mind.
> > > > >
> > > > > But if made public in include/linux/netdevice.h, I would rather n=
ot
> > > > > have to explain
> > > > > to future users why it can be problematic.
> > > >
> > > > Oh ok!
> > > >
> > > > We have plenty of case similar to this. (example some clock API ver=
y
> > > > internal that should not be used normally or regmap related)
> > > >
> > > > I will include some comments warning that this should not be used i=
n
> > > > normal circumstances and other warnings. If you have suggestion on =
what
> > > > to add feel free to write them.
> > > >
> > > > Any clue on how to proceed with the sge driver?
> > > >
> > >
> > > I would remove use of this helper for something with no race ?
> > >
> > > Feel free to submit this :
> > >
> > > (Alternative would be to change napi_schedule() to return a boolean)
> > >
> >
> > Think mod napi_schedule() to return a bool would result in massive
> > warning (actually error with werror) with return value not handled.
> >
>
> It should not, unless we added a __must_check

This was what I was thinking :

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fbaf4a9cf310d5f53c4401840c72776..6aa2bc315411d1a0f7db314f1fb=
fb11aae7c31fe
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -491,10 +491,13 @@ bool napi_schedule_prep(struct napi_struct *n);
  * Schedule NAPI poll routine to be called if it is not already
  * running.
  */
-static inline void napi_schedule(struct napi_struct *n)
+static inline bool napi_schedule(struct napi_struct *n)
 {
-       if (napi_schedule_prep(n))
+       if (napi_schedule_prep(n)) {
                __napi_schedule(n);
+               return true;
+       }
+       return false;
 }

 /**

