Return-Path: <netdev+bounces-123206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 541949641CA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E7C1F24E57
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CE1A0AFE;
	Thu, 29 Aug 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSZZ8M4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354218FC9E;
	Thu, 29 Aug 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926913; cv=none; b=T/DW/sP0XiO7E5f2mcQOZGLKy5iJ4S5oazgXxLwHS4+igh1MJ3EooYBwR4cMJVMxIV1hkR3bTBIQyRGas9XUDOOp3O2MtzZ4kcOG07KzBtQat3lFel8T7LLPnppZFtTI6o0EBMz5BAI8EJTI4q4jP7nc83zT3enY7ctv5fzamkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926913; c=relaxed/simple;
	bh=1QrAX/IdDlR4M5bSGsSFu5F9wzJbd0cyNgJ3LSQuaJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SAowonzw8f2YXk/I5VrAVpQMT0nZ3TFfE85T+rmo4c0wllHQZyYThftZBDUjPcFNA5hkzHZ4TJKFRkYG6BmRZGRY/6o4hwmr71SA8Rg4nRDyrRR9oZXKjJ0Ugt67ZAmJjG3OOtCwucPQs5BfTmWd+BV+6yX0ohb+Akx65k8xzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSZZ8M4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E8EC4CEC3;
	Thu, 29 Aug 2024 10:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724926913;
	bh=1QrAX/IdDlR4M5bSGsSFu5F9wzJbd0cyNgJ3LSQuaJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZSZZ8M4E5ULqOdD2vJX7wTMGrGs02Qab7Qi53JwIh98CvD+wIwjVh4XFfEFw1EYvk
	 JpSQ22YERJI2mAt7QWRMH3As0OtRs/yv4htjANkj7y2Xm2/71MwvRamwGPS5ILqf8x
	 ixAOQG/FnLwGWFCkqHQAqvBhnRejOUqqShkgKCwXEY3gnywo4O2mzySfG6OaP710UN
	 0J2lv0R2XruTh+vYQyl37wBlJfzudEOr4hCWUImsOK/iXb2F8D6b8QjbQgHFu20Kw0
	 8vLO2uj3goSBpGzpGhz9dAfikqXRxJWGqdLfN5FxygJpfX2P6v1ju4dZqUZ+GYkq7c
	 CwmWMRhM2BJcA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 777E53809A81;
	Thu, 29 Aug 2024 10:21:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] nfc: pn533: Add poll mod list filling check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172492691448.1896596.12025723350845983678.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 10:21:54 +0000
References: <20240827084822.18785-1-amishin@t-argos.ru>
In-Reply-To: <20240827084822.18785-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: sameo@linux.intel.com, krzk@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Aug 2024 11:48:22 +0300 you wrote:
> In case of im_protocols value is 1 and tm_protocols value is 0 this
> combination successfully passes the check
> 'if (!im_protocols && !tm_protocols)' in the nfc_start_poll().
> But then after pn533_poll_create_mod_list() call in pn533_start_poll()
> poll mod list will remain empty and dev->poll_mod_count will remain 0
> which lead to division by zero.
> 
> [...]

Here is the summary with links:
  - [v2] nfc: pn533: Add poll mod list filling check
    https://git.kernel.org/netdev/net/c/febccb39255f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



