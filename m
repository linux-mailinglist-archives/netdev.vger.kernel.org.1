Return-Path: <netdev+bounces-242128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510EC8C96F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADDB34E057B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC6820E03F;
	Thu, 27 Nov 2025 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH7YLe7z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6D1FC110
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207705; cv=none; b=LUNZqKHBoqjscpZ4wG0+lWzkVZ62/kHNNiA8rrhe4BEMhx8cl/HkBA4lFUOxtmtDY1OfqYHej5/Pi1XhqAFSgfJmqDsgY9/TlPsEhh/L85ylsWsbfYvYj2PNQeCv7lmUYsbJ1JPUzbXvJVmSKcqEBP8qg4Puv3/5+W4St5VwVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207705; c=relaxed/simple;
	bh=WDzhQcoArmUT10u6xhBacX74Qy9LBlIo9mHKCdQgwQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD66B7LWFV+eYxNUXL8MBZHN1OwY8rZgwnD0HxWTOHXf1XcuP5beJRNcl2zjfxvdQiIQWLIhTKa1zr6YBnRXObNAMJcjUXRTpouN9dpYJ3lKGnKB05hAk8uXqY21s+U5JORtE6blREMKpImH8F+LRjMKB0x119SoixdYRq0svK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH7YLe7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E218AC4CEF7;
	Thu, 27 Nov 2025 01:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764207705;
	bh=WDzhQcoArmUT10u6xhBacX74Qy9LBlIo9mHKCdQgwQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kH7YLe7zpPvWQAhyHiRXetKmdDljywADgfAm8b2J6EDdpgyEAyFD35ntq11JMV8sy
	 5dkmfKgdZyk3BoiWpOmhK7Jk/C6GURT4B+EWCz2II2SewJ1J3TTvCPU7zwi4h/eoZ1
	 skM6MFe6luQrvoGr8tvUbewCk0d3siYCzvocgnGMNhjzJLON3nSyrRzGs7IHijbpEA
	 X93HZ/SIlxNfCnHj9U7jbnLlnCCCiP02XwE8AiwvCk+ljUFtKYixrhbPsghf5PrO2L
	 cpqJ9lJ0A9bsEfq5OQ1lFkfyFw5aI0FOegcsrTHowNUZaidl/jPKPyScJbndiw6j68
	 cnxVagy4mrQ+w==
Date: Wed, 26 Nov 2025 17:41:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <20251126174144.7e9bf70b@kernel.org>
In-Reply-To: <aSem5ppfiGP8RgvK@fedora>
References: <20251114082014.750edfad@kernel.org>
	<aRrbvkW1_TnCNH-y@fedora>
	<aRwMJWzy6f1OEUdy@fedora>
	<20251118071302.5643244a@kernel.org>
	<20251126071930.76b42c57@kernel.org>
	<aSemD3xMfbVfps0D@fedora>
	<aSem5ppfiGP8RgvK@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Nov 2025 01:18:30 +0000 Hangbin Liu wrote:
> On Thu, Nov 27, 2025 at 01:15:00AM +0000, Hangbin Liu wrote:
> > > Hi Hangbin!
> > >=20
> > > The 0.25 sec sleep was added locally 1 week ago and 0 flakes since.
> > > Would you mind submitting it officially? =20
> >=20
> > Good to hear this. I will submit it. =20
>=20
> Oh, I pressed the send button too fast. I forgot to ask=E2=80=94should we=
 keep it at
> 0.25s or extend it to 0.5s to avoid flaky tests later?

I'd stick to 0.25sec since it was solid for a week.
I don't think the race window is very large, we could even experiment
with a smaller delay, because debug kernels don't hit the issue. The
debug kernel can't be >0.1sec slower I reckon.

IOW I hope 0.25sec already has pretty solid safety margin?
As I mentioned last week - this is called almost 100 times by the test
so the longer delays will be quite visible in the test runtime.

