Return-Path: <netdev+bounces-258972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF5/MtwblGn0/wEAu9opvQ
	(envelope-from <netdev+bounces-258972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:42:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB614940C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFEB23015CA4
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225F92D23A5;
	Tue, 17 Feb 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4vCRWzp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZJR/ak/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96245FDA7;
	Tue, 17 Feb 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314137; cv=none; b=ebZOSDuRqvt3lEol3JGzgX0+N0TlPJZYHNVcdwxX065+8hl4Y6QGuqGYtXVCcEc9w/6grxFmmlRkXGjMPh9xEGp1F2YIvjUG8+uSh0Rf3Da2K6d6kW16R09YVkBd76UZJ9j2eBPHOrSIGFkB+P8hhA0nT440dt09nG1z4bLnSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314137; c=relaxed/simple;
	bh=qE+yPLi1ykHRmeRwIOIeQFhMzLFO6SYvRavMwSbG0w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSqyn41qbbCZ5TuUuskxACVBIp7kXwRJ3iRgoBrwMDMwXhAYBGb9LpzMiI+Lr0beXFe/c50xSDZFwVow3C9W9AMjjqSMW7QZ9Ov1qKhWfLPiI87k1/UnqI2FPu6U2W+aTeaRogfEcfEmrcUHU5wVsug2TG7zm8HBBsLkWSH+jBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4vCRWzp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZJR/ak/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 08:42:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771314134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lv3UGO8zu50i+N0PRvq/5skPPM6bB0wzdtk2hzdWxGw=;
	b=T4vCRWzpDkVcYoVW4KYZnOHXdfnzD9xIAT5Qph4gtHB+H9YazGRbBuHjiSmBNNlPq787iD
	AAujql3SQIaEdfbKeruZYI46KdjF1GWF0enebTsCkGUe6ISGFiC3qGotPHYKulacvJG1me
	ok34Vv23E7sYrCFH2p1X28O7wldD6ducnCW8fVOTIM8R1DxdNodKr414bP2wQNtqvkBczF
	k7qzApJstXs1na1GFDZttqNI0nZIG/M3ApDkJImhAimhIQSKps3bq4xUJihkH2inReRZpj
	dR38SD9uJph9I8W4Vevf/7/A54p8NArchddQuBUxqjaw+audUgSfb+3OqNScQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771314134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lv3UGO8zu50i+N0PRvq/5skPPM6bB0wzdtk2hzdWxGw=;
	b=MZJR/ak/FNQkBzxbm8t5YrYs2t/S6mdM0vJTCtxkqUN6d4Wa19fb517/k8Z0UtBqIRBCPA
	JLbA/1NpYqOG8+CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: xxx@vger.kernel.org, jiayuan.chen@shopee.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v3 2/2] bpf: devmap: fix race in bq_xmit_all on
 PREEMPT_RT
Message-ID: <20260217074212.95wNTgR7@linutronix.de>
References: <20260213034018.284146-1-jiayuan.chen@linux.dev>
 <20260213034018.284146-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260213034018.284146-3-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258972-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,google.com,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FDB614940C
X-Rspamd-Action: no action

On 2026-02-13 11:40:15 [+0800], Jiayuan Chen wrote:
=E2=80=A6
> timeslicing during the mdelay window causes interleaving. Without the
> fix, KASAN reports null-ptr-deref due to operating on freed frames:
>=20
>   BUG: KASAN: null-ptr-deref in __build_skb_around+0x22d/0x340
>   Write of size 32 at addr 0000000000000d50 by task devmap_race_rep/449
>=20
>   CPU: 0 UID: 0 PID: 449 Comm: devmap_race_rep Not tainted 6.19.0+ #31 PR=
EEMPT_RT
>   Call Trace:
>    <TASK>
>    __build_skb_around+0x22d/0x340
>    build_skb_around+0x25/0x260
>    __xdp_build_skb_from_frame+0x103/0x860
>    veth_xdp_rcv_bulk_skb.isra.0+0x162/0x320
>    veth_xdp_rcv.constprop.0+0x61e/0xbb0
>    veth_poll+0x280/0xb50
>    __napi_poll.constprop.0+0xa5/0x590
>    net_rx_action+0x4b0/0xea0
>    handle_softirqs.isra.0+0x1b3/0x780
>    __local_bh_enable_ip+0x12a/0x240
>    xdp_test_run_batch.constprop.0+0xedd/0x1f60
>    bpf_test_run_xdp_live+0x304/0x640
>    bpf_prog_test_run_xdp+0xd24/0x1b70
>    __sys_bpf+0x61c/0x3e00
>    </TASK>
>=20
>   Kernel panic - not syncing: Fatal exception in interrupt

I would move this next to the diffstat (same as with the previous
patch) since it is obvious once you described it.

Sebastian

