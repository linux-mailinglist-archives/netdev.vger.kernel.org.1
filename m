Return-Path: <netdev+bounces-44057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867F7D5F5F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F301C20D74
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48530137C;
	Wed, 25 Oct 2023 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC0cDXJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179131369;
	Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F5D8C433C7;
	Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698196223;
	bh=jr94RxQWR4i7cYxL/lD+f8pdGurxi1ydHIq3R2P6ijc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KC0cDXJy1QF1yJ4i8slHHvvWYTwGg6xp0yY2QWfdAgx020uanyxzc+/RRmSwRA0gj
	 QaKBLZosAn+jUPvXpL/uGi1WBnx0qc42gCyZfyt2n5OEePpYrZkatrmac/excAtPDW
	 2xDQ/Il28liuR9oeC+NOtKTQQxpPQHfCyhyqE4WEVMDB+PlJ6nVI7A25+d7h2sIPlQ
	 0z9jEs8m1s0J8KNleYiGF5brztz8/LhrHijQFbEfmFMEqDOOZG0FC6rrELoK+A/5p2
	 /WM1Q+ZFEAYk0rlSYQGwRfnNH/R4c0MKjcEWo3fbpgPuwvXSXi3YIVpm5iBqoCWm1y
	 qcHbcMnuTBiUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7254CC41620;
	Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/ctcm: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169819622346.20949.9173650120441533061.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 01:10:23 +0000
References: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
In-Reply-To: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 19:35:07 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect chid to be NUL-terminated based on its use with format
> strings:
> 
> [...]

Here is the summary with links:
  - s390/ctcm: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/19d1c64b7741

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



