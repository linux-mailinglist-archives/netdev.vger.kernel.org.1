Return-Path: <netdev+bounces-110223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAC892B60D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55579B20B21
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3F14F138;
	Tue,  9 Jul 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMExDQ6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC85146D53;
	Tue,  9 Jul 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522830; cv=none; b=aM8WDzcQeOHlhUuSoZxAnmm40xBiU6BLgWI6yNUTN73Y9NlYkKpGmiRgoJH77dNuedIDFOrNfoKcg+EBNtmOngRzmP7MOCr2yBdwXmIuj3cZzbMINwKqTLhu63yrGXKewoV7WYDhVUmHwal2tD86wdk1M8oog6df3XQEdo8hZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522830; c=relaxed/simple;
	bh=Q0dPZCvbfhUYOkbkFi5y6s3AsoY0e8nz1VTs8LhwtPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iba6RQ//BmWnXjfHdI+EHSkulMqUvClOQZ8v045NYLkP4zsSauULUKIbmODLksqaLUZgQSGBtyEvNUwXlJb5wQx3Y8mQVtcyiZaHrloZmOKaLlUBxu1vgwotgTuxpzYPh8KjaSkdCmC2PAZCHLEPIROt/NHdGW5enMWCdDz8iVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMExDQ6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E33CFC4AF0C;
	Tue,  9 Jul 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720522830;
	bh=Q0dPZCvbfhUYOkbkFi5y6s3AsoY0e8nz1VTs8LhwtPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rMExDQ6P/6bjaeSdSRMhLBPH1oo2EtL6JK+seuat5VKoCISU1PBUnz686H9CLzSqf
	 O8gphX7z8ydWgH5AQIDJmSFxw8ZNUExgut0EEt8EDv1YAR3H28BKLddo/+YGVXOmxp
	 p3DTcmM7EF2aL/5ZQpdWvRmA+E2wGTYKVxZ4Q1ASCngJjScks01UK4NIZUC912jIgx
	 XYv6miakCiYKVmWj6O/lJSPQLjxOBKW3Pg1iXUBirQQtlMJHFALhGwzcspHgy1iQyZ
	 kv2uRuIVGwopjI62d6JRfx7jDPQ5cWRrLB+l9IEDG9JzQhtCt1TDLZXc4yPEsPmEvf
	 iCLlLfRLnn3RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D126CC4332E;
	Tue,  9 Jul 2024 11:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Fix incorrect value output on error path in
 rvu_check_rsrc_availability()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172052282985.30718.7752224049592096233.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 11:00:29 +0000
References: <20240705095317.12640-1-amishin@t-argos.ru>
In-Reply-To: <20240705095317.12640-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 5 Jul 2024 12:53:17 +0300 you wrote:
> In rvu_check_rsrc_availability() in case of invalid SSOW req, an incorrect
> data is printed to error log. 'req->sso' value is printed instead of
> 'req->ssow'. Looks like "copy-paste" mistake.
> 
> Fix this mistake by replacing 'req->sso' with 'req->ssow'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix incorrect value output on error path in rvu_check_rsrc_availability()
    https://git.kernel.org/netdev/net/c/442e26af9aa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



