Return-Path: <netdev+bounces-89593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FE8AACF9
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D22282267
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D27EEE2;
	Fri, 19 Apr 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk1mOe31"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA067E78F
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523231; cv=none; b=LCa9tWNEeprppWVdahZfqNOhnqWiew2wuxpQwINqSFRQyd6+Y/iVJpfqQTQWJ59nnTZMYSUbeCeL0fYH0ZnDEsopjXApnxuhyRF8J9B9RKbVR0GLUWfdMrHtI+HijJGDUzy8ph0RuzQPCgU62OZrTqwPeRbbvpY84GGEjoARvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523231; c=relaxed/simple;
	bh=H61lEl+Oq1pNgmYVM5eDb/AcyW+Aic0TBauEVaeOGhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X8EQqM6tBzXGfaWjmgrQVylrTV9KW0yC1CzqrUTtwJOFGQ7gHlZVnehSqsa2ECgNJOCtNXptvfuD9j1zeWp9nCJ33ljGwraiP2kvcgJ6GnMwjOPKtjuZjvr8F++qWjifxkQuEFQZQZu/jKdKWofz8KngFGeu7NYzfTvzfdHxx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk1mOe31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91885C32781;
	Fri, 19 Apr 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713523230;
	bh=H61lEl+Oq1pNgmYVM5eDb/AcyW+Aic0TBauEVaeOGhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dk1mOe316cCSvYT38OGHDSxb/EvQtdFeBsyh19uJWld/Aj3RhiWhbVfIjMpyS/O4o
	 GRhBf95WJtksOX7E7CTL1E1VR5OzGJ2CUo383vxolxQgqDk/Xs2K4g22aPoyuzTMpw
	 d4NCCp+q+6Vy9o1XsZlFoS6oedxqfVlBLcWSimAECp6oT9e0rQg5AYiy/lfGGUavZF
	 nPPnt/2tG740HSIIEbmgxo3eOcjKx1cyV5KejJnA+qTttSLeb0yDERKRO7Q8QL4pJp
	 SNziCePkZdNitrriDUAroT1pfKPlcKMjUr9dq91tO5xKjSXWiyDzYrSUilEEVJFl20
	 /mVl/jZgJXElQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 827FAC433E9;
	Fri, 19 Apr 2024 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] locklessly protect left members in struct
 rps_dev_flow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171352323053.9279.11233858843436039368.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 10:40:30 +0000
References: <20240418073603.99336-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240418073603.99336-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, horms@kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 15:36:00 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric did a more complicated locklessly change to last_qtail
> member[1] in struct rps_dev_flow, the left members are easier to change
> as the same.
> 
> One thing important I would like to share by qooting Eric:
> "rflow is located in rxqueue->rps_flow_table, it is thus private to current
> thread. Only one cpu can service an RX queue at a time."
> So we only pay attention to the reader in the rps_may_expire_flow() and
> writer in the set_rps_cpu(). They are in the two different contexts.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: rps: protect last_qtail with rps_input_queue_tail_save() helper
    https://git.kernel.org/netdev/net-next/c/84b6823cd96b
  - [net-next,v3,2/3] net: rps: protect filter locklessly
    https://git.kernel.org/netdev/net-next/c/f00bf5dc8320
  - [net-next,v3,3/3] net: rps: locklessly access rflow->cpu
    https://git.kernel.org/netdev/net-next/c/f7b60cce8470

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



