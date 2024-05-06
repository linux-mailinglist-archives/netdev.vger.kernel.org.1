Return-Path: <netdev+bounces-93793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A38BD37F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416071F20F09
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7153156F45;
	Mon,  6 May 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSYCK7eb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CB156F43;
	Mon,  6 May 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014828; cv=none; b=DdGbFT2xOUEK3Lts71hDLNcRzdZrl4adj6KJGYy4wviulksoWg+U/SrdL3nsQ+v/3NRCrs10hT5hK0Ub9nJigKeX2kqNy0eQ5OGDxKpTR2XX7Wsr+1v0q60utfzcSaYxnm7GmWLSNXTgYxftFjV9eRyMQJ1h6Fn5p/9F0paZw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014828; c=relaxed/simple;
	bh=wxLv1v6pq8o/ukY49jdtwQdze1lFJ4uf5fQ5aytYq4s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sIRQoxauAulmCsze6VvXJosMfnoVQa2fwmc3Y2B8OQ/S+BfDdTPJQ8BSRE3/tAftSPY/dY4OnNmhDBLft0dJB80z/slHjahgw0kTGUjZW41i7Wtv4yLOz7d3LhVL6hgz3wXPSsmCRwPWcDLlxY9coLUfCjKx4mE5QoUealO7Guo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSYCK7eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3469EC4AF66;
	Mon,  6 May 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715014828;
	bh=wxLv1v6pq8o/ukY49jdtwQdze1lFJ4uf5fQ5aytYq4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tSYCK7ebxna1LNOXDBPgeEzxSAZz1Oj5yR8rKuNlGC0GDguWxxszqsyZoPUhIVlIW
	 PaDjZTsPjpgTuph5MRb4EG1aI+euJtVc5TGVRFCYPanKLkpzsdw47dM8nd6TN6zX4p
	 9jn7J0oIuXnCPNDm0Fc2Lom0Y3jy39cfrYIuI9/qIsIDk3AXbMjrZX5DWDTMjLQS9h
	 sZ63gJKAFNwSBq18rcOfWMGcyXHNyhlkBimfq+TalqSdALFOvJuC6hYKJqcyQkYhsp
	 IkMrbPQj/7pfRzUVSNc6g4+1vAPJXkggr6wu3pEFJJXL6gfpe7njGQNzBCXwwGhcZ3
	 qsn7d1IQ7kJ+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2312FC43333;
	Mon,  6 May 2024 17:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: L2CAP: Fix div-by-zero in
 l2cap_le_flowctl_init()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171501482813.13196.146367594390490315.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 17:00:28 +0000
References: <20240504192329.351126-1-iam@sung-woo.kim>
In-Reply-To: <20240504192329.351126-1-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: luiz.dentz@gmail.com, daveti@purdue.edu, benquike@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  4 May 2024 15:23:29 -0400 you wrote:
> l2cap_le_flowctl_init() can cause both div-by-zero and an integer
> overflow since hdev->le_mtu may not fall in the valid range.
> 
> Move MTU from hci_dev to hci_conn to validate MTU and stop the connection
> process earlier if MTU is invalid.
> Also, add a missing validation in read_buffer_size() and make it return
> an error value if the validation fails.
> Now hci_conn_add() returns ERR_PTR() as it can fail due to the both a
> kzalloc failure and invalid MTU value.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
    https://git.kernel.org/bluetooth/bluetooth-next/c/93e31170f4d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



