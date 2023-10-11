Return-Path: <netdev+bounces-40083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0774A7C5A69
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2FA1C20BD9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0DA39946;
	Wed, 11 Oct 2023 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMQSrzaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB581A41;
	Wed, 11 Oct 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50678C433C9;
	Wed, 11 Oct 2023 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697046025;
	bh=ASe+Jx12t2/axReJbaYPLyiArb/zifhujifxJT1BgeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TMQSrzaMvfjlwCu1l7I7IKb//ZqRmZ6a6t0FSYx+E2xIv90vzoMLoM54VmmmPfpXv
	 3mcusSKSdn9DNvyEdeDX4d5+VEqZMWqadFmIUXqUSI8sHEjrTwwC5B3Z3E4vJHGmTG
	 fgtZKsjZBMgUBcDgVrGcMQR1XX2afKyz/izrx4vnWnYhomQFSCpUYKKSTS72myc3A7
	 +PAHoxDW75OiTHr6VzlE+oftKx/tmzIwkYQzFwqEc9l1cc2r9Bxc/nRl4FbeOP5Hr1
	 M7n9vT54dksRBJW4HKp3z6SHXSBgH0zL2ww806Kj0VrnHB1f7PMyzmgdtcjsclMamC
	 KJfcHOewF8pCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34FC0C1614E;
	Wed, 11 Oct 2023 17:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sock: Correctly bounds check and pad
 HCI_MON_NEW_INDEX name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169704602521.20012.6049823285233364562.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 17:40:25 +0000
References: <20231011163140.work.317-kees@kernel.org>
In-Reply-To: <20231011163140.work.317-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: luiz.von.dentz@intel.com, twuufnxlz@gmail.com, marcel@holtmann.org,
 johan.hedberg@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Oct 2023 09:31:44 -0700 you wrote:
> The code pattern of memcpy(dst, src, strlen(src)) is almost always
> wrong. In this case it is wrong because it leaves memory uninitialized
> if it is less than sizeof(ni->name), and overflows ni->name when longer.
> 
> Normally strtomem_pad() could be used here, but since ni->name is a
> trailing array in struct hci_mon_new_index, compilers that don't support
> -fstrict-flex-arrays=3 can't tell how large this array is via
> __builtin_object_size(). Instead, open-code the helper and use sizeof()
> since it will work correctly.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name
    https://git.kernel.org/bluetooth/bluetooth-next/c/fbd34cc57479

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



