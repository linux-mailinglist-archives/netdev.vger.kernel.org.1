Return-Path: <netdev+bounces-148195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE19E0CDA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C10DB62BA1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AD1DED43;
	Mon,  2 Dec 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdW1db1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB81DE892
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168416; cv=none; b=KtAB3AkdE+zPUPGwtYzC+OiqAlZyuFK+jn+wXcJ2rPQnJlRB4puhG7eqPYO0CoP6Yq2mAd5oH4BZlx68d7pBws5Iez58Ps0ktAwYaZM91/Y39A/5oM4weIp0GC4qhKbP3WvKpSBjdgcLS2hDF17m0iwb2mW3PkwrA5xMADZMWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168416; c=relaxed/simple;
	bh=MWNMEx541rbIira25ARvpf52Xg0r2SZpop79eE2yHBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MGTdYR+imikClbyWs+NYn3zeUSNaP3gJuLzsC6ZfmacWHAkyR56IaSu1ih25hiOdOStJOOGjip6+a3NqQRIzsxdiBut0Z8tcMVeKEKOBPb+qFDt+f64heKfbf4i5FFbLiBXAP5dNFHDr5LLMjYu2UPBqa0vE3g+0JD+NlYgkJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdW1db1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618E5C4CED1;
	Mon,  2 Dec 2024 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733168415;
	bh=MWNMEx541rbIira25ARvpf52Xg0r2SZpop79eE2yHBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LdW1db1U+f3PYy+x6yOUIvke/mLGbKtf1Vzyw3Ky0UIPQMYTBIMqhRoF9Wqg09hb7
	 bErCmwEl06Uty2Am2Xak1KsX225Sqt4viNegzJ62muzx5mfTmgYex3ab5RLnEFjBCl
	 aZt7CnhzezfLZN/CEQS9z0QysXDmIYAKt5+PyL1Saof+Hrq88cOJJ+ZdQumqCTeC80
	 H22E+v76qoSccHGDG6l9viUUwXEq2rRKdd8Hy7RXkdP5VI0YzugQqVawCd2IVJRaZZ
	 u4h+vAvZ2aDJ2boe5mxlCHi4xLSqXzKoJvLWLZ5bCOu8gvsWZXt8vPAcY/rszyPJ56
	 h1gIBKN1W53Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3F23806656;
	Mon,  2 Dec 2024 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/2] devlink: fix couple of bugs in parsing port
 params show command line
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173316842952.3871672.1293450601638260310.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 19:40:29 +0000
References: <20241126090828.3185365-1-jiri@resnulli.us>
In-Reply-To: <20241126090828.3185365-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 saeedm@nvidia.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 26 Nov 2024 10:08:26 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> When port selector was introduced by 70faecdca8f5 ("devlink: implement
> dump selector for devlink objects show commands"), the port params code
> was left more or less untested. Two bugs were found working on kernel
> implementation, which this patchset addresses.
> 
> [...]

Here is the summary with links:
  - [iproute2,1/2] devlink: do dry parse for extended handle with selector
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=8c4918859e4a
  - [iproute2,2/2] devlink: use the correct handle flag for port param show
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=413cf4f03a9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



