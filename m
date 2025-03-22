Return-Path: <netdev+bounces-176856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E59A6C937
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ECE16CA2D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849671F5857;
	Sat, 22 Mar 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikw1k7PL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE42AD20;
	Sat, 22 Mar 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639263; cv=none; b=bLMUBqO8Qevu201Z2SRlee6dxuvnvup+DSSqX4PvuyNVlXrTUObQFLGt7ig1VwP3cwh9CQHNXF4WOI715hWJU109RD6r1V/gIyaj81CxCtY1B3daUYLDxr6+WVi2eefLwDrsB7z3PxnqEFHt9pSsrhjAlQychqyEBLBy3s5K26U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639263; c=relaxed/simple;
	bh=g6kgjj9jrz0gAdFDcYlb6OkHwnG/u5DXApJOwXWpN9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o36/nL2WFWzywG3zBqJvoWokIDn7/esBJi1xYf0CkttOddLiuZZpHqAbGAr7r6Q/3jALL6EsfNYGlMaqRpZxKdUWgHO+mtne0vs6ojxGD1uMTspzCIc2UU+qtU2cnZVTADmFJ/H8OzhpDm+Fv9TrC4r8UpNash4mulaheXaNdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikw1k7PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07C3C4CEDD;
	Sat, 22 Mar 2025 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742639263;
	bh=g6kgjj9jrz0gAdFDcYlb6OkHwnG/u5DXApJOwXWpN9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ikw1k7PLa8sA1dy4SXFVfnVPgL5TSMMuual93FXzNUKlk2XpQ4CXuRbZhwOUWQ4KJ
	 9A72bpNZ631I5z7ihIaccoN4I5LmAu6NyVx3X9qJaD4/Jloo2UHyZgS5+SegefPDdv
	 Sn97W1X89/hHCEXq5fodPJPEDxvVTP1lt1ObBjcAoHvgPsrsDRM2Z8fJVWT1i/pfkw
	 JsGmAy/Df86YWu0YNWN9PmsSNDoRqxB/3xEqgG9eT0UzqOGDc7q57tPmXLqSX+mvVk
	 EcBBCz+O/etT40Ks+SH/Smb0KZBbRwHUtaHIUkw+98egNWVwfx8VuXpH1NMxe7Cu+3
	 dizN6k/MUDJwA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Daniel Almeida
 <daniel.almeida@collabora.com>,  Trevor Gross <tmgross@umich.edu>,  Alice
 Ryhl <aliceryhl@google.com>,  Gary Guo <gary@garyguo.net>,  Fiona Behrens
 <me@kloenk.dev>,  rust-for-linux@vger.kernel.org,  netdev@vger.kernel.org,
  andrew@lunn.ch,  hkallweit1@gmail.com,  ojeda@kernel.org,
  alex.gaynor@gmail.com,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,
  anna-maria@linutronix.de,  frederic@kernel.org,  tglx@linutronix.de,
  arnd@arndb.de,  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 2/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord
 trait to Ktime
In-Reply-To: <20250220070611.214262-3-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 20 Feb 2025 16:06:04 +0900")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-3-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 09:51:30 +0100
Message-ID: <87wmchbg8d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:

> Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
> can be compared to determine whether a timeout is met or not.
>
> Use the derive implements; we directly touch C's ktime_t rather than
> using the C's accessors because it is more efficient and we already do
> in the existing code (Ktime::sub).
>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




