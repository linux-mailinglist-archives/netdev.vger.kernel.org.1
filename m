Return-Path: <netdev+bounces-231413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6D9BF902E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969E2562DC6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C76928B7EA;
	Tue, 21 Oct 2025 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAkHXFAQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70B27467B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084630; cv=none; b=dO1hgEydLYU0kFmTrZueNzuZjAbU7/Bnm47ojm33S3uY5FCF5Wmut8jWV7/0TP+Jp6viu3bdguCdHk+j2OOdgDWth4mj/C61P5KdZXFfZCRLYuErTslWtmfB+LYA5SXSg4NVUUHHQLVQkiipWAKbcDJJQf39YQZLAAj5wb+uncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084630; c=relaxed/simple;
	bh=Qw0HjR6Po8wvT0EuwdVPfACWjoTQY90SlffEYbLPR1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D6VObcn5HPy5uJw54EX2h9FR32K9OAcC/ncpGRNYPbLKgNl4E3VKJEqJGrelTH5A/gSpexEdux3rrOUBfAxUipaIXpuEXwGzF4SyFkS30e14VV3YsfX1BfgCiqVvIyUiLeQB7GC4URyTJvximmP9eCHNftcz68zfW4yqOSu06e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAkHXFAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5795CC4CEF1;
	Tue, 21 Oct 2025 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761084629;
	bh=Qw0HjR6Po8wvT0EuwdVPfACWjoTQY90SlffEYbLPR1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RAkHXFAQCmRN8mwl+FuY1roVjUNLI4n8NqghVF1U5TfJfBBFb3JGjLp67bUXBgcds
	 C6PwdvbrwzPcYQJFuTKslezg0+S4ilbVRxRf7TPm1p4BYk0hiSn3KavmlSp331Q4Eq
	 PncYF0bswNt57bXLNDLhIz1dUm9xzwhOrgZRLq3zD7/9nLI/F5wxz2G5M1vCi0cnF1
	 yYtNA0iP5ll/6d2X/QAVNf2CUTgmfGNjKiVkg9zJtfJrUpyUP4QzAbYdW9E6CisGek
	 QsyV24wg9W9YKrk8pqOZxAvvNEDLDtM84DwevTLkiHBGMyuU1BfIAFvaEbQRY83jbI
	 I2ew8Pvoa7XgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE663A55F99;
	Tue, 21 Oct 2025 22:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] mptcp: add implicit flag to the 'ip mptcp'
 inline help
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176108461082.1250236.9824097975105991969.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 22:10:10 +0000
References: 
 <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
In-Reply-To: 
 <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 21 Oct 2025 21:26:56 +0200 you wrote:
> ip mptcp supports the implicit flag since commit 3a2535a41854 ("mptcp:
> add support for implicit flag"), however this flag is not listed in the
> command inline help.
> 
> Add the implicit flag to the inline help.
> 
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] mptcp: add implicit flag to the 'ip mptcp' inline help
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=14749b22dd8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



