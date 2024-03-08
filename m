Return-Path: <netdev+bounces-78718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E78763E2
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823C428218D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41A56456;
	Fri,  8 Mar 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVMi6AK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C31535CA
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899236; cv=none; b=Ac3FoTyq1i1g+3zA97S5aEcI/Pvb9mQwJ+c9tZlrfoIz9bqaVy+qKMyP7UFSc/54c05v0NX+/RIPdiH1gGvOrAq9VFF60/vS794+ztwRgUWOR72V6RnyTKOH/jLXGh9t6Y+wfpHbaQD36B6oTtOcLIdiFisElYCx4fcPx+79XiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899236; c=relaxed/simple;
	bh=PvZozQkHf4MHTlqC8LmjYfIxvcwWpUfFX+yZZJrhljI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TmTIB1gDdPQR7lBod9AFb15S7F3UNMHuj0KtijsG4TeuLV5L3TN/eRFtaDRPYVZkAODtPrgkRLtPh/f8H7f3LaWYpuybXz7egBYGtP9zoic+0/xt6VHg39VBW4Eeof00Ub7ouAXtLLDsiQZCy/QQ15/JeaqRJ230U6JA0wZGyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVMi6AK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3538C433F1;
	Fri,  8 Mar 2024 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709899236;
	bh=PvZozQkHf4MHTlqC8LmjYfIxvcwWpUfFX+yZZJrhljI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XVMi6AK4H5Y5No2f8iO1Bb5c9R2HKTXkHZCV9UpiYttXkoAX7RLacgwmy1dC8DXfk
	 GqQzJm4aXcK03wrXT88uVJxTbLgXCitho9IeOxMYeR3yZZ2FWW+kesQMNHTFpPoEpb
	 FsOKYFUQMwFqKLP+BLeCA0E+X7B6bUGfLA+8xClLU6MXIi4lMi62h6TxKE1Od+loWm
	 nQtyxbki0Azy5UIhsZ8kc3NSXvTNbtXSPKm2GTX9uavs0//G0PhauGZfh9fPotNgSW
	 KhFm3tB67W3DN7ZaUq+i8UdTum4Ws7lYonle/A+fj5hWewnx2zoRiTejRLWmHHQMPA
	 MRnHCTkfs06cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C833DD84BBF;
	Fri,  8 Mar 2024 12:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] ionic: putting ionic on a diet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989923581.957.1174550445221956227.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 12:00:35 +0000
References: <20240306232959.17316-1-shannon.nelson@amd.com>
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 6 Mar 2024 15:29:45 -0800 you wrote:
> Building on the performance work done in the previous patchset
>     [Link] https://lore.kernel.org/netdev/20240229193935.14197-1-shannon.nelson@amd.com/
> this patchset puts the ionic driver on a diet, decreasing the memory
> requirements per queue, and simplifies a few more bits of logic.
> 
> We trimmed the queue management structs and gained some ground, but
> the most savings came from trimming the individual buffer descriptors.
> The original design used a single generic buffer descriptor for Tx, Rx and
> Adminq needs, but the Rx and Adminq descriptors really don't need all the
> info that the Tx descriptors track.  By splitting up the descriptor types
> we can significantly reduce the descriptor sizes for Rx and Adminq use.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] ionic: remove desc, sg_desc and cmb_desc from desc_info
    https://git.kernel.org/netdev/net-next/c/d60984d39f18
  - [net-next,02/14] ionic: drop q mapping
    https://git.kernel.org/netdev/net-next/c/90c01ede6d31
  - [net-next,03/14] ionic: move adminq-notifyq handling to main file
    https://git.kernel.org/netdev/net-next/c/05c9447395e5
  - [net-next,04/14] ionic: remove callback pointer from desc_info
    https://git.kernel.org/netdev/net-next/c/ae24a8f88b3f
  - [net-next,05/14] ionic: remove the cq_info to save more memory
    https://git.kernel.org/netdev/net-next/c/65e548f6b0ff
  - [net-next,06/14] ionic: use specialized desc info structs
    https://git.kernel.org/netdev/net-next/c/4dcd4575bfb1
  - [net-next,07/14] ionic: fold adminq clean into service routine
    https://git.kernel.org/netdev/net-next/c/8599bd4cf30f
  - [net-next,08/14] ionic: refactor skb building
    https://git.kernel.org/netdev/net-next/c/36a47c906b23
  - [net-next,09/14] ionic: carry idev in ionic_cq struct
    https://git.kernel.org/netdev/net-next/c/0165892477da
  - [net-next,10/14] ionic: rearrange ionic_qcq
    https://git.kernel.org/netdev/net-next/c/453538c52ff8
  - [net-next,11/14] ionic: rearrange ionic_queue for better layout
    https://git.kernel.org/netdev/net-next/c/4554341dd0eb
  - [net-next,12/14] ionic: remove unnecessary NULL test
    https://git.kernel.org/netdev/net-next/c/a12c1e7a6449
  - [net-next,13/14] ionic: better dma-map error handling
    https://git.kernel.org/netdev/net-next/c/56e41ee12d2d
  - [net-next,14/14] ionic: keep stats struct local to error handling
    https://git.kernel.org/netdev/net-next/c/2854242d23a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



