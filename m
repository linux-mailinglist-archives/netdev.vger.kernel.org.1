Return-Path: <netdev+bounces-155654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD20A03447
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910463A4BE7
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C038635D;
	Tue,  7 Jan 2025 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVl8XyYX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E427DA93;
	Tue,  7 Jan 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211617; cv=none; b=GuTQJKzvcoTtEO41QU77Omy4NLFrf6jmRqElU9jXk7Y57FSKPMtWVMr0qwe37hYY+C2z1g2uaPimJ2Jw/PYGBBzv65q2fv47FoLa/lz5RLFrWf7nycEz/V5xim4bp8FG13mdqX278IlaqmUbI4VHV3rS7+/LbCZVkXwrnh1vRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211617; c=relaxed/simple;
	bh=gtKlmBEN9Ale56iKzCmQRDjGXc4tKK4WhudjJ2KJZZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D7V0K5ALf/howKYSs68OmbA2xI46IiTKQ4mAppBXJb+mXpZjyTQnhqMbuJP8glx4RaV8wNL8Z+B5x7L7nn+rfhdKHpnB9w4ziMoiscCq5yky9YIgc3oK1q9ydepoT4Ps+L5/HeP86EIeGUKJATWJY6LpFCvgBl8K+/hURMpD+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVl8XyYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD103C4CED2;
	Tue,  7 Jan 2025 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736211616;
	bh=gtKlmBEN9Ale56iKzCmQRDjGXc4tKK4WhudjJ2KJZZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sVl8XyYXAMkMmsqyQBJEwSf77Mjx4cxJBax1WD7l5r+d0yJkTgr4emcxsHbytjZAN
	 pf/yuQnjArZamuZ6jvRA6f64N2rjACiAFYkJ0D4V/AIOs+KSVukZ4zqcGKDFmtxvtq
	 HjWsopp99I3A3qKf6U7mDy7INNj7zqBgLVRya+zaQYirH+wSGIN79rw2ODwWZFfBbv
	 7qQ5dpCcjMeZuGdWnXSvLZL24liKKU0HAyWwpNDfqpLJua8kZNlXo2nS2ijOfdTSB6
	 SQqdqbxO33p1+UqDBUjsi13o+U7NmrASPAThDo7K8dkTBONHaV39Ymz67g9qltn9Eg
	 I1KB9kDlk6m5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340EE380A97E;
	Tue,  7 Jan 2025 01:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfc: st21nfca: Drop unneeded null check in
 st21nfca_tx_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621163774.3665137.17324569970620167129.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 01:00:37 +0000
References: <20250104142043.116045-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250104142043.116045-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: krzk@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Jan 2025 15:20:43 +0100 you wrote:
> Variable 'info' is obtained via container_of() of struct work_struct, so
> it cannot be NULL.  Simplify the code and solve Smatch warning:
> 
>   drivers/nfc/st21nfca/dep.c:119 st21nfca_tx_work() warn: can 'info' even be NULL?
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] nfc: st21nfca: Drop unneeded null check in st21nfca_tx_work()
    https://git.kernel.org/netdev/net-next/c/21a8a77abb4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



