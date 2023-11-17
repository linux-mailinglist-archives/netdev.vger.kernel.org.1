Return-Path: <netdev+bounces-48530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6277EEB0C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F3F1C20947
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D07649F79;
	Fri, 17 Nov 2023 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFJlyho9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D081CA56
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 02:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F0F6C433C9;
	Fri, 17 Nov 2023 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700188223;
	bh=Bi++G3J2BXlCQbqHWLtl+LNBbMJokVdqsIbgDw3TS5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KFJlyho9HYAGTezuDY/KGiPEppGTIqsON5prVvh8nVs0EiSVbTeypHQtCRQH1gSV6
	 hg8IQ4xL5emrLgW7wd3j/Xqs0Aiq+iClKEoHJEVzSp3YuDXTDLn1awSAVqVjEvN5CI
	 SmUHlqfLf/x4EwQucrhu6DZ38M+QGUmlEpVuD6lTLZ4sBR163PxqcCwSXtNiSkdwwc
	 bOlvu+S5GXNZdDSuR0FypPfRDgYNHWz1VKghZh9Abx75g6FiOAnsm0c3zQFkqFij48
	 laZllMaA+eZgHQYeCFFuXDERGuMnUpZt4P5+8n7c/8uFyiMd5+6zBvpYqdXjtdoxTJ
	 UoSpyvJ8j0oog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AF73E1F661;
	Fri, 17 Nov 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tipc: Remove redundant call to TLV_SPACE()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170018822349.19040.6248661340876085947.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 02:30:23 +0000
References: <20231117003704.1738094-1-syoshida@redhat.com>
In-Reply-To: <20231117003704.1738094-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 09:37:04 +0900 you wrote:
> The purpose of TLV_SPACE() is to add the TLV descriptor size to the size of
> the TLV value passed as argument and align the resulting size to
> TLV_ALIGNTO.
> 
> tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
> tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
> call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
> redundancy.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tipc: Remove redundant call to TLV_SPACE()
    https://git.kernel.org/netdev/net-next/c/d580d265e9ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



