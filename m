Return-Path: <netdev+bounces-191253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C0ABA778
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199C77AB6FF
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30155A79B;
	Sat, 17 May 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGpwtYW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187A8C0E;
	Sat, 17 May 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747444199; cv=none; b=jFp/K+qMLmMMmGoACfUwr7JRxqoW5wUdNT3v+ZxoxcpBjRjDLrEM6Z+em3Xheil6oQt9bTeB6xQtjbgknUqQ646IgjAiwTn7IAxZ+vAOYIBIDzGC1ZK0472TjCWzBkhB8KzziG6MIMRAGBqf5PrQD51VTMkyKDb13wdKxbCgKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747444199; c=relaxed/simple;
	bh=eHv3aNvDH6EZV2LpJqpEw7wsPLVez85hGUCRZIqhT94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9fqxZjQWDwueryzjQu75cxq/6x1mkFPIhsiKLvc/KyiIRU+iWNAuMnkxGPluTlvHeYGrcBD8UTPRfLlyimTr48wmTeGOeuZLd1UMkAFfhYNKj6ndzUIlS1ijqSBAk584vsZppaWRl0m8QVj6QVq/wzl3ixB7YMhSXihKRS6LgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGpwtYW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5A1C4CEE4;
	Sat, 17 May 2025 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747444199;
	bh=eHv3aNvDH6EZV2LpJqpEw7wsPLVez85hGUCRZIqhT94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RGpwtYW2Z3Bx3X6pQZo1IVjaCkH385jarEyzFajPVzNBhIBvzlLJGAn1vYHr9Wc4Y
	 1Yx8fDqxplDhsHErNXR/WUGplBQtzsrEzv39sJeDl6+DD7YW7hCynRmDFw2ZA5ROld
	 aPVMucbsaYWJ8DdTTqaiGrvGEzSzUH7Qr3TyT5lnRCTLQKEAOQkSDcX6vVizPjpsGt
	 YJBT9ZT6VqnmtE3is1Wqexictg471yQEcvMxJcGjr23TUt/e/91BYXJoxuds5EFpWH
	 eIasMiAZjxF+GPWudyPUlybKbdTGqD1KqUMja+dp23/ZZze4tniE/qyLmDA+wvjt9C
	 UatslLHA3YjDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCA380AAFB;
	Sat, 17 May 2025 01:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] vsock/test: improve sigpipe test reliability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174744423548.4114923.6817552161649997971.git-patchwork-notify@kernel.org>
Date: Sat, 17 May 2025 01:10:35 +0000
References: <20250514141927.159456-1-sgarzare@redhat.com>
In-Reply-To: <20250514141927.159456-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 16:19:24 +0200 you wrote:
> Running the tests continuously I noticed that sometimes the sigpipe
> test would fail due to a race between the control message of the test
> and the vsock transport messages.
> 
> While I was at it I also improved the test by checking the errno we
> expect.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] vsock/test: add timeout_usleep() to allow sleeping in timeout sections
    (no matching commit)
  - [net-next,v2,2/3] vsock/test: retry send() to avoid occasional failure in sigpipe test
    https://git.kernel.org/netdev/net-next/c/135a8a4d25a2
  - [net-next,v2,3/3] vsock/test: check also expected errno on sigpipe test
    https://git.kernel.org/netdev/net-next/c/3c6abbe85bcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



