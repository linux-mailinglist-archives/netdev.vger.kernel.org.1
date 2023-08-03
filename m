Return-Path: <netdev+bounces-24174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2A76F187
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A679C1C21632
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BB32591D;
	Thu,  3 Aug 2023 18:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F142517A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45752C433CD;
	Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691086228;
	bh=Edj37ZXAi47TlAn4TH5nabu1ETrkr+hlACL2kN9s3dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H4K+1oxO/Hz1ej7ljDwUGNJ756hzrryx4QOD10HKeGBOsBbpoWBDITD8nkNxg5Jgk
	 sj8p75bpH1JOTXKjFaJNvqQShC+QVcz8SbobrIHePG9BXZTBjb2pOe7RP5BjofdZZb
	 T+w2UlXErt7jyUOzIvRzg/bHxr1+vNFIDki3PwnhJWjoIkfjYhXUKUIxCtKLZKQmrQ
	 TTJFRB0pxY9BFSMOCeEuo5QfM/vz6UbAHg4CTUDMyKqSwWFFaRgaWQnjk7ue8w21sQ
	 6sf4+mF0sDDDuR4ZQ9a3mIJXTXJeURC5hBApaiHqU1zRZFdg7aoPzlX+FWDdSt7xls
	 861zlAffnuXRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E7BEC595C3;
	Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] test/vsock: remove vsock_perf executable on `make clean`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169108622810.23543.9767560286083111967.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 18:10:28 +0000
References: <20230803085454.30897-1-sgarzare@redhat.com>
In-Reply-To: <20230803085454.30897-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, AVKrasnov@sberdevices.ru, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 10:54:54 +0200 you wrote:
> We forgot to add vsock_perf to the rm command in the `clean`
> target, so now we have a left over after `make clean` in
> tools/testing/vsock.
> 
> Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
> Cc: AVKrasnov@sberdevices.ru
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] test/vsock: remove vsock_perf executable on `make clean`
    https://git.kernel.org/netdev/net/c/3c50c8b24039

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



