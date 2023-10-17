Return-Path: <netdev+bounces-41958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C17CC6F3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2EC1C20AA4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E0D44470;
	Tue, 17 Oct 2023 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Skp+qL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871671F61D;
	Tue, 17 Oct 2023 15:04:10 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17960F0;
	Tue, 17 Oct 2023 08:04:09 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a64ca9cedso5857782276.1;
        Tue, 17 Oct 2023 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697555048; x=1698159848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvAYxPZq19QuYMm9V9Ix5MZ3K9vR5maAzHdfTAZ+zKk=;
        b=H4Skp+qLB6OGmvpmQE+xvkEfRi+DniPQv1GGdqNYYhXAJAzT+Pg8St8E5jM7/gYDF8
         qJvPx2yRIy/4hOVILzag2M1urXU0eEKZQFpXziXrrvy1bA9bYOabzvzybhRqcOVPx8dF
         RZy1lba9nbHie5cz5FlDypV0CViZEFcNdkQscOIdtPYg8KgCtKaDwV6Ep3+h1KY5MZKn
         SNJWk+7/xXYec/vY+E7cJ3VxmVAFGvrVDzWuPDRW1D6moxofdkTkQCiSXuQxW1wP8h+X
         3gQMOYzoJaQW27aeUG0Bd4JgBKFeEEyYB8gnT892mMKVrRqGQ5FBhnTmrYJUsCpscgfP
         upkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555048; x=1698159848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvAYxPZq19QuYMm9V9Ix5MZ3K9vR5maAzHdfTAZ+zKk=;
        b=safdkJrM1TZ8+eH2nElQ7hZTwrgQyUtpAcUX6FRQRCVFlRIDgR57Wm/yimJcRvVflk
         0fsF4EPG6a8EdoWZGwPMd2c0jGshhW9aSsUtQ5H6rIr5E9Uj4r6ivbmeKmI6T5ey6An2
         eZbPShjOBM1JBhNl2azJZ+mCpHnO/EIUNXIbL+fsXdFY9aEUQJpBkqAYWT8KFOyEkDID
         58zn6Czc/S3nI58hhgEX7am068AdpIR+JtKSoYnS7fEuoCD5i6x1As/215zZEW2+urBR
         0GN3WCY9toiQoEByi5vNQUCNnjTc87CKldpI0y8DorBhrCNzVOY/oFDENr/tmEhjlgHu
         hS+g==
X-Gm-Message-State: AOJu0YyISY8AsV9E/yxeqw4pJ0IVgF+Wct2wrbCY7Mrm5nsTsNUu61KA
	P1gOKBEMfYoRpO2pOe/OXH7Lc0/pUmSEtn8toX4=
X-Google-Smtp-Source: AGHT+IHyuihFSV7ZqXD3w/W43HmuZVcseFccYATTXzUWRz6MlNPk/FaOqkHBEaW7p90DjJhD1eMyn/ltidiPpOcW7Ek=
X-Received: by 2002:a25:d254:0:b0:d6e:3544:9871 with SMTP id
 j81-20020a25d254000000b00d6e35449871mr2542412ybg.44.1697555048064; Tue, 17
 Oct 2023 08:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
 <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
 <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me> <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
 <98471d44-c267-4c80-ba54-82ab2563e465@proton.me> <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
 <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me> <2023101756-procedure-uninvited-f6c9@gregkh>
In-Reply-To: <2023101756-procedure-uninvited-f6c9@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Oct 2023 17:03:56 +0200
Message-ID: <CANiq72nXcyig=FYY5NEP1RYADArk86XJEUxsoA5R2gGe7O3uLg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Andrew Lunn <andrew@lunn.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, boqun.feng@gmail.com, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 4:21=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Again, no, deal with what we have today, kernel code is NOT
> future-proof, that's not how we write this stuff.

That would make the abstractions "unsound", i.e. UB could be
introduced from safe Rust code, which is what Rust aims to prevent.

It is not so much that we care about "unwritten code" (or out-of-tree
code), but rather that it prevents having UB in users of the
abstractions.

Put another way, there may be no code today that triggers UB, but
there could be, tomorrow, with a new driver. Or when somebody modifies
a module. The goal is to simply not allow broken users to compile to
begin with.

So if we allow unsound abstractions to be merged, then we are
essentially losing that "layer" of protection that Rust gives, and
thus one of its key advantages. Instead, if we manage to keep the
abstractions sound, then we can review Rust modules that do not use
`unsafe` and statically know that they are not introducing UB.

Cheers,
Miguel

