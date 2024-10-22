Return-Path: <netdev+bounces-137842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A59AA0E3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4251F219D1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB492199EB7;
	Tue, 22 Oct 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErfIZNM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8D18BBA9
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595423; cv=none; b=GZ4uVCjnJcdzKTs0Omf+7Go/2BPAUefF9KEtUu0rPOHMPPURkpP7hMyKHNkpVuAHOVVKokwVvZ0ayelkQzoz6JjYZxWSnhDZASLVUddXApRDvQ5AenqxO6Bic4XV2PKRD1H5aY0506E2AXj8WREhK1Fl1AR6PPnPjbckucUq+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595423; c=relaxed/simple;
	bh=MqobmRDOIMRy0FO9+FqzR8fvKWQAAbfxNzkgdSVI63g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XTugonhX/UZbqQ+XOpn5xNGNoGVfqcRzkh9ESRm43CLnLAxT00VrMNi3qQuIVgmV58H/j1XA97Nrl1VJUNj6DEUvRxepCUWCv7bOwrJnReAVz532JyNn5yJyEXXEOulnu8t4scD3pprGcbpvB0Ycr6IWGfr6ABrJHZt3Pgc3VMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErfIZNM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1B3C4CEC3;
	Tue, 22 Oct 2024 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729595423;
	bh=MqobmRDOIMRy0FO9+FqzR8fvKWQAAbfxNzkgdSVI63g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ErfIZNM4+Gn+bfi32eBW+EzipDEFZtgv9r1JgwE5+7fccGBxs6TSNlQQayujjn4q7
	 o73NJcI3Rfnv83Kk4+296BYShDvEvqfQ4daxz/nmY7dGmJlsbacFQvWV6YThciHnDo
	 msAYCBLnYbexB+QO9rYDB8KNR+jA8FdVXqDOrOpCJl8TJvwuyzwb6zSi0qzLdYmmg8
	 3Jbrp5IPHXpOZeIkPLFSfd23SfmGKJc5yo3qp/xrNFVzFJSibFGFfpLHjpIsR92Rir
	 ShndYsBXS4b7mA+yya0JNXMQw4awP2vDz5ELwHKf1/7VsAMlzCwty7ESgqDAN/yT2h
	 qapafN8cU6wSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9F3809A8A;
	Tue, 22 Oct 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mlxsw: spectrum_router: fix xa_store() error checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172959542851.932857.16621343446028765371.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 11:10:28 +0000
References: <20241017023223.74180-1-yuancan@huawei.com>
In-Reply-To: <20241017023223.74180-1-yuancan@huawei.com>
To: Yuan Can <yuancan@huawei.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 10:32:23 +0800 you wrote:
> It is meant to use xa_err() to extract the error encoded in the return
> value of xa_store().
> 
> Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters in resilient groups")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] mlxsw: spectrum_router: fix xa_store() error checking
    https://git.kernel.org/netdev/net/c/f7b4cf0306bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



