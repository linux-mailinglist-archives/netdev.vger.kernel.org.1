Return-Path: <netdev+bounces-159592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F3A15FD5
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3935A3A6D9A
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFDE38FB0;
	Sun, 19 Jan 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVBxP7Pw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C838385;
	Sun, 19 Jan 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251414; cv=none; b=VEj+ovCwVSsjzN+Q8+IcSXALoiG2xwMX2Op68daiZtr3++6SMphH/ykisLxNOzyU2bZkRTtLPF9vUbOg7S5yfBf6JWozM9NX2LN1/lQYKvvJcRMNLcVW/V0aYJsJtM+6as9C2VIZazIq3IGv4PYMsA/uV+Y71L1AgHKcOIVBAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251414; c=relaxed/simple;
	bh=7u81O3O5jFIyV3YrlkEwcLIJx8HPjN2O1ZzsmKp7TLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uAl2apLwhjhDqZ7I/TkHYGYUIPGezK/hD+GP0EcDz16SHN3FshzpxapqT2BdeYPv92PeqYKxBh/TFNiclqcqC60fL5w0ZRU3TSpzmq5jbkJcHIxJfYGUzTpSWHfmMRVcE+oKGnjJMiG/v8L8ZtC30OXdvcfuRwWaFtAMv+orMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVBxP7Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2B6C4CED1;
	Sun, 19 Jan 2025 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251414;
	bh=7u81O3O5jFIyV3YrlkEwcLIJx8HPjN2O1ZzsmKp7TLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QVBxP7PwVufHITp3BAOa5cquw8eOP83iejhmr+PnX588cQg/3Xuso7QBEWQ8EQfUY
	 E/x+TNcX8R800pHVLbbOnwOHX9oMPak8RcGIbTO0OZ1k/ExHmNR/QP+d0eacgbi/21
	 A9jiAHQvT7Gp2J3W0j/R4TO0jRgaF9dQDE8KQb3PIXfxjOtXgmfCjYb/btjL/eJnMZ
	 3ns56owWdBhD4NcDgTibghFdIYZshxVwNzVNMdcPz9qc0iPABwQREwbq25nGCRzVvo
	 Q2Kosux+8pUUPrdkV4sBW613Q8pLe9qPO0hCpP1VDL1gECtzFv9ixTx9ppzqwUQFSI
	 /9pig5wA6Rw9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1E380AA62;
	Sun, 19 Jan 2025 01:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] nfc: st21nfca: Remove unused of_gpio.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725143774.2533015.11644807606501314270.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:37 +0000
References: <20250116152742.147739-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250116152742.147739-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 17:27:28 +0200 you wrote:
> of_gpio.h is deprecated and subject to remove. The drivers in question
> don't use it, simply remove the unused header.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added tag (Krzysztof)
>  drivers/nfc/st21nfca/i2c.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next,v2,1/1] nfc: st21nfca: Remove unused of_gpio.h
    https://git.kernel.org/netdev/net-next/c/33b5c84ae4fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



