Return-Path: <netdev+bounces-176957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5748A6CED3
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EA71651DA
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65C220126A;
	Sun, 23 Mar 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hdy8pQea"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300B1FC107;
	Sun, 23 Mar 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726358; cv=none; b=g/RlHO6S5RyztRylqVvSKHR0gtsC2KIC+Odnz9sK3khsIQ4NIavUgSTT+tv8avaxR/YPYjyLPbdx8nlofb6S84OQW4y+vdH7kPB1Q9DMt/wksZmBg6rAW5vNfvQhi6zRLaiPXN+yZtwmBNl79mAm4Tcfrj+K6BencunkM8hv0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726358; c=relaxed/simple;
	bh=AVRh0Xa6OPw4Vrq9X0/9b2V0Lz/TqprJd2MOxOm4igM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y2k2RY5En3/iXUU3p6OkjmrqB+5M/AGVLFyophUk6p6u56FuCJ4iEleCyTpFxzW/q6wGJe64fzb0YEKiiUIMGguiejs+jbJIVUeJ99W6ADYJZaAaedE50UG4WfN2Mlj3KawIA8dlQj7/V0TY3m9RJrppHimXzEOINWktw9GR9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hdy8pQea; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=c5isnu5aurezjgl6uh5xx6wkaq.protonmail; t=1742726354; x=1742985554;
	bh=vmqzh7/G+ae0+uJvF7eWYfnyUM6UEP9JdNqwExsi6yE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=hdy8pQea/2n4T48vqxgg95xVMg29YXggCAD3CaHf76ydSBpzHWoWALslKOmJAHsRI
	 AwOneiGUl8auVPJ0GluNjLLMzI5DdvBcpHeF5XaHSGqEYsEFLdkD8KjP+3qy71xlPW
	 mCftBhqvW/o5G0ruGWvs3OWSN73ybZ3FHrrgx3jExFdeIoAkWjfV4Z1Rb7hUVkiB2O
	 9ls7SyqUoib4Wm+Qq2j0QdkPKC4udtuBmhCzkLh2ABhwnl6wNVILM0UvsCcD2MAlq+
	 dmlyyO5vC9dVTj3GWHzDV0n5dlZPeLHTvypeTHNvABLRI0rTrs3ZcF+CaJpuEkb1X5
	 KCH8bJyg5Ed5g==
Date: Sun, 23 Mar 2025 10:39:11 +0000
To: Antonio Hickey <contact@antoniohickey.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/17] rust: net: phy: refactor to use `&raw [const|mut]`
Message-ID: <D8NKXKB4SLUN.2Q6T2MCQQZMOQ@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f1bf29502283d6ae593996d04b5eca3f90ce8144
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of_mut!(place)` with
> `&raw mut place`.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw mut` is similar to `&mut`
> making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/net/phy.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


