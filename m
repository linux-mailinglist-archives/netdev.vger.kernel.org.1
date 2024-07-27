Return-Path: <netdev+bounces-113324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522E93DCEC
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 03:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43F2284EC7
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C900394;
	Sat, 27 Jul 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6nuRtJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E715C9
	for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722043833; cv=none; b=Ue4hp+frLBj8DS9vn1Ggc1xWcWB0X8JSfu6NSs4HucyuYpt9TD3kWzC0Vsl0TUySgdp9Rbl65Nh4y/frmTD/XcS3BczJnD+Kc72osDkszuVJdbkS8qjWJ6fWPlyTGK46HIErdjt740MXIZwaDiR1zfBFWlgxQKVIF53thD7xsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722043833; c=relaxed/simple;
	bh=XguecjtcLvq/6+g2wUKFm/r+cwxWO28BgvZn0o1x2vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GKP2rz7CHg31plG/U3WrGWDTmrgByrTsmJ+hcbzlgGsIYqYbsZRCb/9VhxYkBJC269O8z1HjucaLRkkXuNN1rNUzOlLG+gWC0eP1AUxYfD0JhMyCeB4nhyu0u3HHTh8zh3j9jHDSyBq12oB3GzzNSI2U54OMRDmxtyCGGW+C7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6nuRtJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DCFCC4AF0B;
	Sat, 27 Jul 2024 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722043833;
	bh=XguecjtcLvq/6+g2wUKFm/r+cwxWO28BgvZn0o1x2vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o6nuRtJyP4rYmU9TOfy4vkCnj4PRMnHRh1OVr8nZnYuirPHWlSdZno2xUtrfR0a2R
	 2OyMquAqnJ/cVX2DVbejInvqAFSLGBbvUXVsDSQj3kEz4eHwYsP99kn5oDWnKItOVC
	 oB7rN376A+l3XErk2i8DcJBUGIqUgZZw0PdySiGsvb7KzwrKMQdsnquhnmhuJG3k/f
	 lFQyM5w4/tVuPq1sfOCz3fw90HFFDEKbj9OKi8TqILVNRdLdkNk0w23jxRDD7gauG1
	 TPQlDi2QdvQMm1UP2mG/j8qfHZe0g3jRGjfY/4ryO2erT51G7GyP8hMcKCLdw+FWj6
	 TpSooPJg3Y+Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E3A6C43443;
	Sat, 27 Jul 2024 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] fbnic: Change kconfig prompt from S390=n to !S390
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172204383351.20059.8091169109308298292.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jul 2024 01:30:33 +0000
References: <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jul 2024 10:03:54 -0700 you wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> In testing the recent kernel I found that the fbnic driver couldn't be
> enabled on x86_64 builds. A bit of digging showed that the fbnic driver was
> the only one to check for S390 to be n, all others had checked for !S390.
> Since it is a boolean and not a tristate I am not sure it will be N. So
> just update it to use the !S390 flag.
> 
> [...]

Here is the summary with links:
  - [net] fbnic: Change kconfig prompt from S390=n to !S390
    https://git.kernel.org/netdev/net/c/697943657444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



