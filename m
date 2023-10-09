Return-Path: <netdev+bounces-39145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4CA7BE376
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0FF1C20AEA
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FF18C04;
	Mon,  9 Oct 2023 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6T+U6Ft"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E11FD8;
	Mon,  9 Oct 2023 14:48:48 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349959E;
	Mon,  9 Oct 2023 07:48:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59bebd5bdadso56322907b3.0;
        Mon, 09 Oct 2023 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696862926; x=1697467726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ro+SJCcRslKpAiug8s+931bqCz+BW8AihFJ9AsxsEA=;
        b=H6T+U6Fto7kM0uYQtz8YVIJHZxhjH+ZBSVcOymHw5BaaPYajk5lTPvpkCB/qjWoHa+
         93aXqQoYUbiFqRtjjh/abPSdF1YxXgC14jS022YOeuhla9v3DcidydfB0D8Ky+8dsshA
         Ou6eWDt1pT6YjAKQRemYL5YEMGaTgNLvRbzbBSeiCAEEY5kJUvcVENaPLEckjaLxOmwH
         5cjZ/A7PXDU9SLkoxAHn+o/3Ad8mm0zU+cw9S+UNJ+wLTDacLRtaxqQzhSPK4FjxCzn0
         0vI3F3VMBxxxiXmKrDNxYm4I4PNq36KzzLe67hNmA0wWvii66+EdWngTZk4MgaEUQ3p5
         AfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696862926; x=1697467726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ro+SJCcRslKpAiug8s+931bqCz+BW8AihFJ9AsxsEA=;
        b=dubwn/eO36AvTxdUm70HomDpFTVPLJwVmErmKo9mc8RgLwY3j9oyECHvvtqcGtVtiJ
         9tbn6aEyd/Qw3Z61BjZORiB5frsrdJXzYtn9xY2Y0zVpz2cTP120ryGpRu0TNZJ80ZS9
         oYVa445ihvjOqHC/QxDNl/Qc2VoO/J+OXoLvbL8mb8VpJwA9sFsVvRw1J1O5nfq7z+Sf
         Jd0nW4i6fZFyITtf9cStANmTlJAN90BsgW35R2BDfON/tLnytuhuI6CcvQoYN+IzYalj
         tZz+0QocE3zxfbnGYEMTApz3PGuY0Be1y1S+2pn6nf5NaqTy8w4ltfrX/V0SmKNg3+Sy
         VExQ==
X-Gm-Message-State: AOJu0YwYrrMymvqPVOAvXjQiF4yNAiU66+YQb8AgkIi/FSryHGryjKI2
	3OoY3rwmM6tCA8AYgwB8tqZGy+nh/tI4NUVWVhA=
X-Google-Smtp-Source: AGHT+IHyveZVSFkjSDZ3LqGEbbZmHOt2cGb9sqw6l3o88NogQf+l3PqytLTl08KjO8Ti+6TvF1gwt5BfgvtOLuNPnPw=
X-Received: by 2002:a81:9b84:0:b0:5a6:7f8f:b819 with SMTP id
 s126-20020a819b84000000b005a67f8fb819mr9817937ywg.14.1696862926447; Mon, 09
 Oct 2023 07:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com> <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <183d4a59-acf1-4784-8194-da8e484ccb1b@lunn.ch>
In-Reply-To: <183d4a59-acf1-4784-8194-da8e484ccb1b@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 16:48:34 +0200
Message-ID: <CANiq72knE9zK1Z0W6RMW-dn0Mqq2gZjJXukQPeXN4=MFcCExyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 3:54=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Can rustdoc be invoked in a similar way? Perform a check on a file,
> issue errors, but don't actually generate any documentation? If it
> can, it would be good to extend W=3D1 with this.

The Rust docs (like the Rust code) are supposed to be warning-free
(and should remain like that, at the very least for `defconfig` and so
on -- modulo mistakes, of course).

We were thinking of using `W=3D1` to enable more Clippy lints that have
some false positives or similar, but otherwise a lot of things are
already checked by default (i.e. while building the code and/or the
docs themselves).

Or did I misunderstand you?

Cheers,
Miguel

