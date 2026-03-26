Return-Path: <netdev+bounces-272186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BwmAeJxxWlJ+QQAu9opvQ
	(envelope-from <netdev+bounces-272186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 058173397BF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0219730074D9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8C39D6C9;
	Thu, 26 Mar 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wb3kqIg8"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5339B4A9
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547377; cv=none; b=M6PoVRU53SXFjN3IwBjZO96KEAxzadxnpDvMA0kMDHl5fASjON0bFQcPEynZ2pf+stc3ovFI/uDQTOCttueqfz1913iJZ4r0DdS669yMifa3kqfMMZ5zC7lqjtPk2ag9dr8pzEIHMjdgNnb1oCvEE0lfN6IW8wXjofaIRw9gBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547377; c=relaxed/simple;
	bh=Ys8BVN0x3U87U6nb5s7SqO4PUjwOesE4M8Kiph+9P6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDeAM98R+AAqzbV2K5VTj4r5cjX0QuumIICNweCfHOulhL4U2DHg0o9dQ6bgAf7aKtjT2CQ3OiYMiWq9foBsB4k3pWfBoG28nKq6wA5fvm6hrbKDmypLvCUj79uJjME4yQJMfw4htH1dO95GelPgbREJUiiAfT1FsLWyJBEeyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wb3kqIg8; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0c453f9-28aa-462f-884d-0e9beb2fdf0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774547361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZzE7Lq+Wi/ClrVVHCpj5Th0qEok0qKHryuF5ubIT4s=;
	b=Wb3kqIg8DT0FCwK8Sajf0T8vfYIDFjXuvV+JIxaCOsQHmvS8CZc1vv7ceUVlNKanVPigEH
	Sh5J4c7epGiRzznou9TavQlH1hb58SCRcIC2tifQcHzTC4rWg2yz/tiXqJycf3HJK0Twgl
	sR9ei6ymSpsUNPgfMMG/67R4+fYe5zo=
Date: Thu, 26 Mar 2026 10:49:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap
 validation
To: "Hudson, Nick" <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Glasgall, Anna"
 <aglasgal@akamai.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-4-nhudson@akamai.com>
 <f0f271ae-4d4c-4d52-8670-a14204da437d@linux.dev>
 <9E9BE3BD-1640-49E7-8801-130945073B24@akamai.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <9E9BE3BD-1640-49E7-8801-130945073B24@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272186-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 058173397BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/26 10:02 AM, Hudson, Nick wrote:
>>>     static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>>>        u64 flags)
>>> @@ -3502,6 +3513,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>>>    unsigned int gso_type = SKB_GSO_DODGY;
>>>    int ret;
>>>   + if (unlikely(flags & ~(BPF_F_ADJ_ROOM_ENCAP_MASK |
>>> +        BPF_F_ADJ_ROOM_NO_CSUM_RESET |
>>> +        BPF_F_ADJ_ROOM_FIXED_GSO)))
>> Under which case this new check will be hit?
> If a user supplies +ve len_diff and attempts to pass a DECAP flag.
> 
> The commit message had
> 
>      Add flag validation to bpf_skb_net_grow() to reject invalid encap
>      flags early.

There is DECAP_MASK check in bpf_skb_adjust_room() and then !shrink is 
rejected. What am I missing?

