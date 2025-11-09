Return-Path: <netdev+bounces-237066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29791C44479
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B0514E1CE5
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185C20B80D;
	Sun,  9 Nov 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnRD+iNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6691E5B63
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709439; cv=none; b=rAR+XRjs5FdEaEws9HrG7Dol0ttWqdqTGU5JAQUSvg2LQ659Ii76Jetx/53rXdKkmz/I9R5BBjQ0LD2Y86+hNh1dO1Zy/LFLg0Y8t4oLnRHxf8rtBqDmDLaHg5VLYrgZ4ZfFnpKNjN4OasF109Nw9sPxrVWqg90HdrDgoM7+9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709439; c=relaxed/simple;
	bh=xsP0+zex9Y+ti5s+OUyOJm65z2fbSOKiEqVl6975At0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K0Rj0bhKHJT2kbxoD1wardgqxE5Ifx3F96hjdgGkUmiXBx3Lr63kE50l9oHmgslWREcZy1/vM/O/3J2CuYbMGqZVa2xDNyPgtPZojpGQNGRG2m7EYrVU4SOvK94r1+0l2wncLjblCdkZ40y407ufCuPB4o3ZDjSRT4Hvg/J4n+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnRD+iNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA58C4CEF7;
	Sun,  9 Nov 2025 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762709439;
	bh=xsP0+zex9Y+ti5s+OUyOJm65z2fbSOKiEqVl6975At0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WnRD+iNNhFL1ogS8uulnmRR0muU+hYSS4OWureet397fQ2syqq/Fh0YSDb5cU/RBi
	 fsASaHjXb9SUPIMP+lX09egRUnlN/egCdhe4n86Okf5mR26HNaggO8QQ0OvbzljEJi
	 ALhww5gspBDc2ve5HyprkOUk7WXhANAf60AwoYuFvU1ALkKYGjs3RLtl3/e8QHnNEq
	 /ilcnRwYM8tC0b1Ho+n4Oh3mnJV7bdaIXwJtH0kllMvTLGisNrweioS42bIaNdLFCf
	 Cl7V4YZhOHx9jBr4dBD0bv3aTMRgl5IH73EURaFSt5Inl6eHsJjn5Swfa5T7vlDtrS
	 XG8k8D1l0dn4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD203A40FE9;
	Sun,  9 Nov 2025 17:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] netshaper: remove unused variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176270941049.1603013.14751582174078964428.git-patchwork-notify@kernel.org>
Date: Sun, 09 Nov 2025 17:30:10 +0000
References: <20251108173540.21503-1-stephen@networkplumber.org>
In-Reply-To: <20251108173540.21503-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, ernis@linux.microsoft.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat,  8 Nov 2025 09:35:26 -0800 you wrote:
> Clang complains that the variable 'n' used for nlmsghdr is passed
> uninitiailized. Remove it because it is never used.
> 
> Fixes: 6f7779ad4ef6 ("netshaper: Add netshaper command")
> Cc: ernis@linux.microsoft.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] netshaper: remove unused variable
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9282ff21af89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



