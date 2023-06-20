Return-Path: <netdev+bounces-12370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBC2737354
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19798281350
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477DD168A4;
	Tue, 20 Jun 2023 17:55:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935F2AB3A
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:55:47 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F31987;
	Tue, 20 Jun 2023 10:55:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bd729434fa0so5267794276.1;
        Tue, 20 Jun 2023 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687283742; x=1689875742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSF5soPOP8va7GnB3Njk98tlVSmV9eQIPMx/srLmS5E=;
        b=UyNXyrln9kREsaRb9T7hd8rLwW7KXhGiFAdHED8uhjOlMRSScqADivwLTjlzwR6DtX
         y6OLIwOZr2iJP4ZIWd9h6el4JAlZoLmtge2YsxPcCqhpVDd8Ci8NPBKyM70lOj/kF1IS
         +2YdFp6Wudy/xC0DneXXqmIFnDZXDx/BK6F690aYUFfHRG6gW4HmckyuI9StmZaxtpbr
         aJSRsMj8syaBXiZYRLYiQkcuAoiYcwgQZ2i5xw0B0d5lwfLR2NpPDgBBly+p+h0jbWAo
         YEftT/jPCyr7wJSZj2M2GUmqhUs6U2AbyyLqdfDt0SqscYUVxPmaqK7abfFAsT8GZeR1
         e4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283742; x=1689875742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSF5soPOP8va7GnB3Njk98tlVSmV9eQIPMx/srLmS5E=;
        b=k/MiB4KPfU7mFHB4FDlnP2nGlIzEQLB3fCitVVVVzSiuzNgSeB9GzIU/WNFBHls0nH
         WU+CuzcUxybzNH5vsP5rnMDqwm5tQUVU0J5VTc8vcYgy1bYMRyeOJcRmq/icIPivezqo
         8pmoqtTdX5fhJgRHi2fnQc1Qf5iBTGZDWala+tHoMFvt9sUBOoTG5xfcrmt2FcaQBz9w
         fYotO/smJvupZfVqz3adwTBUgOaq34uzv1DYbRPZL6OrEfuOOdpRaCaY29E8ru0rjiBy
         osSzWU2jmyZgOkLaBxJcX7RQJRqCpG0X7U7STyFHOkoi0qSN+zRDURglgmyWHSREKAdW
         zq9Q==
X-Gm-Message-State: AC+VfDyo6nNXopMntHUiORhseA1LA5VwvNwdaeF+d37zzVoQRGcjUjho
	kXMb6Mod0ijeXpAy0xorfYCMCzhxboqYVnVkT6KM65RNoT0=
X-Google-Smtp-Source: ACHHUZ48hBYbz02cVWsSJhI79fexUigs6DjcK13VLgPBZ32kqOZ/B6XvnyOrd77rmU3dMujBURYO0huClUx6xkrcG2E=
X-Received: by 2002:a25:ae83:0:b0:bac:f4c6:d956 with SMTP id
 b3-20020a25ae83000000b00bacf4c6d956mr11287626ybj.47.1687283742022; Tue, 20
 Jun 2023 10:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230614230128.199724bd@kernel.org> <8e9e2908-c0da-49ec-86ef-b20fb3bd71c3@lunn.ch>
 <20230615190252.4e010230@kernel.org> <20230616.220220.1985070935510060172.ubuntu@gmail.com>
 <20230616114006.3a2a09e5@kernel.org> <66dcc87e-e03f-1043-c91d-25d6fa7130a1@ryhl.io>
 <20230616121041.4010f51b@kernel.org> <053cb4c3-aab1-23b3-56e3-4f1741e69404@ryhl.io>
 <7dbf3c85-02ca-4c9b-b40d-adcdb85305dd@lunn.ch> <c1b23f21-d161-6241-26fb-7a2cbc4c059c@ryhl.io>
 <20230620084749.597f10b3@kernel.org> <809bb749-365f-af06-c575-0c4b1a219035@ryhl.io>
 <CANiq72n91z7heDU5MDk_=jYY8h8VJsfboevmFS0vrD-zQCKq5Q@mail.gmail.com>
In-Reply-To: <CANiq72n91z7heDU5MDk_=jYY8h8VJsfboevmFS0vrD-zQCKq5Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Jun 2023 19:55:30 +0200
Message-ID: <CANiq72=BAZPc94pa9LLYnuYMcxi-cWnKSZAOTGhJOWRv4FGXug@mail.gmail.com>
Subject: Re: [PATCH 0/5] Rust abstractions for network device drivers
To: Alice Ryhl <alice@ryhl.io>, Gary Guo <gary@garyguo.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 7:44=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Yeah, and we could use `build_assert!(false);` to ensure we don't ever
> call it (by users, or by the the custom destructor methods) -- it

i.e. `build_assert!` is a similar trick we have to produce a linker
error like Alice suggested. It was "nicely packaged" by Gary a while
ago :)

Actually, it should be `build_error!("Normal destructor should never
be called");` -- same thing (I just forgot we had that one).

Cheers,
Miguel

