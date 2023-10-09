Return-Path: <netdev+bounces-39156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346157BE3E4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656801C209E4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36C34CD6;
	Mon,  9 Oct 2023 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrvO5mnp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA835892;
	Mon,  9 Oct 2023 15:07:00 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD82B7;
	Mon,  9 Oct 2023 08:06:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7a77e736dso5329017b3.1;
        Mon, 09 Oct 2023 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696864016; x=1697468816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=at8XvbeGP+LBevEkXqeDdKBAJUttMOlbFq0O+X3ZHGg=;
        b=TrvO5mnppXiAIMGqw07SVcOYiuvAtAQBKDRjD23q84x6pSx1S3HkrmwSSQjGy93Ska
         6RJOZWJo4YsZfqQYZd0wDHN9euZ++ISAnqh7GPEbDJnHIXMN8+I0/IvgpAom4pxrJuUu
         2l0cVIlF6slP3NBzbz8nTvJMh7nCnc/pU3IUTAoyrzE/wsNrNg71Ug2pehY3nd2PzeG7
         mbMTXY2fK6842uHo17dej83Jk3nxqgPAiNs2fYEfefSHqsy1qkg/zVgZxmRNI+no7USu
         zHd+SP6mirExJyLoI49lsrFmadnIsMUrfFTqtdRhjSqhEM+jIQBY1hFAtOEs8e7gaub7
         drug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864016; x=1697468816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at8XvbeGP+LBevEkXqeDdKBAJUttMOlbFq0O+X3ZHGg=;
        b=Vh8QPx3uZEroMYedagbPPVoz8z13cl3Acke6dj0qIZ6vXnHGQMPR4Q6/YtWJyFsEsw
         kViIu0eAFND2CTX5ymntovzQ5OKV2x0/imVnhyGBWQ41X+YSsDSnBiv5vj/4aScQH/Kv
         oCRmk3OeM3otw89Iet9bWp3Tb/EMqrE9ZH7a+8Ri2enPICXA0fG3y5Ph+zc4xEh/79E3
         C5StSe5QNKsxcA/y3aNzh7yEggil37iQ0Ky3BIsmQBvNbk8qpwG/9khN0g7dBhgCQ/LK
         zMLRvp8eaTOTd7ZvzOeliBX07lQSucsBgTtGg2dEhwXN0lqtXW+Wk/QPmXlTzx6G/2pR
         gY4Q==
X-Gm-Message-State: AOJu0YwIOwQVOeyV+n2DyyUetcIKNseOtbv29BK/dld9TKmzhekC7SG6
	ldL/n90/9UVSdD9PVQSl/t8prig3pfuUZobG7hc=
X-Google-Smtp-Source: AGHT+IGScsGpsvAeIFYWSiddhIk6NNx7oaCZd6BoqPQ3tizhHgkivqIRaEbqXcxvGDQy7TPJ9qN6dOs1Zo+hcoES1E0=
X-Received: by 2002:a81:de01:0:b0:5a4:f92b:3a44 with SMTP id
 k1-20020a81de01000000b005a4f92b3a44mr14556728ywj.25.1696864016465; Mon, 09
 Oct 2023 08:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch> <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <2023100916-crushing-sprawl-30a4@gregkh> <CANiq72nfN2e8oWtFDQ1ey0CJaTZ+W=g10k5YKukaWqckxH7Rmg@mail.gmail.com>
 <2023100907-liable-uplifted-568d@gregkh>
In-Reply-To: <2023100907-liable-uplifted-568d@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:06:45 +0200
Message-ID: <CANiq72=A_HMc3nwxk-EGzuDGRBSCfdzKGj=M-snbd8cidQLfuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	Andrea Righi <andrea.righi@canonical.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 4:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> Then the main CONFIG_HAVE_RUST should have that dependency, don't force
> it on each individual driver.

Yes, that is what I meant (well, `CONFIG_RUST` is where we have the
other restrictions).

> But note, that is probably not a good marketing statement as you are
> forced to make your system more insecure in order to use the "secure"
> language :(

Indeed, but until we catch up on that, it is what it is; i.e. it is
not something that we want to keep there, it has to go away to make it
viable.

The other option we discussed back then was to print a big banner or
something at runtime, but that is also not great (and people would
still see warnings at build time -- for good reason).

Cheers,
Miguel

