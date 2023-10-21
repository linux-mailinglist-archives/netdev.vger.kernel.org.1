Return-Path: <netdev+bounces-43181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295587D1A73
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437E51C21063
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8F817;
	Sat, 21 Oct 2023 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnCcOTTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE17F4;
	Sat, 21 Oct 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59597C433CC;
	Sat, 21 Oct 2023 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697853625;
	bh=Ei+kODBzIVl8L3VplpOSBYmZrAv5Qvh+i3MnO6ooXWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JnCcOTTsPSPFf9BB3S8uHHQcVoKWSIcIJ4ndqklYxxEdqBLzZ7180rw67KASZ/7ER
	 uuphBaof7LPNFhTGx2O4EHiwJnm8zXwbGEHmAPeEsh0NjYdZopFP2UrBFclOGjmClM
	 zSFlo39qp6wjyeHM5nEIiPa/Z1tww4N6kPSVJqMqQXU4snNGQHDjUFIN6zCRUYyWAH
	 PD/Pqiym+msXr4/Wz7Iw1EZ5pwpNofwFk5Np/g/Dk6YV766GRgGlcm8l5R7+oio3K6
	 tcuAF0LrnkYRYRYuH5W40DKLCba2NOJ4TqsOzsb48cAkgKB7WPOlq4ZXx15yDHnkqF
	 VEgBWqfKA7l+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4253AC595CB;
	Sat, 21 Oct 2023 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: wwan: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169785362526.14770.3733349945703653209.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 02:00:25 +0000
References: <20231019-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v2-1-ecf9b5a39430@google.com>
In-Reply-To: <20231019-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v2-1-ecf9b5a39430@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: stephan@gerhold.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, keescook@chromium.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 18:21:22 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect chinfo.name to be NUL-terminated based on its use with format
> strings and sprintf:
> rpmsg/rpmsg_char.c
> 165:            dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
> 368:    return sprintf(buf, "%s\n", eptdev->chinfo.name);
> 
> [...]

Here is the summary with links:
  - [v2] net: wwan: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/75e7d0b2d223

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



