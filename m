Return-Path: <netdev+bounces-257852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP9bBIvEiGlyvwQAu9opvQ
	(envelope-from <netdev+bounces-257852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 18:14:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BB10987E
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 18:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E24C300B9D4
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263842D3ED1;
	Sun,  8 Feb 2026 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DhiMBPvP"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D7253B42;
	Sun,  8 Feb 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770570887; cv=none; b=mVkjFktRkQxXJkiep2Ct42AXr4UIG6t2nDoPzsRnl4I+/mQcGqkmOiYHvW2FR8dSpWfOHxCNiH8CKQZhxwLp/tkUr/NVNPtfe0XPxt7ml9vbfcnacEr3BS/lyl0L2K8EDEfwLZpM47hyY6oLtocOU32QeWhUXjUl9EpoT+N+9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770570887; c=relaxed/simple;
	bh=SjRiWd8htRUZceqO0qWUBlYW4sLMYjWzzvAvbqp1y+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjMhNzXCPj4DQauNNAcnFGAbH5+f2QPerHqbYmOfoKQzE5EVz11UMsffVUiWrTxWg89uH7Ina89/haYndsFhGlutL6WHR2hd27HfM3XUoN3SXlEmVXPqBZgOM/n8dbBIGaZXWmJV4svn8jA13PARqeEGAE+QZ34La+w5qtCtiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DhiMBPvP; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vp8MP-00GmpH-SO; Sun, 08 Feb 2026 18:14:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=O8RJUkzJbz9LuXYHmv9bPjA91UwSvRO7HiTaqxe8MH4=; b=DhiMBPvPODBnXusfoYVpucW69Q
	uDqqJ/cgC8zBP6n4gFDWCIqtQY+FC1W2yU2V3Ri0x/L3PNO815lA8K+hFWneVOAbgzaSIcs1O95Da
	ILVQs12GI0KCGf9rueTc/VQXO20L2AlPi/yxonXAh30cbeMAYQRnP/L/O/U42+OSds/qcAoI5uW8Y
	IFF4MaDPPi4Vsqgn9Oq9A4rmX+MCKfl7/rOpR1d0BspDyVu4h4emph8SuZmA61jwOGDwEOpHpeQM7
	xP5LKrhmwytf5qGxnE2yd/S+EfLjTzuY6WNTYCrpZBzljN5RqTl+aZ2xz+2cPWGS0rJBVf04QQyMp
	cl+TuqAQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vp8MO-0007In-Hn; Sun, 08 Feb 2026 18:14:12 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vp8MG-009NlI-TC; Sun, 08 Feb 2026 18:14:04 +0100
Message-ID: <c4eaead1-ad69-42f0-9699-5f2d555a7693@rbox.co>
Date: Sun, 8 Feb 2026 18:14:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 3/4] bpf, sockmap: Adapt for the af_unix-specific
 lock
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemb@google.com>, Cong Wang <cong.wang@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co>
 <20260207-unix-proto-update-null-ptr-deref-v2-3-9f091330e7cd@rbox.co>
 <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,bytedance.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-257852-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:email,rbox.co:dkim,rbox.co:mid]
X-Rspamd-Queue-Id: 666BB10987E
X-Rspamd-Action: no action

On 2/7/26 23:00, Kuniyuki Iwashima wrote:
> On Sat, Feb 7, 2026 at 6:35 AM Michal Luczaj <mhal@rbox.co> wrote:
>> This patch also happens to fix a deadlock that may occur when
>> bpf_iter_unix_seq_show()'s lock_sock_fast() takes the fast path and the
>> iter prog attempts to update a sockmap. Which ends up spinning at
>> sock_map_update_elem()'s bh_lock_sock():
> 
> Hmm.. this seems to be a more general problem for
> bpf iter vs sockmap.  bpf_iter_{tcp,udp}_seq_show() also
> hold lock_sock(),  where this patch's solution does not help.
> We need to resolve this regardless of socket family.

I don't see any deadlocks there. Note that I've mentioned lock_sock_fast()
fast path was a problem, not lock_sock().

> Also, I feel lock_sock() should be outside of unix_state_lock()
> since the former is usually sleepable.  If we used such locking
> order in the future, it would trigger ABBA deadlock and we would
> have to revisit this problem.

Do I understand correctly you're suggesting taking lock_sock() for af_unix
just as well?


