Return-Path: <netdev+bounces-44777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579B7D9B53
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B10A1C210A1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E8374C6;
	Fri, 27 Oct 2023 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msj+ANxw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072501A5A3;
	Fri, 27 Oct 2023 14:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBC0C433CC;
	Fri, 27 Oct 2023 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698416784;
	bh=l1VfKmHVrmK0xHignQRjfc+NqzuNE9hObfeuJz3gStg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=msj+ANxwMNX8EkKMJTvRxANOQNzJ5Uca7msex8sDe0muobQUyZW+XoJa354kYsmK/
	 YcPJtfFdp7xYHQfcnyFsFLFSjLL7hloWfaGhgt/AZaKykd7H2eilzGekpAea0FLzVl
	 HzsJpvniwUNL403j8/8vDJ+5NnRu6d3PEh/aiCatB8Etg/rVo2/dN8QfO6n/JYA1j0
	 l/9wEdh+vhk2tzYS3F0NF3cAp8U2tG10+MdDvrB5J1Vd7dnScwuqYUTkctmH1iTkjN
	 9f4XaSPPzXwAHDz6RVIIDKc3NjmuJaeVRcgVkz2/g6910W3SEqf/Md27uTFDIOCcw8
	 vqRr2W/hb3iEg==
Date: Fri, 27 Oct 2023 07:26:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, benno.lossin@proton.me,
 wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY
 drivers
Message-ID: <20231027072621.03df3ec0@kernel.org>
In-Reply-To: <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
	<CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
	<e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
	<CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Oct 2023 12:21:33 +0200 Miguel Ojeda wrote:
> And as I said when you told us that, that may be the right policy for
> C netdev, which has been around for a long time, has a well supported
> infrastructure, the code base is well-known, etc.
>=20
> For Rust, it is not, for multiple reasons. For starters, we are not
> talking here about just another patch to your subsystem. This is a
> whole new subsystem API, in a new language, that needs careful design.
> Moreover, Rust abstractions are supposed to be "sound" (a property
> that C APIs do not need).

Nobody is questioning that.

> On top of that, two subsystems are reviewing it, and on our side we
> simply do not have the resources to commit to netdev review pace, as
> we told you privately. I am aware of at least 3 reviewers who have not
> had the time to look into the more recent versions yet, and it is
> unlikely they will have time before LPC. I would really recommend they
> are given the chance to give feedback.
>=20
> So, if you appreciate/want/need our feedback, you will need to be a
> bit more patient.

To be sure our process is not misunderstood - it's not about impatience
(=F0=9F=A5=B4=EF=B8=8F) or some rules we made up.  We get slightly over 100=
 patches a day
(for us to apply, not subtrees). Longer review cycles would make keeping
track of patches and discussions unmanageable.

Is the expectation that over time you'll be less and less involved
in particular subsystems? What's the patch volume right now for Rust?

