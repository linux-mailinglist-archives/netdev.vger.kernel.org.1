Return-Path: <netdev+bounces-90619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115538AF470
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5B41F25DA5
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248DE13D254;
	Tue, 23 Apr 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnKJEgvr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F401413C67E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890429; cv=none; b=gJ453jmIyZXh+VNZNKYyl7IHVYMdqZLWn2J/IXbOR3E5uOA55w6+hNJwxtjTfwpC3XGkSxOkDGzH/vBFCHBnQMtczIAvcK6y/i8qmRZoq4RHJfp1/2u8tboG15rXYpCLjBk9QYG3J7/hW0y1oN6l4nJk7VmopdRvMRywAneSvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890429; c=relaxed/simple;
	bh=LwP+4om0NnyGjYJrLCCIWkevDzv+V3DQ9PgzZJzMykA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SkiHEDHW7jTxaiNr5ErQTftPNzHPZv1y4EDAqzqXHMaVk/3qT2biYzY8Bn9NRyLka6Lyvp3iL5p4sLGfAUOYBW2qKPmSpo9G6Gd/28kIhhDoXRnOYrb8uI44WlBQwkSZYM/CVrKbpr07+oRabmvLNj50n5+cyJfzKMySJ6QvfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnKJEgvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9C03C2BD10;
	Tue, 23 Apr 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713890428;
	bh=LwP+4om0NnyGjYJrLCCIWkevDzv+V3DQ9PgzZJzMykA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XnKJEgvrvojt+KbsVMUhLtC12+NEZIVDtckiCJsVh23TQISAAZ0rTJtJMfOT1tO0E
	 VJQ5tHOWsoO6N3higk0Mt4LUI+e3eUsFIRMhGPaHYlWJiBeq9rDQAWuieFvPwmXiXU
	 OP5dNmTHvihKt4WMSfZRRdHReLGq3okGJwpuxu1YsXP40Lh0zkUpJwir+/BNyuTLA8
	 pe55ytxYlteKTPsNlZN9Nt87rJhWeA2MY3oF2t84BcEzJYpliaaNcwC5iE112vg7cY
	 kLY+QUq7KKSW4tyyxOmfEfsBKb9ePx2V7b1dzOXYYfgZoTKK3t7o2E1Hyh4SH5fyBc
	 EuMmCkf7vXjSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B51ECC433E9;
	Tue, 23 Apr 2024 16:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3 0/2] PFCP support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171389042872.6422.8127722613150421621.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 16:40:28 +0000
References: <20240422120551.4616-1-wojciech.drewek@intel.com>
In-Reply-To: <20240422120551.4616-1-wojciech.drewek@intel.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 22 Apr 2024 14:05:49 +0200 you wrote:
> New PFCP module was accepted in the kernel together with cls_flower
> changes which allow to filter the packets using PFCP specific fields [1].
> Packet Forwarding Control Protocol is a 3GPP Protocol defined in
> TS 29.244 [2].
> 
> Extended ip link with the support for the new PFCP device.
> Add pfcp_opts support in tc-flower.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3,1/2] ip: PFCP device support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=a25f6771bef3
  - [iproute2-next,v3,2/2] f_flower: implement pfcp opts
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=976dca372e4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



