Return-Path: <netdev+bounces-120779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C395A95A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E9A1C22D80
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBD79C8;
	Thu, 22 Aug 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHM+AdoT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD056FB6
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289033; cv=none; b=bIs27g7hF4cCypXAMkT3H/gBQBKwg4L6g7WUQAWMJGjptpQogwFMZbpO7Cphal7RT3Jz/0TZF9ZmNC3HBugLrWD5dhJ9WsRFTInGzYi5AV9iDANdrqcSwBYYvdc2TK1Yj7P2aN3boaH6RG8Alb4vxoI39ZJ5Qqwmx9nc4yl8AqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289033; c=relaxed/simple;
	bh=8kncyYZaCexd72MxE30iwRSzaBgr+nVPlrPNMAr9YhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gV/x1NhjkZdfnzG1yWFqCJcW23BEiVPzPWics38gc6vA8+5/E//HkyahSNA/oVHNL/42Z4injJSnyO2Gn5yVO4hfbaNj9w7sYtqHRwATVE96ZpgZARDR7oMco0HhWX8fOGuCpvrcRpNPuGNkAiYxQl1R8zog7E/nMKGT2RzVuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHM+AdoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E25C32781;
	Thu, 22 Aug 2024 01:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289032;
	bh=8kncyYZaCexd72MxE30iwRSzaBgr+nVPlrPNMAr9YhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nHM+AdoTRGi9SUC0KOaMJ7YvN5qeps7W/yY+MoH6T3zDwGfy1RKaS+Cj4fYyKlamN
	 4YAbgQ6x1pp/xla9sU6fX9g4Jrdw2K1IoCIHSvKg42QbryWC9iFcS4958UqRfXX9LN
	 Jwwcag2j2V2urUjyq5w2a+HcQRtIVMkv+Ch8LgCzHnfwRDwJz87rDN3EmQA4bbrxS5
	 QNgKsVR/EPvIx1S8838BnRHSP+5Gj2aTKHwmCKhL8V/3aS2K2eJeX8VeZ5dN4+z3m4
	 NyzIhCY9hwMOAVWbbuSRUQhdiUCuDJfC40mWxncc+eJrqPQ1Hm080UEtfMe15JuH63
	 O6KhV2Bt1IV/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEFC3804CAB;
	Thu, 22 Aug 2024 01:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428903223.1877102.10634302904510875141.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 01:10:32 +0000
References: <cover.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
 madhu.chittim@intel.com, sridhar.samudrala@intel.com, horms@kernel.org,
 john.fastabend@gmail.com, sgoutham@marvell.com, jhs@mojatatu.com,
 donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 17:12:21 +0200 you wrote:
> We have a plurality of shaping-related drivers API, but none flexible
> enough to meet existing demand from vendors[1].
> 
> This series introduces new device APIs to configure in a flexible way
> TX H/W shaping. The new functionalities are exposed via a newly
> defined generic netlink interface and include introspection
> capabilities. Some self-tests are included, on top of a dummy
> netdevsim implementation, and a basic implementation for the iavf
> driver.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/12] tools: ynl: lift an assumption about spec file name
    https://git.kernel.org/netdev/net-next/c/f32c821ae019
  - [v4,net-next,02/12] netlink: spec: add shaper YAML spec
    (no matching commit)
  - [v4,net-next,03/12] net-shapers: implement NL get operation
    (no matching commit)
  - [v4,net-next,04/12] net-shapers: implement NL set and delete operations
    (no matching commit)
  - [v4,net-next,05/12] net-shapers: implement NL group operation
    (no matching commit)
  - [v4,net-next,06/12] net-shapers: implement delete support for NODE scope shaper
    (no matching commit)
  - [v4,net-next,07/12] netlink: spec: add shaper introspection support
    (no matching commit)
  - [v4,net-next,08/12] net: shaper: implement introspection support
    (no matching commit)
  - [v4,net-next,09/12] testing: net-drv: add basic shaper test
    (no matching commit)
  - [v4,net-next,10/12] virtchnl: support queue rate limit and quanta size configuration
    (no matching commit)
  - [v4,net-next,11/12] ice: Support VF queue rate limit and quanta size configuration
    (no matching commit)
  - [v4,net-next,12/12] iavf: Add net_shaper_ops support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



