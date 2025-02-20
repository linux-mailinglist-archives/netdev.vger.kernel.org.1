Return-Path: <netdev+bounces-168212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1FBA3E1BD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902F919C2C05
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB31FFC6C;
	Thu, 20 Feb 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdB1b/kg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0DB1C1F02;
	Thu, 20 Feb 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070787; cv=none; b=KsMKoJN6f1mDcW88Ml19m0GfczD9IKrmfIew8nuQVnH62Fsv0LMjrZfJKBNg0tALIam7XgaYKNwBPxH0niPHlO4dhyRR4pipqZMMF81YZQB4YLJA8udVv6nC/zNFDE1zziVvsNubWw6oK73Q3fJTpdHenfGCkscVWZo2Lq8vuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070787; c=relaxed/simple;
	bh=5bpDcWU8d8GvxsQy1prYmtM/a9rjB8/6Nm/Gqt1Nfvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlMR+TbVAiMponsIvP0V8r93cGT00efPd8vh0StiOXezvx7MmFV4w8Jd21tL8TrE0hSQYBcrVi2vQDYH2BZA3dUU2k/27KbUNfStSRr99Cg9yLjidk+UcA81Os5M40i9ipE2lWaJdJab6fi/cgV8r6+5urBC00VPjA4Egdpn870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdB1b/kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC85AC4CED1;
	Thu, 20 Feb 2025 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070787;
	bh=5bpDcWU8d8GvxsQy1prYmtM/a9rjB8/6Nm/Gqt1Nfvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdB1b/kgMHpLnAOqx+gET0tf3OGl/UB+x9ClkzHu4YbyX0U1vk27Gg9jeBqFTehf3
	 Op7V+nNEK3VuxzHZzSrUGxRm4iOK/l/11g0qpj3lxPnM/WVL7ttazxNKeYB4muHSSl
	 tt9kwPEgOwDEm2F0Z4drQZbMz+3EtH7O0YOyKy/IrkIOEMdfOYJkxnSih6tXCAh6Iw
	 PsDtuxJxjvSYOXr9rBLhSx+kEf4yofJAq5ubYbbsCKJurZ0ptn0+zrTekzWG1AaBSo
	 MqBnL/w07u6A2TpIK4o0CWAoueTPjxgRkSXqG9pV9Tvkglfo57d5XWaRKK0ihqAnBD
	 ++byuwZzvkA5g==
Date: Thu, 20 Feb 2025 08:59:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: patchwork-bot+netdevbpf@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
Message-ID: <20250220085945.14961e28@kernel.org>
In-Reply-To: <12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
	<173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
	<12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 11:01:10 -0500 Sean Anderson wrote:
> > Here is the summary with links:
> >   - [net-next,1/2] net: cadence: macb: Convert to get_stats64
> >     https://git.kernel.org/netdev/net-next/c/75696dd0fd72
> >   - [net-next,2/2] net: cadence: macb: Report standard stats
> >     https://git.kernel.org/netdev/net-next/c/f6af690a295a
> > 
> > You are awesome, thank you!  
> 
> I think this should be deferred until v2 of [1] is applied, to make
> backporting the fix easier.

ETOOLATE :) networking trees don't rebase

