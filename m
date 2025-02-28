Return-Path: <netdev+bounces-170531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFDA48E7C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38CF16F46B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A0155C97;
	Fri, 28 Feb 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do++Di2Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A11155393
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709205; cv=none; b=bXwieLD7VrAWb+UBFCSfitsIGwZbynDS8CHhRMjkQcfqaZoDA6zRoLKiV42h65RzYgHVnVI/tgx8oUxYfZnmkApu0sXhlRc1zog2MPfpnGu2uTPiWg1fIP/ot68sWCyYAnpjtMCopWEMvBs2BitWMzDmfhcP6UkwqlkU9kqTFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709205; c=relaxed/simple;
	bh=EPGfTXYIGkQEzIp4U8nbJTImEKprDJKbGUpZKG9+E88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uPS9oriZuZ2mdQSkNzRVoKBnwY0nuPpguNsr5HVkpgTB1+amdXpO/cIP2cka65lvysUMlQQSNnxMrkXrxNu279NwcwUmTRsqEPVO1pzJeyt1kuCTjAhAzLpi7gwy7Xmf2IPiMBOaCn5NMfEVze4xl5ZeT9HSzefpUUOg1G9V+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do++Di2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00E1C4CEDD;
	Fri, 28 Feb 2025 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709204;
	bh=EPGfTXYIGkQEzIp4U8nbJTImEKprDJKbGUpZKG9+E88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Do++Di2YkxQBfoFZXNcXoG25bP/AgECvvyKC9gOb8nYDPFLP7FDYqgFeclCsYewd0
	 eo0ePQJxywN17qoVvd9RzLt0M1MSKjAwUMTOVOSjSTyWpzpaI+Bsd9u08VBOo2EMTc
	 GOlMYnvFTBDNRNQdqHDJsfOA3BswCEVBkNB/0bxlNzqeYawrhbCpm8nRJtrFHieHPF
	 XtLNQE4/cpNoUHE4Ss6/vfY1Lc0AplUBmj9+n6qnevu0u/E28tg16wqOKLavva8ZgL
	 SNaUQL6PdBM+pGiHLAekIqHapglQCB9vgTgGuKPV7wDc8q7mDodhRIjOnUsJ/tqyEY
	 PVR2vis/6SgSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB319380AACB;
	Fri, 28 Feb 2025 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net-sysfs: remove unused initial ret values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174070923674.1657442.12396185190742818721.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 02:20:36 +0000
References: <20250226174644.311136-1-atenart@kernel.org>
In-Reply-To: <20250226174644.311136-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 18:46:43 +0100 you wrote:
> In some net-sysfs functions the ret value is initialized but never used
> as it is always overridden. Remove those.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/core/net-sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net-sysfs: remove unused initial ret values
    https://git.kernel.org/netdev/net-next/c/38d41cf575f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



