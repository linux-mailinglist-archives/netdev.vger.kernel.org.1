Return-Path: <netdev+bounces-166574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC350A367A1
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507803B1AC6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7821DC070;
	Fri, 14 Feb 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA3jdozq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA11B6CE3
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569203; cv=none; b=ZImqH0GcmEtBu2Ix67IBnQTztDmYAZCa6V/4TfjayrOcbQdJ78bxTN3xAt/2mbUXDBUEX1AaVK3qHIAUGpytJpdleM/K+B+XilY1Oykna+2OLR2T7uwlO3cq5/q/rxQz83YwW3HCafQFOD5Of9O5ywHobSg066I75GSGT5zVy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569203; c=relaxed/simple;
	bh=dStZfgLSG7T3LlVifISLksMR1hqM6ineaPRBU9AT+w8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e1IRW8pCZVZ12RCfQpRVkq5Y85ExmRH2JvMAYKT8TC7RJ7l7WfYOY9EJrQP/K9xECmlPDRKJuB8bWKC5UcwrqI0okvtrM9z2rbYbJvLM1l7AZiZJxFXkh8VXgHUQ1XgR/4dUmVW8+PQq0g84ms7mO+Ufi1IZgQbmX1OS+VOhXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA3jdozq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39191C4CED1;
	Fri, 14 Feb 2025 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739569203;
	bh=dStZfgLSG7T3LlVifISLksMR1hqM6ineaPRBU9AT+w8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iA3jdozqRt/MiO9+hdf1AVv4525khwu9RaZI/XnAsggl32HNwI8LsWByWx4ujBt8a
	 8imeH1/dTKN+1mz22P1kvzrBXaqjUynxV3541hECkPYwyLnfKIn6OdMdxXv32mc6Ff
	 A17bFwqUnrJ6P9b5H1We4S5SYB9FlAwCyqEJ3Et7HMSdxo0nsqOIhi7OnQB2BvZdc/
	 hrroW05wxRUXXATUth9vlUFwlIh+XEKfT6XQSMbTHWYhdlQz0NnRYD3yOGfkB2WyZv
	 Bkoqe1Q7SLqUFb/4SPdxof5utYuDiEt075+xrKa2y7CVDI0RRZ87wA8XBzRxU0zTP3
	 Inrb4ZVfysypA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB15A380CEE8;
	Fri, 14 Feb 2025 21:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH NET v2] gve: Update MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173956923274.2112679.12370063514330712389.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 21:40:32 +0000
References: <20250213184523.2002582-1-jeroendb@google.com>
In-Reply-To: <20250213184523.2002582-1-jeroendb@google.com>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 10:45:23 -0800 you wrote:
> Updating MAINTAINERS to include active contributers.
> 
> v2: Rebased.
> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [NET,v2] gve: Update MAINTAINERS
    https://git.kernel.org/netdev/net/c/054e61bb1de4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



