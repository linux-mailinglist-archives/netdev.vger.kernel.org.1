Return-Path: <netdev+bounces-55106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9280967B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CEB1C2074F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069334F8A7;
	Thu,  7 Dec 2023 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7jVF29G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED404EB52
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 23:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5F1C433C8;
	Thu,  7 Dec 2023 23:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701991050;
	bh=GgWNeFHH0noy+8Zj7uuJkxDh7pN7jZgw38zOMrmO9ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g7jVF29GI7p0rt3HNJ51JK2FBfzm0NC+Gy4qkMjE0N0BbVawx8jrfMp/9YNZcHqNK
	 arABPjnLyzbUBONt4eEyC4iWMTEokB5KP7l/t1M98bSubYJ1wA7KkvaCfkFXAvSImY
	 yyjid6PvFIPMHADPfvIKoGqIs1SVuW/35r1snGnnS7PU0+zXJQ5rs3e4KvuHhPeOFW
	 xAx74gyhOBGAXcQa2hzSSQc2Ibl/c28NrdIXmiI1FSi8gXn3AskU+Go+/hEq5Mojo+
	 eMlyS7gq6Q7ezrEnYJ28bAIkw8BW4U6EQ+aHl9+zZNFmyTepuCjXT/i8fbCXbU2RTv
	 TtXQt5meAT4aA==
Message-ID: <8f44514b-f5b4-4fd1-b361-32bb10ed14ad@kernel.org>
Date: Thu, 7 Dec 2023 16:17:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: insert the fib6 gc_link of a fib6_info
 only if in fib6.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com,
 syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231207221627.746324-1-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231207221627.746324-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 3:16 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check f6i->fib6_node before inserting a f6i (fib6_info) to tb6_gc_hlist.

any place setting expires should know if the entry is in a table or not.

And the syzbot report contains a reproducer, a kernel config and other
means to test a patch.


