Return-Path: <netdev+bounces-26091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3ED776C6C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C0E1C213D5
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5C1DDC4;
	Wed,  9 Aug 2023 22:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE02452C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:47:16 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1C138
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:47:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bf91956cdso43431566b.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691621234; x=1692226034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXDTEd22XEqIMZo661qqSWECrCERN1pJR45ox7HG1tQ=;
        b=kTZCX1e5w9R2+jLRXd8Et3IBei6pd6I7sr/aC4lJuKhouUR+vCMJjm8dZ6/yiS5R7D
         4xbQMT4zwW3pkfWU5au0PLLsw8pU0OvWmwq+bfjlvX2QjumO43Vx4VUvW1dKsqPHc2ZL
         EaiIhoLbwRwn7mfxZUPZErCKjDv8LumWIc3gbtkk3sBEqKLOwqzw2wkkTXPGbEfEUKkD
         L2OqUKYegZsusDqQOLl0OO352Vak0mP7yjBxoE5TXBuz/bP95XtNYB4EdtggB8rQWmw4
         5NOCTozzWKDHM5jOa9yuKjA60NjG68D3knSTrYWy90mR9nJ6IwWxCXBC2Ix/PVqJvXOb
         nzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691621234; x=1692226034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXDTEd22XEqIMZo661qqSWECrCERN1pJR45ox7HG1tQ=;
        b=T0eZSBavmnBQb7BXUjQPLXt0DoF9BDTV78apioeVkDh5TLTnw5m5iSnMYDqzTo55Se
         NrJRffNcT1lzo8Y5HnYoEUrYBsIUzzwIswfeLaH4hr0jbZIFk4E1EJ+ycqgpTuQ1KKP0
         VjoSFpSQuJJ73SAMoH3ZkzmfrSwRHABUEOnTEbTyrctw1hX+rSGues32geZ4swa1f3fl
         JG7y7WBwQBiHPKiAgIciN3M46OMbQ66T0sRaOU/VnWWnvcCl5UoReACqiej4BqmeFIDD
         c16fj7bzDvEZsqZ02HR60rpyQ+trPc4wLCvoQCVplnwYKD4K3WsyeRmO9CZyB4AdnhSK
         OFoA==
X-Gm-Message-State: AOJu0YzRGfiAaNny9P/eYs/YLk1Mv7ARhGH0Drdnq5Hm5ljkzGOZuQbQ
	ppyinrvfsHNmUMQqIPnTPMKvhjkL++UodEkNXqCaCQ==
X-Google-Smtp-Source: AGHT+IFIuo+MXyeoVh4pXrORyqAYRV4fSc2uKFtsz6XX14Xjj1TlLU4KZdw3MywV+/6iy0M23VJ3Vq8NEKB4qDR+zyo=
X-Received: by 2002:a17:907:2713:b0:99c:53f:1dc7 with SMTP id
 w19-20020a170907271300b0099c053f1dc7mr310500ejk.54.1691621234083; Wed, 09 Aug
 2023 15:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
 <20230809-net-netfilter-v2-1-5847d707ec0a@google.com> <20230809201926.GA3325@breakpoint.cc>
 <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com> <20230809215846.GE3325@breakpoint.cc>
In-Reply-To: <20230809215846.GE3325@breakpoint.cc>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 9 Aug 2023 15:47:02 -0700
Message-ID: <CAFhGd8r4uCZHBgNG+Cws7GFZ511VEu8Q=KBiq7jU0PJHW6Z9ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 2:58=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Justin Stitt <justinstitt@google.com> wrote:
> > On Wed, Aug 9, 2023 at 1:19=E2=80=AFPM Florian Westphal <fw@strlen.de> =
wrote:
> > >
> > > Justin Stitt <justinstitt@google.com> wrote:
> > > > Use `strscpy_pad` instead of `strncpy`.
> > >
> > > I don't think that any of these need zero-padding.
> > It's a more consistent change with the rest of the series and I don't
> > believe it has much different behavior to `strncpy` (other than
> > NUL-termination) as that will continue to pad to `n` as well.
> >
> > Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
> > `strscpy` in a v3? I really am shooting in the dark as it is quite
> > hard to tell whether or not a buffer is expected to be NUL-padded or
> > not.
>
> No, you can keep it as-is.  Which tree are you targetting with this?
Not sure, I let ./getmaintainer auto-add the mailing lists. Perhaps
netdev or netfilter next trees?

