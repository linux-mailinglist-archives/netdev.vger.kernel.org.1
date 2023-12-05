Return-Path: <netdev+bounces-53724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A4804450
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F497281356
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39061C15;
	Tue,  5 Dec 2023 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Vrca1hOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB0E6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 17:53:54 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c08c47c055so56539257b3.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 17:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1701741233; x=1702346033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ishiEW4UMAXTmDDo7dxcxHshgbq6iysrNnaxKO7/+FY=;
        b=Vrca1hOGVWLTaQ+rlUFj0airJMdUhaHAKjZLfbidyeuTFvcmqjfL7Agg+o0t0tNOOJ
         FfdgMFEYLtcgOBtlf6PpIgk/BPLGJanCSf/eBcPN8dxGPwBeHV9RZ8+p8SskKDc82eR1
         /PKAA3xk3V8J/Canp3R7XbqCpWlJBhtVEyZqrfl8LxPWLs7kFI1sZEBSdA2W7f0Iu+Zv
         +ha8SqhGKfpsY3i5qyWsxP9B1c1rtq3BU3IbKnKvtTs13NeWNBRybnWjJXos8mSSKsCr
         hqbR7YRlpi01Q9LfqaBTgOlZK5Q2qKGEl0XZ8vHTuDu9R1aLJmwCSbm5sO6p75EFE9OF
         fX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701741233; x=1702346033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ishiEW4UMAXTmDDo7dxcxHshgbq6iysrNnaxKO7/+FY=;
        b=EleYeT7pn9c3Ya1JD6f4VaI9t3xvknuOB31W2woLL0PobAGx6EsoceTcQQZ0hgrRKj
         +wKJDIoJ1YKV2enIgsW4sA+xQNPDUriFtRRLGi9T1D4i89VD6RJ+Q6o7E4j/Re1AjwGO
         qbUCDaEGKza+qcqTY8d8q7FrRN8z2JCtBMRIpCDzKdS9sFllf+4/2V5ppjTqZBoy5BMZ
         Njj2NIpAoFExU30atXQ8pWuElrl1fIy9fzFaaMfp0W/IuJBXH5B+OKKZWVRqBLOwsVVS
         DZSBgrmRax5wh6HJePETy0g5+PhNTiS16lcH9EnqBdr41O4HdNzJqLA/WeG5/ATjC28s
         bgtQ==
X-Gm-Message-State: AOJu0YxgX+z1gr1LVolCJZDTNOzWnRyEclTSzPKO4+8wtE8IxXYC1G/F
	Kk1jJslQveqceWyR7odWD8lpwAlXLDz5u6WJldf2lg==
X-Google-Smtp-Source: AGHT+IH/035C/ctkUevN8nptwEpqGm9DVyH1S/5pHMuPxReLvLudij59XlD/ZHRoJHwxjKc0wFnHc+sd6+6B2W32p60=
X-Received: by 2002:a81:83cf:0:b0:5d7:a00d:62e7 with SMTP id
 t198-20020a8183cf000000b005d7a00d62e7mr3312855ywf.50.1701741233649; Mon, 04
 Dec 2023 17:53:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-4-fujita.tomonori@gmail.com> <CXG0TUFW0OWW.36Q4UJO1Q2LIY@kernel.org>
In-Reply-To: <CXG0TUFW0OWW.36Q4UJO1Q2LIY@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 4 Dec 2023 20:53:42 -0500
Message-ID: <CALNs47u5=HMa+RBK5NzJJYzg9rSsdqqAcY5SeT624Q4tri3YoA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/4] MAINTAINERS: add Rust PHY abstractions
 for ETHERNET PHY LIBRARY
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, wedsonaf@gmail.com, 
	aliceryhl@google.com, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:49=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
> > Adds me as a maintainer and Trevor as a reviewer.
> >
> > The files are placed at rust/kernel/ directory for now but the files
> > are likely to be moved to net/ directory once a new Rust build system
> > is implemented.
> >
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> This is lacking sob from Trevor.
>
> BR, Jarkko

Thanks, was not aware this was needed.

