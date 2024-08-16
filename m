Return-Path: <netdev+bounces-119283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D477A9550DE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD8BB211BA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D01C3F20;
	Fri, 16 Aug 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxAEd9+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140F1C3F1C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833033; cv=none; b=nb7zD02GFSMm7TAX0TWv2DOTc6HAt87h5NIb22s21TsJ+9RaQyLll1jlfCxlfX04/vpMkhlNe2C3QNb+uj+S/+YYmcgnBSRGTkGVdIvdZ9XIlktZAbVffexGqt8fObNiLwE0LH8VD7YzrKovqqbEJIMBum/O29fLj/5O5iLOWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833033; c=relaxed/simple;
	bh=ttjZhJCDKTW8zb9cyiGVhuzCzAViubp8vq0k02KMGGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r1t9wJNIwAcsOBeNTVgnGMlEMWvFW4/Y9kV9gC6YOnLVuXaCHMZ0uFtmejPsa5wQhM85L/RBp26kpQ1DRwcfto7rYZdvET8miFBKBSjxNHbTFIgqC4ZFnJobDMivBD3xkdE1Lvgx9MqGDn+Pa7A4Koxc1t2IjN260XnFQG21Sbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxAEd9+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EEEC4AF0F;
	Fri, 16 Aug 2024 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723833032;
	bh=ttjZhJCDKTW8zb9cyiGVhuzCzAViubp8vq0k02KMGGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fxAEd9+cEzpD8Rnt/6HmnxVHUgpoLoCX6cMBH0ZuttwNfjQIXMMublsC20sQFcQ58
	 TkcfLdUoK/R7R2jTIQUa8vvW8286B0T9XlRXgsQeI5MgL1T/RiLgJee31a3pPjxWKj
	 3LjEMIuDmvX6kMbNoxFhW8io9qmTWkhPIs/AjhVpOlbS42W9TcLFoFfYHzWtkX3Fwo
	 qpr+Qf8jEc6xzxoWH1/FAOCbS/fGfInqnVLdTo4Zu90gIEEqADz95xUE/tU5GTtBej
	 Cxz5b1lhkX/IxHWIJy7kx5+ez0NRYgBQKyCko1yG/8F95ptPUqcOdjQorRZoElto4Q
	 deP3eY6peW4lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBED238232A9;
	Fri, 16 Aug 2024 18:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: remove redundant 'req_vec_chunks' NULL check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172383303149.3598282.15138094602242688040.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 18:30:31 +0000
References: <20240814175903.4166390-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240814175903.4166390-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, pavan.kumar.linga@intel.com,
 dan.carpenter@linaro.org, krishneil.k.singh@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 10:59:02 -0700 you wrote:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> 'req_vec_chunks' is used to store the vector info received
> from the device control plane. The memory for it is allocated
> in idpf_send_alloc_vectors_msg and returns an error if the memory
> allocation fails.
> 
> [...]

Here is the summary with links:
  - [net] idpf: remove redundant 'req_vec_chunks' NULL check
    https://git.kernel.org/netdev/net-next/c/795b1aa8f37e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



