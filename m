Return-Path: <netdev+bounces-130435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DF498A82E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF15A1C229FC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06A1925B9;
	Mon, 30 Sep 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chYa9MYQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D91925AE;
	Mon, 30 Sep 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709000; cv=none; b=qLH70+r6DEiYzvqCIx+SzVf3SzGJmHmgaS9Z4PpBN9n2W92+6XOlwo58kPYR/KYIq7HSVI4zHxUzTP0Pe6qYP8iGSbRb+Qsvi5m25AHvYYlLLj1SUKOpUqYZkg3b/oQHlfAW/KFe6xFH7PipQfGv4FP62lJIAYe9oVy4eGGdCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709000; c=relaxed/simple;
	bh=8z//JTvwgq6E9BMHMYhRVFIsSMeu7/lfmxgPIMTINR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjd269hf3FNU+21N+fSaGCBsDsCVL6HlefI2JOsfyVK0uOWya3dh25/VSItiHgBR7ezSSC2rn09KdLMvyOJgd0lc6pgH3B763KnZxnrn84njmr0P8DQvCnn5iJTv85h76663R69BVgF1YENhmKY8kkakmFBHEIcVnrWbsKYz/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chYa9MYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70981C4CECE;
	Mon, 30 Sep 2024 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727709000;
	bh=8z//JTvwgq6E9BMHMYhRVFIsSMeu7/lfmxgPIMTINR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chYa9MYQ8x0EuzeP+5xOF3fp4Gq0OeLJfodzFgXAdUIhzWMdwYJ+vreWzTpBJilUl
	 /omqO7ViavYhZWRU8NWkEdrGa3+EghznFbaVoCVERIOS4nZ4qAt3SaEQ7g+GQFv7Ei
	 ha09xK5bS6Z43dEZD9L5++dD6WMKMqo//6X5ysxK4xSI9zF2bqrhfRq84k9GWJCSbO
	 dP2yXeD2FYpcEJ/hr52DrYiP6FXOO+2LQCMz+bxk4/ofPG+G6aJUFP04TSSWz5Yzwq
	 1zI82p9zjDM+2vREvloQb0/dZ77bxH4KNLC+vihSsJ0E0rgKPPlCaqe9cSYH4tVot7
	 3ATgbjHnam9Sw==
Date: Mon, 30 Sep 2024 16:09:56 +0100
From: Simon Horman <horms@kernel.org>
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] Documentation: networking/tcp_ao: typo and grammar fixes
Message-ID: <20240930150956.GB1310185@kernel.org>
References: <20240929005001.370991-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929005001.370991-1-leocstone@gmail.com>

On Sat, Sep 28, 2024 at 05:49:34PM -0700, Leo Stone wrote:
> Fix multiple grammatical issues and add a missing period to improve
> readability.
> 
> Signed-off-by: Leo Stone <leocstone@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

