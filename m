Return-Path: <netdev+bounces-71945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7B85596B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC66B2A1D9
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F051479C5;
	Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1dtmLSj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A90539A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966631; cv=none; b=Coc8iy7m+G+lWIhjap+2B0FIHUUdsZY6akVmyE0gTaBU5UK0H/KXBDkE/HDzFP5t0taV8m4Z6HBYgDii1VTRjhrKCoWwlc5nDB7H16OGNbfJz+aO7uPEi/pqAPoqeJTe2IRCJ3NOhVXCL/ujmywhCf+rwoNhxE2ormeOiEt/yrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966631; c=relaxed/simple;
	bh=i0eSlegKYJp+EKLOa8446B/lnn40X9e8FBeb4PCgLgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+9aDLOlLdhTmVXUXQ8sa4nYYaPu4rx8BPIzJJuwh1GE172vN94xrnRcE9c80U10HYE9Qfc3ZKl9ul2qvSeJrovr9ckdtqsdVbKWoyASRZMFcWf0pTgWEsamHdqw2amhBx5FnnU/f09wwMn3eDBIANmeXomVxT5KYlL9wzJ6Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1dtmLSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 446B1C433C7;
	Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966631;
	bh=i0eSlegKYJp+EKLOa8446B/lnn40X9e8FBeb4PCgLgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J1dtmLSjlDhFP8e24tuYv33d2qr4+HPPRzZWx1jdqbTJbJIhx2e9cQCaBkSiH9WqH
	 FH0NWAfr2F41BTTtbvXtV2L+oMJYK2H0HAVyQAFIkENtVp+tF1Qcf2zl09HfAYPxpj
	 0QeJ+RX995MkD+q63zqHhoaN/6Ejpba1Fianjw7HoG8vPZuSYbXCzmgpydEMbxqVyq
	 FSLeSd0y+ed6Mz6XPHP0A/qryH2xZ/M2E8iDwNZa/TIJ1V8nqTPdGLQoy43/l0rWJL
	 cQBoYrZeC+EBgoCKeoLF7YpdQyHk4Owsm5xno2yFd3gKNs9PpQACSdTbbV4h2605Oi
	 dG45WLE4KJLzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D1A6D84BC1;
	Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] tc: u32: check return value from snprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170796663118.31705.13477919139752974326.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 03:10:31 +0000
References: <20240211010441.8262-1-stephen@networkplumber.org>
In-Reply-To: <20240211010441.8262-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, liuhangbin@gmail.com, jhs@mojatatu.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 10 Feb 2024 17:04:23 -0800 you wrote:
> Add assertion to check for case of snprintf failing (bad format?)
> or buffer getting full.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  tc/f_u32.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [iproute2] tc: u32: check return value from snprintf
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=d06f6a3d1766

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



