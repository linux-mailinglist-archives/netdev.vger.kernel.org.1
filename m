Return-Path: <netdev+bounces-53726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F116080445F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD0B20AE7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D717F1;
	Tue,  5 Dec 2023 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9yVHhLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818271C2D;
	Tue,  5 Dec 2023 01:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A08C433C7;
	Tue,  5 Dec 2023 01:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701741434;
	bh=JqnBkwmcS9JHp6n+2eu4zom9fDoNynzAqfcSrp/+A0o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=l9yVHhLCa43b5IuMUiBrAhKqEqFjd2q9FXH7MWBiCGIVzf9bgQaOlEHcWSs2IMQvA
	 x06wg7/dOKsucMsPldHco2za3Dkl8MKiUrfCPTxUv502hgh4r3vj4d2CfQHxfP8UDB
	 Z9gx5E8WgAyDkLnS8q5tIF01gp092ysCo1txL7BiIGMXdmySiAYNnwtpHIwiE9YQi7
	 3feA1N1gSZ8vb9amqKfcHJ9K7TRQnbEeWssvaYHjFQzITjiteWLoQo6UVKSK//7Yxx
	 b+2Sxlcayu1q/taq9ag0RUtoYUOjzSaFdxy6BEDcIyPtkNFZHmKMj+qMkCj4hTgQzi
	 qFv1BdI1lTKdA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2023 03:57:10 +0200
Message-Id: <CXG0ZOHXON5S.258UJJG12MI4@kernel.org>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <andrew@lunn.ch>,
 <miguel.ojeda.sandonis@gmail.com>, <benno.lossin@proton.me>,
 <wedsonaf@gmail.com>, <aliceryhl@google.com>, <boqun.feng@gmail.com>
Subject: Re: [PATCH net-next v9 3/4] MAINTAINERS: add Rust PHY abstractions
 for ETHERNET PHY LIBRARY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.16.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-4-fujita.tomonori@gmail.com>
 <CXG0TUFW0OWW.36Q4UJO1Q2LIY@kernel.org>
 <CALNs47u5=HMa+RBK5NzJJYzg9rSsdqqAcY5SeT624Q4tri3YoA@mail.gmail.com>
In-Reply-To: <CALNs47u5=HMa+RBK5NzJJYzg9rSsdqqAcY5SeT624Q4tri3YoA@mail.gmail.com>

On Tue Dec 5, 2023 at 3:53 AM EET, Trevor Gross wrote:
> On Mon, Dec 4, 2023 at 8:49=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
> >
> > On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
> > > Adds me as a maintainer and Trevor as a reviewer.
> > >
> > > The files are placed at rust/kernel/ directory for now but the files
> > > are likely to be moved to net/ directory once a new Rust build system
> > > is implemented.
> > >
> > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >
> > This is lacking sob from Trevor.
> >
> > BR, Jarkko
>
> Thanks, was not aware this was needed.

Trevor is an actor here so it is just common sense to be aware that
the person is signed up for the job. Compare to any other contract
that you've made in your span of life :-)

BR, Jarkko

