Return-Path: <netdev+bounces-40844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18D7C8D3E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6611C20C85
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F81F1BDED;
	Fri, 13 Oct 2023 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JooisrpC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8B33C8;
	Fri, 13 Oct 2023 18:43:35 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F131CC;
	Fri, 13 Oct 2023 11:43:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9151fc5903so2690106276.2;
        Fri, 13 Oct 2023 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222612; x=1697827412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhqzVFcWjYiuIlC2M+OeCR9AdcATVr+y2STC1n31eYo=;
        b=JooisrpCdmJUxGEsPHZpd/ORlMuRwMMBDodwFzUFOv2hvZmHiucP3CpeA7Ch2zvuRI
         5o7Np1I7cG1GtlFRi8S3Scsv/S6QW6OnUlkyWB3jDPFKELniLdZ8VUfE1oLwq/JcHvAu
         5q71dZtA5Dc7puip6PQA/lUvHzXyHQ3jkrRMOK1n8oMA/RZi7pGhGzjqSioxYeLbTX8f
         zeYsBPD7kiH6Jtxg6QgNcqOTlxeSdPiq6bx7iz98qywN7X2JU1rPtIMP2Fwh5VHl3Nct
         8GJRVrZ5jBq44nchFtxYKhZAxEmwMpseMEC/atiSc3AIeddIPXgEze1hFTyrHqrfLOOB
         7X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222612; x=1697827412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhqzVFcWjYiuIlC2M+OeCR9AdcATVr+y2STC1n31eYo=;
        b=Lm2Z7WiTXrLcyCush4+kxwUjyv1MfFR1Xypyx4tjyJR79gRU57Py7Fc5yrszbA7Ijy
         uOMiMzDtqExnMNmh7DLNW8WyQVwECAScWaipaGlMdATHQKEPb15Q1mRTm5G6jmP0DDlV
         gnn4nF9KB/DPWFvUcPWWIzCIzOl5YaDyIKQ9ep75RrwvLfa1NxfcJSgYW2y18cXzLZEF
         cWeGhi9lbOmE8WLSZObYcqQ2md+gMyuEs7dwb5VMosSuRS/s7fEngZSI+5xdCO3u0SVa
         2tRoVdY/qGkfo3rzeM5fP+DDTlKbbRTlrPvOfDyqjkSMBgB+yRwser0oR4cMN+3BQO7U
         44lg==
X-Gm-Message-State: AOJu0YzD7GjpBZwypyGB/uQM5mdchHMi2W45NDe2LUCaavFZc9Ppt2HH
	VroVcNGR7T9Nm/4mSMLKZIyzqNd3Fg8xds+v8qA=
X-Google-Smtp-Source: AGHT+IHzthzNwMY1wGOo43U10IWRRydm6kb1kVkU5f+tfS7oXqNqgcGLUuZdQUvwihOksy/SbGatuD+IPpoD2uZvs5E=
X-Received: by 2002:a25:c7d2:0:b0:d9b:353b:9e24 with SMTP id
 w201-20020a25c7d2000000b00d9b353b9e24mr1839623ybe.11.1697222612455; Fri, 13
 Oct 2023 11:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
 <20231012125349.2702474-4-fujita.tomonori@gmail.com> <ZSlVgAfz-O5UR_ps@Boquns-Mac-mini.home>
 <CALNs47u9ACA3MO2soPueeGZe=yZkieKb6rDr-G1fGQePjJ5npg@mail.gmail.com>
In-Reply-To: <CALNs47u9ACA3MO2soPueeGZe=yZkieKb6rDr-G1fGQePjJ5npg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Oct 2023 20:43:21 +0200
Message-ID: <CANiq72kS=--E_v9no=pFtxArxtxWNrAbgcAa4LUz28CYozbVWg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions to
 the ETHERNET PHY LIBRARY
To: Trevor Gross <tmgross@umich.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	wedsonaf@gmail.com, benno.lossin@proton.me, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 6:17=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> Thanks for the suggestion Boqun :) I would be happy to be a reviewer
> for the rust components of networking.

Thanks a lot Trevor!

> As Tomo mentioned I am not sure there is a good way to indicate this
> niche, maybe a new section with two lists? Andrew's call for what
> would be best here I suppose.

Yes, maintainers may prefer to split it or not (e.g. "ETHERNET PHY
LIBRARY [RUST]"). Then Tomo and you can be there.

That also allows to list only the relevant files in `F:`, to have an
extra `L:` for rust-for-linux (in the beginning), a different `S:`
level if needed, etc.

Cheers,
Miguel

