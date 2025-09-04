Return-Path: <netdev+bounces-219762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BE7B42E40
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A233C17E16A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3941A238C;
	Thu,  4 Sep 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj1ySjBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4F32F74A;
	Thu,  4 Sep 2025 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945817; cv=none; b=p/LOnDaaTTc34AnsjgSz2ml0qPg+JdCLpR+jGJI0gAIML76OCJ2ltPpXdVgNTMUAwe1XZTKHjDCoGR1+Kq0HI6DfhHbfqyUgIZfaRPzaTcprpi1TNR+F2KqQQTO+MTQ3rf4NF2cP/kBHcwMxEK2raSr36Sa0gtkxVceJJ/4PAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945817; c=relaxed/simple;
	bh=UN+ZlvorEZUIc/qZ/eTN2cLOXXRnPsm1HRGcViY290Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZuhucEjTl0M2VZEtexOcFs7AiQTJqqK4Nx7Khu90KreOVb3yXT628p8FjX8yYC+oLo1qXO2M3uwHxo3U7e0bC8ukywpSONCZdV3YlDCFTP9KG1vKb97RFg9LLjOl1FvbZsaalKk+c+Mg0FCXDi3WjG0BY/mI9wGSF72ukxKywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj1ySjBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2507C4CEF7;
	Thu,  4 Sep 2025 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756945814;
	bh=UN+ZlvorEZUIc/qZ/eTN2cLOXXRnPsm1HRGcViY290Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zj1ySjBRUZAjkpgWD+Cw2isFNkY1EHXP9axfqx5XLnlx+CK8CuDUinsp5+mOqekF7
	 X6nm2WXVeB4seWUqAyx2BDYH3mzsC6HALfQE4sj2cydRWNM4GNr7H1bfmFtPbi/pP2
	 Azqw9JL7O7CDgB3B6jfu1gHlp3EL/EP1ZwjAIM9lKhZkHpx/OgmoFHIwdiR5TNHUBL
	 lqH8LIR4rv4/R1xLQVDsgtsmL20p0ubqF1IY2xxVn5Yrl7cOnLcBzsTTP+l6Pc3Ad+
	 2wYD/2YNR0UCfkBgd61wfHxFOn9SYOr0+dpwtRK27mIUka3A6DhBUpNC5SKf5lwIQb
	 w+LxcSayxhHbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAC383C259;
	Thu,  4 Sep 2025 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: nfc: nci: Increase NCI_DATA_TIMEOUT to
 3000
 ms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694581999.1248581.11374720068117319452.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:30:19 +0000
References: <20250902113630.62393-1-juraj@sarinay.com>
In-Reply-To: <20250902113630.62393-1-juraj@sarinay.com>
To: =?utf-8?q?Juraj_=C5=A0arinay_=3Cjuraj=40sarinay=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, krzk@kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, mingo@kernel.org, tglx@linutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 13:36:28 +0200 you wrote:
> An exchange with a NFC target must complete within NCI_DATA_TIMEOUT.
> A delay of 700 ms is not sufficient for cryptographic operations on smart
> cards. CardOS 6.0 may need up to 1.3 seconds to perform 256-bit ECDH
> or 3072-bit RSA. To prevent brute-force attacks, passports and similar
> documents introduce even longer delays into access control protocols
> (BAC/PACE).
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms
    https://git.kernel.org/netdev/net-next/c/21f82062d0f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



