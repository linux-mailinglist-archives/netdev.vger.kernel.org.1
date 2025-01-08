Return-Path: <netdev+bounces-156120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A79A0505C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C1B7A06AD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48BF19D884;
	Wed,  8 Jan 2025 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHm0j8JI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBC166F3D;
	Wed,  8 Jan 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302219; cv=none; b=iwyOk2kAM6Zh46UuXgqd5KHdgjn9fStCRnpd1jxkyXx8KoXrsU6PkOueI6WPKLvhxImOxPKeSamR3p52YmLzn4d7M4lOL/4Ha3fj32rqPln7iOjQJudGjew97IVTAm0wCgIm/HhAgAnvdW4FO8AN+9cxAXUSpB84Zg/aIFV5TDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302219; c=relaxed/simple;
	bh=zbi4gjTmy/ktub0hEOpA9+DNfAjJQzy3E1tq2ui7t7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqGoa9E0PQ909xEg31JhVleDyLV3knUZZucsx+7A+QvRze8zvoiu17IYrg8fn95qZpdLFjSMWbnp2N9suKWhsqkSLcasJjZ4I+UfStbE7UOHwcUA+mzANpqTK3CYxIir6xd4sQrG+sZrXldESKZruHLKN/W0pBJEHD2bDIF0HZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHm0j8JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43024C4CED6;
	Wed,  8 Jan 2025 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302218;
	bh=zbi4gjTmy/ktub0hEOpA9+DNfAjJQzy3E1tq2ui7t7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GHm0j8JIggSCnDSBqKUtTKKmhqP4mQRlamKSaxcJZUGdMx25bOb1gY+xf1FvmNr57
	 TB5TRBbDwesvIpTpfVOd2KP+poonS/WcIj7UZ2IQy8JJenSyzaTf/tOmI1dta9NsJz
	 t/RuGyVqPhHVJKokH7fTUG9e7EIXM/Bl5TBnknOtbKyHpx/FJnlU2qEbmJhzS8dYBy
	 7MMVjrq+Grl8LbOHmzKUbpmJLbwewDy/jsbFRyr+bvC33ckTaBrfBnCGxkZXqkNZZo
	 Zy16RnpDsr6i4UufdoUc25F5iC8nd8FoE/2LASNDPSwTNrPeMIrLQ36vc/qkf/hd4p
	 Pi/Hz4QU92iOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DC380A97E;
	Wed,  8 Jan 2025 02:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630223899.165659.5290302899760343345.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:10:38 +0000
References: <20250105122847.27341-1-linux@treblig.org>
In-Reply-To: <20250105122847.27341-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  5 Jan 2025 12:28:47 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
> commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")
> 
> but has remained unused.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
    https://git.kernel.org/netdev/net-next/c/4ce1aeece911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



