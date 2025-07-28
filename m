Return-Path: <netdev+bounces-210512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED1B13B52
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73921891C24
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1726F462;
	Mon, 28 Jul 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bef4sCq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78E26E717;
	Mon, 28 Jul 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708567; cv=none; b=UZUZm2jxI3MdoQJTNUvISmXk5/XCwj/R7qVcfkVteCk7W5QfdidwsvXlw6kB5IOIsbGg3ccH+nHPAW0ujIKh7TFSlO9FCxRKDrlc80l5lfSs7HSkUo792kTRil7tJBzJsLD+szZUzaazEgaa3T03niMhJT3xBSHHUbSIG4yeSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708567; c=relaxed/simple;
	bh=2db+AFMAx53POg/rI8NBOnYTcv5hfuZNGSBrihtTzjg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LqjMwcqfQtdNOAodHg20YvwqgYh2Fa+JTvXcctxjREJFCWx4IrjwCoeiELWo+HQLeh2driHkik+B2MS266wUS7MHTf1irj1MzZCIJ3ujRkI5JIwTxM1zL0keKjsxZWmMc8fdJClU7UHldOFglK+o2Eu7lk7T+T52SK6towJkWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bef4sCq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2CBC4CEF7;
	Mon, 28 Jul 2025 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753708565;
	bh=2db+AFMAx53POg/rI8NBOnYTcv5hfuZNGSBrihtTzjg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bef4sCq92jyFBwxJPgbv59VImZbvd4eOE0nvmcyBtu3J9tjRoD71DjqyqEYmqBW3L
	 dzLShbK3KhH6Jo5U3AW4sFCdMN6uWKbltcYEDx/Th03bV79RMPPNtNqJPhukIiSUCQ
	 xQvWe4qswL1ZnKi8gxCfFOorg2eqspvBjCao9apY2W9eS4Cl3Upjv/S14dsb7iu46h
	 eN3hGyLV/N1fr5G8YQp6TjZLFgpmbunV8eeXh9D7NZdeRn/LlNFc6p/+4cMp+je7ql
	 ZNdRUldPMqttWUuoEu7H9PG5c412M9kHRbj7UnrThyjvGLcQnmMwuO4PrjIg1aLCRV
	 bxmlWw5dBI/tw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 15:15:57 +0200
Message-Id: <DBNPST5JN6YO.S1NRRG551M1M@kernel.org>
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Cc: <kernel@dakr.org>, <daniel.almeida@collabora.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
 <tmgross@umich.edu>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@samsung.com>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
 <arnd@arndb.de>, <jstultz@google.com>, <sboyd@kernel.org>,
 <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <tgunders@redhat.com>, <me@kloenk.dev>,
 <david.laight.linux@gmail.com>, <acourbot@nvidia.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
 <20250728.215209.1705204563387737183.fujita.tomonori@gmail.com>
 <6c5b4f8f-c849-47f8-91ce-fc9258b0f239@dakr.org>
 <20250728.220809.2078481261213859858.fujita.tomonori@gmail.com>
In-Reply-To: <20250728.220809.2078481261213859858.fujita.tomonori@gmail.com>

On Mon Jul 28, 2025 at 3:08 PM CEST, FUJITA Tomonori wrote:
> On Mon, 28 Jul 2025 14:57:16 +0200
> Danilo Krummrich <kernel@dakr.org> wrote:
>
>> On 7/28/25 2:52 PM, FUJITA Tomonori wrote:
>>> All the dependencies for this patch (timer, fsleep, might_sleep, etc)
>>> are planned to be merged in 6.17-rc1, and I'll submit the updated
>>> version after the rc1 release.
>>=20
>> Can you please Cc Alex and me on this?
>
> Sure.
>
> read_poll_timeout() works for drm drivers? read_poll_timeout_atomic()
> are necessary too?

Please see my other reply on this patch.

