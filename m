Return-Path: <netdev+bounces-70419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B684EF3A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 04:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28CBB2530F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13B4A33;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io1oYHK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429F4A31
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448268; cv=none; b=D+w+3SebkOwwIkm6sdd8aZEPX67zl7b+6mBFCUnzy1Ns5JJSG++Ww7jnjmGm3KTcHDWkfmrGoQidgG76aacPRgSEaOdw9v0SIFWjjnyXCBsZ7ezkszW4/gBjTntyv78aQ6wV4Gi0DT1OEBRu/JwaLmeMQWIs4+wuIe48UcVoxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448268; c=relaxed/simple;
	bh=knPlsTwOfTn/cKc4dhD1A6q1j/9VEoiMaSFoPbeUo2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZO0nwB6Ptxa6bEzmO+62EpGsPCPku7e3MxlikQh4gEcWBP6Rb+bKE8acpevafDzsud5JUCkrb7bXdBqsWTi3Ou3jWQA4f9tflvGw43y/1rYfbys91S/yNu2tpkQ8l1F4Y/NHgD1dbLlLUf1PcmWU1tTBU5LaeM6V5pW7D7+X7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io1oYHK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57AFDC43330;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=knPlsTwOfTn/cKc4dhD1A6q1j/9VEoiMaSFoPbeUo2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=io1oYHK4wBHPHN2HpYPVF6MoSTtvxuu/IwqPuzkHSV81ggXkC37xaDMm+Pjz1DWi4
	 TRivOf5OOyWSpbAv6fjcr8EUMHsxesWctyHkHBYUt3VZGohObVfrUeK67U9RiSn3cK
	 9rxsJt+I4X/gRRf82aM4tstNzyshzYuRE2yixz8KeA6J9oRBEcQSlewI3yiM/wzCPL
	 sIgm2v26O4RSX25G7T6+5dEksqrXcyFEPn+//dsAIv4bItgFzqKqsVjk2xhBzQHGJr
	 PLCEdnTqLX+GTulhmu4DJl4HFbGNjpIjrZ+yY3hC7lJydDDsPQz2bjkpeZoi0lSI2L
	 z2CTSg5Sq3zNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C8C7E2F312;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESUBMIT net-next] bnxt: convert EEE handling to use
 linkmode bitmaps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826824.23533.9844442167901588598.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <9123bf18-a0d0-404e-a7c4-d6c466b4c5e8@gmail.com>
In-Reply-To: <9123bf18-a0d0-404e-a7c4-d6c466b4c5e8@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, andrew@lunn.ch, linux@armlinux.org.uk,
 michael.chan@broadcom.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Feb 2024 17:47:35 +0100 you wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for removing
> the legacy bitmaps from struct ethtool_keee. No functional change
> intended. When replacing _bnxt_fw_to_ethtool_adv_spds() with
> _bnxt_fw_to_linkmode(), remove the fw_pause argument because it's
> always passed as 0.
> 
> Note:
> There's a discussion on whether the underlying implementation is correct,
> but it's independent of this mechanical conversion w/o functional change.
> 
> [...]

Here is the summary with links:
  - [v2,RESUBMIT,net-next] bnxt: convert EEE handling to use linkmode bitmaps
    https://git.kernel.org/netdev/net-next/c/6fb5dfee274c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



