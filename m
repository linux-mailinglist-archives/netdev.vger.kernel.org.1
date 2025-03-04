Return-Path: <netdev+bounces-171611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86884A4DCF8
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292D83B1884
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76E201018;
	Tue,  4 Mar 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnipqefL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5913D561
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088997; cv=none; b=gAeqqbQgHDeQaz11iMXHK1qWUHHdzuxmJe9CWwRitnvi2uqhDl7mXFjBN8BcRJ2YZolcPwKSbibkVy6uxJvOD6ctSRGyVw1VNL5V4uCSAVErbUJx/IJobXMW0q2gF/+30pOSULkL7aKMgbIdxKhrPsTP98+YwVFo3nLTQ3IsI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088997; c=relaxed/simple;
	bh=FEy8wb0Vfp2rft+m+EKevy1bDol8G0fpS42NKf4iXx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FeokgxZMZoBmyY1FnfrowCmcjme+UBzBXcJ00ciqdgUrKBg6pzzO5MRMww/gSFI4JwjAlC/Nw7/yYM3bClV0P3NH5UeIVF9mP+mcIrVK45cA+xVTzUbFf5Wpjq2qi7TK3AZHtRLyypfTPllC2nguuh7/s4roX13amaCv9Awi/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnipqefL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00F0C4CEE5;
	Tue,  4 Mar 2025 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088996;
	bh=FEy8wb0Vfp2rft+m+EKevy1bDol8G0fpS42NKf4iXx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bnipqefLWEfuG3fe5vzqev8V1BvnpArMo9SM2pSvCR1G8d8ueXMQMKz8eEttKpQch
	 oYJf4MStOSN+/UqiTGsvxx6oYDQanfdtc8IDYh9+pFwFsh32tv0z1LArYVWl3Ge18L
	 Qzh+LmNVH9MC+H3Ag8sHnPBp1V1Vh06C8IvrIHopRLAzceeqGlfSLWlq6Bi/aKDd6f
	 HAZni0waic34p334gG4orgpZu1dF7f6Cj6gg/HKrh/SY6VOv9Bk3sebvOvoI1Sa0gS
	 cbiVIeKn9KwZe65/La2qj6OqilJdgN9jYdJxu+OatAwNPlbqRCTrKwB0kz4STon+Er
	 vWcbSlDSxJ6ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5A380AA7F;
	Tue,  4 Mar 2025 11:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] net: notify users when an iface cannot change
 its netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174108902974.110360.3257129140639138427.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 11:50:29 +0000
References: <20250228102144.154802-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20250228102144.154802-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, aleksander.lobakin@intel.com, idosch@idosch.org,
 andrew@lunn.ch, kuniyu@amazon.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Feb 2025 11:20:55 +0100 you wrote:
> This series adds a way to see if an interface cannot be moved to another netns.
> 
> v5 -> v6:
>  - reword a nl ack comment in patch #1 (add "in the target netns")
>  - add { } in the netdev_for_each_altname() loop in patch #1
> 
> v4 -> v5:
>  - rebase on top of net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: rename netns_local to netns_immutable
    https://git.kernel.org/netdev/net-next/c/0c493da86374
  - [net-next,v6,2/3] net: advertise netns_immutable property via netlink
    https://git.kernel.org/netdev/net-next/c/4754affe0b57
  - [net-next,v6,3/3] net: plumb extack in __dev_change_net_namespace()
    https://git.kernel.org/netdev/net-next/c/12b6f7069ba5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



