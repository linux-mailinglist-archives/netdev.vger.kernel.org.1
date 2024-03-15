Return-Path: <netdev+bounces-80007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF687C6F4
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37441F211C6
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90E10E4;
	Fri, 15 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC7E+xXb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8974C6E
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465029; cv=none; b=oDkHd+t6kGtHi6WS2rEZBjcje9Kb8N2ztjuf9D5+2z9WqUmQle2ZnUtQ3G1ycTUj3EGKyHXes6+nAv8hMJj5W+5db3vqGQqu+/BzxPmolqXS5AcwLwCtROJQqTe+WfUkT6R5l70BAo+3etgae0VJYgUDAPaQ6tEM5JawESY1Mes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465029; c=relaxed/simple;
	bh=Zcr+XrS+8EAha/4Z8gqmMALZLIb6KSbQHLwuBBeDjcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XZOvVITtYm9f2FfIX/Q4ccE7gV3kJ9vHXXgUkPsYovsPpOuFJVRlZ6eWGSd+pGCz4vyqZeoZBOBoPChJXL+xFLfhkdrkBM2GMbS7vaJJUy2WmJPk8Y8ihUlePkN4+1iu5qRkRWWVndeQM9XphZpoci2O0xf9bkNA8/eQCPFD4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC7E+xXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 054FDC43390;
	Fri, 15 Mar 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710465029;
	bh=Zcr+XrS+8EAha/4Z8gqmMALZLIb6KSbQHLwuBBeDjcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NC7E+xXbxqdCG+Xtjsq+6xQy+3RdKYtvUuwXKPxoBbzNJcUVLQuv35mn1hOW0MW2X
	 AYB0RdkIlrAIRYloD23482NESsTf9yvvWXCjkK+qp130TEltrVUQpaRHJGsPXepCIC
	 UiEBEqgau77+eyvcL9JC1tfiRImshpNydqstzs3Hixtp3cCbT65va6RLQQ1jlYSDig
	 5svKjb8kCYoinJFJVrV5u7WeVem2fQIIepUT3eUeJ22BdmMMOJqIG8NMUlTZ1cLoP4
	 zU1Qw4r+5pJveCF0p2l/iPy2DmX24uIWGh2VQQzs90PJNzAQ60icRxiLOsmFK2ziRs
	 al579ou07i82Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0606D84BAB;
	Fri, 15 Mar 2024 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: remove {revc,send}msg_copy_msghdr() from exports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171046502891.9608.8100318913100139171.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 01:10:28 +0000
References: <1b6089d3-c1cf-464a-abd3-b0f0b6bb2523@kernel.dk>
In-Reply-To: <1b6089d3-c1cf-464a-abd3-b0f0b6bb2523@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Mar 2024 09:55:45 -0600 you wrote:
> The only user of these was io_uring, and it's not using them anymore.
> Make them static and remove them from the socket header file.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> [...]

Here is the summary with links:
  - net: remove {revc,send}msg_copy_msghdr() from exports
    https://git.kernel.org/netdev/net/c/e54e09c05c00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



