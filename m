Return-Path: <netdev+bounces-53722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0809804443
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372B32813BA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CD1870;
	Tue,  5 Dec 2023 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYRSz+NN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A423C1;
	Tue,  5 Dec 2023 01:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DDCC433C7;
	Tue,  5 Dec 2023 01:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701740977;
	bh=81TCWr50PvK0wxgyXdF4t9EGy/NUlI+QFv8PRp6f/Wo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=bYRSz+NNxUEJ7MU0fx18t1Ghqy8UUoadz2BftmOn8C/JzIL58EPOphn4LG9vikY1H
	 UiXmY02oE64ipg0WI1GdP4Vd5WvKrz90+tUuD1yXfryuJ3UuTG+b6Bo0tURlrgSmtC
	 ndYoi37XZFFh/m0XzcS5om0m/vj3jpo5MXTG17gpWo2m4GUBs8qnetLO4coVuboS/4
	 p02UU/14hMoITTJubzxGrmFOJIKK/dqjwEPzITFUvqY7KZSUK0G/lEvaeFzbDlNaZ0
	 1or9M97xU7cSYwSPn6QggO3akhCqbvSjXWoe5lx4pHSW6OZNskqNuf59Bc3eyVrJPz
	 vjqUSBRPFSbtQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2023 03:49:32 +0200
Message-Id: <CXG0TUFW0OWW.36Q4UJO1Q2LIY@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <netdev@vger.kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <andrew@lunn.ch>, <tmgross@umich.edu>,
 <miguel.ojeda.sandonis@gmail.com>, <benno.lossin@proton.me>,
 <wedsonaf@gmail.com>, <aliceryhl@google.com>, <boqun.feng@gmail.com>
Subject: Re: [PATCH net-next v9 3/4] MAINTAINERS: add Rust PHY abstractions
 for ETHERNET PHY LIBRARY
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.16.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-4-fujita.tomonori@gmail.com>
In-Reply-To: <20231205011420.1246000-4-fujita.tomonori@gmail.com>

On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
> Adds me as a maintainer and Trevor as a reviewer.
>
> The files are placed at rust/kernel/ directory for now but the files
> are likely to be moved to net/ directory once a new Rust build system
> is implemented.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This is lacking sob from Trevor.

BR, Jarkko

