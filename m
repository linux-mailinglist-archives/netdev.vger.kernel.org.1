Return-Path: <netdev+bounces-66357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A183EAAB
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6F41F2407F
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7741170A;
	Sat, 27 Jan 2024 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y9qrREH9"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686412B68;
	Sat, 27 Jan 2024 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706327090; cv=none; b=pJ1T1/unZLlcE2M8OjmaxRmEQIBUgysP4EXX46IYzBndpcYEzl6DlYAb3X+znqul+JBwgS7PIEObDg1jjHb9FIY0DiRrlS4o1FVPC5n8ThmLHybpOEJk+apRxaPB9TmFuzogG4xrYiqiPI8GqOeoCsscuLoIEhz7Bx9L7o2iLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706327090; c=relaxed/simple;
	bh=rsTZ4KwLQF2vdV6nBYBkQDb2Atu1jNmWJuAxnllKl/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkOskyi3LM1VSYffRzjJWwDlwTmlW9OCW9j91Im+VNUMLAbuPudIQBVO75yv8SAwaWe0rg+9ZyewmMstYXatI1grtXG138yo+CIOEWThRHW3wOZ7aZU7qrpQLvc5XUtLnvRE3ADiUyoS7kYVxFnoaOWHQKLfjpWS+oJSY0X2ehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y9qrREH9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iBPLDORwbabHqdwlo5cfEvCIBCQuAnR4A1y9DYY5Uh8=; b=y9qrREH9wgeisJkX8eVZRnSnSP
	GoYo1cImMGMsKUG9Jt195GUgqI9Rwz3qSRs3D+6n0L2uCG5kYciTOtWtAeAmHfZBmHNUvZ1kS6Q/Q
	mPTOD2/mMb7EwHFKvz3IPSi7ql2pMyDuRA7IL+85AOXn1aHqFHv6mzlE5QyQ2m+zQqWrTHezdHkyk
	crm/O6JA/d/AU3FjdfCCljFixsTxuZZGxI+IJ1ND0tMruVg4+9ArCXkZ7dnta9bi2epRTLPRFwH7P
	tb0m7k1bUYz9vSZ2huyLgmWAoJpPLheAXaKcVaR6P56I3cFr+cWwRU/HLkyC/DkXhQsaxn/6bc3l1
	R7n8NFNw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTZcX-00000006fhV-2asJ;
	Sat, 27 Jan 2024 03:44:41 +0000
Message-ID: <501aa5d8-9376-4479-b3d1-18f3b92898c2@infradead.org>
Date: Fri, 26 Jan 2024 19:44:40 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tipc: Remove Documentation Warnings for `Excess
 struct member`
Content-Language: en-US
To: Carlos Ortiz <jmp0x29A@protonmail.com>,
 tipc-discussion@lists.sourceforge.net
Cc: skhan@linuxfoundation.org, Jon Maloy <jmaloy@redhat.com>,
 Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240127032058.3030-1-jmp0x29A@protonmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240127032058.3030-1-jmp0x29A@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 19:21, Carlos Ortiz wrote:
> As far as I can tell,the struct `inputq` and `namedq` were never part of the `tipc_node`,
> therefor removing the documentation comments this will make the warnings for ./net/tipc/node.c when
> running `make htmldocs` to be gone.
> 
> For socket.c, and documentation comment was added on commit 365ad353c2564bba8835290061308ba825166b3a
> but the struct member was not added in addition of removing `blocking_link` also move `dupl_rcvcnt`
> documentations a few lines up to match the struct member order.
> 
> Signed-off-by: Carlos Ortiz <jmp0x29A@protonmail.com>
> ---
>  net/tipc/node.c   | 2 --
>  net/tipc/socket.c | 3 +--
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 

Hi,
These are already fixed (recently), but Thanks.

https://lore.kernel.org/netdev/170614862613.13756.7070098094645334807.git-patchwork-notify@kernel.org/
https://lore.kernel.org/netdev/170614862616.13756.18046951576152774345.git-patchwork-notify@kernel.org/
-- 
#Randy

