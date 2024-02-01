Return-Path: <netdev+bounces-68102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF101845D6B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8849C28FD52
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAEB7E107;
	Thu,  1 Feb 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfJZ0QH3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A564C79
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805627; cv=none; b=nWT697Z9+ta4oEMQ24EzkQZIKvwe2QsRgqCwL0MBfFGCqfog1jH0JNyTQIdRwa6YKLPWlOK2Ennbjac+uuUIfS4s9GgwXTEOTUKjDf4I92uh+DRdW0KAXkp0oo+F8a8kFJ8vABg12lkNdpNxuL8n05S7BNMDN8nvkGXm5iPAo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805627; c=relaxed/simple;
	bh=tUGHjQXZc4kPtsp3kBrK8stZgKY4d0Sjj2hXbau2+tw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RWxl6EYWgkqr5Hb32n9AEZ/tDY8mCnjpA7I7UuUCORXH60TZf0AzwJka2+LBizDkj5NckDy/4/0UtMhvOiOeAT1kTlQF9yc3Uu0LHqdb+vvlvEoyaR3ZtzeA/PKr3Wa9uJoEGlPnfHQ7HxOW+d3ps4qZuwk8ZHi+sgymqjVi70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfJZ0QH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED7CAC43399;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805627;
	bh=tUGHjQXZc4kPtsp3kBrK8stZgKY4d0Sjj2hXbau2+tw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VfJZ0QH3JSTZZIgOoOIZVp+7MvzJdERSMVdJrd7Nz3wf6BV+idXCMDx4tOcaTmvat
	 fxmPMtckf+EgnLTFPSQgP+8PFLohotnQa8Y73hUITcqIffQ818riTNTFzmzMBDfb+x
	 lqRcmaJib3eQlM6Bs/nkFhdsotdm+9+pU5XwzS5R1XNhZejmtoY2KQX1zi5IBVNhjs
	 frvKdkUdX+klk0Nz3k+cWF4y52HNIuv9tO2vavaZpWzr9Fi04wQMA4jDiQ8OSgFZwz
	 fxk1x53xSh9Yg8N0jUCPDUPEC3/Gx+Hxv1sJYy5QKNuCs+V3fQxgU4dnlaTpml7b4V
	 4VibnUIC34LDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D639DD8C97B;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xen-netback: properly sync TX responses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680562687.32005.2375881723958020276.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 16:40:26 +0000
References: <980c6c3d-e10e-4459-8565-e8fbde122f00@suse.com>
In-Reply-To: <980c6c3d-e10e-4459-8565-e8fbde122f00@suse.com>
To: Jan Beulich <JBeulich@suse.com>
Cc: netdev@vger.kernel.org, wl@xen.org, paul@xen.org,
 xen-devel@lists.xenproject.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 14:03:08 +0100 you wrote:
> Invoking the make_tx_response() / push_tx_responses() pair with no lock
> held would be acceptable only if all such invocations happened from the
> same context (NAPI instance or dealloc thread). Since this isn't the
> case, and since the interface "spec" also doesn't demand that multicast
> operations may only be performed with no in-flight transmits,
> MCAST_{ADD,DEL} processing also needs to acquire the response lock
> around the invocations.
> 
> [...]

Here is the summary with links:
  - [net] xen-netback: properly sync TX responses
    https://git.kernel.org/netdev/net/c/7b55984c96ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



