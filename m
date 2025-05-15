Return-Path: <netdev+bounces-190590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D4AB7B86
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEAC7B61E0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F726989A;
	Thu, 15 May 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCCnwlZb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EA1EA7C2
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275600; cv=none; b=ak1nISGRFBJgJ/rFePK9HQLKNit6SrNzY7OoKgMzKoJhz3/0h2iU4fslRwofyvfTXsFLY4NvhgDrTsgCgHXPavC3/2i8BQ9ISK4BEYp5wcO7MwbxxIQ5ujhSXpWwmna8TKEmFkIbL+8vLFWHe5sXSjNFIYDxCLp78CRbfTjL1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275600; c=relaxed/simple;
	bh=6+eFQRWcb+ZaAlil5sHboD7LQe1plf8N+J3HcYq8nH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jdGNNbtYdOeDiMTZxxKZcaZj0SF6RRI3q3tXLiAmo+YUidAVcmcp+Z33vXOOFpbVgCscYGFd6WVxseJiSGtii+MSbS6Yi3x/2UF9L1WpSmvPnQLltQ4Idxa0TAwxUSKu3Udl8KFGj/eLE/EjJDU+i2jdrcHiL6hSrlTPcaVMA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCCnwlZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7FDC4CEE3;
	Thu, 15 May 2025 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747275599;
	bh=6+eFQRWcb+ZaAlil5sHboD7LQe1plf8N+J3HcYq8nH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nCCnwlZbNx29AjWDvQJl5wyoecbOOs5+p37MG+exlWXhMUJuK3mNBTr3Z1ANpWuSV
	 92Io4QHPeUZkGoj8zPwJBiWkwdR8ljPqz6JHHsFWOB0fOTPWo0zmCaufZEIW+pnSI7
	 sVfH7Ipa+L54M4erli8ty6WjKiq1y2AfNCVtYBDXrHlyNlWXd9ZZynu7QCy8jbwwNX
	 clNTPjdfzCLwZMioktActrzJBRJRLduH+UbMDtWXPa9Z2cWfojQvBaCRWMo2neeTtF
	 c4rYfrYba9zg2aPRpQecJLo1xI/qtoizxeeuiyPOWBhHFKsivEzMznqGuG+Gu5fP6I
	 scny7C4zPeoKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34526380AA66;
	Thu, 15 May 2025 02:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] openvswitch: Stricter validation for the
 userspace action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727563674.2582097.9408039734394168473.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:20:36 +0000
References: <67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com>
In-Reply-To: <67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 10:08:24 +0200 you wrote:
> This change enhances the robustness of validate_userspace() by ensuring
> that all Netlink attributes are fully contained within the parent
> attribute. The previous use of nla_parse_nested_deprecated() could
> silently skip trailing or malformed attributes, as it stops parsing at
> the first invalid entry.
> 
> By switching to nla_parse_deprecated_strict(), we make sure only fully
> validated attributes are copied for later use.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] openvswitch: Stricter validation for the userspace action
    https://git.kernel.org/netdev/net-next/c/88906f559541

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



