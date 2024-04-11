Return-Path: <netdev+bounces-86889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C080E8A0A2D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CFA28294D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541013E8AB;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4AKtxuA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1FA13E898;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821229; cv=none; b=Z/i6+3hg5X+q4Gb99f6D7KTlMaS5CJwUUOqTM9YkN/bL5985S4bKFCa4DBzFdqhDOIQIspEhhHz120IqXg6jGA1at4mJEhFhgnQE3Chn4MB5Mv1aAUw8c1BJ1cHGFYjwVAgPp5VDyEriqV5bQjnCi8s5iM5dKowl1e1cKU+IaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821229; c=relaxed/simple;
	bh=clCyL7vAsBdzii6fsC/vNetoRxkOgVXPDpSuTjwGMw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+DSgZMNurhisonha1Q5/Ri+gvTv8lHInAKTSnyTfxK2BjmNUnTTvn5nLv6sSGszgi20NcFmkSQIFRRpuzNI3NcQ6ow/tYR89xPxBixjoCxKT+zKte8SXz64cqJmSed6UYlxTmH4Eob5S+2wCl8tDGF7vZExIIVi4t/4/QYxyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4AKtxuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A37DC43399;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821229;
	bh=clCyL7vAsBdzii6fsC/vNetoRxkOgVXPDpSuTjwGMw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a4AKtxuAymcek4ZUqT+3HJomMpzEwQ+mLhbMHXoR22vl1ozo+NyArJA2hiTuqjFds
	 F7o5dpYe31nHQ8AxOACAYDecupwbYBHIW0dIMDnscRMD8LK7ZRiBE0rPV2FXq6ot10
	 KCzv9FoL8mbF4bG99Vih0j7W2aFfopib4yy1iurrwO9VyPc64Zemj5jbTP8sUpoMYe
	 unm9UZ5yP1QT6GwA8Ef+GHvIyyPBv/eHuISLI+XHoaaz+STaVMwcBLdYk1uWRVtLuZ
	 N/MImuiZwZw7m+P4ZuIDO2DqOXFfbZ/OBzvZ9YMmG22mgYTJARQx5fe45Y44dvRIuP
	 gbzaVh55nmRmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1610EC54BD2;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "s390/ism: fix receive message buffer allocation"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171282122908.27809.17987855320435240196.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 07:40:29 +0000
References: <20240409113753.2181368-1-gbayer@linux.ibm.com>
In-Reply-To: <20240409113753.2181368-1-gbayer@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: hca@linux.ibm.com, pabeni@redhat.com, hch@lst.de, kuba@kernel.org,
 davem@davemloft.net, wenjia@linux.ibm.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, pasic@linux.ibm.com,
 schnelle@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Apr 2024 13:37:53 +0200 you wrote:
> This reverts commit 58effa3476536215530c9ec4910ffc981613b413.
> Review was not finished on this patch. So it's not ready for
> upstreaming.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> 
> [...]

Here is the summary with links:
  - [net] Revert "s390/ism: fix receive message buffer allocation"
    https://git.kernel.org/netdev/net/c/d51dc8dd6ab6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



