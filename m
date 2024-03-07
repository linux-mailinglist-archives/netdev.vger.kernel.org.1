Return-Path: <netdev+bounces-78511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC98756C2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 20:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B581C209DB
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3D135A7C;
	Thu,  7 Mar 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ3uvsde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCE135A7A
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838629; cv=none; b=Hih3ku6P0iDaEtsNv21U/Jc3FmHDZ0r04qTZ4DQluulu8LkTNX+DEZ0ltuSSfiAM90DsMaZxxXkPxJCZHAZAfw0yroQOksoQLdci0tk+hprfEdQDrxD+zyDupu0faNp1eTCjxD2OdkwH7SfoGEjXklpTPDMxDeK77J9CbB0UOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838629; c=relaxed/simple;
	bh=+Y4MXW+ztbbARJvlhCqK23Ry8YphgA9+onUPTUGqGss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgBSvAKL2r1djBw55BCJjP5aoOwGUU8H1pFtNT9EcReU8WMab1/FQJ/ODKE9BA7wFWxkVp/5FPk+3WfSy/Dk7ao+UXg28lAEQx7oZL70dcKPz1xQ3+NaqxkBYc1DwUwa1qhvQ/JTzP8QObpSP7cgLZLaa/o136Ka12q03jNgUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ3uvsde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20AECC43394;
	Thu,  7 Mar 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709838629;
	bh=+Y4MXW+ztbbARJvlhCqK23Ry8YphgA9+onUPTUGqGss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WJ3uvsde9Bshxf9zVf0cOyKgfZ8a12xN85EjShVSvypLv0/pbmy1x/s+Kdw9ss0f/
	 SPrrpGXNK2+q6zqPxgrRtHDUbowhRu06xZWhmTUAgGrXPW3FbVCecerKN+lpjzSBSU
	 FhBN94Lr1GdDULvj4Mf45YAj/pcAHna77w/IUFI6Ttq3q+hPekAcaUqzSGpKP2Xn0/
	 0saZBPoKJmkOVCK98pLtPtgw9nwln20flRqSV5JEIjJ7obZwOAzZbGeLwvISfMRbXA
	 FnbF0Io/DtViOI6WYZr5WFzJ7xkPnvgIf/X3FhID0CQ0H46Sy1rwmExjEJTeAii2qb
	 PYSowraErI/8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 007EAD84BBC;
	Thu,  7 Mar 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: check for overflow of constructed
 messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170983862899.13962.2081763612870763157.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 19:10:28 +0000
References: <20240305185000.964773-1-kuba@kernel.org>
In-Reply-To: <20240305185000.964773-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, nicolas.dichtel@6wind.com, jiri@resnulli.us,
 donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 10:50:00 -0800 you wrote:
> Donald points out that we don't check for overflows.
> Stash the length of the message on nlmsg_pid (nlmsg_seq would
> do as well). This allows the attribute helpers to remain
> self-contained (no extra arguments). Also let the put
> helpers continue to return nothing. The error is checked
> only in (newly introduced) ynl_msg_end().
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: check for overflow of constructed messages
    https://git.kernel.org/netdev/net-next/c/15d2540e0d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



