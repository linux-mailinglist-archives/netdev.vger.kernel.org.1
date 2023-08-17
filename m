Return-Path: <netdev+bounces-28584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39D77FE60
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF342820F9
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7CB1804E;
	Thu, 17 Aug 2023 19:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE611643A;
	Thu, 17 Aug 2023 19:13:56 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B38F3580;
	Thu, 17 Aug 2023 12:13:55 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58c55d408daso1616297b3.2;
        Thu, 17 Aug 2023 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692299635; x=1692904435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIEs+zY5mVb/g93Ss2uTmENSwbzNg8Kom89qgvF5FRA=;
        b=W4Cr0mvis2OIKZsFy+6rdHNEUPvSbKjJynj7HSrWf3aZFurLDZHIQ9Sc5adepU7X2g
         yuA5at36fBxZ744aDN/SnOjlOab7w3PtJkx5oasb1Vr2zRH9GNzEISvKuiaOJVjc3a4p
         fi5NjNaJzdwlTolP5tcLYURgorPSDxfXL5y3y7pFJuFIzanAUckId3vdJQ8RiPPaPa5e
         pktTa6ctIs2F+R0oFxGJF7hpEttO3KQhesWLCbtd2KQP807I0K61zxtkFEc6BEbPrr4g
         WxyDPuCkBUfgihuqexYxR0P0LCnXiFw5A5nI1Z13wInFcGXiiNTVEVlWMiHl2Avy4Z/V
         TzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692299635; x=1692904435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIEs+zY5mVb/g93Ss2uTmENSwbzNg8Kom89qgvF5FRA=;
        b=O+QaYo1CLw1plCRuXO4mqt3pytj8jyli0FkfvdpQeBpdT5qvEj0c5Q8imbZncQzoxi
         dXz0QVhc0VW4kp0YIS9QB2yf7CkjPlr3wfLpR9GcMT6mJikcoI9yYm3vnNoxKmPa7MuP
         H+xRF0KpNi6ZPMq40frHg6ZxsRFUKchK2SxbarRZR4ihW/rGWV720lEKrYkAh/b8mqcv
         ae3Eb/gBwQSDRaUuFof4xD0tr+EwnA/TlxQfj7DSkFk1wJ7bppLThGOWnfCCQEOM+kf+
         x3cbdcw6e5c5YvZ/cUhE5o7WmNlB3aFQQb848qYLViPR0vNUxcZtg+9s2TbnQgMRTfI3
         1IMg==
X-Gm-Message-State: AOJu0YwjxsVoX0uamilDKSy5ieFo9uUAyP7TWdc+lUpZejsiXW/cMwmO
	joguk9gYECuxbqz8NZrGyGFa0eS+D0+kjqx49k0=
X-Google-Smtp-Source: AGHT+IF/w8EXRcnrNyaP+WAiDPrkMT8e5wTpJpESG14m1yR+ncLrSovatqvFBm4RL7ksjyteyKLfjDq2FURcSGdSb/o=
X-Received: by 2002:a81:4e85:0:b0:57a:897e:abce with SMTP id
 c127-20020a814e85000000b0057a897eabcemr401799ywb.7.1692299634794; Thu, 17 Aug
 2023 12:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh> <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch> <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com> <20230817113853.4b47e636@hermes.local>
In-Reply-To: <20230817113853.4b47e636@hermes.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Aug 2023 21:13:43 +0200
Message-ID: <CANiq72k0FxqE+_4jUM58pKinArARC75jYORe3CWX+OkosDqABQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Michele Dalle Rive <dallerivemichele@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Davide Rovelli <davide.rovelli@usi.ch>, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 8:38=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> I thought Rust symbols were all export symbol GPL.
> And therefore any Rust module using these must also be GPL.

They may be not distributing it just yet, e.g. it may be in
development as part of an academic paper, but they may be able to
publish later.

Cheers,
Miguel

