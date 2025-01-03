Return-Path: <netdev+bounces-155104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44BA010E7
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 00:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ACC162799
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC81B0F15;
	Fri,  3 Jan 2025 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0kVc4D8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88226AD0;
	Fri,  3 Jan 2025 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946514; cv=none; b=lSw8ebzNMNBHgaw9gXFqeFnnphKvfVeQ0zqIT2yJXSd6gdov1kyzYpnXhWFdFUx8odvMyihMDA/6SWubw+wji5scbLkfEYLb7mMqfWXkijFJVxX6dn3ybSqJjpMGLaJr71LNOmQbqZwYRLVr7uzVorsZjrzmlfAv4kjTMmG1lcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946514; c=relaxed/simple;
	bh=b9+XYSrMoLOUXJ5COkIwXeIovbR3q3601rmFAulbRn8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FuLKK0Bsch27Cdry1CQ/qFbOsM4nne2cMz1VZPWUwhvguu82kS5VbK2gVcqYw9TzHlTpmtMCQr3TrgetGGzVfS48AUtnyyIaYTnASwgZK0Z6K6Wzo8tM+Xk0u27LZFTHBV8AmwmZVoO+ShXIR5kRCyN/jsYeCqkp0zM/JGomh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0kVc4D8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A5C4CEDD;
	Fri,  3 Jan 2025 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735946514;
	bh=b9+XYSrMoLOUXJ5COkIwXeIovbR3q3601rmFAulbRn8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o0kVc4D8KQWydZulfaHuq3GxgEjFXKYmAUqIifpIW/l+MXH6QmqGvu6KpQ4kFLsj2
	 s86GOjux2UgbjgOHUubfaPfTglz42Gl82BofdTyauBSdRQyv0GJxU6i5J47u0BjVi7
	 RzQVBPBMWXGXHla8ZrU4yuHIgQcxkw9gk8JyIzZl+m8PlDtYomvI0ocrhWYkuArYBC
	 gpopcvCNf2cm1dOy5kmDdxGiOM0gdfk4BlDIz64YJa5BJEawsZFhNuG5JfnhHsFj4I
	 uBD85tpImw0ailcL7fnd5TLWf6ugcpGavmSmGTT3ypQQnZ+bMAOy2wNvNxnsr2izXz
	 sK4nmXdlFmwxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FFA380A974;
	Fri,  3 Jan 2025 23:22:16 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250103171551.2999961-1-kuba@kernel.org>
References: <20250103171551.2999961-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250103171551.2999961-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc6
X-PR-Tracked-Commit-Id: ce21419b55d8671b886ae780ef15734843a6f668
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aba74e639f8d76d29b94991615e33319d7371b63
Message-Id: <173594653472.2324745.11678348684162817308.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jan 2025 23:22:14 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  3 Jan 2025 09:15:51 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aba74e639f8d76d29b94991615e33319d7371b63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

