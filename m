Return-Path: <netdev+bounces-176774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8915A6C184
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB2D3B9A36
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C622DFFC;
	Fri, 21 Mar 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCNkvqBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954A22DFB1
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578201; cv=none; b=S+v1j+LINGabjLYp7Gbv7njGZwNRaswJtJwd1zXLn7jus//xnkOPH+9F858Reu3K15mKOVP2Zu1Qt/Sbt4ieCVf6It5a8IZA5mVSeGEIAdAn4beoEr299L8hX23HFPplCHhv0KgRVRYneWNwZvgSBPiKVCf9fVjW0jlm0kQKELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578201; c=relaxed/simple;
	bh=bkOubFHNoausmZjDN/lq8Jr95seH0OnbWtOgwaesgds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zh1uI5lvA+a9gaMLDauLtoIAkOWVc9sKZ/04o+KiGPDGxGJG3aDB7AXvzXvi7WJEeylYDcB7eNfqmHUKf9VLOmhyRhukNfRdUAImGhBeXMk5IjDFGqOesgTKvHH1AslKIDoi17FOWOe7dMxVq81kCpSS+DXGgGpb05g+hO2cUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCNkvqBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646A8C4CEE3;
	Fri, 21 Mar 2025 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578201;
	bh=bkOubFHNoausmZjDN/lq8Jr95seH0OnbWtOgwaesgds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nCNkvqBfTWsiNrws9UyY3PBR/ToV+FY25/995ho7sir+3/G83eejdItPyqrQOW7HY
	 3I6OnCEEpYD6yDw9QL5+CltFp3yF8LRuG9ovuwgN7M++cOm+pxrErW/jvAsRBOehSx
	 kvKdFVLNCU6y8N8HIBGdJFToCRE6VV64OETX+8lYptcM8mxX7BZ/0ITCxoep56MpLY
	 J9RNwb3hEsiF3B1DmG6WuRLPcY47Pi/yE7YMVL2gJg0x5BDsmoK9agNOT1I3M33eja
	 mqlAEKh1SuXaFVfO7XZvPawQoNzWFk8DYhh89H/99FqDQdbEp7n7PjtqoD2tDkiYe3
	 IJYnGJ8DD1JZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF733806659;
	Fri, 21 Mar 2025 17:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mctp: Remove unnecessary cast in mctp_cb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174257823717.2564531.8303347098423417499.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 17:30:37 +0000
References: <Z9PwOQeBSYlgZlHq@gondor.apana.org.au>
In-Reply-To: <Z9PwOQeBSYlgZlHq@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 17:00:41 +0800 you wrote:
> The void * cast in mctp_cb is unnecessary as it's already been done
> at the start of the function.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Here is the summary with links:
  - net: mctp: Remove unnecessary cast in mctp_cb
    https://git.kernel.org/netdev/net-next/c/a6984aa806c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



