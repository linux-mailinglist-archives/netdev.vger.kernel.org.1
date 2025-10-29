Return-Path: <netdev+bounces-233754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84479C17F73
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3E406C7C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C2B2853EF;
	Wed, 29 Oct 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltWpU+GE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A513B58C;
	Wed, 29 Oct 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703229; cv=none; b=KUCXMHsHNMh6drjjoXVjPmNz96+IcejunCYmIbPkp144VGkCDiNBOzoUHKRlX7ZuHGRxOJedr8xtolelEve7I2y+aUDs0TXMm1VbYnfgPGCNn/6qtmI43BpzF13j6qkZzIOAKGV3W7GFzAVZbzZVyPL8FhzO3BAr2Vfo2POgaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703229; c=relaxed/simple;
	bh=1uuRtyjAMDS5O0oDGkhK1IVFfj3YHRp6YpyZ+PC/T24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OOPI0aBOKcx7r00YNlHqRgJ0/uRzIeps880yqbYa/Q78Q6uSsIflUCs+Uu5mxflvBKC3i8KGh/Q9iUoEcFHA8Oy8rnomh6udTpYnGG5U/DzMVqC1sSxUZUXpObOf6Nj8yCSMm1Sv74RIghzqVV+zgIB+ylmkwv0LJ3BT8K9nz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltWpU+GE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B9C4CEE7;
	Wed, 29 Oct 2025 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761703229;
	bh=1uuRtyjAMDS5O0oDGkhK1IVFfj3YHRp6YpyZ+PC/T24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ltWpU+GEA2fZgrHIoDYKkeLujKAccBcfLOccoOVy7DKrv/ojCCfJDFVWlT/e/Mu5h
	 WctGxYkRm2dy2XYm4x/9O+LetN+iOOtKm2UWZKxteVT7LuQ466fC046BWyKPFanmb5
	 Ugmz2f3BPTpbOP+QxNH2bSyc15pB7n8GR1A3XsbdH0HCWX75xB8XfMyY/nAgl5/x8B
	 dRjabDFqoQo5wACy8L9CFKYJRuXDAzalgjIgWc88W4UooAwMwjxIfK47xtY6NaBchd
	 dBkkBYcQUpCkqdo6HESCpEgIEs29y4V0HptYCG1k2EmmT6gJnAe5noH/S055Yqb1Rm
	 iUw/1uDgYVRrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD739FEB71;
	Wed, 29 Oct 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: zl3073x: Fix output pin registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170320651.2461467.13128205613424753857.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 02:00:06 +0000
References: <20251027140912.233152-1-ivecera@redhat.com>
In-Reply-To: <20251027140912.233152-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, poros@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Oct 2025 15:09:12 +0100 you wrote:
> Currently, the signal format of an associated output is not considered
> during output pin registration. As a result, the driver registers output
> pins that are disabled by the signal format configuration.
> 
> Fix this by calling zl3073x_output_pin_is_enabled() to check whether
> a given output pin should be registered or not.
> 
> [...]

Here is the summary with links:
  - [net] dpll: zl3073x: Fix output pin registration
    https://git.kernel.org/netdev/net/c/40c17a02de41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



