Return-Path: <netdev+bounces-166753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7CAA3732F
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 10:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DE53A9AB8
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1CD1898E9;
	Sun, 16 Feb 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfXNL/kl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF7290F;
	Sun, 16 Feb 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698376; cv=none; b=DdcNyev/dE7/jfHK7Z7CMAWZzddTK7wPopTA3IGPLxT6EeT6n4PXJT02o9gK+DY5zSqrLUKER1HPxYrGCrGkn+9KTRUt/dt+el6hh0n0aLY2WfkEplWnZyMT/LEFRrEFDKVDCbbR5o6D58d2AqUVuNwdG2Qu/YtKyPjcQDjGTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698376; c=relaxed/simple;
	bh=18R0lE2RnkHnz6VTkOY4xf4nrg7lJdoDGjsS5lLwgKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCdrQwT+zHzAmG49h2jvIPaQe2qvjq6wu3tv2tXsYgRh65mYaEnvlYI9ufSpdp07Lt8HK1mFPKuAR3uQ0srPT8hD1+VWcRI7bIFWZ0/NY+WXPLRZiqFpd4TZENShXBKUwoPYKgsNU1jdHJo/X8xx5OgDl2Dhvc4owB67uU+/Bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfXNL/kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D819DC4CEDD;
	Sun, 16 Feb 2025 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739698375;
	bh=18R0lE2RnkHnz6VTkOY4xf4nrg7lJdoDGjsS5lLwgKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfXNL/kl3So4kEGtv4eviHlRA1V2gVaRw1FtPngYXu8HKekoU4bfOedFhLYp6zce5
	 iNDQovMt9+j5n38kzrSSopOTunWoDR5DLLnAnardnz/fzbQJ6Jj40Vu5sl0vJzZfly
	 iCw/LTrc2cfXA90QcjDPhH78lOkVLR9aKplZ2lT5JB7DODKvpr3KiNZUypN9ScE6r/
	 t9xO4MCvlyTuBbI+kDq+RS5o0iuqyjciZHWdxV3SOxQrR+WjQxAruBB1wspMyAVUX0
	 Qae3vlEUk3HyND6GmCSZ/tEaV71gWbHMqapz41oF2pMUs8SfAa9izDqnDiiqZSesIH
	 avgmBMi/EWsaA==
Date: Sun, 16 Feb 2025 09:32:52 +0000
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH net-next] selftests: net: fix grammar in
 reuseaddr_ports_exhausted.c log message
Message-ID: <20250216093252.GA1615191@kernel.org>
References: <20250213152612.4434-1-pranav.tyagi03@gmail.com>
 <20250215134548.GN1615191@kernel.org>
 <CAH4c4j+9aXmFTym_uU-RtQtNhPBMeWnEE-mZaAceQTmuL3QCTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH4c4j+9aXmFTym_uU-RtQtNhPBMeWnEE-mZaAceQTmuL3QCTg@mail.gmail.com>

On Sat, Feb 15, 2025 at 11:53:33PM +0530, Pranav Tyagi wrote:
> Hi Simon,
> 
> Thank you for reviewing my patch and for the guidance on the submission process.
> 
> I sincerely apologize for the duplicate posting—I’ll make sure to
> follow the correct versioning and reposting guidelines moving forward.
> I’m still new to the community and getting familiar with the workflow,
> so I really appreciate your feedback. I’ll keep these best practices
> in mind for future submissions.

Thanks Pranav,

One more thing: please don't top-post on Kernel mailing lists.

Thanks!

