Return-Path: <netdev+bounces-84950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C94898C5A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0FC1F226A4
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E321C69A;
	Thu,  4 Apr 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6bxMoaT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90351BDCD
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248831; cv=none; b=Yp2pbezufVSvUMjU2IDVrydVh/cGEhltnGdX+Yv6JHHKz9CC7PiytND6j27SRbiTpqJVVj/gerDv0hMeAcQQyKAecLYUUaWSn6g31DsNNXHzHeaiRtktlliSJGkXNGeZG22nDL9KtW2U5EoIC4OWyPSUTWAI6z1iOebs3/zAJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248831; c=relaxed/simple;
	bh=ptwQbjtuHu0c8f1wYxR251+aq74zE7RdV+6wGyOPqLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZe5FsyhhgxfFx9An9L6Hdj5d10UxsWS7HhATlRSmYVw0kgm7/MidV/MlOw/2BRaH0g5DlfiDCcnip89da7ql7FsnaX3vTQJ6kQOIHHkyNeh8OlcEvy8MxQbT70P9zfkPQd3tL26qKfmWRArbGBAoS1qUpTe4BK9WNP1jzsq/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6bxMoaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B96FC433F1;
	Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248830;
	bh=ptwQbjtuHu0c8f1wYxR251+aq74zE7RdV+6wGyOPqLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o6bxMoaTPFvoy9WCMs0cY8I0gTKIhQE0MyKK4gIZizDg9yD5+dQshuYxrcSyBHm9/
	 gZgHQ2enJrn+0fVz6Pje46SC1/Ma+6FB17LVCxIsbQcwELD6p9Z2uyZvMhZ4MFayn9
	 1MO8OLfiCBwt9dWzrQoMsOkvy/uzOTdz9OgWl6k0V0vsDMiQ1uxMrvtR+AVIat37Zo
	 cOg9ezaZAovVjmcRbmy/trAHkdIdaUKmcCfaHKgNmio49Xyw15TSnUGcTmrprpmDtu
	 QzqP3wJlhMNXzD0hK4FFOgKQRf+F8GpsIIhw2eQ+6TpWwHRT4XCQ2amr5e/IDRi7sv
	 9Uvdm3QyL6kRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ABD7D84BAC;
	Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2024-04-03 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171224883056.6883.7867699699844132113.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 16:40:30 +0000
References: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  3 Apr 2024 13:19:25 -0700 you wrote:
> This series contains updates to ice and idpf drivers.
> 
> Dan Carpenter initializes some pointer declarations to NULL as needed for
> resource cleanup on ice driver.
> 
> Petr Oros corrects assignment of VLAN operators to fix Rx VLAN filtering
> in legacy mode for ice.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: Fix freeing uninitialized pointers
    https://git.kernel.org/netdev/net/c/90ca6956d383
  - [net,2/3] ice: fix enabling RX VLAN filtering
    https://git.kernel.org/netdev/net/c/8edfc7a40e33
  - [net,3/3] idpf: fix kernel panic on unknown packet types
    https://git.kernel.org/netdev/net/c/dd19e827d63a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



