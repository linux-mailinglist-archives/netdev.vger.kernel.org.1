Return-Path: <netdev+bounces-145518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A99CFB73
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCFF1F246B3
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F37383;
	Sat, 16 Nov 2024 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm0XF7ME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7036D;
	Sat, 16 Nov 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715699; cv=none; b=mxXaz9OPPclgiuxjMshKtU1OoqfuuBdyd9LJsVIGWK0A6XzcDpYYkA8Wzopg9Ybf8u8BKjBzPQv+g6IpRkLSljCkEhhD/v1aKSsRjHN81sAY2biMHU1jNyDeO9TPhpNEfKYUJ0/oBxqYmK6QI127OLmGQxvFnbARzdoH2MxmFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715699; c=relaxed/simple;
	bh=c8v8xPbDc/4iwirqSmQJaogTdm/AhEGIo+tQMRM8OQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4bDgv69GMRi+awApH/cyy8S4JRsLaQL3D8oeTHN2QunhLmwEJeSQW2vf8xiznJJIyT81SfHAojWfmie1gSJ+ioFrh/EC+VMbzoB/nUFNyQEkuhaY2xp8d+D8vHAbj5uM85Q/RM4nu2ThskMNH1b/sadr+f4A0hHnXlB5VdsKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm0XF7ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2158DC4CECF;
	Sat, 16 Nov 2024 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731715698;
	bh=c8v8xPbDc/4iwirqSmQJaogTdm/AhEGIo+tQMRM8OQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dm0XF7ME7O2ruIlmQRmGirE5rDBOoCgmDlamxXJlYjHlweWrdgutxXeGTZzIt+fku
	 6ili11KJ2KgDRG7/vuXp+Kca8el/PnkeI1KkbUvQT7Rs1d/JR++mc+lYoIFQCvX4BF
	 WIsLlz8NxPcPbLaZeULIIAfQPip8lO5PFW+IiLwVfmAd2fAbO053YIeiCnBizDENb4
	 xqpWmvkTJ/30vlNqJxLZCm/vb/uYNOjwhHlQ/318Uqdy5gpd9sCRgYclzWqwSi7qFr
	 sAoFbOGmGqbR44mVTEhSic5nPtuBXW76W+1udJsxy9HdaapwvGZgQmNu0wPaAaVFth
	 +elYkTvRzJzpw==
Date: Fri, 15 Nov 2024 16:08:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ivan Delalande
 <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, Johannes Berg
 <johannes@sipsolutions.net>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
Message-ID: <20241115160816.09df40eb@kernel.org>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 18:46:39 +0000 Dmitry Safonov via B4 Relay wrote:
> 2. Inet-diag allocates netlink message for sockets in
>    inet_diag_dump_one_icsk(), which uses a TCP-diag callback
>    .idiag_get_aux_size(), that pre-calculates the needed space for
>    TCP-diag related information. But as neither socket lock nor
>    rcu_readlock() are held between allocation and the actual TCP
>    info filling, the TCP-related space requirement may change before
>    reaching tcp_diag_put_md5sig(). I.e., the number of TCP-MD5 keys on
>    a socket. Thankfully, TCP-MD5-diag won't overwrite the skb, but will
>    return EMSGSIZE, triggering WARN_ON() in inet_diag_dump_one_icsk().

Would it be too ugly if we simply retried with a 32kB skb if the initial
dump failed with EMSGSIZE?

Another option would be to automatically grow the skb. The size
accounting is an endless source of bugs. We'd just need to scan
the codebase to make sure there are no cases where someone does

	ptr = __nla_reserve();
	nla_put();
	*ptr = 0;

Which may be too much of a project and source of bugs in itself.

Or do both, retry as a fix, and auto-grow in net-next.

> In order to remove the new limit from (4) solution, my plan is to
> convert the dump of TCP-MD5 keys from an array to
> NL_ATTR_TYPE_NESTED_ARRAY (or alike), which should also address (1).
> And for (3), it's needed to teach tcp-diag how-to remember not only
> socket on which previous recvmsg() stopped, but potentially TCP-MD5
> key as well.

Just putting the same attribute type multiple times is preferable
to array types.

