Return-Path: <netdev+bounces-231962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0606BFF08D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC1A44E785C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7D2C21C3;
	Thu, 23 Oct 2025 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfAAWn+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49232C159F
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191183; cv=none; b=pqLicqnKCL8XO8veqJMmEaI+nIqblbNhqpzekhPjxwicll7mLrMoyGRFTzAayC639OFnO3lJ6s4qJIA0QpGW2ObVswUVi1brAbCBS/zK1egnEBAryfdHd2wn+5127Uf053+gkxEeJUABhAZ7rNU/VaynqnRHszGex42AkoeESYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191183; c=relaxed/simple;
	bh=EDUH4wYq3jAJOje9Y4N0CyDgjlY9DisyObNGg3vhb6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YyjkuhaP4W/NNSJ0NH1IKi4MqmEOt/yjLQfQXNQtLvUIJVEW29z/emmacrHV/hiko0DL2QRc/R4qCqIwAk4FxitOibXyVB+gNZck7nzhG8BxmWE6o7KqHcchfdbqSJXoHyow/wlNC3xLPugf/JJ6Cjm/3cP/GUQTxORY3Astzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfAAWn+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63D2C4CEF7;
	Thu, 23 Oct 2025 03:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761191181;
	bh=EDUH4wYq3jAJOje9Y4N0CyDgjlY9DisyObNGg3vhb6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hfAAWn+A8K/QYrKAs9CNvNqtysQcMsDQL4UlzQG52AjMvE1dURdJoujZiDkfz6RCZ
	 Oa0BhKXndXZuKeWpYuM4MERXKxLqpUjHSlB+ODUM/EV5/zK7nkCHG4LfL1CYj4WsPZ
	 /WROvsguJzD0Los3X42zT/8Cr7tQeSN1c/fGNnlCILUbL5FhhQ9QbqxxjIXE31sTH8
	 vWGSyxsZ7KCptZi3rMtBPntk4JjfK12F58vdzPDRhy8e4w68sPA0g2Qp4eAS1swPdb
	 4958tJtV+H4HK0SCop2lJtOxMtQDS8771CGv1Tw4/QnICHV/Jg8gmlD0Y5hlrZ/Krd
	 WVk83VMv7/v2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF303809A04;
	Thu, 23 Oct 2025 03:46:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: prevent creation of HSR device with slaves
 from
 another netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176119116225.2145463.3539910996510064483.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 03:46:02 +0000
References: <20251020135533.9373-1-fmancera@suse.de>
In-Reply-To: <20251020135533.9373-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Oct 2025 15:55:33 +0200 you wrote:
> HSR/PRP driver does not handle correctly having slaves/interlink devices
> in a different net namespace. Currently, it is possible to create a HSR
> link in a different net namespace than the slaves/interlink with the
> following command:
> 
>  ip link add hsr0 netns hsr-ns type hsr slave1 eth1 slave2 eth2
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: prevent creation of HSR device with slaves from another netns
    https://git.kernel.org/netdev/net/c/c0178eec8884

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



