Return-Path: <netdev+bounces-177128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE00A6DFFA
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A243B21DD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18282638B0;
	Mon, 24 Mar 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMJaZMFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968C25F96B;
	Mon, 24 Mar 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834398; cv=none; b=iOsq3jTbVhILvdpkQmfTCzpXpGTDvlZl1UTqeKifZ90dCvyd5v83EjEi+Q8VMULWGy5hFQYD14uYjplo2q7eskXi/9syG9wRd8SXP74jHNsGgOxKS3G0nlZiUfyhC3r7pjsqb5mgnEMNfws33ZTBZIzmb31yl7mxAgRIC08zUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834398; c=relaxed/simple;
	bh=Wl0bTv3Oau2GnncRqVR1+E1gx6HEXnEqXlEbMOUlVkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cD+Z/+GKUuE1Jg5QSLoT9FYVG+jU1Bu7TkdrYJSvGVDa7q5MdIxptN2W/J9cvVtWL+rySQ/SEUC1C8JRFBu19+zF0Iabq8oAEg1RoUC3n4EmEyvTI2ugIpUtODZ+WWvJQdadNmVmGYAN6wP+XgnOI1dExHjHtqYemhwwdTbN6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMJaZMFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4870FC4CEDD;
	Mon, 24 Mar 2025 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834398;
	bh=Wl0bTv3Oau2GnncRqVR1+E1gx6HEXnEqXlEbMOUlVkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kMJaZMFw/Oc8CrrUOis3A/R6EDiBWFApx2v+tlVPz18GOfEXL61meHIhfkcHTNA58
	 yKz0Rmee9rNIQxHsCGrLfg7cHWulSlYlOxbzkP0eZR2s/lLHQboorcuJ6xe8wlx4IZ
	 /pQ3OL16wVTnjoEJ9Jl3zSUgVI3DlMvsRyP1i6wmvbgIF1hlzv5pJQUupZUnqFfWLN
	 Cnx0YD0EbRUsv5TTtZ1gmu7mX1KerW8I2bV15xbhqT4EbeffrdKmCV+2CFfMpKQz2X
	 0ROuvx/o08qs7LQQvHeH+COgI/NZMT1MpDriF+H/9Z2vSAr/yL0pioKahCbyBn9S/X
	 fUx9jrCxfx00w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE28D380664D;
	Mon, 24 Mar 2025 16:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: openvswitch: fix kernel-doc warnings in
 internal headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174283443455.4090423.14500269133462520732.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 16:40:34 +0000
References: <20250320224431.252489-1-i.maximets@ovn.org>
In-Reply-To: <20250320224431.252489-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, pshelar@ovn.org, echaudro@redhat.com,
 aconole@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 23:42:07 +0100 you wrote:
> Some field descriptions were missing, some were not very accurate.
> Not touching the uAPI header or .c files for now.
> 
> Formatting of those comments isn't great in general, but at least
> they are not missing anything now.
> 
> Before:
>   $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
>   16
> 
> [...]

Here is the summary with links:
  - [net-next] net: openvswitch: fix kernel-doc warnings in internal headers
    https://git.kernel.org/netdev/net-next/c/6bb0dcb3d321

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



