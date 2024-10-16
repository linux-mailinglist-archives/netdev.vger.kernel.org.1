Return-Path: <netdev+bounces-136193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEBE9A0F0B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CF91F23CFE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29120F5BD;
	Wed, 16 Oct 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua6fQ0XN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE220F5A3;
	Wed, 16 Oct 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093828; cv=none; b=rXwjtNQgHV+Uv7kepSfx8l4Dm0FLUhDYm7SbmI/EDYvK/QfZcE5icp7KY8Jxj9skknMYOIHBy9rbdqOMoenrJMWHBuHADqMECUcjYxM1TFS/A9LNB0BUoNacPnlY9dNtqAzUhJNogerG3Z3TNsFJas1Xtm0Nq6Hkyhfi0/Ijvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093828; c=relaxed/simple;
	bh=yrQkUOhCimydslTMP1sM5M5FprUZtXRx80+SQ5c++Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+3dJp2fkc5nHmHkJwxLdxHD7X0WFDLv5S08zJOFh7DtXiyW/xETatbKZNaqljIph2EP9NMPfU42bS5byFloBk7zYs1A3LEG3mPyJNK8si3HgFOVIijXLjWiOkl+1iSGe6nfQeIzq44z9ItHRa6dJiSnq05YPOOCGLiFKctxgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua6fQ0XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C893BC4CEC5;
	Wed, 16 Oct 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729093826;
	bh=yrQkUOhCimydslTMP1sM5M5FprUZtXRx80+SQ5c++Es=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ua6fQ0XNsg4aX9Kj9H9WW4v/givnHKjDdY+MECAztUFCxVyk9yGYKCQCCQ803Jbnd
	 OnxdKGeIVeyB19jD0gwMS712SS+3OQnLAhP1tYSainnELzSAR5TAnon2Svco8UhcW5
	 73r5GgUpJXwyFYFwp8tC/tVZ9C+qCzW8vi75Jl+kXtq3eJTLzMDmQXcmx0nwY/UTkG
	 VHY6ROPiwrO0eU6OcTyB8XZpiIvSn1sjo882mzDm+cX1b0/Zk5v6W97QMgdNdCd4BI
	 FbuAscV4Ie+q1POEA0xajso24wcodQT13YWYpYhCNB7fPN0ZTRmWfHJiJ62F6+ti1y
	 VhcS7gIpRwZLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6B0CBCE0DCA; Wed, 16 Oct 2024 08:50:26 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:50:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, matttbe@kernel.org
Subject: Re: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes
 effect
Message-ID: <451bea22-0ffb-4eb0-bbf4-12d7b7742026@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241016011144.3058445-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016011144.3058445-1-kuba@kernel.org>

On Tue, Oct 15, 2024 at 06:11:44PM -0700, Jakub Kicinski wrote:
> Commit 0aaa8977acbf ("configs: introduce debug.config for CI-like setup")
> added CONFIG_PROVE_RCU_LIST=y to the common CI config,
> but RCU_EXPERT is not set, and it's a dependency for
> CONFIG_PROVE_RCU_LIST=y. Make sure CIs take advantage
> of CONFIG_PROVE_RCU_LIST=y, recent fixes in networking
> indicate that it does catch bugs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> I'd be slightly tempted to still send it to Linux for v6.12.
> 
> CC: paulmck@kernel.org
> CC: frederic@kernel.org
> CC: neeraj.upadhyay@kernel.org
> CC: joel@joelfernandes.org
> CC: rcu@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: kees@kernel.org
> CC: matttbe@kernel.org
> ---
>  kernel/configs/debug.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 509ee703de15..20552f163930 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -103,6 +103,7 @@ CONFIG_BUG_ON_DATA_CORRUPTION=y
>  #
>  # RCU Debugging
>  #
> +CONFIG_RCU_EXPERT=y
>  CONFIG_PROVE_RCU=y
>  CONFIG_PROVE_RCU_LIST=y
>  #
> -- 
> 2.46.2
> 

