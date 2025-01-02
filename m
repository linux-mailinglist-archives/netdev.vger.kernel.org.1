Return-Path: <netdev+bounces-154763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0B9FFB3D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB8A18839A7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283A1B0425;
	Thu,  2 Jan 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWQA/5if"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8540BF2;
	Thu,  2 Jan 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833440; cv=none; b=FvqdFh8U13zI2yGJz7BqaLDz/hR6XWNY0YbjOmR5FM7GdE19bfBKwqkB3XQDiHpxjEkcGQYSTzl2JIO+xcCzkWAi+fe80jXvSNmR11w54/caZTOjzg6pILlWpAT+EMXCOIwu7bDmM0/JsnzDvPxCcXkLJEMxCTqisQailNZK/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833440; c=relaxed/simple;
	bh=l9krntIFJFgGFkmtKhs3ubXfoLYdo1dGd3fujb63qS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdFoIMMAhimgq4EHKGStZQVZfiGhqVSoYMdKrnIcj3obucJwgPKSyDZVuJ68/HSakRdJUXhKPOknnFVDeVY89BELkN0gejREsRY+NbBF/pQ7HEvpmBZ7q2uDL5ogGEqbCVmbji5zhSnR9B2f/zmPWlJiWOhaPPnKkKaxKr5h/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWQA/5if; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9958C4CED0;
	Thu,  2 Jan 2025 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735833439;
	bh=l9krntIFJFgGFkmtKhs3ubXfoLYdo1dGd3fujb63qS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GWQA/5ifHfAmW52ebrzWPjPHWHUb8Loa0cT4PsfsmvUVhRjgfv/ZpWcPVVV44iIHC
	 bKsRoUCZPiDbMC83ImLbuFqmKm6mstitNOepgNr5aA+HsdQQ5C/tA6NY4h6OXMmJ+q
	 6IBkszDnPvup/cfBcTL0bFgCGnvypTjtSYHpBaz56PotKjtai449QiPJG7IsNBAzQA
	 20e2CC1lJfbpujiBtIWZ89nDEcmL5mhMym77NPlIVjh1KL9i/L1jZH2JVeIw2IVZrS
	 BUwMKBBJaezhcfg3jXKBCIaQleuhDPZmtL04RUNxi9PR43T3d18hHd98xRuG9UMC8O
	 wiAdixR9p92dQ==
Message-ID: <dfd37ca0-14c6-4cc1-8fae-f1aa2d23e148@kernel.org>
Date: Thu, 2 Jan 2025 08:57:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: socket SO_BINDTODEVICE lookup routing fail without
 IPv6 rule.
Content-Language: en-US
To: shiming cheng <shiming.cheng@mediatek.com>,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: netdev@vger.kernel.org, lena.wang@mediatek.com
References: <20250102095114.25860-1-shiming.cheng@mediatek.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250102095114.25860-1-shiming.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/25 2:51 AM, shiming cheng wrote:
>      When using socket IPv6 with SO_BINDTODEVICE, if IPv6 rule is not
>         matched, it will return ENETUNREACH. In fact, IPv4 does not behave
>         this way. IPv4 prioritizes looking up IP rules for routing and
>         forwarding, if not matched it will use socket-bound out interface
>         to send packets. The modification here is to make IPv6 behave the
>         same as IPv4. If IP rule is not found, it will also use
>         socket-bound out interface to send packts.
> 

Please create test cases for IPv4 and IPv6 showing the problem - what
you are configuring and the expected result.

Also, commit messages should align with first column unless there is a
reason for an indentation.


