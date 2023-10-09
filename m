Return-Path: <netdev+bounces-39178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F437BE459
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF83281A1F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E41E36AE6;
	Mon,  9 Oct 2023 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UofiSiF1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B5358A5;
	Mon,  9 Oct 2023 15:15:30 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C9710F8;
	Mon,  9 Oct 2023 08:15:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59bebd5bdadso56752457b3.0;
        Mon, 09 Oct 2023 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696864517; x=1697469317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2RNhYK7K/U6oEU438HKN778Xvkt1N3xbG/bqNUTNxY=;
        b=UofiSiF1WyX3kSgcnV/pgDVggRyciV0WTNq2+sT85K7pbVtTjk1nx78bfJCUS1svWr
         1PzfElqtyHUBkhgv/jdKYVFovriJvGHhrtmV9rZJ5NdTFouslu/eHXY+OX0aBSQIx+53
         5eQ6IM3bB4bgJhsLktPzBIYfjOLXOjhEzUln4JopBIVSksqZPoBr+iaTylbn0LCEwB+G
         6Fi4VsNx2DgwaZBO7ttxodllJY9nIhuFt0CL+tSjR0AKTRhMq6KHDkc+JKzzz+v4HOtC
         jG6JtGQiWOYOteD4mP+dOf9xpuX/pTIo6E3HMCyDM6gS13B9US1e3MDGmCfB8953fQWC
         8YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864517; x=1697469317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2RNhYK7K/U6oEU438HKN778Xvkt1N3xbG/bqNUTNxY=;
        b=GaJiVyzuHV7m7jyd9J7r/tc0tgBdiU+9QwJaO12jRqN5kQwBLiOtBvhxfpVCsArCWA
         dpnLbJT1cQ9HPSFefttpKzNkKIEfT8i+veGeygqm6DwSfjynu8JBDNMKeCNPBqjDSTPs
         kKb63KeYVwBfLq1PEfKYhFl3wLlvGtSh2+TxlZV1LuEQzbK5zBsbF1MZWpI/z8wcUaRo
         Swg18vPWrl6uD4Qje+hYo/8uzvLWqPhjlfUD94599oFhoe3lnl01i+hIYM4+ayfwSOqz
         3QMiRvcADPbELfywjXUThDkspnIqsKYQLGl92cnvMT0KJZcamB6NxlHyzG/jzKF++gUW
         fj4Q==
X-Gm-Message-State: AOJu0YyXsVENlxIYlogJ+Ez2oBtpx7e+5i9OCBHPdKuAN+Oio3oWfEWa
	+H4bg15t/mWTl29ST1Uh8KOW1D1DMTCQpF9Xh/a4FhPfEaZObpWQvh0=
X-Google-Smtp-Source: AGHT+IH0jSvEMjMGJCvp9ZJ/KbDS0Z/oG6h14P09dxl83rHjbd5On3Gi4dupzE+TiM9gAJajWOrovUMSPT98Ya5/6EI=
X-Received: by 2002:a81:9255:0:b0:5a7:af97:c787 with SMTP id
 j82-20020a819255000000b005a7af97c787mr635318ywg.11.1696864517055; Mon, 09 Oct
 2023 08:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch> <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <ZSQMVc19Tq6MyXJT@gpd> <a3412fbc-0b32-4402-a3c8-6ccaf42a2ee4@lunn.ch>
 <2023100902-tactful-april-559f@gregkh> <CANiq72mDKVKv805n7zQ6SOLhtrp_P2Gi_C89Kis8SGgT1JhT6w@mail.gmail.com>
In-Reply-To: <CANiq72mDKVKv805n7zQ6SOLhtrp_P2Gi_C89Kis8SGgT1JhT6w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:15:06 +0200
Message-ID: <CANiq72mHVoqY6qGM-zFYPCrWTyA_i3eT+6FRh8jhTfJKz1QKHA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrea Righi <andrea.righi@canonical.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:10=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> The compiler has support for it
> (https://github.com/Rust-for-Linux/linux/issues/107), but I didn't do
> mips pre-merge.
>
> The ones I tried (and that we had in the CI back then pre-merge) were:
> arm, arm64, ppc64le, riscv64 and x86_64.

By "in the CI" here means: booted in QEMU with a given kernel config.

Also, I should have said that Michael Ellerman was the one that added
the ppc64le one.

Cheers,
Miguel

