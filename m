Return-Path: <netdev+bounces-141342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484069BA820
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052B5281B46
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03B418CBF2;
	Sun,  3 Nov 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvCjR6b8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BB155392;
	Sun,  3 Nov 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667627; cv=none; b=rfbkJZvgpWWVdZieQcy0jpqchwOuJ3JYK3hPhSKAswk1I70wcuKrnpwh+LztCaraiXukHvdA4rIrQLDF/YYiV1sEqMxT9FJiTjIzbVP5Hib9g4An6R9j33IK4/fA3YckoOVjwxunXWObUH10ICM2HmjUM7cJD+O0TMlj+CYYWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667627; c=relaxed/simple;
	bh=pbd16GLlHtOC2dmcOjLcGwfE+tqzEsot5pNy9wyoHDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HlTa3OiIC5La9PiuxDZdvypEjak81F+plLzSlm18M/qjbFRLKmhWTEuQ3u83Obf5FWm3JgtdajVk8ECld2UL0NxWr9Q2uguLhYerKvJKWAtROf1DerbEKIgzdZBaPILyHz91/EFE7bO0RB7h8RUn/RzDAAS2+VSxtKBOatHmtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvCjR6b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F624C4CECE;
	Sun,  3 Nov 2024 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667626;
	bh=pbd16GLlHtOC2dmcOjLcGwfE+tqzEsot5pNy9wyoHDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dvCjR6b8rsmxnSxmtAUIyFM2GFJ9Nsiviqxej0QH0GgPw4Y1NE2+LBTzo/NKKduhc
	 20yStcNBtIDP2EfELaEj6zsWgIliGVaP0kRvH1lfBJqBoFLc62gl1RsIdtGFWQGKNw
	 w6xoTL4XukvTUqtKbfaFOLVBQL9PAJYigm6iKDYaR6OPH2Tj1CKc674GUrQvJvSjvx
	 HL8AIHeO4X1iziJ5Q667k0BSh+ecfdZesVZmOL/juVxY/OH2+Syd+658ceS3B5DsoG
	 c8rcMkyQAGoisTeQQkgHTk/zcjWmrytnir/T+BeB+7L7bo+F0P16zSQG/j9DXowHoT
	 9qgFHKpSnmdhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACFD38363C3;
	Sun,  3 Nov 2024 21:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] ptp: fc3: remove redundant check on variable ret
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066763448.3253460.8196124095861512095.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 21:00:34 +0000
References: <20241031135042.3250614-1-colin.i.king@gmail.com>
In-Reply-To: <20241031135042.3250614-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Oct 2024 13:50:42 +0000 you wrote:
> The check on ret has already been performed a few statements earlier
> and ret has not been re-assigned and so the re-checking is redundant.
> Clean up the code by removing the redundant check.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/ptp/ptp_fc3.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [next] ptp: fc3: remove redundant check on variable ret
    https://git.kernel.org/netdev/net-next/c/5c87206cdb53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



