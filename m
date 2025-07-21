Return-Path: <netdev+bounces-208708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB355B0CD48
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309516C6FBD
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE823F403;
	Mon, 21 Jul 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsMbVhX8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C22E3716
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753136989; cv=none; b=A3jXUWHUE6f2NwXtrJB2xwCA+4xlncPJ5t58ClTB1YCjoiiETKHckKYYH7gCf/IVBqSkcoVjntbUH9RqCwW9QzE/D0NXhT4sbj8jtQzlG5dqjG2IUGCSjlkYwhNBZgSrVYstFRiaRrdN4nWONWa8WGK+iWoHIh+dEYzdcYQSXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753136989; c=relaxed/simple;
	bh=EsdyVLAXMLkJTbKxqRzGlvdYUdyOEBKdfEpEJzGr2/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=abUcxfQUPKEZ5RI9CkWCFvwI0LQ7+H8fNbwHjdLhvgKhYA6DAM+b6Xb2ajBlTtYow4sd/+ofl3yYKAhxdHKEM6myaGcK3g3Tn/i9/YYrVrYKVH8AaT0abuGtaNFIWeJCRouOrqKNu4i3TB/PXL8iWEo5WH9LPT15pOU7/H5ZsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsMbVhX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABFBC4CEED;
	Mon, 21 Jul 2025 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753136988;
	bh=EsdyVLAXMLkJTbKxqRzGlvdYUdyOEBKdfEpEJzGr2/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OsMbVhX8v88bhI+OxipVRcZ5FS5fEmYHN6l4KLuMSgObPHE6dvm9xeBvtKKPam27I
	 FY9HOX7jyO6HX/qqelZDzv0l1zyYq6hZAhGBDqZerHLVTtul8qeBJ4e+I2l7ZvHWQB
	 9Yefgm8/U0HrWvWj4Zs2keZAQc6oYU2kq2EF2SwSvZBahR3YIDU9+uvkFdPA6nuxpA
	 ykVzMMQoptQNtaBU4a/ODeXRwL6/Xg4i/aQ+wbNufQJ0KPl4HNQv+R98KRY1hGnwKF
	 rX71MceOjnxyfM2ND8TLfIZVMUwQRv5mgfjtZ2fmmVq4JtiWx8MY7Z+SjcxOcH3Acf
	 FQ+oSQPPt4ldQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C84383B26E;
	Mon, 21 Jul 2025 22:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] netlink: fix missing headers in text output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175313700701.213144.4397617760151450530.git-patchwork-notify@kernel.org>
Date: Mon, 21 Jul 2025 22:30:07 +0000
References: <20250712145105.4066308-1-kuba@kernel.org>
In-Reply-To: <20250712145105.4066308-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org, ant.v.moryakov@gmail.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Sat, 12 Jul 2025 07:51:05 -0700 you wrote:
> The commit under fixes added a NULL-check which prevents us from
> printing text headers. Conversions to add JSON support often use:
> 
>   print_string(PRINT_FP, NULL, "some text:\n", NULL);
> 
> to print in plain text mode.
> 
> [...]

Here is the summary with links:
  - [ethtool] netlink: fix missing headers in text output
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=b70c92866102

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



