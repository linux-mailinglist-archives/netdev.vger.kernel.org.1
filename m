Return-Path: <netdev+bounces-197287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1458BAD804B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198A617C925
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E041DDC00;
	Fri, 13 Jun 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuITyTqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF31D61BB;
	Fri, 13 Jun 2025 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778209; cv=none; b=AKMWvJjVLPDWlb/dfXvBbT8mx8gjWVLBw8Mfj34IHesvrmYlrq+cNPd5do23ukyZ+Xin0CFUUD18z6edapu8vsyYO7P3EBnVPHooJLysc3nXD2NEV2DXLi58MVYXaGTUbvRG6t+oJFYtn8Ic3DjPxQfMIT9oTnOnApqhFQQ8BZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778209; c=relaxed/simple;
	bh=LGozbvg8wuN0oUN5ZIjdqt3AjKmMD5qfTZM/TgcpT4s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I1OwuN8Br8gYzQeLV+tQG3TipsHjHJunPYP2gM0l1kmuRW3Fwt/XixylnLxP/85Z1JBimdYjOSOEBFmN9BL50sZvqf3LcEPwpDvWBmlw8cDkcC9nPkPaRgyP75Ztf1ZjCwmYst1r5Q3lHeQa+s8rNxiC8G8pHXZgtk91Qr5r46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuITyTqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C33C4CEEA;
	Fri, 13 Jun 2025 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778208;
	bh=LGozbvg8wuN0oUN5ZIjdqt3AjKmMD5qfTZM/TgcpT4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KuITyTqQ96SNY9NwvSEKX477bvRluNEF1+hXIzDcbNbwvnt6kcGuZJOjUmRtBcUJ0
	 O6uWcoZTPPSpCHts/TRyek6/rvtUSoYlikli3J64IrPSkrJkJoxolGS2MgVDzpsaZP
	 I6ACd5gLwDpZa6NLW9tgBDXo+arfHXRx6vKhg1vu7rQGG7EodXqsSnhKxzZR0y6IyR
	 L5fxbaHf0wfeDke+WRKCsOzL3RhEGZUx2ER6k/FezQelCEU0jxn24BTgCkEEo1rMvB
	 OfnRRgcS9+4cAYaW9+jfgeq2iDZr/OK6qpdE+P4Kq8OBrYQ7K6g/8oeKkQJaTFcEWn
	 DUelvTK9SmZfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8939EFFCF;
	Fri, 13 Jun 2025 01:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ncsi: Fix buffer overflow in fetching
 version
 id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977823850.179245.13765419017605151253.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:30:38 +0000
References: <20250610193338.1368-1-kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <20250610193338.1368-1-kalavakunta.hari.prasad@gmail.com>
To: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 hkalavakunta@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 12:33:38 -0700 you wrote:
> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
> 
> In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't
> need to be null terminated while its size occupies the full size
> of the field. Fix the buffer overflow issue by adding one
> additional byte for null terminator.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ncsi: Fix buffer overflow in fetching version id
    https://git.kernel.org/netdev/net-next/c/8e16170ae972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



