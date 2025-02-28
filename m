Return-Path: <netdev+bounces-170493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFAAA48DF1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89EF3A7764
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4987182D0;
	Fri, 28 Feb 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLGqUrpd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7226ACC;
	Fri, 28 Feb 2025 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706120; cv=none; b=FA1H+sBdpbjeqgFudpOmfIbDMs80qWBpP2PEA/u5yR37hjKue9FaWUnSjpuAVG4y8W03uSKQLzyT6NWqmqmjlGsR2eFa9XTxVQO0j9SOMBcJulHip364pkyXDs+NS5rL8mQIzyOvynF4Z+VnImWgUkcvIiYWpaKeqQuKUY+uJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706120; c=relaxed/simple;
	bh=AH5J0UcyBhl53duiqr5guETbXIB8mnhzhsoUhRo5PQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o6YyiHZsUSVmA24FN5OPwtZPylIthRj1GZxEZugkY2GLXe6X9qffBd/KNQfZgQiXiGjBhc8EGxKcB5zIGd/8w3U0FCex+MvrsW2thT5EJY/1FcTVTqwYidytXWDd7sOYrWCnbSxWe7EU0E00M3Od/xmdDVBfIeZD5uhaP9mNyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLGqUrpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212EBC4CEDD;
	Fri, 28 Feb 2025 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740706120;
	bh=AH5J0UcyBhl53duiqr5guETbXIB8mnhzhsoUhRo5PQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BLGqUrpd51u3n7y4DhbjjkTPk0aWmHhuy8eHMuloRDkLDvHMGxPbC9hawSxTl3QGo
	 /baFS5xm6xI8v1HT2wZ0REA5/52sWRWDfkMhbewtb6RTKaAMYQ7f/hXCzWNaACuLJ6
	 PWgqZL8rAjVUGWpqv7kq2+ggDK23hK6+6uw7nYY5Rn6EuA/W+LnT9eV5hCO0v1mJbO
	 Lw111yldAPyK7K3sBtrijne0XyZRN6CYiC4eFome1gxkKGczGTfib07Wmo3TmwCiTy
	 WEAtDvjx/Sak4zDFyuq6d0p57N/tmgqnL5hgi04I6m2POCkbBuh928WqP+UwtCnU4+
	 SC2CJOeBrrmhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C77380AACB;
	Fri, 28 Feb 2025 01:29:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qed: make 'qed_ll2_ops_pass' as __maybe_unused
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174070615227.1621364.9825668679002642770.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 01:29:12 +0000
References: <20250225200926.4057723-1-arnd@kernel.org>
In-Reply-To: <20250225200926.4057723-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: manishc@marvell.com, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 21:09:23 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about unused const variables even in header files when
> building with W=1:
> 
>     In file included from include/linux/qed/qed_rdma_if.h:14,
>                      from drivers/net/ethernet/qlogic/qed/qed_rdma.h:16,
>                      from drivers/net/ethernet/qlogic/qed/qed_cxt.c:23:
>     include/linux/qed/qed_ll2_if.h:270:33: error: 'qed_ll2_ops_pass' defined but not used [-Werror=unused-const-variable=]
>       270 | static const struct qed_ll2_ops qed_ll2_ops_pass = {
> 
> [...]

Here is the summary with links:
  - net: qed: make 'qed_ll2_ops_pass' as __maybe_unused
    https://git.kernel.org/netdev/net-next/c/f8131f4cc5bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



