Return-Path: <netdev+bounces-43234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DF7D1CFB
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 14:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE3DB20DC4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A37A2109;
	Sat, 21 Oct 2023 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK5tffe3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DEED528;
	Sat, 21 Oct 2023 12:06:06 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3D1A4;
	Sat, 21 Oct 2023 05:06:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso1713963276.2;
        Sat, 21 Oct 2023 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697889965; x=1698494765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ja1C2VFP0W2/pxJ8cQiAC3kI+L/k337SubWCWnvoB4=;
        b=TK5tffe36yN+b2LW2qSkNWL4b6nmkFIwJ6AI/zPCV+Fehz3ufGWeyRRfG1pGYzAc8i
         fSz7nNU1ecVMJuxCiEtX6wtYCWd6hk4ec0uQtf1Lho4BKE/uHHJKgTJfwaRddbAKypdf
         rj6NLKi1rO4mN7Ge5GXguT+6eNmSe9nASyTgPPn3PEasdRZ2yTT2TKcXPgvnTVQ7n0Qp
         Yd5kIbB+dPqFjXyJVH/asaySYCcAgiW80lEPefJD7u2yEHi3y/9AhEBr1xekRUJ0eU8F
         nr0EiCk5vhzULjqwRuHs2CclKlwRtJOwg3/M+MvRc1GWWJ0N9oYW66mWKFNFWLj47hMG
         Qx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697889965; x=1698494765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ja1C2VFP0W2/pxJ8cQiAC3kI+L/k337SubWCWnvoB4=;
        b=esbYIBEVd9C86r5W+w0WnAmh6vxo7043C3eSpkKdASbySUC4JR1JcpBoRlbj27zhDy
         8ua2kPUgDGkopyGnt6HWt78viAZkVtar1VU3CzhW2g7Rk/E/KEkvodhqo54uLUDyGTRz
         m5iEpg+WRTlQsaG3Ia2GJMrvfTpeGyxeBGN79n2CETlEDlpSru+qLameE47xcMiJNuhI
         d6Yayiy8awn5jYq09TYa3Fn0ugIgPNQ8+K7Mc5QjzvCLtucU1Enk4qXpABgQ963xwwJ7
         7k9LVwe+7pYjxLNvf7tzn3z9W/ER4I6riIgd6LgdgeNkyWJBVE4TdmcgHVpI+AjqsJh9
         LuiA==
X-Gm-Message-State: AOJu0YzOI64tS1Lv7ySqhtkHtkY3tf/HmlXzpdBPwgn48BXUTpnDTk23
	CORyZMPmCEhJukwKCF0+V2fC8dzgpu84uSPrpqCy77S2hCNYejGY
X-Google-Smtp-Source: AGHT+IHntCB1vKalHz97mC2scksJb0FfyDYZj7Z3fLLgOhY+uGG9dCKxW2nncF1aO19fMGb+HqZezGjcyTkW+TBc7fQ=
X-Received: by 2002:a25:abb3:0:b0:d9a:b7cb:53bb with SMTP id
 v48-20020a25abb3000000b00d9ab7cb53bbmr5208233ybi.11.1697889965146; Sat, 21
 Oct 2023 05:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-4-fujita.tomonori@gmail.com> <871qdpikq9.fsf@metaspace.dk>
 <20231021.125125.1778736907764380293.fujita.tomonori@gmail.com>
In-Reply-To: <20231021.125125.1778736907764380293.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Oct 2023 14:05:53 +0200
Message-ID: <CANiq72nc+pZ2fsNzNkaB01im92X1F4mhESZonyvD2G1rd9dNDA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] WIP rust: add second `bindgen` pass for
 enum exhaustiveness checking
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: nmi@metaspace.dk, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andrew@lunn.ch, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, 
	benno.lossin@proton.me, greg@kroah.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 5:51=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Hmm, this works for me.

Andreas was probably using `O=3D`, but you were not.

At least that is what I guessed yesterday and what the suggestion I gave fi=
xes.

This is also why sending unfinished work by someone else is not the
best idea. I would also have marked that patch as RFC and put it at
the end perhaps, to make it clearer.

By the way, the patch is missing your SoB. I would recommend using
`--signoff` in Git and b4's `am`, `cherry-pick` etc.

Cheers,
Miguel

