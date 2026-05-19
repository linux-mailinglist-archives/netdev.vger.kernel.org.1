Return-Path: <netdev+bounces-289231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMofNlm6C2q3LgUAu9opvQ
	(envelope-from <netdev+bounces-289231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95C575FAD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D38630620E0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC402BCF46;
	Tue, 19 May 2026 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy4mWYxP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71202F1FC9;
	Tue, 19 May 2026 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153403; cv=none; b=gF5yDlLrfv2jeuXVfvvf87iwj+BBWc5iEWymyU/8YIWhzT/AcLfxcWC/377pkNjfajH7QWvnGrb/x/8kokgovoNOefTh/l58bQiTIZFSNK9isVvffG7hfZ9VAwq21yCQGOJFGIPvM26GNelKobT9n4n3p1iPm+vqFYUOfsKkcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153403; c=relaxed/simple;
	bh=Jl2e0t1wQgg3zWhQrUsPZKbQH8QzQ3ZL9paEXWzMHfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVQyqHirAPc+qrWWs+o4t6krouD6dCsmn9HcekVe/w7jHmP2yHyRr5yMy58PwbzH/6FLeite08YFogbRAnIbgvpJTfQW9FTpvs8PkYl675PIlPnBmEXdeq+GTuBbXzMpM3/aCnbNd3QnmW9ds9Jx0kIQ9czfOPohw6cylBoanxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy4mWYxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF49C2BCB7;
	Tue, 19 May 2026 01:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779153401;
	bh=Jl2e0t1wQgg3zWhQrUsPZKbQH8QzQ3ZL9paEXWzMHfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hy4mWYxPPWZ210C0KjkvgPSDh36Az4RVNg+rXf/VnqDHaP8BNRg9UrJAKUH/3RnlV
	 o8YTG9WNcH2mx6wRSRxkPHYD3IOvbPA2apRslZmLsUZ4G67bvfoDiBF50g3o+Nqf5y
	 mo0bgxMEzdmbyzw8hNrJW0n2saTJ5FJLQfyZ0mjOSwjQQe3SYMmG7iaApqLT0CFjrK
	 rj+CIA0YvTVBnpiOxlEN+iSPAMox1j/W+VaWg7hQGLpW3JqD5ftDbUh032PnqE+ftl
	 65VxDad6FLAMRZnZ/Tdg8XXusP7cYXG8tt+lD8sLyaHsAOhSH4d+WAEWKg0Z+a8Vnf
	 OQCHNJsL75NtQ==
Date: Mon, 18 May 2026 18:16:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
 syzbot+9744ccaabe337c6fb123@syzkaller.appspotmail.com, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Victor Nogueira
 <victor@mojatatu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: re-enable queue reset on root qdisc
 graft
Message-ID: <20260518181640.150337d5@kernel.org>
In-Reply-To: <20260514031242.2667-1-jiayuan.chen@linux.dev>
References: <20260514031242.2667-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289231-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,9744ccaabe337c6fb123];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C95C575FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 14 May 2026 11:12:41 +0800 Jiayuan Chen wrote:
> Commit 47e8dbb6e763 ("net/sched: do not reset queues in graft
> operations") changed dev_deactivate() in qdisc_graft() from
> reset_needed=true to false. This was the right call for graft paths
> where the new qdisc has an ->attach op (mq): the new root
> takes over per-tx-queue state via attach, and a blanket reset would
> needlessly drop packets in unrelated leaves on every graft.
> 
> For the path where the new qdisc has no ->attach (e.g. HTB, sfq
> as root, or qdisc_graft() called for deletion with new == NULL), the
> old root subtree is going to be torn down anyway: every leaf will be
> freed shortly via __qdisc_destroy(). Skipping the early reset there
> provides no benefit, but it leaves leaf qdiscs with their queues
> intact during the window between rcu_assign_pointer(dev->qdisc, new)
> and the per-leaf sfq_destroy()/timer_delete_sync(). If a leaf has a
> self-armed timer that walks the parent chain (sfq_perturbation ->
> sfq_rehash -> qdisc_tree_reduce_backlog), the timer can fire after the
> old root has been swapped out, find dev->qdisc no longer matching,
> and trigger WARN_ON_ONCE(parentid != TC_H_ROOT).

Is not resetting root really worth the extra code?
We care about mq not resetting for each child N times
more than we care about the mq itself?

If we do care - you're breaking reverse xmas tree,
and "need_skip" is quite a poor choice of a name for
readability. 

> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 6f7847c5536f..932cd1144b2b 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1097,6 +1097,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>  	struct net *net = dev_net(dev);
>  
>  	if (parent == NULL) {
> +		bool need_skip = false;
>  		unsigned int i, num_q, ingress;
>  		struct netdev_queue *dev_queue;
>  
> @@ -1123,12 +1124,15 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>  			}
>  		}
>  
> +		if (new && new->ops->attach && !ingress)
> +			need_skip = true;
> +
>  		if (dev->flags & IFF_UP)
> -			dev_deactivate(dev, false);
> +			dev_deactivate(dev, !need_skip);
>  
>  		qdisc_offload_graft_root(dev, new, old, extack);
>  
> -		if (new && new->ops->attach && !ingress)
> +		if (need_skip)
>  			goto skip;
>  
>  		if (!ingress) {


