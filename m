Return-Path: <netdev+bounces-82094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4B88C4FD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053C5B23C7A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1570312D75A;
	Tue, 26 Mar 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba3LYP9J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC916CDD4;
	Tue, 26 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462807; cv=none; b=VUDTuu67iVsGolsy1xmYilPhoR2cxhG2X1rE0xl6+Dakm1M659kSExCcAXsPts9XLoXE7JEmcEMx51fYf1OKYdDawICVu4ngNS5r3XpoT7y74GnlcxUN4H8nBmTA9gcBw8xbOz6Q3O7WbXKrhqB+8nMC4viSer7kvqKgMAlepQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462807; c=relaxed/simple;
	bh=IlGSwec0CBe8PF7Jab9lLCboRK0XijbGSJ6JR3LMO+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMWsftnSOhDKe47LYL4lS4bv3jZGb6VQRkaDiwoHufT5/+pyKr07IXp3fFfQDW9uzncjMqkWxMUyVY2rexneKnejNofFFOSR4p8S2USmVMwaFgQ34a8xsyXKqG1O6sebtMG6eIQdQi6aH31rLDBWZkrTuLg/lzX9waHJS5/evDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba3LYP9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4620EC433F1;
	Tue, 26 Mar 2024 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711462806;
	bh=IlGSwec0CBe8PF7Jab9lLCboRK0XijbGSJ6JR3LMO+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ba3LYP9J/Nje3jG/XK8T53JXQAOmELkfE1Cdqbu+qOek++pxFpC5pYtXR3tsXgCTQ
	 MGBTOluo4Q7R6hI6R8+tgyQg0fP66Oq1l1LWM8yl67q2MF0BOEXjXBZoXSQvhnwzzn
	 Xxv7XLqXsa9Ht/0l6VvCMlnoPWBLSfcx7aR2eGYpx/7/WN22+/u33+csf1PSgm74bj
	 6c0n9bq2zs6BrEIlvTwBykSYQFa61oWNj9w8u3mDw7l6MSQsP4wowUwe7CAOacP0Ka
	 LQI9b/L1DedflUuvc0T1RDy3se2UM0LTvCo2b2k9VzgC9f/Q8sVaVf95aExGBmvKcL
	 Hjn//dsgPhxqA==
Date: Tue, 26 Mar 2024 07:20:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
 netdev-driver-reviewers@vger.kernel.org
Subject: Re: [TEST] VirtioFS instead of 9p
Message-ID: <20240326072005.1a7fa533@kernel.org>
In-Reply-To: <4c575cc7-22b8-42e0-a973-e06ccb82124b@lunn.ch>
References: <20240325064234.12c436c2@kernel.org>
	<34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
	<20240325184237.0d5a3a7d@kernel.org>
	<60c891b6-03c9-413c-b41a-14949390d106@kernel.org>
	<4c575cc7-22b8-42e0-a973-e06ccb82124b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 13:34:33 +0100 Andrew Lunn wrote:
> > > And the Rust that comes with it doesn't seem to be able to build it :(  
> > Did you try by installing Rust (rustc, cargo) via rustup [1]? It is even
> > possible to get the offline installer if it is easier [2]. With rustup,
> > you can easily install newer versions of the Rust toolchain.  
> 
> I guess part of the problem is that $RUST does not have a stable
> meaning yet. The rust in the kernel seems to need a different
> definition of $RUST to this package. And this machine is all about
> testing the kernel, so $RUST is set for how the kernel wants $RUST
> defined.
> 
> Maybe, eventually, rust will become stable, and you just install a
> rust compiler like you install a C compiler, and it just works for
> everything. But we are not there yet.

Somewhat related, our current build_rust test doesn't work because
I used rustup, and it works by adding stuff (paths mostly?) to bashrc.
Which does not get evaluated when we launch the script from a systemd
unit :( I couldn't find a "please run this as an interactive shell"
switch in bash, should we source ~/.bashrc in build_rust.sh for now?

