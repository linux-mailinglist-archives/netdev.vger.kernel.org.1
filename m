Return-Path: <netdev+bounces-117051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845E94C86A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713921C2203C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 02:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5A16419;
	Fri,  9 Aug 2024 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eujbSvn6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371731401C;
	Fri,  9 Aug 2024 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169741; cv=none; b=HIufNbeSUK1hcufXDRH9phMvvg7MwSI/heFYcWkeNH+nW5TYvir+aqCluFmxrTaqvlSjyVTPHgvabkRFoDNAJUmhPY84uqhjr0GEnpYibkgYKAUt0NnhCqBJHmoUqTBcQlIMzkTG7QGTgG9AfcYLHsYr34vpVo5+DayOJNBCzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169741; c=relaxed/simple;
	bh=nJuswpyVmo6EC4IpZyEB8KNszJ78dYeSsIYznjgXYsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyBF4dIKlfIN49KYGPA4arQkNBbQAN+vFZXGtzdcKtWZComP58atEjNUN7VGeH1zJM1wq/jFQRYjmKjJr7jNzmvpDYGyEO5IB/eWKg9t3rWv/NDpvYD3Z638nNTCm/79/MQHER9bZTyCEm0tbPHv7qZVpvPNDMPY0ehSTkgjyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eujbSvn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F5CC32782;
	Fri,  9 Aug 2024 02:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723169740;
	bh=nJuswpyVmo6EC4IpZyEB8KNszJ78dYeSsIYznjgXYsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eujbSvn6/xFJA0eRi7aEOiDAtjKEngaauVXJ4EWIxSDo50iUkvkE/wEO2u3lpIpdJ
	 Sk16nQfAvHFnf/D12uHrIXe6GgCAsTujXypo/JdPn7dPhJOG0kMan7ivYIZZJygbmS
	 RIaR3bfnKsywLL6hdHHXEhqJQMw752KMmx43ajdsde1yzkfUiqoPfvRoA2D2OtZ8+T
	 rHYnitLW0V4iz9fYwmcsyG4HlkHNTSDDy8F8AtWgC8DJ7xORoQKBlBUWjFdV9fHfpv
	 srAgFBIWhZ4pgWnZnD+S4VVY6fCpeKPSFTGiM9VnT+DXVKmKTEFhW/mVzAQAuVAsTF
	 mv9i94TxnV3eA==
Date: Thu, 8 Aug 2024 19:15:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Potnuri Bharat Teja
 <bharat@chelsio.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cxgb4: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240808191539.615733ab@kernel.org>
In-Reply-To: <111cc058-a681-4aec-ace4-cd6bc19699f7@embeddedor.com>
References: <ZrD8vpfiYugd0cPQ@cute>
	<20240807200522.2caba2dc@kernel.org>
	<111cc058-a681-4aec-ace4-cd6bc19699f7@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 12:41:32 -0600 Gustavo A. R. Silva wrote:
> >>   .../chelsio/cxgb4/cxgb4_tc_u32_parse.h        |  2 +-
> >>   include/uapi/linux/pkt_cls.h                  | 23 +++++++++++--------  
> > 
> > Took me a minute to realize you're changing uAPI.
> > Please fix the subject.  
> 
> What would be a preferred subject?

The point is that include/uapi/linux/pkt_cls.h is the more important
change.

net/sched, based on:

git log --oneline -- include/uapi/linux/pkt_cls.h

11036bd7a0b3 net/sched: cls_flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
bfda5a63137b net/sched: flower: define new tunnel flags
6e5c85c003e4 net/sched: flower: refactor control flag definitions
1d17568e74de net/sched: cls_flower: add support for matching tunnel control flags
6dd514f48110 pfcp: always set pfcp metadata
82b2545ed9a4 net/sched: Remove uapi support for tcindex classifier
41bc3e8fc1f7 net/sched: Remove uapi support for rsvp classifier
ba24ea129126 net/sched: Retire ipt action
35b1b1fd9638 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
4c13eda757e3 tc: flower: support for SPI
4d50e50045aa net: flower: fix stack-out-of-bounds in fl_set_key_cfm()
7cfffd5fed3e net: flower: add support for matching cfm fields
1a432018c0cd net/sched: flower: Allow matching on layer 2 miss
8b189ea08c33 net/sched: flower: Add L2TPv3 filter
f86d1fbbe785 Merge tag 'net-next-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
5008750eff5d net/sched: flower: Add PPPoE filter
94dfc73e7cf4 treewide: uapi: Replace zero-length arrays with flexible-array members
b40003128226 net/sched: flower: Add number of vlan tags filter
e3acda7ade0a net/sched: Allow flower to match on GTP options

You can throw in uAPI somewhere in the subject, too

