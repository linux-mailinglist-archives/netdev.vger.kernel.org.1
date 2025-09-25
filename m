Return-Path: <netdev+bounces-226137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D59B9CEB1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043E67A388D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3A2D7D47;
	Thu, 25 Sep 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOyYgul0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136D611E
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761410; cv=none; b=neNmIffvT0yWe1mCdfj/nF08xNgbeeqJ+UGo5n1zsUedw73CdffzIGeh/HxKYGqn96si1cp3fYSs5ZNoEj0QJ388DMx0uLaWzR8lDENG7KdMAAGQFvGrZ5YEsvN77QdTBOB+eJ09zo53tXHlMn4AaPeFPyQK1KL/mhU5vz9hdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761410; c=relaxed/simple;
	bh=zF/J7CGNrpas8ghc28mHyLfFskmXYzN2+YN/dJJOwoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SrktIUUUvB4oLd0IrU1im0Jpd3v/GwbJEMdJ4x91tZDnXQyRoCvwoJpOTlvQXAoOuErIlpOdYDhx/GKbzZmhYjlWh3yCaEz2EGbBMeSPYRCgTSxCTJmFW+8zBzyGeoVJamPTnbDcRHBYVuuo8TzFb836qw9h2Xepoo7eYxIJDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOyYgul0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31797C4CEE7;
	Thu, 25 Sep 2025 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761410;
	bh=zF/J7CGNrpas8ghc28mHyLfFskmXYzN2+YN/dJJOwoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BOyYgul01q7MJm2Dr/GI2wL+nuhS3Os/yYRXCKq+PJjiGTyHdElLEwAFm3be/9QcP
	 F9s7jnD8rq1xbtbALFtC3SiRsN9fy4ZxMLdZJyBlHuVm6cgC8Piz0yydm/hRiradVa
	 VXQpFWep6yx5k6RxaQ9GNfNJSsY+zRTl0yE/16NgQH5PCZHrIAEM3NlqFAcAoaVfUa
	 9qVPxuMtzt0l/fZNBUJu1tHNkJWPoKqAXBrR0yjRY2Vz6LRlEIDoOUt6tqEZq3/DO7
	 hEVIiDkOlEbarYsOuGk+x/LfaZNxcz8ztcDmWUQ1FjMVFLY+esh4ezC5AfxX54AqDR
	 ur8Q1Ol88LUsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3C39D0C20;
	Thu, 25 Sep 2025 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] libie: fix string names for AQ error codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175876140652.2757835.9176882333160784818.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 00:50:06 +0000
References: <20250923205657.846759-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250923205657.846759-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, michal.swiatkowski@linux.intel.com,
 aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
 pmenzel@molgen.mpg.de, aleksandr.loktionov@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 13:56:56 -0700 you wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The LIBIE_AQ_STR macro() introduced by commit 5feaa7a07b85 ("libie: add
> adminq helper for converting err to str") is used in order to generate
> strings for printing human readable error codes. Its definition is missing
> the separating underscore ('_') character which makes the resulting strings
> difficult to read. Additionally, the string won't match the source code,
> preventing search tools from working properly.
> 
> [...]

Here is the summary with links:
  - [net] libie: fix string names for AQ error codes
    https://git.kernel.org/netdev/net/c/b7e32ae66642

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



