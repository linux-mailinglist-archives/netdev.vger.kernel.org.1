Return-Path: <netdev+bounces-12401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2636737513
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42A91C20D84
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5A18007;
	Tue, 20 Jun 2023 19:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1E17AC8
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA85C433C8;
	Tue, 20 Jun 2023 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687289421;
	bh=nUeCfLB31CaFoKMGKSp295jPG5fUSMkthOYLw6VgpWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2SQcF1CqcIHip21N+TgePwAwGtzZ2voSD1l5mBmw3WVXnePHOxMqOnA2bSPjrw9B
	 MPymQFWZBuUsjymmtI/Ws/ofAiWsk/7emVR4tjW7zevVFRhp1uX0uCAQaN4smqWbJ6
	 6g0jiCAC3EMoeCxq4jVq1EEqPTHg/ZKUlUubXdeeKrHxBDHcJx7DDjZFCKFTqrAjmW
	 5uDKzh01u5UcQ8nXg5uYG3+PaZpLXaDAlFgn+Zn3xiyJVd5PyBJCWCLrLyvmbLoYbt
	 9vshrN0uNXU8pS+EaPgqPeSzOoge0N5SiXoUKjVcf/V527Q68crL24xS4jwrCpJJoz
	 svWF+4tDRsRgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA686E301FA;
	Tue, 20 Jun 2023 19:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168728942088.14216.9670142240343267380.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jun 2023 19:30:20 +0000
References: <20230619150233.461290-2-johannes@sipsolutions.net>
In-Reply-To: <20230619150233.461290-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 mukesh.sisodiya@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 17:02:34 +0200 you wrote:
> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> 
> Add support for AX1690i and AX1690s devices with
> PCIE id 0x7AF0.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0
    https://git.kernel.org/netdev/net/c/4e9f0ec38852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



