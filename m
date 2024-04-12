Return-Path: <netdev+bounces-87322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71418A2A24
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 11:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90325288ED7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9EE53388;
	Fri, 12 Apr 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CAZlzv/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC85102F;
	Fri, 12 Apr 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911749; cv=none; b=rnB93+uvDuCyfPMeSC5wdkq90Wg5gS9nJGg5h5b08w+5XNSoFB5KQ1en3b2z0btG5OsguFmQKOl6RBeQO0d2OIJgYzGbufWwl47SRrqedrO+j+wHOnob4vz4tvMhzOW8JWPdci9ELv9X5UUhmCoPwEnTVJT29zZ4IhdcsqInc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911749; c=relaxed/simple;
	bh=25mpmnwFThR1+7u0P3ED28Wdq0tOKe4Y9k5vAsFmY1M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nURZGwCLsxzuNg6ASR6ozjnYATgY3MC9ENeWDGIIrLmN7s9yLR1vmdGjhc68/HFWbwrShoKqcavLNk02Hd5QdCqgXH59TBuo2N8KVAHvYc3+sVOQGTEBspSsywvYbi0+mGC9HwaMQ9dQzmYUGS/+Rgt5c9Pg5iNBcnLB2LLjQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CAZlzv/y; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712911739; x=1713170939;
	bh=aqmh+RULqViD5sjt54sQw5FZZ2wbvTZ6xtH4GZI/e2o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CAZlzv/y84Zku8f1Icgum9e76p3D25UG4jHpR0UmBosX39w24AQwF56iUMxfDZq4K
	 YpTiql3FpxrMdCk0TmTCJ2kpsYMkvsDqcw60+vaPXppTLABUFW5Pq94n1FSxh3QUGZ
	 LfDDKQEh+Cqi0ADX3SEN1gxpNpwnBqUdsvuICE/lvdMRxMpEplSVYaR4PQ/NsQJ7EF
	 gWb/2/13rdtR2S7BetDGbSAZGRuquWSQSnQmrEmlx8//hvD/tFg3YveJ32AnXk/oZJ
	 jOmoSoYhmLQMa+RRFyYXvEPgzFpXWu5xA2+8T0FGl8Ng7oNt16IzQnAzmGOYh6pKYM
	 09nVvrFI4y+ow==
Date: Fri, 12 Apr 2024 08:48:53 +0000
To: Nell Shamrell-Harrington <nells@linux.microsoft.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, fujita.tomonori@gmail.com, tmgross@umich.edu, yakoyoku@gmail.com, kent.overstreet@gmail.com, matthew.brost@intel.com, kernel@valentinobst.de, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: remove unneeded `kernel::prelude` imports from doctests
Message-ID: <02b9d259-03d4-4245-8b35-ec4d11b9c323@proton.me>
In-Reply-To: <20240411225331.274662-1-nells@linux.microsoft.com>
References: <20240411225331.274662-1-nells@linux.microsoft.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.04.24 00:53, Nell Shamrell-Harrington wrote:
> Rust doctests implicitly include `kernel::prelude::*`.
>=20
> Removes explicit `kernel::prelude` imports from doctests.
>=20
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1064
> Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
> ---
>  rust/kernel/init.rs      | 6 +++---
>  rust/kernel/net/phy.rs   | 1 -
>  rust/kernel/workqueue.rs | 3 ---
>  3 files changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


