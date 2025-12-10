Return-Path: <netdev+bounces-244236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC87CB2B6C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED06315757F
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57E3126B6;
	Wed, 10 Dec 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lENO83pr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6E279346;
	Wed, 10 Dec 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765362699; cv=none; b=Do//idyaHdYFlFVhHkj3/0a4qdg1go26p47RoaK4SCz1fMODhJracwExn5WRyIrY8AAC1jDSgg2gzTZxw+sgY7+4J0/k+ps/VD5CshLSTv+4LXqMnJJoAeMzTol0oHkrpi0PrF6wr5U6DQRZVnx30IwPG9+1PjicBWJksqsAD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765362699; c=relaxed/simple;
	bh=Z/rC3XU/U+sDX/Cs5ckZ5TyErgthZXeTjo5S7A7/m88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJQ9h3ulCwid7OLZbilmx85D8Qwb5TAfNFInJrvjUubx9V1Tf4WPRKcYTWW5iWkZmTxwOvcyRxUCwFHEHPG1+p45okiOuQwrxOCoLflr99+5U8WDizzTyIW8HfoXDw5KaLZ7SmraiIeQeG6WaxRehqp/KZzNmUYsy9au1UMx5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lENO83pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BBCC4CEF1;
	Wed, 10 Dec 2025 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765362699;
	bh=Z/rC3XU/U+sDX/Cs5ckZ5TyErgthZXeTjo5S7A7/m88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lENO83pr14cQluDUX4T+W+fuYrIVfJEyLNtaEqZkJB1BAP4xqqOfuFyxD8ccoHyii
	 xOEl+6EMFpRHODuRv24B3sSA8lHh8FSdea8WtUg87cDfezuFVt26/kfIp+177HnPfQ
	 KwpMo2F6AIfhtJ6FWk/dIbJWJ6WlRQ6loA7A8bgR+l1cor0TXXHYcY5ZQWaEAcqEnM
	 LbWoF52RPGARVXHDuS3HppT3aoMniURLzMqBYdvJzE3fnQglSa8lwHMIKLu1Xr51Eu
	 ZSCUcKWG8SX/TigjXCRO6GZq7EWeQYPXMIYOmqHYsk+XpkbQDy2TAIieq6bE7uN+eU
	 p6XCVQAnPFUog==
Date: Wed, 10 Dec 2025 10:31:34 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: Re: [PATCH net v3] net: atm: implement pre_send to check input
 before sending
Message-ID: <aTlMBiGNH7ZChSit@horms.kernel.org>
References: <tencent_4312C2065549BCEEF0EECACCA467F446F406@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4312C2065549BCEEF0EECACCA467F446F406@qq.com>

+ Dharanitharan

On Thu, Dec 04, 2025 at 07:17:22PM +0800, Edward Adam Davis wrote:
> syzbot found an uninitialized targetless variable. The user-provided
> data was only 28 bytes long, but initializing targetless requires at
> least 44 bytes. This discrepancy ultimately led to the uninitialized
> variable access issue reported by syzbot [1].
> 
> Besides the issues reported by syzbot regarding targetless messages
> [1], similar problems exist in other types of messages as well. We will
> uniformly add input data checks to pre_send to prevent uninitialized
> issues from recurring.
> 
> Additionally, for cases where sizeoftlvs is greater than 0, the skb
> requires more memory, and this will also be checked.
> 
> [1]
> BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
>  lec_arp_update net/atm/lec.c:1845 [inline]
>  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
>  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> v3:
>   - update coding style and practices
> v2: https://lore.kernel.org/all/tencent_E83074AB763967783C9D36949674363C4A09@qq.com/
>   - update subject and comments for pre_send
> v1: https://lore.kernel.org/all/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com

FTR, a similar patch has been posted by Dharanitharan (CCed)

- [PATCH v3] net: atm: lec: add pre_send validation to avoid uninitialized
  https://lore.kernel.org/all/20251210035354.17492-2-dharanitharan725@gmail.com/

The main difference between that patch and this one is
a check for msg_size being present in linear data.

I would appreciate some collaboration between the authors of these patches.

Thanks!

-- 
pw-bot: changes-requested

