Return-Path: <netdev+bounces-269112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCWyM4TZummfcgIAu9opvQ
	(envelope-from <netdev+bounces-269112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:57:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 580222BFBC7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0592235056EB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAD3B8BC3;
	Wed, 18 Mar 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE4y+WNw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F3FB064
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851098; cv=none; b=L9OY2yhWukjTuWvl3DDAZB7P1dZfmQIiSizaQDtASJ7OtHjw0r2962jqyTiSOvMusnUEx3Oge7NSV51ZPr5KUuInMRsdBymgcs8whAqZaNuXAVbUsCwvHHLrOrIo7JF2SePbzfO0Dy5rx783j1GFRDIS+MrkP2S/zeZGoQW3RX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851098; c=relaxed/simple;
	bh=MCP3h2XuCPCMPKLxfuYQ6FoftJMMchFpuND023+4K68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRUBKum84RmXDxAbqQwIhP3GdUFaMcS5KXpjrmRBi05TfMLD2rCaKgTX3zJJ/KFTEdeB+y11NgnYVNMD9fLNaieqCfPl1E75Ah9jEAK0Sx4AZo7DKTbOBzwkoREKJOZ/pfkD5Kl3N0uoHHOIs/HaDgE7+RuVqUvcGCFqkcbmbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE4y+WNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56469C19421;
	Wed, 18 Mar 2026 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851098;
	bh=MCP3h2XuCPCMPKLxfuYQ6FoftJMMchFpuND023+4K68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EE4y+WNwZVkeTWYHmQ+1jB32IVowSRFDTghbu9eKgWYZDoWM5W+Ca15Z7IgtMSy8G
	 AiEo3KUeSKyop81qzWtVt6mHCbeuvcE9VPK8TvX1ObQwAsodjKwDIgGzxHafdNUL8V
	 fneEOkrhLrdLySUuczoVPrt7eVdqyAvDhNXzOQO57E5Yky+r0yhXEc/V1OQleAD3dc
	 ndvpMrOBODiE3cVkFyQ6Z577DfipzHKJ/G5EPBEZOsOHVOwd4JH0MEBAzBS3KWBwsH
	 B0HoY/3qlwVYbf18XwqfWp51OiP+5KJQ9ncptoRybuCLH8Ny7sQ6MXM1OwSGsleWGp
	 tiXfJu/If514A==
Message-ID: <cbfc927d-0b96-4788-8bf6-8a2ffa4dd9f4@kernel.org>
Date: Wed, 18 Mar 2026 17:24:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/6] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@fomichev.me,
 j.koeppeler@tu-berlin.de, mfreemon@cloudflare.com, carges@cloudflare.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20260318134826.1281205-1-hawk@kernel.org>
 <20260318134826.1281205-3-hawk@kernel.org> <87ms05nrdw.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87ms05nrdw.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269112-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 580222BFBC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 18/03/2026 15.28, Toke Høiland-Jørgensen wrote:
> hawk@kernel.org writes:
> 
>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>> Add BQL support to the veth driver to dynamically limit the number of
>> bytes queued in the ptr_ring, giving the qdisc earlier feedback to shape
>> traffic and reduce latency.
>>
>> The BQL charge (netdev_tx_sent_queue) is placed in veth_xmit() BEFORE
>> veth_forward_skb() produces the SKB into the ptr_ring. This ordering is
>> critical: with threaded NAPI the consumer runs on a separate CPU and can
>> complete the SKB (calling dql_completed) before veth_xmit() returns. If
>> the charge happened after the produce, the completion could race ahead
>> of the charge, violating dql_completed()'s invariant that completed
>> bytes never exceed queued bytes (BUG_ON).
>>
>> Whether an SKB was BQL-charged is tracked per-SKB using a VETH_BQL_FLAG
>> bit in the ptr_ring pointer (BIT(1), alongside the existing VETH_XDP_FLAG
>> BIT(0)). The do_bql flag from veth_xmit() propagates through
>> veth_forward_skb() and veth_xdp_rx() into the ptr_ring entry. On the
>> completion side in veth_xdp_rcv(), veth_ptr_is_bql() reads the flag to
>> decide whether to call netdev_tx_completed_queue(). Per-SKB tracking is
>> necessary because the qdisc can be replaced live (e.g. noqueue->sfq or
>> vice versa via 'tc qdisc replace') while SKBs are already in-flight in
>> the ptr_ring. SKBs charged under the old qdisc must complete correctly
>> regardless of what qdisc is attached when the consumer runs, so each
>> SKB carries its own BQL-charged state rather than re-checking the peer's
>> qdisc at completion time.
> 
> It's not completely obvious to me why BQL can't be active regardless of
> whether there's a qdisc installed or not? If there's no qdisc, shouldn't
> BQL auto-tune to a higher value because the queue runs empty more?
> 

When net_device don't have qdisc we hit this code path:
  - [0] 
https://elixir.bootlin.com/linux/v7.0-rc4/source/net/core/dev.c#L4806-L4852
  - Notice the check if(!netif_xmit_stopped(txq))
  - resulting in "Virtual device %s asks to queue packet!"

We cannot unconditionally track BQL as calling netdev_tx_sent_queue()
can result in setting STACK_XOFF.  Resulting in above code dropping
packets and complaining.  (It have no qdisc to requeue store back-
pressured packet).

--Jesper


