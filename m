Return-Path: <netdev+bounces-39134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461057BE29E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463051C2095A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6971A35891;
	Mon,  9 Oct 2023 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze6MDAEz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8FE54D;
	Mon,  9 Oct 2023 14:23:12 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4578E;
	Mon,  9 Oct 2023 07:23:11 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a200028437so57172597b3.1;
        Mon, 09 Oct 2023 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696861391; x=1697466191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+K98nB5NSmt/uyQbB7mTA19vpaoMo5M6YIsrmsl/6U=;
        b=Ze6MDAEz7r4sf/syIraPweGJY+HV5IM4SZ3y5bknGkC8maufU9Tv0vjbIiw7txijPV
         Nixa5WZkP8VJdR/qyhEsW3slyjgOOT0klU1qkbH7GiNcOud5Dm8zxaeKZJE4kqY+NZU7
         JISbJ5Wuw2Ud57VATQwO+JLC06pfnlhwupDWiMpJB+64neuuoh/HfXg15ya6Q3fjfmh/
         3IuQwsSCZ/3hXRxRoB1SH3bjTohyhM2NYOwrWVxYsVSWlZSYL0uuhS2Nv4uvPO5Y3E0F
         LJqqg4NViGlZE6Df2TfsQJ5I0MDTdu+ugB9wngDiIRjPh0tfockSzS5mw0o8PV3T2Dmg
         wkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696861391; x=1697466191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+K98nB5NSmt/uyQbB7mTA19vpaoMo5M6YIsrmsl/6U=;
        b=t40u9FcKo6g+RXfakRp2UwBAHNHIfJVGgp69LhvxvIMCQOKQ1r7h6ydC0g4bZW2+Og
         q0LytZMAVKxfmCKGm+lOsvyxEZRZ9jE8ZHqbI8q+ew/9ET/lgCmz5HzL7j1jpWFFqZIF
         Zqz8CAQGK5f5Mq3Hw071qxINmTGDH5OcjT3lDuECdfBrID7Q2S6mxQxiXnomOWR3Qgxc
         Gz6TSbk/pgqAY9aC16q8Nz5fCTD9lxDWuZ4dwUi7vhELbTKCA9+C4nohvKuvc15gFhYV
         uNemgGXNi69/5mRxZNn52+CBJzJlxlMhmJ55p5trx7N8E5bNybHjsNiKJS3+JMR/fNoR
         VbMQ==
X-Gm-Message-State: AOJu0YyD8cGG+b/TbVlz59N21sZlL5YP9gRYW+wyoyrBW1CNzRZ/qfhw
	qQPoSWCAxfw4TCoCs46UKzvKCqxslUvxnYOXsxFiP5lt9VAC6hZs
X-Google-Smtp-Source: AGHT+IHEFyvX12XEe+1UM60umvRqNTozZZfleQH4SpQD9pTWhqI0z/e3tpCtg/HEgeosO0xRBFPNSWxQJGoSMiFu2F0=
X-Received: by 2002:a81:ee11:0:b0:5a5:798:4f0b with SMTP id
 l17-20020a81ee11000000b005a507984f0bmr11772544ywm.52.1696861391043; Mon, 09
 Oct 2023 07:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch> <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <ZSQMVc19Tq6MyXJT@gpd>
In-Reply-To: <ZSQMVc19Tq6MyXJT@gpd>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 16:22:59 +0200
Message-ID: <CANiq72mNg8bw7r6acZX1OniOO+Qt8Mo199Nj6qBm1r_-s3fwLg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 4:21=E2=80=AFPM Andrea Righi <andrea.righi@canonical=
.com> wrote:
>
> Disabling RETHUNK or IBT is not acceptable for a general-purpose kernel.
> If that constraint is introduced we either need to revert that patch
> in the Ubuntu kernel or disable Rust support.

Yeah, I was expecting that you would disable the Rust support, of
course (not that you disable the security option! :).

Cheers,
Miguel

