Return-Path: <netdev+bounces-181939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF589A87061
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 04:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C7817B2FA
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 02:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C14778E;
	Sun, 13 Apr 2025 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqOuRrw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A509450;
	Sun, 13 Apr 2025 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744510025; cv=none; b=Ukev3pnDVlvvjWFiJJRD/DxSJAhs95zGDp/vHbdocxzsxoYseEKj30vyzFXOtPPSr/NaiIesHBDr27BEIIWUz5j+gPdtKoqGW2sBxFl0qHUVZMEKYxV1jIQVQPmF0HiCPWGh6521fzR+dxFDj5p4wdy04WKsy23hUEUNh96C5XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744510025; c=relaxed/simple;
	bh=kieYeEPnDgFv8WybWlZyqjY3RQw5OmpdhvM2GmhkiBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skfF3z6Euk6soxewfNQ+YNuskKl4PVd42e2oxHSLbEe2gNYybEmXDguw5h+WNQBMmIVKO1Swe8WPF2hmZSW6t/MMcddPSG6JwW0yS7Bq5mHWNUTjUDtdDrxJlw8mnzbe+oXM8j3pk9TznO3jZFfbtRqfMMvVP+iR06w37z3sUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqOuRrw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7E8C4CEE3;
	Sun, 13 Apr 2025 02:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744510024;
	bh=kieYeEPnDgFv8WybWlZyqjY3RQw5OmpdhvM2GmhkiBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqOuRrw/mKIamwTQ9pkyi+znU76dGF6tUDRAClmqVe8LEetxlQjFBDpnx3I86Zm0F
	 f3opB/oiBLhygkfSBQK3tNoDzWE2kq1Dx0/k5sSoZ6sc16dHvTPuuSyHofvLAIDInI
	 P/uWa7D/XsyeeRcwxjlKWZfpMi/E5JHISfr4fHcIGNLUzwMQqQmfs/3U7RUiiAEwLW
	 5cckfsS9dgfZy+Qu38/rk9WlvXZfcQlwy2SSnTKA1gf5kT5owIXdHcbAeZT7VasgUy
	 33/Ml/MkrW7hCs4gPMclSuMWAgry9cBiaA2qEmWgS2l+NifqFr2iuhM6GrEkQCxzU3
	 /E4Dc7Hu6iZIA==
Date: Sat, 12 Apr 2025 21:07:01 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: qasdev00@gmail.com, jlayton@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: use %ld format specifier for PTR_ERR in pr_warn
Message-ID: <20250413020701.GA3020916@ax162>
References: <20250412225528.12667-1-qasdev00@gmail.com>
 <20250412232839.66642-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412232839.66642-1-kuniyu@amazon.com>

On Sat, Apr 12, 2025 at 04:28:38PM -0700, Kuniyuki Iwashima wrote:
> From: Qasim Ijaz <qasdev00@gmail.com>
> Date: Sat, 12 Apr 2025 23:55:28 +0100
> > PTR_ERR yields type long, so use %ld format specifier in pr_warn.
> 
> errno fits in the range of int, so no need to use %ld.

Sure but the compiler does not know that and will warn about the
format specifier and type mismatch:

https://lore.kernel.org/202504130642.HaAQv94V-lkp@intel.com/

I think my comment about switching to '%pe' on basically the same patch
in lib/ref_tracker.c is relevant here too:

https://lore.kernel.org/20250413013245.GA2989337@ax162/

Cheers,
Nathan

