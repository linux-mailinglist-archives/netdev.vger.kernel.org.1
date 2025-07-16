Return-Path: <netdev+bounces-207642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF18B080DB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87A41AA61D3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31072EF652;
	Wed, 16 Jul 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLV3mASs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C72EF64B
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752707992; cv=none; b=NhgNHXuwtM0mg3mkldjdNcUrkDkNvve4pN+3wepTxzUFc2ZoQEJx/s0rvJlC0SAF/M6GiwBMtkn53rShTGLNZjayZhATx+/ZzD88FYiIxYWpSsNNy3a/30tBLeo6p8c0+Y+Ree+F+4YtEK3JZSFl0wztTR+kEAVfGVlmQeICp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752707992; c=relaxed/simple;
	bh=3tMvUmk31FF6rw9SHQtDBBa7N/23wetLTQnNW7E5Cdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TWzPyE/3MV8n6T4ZIEIsY1tvPPk2TzeUWifVahNHIC9rYCoGSBYA/zQLGGA8+tQCPEi6duL6SlFkuu/lKqkjYKWbUPje6KLIUG0XzHm/n84GQNtkWgqhmDdstzaglOZKVhBdcujpCLtWRrsZyaJyiMcrVO8BvtoF09DyP/8jIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLV3mASs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BABC4CEE7;
	Wed, 16 Jul 2025 23:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752707992;
	bh=3tMvUmk31FF6rw9SHQtDBBa7N/23wetLTQnNW7E5Cdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aLV3mASsPvJsIJ1aFjfoK/Zp1oAaHiR/6o674bUQ6j4rsKk04dPducXOVrSzR+0Ni
	 K/UEGfq4WJuJEOsvcQxIa8FZk6tOF6N/cXILaSVb+kctqUQulLbGJeUUpYZzJ8kqrA
	 qWbUpts7lGU768mLJHvBcunZYF9MPpX2Qqs5DIJCWLxYvVxIi8HLSV1tC+4uMpsOjt
	 QX5PpqwWPBpSeOIKcv8McjambpqIfQpULRtpJ0eBUqEZ6WAISCTA9Vvo2i05rP0FCp
	 oySRPjiA/HRJaL2q1LycMRIfkqU+PhrLHpgDKxWe7rdKN0HFppQ6rPKFuVhXxR9vWw
	 gUozELrmV347Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9D0383BA38;
	Wed, 16 Jul 2025 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock/test: fix vsock_ioctl_int() check for
 unsupported ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270801224.1359575.16601767977685545623.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 23:20:12 +0000
References: <20250715093233.94108-1-sgarzare@redhat.com>
In-Reply-To: <20250715093233.94108-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 11:32:33 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> `vsock_do_ioctl` returns -ENOIOCTLCMD if an ioctl support is not
> implemented, like for SIOCINQ before commit f7c722659275 ("vsock: Add
> support for SIOCINQ ioctl"). In net/socket.c, -ENOIOCTLCMD is re-mapped
> to -ENOTTY for the user space. So, our test suite, without that commit
> applied, is failing in this way:
> 
> [...]

Here is the summary with links:
  - [net-next] vsock/test: fix vsock_ioctl_int() check for unsupported ioctl
    https://git.kernel.org/netdev/net-next/c/47ee43e4bf50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



