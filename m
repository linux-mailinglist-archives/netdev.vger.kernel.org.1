Return-Path: <netdev+bounces-75185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1063F86881D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 05:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4161C1C213DF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01C4D11D;
	Tue, 27 Feb 2024 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd2bA5mc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558538387
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007031; cv=none; b=OAafI48xmdcMsCildRBWbeLqVBH9y5QkzE0/CEFiWCS+gIR+gij2R25svT7xH8zMFoxndoddEyq/f1LYLAfC25v8cr2kJvjgivZLrx6CQ7F5bezSzfU+k7+nYL4ArAunnkvrQ8+y3q7tFxSnwp1U14eTKCzzHNdM+FcRIIJRaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007031; c=relaxed/simple;
	bh=my/I2HwwTO5Z/t6i0ifWb5Vh9r/xm2EW5cTm3S9oUTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tI5GvFM3niDu4OzYUAzEt70dLtNkmmuCFJ85iJIsocPJBYa8IUr/yVhTwHR8Hd8rUvQ/lL5KqDzH9jQVfKH4kjYquK4AgVw0tCDi/KgbJMKowHtYzPHsEgpUWXp6TAiPhp7o7CRuhHiiXUPlHYaEI7s1GHZ1bXe9bmTKzkx+7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd2bA5mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A127BC433C7;
	Tue, 27 Feb 2024 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709007030;
	bh=my/I2HwwTO5Z/t6i0ifWb5Vh9r/xm2EW5cTm3S9oUTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rd2bA5mcJjZGSALSIhKshvQsTCLFf1CHJePdfp0SbWtXe9+iicm/L3mBlydK9IHV8
	 By11vLMW1DCwLPzQ4n32V0OcbrElrnEb8Fi+LTR1KagbjzyiovIPnBxQNVgKHJ8vjm
	 EXfR5V+bNTfYVZlfPVQ/iBKY9MH0axDLkWGpiziGouob9QKSejMSaNYlH/sARgZpnt
	 h5CXhVd8eEWB3WXed/6dRO6LB2e2bVsxqZNnNMKvCIRsQI00HXEO254WibMPmT/BwZ
	 /9fU8fPWI2KrKFmo6k3qk0G4x5jX53Sx13qvaSn1ZZf9fmziXgpbtIN6SAYpMve2xD
	 cMmspBUQOVKiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87745D88FB2;
	Tue, 27 Feb 2024 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v9 0/3] ss: pretty-printing BPF socket-local storage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170900703054.18126.15853641651778425009.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 04:10:30 +0000
References: <20240221151621.166623-1-qde@naccy.de>
In-Reply-To: <20240221151621.166623-1-qde@naccy.de>
To: Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, martin.lau@kernel.org,
 stephen@networkplumber.org, kernel-team@meta.com, matttbe@kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 21 Feb 2024 16:16:18 +0100 you wrote:
> BPF allows programs to store socket-specific data using
> BPF_MAP_TYPE_SK_STORAGE maps. The data is attached to the socket itself,
> and Martin added INET_DIAG_REQ_SK_BPF_STORAGES, so it can be fetched
> using the INET_DIAG mechanism.
> 
> Currently, ss doesn't request the socket-local data, this patch aims to
> fix this.
> 
> [...]

Here is the summary with links:
  - [iproute2,v9,1/3] ss: add support for BPF socket-local storage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8740ca9dcd3c
  - [iproute2,v9,2/3] ss: pretty-print BPF socket-local storage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e3ecf048579a
  - [iproute2,v9,3/3] ss: update man page to document --bpf-maps and --bpf-map-id=
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=50763d53310c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



