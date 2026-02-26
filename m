Return-Path: <netdev+bounces-261269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPSHOMUaoGmzfgQAu9opvQ
	(envelope-from <netdev+bounces-261269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:04:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DC1A3EE4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF583301750D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B093A0E9D;
	Thu, 26 Feb 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbtKeFL9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oafF1Wkj"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CF22157B;
	Thu, 26 Feb 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099945; cv=none; b=uN7Zf3Fr7Z1I89I421HflX/Yz/A/ak8EPTpDGsHhEpgKtjAjxzqy/JxAyRtQTp5/yoODYdhiddESVEcT6RVkSMazdwtKBFGyckn0H1kqf70k0T4pWG8Q3+7j77ZtVY2Qjup5BmlwhqkzG+5D6RgigSb3l12vJsoHKSaI2WWQL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099945; c=relaxed/simple;
	bh=xnsgGhCAvA/FGKQrDFk3LFrWwe8fzOofaCQtVEYGFDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF5NG6r3FQevOrLf2PYGUfBA7NQsR4xgkLyg6TByB8sJHgX+g33DAiAXY9pwZ4XHUmBy0EVxzHKXR8vmayYB/fRMmITkrFVzbQkoX9MzrmcadKaKYqNLrpD6NaQv6bKsDmQuT23zlpz6TI3SbvHO9er5qG9MJwJDR+GSvY3phog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbtKeFL9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oafF1Wkj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Feb 2026 10:58:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772099941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYam34fvx910nzxtv0zP2ACsjNjwt7ARQIEtWYy7sKs=;
	b=JbtKeFL9cdPIQli9XdfpGHUlRUhvSy+1UoKZzpP0A9RjaDuvQSBpI/FcQFO7M3HwIEo/Qi
	+fINqS1y0o+Gxpsl6HE7D4xJXs8KThO4Ax5qSptIIZBqHgFlEnN5Q+kerK2rKB/iTW3UUZ
	e0u80Pba6Ui8GYwmD5dTu9iY5l5m++QdlQABHNMneyWjteRR+awZBcmBp/xHxxS7GkAwzW
	GNvEE3Dcdw6ObilXCI/l4H/a6IHaRIyyaJ9IW/szfgIA61IzY07Aj/SiYJY91qZ6YKHfes
	iJ1DHMyktHU2auItiyBDVWnv1eywVFGTPznBK4bRsPsX8ox8Q9MqDNXhssdHfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772099941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYam34fvx910nzxtv0zP2ACsjNjwt7ARQIEtWYy7sKs=;
	b=oafF1WkjPRpOKkopI+HDb9u5sBu0wwK2Ap8/pDQ+prBNMQeVYA7gJpG20EVBS2zRviStRL
	Dtld4x/xhOoDb3Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v1 1/2] net/bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding
Message-ID: <20260226095859.hLxDgGdn@linutronix.de>
References: <20260224112545.37888-1-jiayuan.chen@linux.dev>
 <20260224112545.37888-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224112545.37888-2-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261269-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 818DC1A3EE4
X-Rspamd-Action: no action

On 2026-02-24 19:25:41 [+0800], Jiayuan Chen wrote:
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4387,6 +4387,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>  	struct net_device *master, *slave;
>  
>  	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> +	if (unlikely(!master || !netif_running(master)))
> +		return XDP_TX;
> +

I'm not sure this check belongs here as this is not bond specific, is
it? Also nothing stops the admin to put the device right after the
netif_running() check so it fails later but the race window is not as
wide as it is now.

The per-CPU memory could be allocated while the bond device is created.
I don't think delaying it until "device up" brings any advantages.
One creates the device with the intention to use it so the "up" is
inevitable.
The bond_xmit_get_slave() callback has the same logic. Couldn't this
scenario also occur to the ->ndo_get_xmit_slave() user?

>  	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
>  	if (slave && slave != xdp->rxq->dev) {
>  		/* The target device is different from the receiving device, so

Sebastian

