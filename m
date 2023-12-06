Return-Path: <netdev+bounces-54530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A7E807652
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773E8281F79
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF955F1EB;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J367BBzQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113B48798
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26240C433C8;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701883053;
	bh=VwyudqvssUGouEPe/doZEgpxB104JGX7e++XEKaFxNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J367BBzQtrLJ8cK4vEZWp3pvvfygylMWu3ogYmc6c+FsQj/LxtIzpRpasPHaQpK5S
	 p14WFjBnTINW5mwvRsAYFNy4vcXiD8CjrKyUiYCY1eL1AHNXhMVRoJU8N71xBe3kbE
	 lVL0ZZuMIXGJVR/xaBXhteKtPkf1pSm5iD0StIeN+YouhG5lcxCSWhiRk+n7iF8N/a
	 IUkiR9Yqvnztwdyu9/tEAwHB4bG8l6gjewtGp178M9dKj+CosiEd4Sy26rhTIIe78v
	 rcCZtxnalGT9e/N5Z/8B3Weswmt4j5jzADARyJb7EbuGxlu5aV418WumGPCjufdYqW
	 natlN9XUtB8TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14348C04E27;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2 PATCH] configure: Add _GNU_SOURCE to strlcpy configure test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170188305307.32642.7730865310846878199.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 17:17:33 +0000
References: <20231202024705.1375296-1-sam@gentoo.org>
In-Reply-To: <20231202024705.1375296-1-sam@gentoo.org>
To: Sam James <sam@gentoo.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat,  2 Dec 2023 02:47:04 +0000 you wrote:
> >=glibc-2.38 adds strlcpy but it's guarded under a feature-test macro. Just
> add _GNU_SOURCE to the configure test because we already pass _GNU_SOURCE unconditionally
> in the Makefiles when building iproute2.
> 
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [iproute2] configure: Add _GNU_SOURCE to strlcpy configure test
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0a24c18d30f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



