Return-Path: <netdev+bounces-263697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L9QAIL+p2nUnAAAu9opvQ
	(envelope-from <netdev+bounces-263697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:42:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA1A1FDC5F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5601A30C693E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7DC39D6C8;
	Wed,  4 Mar 2026 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAp3voBI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K3E4IYZb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE137756D;
	Wed,  4 Mar 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617228; cv=none; b=f7T4KyS5JFw3MykVN+ziyLCU7/C7wCeq8jozrMjiJ7prpTBx6tL5Ye6FcZ6YEynvqmbJGXl6K2TtlLs+tLAHe61yfFNIRJh/J5ahDrLIqJhJCE2YwESasDyxnv93SlUV6KidAAnKJsVK64rpsSWzFFdocV8JkjBtpE63Iy0u2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617228; c=relaxed/simple;
	bh=AO4HBzUh5EP6nb40VVibWTz1NPRn67r816VYbLssLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwStHmg3rvrIVFuyEsXO10p6Q5+9KeTd5RgaGNGYUK+07r/qYYs9Z2Hxg6LDo4GSbQ9D3W5rdLlmkeZF8zVce219+h7BC7pE6V+y0/dHm+u9s9Ier+oPcyQ1nJbHKxhxqPuteOIoHryj3yW0BbhkFcfPLAj5s5bPnoh4GDa5q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAp3voBI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K3E4IYZb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Mar 2026 10:40:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772617222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q657n44NPR8EAAxyaBxEl5qa/lvFmu4t7TcVp8HrJ7Y=;
	b=OAp3voBIC0L4UmhpZ2/EAVtSPuaBfY6rUqIWrxu75Cw+lLn65bvdFd1WzX/AKsNg2gKBiw
	Z6I9txSZCxn1OKQcxSMdmh03zI8UjppHhFwotw05wqcYEIiumIBoMboVyfq349GiDbXlYQ
	ufIqW3hTcq/BKDWlpfn1KMe1HKcftN4QrZqKYxZC8ghFt56WFj4Yjc5fpo0eeHCEVYRyzd
	fp1K19HKj5QkG8YHNN2vzJcArZpDYEemMrqIv7WpG8oLfiwASx4pap/kpsUTx8o4zOTrR5
	guCmjaNKgPjuAvmbzsFavSth2zFbsgSZHzAvPD5UF7Be9/jDOp7n9W1nr6yLZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772617222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q657n44NPR8EAAxyaBxEl5qa/lvFmu4t7TcVp8HrJ7Y=;
	b=K3E4IYZbNFpbtPuBz2Nep+jxFPN0D/7DPJh4DozcQd42LeMWFbaL8m7nL21IIouc5ID0z3
	4mMqBIs4V19rOeAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, jv@jvosburgh.net,
	netdev@vger.kernel.org, jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <20260304094020.mrSO02-z@linutronix.de>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
 <4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net>
X-Rspamd-Queue-Id: 5FA1A1FDC5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263697-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,jvosburgh.net,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-04 09:20:27 [+0100], Daniel Borkmann wrote:
> Arguably it's a corner case, but could we not just do sth like this to
> actually check if the device is up and if not drop?
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ba019ded773d..c447fd989a27 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4387,6 +4387,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>         struct net_device *master, *slave;
>         master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> +       if (unlikely(!(master->flags & IFF_UP)))
> +               return XDP_ABORTED;

preemption (vcpu scheduled), while paused the other CPU could put the
device down, or is it too much of a corner case?
Also, there is also ndo_get_xmit_slave which at this time is only used
by Infiniband and supports only active-backup mode [0].

[0] https://lore.kernel.org/netdev/999129.1772247707@famine/

> +
>         slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
>         if (slave && slave != xdp->rxq->dev) {
>                 /* The target device is different from the receiving device, so

Sebastian

