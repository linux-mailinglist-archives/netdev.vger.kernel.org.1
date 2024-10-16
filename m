Return-Path: <netdev+bounces-136276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC49A1248
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9E1282F60
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B5215F5D;
	Wed, 16 Oct 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is8/twvH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA72215F5B;
	Wed, 16 Oct 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105554; cv=none; b=YHfzKxLIEHyKTrYP7l0xxf5oGb6TJlKFcctbuvJ8+HFJjkDnXttUwccl03kCd5F+6LJLOlXEdj8AfM65hCBnT4OVyP3fLKj+ZKV3WAHxCvT39Cg6EnuY8KF1NpMkaHa3ioP4FE560PiRJ7qtvzTzkh+T/hZChE5rhCVoThNznrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105554; c=relaxed/simple;
	bh=WtQiltnUCgWkKmpkZDumFz9tz719l9jis6mD95+yIJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NCM5e7Khf750R8YYaVNaTML66qlgQSaUoojV0RforIEDa5JkmkeCNdqi46suegggIH3yZRZaSB4I7F7aHakVWXsg0aRgA6vRAchJq8uiFpWk7HF8Gz7GVNCPj0RyzHfr4e/PuD1UUuAMKBKZ9wqf0YaQ1P6Oz5CPI7ahPM+OPas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is8/twvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66623C4CED1;
	Wed, 16 Oct 2024 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105553;
	bh=WtQiltnUCgWkKmpkZDumFz9tz719l9jis6mD95+yIJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Is8/twvH9nScDbidtN/C5nZWFe4tGr9kgaDVRX9/xlKNQpqi04jASrLK9PkValyy9
	 ziT2ROUSgHFxovtrxAAfPrMuGnnXTvn8mnmv2A0yLkcucg9s5kfjUK9At4PZD2WCyv
	 CNSAXb6N1sSjpL9hPixiC3LiBWm/iDow3DYwI9LYsFBAT8JZoum7+Pk33A5FeJ9FYC
	 /N9y6iHr6eH3HpgZfHapaJPFi4TBb7TM8YX4K2+ua4Z/4vifzB/zlFoGhgoPUiKqNu
	 mqH860bziwypK0Z2g1YywbfbfvT2FWZJcI8rzbKXra+hWtW+0Fu4ughiclLwKIG0MQ
	 ByA9oYgW+oViA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF83822D30;
	Wed, 16 Oct 2024 19:05:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-09-27
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172910555846.1899946.14515472624740698653.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 19:05:58 +0000
References: <20240927145730.2452175-1-luiz.dentz@gmail.com>
In-Reply-To: <20240927145730.2452175-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Sep 2024 10:57:30 -0400 you wrote:
> The following changes since commit d505d3593b52b6c43507f119572409087416ba28:
> 
>   net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable() (2024-09-27 12:39:02 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-09-27
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-09-27
    https://git.kernel.org/bluetooth/bluetooth-next/c/e5e3f369b123

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



