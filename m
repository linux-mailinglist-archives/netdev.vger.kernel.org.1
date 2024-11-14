Return-Path: <netdev+bounces-145054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71159C9450
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CA0B228A2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630731ABEBA;
	Thu, 14 Nov 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGLr2cQE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4442905;
	Thu, 14 Nov 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619446; cv=none; b=YaSNiNXyQNPcEOBpI2zJKadr0WK2T30uMN4T7rOMPDCfZZLdV6Ucs3SZYUCSNXAnzN4i5Q3m0i1+zMBTDv2cXm5F6cpS/BEvsy95sB1GsjoRMOKkGIMnZ2iREh9QkClqXrbegDBTpXxgaNsMHsw1R2hxO5p9wHp+GUUxX3fog/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619446; c=relaxed/simple;
	bh=Fdf2fRh/fa4AAA9KsPcO38qEhdZaoYYJ7Kgp4azxid8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pA5JTs6fJXXTNVOgx+Bg6zZAlIxaRta7EnQP7U1gYIahumUresvJ3rCzexM1J+bh2ldiIbfLZ7yUYwHK66RC/kn+TnZ0Enb5d3ugjoq80MoWhlary4pwKCQm4hirfhT/21UX4a2RJOxzd6pB2qzqfE7+9Sqnb6YjlNcruN8kQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGLr2cQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A340AC4CECD;
	Thu, 14 Nov 2024 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731619445;
	bh=Fdf2fRh/fa4AAA9KsPcO38qEhdZaoYYJ7Kgp4azxid8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UGLr2cQErowDjHxrG+z/Tz8lS8/vvNYI5cVqUixIqCjyJ9wQlHHvUKQfcf6+jbbHY
	 NNDuXlXubPIOGDPz8PeV+DR9/HvM/L0brIJFIwD+ve7RLOvx78zpcBdjX/VAQBVs+R
	 6LSGe57YT9l/co9VuC7J975LgcyeA4b7PZ9D362MKCTkOuHoKhl0rEzxp/3kJyU4Ng
	 1cLCxBNRHcHgmfq6snsG07sAPtFlF9lYV0CXne01GVU79OE5E49ljjk/aHtBX5211d
	 dFMg4lbI+N47McDBlLh+IwgF4EdNZMMcZfeOYfOkWaCUjgygDI4oQa0Z3LcDt2gE8I
	 A2Lp0R3UU5tOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8E3809A80;
	Thu, 14 Nov 2024 21:24:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-10-23
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173161945626.2058902.16590652041720850482.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 21:24:16 +0000
References: <20241030185633.34818-1-luiz.dentz@gmail.com>
In-Reply-To: <20241030185633.34818-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 30 Oct 2024 14:56:33 -0400 you wrote:
> The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:
> 
>   Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-10-23
    https://git.kernel.org/bluetooth/bluetooth-next/c/ee802a49545a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



