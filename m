Return-Path: <netdev+bounces-43553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F97D3DB9
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982E12815C7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48520B38;
	Mon, 23 Oct 2023 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxYJ9dDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FD20B29;
	Mon, 23 Oct 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46F2EC433C9;
	Mon, 23 Oct 2023 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698082223;
	bh=RDvyzbOMpw9P4rJLFlUagfiIuQbQLm1HfbVFlStZ/yY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fxYJ9dDzaWQd5bb/H3sGbasjgsQdUMAWzMUJl8ls1L38IToMVRL33MTWJG0aX5leN
	 plxZLfdxCvuJPTIgixz1+FE+pxs/KetIul3Vc9N5BMitlv36U/p/USPdwGr2+0Tom7
	 aV7H21lp/mn8GEBPosIzt6q5YRiZuXLnjsKxOnHTZIDpifcVgDQyRNvybRznr1d9Ly
	 VlpobCA89oiS4UaJgF7BSYa+FVd35EbRb86s6NDu72H2TCxq3HDglI6GDlhrdf/ntF
	 URXgFjRTiRc0ScInpXTIBlCZff32Fav/kPg8OUEEoVgofm3O6hSNn4429iNvOUyRU0
	 7vibHxIC5i9cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DDE5E4CC11;
	Mon, 23 Oct 2023 17:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/handshake: fix file ref count in
 handshake_nl_accept_doit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169808222318.2880.6790391903176852910.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 17:30:23 +0000
References: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com>
In-Reply-To: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com>
To: =?utf-8?q?Moritz_Wanzenb=C3=B6ck_=3Cmoritz=2Ewanzenboeck=40linbit=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 14:58:47 +0200 you wrote:
> If req->hr_proto->hp_accept() fail, we call fput() twice:
> Once in the error path, but also a second time because sock->file
> is at that point already associated with the file descriptor. Once
> the task exits, as it would probably do after receiving an error
> reading from netlink, the fd is closed, calling fput() a second time.
> 
> To fix, we move installing the file after the error path for the
> hp_accept() call. In the case of errors we simply put the unused fd.
> In case of success we can use fd_install() to link the sock->file
> to the reserved fd.
> 
> [...]

Here is the summary with links:
  - net/handshake: fix file ref count in handshake_nl_accept_doit()
    https://git.kernel.org/netdev/net/c/7798b59409c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



