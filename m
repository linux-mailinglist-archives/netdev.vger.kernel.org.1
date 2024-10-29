Return-Path: <netdev+bounces-139742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F59B3F53
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5020828355D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DB4D299;
	Tue, 29 Oct 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQSTg0FY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97512B63;
	Tue, 29 Oct 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163023; cv=none; b=EpBsj9NK+mlUiIWE0fEboReAwtzZfzWA7BkoTOUtrpxCCHDGAeoB52VqReWm+ckWVnSS7P+x0AZ1l56cGqaHEtDJo1WFnpo8oqLBFGBbQ2cqKigLAbQlVdqC3aMp1Ooh/kdlBt2FrJXZ3ifPWng3Ei4Kn2uOU0vFfgokPUXHGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163023; c=relaxed/simple;
	bh=HoOSDwA1Lhzv3L//OVAE3yDp09ZWHQS+UQaVcH/XsuQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=POxSNun0DmZQwFtNu+gnUM1TSAJCjKjkxiu3jl9NgX3RLhHI6zZcSngFYS/HwzonuAJudh7zPo6+UOztkWnmRXgBpXgbr+hEnFLqIhgJ/3cMzbfZT3Ttd+8KbajdcH5Sq7Qk2q17zpOuWh/98o2iqB5p8keIdmRpfYg9RdveKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQSTg0FY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12135C4CEC3;
	Tue, 29 Oct 2024 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730163023;
	bh=HoOSDwA1Lhzv3L//OVAE3yDp09ZWHQS+UQaVcH/XsuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQSTg0FY9KgAxoJsbzXNI47p7TCFADvo9L00g/lcqNt2KnnuO3nzjikD8nmF4upeq
	 mWUnJn/q4sRg9eepHWr5WTGVkPQ6ttcKgYDFZDiBzdO6CDWO1yUU7aacxB+RQFYoLT
	 7/SwguRI+6ibaJ5oauCFbeCF1cGk4Z0YOlVQ/4tNqFbb0KJ3/sK0QWcMnLvvwNOQUz
	 C+JdActV6ymJzIq4JyAMvavGBl21+gTDfbJr8EA0Iwk7mBSckzLMX0BKvpX0aByGCw
	 iEBsY+G/mHb7BppkrFDhnXZCn+XJsiKEbzw7Otl9HGEvOjx9/X1epkgnRZjqPMSrfD
	 vU+vM/vPk6qEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2F380AC1C;
	Tue, 29 Oct 2024 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: add support for new USB device ID 0x17EF:0x3098 for the
 r8152 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173016303060.228747.11880864939275217972.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 00:50:30 +0000
References: <20241020174128.160898-1-ste3ls@gmail.com>
In-Reply-To: <20241020174128.160898-1-ste3ls@gmail.com>
To: =?utf-8?q?Benjamin_Gro=C3=9Fe_=3Cste3ls=40gmail=2Ecom=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Oct 2024 18:41:28 +0100 you wrote:
> This patch adds support for another Lenovo Mini dock 0x17EF:0x3098 to the
> r8152 driver. The device has been tested on NixOS, hotplugging and sleep
> included.
> 
> Signed-off-by: Benjamin Große <ste3ls@gmail.com>
> ---
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver
    https://git.kernel.org/netdev/net/c/94c11e852955

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



