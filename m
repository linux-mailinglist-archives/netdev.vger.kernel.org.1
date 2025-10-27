Return-Path: <netdev+bounces-233309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BDC1175B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6721A60701
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E7931C580;
	Mon, 27 Oct 2025 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7iEJ20i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FF2DCC1C;
	Mon, 27 Oct 2025 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598862; cv=none; b=diiqBd3TGN/z39cmQu5zfFUjnIqNOPe3/BDlmt+MaotLe0gFs/1L7SQ99vrYoN+KS0Wx4sSCS6jvSrNkI2w/Esf8LGjg5OmIkqt7k9LM3qxLJ1NsHCxSgEfvdAjXdIiTeDJ9vpYUn4xAKktA9LSr4hDhxlig5HBX2lvhzDzh09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598862; c=relaxed/simple;
	bh=Ju/F0AdkyNo49mZUGEPu1WxopN//rz1xdQNcnzbj0EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILhhEOY2Ja4o2gX2panhPWMF91risTIkoxmWUPUvzsqtgcOOAQL1EasSO9lsnc18WrmGCx0jVdABnkIJYXMwMxkYBoUsEBGlUKufVfIkMuUtOZk2JSN/OxX6RWJnLGKkPEqXNx2WawOhNmnInys0oMn3czZZzd1GWKv+AuHbcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7iEJ20i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ABDC4CEF1;
	Mon, 27 Oct 2025 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761598862;
	bh=Ju/F0AdkyNo49mZUGEPu1WxopN//rz1xdQNcnzbj0EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7iEJ20i8qpXnQpPeXqmqSBdS2bE7WMZ72ialVxwuDeo2TZrK9uOi8FWLFhU0sjC6
	 z6jcZhS2zUnhxj3C90CWiVgCIWR3amCabLtpvdqnMvTMHEjEMszgCqp75HFdpWnWzk
	 wjPlUnhZ0rm9qTuwfnTpt0394BgaRMcc8TAA+Ydt9QePYz3BMCd2zk/sqlhC4OBpZF
	 s4JtSIWCNGmSR4VWIstc1Jj+nqJxeyE0/I7598pNr9VeUG7m8pWL9pJZ0XdpRNHaHC
	 1LgwinzdCXX6EfELmCIRsBPDLK+lKh9GzSUSrnlZMfuJDZEhErlCMp9BgAKGSRKq5L
	 57hbVJFE+7y1g==
Date: Mon, 27 Oct 2025 21:00:57 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	syzkaller-bugs@googlegroups.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	clingfei <clf700383@gmail.com>
Subject: Re: [PATCH] key: No support for family zero
Message-ID: <20251027210057.GA4072277@horms.kernel.org>
References: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
 <tencent_57525DE2DDF41911CFDB8DF525A08D9D9207@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_57525DE2DDF41911CFDB8DF525A08D9D9207@qq.com>

+ Shaurya Rane, clingfei

On Sun, Oct 19, 2025 at 10:34:11AM +0800, Edward Adam Davis wrote:
> When setting the extended skb data for sadb_x_ipsecrequest, the requested
> extended data size exceeds the allocated skb data length, triggering the
> reported bug.
> 
> Because family only supports AF_INET and AF_INET6, other values will cause
> pfkey_sockaddr_fill() to fail, which in turn causes set_ipsecrequest() to
> fail.
> 
> Therefore, a workaround is available here: using a family value of 0 to
> resolve the issue of excessively large extended data length.
> 
> syzbot reported:
> kernel BUG at net/core/skbuff.c:212!
> Call Trace:
>  skb_over_panic net/core/skbuff.c:217 [inline]
>  skb_put+0x159/0x210 net/core/skbuff.c:2583
>  skb_put_zero include/linux/skbuff.h:2788 [inline]
>  set_ipsecrequest+0x73/0x680 net/key/af_key.c:3532
> 
> Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
> Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Hi,

There are several patches relating to this issue. And they seem
to take one of two approaches.

1. As with this patch [a] and [b]: check the return value of
   pfkey_sockaddr_len()

2. As in [c]: correct the type of the family argument to set_ipsecrequest()


[a] key: No support for family zero
    https://lore.kernel.org/all/tencent_57525DE2DDF41911CFDB8DF525A08D9D9207@qq.com/

[b] net: key: Validate address family in set_ipsecrequest()
  https://lore.kernel.org/all/CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com/

[c] fix integer overflow in set_ipsecrequest
    https://lore.kernel.org/all/20251021030035.1424912-1-1599101385@qq.com/

I would appreciate it if the patch authors could coordinate creating a
patch(set) to address this issue. And look over the more detailed response
I provided to [c].

Thanks!

-- 
pw-bot: changes-requested

