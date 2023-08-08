Return-Path: <netdev+bounces-25620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007D774EDC
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6551C210AC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E537171DF;
	Tue,  8 Aug 2023 23:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553E1802A
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27924C433CB;
	Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691535622;
	bh=+3PAhwcO5SkftV4Z9RzQcn0DU4daMBjo3PN9QdcSRoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CLLVovkMCLtAJvaacutreZ2MMuycBuoiTlUHbPfRTS8aod/RqX8WHbQBc6raLrbzs
	 H8bDYzNykmtQ6WKyn70lo2bzJYCC8rW9jno/ylZT3/AzaAuUcZm2pYubVHahdNIBt1
	 nie1CvfUqQObbS86N6zkFz98ItnjDluz8IwUFK3TbHKbLmJ3BJmmJYN+gnmRzd8D22
	 95YqnYQ73K0xOhLiYj8KybI43I3C87wNkv1LvHljtXTjt7WCUGHcUc0DBbcc3EtmsJ
	 T6bnx+An85XW9z6F3olBX2h63woCC9yzKk458y3S9HmMCAE+CkUVvtjnZegil/aA4S
	 W0PEYKdlOL9pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08DCCC64459;
	Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153562203.6878.1667103889649969774.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:00:22 +0000
References: <20230807071022.10091-1-hare@suse.de>
In-Reply-To: <20230807071022.10091-1-hare@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 09:10:22 +0200 you wrote:
> When flushing the backlog after decoding a record we don't really
> know how much data the caller want us to evaluate, so use INT_MAX
> and 0 as arguments to tls_read_flush_backlog() to ensure we flush
> at 128k of data. Otherwise we might be reading too much data and
> trigger a TCP window full.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> [...]

Here is the summary with links:
  - [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
    https://git.kernel.org/netdev/net-next/c/ba4a734e1aa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



