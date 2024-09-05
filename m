Return-Path: <netdev+bounces-125310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6979796CB8F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C69282610
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E821854;
	Thu,  5 Sep 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEqSiiVk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BF184E
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495035; cv=none; b=ZZt/pKijiOWLlvda6GzMb+gkRNf89rlcdS+E1pCpdTJGm8HXGbXHKiWxKViAFUY6jJuBJD9FVoO6dV2WMtLMa1VxwGk5KDyBmkqCGS7VrguLQn4DLuqi9Tr7IlxD3LeILTbrg7eVY7oUdP4OX/+mtYot40RiUQOHQSDbxIfg6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495035; c=relaxed/simple;
	bh=EFHNVCD3ggBHfuD0d0mtRoZLb+imKwXcDXjenJ70c60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fp9MMzPMrDtI7BTiTcEjL1haLirIHpz7n3kzd1ikv8//JlfgKEWfK52sUXwo27dDXrEB2vfVAyek/ysgw3djC3gMVqM0kLx2gKBV8yvBimohjUKCwgTMBeBvDIaFYZdfAPuj9ilWmUrkY0xfsGu0vES52nk7RBt+IIHu2fzi+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEqSiiVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC048C4CEC8;
	Thu,  5 Sep 2024 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725495034;
	bh=EFHNVCD3ggBHfuD0d0mtRoZLb+imKwXcDXjenJ70c60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZEqSiiVkcrOleAlTGi/CrmPJ3nnjCZt0ByDCBvvkFzf7TaSmqqNtTsYrGS12Xunl0
	 dSCtl+8v3zN9gbUWiYQo3m/YLjCsf3t6oXPAbldFknYTBuY/7DfZg4K1lbMzvTymRQ
	 +aKTpIg7x5mA/QR5Y3ZFUSeVcDiZ5VLKUBmhYkZbITMQ3bBw/T5Own2ybnDreo0DfR
	 fzlHVAUkBG7S7xYjK1fZG60TRpQ3cwhSXH7aK5zRA9QXzQT0FN87AbroZlijwVERny
	 XGvZgxCwkuYqot5jWRWdReRzJspWQyBi38/+hlyvIE6j1nB6xc2dSOz0KtIe7YtqMv
	 +RDu1wNBm28tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC73822D30;
	Thu,  5 Sep 2024 00:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] pds_core: Remove redundant null pointer checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549503524.1206552.15620247062035856327.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:10:35 +0000
References: <20240903143343.2004652-1-lizetao1@huawei.com>
In-Reply-To: <20240903143343.2004652-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Sep 2024 22:33:43 +0800 you wrote:
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant, and using IS_ERR is
> safe enough.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/amd/pds_core/debugfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [-next] pds_core: Remove redundant null pointer checks
    https://git.kernel.org/netdev/net-next/c/8ed6e71219a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



