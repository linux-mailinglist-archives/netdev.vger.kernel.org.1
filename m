Return-Path: <netdev+bounces-261789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CfGEeJooWkUsgQAu9opvQ
	(envelope-from <netdev+bounces-261789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A01B58FA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41325310A6D5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58AB279903;
	Fri, 27 Feb 2026 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YPLwCRBu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="flkODPDn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F21F92E;
	Fri, 27 Feb 2026 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185563; cv=none; b=P/WyO3/hUIXsJSykDyeANbozHEuA6nzrSP7krPovtuyDm4qA9hONQwgWzELaVMnXs2ridq76NKVv0/gUCxNJYtJ8n1kOfjj4iP02+lPA/VXneoSI53SXChgV2Tb+hPxR2p9OrC7bXpfROOkALwX3w31XTfB351YtUN4bhvMYRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185563; c=relaxed/simple;
	bh=VYFg5k7FKX+uIcQK8lWyAtUT/QcKiHuyfaKksYCk2iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlYQ0nL1i6k6XC6nhPbi9bJBwyS7gU73Tlro+1r2Zyz351U2wOe61SqNZSvPXaFdAUa0QYcDMw6Snw2RcOLkTKRDXkEpPM2cxSk0Y45f8Roovo1U0Aj70IpoaKMUo4QHOT4r5QJPKmMmwIcaPpHOkP2omya4Fj7G4HFTd0WzA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YPLwCRBu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=flkODPDn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Feb 2026 10:45:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772185560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WADBw/49RgqeVitdv+2eYLg7uk6Rv8a9V1F/vtC1LSE=;
	b=YPLwCRBuVscCHETXF8Fq24RERTaNwAELr6KN71SwyUy5aULW0SFmZREtwjnOn3HX2j5g5/
	eqRhvivi2cz42k3YBJbkmTslvVQk5i9B2aiPapOHqAp5LLTE02TlFRWKhKyCTEKwVfjznu
	qc4I9vlpZ7G4LLAjUGRfLi/l6C+zGxR+w8bRAKZ0kzFMtGYkPtAMYMxRgfkF2MQUBWjPre
	hFZPCGGTendy03km4ixm1TioPPAaMHU72U1DQzu5miJXvfAVW1RfTWmTeC2eu9wf9QFhZ3
	MY8xTsDjSMCtWWkGpMtOCCLjnPuFJ9oJKMDzsMoy2L+AFw/ixIA9ahF28YMDXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772185560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WADBw/49RgqeVitdv+2eYLg7uk6Rv8a9V1F/vtC1LSE=;
	b=flkODPDnw98wP4j8ocKt4w1Bhv+PAmdeHurV2WTwlhsKIBjUZtqZ7ZMWcHU3T3E35BiL+7
	tIB8hz7mzhsrIzCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuna.chen@linux.dev, jiayuna.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v2 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <20260227094558._Fna2iSe@linutronix.de>
References: <20260227092254.272603-1-jiayuan.chen@linux.dev>
 <20260227092254.272603-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227092254.272603-2-jiayuan.chen@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-261789-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C09A01B58FA
X-Rspamd-Action: no action

On 2026-02-27 17:22:49 [+0800], Jiayuan Chen wrote:
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -6458,6 +6458,12 @@ int bond_create(struct net *net, const char *name)
>  	dev_net_set(bond_dev, net);
>  	bond_dev->rtnl_link_ops = &bond_link_ops;
>  
> +	res = bond_create_init(bond);

Wouldn't it be better to put into bond_init()?

I haven't look into it but when can the bond_mode be changed?

Sebastian

