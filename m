Return-Path: <netdev+bounces-120285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E3958CA4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B2A1F2415E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1B719047D;
	Tue, 20 Aug 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4oQU/iu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3329101C4;
	Tue, 20 Aug 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173238; cv=none; b=IA/wGUEsBgT7kVDSTh05h2x024gclFDY2VOTG6yD7goj3ZVroImT/pBcDayNE7RlfqnmMkcNU7CvC+RFPnj9QtI/qpggKb80S9RAusfb5rRtBSIEhow5Eu4Fscv7pXDXu/e5saBhHWwMphYKRwpxLlTOkPDAjbJexEu0bseSrj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173238; c=relaxed/simple;
	bh=/2unedT4cvDoi1CZ7XzX+1ac69dYNxdKOs3uyeY0MCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tfWhWu5E5KbGxJiigpj6cNg33haCZY/AeG+Ot7HbFRcSeKQnlzqZLSr0XZiFIkD7MxBXkngwc7ItwZSogMYXxkOfKS8Ferakf+Yumkq+hhU3KSydFjv9Y7j52WkQoi8k+BqZCjY+V767EkG2+KvYqqzR3J6Z3CMCTkM/aaeArio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4oQU/iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EE8C4AF0E;
	Tue, 20 Aug 2024 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724173237;
	bh=/2unedT4cvDoi1CZ7XzX+1ac69dYNxdKOs3uyeY0MCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X4oQU/iuBJpDwHkFDRX2DM3tC3w+64SuLnumNf823d+eYctJ4X5+0zdS9lHknbEaT
	 j9uG71GhzLgeIttnN07A3lKDwC36D6WQ7A84N0Uk4DA+48H1aZU6/5zQm+W311DIPA
	 HTZsb5/Y91oEJhf395pMaYLlAZn9b3MxN1xLvdhoYQGfUOcghbEG1kl9FszQvp2qNy
	 HfJIRwpBbeVOGLvE6M+GkjTzYGK/6u3CjNZcUA7tSOxMOT+4IqDW/MWpZ8WLk0NgR9
	 I+PAeUXh4hUQ4dU2ycuafpXc5vpYHeIrqqRxwymX4oMQt99IUiPSxSnMr1p6yczE9W
	 dOXm7iHqSA95A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343033804CA6;
	Tue, 20 Aug 2024 17:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Bluetooth: L2CAP: Remove unused declarations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172417323701.1194903.10776389655528832403.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 17:00:37 +0000
References: <20240819135211.119827-1-yuehaibing@huawei.com>
In-Reply-To: <20240819135211.119827-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Aug 2024 21:52:11 +0800 you wrote:
> Commit e7b02296fb40 ("Bluetooth: Remove BT_HS") removed the implementations
> but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/bluetooth/l2cap.h | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] Bluetooth: L2CAP: Remove unused declarations
    https://git.kernel.org/bluetooth/bluetooth-next/c/215220f8c90f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



