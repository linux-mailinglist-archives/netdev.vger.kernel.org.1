Return-Path: <netdev+bounces-126466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85AC9713FA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D78283A41
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D01B2EF9;
	Mon,  9 Sep 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqG+Nef2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4791B2EF3;
	Mon,  9 Sep 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874830; cv=none; b=Ie/CyJVEBdRRU6RXwV8tm6Yg2TJsaZUmTETLkx/XR1A6MIJcvseKmbqCgZLJlqCfP+AIN3iWhOB3MhPkdpaA7Bz5gxX9lNKB90ZDDJLxsyvv1CUtkarkRFG4I6+s9PsE5Bt36d9P2tEETDz0NaChppykvXcikeR0MlEWky47Oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874830; c=relaxed/simple;
	bh=thg2sO/khWHrWKgzw3zIkwY5tZ2TU2Prc0/hTjc97gc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IkDxSiw1lkWMbUdslzOdz7FMmmTuGNNPqqZG7PU7/xZ2Sat/sPZcKwSfv1+PqFFm8yM+lgAjtYrQNyyC5RWnltjbvRdpMGuDgzLlYY3tmenMIWLD8BYZYCzvcO5CjvQp4HJTe60PsgqyA3snwvUyjnxU773jMeZsxnkIE1JRi5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqG+Nef2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B337C4CEC6;
	Mon,  9 Sep 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725874829;
	bh=thg2sO/khWHrWKgzw3zIkwY5tZ2TU2Prc0/hTjc97gc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YqG+Nef21nF0XnUrVRCnLCYY79H05XYgQjNBPzZyUOZQcEkUehoKyWUn1vvWTzHsr
	 YgzeYVaabc/z1mvhoybR2mpB9n7o0wJMHFNW51DyQKihQ+JojV4smF3oFfncysSKK6
	 FzGIKuqVQyBqIDGjFublQwJfwcP4JUh9QJUkHYaL90CbFWAjRpk7EVCOEdM6cbABxQ
	 DZRoyROo9tKMKMTaT81zS6FhHc4OweOrG4dMtNQBdNP/zRZFwwZid971t4VS0+57yx
	 e+mdB79XDKsn3CR+6yTVaGJPIrX4K45Qj3Rw3Byiz090hTmFEatakDjq36Z5L2vOag
	 iZb6vuzKVrPwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD0B3804CAB;
	Mon,  9 Sep 2024 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sysfs: Fix weird usage of class's namespace relevant
 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172587483054.3400712.16196842321963432376.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 09:40:30 +0000
References: <20240905-fix_class_ns-v1-1-88ecccc3517c@quicinc.com>
In-Reply-To: <20240905-fix_class_ns-v1-1-88ecccc3517c@quicinc.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_zijuhu@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 05 Sep 2024 07:35:38 +0800 you wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Device class has two namespace relevant fields which are associated by
> the following usage:
> 
> struct class {
> 	...
> 	const struct kobj_ns_type_operations *ns_type;
> 	const void *(*namespace)(const struct device *dev);
> 	...
> }
> if (dev->class && dev->class->ns_type)
> 	dev->class->namespace(dev);
> 
> [...]

Here is the summary with links:
  - net: sysfs: Fix weird usage of class's namespace relevant fields
    https://git.kernel.org/netdev/net-next/c/8f088541991b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



