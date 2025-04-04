Return-Path: <netdev+bounces-179260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A91A7BA02
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA5F7A5D16
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138AA1A9B28;
	Fri,  4 Apr 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq1cnFY2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035B1A38E3;
	Fri,  4 Apr 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759180; cv=none; b=rON21FEvjJErQKI4ol6kxExdJ1HOWy4oNEYMBTdW4k7gZMvMoKfNHvTiYEnWuvTHiR6Cp0/O1XQ/pfsLda8LwC9MgrfT719dpnHpjZL8r0Fv24yAAf6qp2/UEoTP3n9d3y6sUXBqlJafo6fhwy1//tRw17IZ4AWPZ6/uAAXGAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759180; c=relaxed/simple;
	bh=x/htCtnL4bJbQP2vXMg/bxEFFPbS11UpyoiMOMuZhvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRl2M9BVxfbT77z3e6AJLdFciRLMtL6rEN0xITRVTuC489BHnc6MEPmUrCPfInwudvcuJxgaTqmyv+JPPX1ApRMrgsbwwnDUetlBlYogxgpdyX3JW+HJsECR9735gC9MrWIicTTMCraJvJQ/3i4ZNbVV5ObF145ohWAWbdi2krk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq1cnFY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6BDC4CEDD;
	Fri,  4 Apr 2025 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743759179;
	bh=x/htCtnL4bJbQP2vXMg/bxEFFPbS11UpyoiMOMuZhvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nq1cnFY2+4/Yt4lih9yaYqSrPLqIoT1sqSPa/3a54HfC32ZzPeiCvxzJDZ3o3GQ2c
	 GVq6c5d/AIuGVHJqgXhJHgP3Lw2Zz2irdSPow+o0xa0oR0uEFTflEH/dho8HadSQuR
	 a1jk056yjABFzETI3RLW0Q1OJRaD6QGlDuFb8uhFd5XnVcgt+k/wY7q6y4TEJjRfaJ
	 ZgGKXZtrK6v8/SLdO5Xbo/jKoP69FCEUEfYQz7NOOX4ifwpIgMMhxsCXPx6AOMQjRP
	 MyDVWksd4rHqFXhOeZwSuWioXXbo8utI3YOES21FaFi21yDM/dff5LNL6uAvrHWXX7
	 R6EDtGdg+micA==
Date: Fri, 4 Apr 2025 10:32:54 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, paulmck@kernel.org,
	joel@joelfernandes.org, steven.price@arm.com,
	akpm@linux-foundation.org, matttbe@kernel.org,
	anshuman.khandual@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] configs/debug: run and debug PREEMPT
Message-ID: <20250404093254.GC214849@horms.kernel.org>
References: <20250402172305.1775226-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402172305.1775226-1-sdf@fomichev.me>

On Wed, Apr 02, 2025 at 10:23:05AM -0700, Stanislav Fomichev wrote:
> Recent change [0] resulted in a "BUG: using __this_cpu_read() in
> preemptible" splat [1]. PREEMPT kernels have additional requirements
> on what can and can not run with/without preemption enabled.
> Expose those constrains in the debug kernels.
> 
> 0: https://lore.kernel.org/netdev/20250314120048.12569-2-justin.iurman@uliege.be/
> 1: https://lore.kernel.org/netdev/20250402094458.006ba2a7@kernel.org/T/#mbf72641e9d7d274daee9003ef5edf6833201f1bc
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Simon Horman <horms@kernel.org>

