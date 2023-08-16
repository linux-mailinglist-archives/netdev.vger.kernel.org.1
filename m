Return-Path: <netdev+bounces-28029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E36577E029
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0561C20B0A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE77C101EF;
	Wed, 16 Aug 2023 11:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038A101C8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 11:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A762C433C9;
	Wed, 16 Aug 2023 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692184821;
	bh=qs28698+mtwFgSZcHmVgBvbRDFxRzHblu8MhBlTqf7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W41jAqKrSoi6ELp5kGJmqP0HKTVEIY1HM8ysEn2Is7IVKANY9DwyCwH43BwZzHues
	 kd2TtwaK1Uwwh4lAFt80ADRsxcEt7etX3YcVmfpi26bn6aTONfOsw7Z+sEwJm6Lhmk
	 QWPk6IbZ02la6Bi59h/kNNCJEOJendVm2W59Ji5cVItFu8xo0mPMQPgPPlzBpE4lf0
	 ip/2xOA0zVJrVa/0NElDaDm19DPbR9V3qF62shaoihNUULkAlRe2jSJUhMwsb7V70h
	 iLFeE5ElygnWwpCofLRbhtK/vIYk+7boGrIHulMwL2d4VDcLjoMaRUmnUk0AFq1k17
	 cIRvlrNG78HEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 007E8C691E1;
	Wed, 16 Aug 2023 11:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfp: update maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169218482099.22753.9965818779603417474.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 11:20:20 +0000
References: <20230815124325.14854-1-louis.peens@corigine.com>
In-Reply-To: <20230815124325.14854-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 simon.horman@corigine.com, netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 14:43:25 +0200 you wrote:
> Take over maintainership of the nfp driver from Simon as he
> is moving away from Corigine.
> 
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> Acked-by: Simon Horman <simon.horman@corigine.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] nfp: update maintainer
    https://git.kernel.org/netdev/net-next/c/7fd034bce6d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



