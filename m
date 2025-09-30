Return-Path: <netdev+bounces-227274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2687BAB03F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 04:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94D53A333A
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F2211A09;
	Tue, 30 Sep 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdVYcakK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C181AA8;
	Tue, 30 Sep 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199417; cv=none; b=JQnJjBHHeJr9DJqwfwRUV8q8uM644cbILcUdpy5L32gr9dUgEFkH5IQ1VFglgLF3PAZNqR2SvonYUuukIlmMFDAFqmFLtkaB3AzIBiv5ZXYuYdluqysVV1g37Fov1TpL+86L+QrPzLSgOfrgZJpYRfxR9abtTnceVUpw6Rfu2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199417; c=relaxed/simple;
	bh=Ht1p0FijMGCD0vYj9M7j5kUbf1+ug2GQLDYNV7EWcog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=goZyNaJW7eMxBF9vNFpraxNDKeQT/jFLwG2BsVyB+FgrxdhvUgqftfB4H4kMrP5vJgad0AGVNM/Gpcgcjjan9945VTx7F3RM7mt+TXBnJbSwzHcnCKKkiQOhKECTr8w2XHhas7b06RQrf/6nYhJ4n5+lZMVyNa0kq5SHI1guoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdVYcakK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D27C4CEF5;
	Tue, 30 Sep 2025 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759199416;
	bh=Ht1p0FijMGCD0vYj9M7j5kUbf1+ug2GQLDYNV7EWcog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MdVYcakKr7CluRlh9gRtO5GJVtOKaWs07GpjLugW+gj1JI6I2PFfK3+d0F7/kI7uz
	 XdlyxQ2S0lkVtBuGNHcqStBEs2ihrzIBdBBWfk2dLucR83CbuL1s28Y7zaSyLYlt7r
	 XwCtDCLVFiyG66bdhoMiUalfx8F2Q2X9oKO47CCSvbF8rjTduJvoa72+Zs6FN8GVHk
	 UscyTmvO7Vyc2zgGX6FzJjdmDD2Z7L9kN+DdmFR5qpokpPCMZVmQUjRmk/2bh9RDQi
	 sfNdZ3B1fCbgARHv8Oc9fAbJ9zY/wK2CEut7gbpNBzbt6BHvGiFSGUfejvhoL3zbkJ
	 HPL+GLT+YTmsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEEE39D0C1A;
	Tue, 30 Sep 2025 02:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] dpll: add phase offset averaging factor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919940976.1796190.7452350875867616355.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 02:30:09 +0000
References: <20250927084912.2343597-1-ivecera@redhat.com>
In-Reply-To: <20250927084912.2343597-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 Prathosh.Satish@microchip.com, chuck.lever@oracle.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com,
 poros@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 10:49:09 +0200 you wrote:
> For some hardware, the phase shift may result from averaging previous values
> and the newly measured value. In this case, the averaging is controlled by
> a configurable averaging factor.
> 
> Add new device level attribute phase-offset-avg-factor, appropriate
> callbacks and implement them in zl3073x driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] dpll: add phase-offset-avg-factor device attribute to netlink spec
    https://git.kernel.org/netdev/net-next/c/a680581f6a13
  - [net-next,v2,2/3] dpll: add phase_offset_avg_factor_get/set callback ops
    https://git.kernel.org/netdev/net-next/c/e28d5a68b651
  - [net-next,v2,3/3] dpll: zl3073x: Allow to configure phase offset averaging factor
    https://git.kernel.org/netdev/net-next/c/9363b4837659

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



