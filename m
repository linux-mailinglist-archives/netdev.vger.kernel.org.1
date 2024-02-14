Return-Path: <netdev+bounces-71596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06758541A2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3448A1F23720
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88228F40;
	Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2sp53be"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CF8BFA
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879030; cv=none; b=Fg3Ym7JRN9lX6iZkF+4QeEmFk4l+YAv+ts6Yg7NOTb3hOqlzLKFhryzDdaZBpwgmT5Hg3K7Di+DxGz+e0Shu+nFMGYaXf/bsngGy9Y9zlG27LEc2tL8zCPfvdc154pYiaHkX8yIwL/4cuVO9yVQqieGaVuXeeX2VYljo+FRbOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879030; c=relaxed/simple;
	bh=BD5DpRDlPreBEKnVM5SWorDZ+TFxtqKd+aTGWCOowb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N7eZK04Ijd9u0f4Htns/sdFNXvwVO2VN1WnuENvHP9fa1UFHDukS5Odfnn/d+LvnNapD3xkQJRSyBpv884LcwiVENdUZTh1T7yxdI3dEpVHL/6mS6qAOUNGQn+86eYCkw5wCUrH73kB2MlqAVBjaIYu2nb3ESHSKQmVkhVnwtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2sp53be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C044C43601;
	Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707879030;
	bh=BD5DpRDlPreBEKnVM5SWorDZ+TFxtqKd+aTGWCOowb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e2sp53benEEjH6hcdJ46e4/9P+smdSgVaJbNW0tdTdzG1QN3y5ULQbJczQLTOqKwm
	 nHGv1XR9OBRYys7cITckwgIyElrfAWV2NilMKqZQG0PN3v6S2IlK7JCd7/3eBDe2i9
	 ZcOmTzcmCeebXfDHJ1b90VdgG7na8GoGdlNr/IgfS357/sM2SsGeqtxY+f9Bi6+85r
	 402FhxN4+X8EeGmSNKctAn+63DIYFsICsphrCj21qKZ4MrJYrVjks5ZPWXXEx8pipM
	 ExhAS1ULIwMPQqFtxp0vlCUlNNEespqt6o/FYZKH+fGDHmbywV4PP079esUGQCJ6MV
	 /R5L3mqOVY2tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C32C1614E;
	Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: adopt netdev_lockdep_set_classes()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170787903009.13249.13577800268153727806.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 02:50:30 +0000
References: <20240212140700.2795436-1-edumazet@google.com>
In-Reply-To: <20240212140700.2795436-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 14:06:57 +0000 you wrote:
> Instead of waiting for syzbot to discover lockdep false positives,
> make sure we use netdev_lockdep_set_classes() a bit more.
> 
> Eric Dumazet (3):
>   vlan: use netdev_lockdep_set_classes()
>   net: bridge: use netdev_lockdep_set_classes()
>   net: add netdev_lockdep_set_classes() to virtual drivers
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] vlan: use netdev_lockdep_set_classes()
    https://git.kernel.org/netdev/net-next/c/9a3c93af5491
  - [net-next,2/3] net: bridge: use netdev_lockdep_set_classes()
    https://git.kernel.org/netdev/net-next/c/c74e1039912e
  - [net-next,3/3] net: add netdev_lockdep_set_classes() to virtual drivers
    https://git.kernel.org/netdev/net-next/c/0bef512012b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



