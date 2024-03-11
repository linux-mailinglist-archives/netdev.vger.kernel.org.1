Return-Path: <netdev+bounces-79276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F223C87897C
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B4CB20E20
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92326FC7;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka3O7MHG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624B3C0C
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189030; cv=none; b=Pmv6g1uQ+G5LByFGb7G9FmoeLOa/Dy/h0iM6UfMlW2zw/ayHbCeSu90ab7zntdpo7oea3tt9/hyUlY4Wigiy3NmluvFtiMtRJbD4JNfjNuQWPGQpnjbahfpajI/WDRQhb7nOt0fC5iNpI6CjOXdSypUDt0cXuzkkDqDn5ssADrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189030; c=relaxed/simple;
	bh=LKGkzUD/KdmWman22iNcxPzyxE+6IUkg1w0FUJ7sno8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J+Vu2mhqWmqtcyFCiTXEpuZuQEfVghg7A0exoAFQpXueoq1ga9FNYgeCqGpbYtJwzYY3KDLdvG577YxVjEMLT8cd/AL45y2M4Y3pI08mY1oOy9E8XrP/l+OilRpS9loQa19+8iGNCpvC7Wmrb6sRqke7Yn8rxa16j4Jxp5Kggz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka3O7MHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 791B2C433F1;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189030;
	bh=LKGkzUD/KdmWman22iNcxPzyxE+6IUkg1w0FUJ7sno8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ka3O7MHGyNluQzrqc4jl6CwzDcjCDj6Quu/CcFe3fptALD138ndkvtGfVK/m0ZTPV
	 9l6ozREiX8H2/H0D4cjRDf39opW3WkngXx2/eVAMc9EEadjnVbtiG0seAgdP2lxnrt
	 w9mXK5Y+4A0Pchsgcgejbm7nEtcXJ43w5C62r4BI+0UZa1C9K3hodgIP8AMwHvW6vw
	 wBivhxxLkklrW67NZLaj/jmE6mQ/QrjMNsQrVabOiPnfJirD1gThmmQVQTF7/VBsYj
	 dL/32cmp7nyk50RVahI4xxa5sROVN6yG1Hot7n3fZXVCJHGgJk1ojgvPI2NESVPWqp
	 +K5z+dX6Ygg8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64554C395F1;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] netlink: specs: support unterminated-ok
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018903040.23953.11246680652398092647.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 20:30:30 +0000
References: <20240308081239.3281710-1-liuhangbin@gmail.com>
In-Reply-To: <20240308081239.3281710-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 16:12:39 +0800 you wrote:
> ynl-gen-c.py supports check unterminated-ok, but the yaml schemas don't
> have this key. Add this to the yaml files.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: update subject, expand the doc and leave the change out of
>     genetlink spec. (Jakub Kicinski)
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] netlink: specs: support unterminated-ok
    https://git.kernel.org/netdev/net-next/c/44208f59362e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



