Return-Path: <netdev+bounces-17030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC574FDC0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1682A1C20EAA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAFA34;
	Wed, 12 Jul 2023 03:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FDA4A
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C669C433CB;
	Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132621;
	bh=zlSkikX5NiioS0jVtW/FGuDJx6biQlxFFJAyRE8c1q8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hUpTCzTyyEqgP+hMVFbDJjhN9+xuEY0YZXDoNw+jMUBvTpDqMkoDPw9F+hEN/to71
	 a0/bIn5FIR2RlxAQTC4gU5UylWCub7Gxx7Nj0Yjam280J4WDgJMoFUJZcrk0LafAye
	 vK0a4CZKdRxUE0qEG6rC85frbbW0yM/3Zz3pp9Oo68IC1XPoAbD9Aa+Z/+e0Kitcvj
	 BAng+Z15VTScyU1alnUPgvgL7NAh4/6MCqkOcNPPBAkIYO/yiXS6q4HAFViqzRkYmN
	 KhWpDy5tFJOFAbxtnR6Wsm8YxK15rdhZ/wmRUyk9YjSzxj3XG3m49jN5f1RfFofsOo
	 kIDRQoDNqRTZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 500A3E49BBF;
	Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: iwlwifi: remove 'use_tfh' config to fix crash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168913262132.27250.2841776474706788914.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 03:30:21 +0000
References: <20230710145038.84186-2-johannes@sipsolutions.net>
In-Reply-To: <20230710145038.84186-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 johannes.berg@intel.com, xry111@xry111.site, pinkflames.linux@gmail.com,
 jeff.chua.linux@gmail.com, rui.zhang@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 16:50:39 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This is equivalent to 'gen2', and it was always confusing to have
> two identical config entries. The split config patch actually had
> been originally developed after removing 'use_tfh" and didn't add
> the use_tfh in the new configs as they'd later been copied to the
> new files. Thus the easiest way to fix the init crash here now is
> to just remove use_tfh (which is erroneously unset in most of the
> configs now) and use 'gen2' in the code instead.
> 
> [...]

Here is the summary with links:
  - [net] wifi: iwlwifi: remove 'use_tfh' config to fix crash
    https://git.kernel.org/netdev/net/c/12a89f017709

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



