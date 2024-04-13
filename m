Return-Path: <netdev+bounces-87618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B378A3DBF
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49B11F21944
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8716B3D6B;
	Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmgLbhSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1817FE
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713026427; cv=none; b=df5PV3PYSNbgpYNWA0F6JGiXj7l2616g2Nhk1th31mf9lrEuIpRiu4g+py7oQlBrKWmU74JPFjsdg38zpaQ+OC2PQ5/UGg5zalwXo6s+luhNtxA5e6W4nqP01igVWKslN8ccOCNCML1Ilk56L1v+SSfIalccdpRRYuE6gpTVFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713026427; c=relaxed/simple;
	bh=rjnaSZr7FmHPqg2ApJcX/TWzpoFUctz9BvycnNlUvMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kkVJdV2X8GIngsoLBjy4lN966gVPaW0AyWhhZjXnAaoC+4mLVf1NXITpo/hiZxlEbYLAzgCYUEZF9KLdGAvBjf8g7aXnVjnvSvvRYs0lcdoIV+3JIg6bqNbcxUXdy7xtoIS5dSB9H7d+uCeRYozIKJMITWGcNpinD0SvUCfF7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmgLbhSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F167C32781;
	Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713026427;
	bh=rjnaSZr7FmHPqg2ApJcX/TWzpoFUctz9BvycnNlUvMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UmgLbhSXvn48Iy3Ujt4del/yHlbCLEBF/0c6EPOG6UlgAwnDKYN2mKcEBX8v/J34h
	 kb7yzuGQkbHgaJsTmclD3do8UM3chkQtBbTATFUuIpVV94WM/YiRbJH2sruGm75TCX
	 EEdP/yJC+4kV7KHoit9yJx5cyjTqgx/SDSnAwAIVTvsAya8QZzeQcdjXQfN3e04CtG
	 BhrQ9xsp2KMNSii2F2oPj3QPW/B26XicQCcGXRbUhUnL3nMk6lGC6sGqtGMJQ3v8qZ
	 2mrAFykCWTTDmLc29ZIqDEqo5d/Jbs5fxtNcyGf6e+vu22cZ5icCk0nth61bI/1gQz
	 +K2lUIQF8ZxDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EDD7C32750;
	Sat, 13 Apr 2024 16:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ip: Support filter links with no VF info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171302642717.24529.5480003178825630695.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 16:40:27 +0000
References: <20240411024319.58939-1-renmingshuai@huawei.com>
In-Reply-To: <20240411024319.58939-1-renmingshuai@huawei.com>
To: renmingshuai <renmingshuai@huawei.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 yanan@huawei.com, liaichun@huawei.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 11 Apr 2024 10:43:19 +0800 you wrote:
> Kernel has add IFLA_EXT_MASK attribute for indicating that certain
> extended ifinfo values are requested by the user application. The ip
> link show cmd always request VFs extended ifinfo.
> 
> In this case, RTM_GETLINK for greater than about 220 VFs truncates
> IFLA_VFINFO_LIST due to the maximum reach of nlattr's nla_len being
> exceeded. As a result, ip link show command only show the truncated
> VFs info sucn as:
> 
> [...]

Here is the summary with links:
  - [v3] ip: Support filter links with no VF info
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=806b751a683f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



