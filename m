Return-Path: <netdev+bounces-34384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0217A40DF
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB6A281543
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248A5255;
	Mon, 18 Sep 2023 06:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B41C20
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 06:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA541C433C9;
	Mon, 18 Sep 2023 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695017422;
	bh=vdqklK7MXfN3CFva6C7xemuTVCcM3vqHz7f1AnIdCjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=duHS+vn/pwtEcFNh06w5m2ftlJsBwoLQF1wIhz/5Vx6YQqhg/xz3mebCbgMhcqaNA
	 T96Z8MV6a0+5SCUGX92qJWvpzhwOla7P033x4/cKCt/mfNy7r7ZNGdY43X/7p+AtcZ
	 bXRnpBmKOk0HDSPloXrfzEKMNpmPfnjQDrF+sEQQ/ANuPofJi85l+GyBdVEPlZMpkU
	 wFgM58/t+j4FJVCgjZZjEG3HSuoai9d2UWx1C4uSmTj13WdhUNOiTcY/ev2yzCmxxc
	 kkkAq2Pi7eqtbfLuIwXCFN4/2WZD3huA/ghSwptj5nOA9nrT1L+kD/d+CG6YbliTBN
	 8XoeaGkfvNvoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3059C595C4;
	Mon, 18 Sep 2023 06:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ncsi: Propagate carrier gain/loss events to the NCSI
 controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169501742273.10972.12224789900597363026.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 06:10:22 +0000
References: <20230915161235.682328-1-johnathanx.mantey@intel.com>
In-Reply-To: <20230915161235.682328-1-johnathanx.mantey@intel.com>
To: Johnathan Mantey <johnathanx.mantey@intel.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 09:12:35 -0700 you wrote:
> Report the carrier/no-carrier state for the network interface
> shared between the BMC and the passthrough channel. Without this
> functionality the BMC is unable to reconfigure the NIC in the event
> of a re-cabling to a different subnet.
> 
> Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
> 
> [...]

Here is the summary with links:
  - ncsi: Propagate carrier gain/loss events to the NCSI controller
    https://git.kernel.org/netdev/net/c/3780bb29311e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



