Return-Path: <netdev+bounces-220501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFBFB466FE
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D7FA4473C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443029D29D;
	Fri,  5 Sep 2025 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8jFoaR9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039F28000D;
	Fri,  5 Sep 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113642; cv=none; b=fOqpW2sxJHEQpWXERatgpYpaDWmh0B80GR5GcCmE6DBo6YM2GeyFq1uUx6pj7kY9X32dahjZgi6j3hEFbNXzNyatrcktu1M1MYRvA6Y7Bvnegb8esLTiigyMDqPBcnXmOjoxDt8/ieXTHfgxJxz7bJIvMQgQcYlkK7vUF/RxT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113642; c=relaxed/simple;
	bh=qfOuw9O05pqkELWv9EdykjeQMNNbPpkQc9cTgNJnqEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sH1SpD+7Fv9aFI7YUfspz3ECrQdN7ExjplJhSu6/30v+T5XJrFlj5CvB6yo6IQIwFfp8V1YpcuDZwFk4ifV6KGTQ9jRNT+hMd8I9vo9MTlRO/3JcJ72p+1+NPe/AsmElD5Y1cqnka6wsZ+lN38yDUImbRY7ctc7aLEt2JHUZTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8jFoaR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE6DC4CEF1;
	Fri,  5 Sep 2025 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757113641;
	bh=qfOuw9O05pqkELWv9EdykjeQMNNbPpkQc9cTgNJnqEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O8jFoaR9QDC4TQoenofHXPKZ9hMwLmFki9fbZcyRQNTnN67ySRkfw//nxZrFSDpPd
	 qnVQ8oktcE7FYrr5nF8JkLEDkP6kb7b14DyFfu4+hnAA+C8qiKNkAoBRuKzYTu3nTE
	 fEXwF7S7STLjppPGvJhH4hmHsGwzMFr9aOEJxwcVEsFOb8L4Aldsj3lozq+yJuM2Tr
	 kvgphHUBvXgDQaKMgG2TPVJZm7p9E/SgCL6P7Z0798AuIxdCtfVUyKWtTtumW90ltT
	 Rk9GRoN4dJItjNnmyN3FnGrMq+THOOBnhDKyac5FeZHfvGgNB6NzbH5BYFIYloG85q
	 hkyl6kIUaOGtQ==
Date: Fri, 5 Sep 2025 16:07:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <corbet@lwn.net>, <andrew@lunn.ch>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] docs: networking: clarify expectation of
 persistent stats
Message-ID: <20250905160720.1e7b2136@kernel.org>
In-Reply-To: <aLrDvpAsVq4vTytH@naveenm-PowerEdge-T630>
References: <20250825134755.3468861-1-naveenm@marvell.com>
	<20250826174457.56705b46@kernel.org>
	<aLrDvpAsVq4vTytH@naveenm-PowerEdge-T630>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 16:34:30 +0530 Naveen Mamindlapalli wrote:
> > Note that the following legacy drivers do not comply with this requirem=
ent
> > and cannot be fixed without breaking existing users:
> >  - driver1
> >  - driver2
> >  ... =20
> I don=E2=80=99t have a definitive list of non-compliant drivers. Would yo=
u prefer to add
> a brief note stating that some drivers may not comply, without naming the=
m explicitly?

We don't have to list them all from the start.
It's for a quick sanity check so that users don't duplicate work
validating that their driver is broken. Maybe say ".. following legacy
drivers are known not to comply .." Hopefully the "are known"
sufficiently indicates that we're covering only one quadrant of=20
the Rumsfeld matrix.

