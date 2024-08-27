Return-Path: <netdev+bounces-122117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114395FF1E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD7F1F22FA6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8C101E6;
	Tue, 27 Aug 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UID67CP7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CF17BBE;
	Tue, 27 Aug 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725832; cv=none; b=kY7RihQusPxq50uNCPX63dvUowvVFr36FCZRQC5pwZ599yRrZxN2BfpNMGPvkL4P/m538umJqAEde+r4uVIWyZb2OUNflPdb/cYAlxhajKSCXO4gU8ROS/srfa5EfNr2rS2m5u3H4EykT31ZForSkfrxy1Yv6/ypwsc0HI7q7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725832; c=relaxed/simple;
	bh=96aPBM1prgnl1Trwv1kDI7urETSSeh6JFCVzKGEBwOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JULQdtlWhLIf/TwnllgCwCv2SsgokJXcqgGaiJv/JFvRL8XPzmiS+IvdqLrT1HnUgDe1OXjuY4B3xw6Vkc85rooEisA6VGsLRFvE7vxV2d7kUyWsYzurueTDt4NSdFu80jO/3swCdRJ6UMI5r+oPpbt+wZ9c05sIakCopTYrSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UID67CP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA728C8B7A4;
	Tue, 27 Aug 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724725831;
	bh=96aPBM1prgnl1Trwv1kDI7urETSSeh6JFCVzKGEBwOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UID67CP7WsLrT3RsC/iK+4OOP992y+UqZ2MwdiSGm7zt9jaKcN/cy4qWxVGCwcdB0
	 0nzrTyZL2kgZBt0lVURgJps+vzb4YGdpDdcYBNL9ClpPplKK2xJYSuTgy/pSiMIlwl
	 ZPLEndwMnzmrMJSBkalIkKAPECxF1FgerWTOp8ZlU3go3W/QgaH87N5S22U8st8SXo
	 u698FDFS/GvTzTKGvkilRj0wmnw682ujMP52OhBHZOs3srGxRBJYdq+6N0DonplqUi
	 rfnkPwae+4dm3ZqRUT+DTBOYeX/87zAGZ7CkFqEkwKin+39gJ1RGaL5sZVFnesaT5W
	 xd4+8BFiD/5hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E523806660;
	Tue, 27 Aug 2024 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Add Embedded SYNC feature for a dpll's pin
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172472583073.186086.6173747037683312916.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 02:30:30 +0000
References: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
To: Kubalewski@codeaurora.org,
	Arkadiusz <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 00:25:11 +0200 you wrote:
> Introduce and allow DPLL subsystem users to get/set capabilities of
> Embedded SYNC on a dpll's pin.
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> 
> Arkadiusz Kubalewski (2):
>   dpll: add Embedded SYNC feature for a pin
>   ice: add callbacks for Embedded SYNC enablement on dpll pins
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dpll: add Embedded SYNC feature for a pin
    https://git.kernel.org/netdev/net-next/c/cda1fba15cb2
  - [net-next,v3,2/2] ice: add callbacks for Embedded SYNC enablement on dpll pins
    https://git.kernel.org/netdev/net-next/c/87abc5666ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



