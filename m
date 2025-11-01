Return-Path: <netdev+bounces-234799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C5C274F5
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 01:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7B188F1A1
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 00:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185011DB375;
	Sat,  1 Nov 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChKx70cv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F421E89C;
	Sat,  1 Nov 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761958233; cv=none; b=ok0S+jiPK97NhnDbEVKrUzmY3kyuHSaHIxOWeqmvsEZ6XwbdGj09nGX5Q3EGMzich08+vrrFliBnWYvty5bN4oHMkBm2xFNdqiZa/weibDgIcHX+0neRyY9htIR1WS7cZEyP7LyDJ1clF1nBo9a7i79RiACEkrxf3oQWftsLeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761958233; c=relaxed/simple;
	bh=YJZn/eLU0RXxJqRTKeG7+rSmwiek4v9aSi3x9JVlsM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MSS81HrnZoRZumfvWHQ1Nx7McN9NPB8Oba8gUf2BbSEvcmp6ezM/aIbI6LeqVqz68+unhInSGPyblKov7ic5U+rH+crEmwC0SrxFaRvFKnJ+GT4rXaYxQLFZjHA13PJXlZG0IL9mJSgCTEGVIvtaZPJv9GV6PRrpFvfTtcYmytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChKx70cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ABDC4CEE7;
	Sat,  1 Nov 2025 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761958232;
	bh=YJZn/eLU0RXxJqRTKeG7+rSmwiek4v9aSi3x9JVlsM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ChKx70cvZNuZkqLss+Mdp/htv1EH90QwKs+quOIb5lYMSOnL+bzKnCysdMef+hxSn
	 0TxFK9MkUg4doy5uMJcVtreaI6M1VdQ2qkV3wEmxNqIr/eOE49FeIv1OE4+v6uTXH3
	 IUmYEcF7uZKobtY6aqyiVrWd052SuqNPgm2lSBRO1Yn+YUhnay9CkmmGsyu3xGo3yH
	 348Bt4u0t+EwjPD+Sof7bJUkUVxFfIppYujK1X3c2mJXqoiOo3AH29ZemjFs2b/4PS
	 fiwSelEbFFUrgtmQpsdsrp2pgyL2kqF+afRP6L+OWyyYrYdLwRI/oWSFpSqXRRsRL7
	 Oo/uPOkBCRxKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0313809A00;
	Sat,  1 Nov 2025 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] isdn: mISDN: hfcsusb: fix memory leak in
 hfcsusb_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195820878.682052.7911747222895966918.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 00:50:08 +0000
References: <20251030042524.194812-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20251030042524.194812-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: isdn@linux-pingi.de, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 09:55:22 +0530 you wrote:
> In hfcsusb_probe(), the memory allocated for ctrl_urb gets leaked when
> setup_instance() fails with an error code. Fix that by freeing the urb
> before freeing the hw structure. Also change the error paths to use the
> goto ladder style.
> 
> Compile tested only. Issue found using a prototype static analysis tool.
> 
> [...]

Here is the summary with links:
  - [net,v2] isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()
    https://git.kernel.org/netdev/net/c/3f978e3f1570

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



