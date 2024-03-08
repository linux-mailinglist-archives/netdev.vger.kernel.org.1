Return-Path: <netdev+bounces-78591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B80875D5C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7FB283B5F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94AA2E832;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4EeYdmP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E982E633
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874037; cv=none; b=RSvjdOztwmdSCE0wtZVHZbFtCYN1MAemz69/5kc6vyihIJQrToHT/wp1oHtLObvnGzc8Cqovq7bjYMNiGsJv4wQovVoykYHW+xX5pHGI+HezKLATqZeS+7ODyUf1K0PG6ZsmMdOc+RHm+LhL+FR5nyqGPLQHmHObhwl8XCftSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874037; c=relaxed/simple;
	bh=cE+F1Jf5tH6SLAYPQ3zCyX63V//LMt8FP9uN6r4x/X4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fKCT/2XhLasSOT0zPgmvX+UQS5IGBNowk6NTe9hGyVZ7uPstj9/ojUafK7BPj//lHLp67FV0KTs83Oa+ykEzUZAoQmZZEzl0rDn+MsYRNCJlR8SiRLxZwJaJRfe2Is3F3pWBk8MNsOFv3G7zcL7DLivBv8FsLmkxp0xVWnvMD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4EeYdmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A92CC43390;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=cE+F1Jf5tH6SLAYPQ3zCyX63V//LMt8FP9uN6r4x/X4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A4EeYdmPiu6BHEwo3UmbrbLdl2zy6FWvz1S1gYnCWHm2jwzcH5dTUam0+YxmhvYw4
	 IexfSSjfp0NoVV+SiPDQkUf4ObPGzsiZkzj9NAFLbBUDVwPx7Khhy+vZoQqZjZb0Ji
	 9Ll2b4TzeTCAojpv1DrGVzG5tPCvxMpwAm/3Ds9CAFpzFwt2pw8TNpLBKEqNPt4XS9
	 RrRshif7l4GjfujbUpe4Lya+QWzQ1iq4/eCruWgK/xO2eZ8L6mco/xPGGfmOyFCVED
	 GxGAJ762D9zXBLI8nHRAS93A8oTinaH8rhFmA8uA1XfLQoQDKj8xD4gZKX0EptjXTl
	 oml6oAevhDrZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30F58D84BDA;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] tools/net/ynl: Add support for nlctrl netlink
 family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403719.8362.3858488476279704879.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240306231046.97158-1-donald.hunter@gmail.com>
In-Reply-To: <20240306231046.97158-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 23:10:40 +0000 you wrote:
> This series adds a new YNL spec for the nlctrl family, plus some fixes
> and enhancements for ynl.
> 
> Patch 1 fixes an extack decoding bug
> Patch 2 gives cleaner netlink error reporting
> Patch 3 fixes an array-nest codegen bug
> Patch 4 adds nest-type-value support to ynl
> Patch 5 fixes the ynl schemas to allow empty enum-name attrs
> Patch 6 contains the nlctrl spec
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] tools/net/ynl: Fix extack decoding for netlink-raw
    https://git.kernel.org/netdev/net-next/c/cecbc52c46e2
  - [net-next,v3,2/6] tools/net/ynl: Report netlink errors without stacktrace
    https://git.kernel.org/netdev/net-next/c/771b7012e5f3
  - [net-next,v3,3/6] tools/net/ynl: Fix c codegen for array-nest
    https://git.kernel.org/netdev/net-next/c/6fe7de5e9c08
  - [net-next,v3,4/6] tools/net/ynl: Add nest-type-value decoding
    https://git.kernel.org/netdev/net-next/c/b6e6a76dec33
  - [net-next,v3,5/6] doc/netlink: Allow empty enum-name in ynl specs
    https://git.kernel.org/netdev/net-next/c/bc52b39309c3
  - [net-next,v3,6/6] doc/netlink/specs: Add spec for nlctrl netlink family
    https://git.kernel.org/netdev/net-next/c/768e044a5fd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



