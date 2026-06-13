Return-Path: <netdev+bounces-298965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ja0hCPdhLWo0fgQAu9opvQ
	(envelope-from <netdev+bounces-298965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:58:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010067EB4C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:58:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b="f6D5Q1/d";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298965-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298965-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3067A30252AA
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1D2EEE6D;
	Sat, 13 Jun 2026 13:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7C63B9;
	Sat, 13 Jun 2026 13:58:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359091; cv=none; b=u35mYmWIb7N1z8K/88GSGFA0X9jXBNMdtgkOwzgJqomG2/xQvFCm7LgOJsy8d4P3h77mMqoHacNOMiMhJlnXyZrZdQ7ekE/tZzlQdVUWtMceSktRpxh3a/klutaykhiahsXpeSJ8fA1OC10+xRfzNq4/5PUyEy8dtQ2oRqIeXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359091; c=relaxed/simple;
	bh=MGHTiIUOviutCRVwxnnDgRYWU2f8IfdfRQ1F5rszzU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix3PcUptbns+EF88KOaByNmGeIsXNhRSNm2aKOO4uN27X+XgUROmPR+Yl5m++q8RPYdaULRVdsIyRtM2jZHsTWiuh9N8Z7KotnCvUqpGoYdon2VIvN5zFnxCOSydtT6l1Tt2qCst/NbjNCk1w7tC/5VCnQiHlKAvCte+L1Pg+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=f6D5Q1/d; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1781359053;
	bh=MGHTiIUOviutCRVwxnnDgRYWU2f8IfdfRQ1F5rszzU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f6D5Q1/d50W4n8SSgF7rG2bLxSNoEGdr9bdFJ+EOXRNWggjl4kn1KceBDsXVmAp6c
	 OYalAEuVWUg/uWmIIGdKGvTReB38XuvjjpnCViuG9l0MgmTIaC1B8QDXDvGpguTiJ4
	 5TDjEkiSvSxKe04LZQcul3jrXqJBgEvOsAe2TED8=
Received: from [192.168.178.68] (pd9eaa69d.dip0.t-ipconnect.de [217.234.166.157])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 65DDvVHv018453
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 15:57:31 +0200 (CEST)
Message-ID: <74a6b90c-7d67-4047-8467-3757cd1f91a6@tu-dortmund.de>
Date: Sat, 13 Jun 2026 15:57:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Chris Arges <carges@cloudflare.com>,
        Mike Freemon <mfreemon@cloudflare.com>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260612083530.1650245-1-hawk@kernel.org>
 <5c326cb0-9b7c-4d67-8f80-0c9be1e8fcba@tu-dortmund.de>
 <4ddf3bcb-db5d-4821-ab32-577de93973a7@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <4ddf3bcb-db5d-4821-ab32-577de93973a7@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298965-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:j.koeppeler@tu-berlin.de,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:carges@cloudflare.com,m:mfreemon@cloudflare.com,m:toke@toke.dk,m:leitao@debian.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,debian.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6010067EB4C

On 6/12/26 19:21, Jonas Köppeler wrote:
> On 6/12/26 16:10, Simon Schippers wrote:
>> On 6/12/26 10:35, hawk@kernel.org wrote:
>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>>> latency by dynamically limiting in-flight packets in the ptr_ring and
>>> moving buffering into the qdisc where AQM algorithms can act on it.
>>
>> LGTM, thanks for the detailed changelog :)
>>
>> Maybe we should stop searching for the perfect tx-usecs value.
>> 100us is probably fine for most hardware to not have a performance
>> regression. And lowering it does not really improve the RTT anyways.
>> Do you agree?
> I agree, I already thought that it just might be a very lucky case when using 50us where something accidentally aligns nicely. Interestingly, I could also reproduce that 50us was consistently a little better compared to 100us on an Intel CPU. Maybe if I get the time, I'll have another look at it, but in general I think 50us or 100us does not really matter.
> 

Interesting.

I ran the benchmarks again, the results are at [1].
I tested values between 0-9us, 10-90us, 100, 500, 1000, 5000 and 10000us.

TLDR: Throughput is fine for everything > 0us. RTT only improves
      slightly for < 100us. So 100us is fine.

[1] https://github.com/simoschip2000/veth-backpressure-performance-testing/blob/v7/results/tx-usecs/text_sweep.txt

>>
>> Nevertheless, I will compile and run the benchmarks again.
>>
>> I will go on vacation from 15th to 24th of June, so I will not be able
>> to contribute code or run benchmarks then.
>>
>> Thanks,
>> Simon
>>
> 

