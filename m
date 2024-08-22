Return-Path: <netdev+bounces-120762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47695A8DE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EC01F229E1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B478101C8;
	Thu, 22 Aug 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj8vfUIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232DE552;
	Thu, 22 Aug 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286633; cv=none; b=ZywCnKeyTU6TtB0vFR/M+eGCNPPtKzEQZtRvLENXRMRM9gJJx11rjfAoMn426G0+4ogXz5d8cw1PAiAeyvtiS6DmPom8pw9hf34CTOYphpIBkLo82AptvNnRcmF0qrHZVp04mbgq81l9net10eIpVDFZrrQoofH39cAtpfQSRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286633; c=relaxed/simple;
	bh=e7KYCxxO1yFMw0JPTmVozbwJrVOernrHyoaI8m1Yb2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KcDNkNnybGcsHT/YH/cfXakHKKpe5O8NVSFcXLRmZQB3pgfcA/D687cbP5fNDliqkY7fcFU0oY0HE6z+T7aO34pIyYnrydcNOHretujjqp//hCbkk5RCdgAekV47ugk28K+Qj+UYzwLiC+3Desl5PaF2UTbOLVESxoUczyMYGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj8vfUIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6270FC32781;
	Thu, 22 Aug 2024 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724286632;
	bh=e7KYCxxO1yFMw0JPTmVozbwJrVOernrHyoaI8m1Yb2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fj8vfUIN74GzggBkX+fFHZgADsbhaiDzMP9/Oou45rETsnfyryRQRcNUf+/UMyp8N
	 f2+xqX/FOPa3mBtN6/3/r2V+SN8VAOLkYASKOW2sIfQkeUd0lbVUzq1qHF2D1KlB7B
	 NdxxDVrsrmxxhOMhzv9o8yebwPKryOR0SlQKE4F2u/53Evr8BVUFxHMMjLVyenWQlE
	 QnlmdKLTWi6s7doaBrgDe86HpdG3FycGpWzkG4Jpx/GZX6WwcQ0xTX7VWwP9Ha7r2h
	 WYRt+ICZS8fi0Adz4PCZYCdvt259QWEf5UqDcRe1ofwaux2/4hbfGp7WS+oNLDK5qe
	 BfA44KL9iIORQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8E3804CAB;
	Thu, 22 Aug 2024 00:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] nfc: pn533: Avoid -Wflex-array-member-not-at-end
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428663173.1870122.3832534157209678732.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:30:31 +0000
References: <ZsPw7+6vNoS651Cb@elsanto>
In-Reply-To: <ZsPw7+6vNoS651Cb@elsanto>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: krzk@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 19:27:11 -0600 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unnecessary flex-array member `data[]`, and with this fix
> the following warnings:
> 
> drivers/nfc/pn533/usb.c:268:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/nfc/pn533/usb.c:275:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Here is the summary with links:
  - [next] nfc: pn533: Avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/488d34643ec3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



