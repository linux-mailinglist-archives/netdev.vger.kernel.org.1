Return-Path: <netdev+bounces-210528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27945B13D27
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9437F1652F0
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD091C861B;
	Mon, 28 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Dd0k01"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165141C69;
	Mon, 28 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713018; cv=none; b=KE0beS9cP3l7ZQmCat22nRLXSlpBPSlgHPuST2NCPixChMghFIKjWhqDE7P48aA20xTs5xN0JqT1PKxQk/4JMj2bV2nPKPZv1zQ/nzaXUEDJB2wZGYI2bom3om/JIBhABm/rlFuiNX5KMxVyBYHzh7yqxjj93eQV0FrCSi05RaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713018; c=relaxed/simple;
	bh=D1CZYbbPrl92SrG8JBJiCygXJIptUMouA14qNJbAWV4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dSXFhFV2n01yBy5YIyIzdxc+jKDE8yctEWuYDopUZK9b01O2ex+Jc9l+ySDiw26b5Gf8jsosCj+QhXMcU08v89ooJBbXyyEW1wXhXz9mfugOisY50Zz+WjrL7eKU5k3Cso0lXMYc4lHjF7POvwkLmTr9x0MHENbpgx6PKxa0ARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Dd0k01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961D4C4CEE7;
	Mon, 28 Jul 2025 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753713018;
	bh=D1CZYbbPrl92SrG8JBJiCygXJIptUMouA14qNJbAWV4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=c3Dd0k012sWwA2o3tU3o5nV9Qm4TyLNmncX+0sGwazIJPRJVmi1Zk75Fcc5P+xGMu
	 VoVGuDo2ZRgWIAH0tJ3bu8aaAHh0e++NlHuhCYSjjvyGAsC2HxixpIcD9B7zFETPZM
	 ArzjWAO7mv6a2dfJI3lfR4F+NJYO+q8luRAltXmep11tRDhXlhIxYAyS7v2NkQV5Jh
	 z4fM+iU3axkY2oXIH5TaP4cneOPwhs9wRvAGhlZ8G0lv7RX/OwHLm6jqx8478M5aFH
	 O5VZHYRTPHMviVsv0lNDYtkjZOkxV31lDK7uNvjKS1rzomFsTBXNjV7layzuR/j4TK
	 jFmW3vd1xLIuw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 16:30:09 +0200
Message-Id: <DBNRDMPLIAAI.16E3LKVM8VBRO@kernel.org>
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <kernel@dakr.org>,
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
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
 <20250728.215209.1705204563387737183.fujita.tomonori@gmail.com>
 <6c5b4f8f-c849-47f8-91ce-fc9258b0f239@dakr.org>
 <20250728.220809.2078481261213859858.fujita.tomonori@gmail.com>
 <3C846EE5-6B1F-426C-A18F-88003EA6F9BC@collabora.com>
In-Reply-To: <3C846EE5-6B1F-426C-A18F-88003EA6F9BC@collabora.com>

On Mon Jul 28, 2025 at 4:13 PM CEST, Daniel Almeida wrote:
> Tyr needs read_poll_timeout_atomic() too, but I never really understood
> if that's not achievable by setting sleep_delta=3D=3D0, which skips the
> call to fsleep().

read_poll_timeout_atomic() uses udelay() instead of fsleep(), where the lat=
ter
may sleep.

In [1] I explicitly asked for not having the

	if sleep_delta !=3D 0 {
	   might_sleep();
	}

conditional.

It hides bugs and callers should be explicit about what they want. Either t=
hey
want something that actually may sleep or they want something that can be u=
sed
from atomic context.

Even better, in Rust we can use Klint to validate correct usage at compile =
time
with this separation.

[1] https://lore.kernel.org/lkml/DBNPR4KQZXY5.279JBMO315A12@kernel.org/

