Return-Path: <netdev+bounces-83873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F7894A81
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635141C22169
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8881317BBE;
	Tue,  2 Apr 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBtRDyoD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB82581
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032228; cv=none; b=p5Wr+oYV9URUTibhttRIOjdMY+89SBs0iEinK1pB5nAo93f7jBP83cZGo5N+KlbjcXmhadkvuWMMEr9qe/P+bdPp8cdOkw74SpuyTkONXPJ13FHKgXX4UrwbIOBFv4bGnRx5lip43vsDQ98tF8iwu8CA6w6/ABZch6baIblalq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032228; c=relaxed/simple;
	bh=TytNeccNPRMQ9Z9frVfq7t/WypP20BLAhISOR/+ilTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pr8XgqB9uua37pBzfUiUtPA5QXlGp05vxgKdd3YZ88DrprpLA0PEp+A1qcWWJUQwiVPkJGBjfbdIZqsgEnQL8apmeAdscFAproHERq7T1sHEavd+IGrdEwG9goRVsQJNIhSYpmacsJrTsDwEfBnnTOiW+Ea6LvdYMvU6ji8WevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBtRDyoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E62E2C43390;
	Tue,  2 Apr 2024 04:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712032228;
	bh=TytNeccNPRMQ9Z9frVfq7t/WypP20BLAhISOR/+ilTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hBtRDyoD6F9vL+Z3CSwHhyrPCbIsmL4ydJU3Xo6hrdTLEIG5b1HKXNJ82Lwt+DvBa
	 ZWV+OPk+xUDZBX+n/qtrcXJyS96tnqpssSANX6/dhQpkgC1yeJlprGN1uXt1mctx9N
	 QEeiDPMV45KEs9FPRzcez8dQ0aFkoQ8jJgZUBdAsd+rtVGERI9DLIpo5K2UBGqau2D
	 dSVhQKlLMq4Py7KL+LSZMiIEnF0IASPU7ciPczYFn7potymB/1OEuzVCjC8h3D15T7
	 X8e66uA2ItoJeJ5IKeZbEac+hVcn4f5bya0/R9TFRjRLIj7F85MeVzXXvNQ+Ov7BFF
	 1T8vMrthRRk+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D664FD9A158;
	Tue,  2 Apr 2024 04:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] doc: netlink: Add hyperlinks to generated
 docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203222787.2159.4728287638491637586.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:30:27 +0000
References: <20240329135021.52534-1-donald.hunter@gmail.com>
In-Reply-To: <20240329135021.52534-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, leitao@debian.org,
 alessandromarcolini99@gmail.com, donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 13:50:18 +0000 you wrote:
> Extend ynl-gen-rst to generate hyperlinks to definitions, attribute sets
> and sub-messages from all the places that reference them.
> 
> v1 -> v2
>  - Eliminate 'family' global variable
>  - Fix whitespace between functions
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] doc: netlink: Change generated docs to limit TOC to depth 3
    https://git.kernel.org/netdev/net-next/c/4cc1730a90fc
  - [net-next,v2,2/3] doc: netlink: Add hyperlinks to generated Netlink docs
    https://git.kernel.org/netdev/net-next/c/8c1b74a26d96
  - [net-next,v2,3/3] doc: netlink: Update tc spec with missing definitions
    https://git.kernel.org/netdev/net-next/c/2dddf8aaf67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



