Return-Path: <netdev+bounces-83880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC8894AAA
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55682869D1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D29199C7;
	Tue,  2 Apr 2024 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC+xfTyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EA19477
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033435; cv=none; b=mtIB1eoy9TiisCzM2YQjshq+bOZnWmAayj96CRTs+YIXlUFG+ZQIbd8z8vxPA0v//KfblPw/Pml+r7p8aOradvwynNhAozm2G0ALUFkSqiNITQ51MfL3/nZdO8nsapp4MLuNEPfqtxXnEBtFBADpv0H9F+TBpxgduFLKbaZkWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033435; c=relaxed/simple;
	bh=yFZ/MVmRw2wFDE3hB0K6UAIGlEHWoGVz5lDIPk1b2vw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qfUB353mkzima10BqodK+o8vHilSnb2dlBvhahvq+KIvebwb8KbnUUQQDqB/u4cJcr0BmisW8gUTAq45ShLLkuxcNoYizJkNtl7w8uTx0NJP+NZQiStwP6JGYTyKRnHaWZZ2ySs8egKiAPiUexUrTrZc6hZDdb8XgekWTKDbC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC+xfTyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC970C433C7;
	Tue,  2 Apr 2024 04:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033434;
	bh=yFZ/MVmRw2wFDE3hB0K6UAIGlEHWoGVz5lDIPk1b2vw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SC+xfTynDraeHBJHIHmBpYtEW7tOVnynX0qovuJk5zt38AVc91JOtBJldA4VCjFJF
	 UUKUI5RbaBm4ExWCDl2lS0F8LpeG4a3nCRtEG1WCUp9oKyzBCDdZicperOfqRtXb4w
	 3Zvd+LaZbN7NGg3Ws+2Tmp6E39J2m/fVmeele1bhZHz7p2jsxehTcvshJ2KW78xFa5
	 YSvUvKHhCP7ysEqBwsSreS0AGV55JzDPb3cMNGkIqT+aBy2d0uviSTdqNTRxEqgvnR
	 6vHYS3kErbeRyklKyviFYvm5QHG78sDXXy9GnU0ufA7KN32M5JHJ41sELUNxxZ1t9m
	 LyNUXRAg/pyoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3E54D9A156;
	Tue,  2 Apr 2024 04:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: preserve const qualifier in inet_csk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203343479.12415.12810215407100077228.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:50:34 +0000
References: <20240329144931.295800-1-edumazet@google.com>
In-Reply-To: <20240329144931.295800-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 14:49:31 +0000 you wrote:
> We can change inet_csk() to propagate its argument const qualifier,
> thanks to container_of_const().
> 
> We have to fix few places that had mistakes, like tcp_bound_rto().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] inet: preserve const qualifier in inet_csk()
    https://git.kernel.org/netdev/net-next/c/58169ec9c403

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



