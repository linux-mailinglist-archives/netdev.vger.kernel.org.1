Return-Path: <netdev+bounces-176528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3866A6AAC9
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0581189054F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54583157A72;
	Thu, 20 Mar 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8EHpwqh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87A3597C;
	Thu, 20 Mar 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486998; cv=none; b=pwLGzMGiDjn0gQdrEEceLL75U5FGlIthBhvZRzxLNnk0DH6AiTF8FAgV+qZvZ5vL2Z9rTDjpa+SBZiug1JalGCnUt2ykvhk8/sb+m+kvelAuyjTDoSJ8fwo9SYMQgrgnetrfVtP9oEiDfHyhEux5KoaX0LiXbe2GDs/wcG7bO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486998; c=relaxed/simple;
	bh=hkuQQMjcS0eGfXLcE1H40vyvYEW5PoN7xdBcUNR6Ct0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PXRyL3cbSJ6p6IiafzKEx7qIWffSFTYPqnquQqcIbeA0kvYcSbaaiJORSi6EspV0hfhGpZdMdAy983VIuddeIddmFDg8jOdl95Ck9h3aM+PBWvizwKexfL2ba3qYYK4ayVq8jgZq54SOO2f9DvkJCQLGOPfPIbwbOOGjr+5laLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8EHpwqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54D5C4CEDD;
	Thu, 20 Mar 2025 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486997;
	bh=hkuQQMjcS0eGfXLcE1H40vyvYEW5PoN7xdBcUNR6Ct0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u8EHpwqhWBmUIIbgCT9WcKrv2NE6hahLKPZWTgXOcho5sv6GAndRRUI5FKG66HRLs
	 /woMHXvrPwQLve7hsCtcqasWjEBpDy1oL4Xh2+igj3cI783QudgsvXEjbp6rerMC2H
	 HCbLlwmdaO6eU1cQURs8azq0ATPOg0PB+9rck38uXSzzSsSZpDCArU9Ql+BwHB/F1q
	 BeV+DyT8clV4GgTRb64Q/yDCZDHA3yF9xEs22MeqSFbTD0T/XIn3RI2lQO9pcJwqMe
	 ji4QyJP+cn5HxPYR/4GIBd2ddMqd5uCg2M1KGHapdlrLh+6x6/Mn/6LTZDSkO43RcA
	 3fkcAR41G5hPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEEB93806654;
	Thu, 20 Mar 2025 16:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174248703351.1823712.1290419889556181560.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 16:10:33 +0000
References: <cover.1742324341.git.pav@iki.fi>
In-Reply-To: <cover.1742324341.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 willemdebruijn.kernel@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Mar 2025 21:06:41 +0200 you wrote:
> Add support for TX timestamping in Bluetooth ISO/L2CAP/SCO sockets.
> 
> Add new COMPLETION timestamp type, to report a software timestamp when
> the hardware reports a packet completed. (Cc netdev for this)
> 
> Previous discussions:
> https://lore.kernel.org/linux-bluetooth/cover.1739988644.git.pav@iki.fi/
> https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@iki.fi/
> https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch/
> https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/
> 
> [...]

Here is the summary with links:
  - [v5,1/5] net-timestamp: COMPLETION timestamp on packet tx completion
    https://git.kernel.org/bluetooth/bluetooth-next/c/de4f56cf6cfd
  - [v5,2/5] Bluetooth: add support for skb TX SND/COMPLETION timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a1b83b8a4b2
  - [v5,3/5] Bluetooth: ISO: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/6a536085b5e1
  - [v5,4/5] Bluetooth: L2CAP: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/f698693b9664
  - [v5,5/5] Bluetooth: SCO: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/01172ed6ff82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



