Return-Path: <netdev+bounces-273064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAPwDEgIymk64gUAu9opvQ
	(envelope-from <netdev+bounces-273064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 07:21:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A4355739
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 07:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1B29300C990
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 05:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340837AA8F;
	Mon, 30 Mar 2026 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rm42e46/"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63761E633C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848057; cv=none; b=pWOWWi42hLp/OUc2pGDgr0xjwv3B1dWroGC3mdLwnPK8OSc6eU0jgaOwEhLkXzOHroJZzul5G3msouI9k31KsvmgtaYGSJXsjouNsDmi9C7HV06NlGU/bAewNbgrCb14X8DYik+b9+bfUmHM/73y6wzi6YZUbtCWFOzSaL9iGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848057; c=relaxed/simple;
	bh=0d0naRcIv9z63yxPLsdCSjk0pr783O3WgjjGnMocXio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBP3Mm7Aj4DgeUh6PxYrPUnhQQPSBU0xZN/iZ43g0dQufrRP5ZpgxL3VlGwBFVXV/94482pk7Nfx0ajwVXEsFJ/9ca5+hrATBvFwf7rzTdAbzXb8HzJ24/TiwW5Q1DJkMyXceF23CDMPS+MhzH/G43NwyyhNZ831B5CIHcwTkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rm42e46/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f83308b6-305f-401d-8a81-ca18e1968b56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774848053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fd68eY2O2CwKaCg9R2Y4ntn7WouQrswGFUmgrDBAqE=;
	b=rm42e46/2efGwnTyy/Nk+aswrm4cugwEBxJF6HCKwNl0e0BvUV9EJq7hIsC2Pr6k1w3QM1
	ntPjaA78xPcGapwBvb4Hez5TRgyQ3LklKOQltrR5754BM77QV6Tq+MquKKYb5n2wtGnK6x
	JZUk16rHpsKNIyUYI0FG1pYo2wsHxoY=
Date: Mon, 30 Mar 2026 13:20:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev>
 <20260326124205.1a3bb825@kernel.org>
 <785e0b04-91e4-457f-8d6c-e0a911c0fd88@linux.dev>
 <20260327171220.6d10d710@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260327171220.6d10d710@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	TAGGED_FROM(0.00)[bounces-273064-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5F5A4355739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/3/26 08:12, Jakub Kicinski wrote:
> On Fri, 27 Mar 2026 14:42:19 +0800 Leon Hwang wrote:
>>> It may be worth adding a selftest to
>>> tools/testing/selftests/drivers/net/xdp.py
>>> which sets MTU to 9k, tries to attach a non-frag-capable prog
>>> if that fails attaches a frag-capable prog and then checks if
>>> replacing the capable prog with non-capable fails.
>>> Drivers may be buggy in this regard.  
>>
>> Do you mean adding these two tests to xdp.py?
>>
>> 1. Verify the failure of attaching non-frag-capable prog to mtu=9k
>>    driver.
>> 2. Verify the failure of updating frag-capable prog with non-frag-
>>    capable prog via libbpf.c::bpf_link__update_program().
> 
> Not directly via libbpf just ip -f link, it uses libbpf internally
> but testing with  ip link is simpler. Also - there are already XDP
> progs which return XDP_PASS in frag-capable and non-capable mode,
> so just use those.
> 

Yep, I see these XDP progs in xdp_dummy.bpf.c.

I think the option of ip cmd to update XDP prog is -force.

# ip l set dev eth0 mtu 9000
# ip l set dev eth0 xdpdrv obj xdp_dummy.bpf.o sec xdp.frags
# ip l
6: eth0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 9000 xdp qdisc mq
master bond0 state UP mode DEFAULT group default qlen 1000
    link/ether 3a:39:5f:35:17:6c brd ff:ff:ff:ff:ff:ff permaddr
e0:9d:73:c6:7a:d6
    prog/xdp id 72 name xdp_dummy_prog_ tag 614b434cd8324ecc jited
# ip -force l set dev eth0 xdpdrv obj xdp_dummy.bpf.o sec xdp.frags
# ip l
6: eth0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 9000 xdp qdisc mq
master bond0 state UP mode DEFAULT group default qlen 1000
    link/ether 3a:39:5f:35:17:6c brd ff:ff:ff:ff:ff:ff permaddr
e0:9d:73:c6:7a:d6
    prog/xdp id 76 name xdp_dummy_prog_ tag 614b434cd8324ecc jited
# ip l set dev eth0 mtu 1500 xdpdrv off

I'd like to post an RFC to net-next later.

Thanks,
Leon


