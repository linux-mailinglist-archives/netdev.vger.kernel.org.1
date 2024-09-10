Return-Path: <netdev+bounces-127025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6AB973AC9
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CC81C24AD5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6FD192D9D;
	Tue, 10 Sep 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA8SZ7g/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85A130495;
	Tue, 10 Sep 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980431; cv=none; b=CXdeKMASVxIbYB1N5E9JjqK1Fw7x9SJvtiYs23XL7bS98Bx8CEBRSXF3yoW30krjOkRG/WoCVerfsYIfCnWphPpAdmP6iVh9BK+0mow/R81fzQyPOP6hzFBMz3cr/96RyvydroHtcaP3WP6Cjlc2oUJVZWu9jy2aHgZjmJisMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980431; c=relaxed/simple;
	bh=7vVe+kPQm7LdEuy1q3f3ICanaOlQ9fti1HVs2FHxLLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZ1Oo4EzfeckR8WuO6xUL/0hLvHjEsA7n/p/Vqh6yUDYRdcskMR0aPoayd2hmFJY5SpTK6wo7CXq/gZuzE7K86KG9vmIcoEk5grDSwhFe/v5Sdh0PVsxWD0nfFhyNTFvZmabWZrX0vfVO5rpgz+Gl1ORYD8bgCJJglcPu0ReqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA8SZ7g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D34C4CEC3;
	Tue, 10 Sep 2024 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725980431;
	bh=7vVe+kPQm7LdEuy1q3f3ICanaOlQ9fti1HVs2FHxLLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tA8SZ7g/4QP4sGbMqHiBbBzbBV/Rh+DoYKeKl5Ii/YQyZRIRUUMHOxFfCVaBrJXiE
	 natEnmjxUIDJwPaXy6LLAjlX6s/4RIVGmPhnsh4Ca+S8X4e/TJR9DKaHq6WLBCYXkU
	 oSI8ZciywI9mPw/B3+7+jYWZKExbXcWbNceUU6c0cqw49SXtZTpesQomckLpDeC5AR
	 LDQtvzeZjkcHSFZ9WNgNL4XiQ690k3WNf93muaFhn62LBreMaql3JaR5UhgMe975KA
	 6SJmDVW7lB5powxsHmPdmfWUMYz4MLJvzjz8vV4lzE+VVCFlVDPWF1gv0HrIP1DG6D
	 t9D2lGbAuJauw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3400A3804CAB;
	Tue, 10 Sep 2024 15:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: replace deprecated strncpy with strscpy_pad
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172598043203.283578.7669553872558102167.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 15:00:32 +0000
References: <20240905-strncpy-net-bluetooth-cmtp-capi-c-v1-1-c2d49caa2d36@google.com>
In-Reply-To: <20240905-strncpy-net-bluetooth-cmtp-capi-c-v1-1-c2d49caa2d36@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: isdn@linux-pingi.de, marcel@holtmann.org, johan.hedberg@gmail.com,
 luiz.dentz@gmail.com, netdev@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 05 Sep 2024 15:54:40 -0700 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings [0]
> and as such we should prefer more robust and less ambiguous string interfaces.
> 
> The CAPI (part II) [1] states that the manufacturer id should be a
> "zero-terminated ASCII string" and should "always [be] zero-terminated."
> 
> Much the same for the serial number: "The serial number, a seven-digit
> number coded as a zero-terminated ASCII string".
> 
> [...]

Here is the summary with links:
  - Bluetooth: replace deprecated strncpy with strscpy_pad
    https://git.kernel.org/bluetooth/bluetooth-next/c/278dcc36b992

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



