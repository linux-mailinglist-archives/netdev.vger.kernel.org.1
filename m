Return-Path: <netdev+bounces-298751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7gTHGzdALGp/OQQAu9opvQ
	(envelope-from <netdev+bounces-298751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:21:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E5E67B4BE
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:21:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-berlin.de header.s=dkim-tub26 header.b=UVfhknRg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298751-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298751-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=tu-berlin.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27531312A93F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC2403E8B;
	Fri, 12 Jun 2026 17:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25434405C4D;
	Fri, 12 Jun 2026 17:21:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284910; cv=none; b=hMEzBLwdGXTlEp8d9ZSRoMDfL8aH26t6qfLqbegAZxod4KlIwS7vW3cQI1UiekjRjwhNoMBbNY6qFIvDKsnOoXGrFznejYVa3WrAasupRecWPViUhaaWI/Dmrm7v8kzWP4BupcC53YhgJyb7zwPFG2YMU6I0K7DqbRO86OAH1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284910; c=relaxed/simple;
	bh=7HAYKMd+/celBV+WiTjQDc9z3dQLsE8U64chPNnjc2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M3iY8Ajkj9D8pZjtb7rCMhMDnW+eviLlw2yhtEF0JuoRTfdJmTPNeoj8MmYJ5DEy0MdtkHR0TX2lCgDxEn6s4MuD1TgjXqitx8bvokb6o+qZtRKmgG1x9iDDoxCk/kZl4OETP5PN/wW9GT3/vBCQ+im0+lu4ZbE8eFyH/rBNAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=UVfhknRg; arc=none smtp.client-ip=130.149.7.70
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1781284905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OV1+Rqtca2bNABQo0c5sCFhOHb8swb/BaM75V70D7kY=;
  b=UVfhknRgpb6m2LcWFfUf+yOVAMZ6A6ZaKF1lWk6B6kHVPFvQ0vuwx+i/
   A7bucdv2dNGRjCsxTWGQ0NO9GtcnNnKhHjDzQicwYFynXZYlE60v8IF1X
   JjXNFTbQcr90pLw517pwBokUPc9vasKGDQGIltW7m4CLJA3Zz07I8OTRz
   uiq2mpoFQtqbVVwol2cqxcgHtxCAnAvaJBMaDXzz3LZTdwb/1WTZ6/iL4
   8GBBjUHypeRDGxTUUDAK8ONNj+IxpEShnwTvCk9FG3OC2xCjo8yyN7os1
   OgKAb5J8gCDA9r/+wbY6V2Q/qaGve1Ve+e/DySD+Ioc4E5tXha9vhG1pR
   A==;
X-CSE-ConnectionGUID: Co7ywSanTKqBgyUi/m5VUQ==
X-CSE-MsgGUID: N7qmqRnERK2hk9xgbm/myg==
X-IronPort-AV: E=Sophos;i="6.24,201,1774306800"; 
   d="scan'208";a="48673396"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 12 Jun 2026 19:21:37 +0200
Message-ID: <4ddf3bcb-db5d-4821-ab32-577de93973a7@tu-berlin.de>
Date: Fri, 12 Jun 2026 19:21:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
To: Simon Schippers <simon.schippers@tu-dortmund.de>, <hawk@kernel.org>,
	<netdev@vger.kernel.org>
CC: <kernel-team@cloudflare.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Chris Arges
	<carges@cloudflare.com>, Mike Freemon <mfreemon@cloudflare.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Breno Leitao
	<leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, <bpf@vger.kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
 <5c326cb0-9b7c-4d67-8f80-0c9be1e8fcba@tu-dortmund.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Autocrypt: addr=j.koeppeler@tu-berlin.de; keydata=
 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
In-Reply-To: <5c326cb0-9b7c-4d67-8f80-0c9be1e8fcba@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298751-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:carges@cloudflare.com,m:mfreemon@cloudflare.com,m:toke@toke.dk,m:leitao@debian.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,debian.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tu-berlin.de:dkim,tu-berlin.de:mid,tu-berlin.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1E5E67B4BE

On 6/12/26 16:10, Simon Schippers wrote:
> On 6/12/26 10:35, hawk@kernel.org wrote:
>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>> latency by dynamically limiting in-flight packets in the ptr_ring and
>> moving buffering into the qdisc where AQM algorithms can act on it.
> 
> LGTM, thanks for the detailed changelog :)
> 
> Maybe we should stop searching for the perfect tx-usecs value.
> 100us is probably fine for most hardware to not have a performance
> regression. And lowering it does not really improve the RTT anyways.
> Do you agree?
I agree, I already thought that it just might be a very lucky case when 
using 50us where something accidentally aligns nicely. Interestingly, I 
could also reproduce that 50us was consistently a little better compared 
to 100us on an Intel CPU. Maybe if I get the time, I'll have another 
look at it, but in general I think 50us or 100us does not really matter.

> 
> Nevertheless, I will compile and run the benchmarks again.
> 
> I will go on vacation from 15th to 24th of June, so I will not be able
> to contribute code or run benchmarks then.
> 
> Thanks,
> Simon
> 


