Return-Path: <netdev+bounces-122875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65FD962F4A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55161B21BDE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18141AAE05;
	Wed, 28 Aug 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBGWdC3n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD819487BE
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868170; cv=none; b=OSooPOwP+rOtodYyCO1OZjS6AO9T4+fl3km+qZeKhBkyA5B4RTY8yRjZ+7vVPAAnGqY10ZJalmEil18qZ/wOIX5S2WF1s1b8Yu6xcyAnhfHCDRf9IqHtSPLwQDH2BGPkquwG6OKs7YTh3c3/nHOBeD4oD2EOeL6OWlK3Rw5A8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868170; c=relaxed/simple;
	bh=rE7EDCOX/9+oAiK5dqTEPrpiB4f6qA6f4G1tRCnqLvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd9WlvAI31Fo1HARaIfU31BY0S/FITqtuLEseDu5zfXPVYgV88PGGdJxeoudHZbEEpx1y1Vo5W8ysGG4hVs3QC2/5j4MZaXxSeCLY3fMWMrJVswuMwU3VwVaZlMKLJUncY+NHmdiwjTliziWdcHZgNArY+6FgmovBNWOa7pSckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBGWdC3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB75C4CEC0;
	Wed, 28 Aug 2024 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724868170;
	bh=rE7EDCOX/9+oAiK5dqTEPrpiB4f6qA6f4G1tRCnqLvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBGWdC3n8s7/IadADTGWGmwYswrlaberuKSxCn4FoScVaMwWqmIw3d5ks/UP+xc78
	 dphLeraGWTD1BomIw5XmBQPAQQNveIypjzn0GfkHAUzBjmtJLfOWWej9IBNMEYSoQn
	 /uPrTcS6420RfdHRheqNmSDdXhPXWyoU6KpkE/Duby2l0OCyhVEw6qRjsKVSgvFySq
	 Uwv65kftmyPKc4HrcSPJ9eCLP92BrCiavBL7BGnJPHbhlCEYG4Vqe3qqLeKlaRun6j
	 ahXCPmF4EAY04XwQwEFdyLizBclQrwpbA+1xhc/uOlKYi+WyacGcIJVXot5d/uNgp6
	 BrCb2DidgeKIw==
Date: Wed, 28 Aug 2024 19:02:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@fomichev.me,
	martin.lau@kernel.org, ast@kernel.org, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: error check scanf() in a sample
Message-ID: <20240828180246.GA2671728@kernel.org>
References: <20240828173609.2951335-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828173609.2951335-1-kuba@kernel.org>

On Wed, Aug 28, 2024 at 10:36:09AM -0700, Jakub Kicinski wrote:
> Someone reported on GitHub that the YNL NIPA test is failing
> when run locally. The test builds the tools, and it hits:
> 
>   netdev.c:82:9: warning: ignoring return value of ‘scanf’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   82 | scanf("%d", &ifindex);
> 
> I can't repro this on my setups but error seems clear enough.
> 
> Link: https://github.com/linux-netdev/nipa/discussions/37
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks, I have a similar patch in my local-queue.

I was able to reproduce the problem on Ubuntu 22.04,
although not on Fedora 40 or Debian Trixie.

Reviewed-by: Simon Horman <horms@kernel.org>

