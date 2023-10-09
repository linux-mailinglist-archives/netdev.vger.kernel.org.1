Return-Path: <netdev+bounces-39138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364907BE2DE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03EC281878
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C843CA47;
	Mon,  9 Oct 2023 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB/vtoQ1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F3CA74;
	Mon,  9 Oct 2023 14:32:55 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2E0A1;
	Mon,  9 Oct 2023 07:32:54 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a24b03e22eso56131337b3.0;
        Mon, 09 Oct 2023 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696861974; x=1697466774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7CMPzGjIZpEThqTjxceGtNFIeTMONe/skUkqEX8s18=;
        b=dB/vtoQ1mKGIKqno0QH/4F4YmlUqU2MydE2jNq9f8i/8acsmTP35frUOLnPy104ROm
         YDAPmOtCnTsnfRHrwbAI2Z0Dj6+7rvGYFRSa+sq97Vcd6PoZw7DU62fSByZO/Z1Kb3AQ
         716XBjK6NCy5J/lnhEGE/1lL59GrzujhVW/D3ABt/TgBgTHeDwELGomRicMTT66GmZcg
         duycDziTuHh46xo/oPg3BVQAKWWzP77vpOSFf7V5cCZsN/6nPV6Lql241brwp+Js1LLe
         PtUWXdEa6f+4HPmgPbPBZuh+32DjUr1ta7j1Pou5ywsvrOl9FXeSjhbIme1+WLj4pOir
         5RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696861974; x=1697466774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7CMPzGjIZpEThqTjxceGtNFIeTMONe/skUkqEX8s18=;
        b=vu//EKdx3gLLFXC97QvK95joED7oAmdKNnPwj/Fnu/qlpw0TxeOtbLIHEEySlP9EFA
         6tHYqPHl9iehYhJFx8R5j9SqmiGaTuc1ap9d91FodqIm3v8ibZS9Q4WX3PAQ1hMrOMHw
         n/+gWWAqoFxHBlqeyP5tk+OGt3biW0kALX4ny+ra3Q5lw3RmLoRQoHQVSi4XQKnrCDN6
         7Zkj4jC1Y/gDRlWqtrmBGIICVNlBtuIwOahaqCbjTD+W5m62EBGOpxZZtLsFAaf6JZLs
         X3X/UXpEdT43dBTHb08hKb7y2xwCpYGuTjkvv28qZr5VnWWdW8Dg/ojw10RrFZWKsblR
         zNQg==
X-Gm-Message-State: AOJu0Yzvv13cLPQRaMnvLikgT7Zdbo2YS0IiwO/d0lvs7Vw/zx2xZs9y
	NMHfHL6CJgwIptQ5ri9r1kMsbpONGl/uvDIrbzU=
X-Google-Smtp-Source: AGHT+IGsIvyqZvIb3ahn5qO8Cx5NOziOwGVaucCf6TYpDZlayQXSVr5N7dTgB72XEy5ubL46fmuNH6BlN9Z/piktI6w=
X-Received: by 2002:a81:7309:0:b0:59b:2458:f608 with SMTP id
 o9-20020a817309000000b0059b2458f608mr16571132ywc.30.1696861973748; Mon, 09
 Oct 2023 07:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com> <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
In-Reply-To: <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 16:32:42 +0200
Message-ID: <CANiq72nf1ystSiV_BavRvMHA79bO7XapA3TURag1Kw_wzUr2Og@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	greg@kroah.com, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 3:49=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> We have about two weeks before the merge window opens? It would great
> if other people could review really soon.
>
> We can improve the abstractions after it's merged. This patchset
> doesn't add anything exported to users. This adds only one driver so
> the APIs can be fixed anytime.
>
> Once it's merged, multiple people can send patches easily, so more
> scalable.

I think it is too soon to merge it unless you get some more reviews.

On the other hand, I agree iterating in-tree is easier.

If you want to merge it very soon, I would suggest
considering/evaluating the following:

  - Please consider marking the driver as a "Rust reference driver"
[1] that is not meant to be used (yet, at least) in production. That
would probably be the best signal, and everybody is clear on the
expectations.

  - Otherwise, please consider marking it as staging/experimental for
the time being. That allows you to iterate the abstractions at your
own pace. Of course, it still risks somebody out-of-tree using them,
but see the next points.

  - Should fixes to the code be considered actual fixes and sent to
stable? If we do one of the above, I guess you could simply say the
code is in development.

  - Similarly, what about Rust unsoundness issues? We do want to
consider those as stable-worthy patches even if they may not be "real"
security issues, and just "potential" ones. We did submit an stable
patch in the past for one of those.

[1] https://lore.kernel.org/ksummit/CANiq72=3D99VFE=3DVe5MNM9ZuSe9M-JSH1evk=
6pABNSEnNjK7aXYA@mail.gmail.com/

Cheers,
Miguel

