Return-Path: <netdev+bounces-53723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E480444F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F318281305
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170517F1;
	Tue,  5 Dec 2023 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dAx0tXeU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA43E6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 17:53:35 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d4f71f7e9fso38158137b3.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 17:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1701741215; x=1702346015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8jNrMNgbTrnkfWx3nULTLfx0bs46KnpcuG8uZ6C8IU=;
        b=dAx0tXeUav4vCx8w2NKukVL82c39vfvtqbgGlo1AlCdMsP48A7apDxFptTIXQDVNWK
         JtsW09r8st9dyjAGA7yrD1PFcl/ICx6h2nVFdF+xwtS2P7CtsvuffnqHGXLDZB8HTnYK
         1HhL33aRv1wg5SR1nR+j/99Vw0pRjz/Fzi+4TFT68k8e1KsS/N4UbEI+xRtTb8h/LFNA
         MDGEgp+D2n0OTV0+Lj6lNTrgNFyKB2gZVkodwGG71wVPIM28FW20I6rioyR+z1llcePL
         KZuYPRpvBhlAB978yWVv1DTh5kv3FPBK1w59cV451xqL8rVCrDMomm4Y6VRmGohOnIfT
         8LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701741215; x=1702346015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8jNrMNgbTrnkfWx3nULTLfx0bs46KnpcuG8uZ6C8IU=;
        b=pl+L8YaQ5YkIbizJUl5N9znO3eSm/jqMGEMwkPpuCiARH8smqOr+OQydlnh8hD7OEG
         a6rnF9x+mK9DWI6YJ8li3+MuiEIccOp5pn2jCarSAdR+gyvyJLq+/8vfPn0/BzkrLxP+
         uXGuZHgOd6PIfXzRjgRQHTwypKhThM2W2Dd2IrQTzkuHrcAKFMH+a2HH3MFulBjr3c2c
         PtGvuhAeaRnAvIVmGKY6ZJo+0Nf7i2RWQWaImDmyhQcZC5nHMBbfD9v+8GfoB5DwopdF
         KGBMAhn+XG+Hv4IY4DB9I2ZCtBH3L7kxcAXcETAwEBTbHxxM5c3PU2ND/DJXQe6+dKSf
         8Gcg==
X-Gm-Message-State: AOJu0Yya/uBYryJs8533+GTkcsxqr1nR2EXnB5L2/PcXq2FJ8Lyien00
	kU+lfWEJjdK+SKZZnqZZKjNESIKxGXk1chsQZLq+Rw==
X-Google-Smtp-Source: AGHT+IHnoDRGbhlPk6efn85GfCKyqfCuAs1Lh9iASIj252OaTDkfUcx/t8px8F2UGrw6hxHEA+JfoI/1zyIwP3i+wmA=
X-Received: by 2002:a81:c504:0:b0:5d2:3a44:846a with SMTP id
 k4-20020a81c504000000b005d23a44846amr14106158ywi.46.1701741214965; Mon, 04
 Dec 2023 17:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com> <20231205011420.1246000-4-fujita.tomonori@gmail.com>
In-Reply-To: <20231205011420.1246000-4-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 4 Dec 2023 20:53:23 -0500
Message-ID: <CALNs47v4zq3-W137iEzEwdd63iZNA_iWULKHWJrEA42mzRC8+w@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/4] MAINTAINERS: add Rust PHY abstractions
 for ETHERNET PHY LIBRARY
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, wedsonaf@gmail.com, 
	aliceryhl@google.com, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:16=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Adds me as a maintainer and Trevor as a reviewer.
>
> The files are placed at rust/kernel/ directory for now but the files
> are likely to be moved to net/ directory once a new Rust build system
> is implemented.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

You may add:

Signed-off-by: Trevor Gross <tmgross@umich.edu>

