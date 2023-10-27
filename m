Return-Path: <netdev+bounces-44644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C17D8DFC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6821F21D51
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332005246;
	Fri, 27 Oct 2023 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPfW6VUE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131545229
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACFE7C433C9;
	Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698383450;
	bh=EKNbDWtfaUD3WEEOAPnInrFXHTHRnJmKszb1TwkoXAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPfW6VUEDtCgms3wTS/NoQn0bTjAIhf2rT7LmcfiFZnnUma4vH+s7AcQpJTqhFzDf
	 5PqWXdvs9Ky0kYM4yQmAk9aSg+fFDA+cLXoxaibFqwMnY7DG2DcnUFySn4s/P64AG4
	 ncwhkO6LdnpDZTVaFG8xfOrw8NV2Iatk9Q9JqGraB3a1ifJ5aV/mZw7m7XLGV0GT+x
	 KdlNG47mzhgXBVv11NqfWNJsHsxJEgBQUTVWAJAVbD3H/xA4StIIO/PycItxBOkMvN
	 UVDGQiQ7zFUoRddAD1SumpMCe+ip8WqJYyP6tg/4CFM0D+XPFVuaOxBIJgD30YQQWF
	 LQDvohJDt6IrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A4D1C39563;
	Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Maintainer change for ptp_vmw driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169838345055.10513.2288095940504010073.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 05:10:50 +0000
References: <20231025231931.76842-1-amakhalov@vmware.com>
In-Reply-To: <20231025231931.76842-1-amakhalov@vmware.com>
To: Alexey Makhalov <amakhalov@vmware.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, jsipek@vmware.com, akaher@vmware.com,
 deep@dshah.net, pv-drivers@vmware.com, sdeep@vmware.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 16:19:31 -0700 you wrote:
> Deep has decided to transfer the maintainership of the VMware virtual
> PTP clock driver (ptp_vmw) to Jeff. Update the MAINTAINERS file to
> reflect this change.
> 
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> Acked-by: Deep Shah <sdeep@vmware.com>
> Acked-by: Jeff Sipek <jsipek@vmware.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Maintainer change for ptp_vmw driver
    https://git.kernel.org/netdev/net-next/c/cc33a80b8164

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



