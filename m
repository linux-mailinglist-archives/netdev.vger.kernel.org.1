Return-Path: <netdev+bounces-233308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E581DC11755
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AF894EDDEC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A158320A02;
	Mon, 27 Oct 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph8hWGJI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFB31E0E1;
	Mon, 27 Oct 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598799; cv=none; b=n4w7oIu0xUCRtifVB04yJl6mgyEN6+hLjcYVEZguAcGtQ+x9lEHmmiJAWXnV6imn5eF/yb0JZuyJYaVzZIO1Y6uvqi7iiDRiQfp9r8C7itQ0taRwIqpiCr7BNhuMi2o77GnFPvXELdmg/GuFJc7PmCA2dAvzoAKNk6IoeDWWzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598799; c=relaxed/simple;
	bh=X+0igtdlsIOxZ2hhWt6o7vw57Q7B+8g4cxNE9CQtKJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrHa6cfI/k21sPDJGd8WTCFRRU0RhJz1O/QsiBPQM6Pfi8ukdPK9FYRGHxNQ4duJxbBBXKtOOFvNPvx3fPhuekyj6q56fcEpwZiq1Q1VcGaUbRs684NQaelLiVpi1UPVJnTsqOhlHZIGyMvDQmUeCRDNSC+jZo4GyO6XX9pBMsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph8hWGJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49917C4CEF1;
	Mon, 27 Oct 2025 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761598798;
	bh=X+0igtdlsIOxZ2hhWt6o7vw57Q7B+8g4cxNE9CQtKJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ph8hWGJIYYJDI7yGl/qQI9giUZrrh+uynDcMrzmDFkan3Qv3dKk+WEwWM3ys2lS+Z
	 OQ38ykN/tWzghidrqz3RiWTrKBJr4ziZdiQngZLmOTr9QizsYIWyeaCmN5hZJwsMd5
	 1FUJkvsIHGgxpUgzJcHshQF0S8vFx0xr1xEIPb2kT/BMJtF0i7mBRRmp/dVVHICjia
	 0QVfUNKLs/QXrS7Wo7JC7KomgwHI9xACCgSH7+SPMR9Yvqueqv9zfZ67ZGCrzb4olJ
	 /no5DsygSyItPOjRDjZQr5NiQp+8kLKqDAsyeYHE5zP06rRXWsIDeQjM/328SiebPu
	 V7CZHwxwrnIbQ==
Date: Mon, 27 Oct 2025 20:59:55 +0000
From: Simon Horman <horms@kernel.org>
To: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Cc: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	Edward Adam Davis <eadavis@qq.com>, clingfei <clf700383@gmail.com>
Subject: Re: [PATCH] net: key: Validate address family in set_ipsecrequest()
Message-ID: <20251027205955.GA4074718@horms.kernel.org>
References: <CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com>

+ clingfei, Edward Adam Davis

On Mon, Oct 20, 2025 at 08:19:50AM +0530, SHAURYA RANE wrote:
> Hi syzbot,
> 
> Please test the following patch.
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> 
> Thanks,
> Shaurya Rane
> 
> 
> >From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> Date: Sun, 19 Oct 2025 23:18:30 +0530
> Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()
> 
> syzbot reported a kernel BUG in set_ipsecrequest() due to an
> skb_over_panic when processing XFRM_MSG_MIGRATE messages.
> 
> The root cause is that set_ipsecrequest() does not validate the
> address family parameter before using it to calculate buffer sizes.
> When an unsupported family value (such as 0) is passed,
> pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.
> 
> In pfkey_send_migrate(), the buffer size is calculated based on
> pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
> family=0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
> (16 bytes) is allocated per entry. However, set_ipsecrequest() is
> called multiple times in a loop (once for old_family, once for
> new_family, for each migration bundle), repeatedly calling skb_put_zero()
> with 16 bytes each time.
> 
> This causes the tail pointer to exceed the end pointer of the skb,
> triggering skb_over_panic:
>   tail: 0x188 (392 bytes)
>   end:  0x180 (384 bytes)
> 
> Fix this by validating that pfkey_sockaddr_len() returns a non-zero
> value before proceeding with buffer operations. This ensures proper
> size calculations and prevents buffer overflow. Checking socklen
> instead of just family==0 provides comprehensive validation for all
> unsupported address families.
> 
> Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
> Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of
> endpoint address(es)")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Hi,

There are several patches relating to this issue. And they seem
to take one of two approaches.

1. As with this patch, [a], and [b]: check the return value of
   pfkey_sockaddr_len()

2. As in [c]: correct the type of the family argument to set_ipsecrequest()


[a] net: key: Validate address family in set_ipsecrequest()
  https://lore.kernel.org/all/CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com/

[b] key: No support for family zero
    https://lore.kernel.org/all/tencent_57525DE2DDF41911CFDB8DF525A08D9D9207@qq.com/

[c] fix integer overflow in set_ipsecrequest
    https://lore.kernel.org/all/20251021030035.1424912-1-1599101385@qq.com/

I would appreciate it if the patch authors could coordinate creating a
patch(set) to address this issue. And look over the more detailed response
I provided to [c].

Thanks!

