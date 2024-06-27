Return-Path: <netdev+bounces-107407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D791AD94
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E01282D7F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AE519A287;
	Thu, 27 Jun 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggBP2R//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50719A285
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508235; cv=none; b=VPPWg8FpvKVG3SgGRta0LL+tuTibkC56/Bjz30UcGr0zMnYnhktHYoV/5ObyUqEHhl2L3avsNLnaIBkJL+bATstqc++FGiuGypnBLKDHV7MPIp3tXO0PZurXDUq2FRQekVgIoy9zYjMhctrm2g7wkwY8vjh5TBBPyMRDh+7U/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508235; c=relaxed/simple;
	bh=olTvC6iWPa1CzXruU4VB4yTTvXlf7BvqhvuwQaicFO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j8RQbCU5vIAsdHO9DKbvHa6ExhOYlmSFohmzSXzf+Utu155vJ238JXfXMoBWRz0pxZBkQxHbYyY3aauyFfzMao2m9kx8vCPhtk0Gb/x8gEk77nQgjJB5yB8mD4CYWxJM+vLdkVuHNEb22ancWPU7IxjE5yI0C1s3HXWiDfw6iPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggBP2R//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D14F6C4AF07;
	Thu, 27 Jun 2024 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508234;
	bh=olTvC6iWPa1CzXruU4VB4yTTvXlf7BvqhvuwQaicFO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggBP2R//zqg/043nwI47bHnglh1CLjfAvtzq484SKEX4BeD+E5wQYndCbWIjSMhHg
	 w/llAHhpi1cfM+J6FbypS5kzja2WFmuHG79y7UoDZ4utq97eEvxUTYKD5iOHPR+JTJ
	 K6HHGFN9SwnM8OGa3gddb6LF8RWQueXoPFdIB2WHviuSBQm8nisj+PYpAYrrbGirxN
	 9B8hgWCzkTb9IGnFT+eM2eX7DidiUDF9MT+cbSnROrhzx5S9ZrxJy6gwFKS3amrGKH
	 DkZLLDKthw3getfrUK0zARBONcbRryCJljB0qqf0mAcp90ao3sXnV/7j9cExL/BW0v
	 J78W73ggEYleg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B677FC433E9;
	Thu, 27 Jun 2024 17:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] ss: fix format string warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171950823474.11956.5875571711553390155.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:10:34 +0000
References: <20240627170029.7346-1-stephen@networkplumber.org>
In-Reply-To: <20240627170029.7346-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 27 Jun 2024 10:00:18 -0700 you wrote:
> Clang complains that format string is not a string literal
> unless the functions are annotated.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  misc/ss.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [iproute] ss: fix format string warnings
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=357808abd3a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



