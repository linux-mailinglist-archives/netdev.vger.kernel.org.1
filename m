Return-Path: <netdev+bounces-184483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FACA95A9D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 03:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6EB171FAA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 01:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B915A856;
	Tue, 22 Apr 2025 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsXvZozT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075E13B293
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286325; cv=none; b=Ve75u19zPzs8PAkp0dnaUsMnSsHGRJfMz79LHF6f5DY8CSX0DyGopS889HvdabGeKrJWMHstHsUjbvtlUoSF53OctMn5EPO07mp8wv/gPHxF9cgN7InzDZUXl88DrEg1qMveozwCTy55oL3Udmt11i88/BSb28Hq0eaqJqVItpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286325; c=relaxed/simple;
	bh=JT8eXDNjLX10cKfo4fom2mmc3fsp9I/Y182OPXoAmC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qamZ/FtSCsjBFFDTnRDneWtg2rvT/Q1aWvDwddzYHoQvCopo3QkRGTWwsahRUmL5RPfaqMi1SrnCyjYgb9DXccF/GQ3ZGjJMx5CiMYQrjkTvZNbOwTb55BZkTJGptWzI4Wcg6QLlG7OQFrMiFCUivfFiSI0AGcs+fHeBRDAf98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsXvZozT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A82EC4CEE4;
	Tue, 22 Apr 2025 01:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745286325;
	bh=JT8eXDNjLX10cKfo4fom2mmc3fsp9I/Y182OPXoAmC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bsXvZozTfDG2vO5RHv/LVGB9MCyn/EWR+XUMIsnfFB0VT2qN45ATsYJpwztj1b0kl
	 VYCtlBOKtq/f7Or1upy0xeWIj6w9p4K9Lz7wWQ0O8qw7bzo6Rvril2Z1TiBA8hDFdf
	 a0SsUu9nbUHYvDgKCSY3fZnCI1ZulCQd25R7LjK5ck8yIjcWWFdX++laIz2vBoMf/S
	 XuZxsJ3dp+PLJQIDrfs58tEPeOhMM6OxooLVouYesdTlsxpM99VpQegx5dtEMw19Ox
	 XCkjTlFwfJgAXhtLWjlxTsK5G32+NhlzVvCJwj+IvMdE6RYeuQNeEQq6sLbfqBaZgf
	 Zrm9H2vrHEshg==
Date: Mon, 21 Apr 2025 18:45:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org
Subject: Re: [PATCH net-next] selftests: net: kmemleak for lwt dst cache
 tests
Message-ID: <20250421184524.215a65fc@kernel.org>
In-Reply-To: <20250417130830.19630-1-justin.iurman@uliege.be>
References: <20250417130830.19630-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 15:08:30 +0200 Justin Iurman wrote:
> Force the use of kmemleak to check everything's OK and report results
> for each test case. Also, useless sleeps were removed, and the bash
> script was renamed to something that makes more sense. Due to kmemleak,
> some tests may be false negatives. To mitigate that (i.e., to have more
> stable results), the solution of a kmemleak scan at the end (vs. for
> each test) was preferred.

I'm open to other opinions but to me this is not a scalable direction.
Checking for splats and memleaks does not belong in any particular
test script, it belongs in whatever executes the test. We could add 
some standard way to get ksft to scan for splats and leaks, maybe in
tools/testing/selftests/kselftest/runner.sh ?

> +++ b/tools/testing/selftests/net/config
> +CONFIG_DEBUG_KMEMLEAK=y

Enabling kmemleak for all netdev runners is too heavy, if others
feel like we should have the test case do the scanning - let's 
detect if kmemleak is available. The expectation is that the user
added kernel/configs/debug.config to their build if they want
debug checks.
-- 
pw-bot: cr

