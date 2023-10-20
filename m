Return-Path: <netdev+bounces-43003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243C7D0FB9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107A6B2142A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A212B91;
	Fri, 20 Oct 2023 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGtCdQGA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFB1A700;
	Fri, 20 Oct 2023 12:34:57 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B2D49;
	Fri, 20 Oct 2023 05:34:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59e88a28b98so6711257b3.1;
        Fri, 20 Oct 2023 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697805296; x=1698410096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+uTffmpyQEAmlrNXImaq/tNp+a5U7h5eJl7wq14bSA=;
        b=aGtCdQGA5CIOxnjz7aH9/Dpo127uwokymSuw5HuoteJMvelO7FNJQeyPxDURrNz9ID
         7rBYRdGWIX+MnPIgb4LhvjmCbxci1B29fDgXyJiYw65Nw/P1HgEm39dGNoCnktsyZaFs
         FQLA8RCjvkMRkvl6QRsOInAMuok1i5Fly3Dnjq3nDFlOkBoFNX/ynfzNX+hdXvWGUvq7
         /ASeHdbetD2HlyCYelHKxd43PETD7h7QHbbNc4KJf5S0sl0uCvPE6w6w0yog9ZzL/cxV
         5+X/LVOYBM/qO6APyz84wQrE3zCA/9s3GkOhQaX0rRWQXhOy5aBFsrWyDR73yAFWBke1
         w6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697805296; x=1698410096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+uTffmpyQEAmlrNXImaq/tNp+a5U7h5eJl7wq14bSA=;
        b=VUNN6zQX48sleBW7alittX2Kp7oTyPVdoszvvbH/RK59mK7siwPTBKZ4QmNK8BztI3
         x+kjz3GQqqdI6NGnI907zxRdY57JllOeIJ19B32vJsZi98NI2r6iuvo+fLjcq1loq91K
         J8VGHCAOjom72vGHYCAxcZq5lFoqdorjzyq764gCyOdbv1G8JBx/CG3KBPDwup9jQWzW
         sO0nKu8qOmKfdWN1c3R7pOOYoudkap0ykTO90VS5hIzRNdd0sL+6SbP3i4kJ6y5Y/2yN
         pA0L+BfjMVwnJApNX5GF1yxPY+wFYXDrsMm8k2uGjVx4m0we3Bz2lCdC6tSpot+DVMfJ
         pmWw==
X-Gm-Message-State: AOJu0YzFamMYfit/I3Nz3QYgSQ9rTTCONy2zIcYpUlMj++0jem7YC++Y
	xmyAB9a1jCS7bzSMrQxe0QQtR2bbhvcHIS73/+C7OwIiuYSTkA==
X-Google-Smtp-Source: AGHT+IENLbktdvw237qo8nPz4Cx3UNK57HbjST9dq24dpZxiNVudl9Is1VvuH3KxGosVcIVkGNggDePmAVtPsJEO12E=
X-Received: by 2002:a0d:d444:0:b0:5a7:bf2b:4729 with SMTP id
 w65-20020a0dd444000000b005a7bf2b4729mr4078992ywd.23.1697805295842; Fri, 20
 Oct 2023 05:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-4-fujita.tomonori@gmail.com> <871qdpikq9.fsf@metaspace.dk>
In-Reply-To: <871qdpikq9.fsf@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Oct 2023 14:34:44 +0200
Message-ID: <CANiq72kWu-zNbhYxvcM7TVFLOEoRczK434J2t4rLhU31AMWAwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] WIP rust: add second `bindgen` pass for
 enum exhaustiveness checking
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, 
	boqun.feng@gmail.com, wedsonaf@gmail.com, benno.lossin@proton.me, 
	greg@kroah.com, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:42=E2=80=AFPM Andreas Hindborg (Samsung)
<nmi@metaspace.dk> wrote:
>
> This patch does not build for me. Do I need to do something to make it
> work?

Please change:

-        --crate-name enum_check $(obj)/bindings/bindings_enum_check.rs
+        --crate-name enum_check
$(srctree)/$(src)/bindings/bindings_enum_check.rs

Cheers,
Miguel

