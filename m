Return-Path: <netdev+bounces-90316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F08ADB49
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 02:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC226282021
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 00:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF43FF4;
	Tue, 23 Apr 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ9lNbuN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E533D6B
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833591; cv=none; b=ipZ7uAsjeBFLcW3Qo1KuiVP4iZ4uR6CIX6IKKF6FMndURSuUMEx7ro1R1JS2wE8RKCXkNW+bQY41lYOz38Ayzg/0FsaxoO3aa9fuzQHQXsPl9PXkVXIEMhH3lNEV+06id2l6qLZjrIDsNr8gzQLc6ygcdhqkduhYI+4Fxur2m3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833591; c=relaxed/simple;
	bh=3lI7lKzbhzbiY2w7WW/eH9gltdvMyHZGGkzOPLQ1NTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=REpwf0ngrYf0cdzMEAuQBlTrEK610PKYTFpthPMxQz3+hSkd3g89qS3awIJRQNULkPsyBM2DZHZVs3GuxQlLlysRstNcyfsJBfORcLLoMX0lcJU5sxGfKxmi/y3t74ib6cOafgF9s5siwxxmiVmkPxhIs37CFuyA3LN9pkAtZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ9lNbuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 599B3C113CC;
	Tue, 23 Apr 2024 00:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833591;
	bh=3lI7lKzbhzbiY2w7WW/eH9gltdvMyHZGGkzOPLQ1NTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJ9lNbuNa5XiehlOXu5qqX0YDWf7KFrW1a+MhCk2QGyh0q7ghsgQdnS3fSTt/Aqcz
	 wogOYr2r07m0IgwvO7jdWLY2/iKaJOCCRUBsSHL6b3WyVLCBV0uKmf2MeEPK7hJ3Zx
	 hZPos17A4Yo0LTWV9Uf62UOmSUOcPNxdsAs3hR6ZUH+C2NWSqiJMH2HnjqgUMmrtNe
	 vr9pXhZ1eHxI99rybGrP/10lKtV3yv5fO2Mt+4fUdjw/59f3MibEUkalzTHifwRGsC
	 S7jfeag+F0HURFRPAHoLyyFQO0WC4lS/Y9u2ZyiMQPwIZ597IEGRXvX+fVUxwQhY+v
	 wzA2EKWvGmLBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48201C43440;
	Tue, 23 Apr 2024 00:53:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: eth: mark IBM eHEA as an Orphan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171383359128.888.1636463748827012048.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 00:53:11 +0000
References: <20240418195517.528577-1-drc@linux.ibm.com>
In-Reply-To: <20240418195517.528577-1-drc@linux.ibm.com>
To: David Christensen <drc@linux.ibm.com>
Cc: dougmill@linux.ibm.com, davem@davemloft.net, pradeeps@linux.ibm.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 15:55:17 -0400 you wrote:
> Current maintainer Douglas Miller has left IBM and no replacement has
> been assigned for the driver. The eHEA hardware was last used on
> IBM POWER7 systems, the last of which reached end-of-support at the
> end of 2020.
> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>
> Reviewed-by: Pradeep Satyanarayana <pradeeps@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: eth: mark IBM eHEA as an Orphan
    https://git.kernel.org/netdev/net/c/97ec32b583bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



