Return-Path: <netdev+bounces-253108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKnhLpwsdWlTBgEAu9opvQ
	(envelope-from <netdev+bounces-253108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:33:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E157EE90
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F2DB3002B4A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730D21FF2E;
	Sat, 24 Jan 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQbv/VgY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344961373;
	Sat, 24 Jan 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769286806; cv=none; b=RdSr0MCfrumfCS4eME7A1EKpIaHfGUfwfrM8uiIvmv4BrGzMBBRikYL0MiO90yeEXT+IaKFi+XvjE0n8fuswl8UWw07S0L6lKYqwuqvd1yBG28DDUVWZojNfbwOXzOwobzmUTkM8hMBsrOt5CE9qd3M4TbTpKdInHRoUWpOLSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769286806; c=relaxed/simple;
	bh=oVbpmkZFQYdpDoW3/8fd52Zh0tsFSo1CFd6atGF80N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJO1LO6yQmUN3+yjM6P4+ETnJVk/7cFOng6nJPZgVNufz0N8dykqCtCm14tW7hZwSSFFEBHmvnE6F0Rt/U8t+G4+SQemLn2HbYbR5Or4bUDLvAdxmloqBwO3biGCJyUufuAANyNCmpEem7nqQZ9BYij2IaMSwCP7jaJOQiTqqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQbv/VgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A572C116D0;
	Sat, 24 Jan 2026 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769286805;
	bh=oVbpmkZFQYdpDoW3/8fd52Zh0tsFSo1CFd6atGF80N4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RQbv/VgYuGJlM+HzKSnheMr5k7V4OgC0tTqOGiX7k2L1148r8rJPCkut/nEX6hHSl
	 ejn3+iNOkj0m9iv3Zn/b1YiH/FmXw3+6vB5egEYx3p9Sd1cvQz2iILf8lzSsJjZKZe
	 N6uapue/fWj4R7CtDE48thNtjeqsTR6BhtRi8maiyiKQIDKCjomenSSaIDsEvppKI+
	 TtsAvKbZfFSsKJ18t793D/5GIg11nfOp5L2paGwkpYnJQx2Oi0tu/2Z8jXV73FuCWB
	 M5qsMzsaX54GoY78+WR07iS2EVEZ1xqivAUEA4XxFbkia075CqRTd6o3BYBa6zwAuZ
	 4TKyHXa5pTMTg==
Message-ID: <222170f6-0095-4930-b6b7-cc309ba45ac1@kernel.org>
Date: Sat, 24 Jan 2026 13:33:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: decnet: fix build error due to incompatible pointer
 type, in dn_dst_gc
Content-Language: en-US
To: Carlos Bilbao <carlos.bilbao@lambdal.com>, davem@davemloft.net,
 kuba@kernel.org, jmaxwell37@gmail.com,
 linux-decnet-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bilbao@vt.edu
References: <ecb0ffd9-4a1f-4579-bff8-264aedb5bab1@lambdal.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ecb0ffd9-4a1f-4579-bff8-264aedb5bab1@lambdal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253108-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lambdal.com,davemloft.net,kernel.org,gmail.com,lists.sourceforge.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: D9E157EE90
X-Rspamd-Action: no action

On 1/23/26 4:23 PM, Carlos Bilbao wrote:
> Update the signature of dn_dst_gc() to return void instead of int.
> 
> This change is required because the .gc member of struct dst_ops was
> updated to a void return type in a previous commit [1]. This leads to the
> following build error:
> 
> net/decnet/dn_route.c:132:10: error: initialization of 'void (*)(struct dst_ops *)' from incompatible pointer type 'int (*)(struct dst_ops *)' [-Werror=incompatible-pointer-types]
> 
> Note that dst_alloc() inside net/core/dst.c was already updated to
> ignore the return value of this callback.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=af6d10345ca76670c1b7c37799f0d5576ccef277
> 
> Fixes: af6d10345ca7 ("ipv6: remove max_size check inline with ipv4")
> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
> ---
>  net/decnet/dn_route.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

commit 1202cdd665315c525b5237e96e0bedc76d7e754f
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Wed Aug 17 17:43:21 2022 -0700

    Remove DECnet support from kernel


