Return-Path: <netdev+bounces-296478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FizKMb+iJmolaQIAu9opvQ
	(envelope-from <netdev+bounces-296478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D2655824
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:08:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=IQSJ+3Y5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296478-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296478-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D97F30580AA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E233B4404;
	Mon,  8 Jun 2026 10:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027B2836A6;
	Mon,  8 Jun 2026 10:38:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915143; cv=none; b=Rl0vOoQpUOZ1fm7FgHwrcwmtX9jExJ1bJzHMXVA8bL0UDsIR2xod4G8IUbhpGcfQZrzc+5qu/6Yy61v/f9540XozGdE8nTZh3zKazl7jvTDwYf4DRaA5dRmKJaMr1hh9K4kEUiopuZBJfSc+40G//+hl5LoA0ApkEGbQsz+rbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915143; c=relaxed/simple;
	bh=RYiLSDGNAU+laXffeD+nGJJf4CP6a5zGwij7IlakTvY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Apoek6HOcxRdFpvCEMMnV7lBNmyhRTp0wbupUyF7hHq3CeYryXS4sbiKaiszZU0wapAO5B5SVc7fkMeoEW+SWQWZ1BZLwkcHRR+Y5eeQ1EGBlBvvs9AkXzoGSFVUGX7UPP16g5VXWrRlV0kFo+tOCc73FLBynzIw7FycGlYSAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=IQSJ+3Y5; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1780915111;
	bh=RYiLSDGNAU+laXffeD+nGJJf4CP6a5zGwij7IlakTvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IQSJ+3Y57+pz5Uz/QAA4IcxaQ2mcChLAyQxQkiKn6bzJ4oJ+/LizQdcjivd/Xi0z7
	 KrxV3uhs6S6d5tiiu1yo7mpHj+S5y6zK93yk0UmlyONWVWAUQqani1c2Eat624/ttd
	 fIVv8NpzdScpt9RED2KFsQlIEmZwwunl9d/1W3Dg=
Received: from [129.217.186.235] ([129.217.186.235])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 658AcUgo009811
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 8 Jun 2026 12:38:30 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------PiV1pwb044zmkApcZlhTjx1z"
Message-ID: <db2aa3b9-09d4-46d8-aafc-0a859ee8b635@tu-dortmund.de>
Date: Mon, 8 Jun 2026 12:38:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: hawk@kernel.org, netdev@vger.kernel.org,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260527135418.1166665-6-hawk@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:netdev@vger.kernel.org,m:j.koeppeler@tu-berlin.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tu-dortmund.de:mid,tu-dortmund.de:dkim,tu-dortmund.de:from_mime,tu-dortmund.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 364D2655824

This is a multi-part message in MIME format.
--------------PiV1pwb044zmkApcZlhTjx1z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 15:54, hawk@kernel.org wrote:
> From: Simon Schippers <simon.schippers@tu-dortmund.de>
> 
> Per-packet BQL completion forces DQL to converge on limit=2, causing
> excessive NAPI scheduling overhead and qdisc requeues.
> 
> Accumulate BQL completions and flush them when a configurable time
> threshold is exceeded, letting DQL discover a limit that bounds actual
> queuing delay to the configured interval. Coalescing state persists
> across NAPI polls in struct veth_rq so completions can accumulate
> beyond a single budget=64 cycle.
> 
> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
> setting tx-usecs to 0 disables coalescing and falls back to per-packet
> completion.
> 
>   ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>   ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
> 
> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---

I found the issue that n_bql may become infinitly large if producer
and consumer have the same speed (and tx_usecs is large). It could
cause a potential BUG_ON if n_bql grows beyond INT_MAX...
Also I figured that no hardware BQL driver ever completes more than
BQL limit many elements.

Therefore, I propose a simpler logic (see attachment) that completes
either on the usual bql_flush_ns or if n_bql > dql.limit.
If n_bql > dql.limit then we either have the case above that the
producer is as fast as the consumer or we have BQL starvation.

if (state->time + bql_flush_ns <= current_time ||
	state->n_bql > peer_txq->dql.limit) {

It must be n_bql *bigger than* dql.limit because the producer will
always exceed the limit before it stops, see netdev_tx_sent_queue().
It is fast because peer_txq->dql.limit is in the cacheline of the
completion path, see dynamic_queue_limits.h.

Another advantage is that we avoid the snippet checking for empty
and BQL stopped which requires an smp_rmb() and an test_bit().

Apart from that I:
- Always call veth_bql_maybe_complete() in the for loop to have
  more accurate completion intervals when having mixed XDP and
  non-XDP packets.
- Made it so tx_usecs = 0 is now also a normal case.
- Change the type of n_bql to uint instead of int.
- Added _ONCE() for tx_coalesce_usecs as suggested by Paolo.
- Moved the bql_state init in __veth_napi_enable_range() in front
  of napi_enable() to avoid a race (Sashiko).
- Moved the bql_state reset in veth_napi_del_range() after the
  ptr_ring_cleanup() (probably does not matter but makes sense to me)

Benchmarks look just fine, see commit message.

WDYT?

Thanks,
Simon

--------------PiV1pwb044zmkApcZlhTjx1z
Content-Type: text/x-patch; charset=UTF-8;
 name="0005-veth-time-based-BQL-completion-coalescing-via-ethtoo.patch"
Content-Disposition: attachment;
 filename*0="0005-veth-time-based-BQL-completion-coalescing-via-ethtoo.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1OTg0NGY3MDM5ODg4MDVmZjc5MTM5ODllZDRkY2Q0MjdhZTg4MmFmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBTY2hpcHBlcnMgPHNpbW9uLnNjaGlwcGVy
c0B0dS1kb3J0bXVuZC5kZT4KRGF0ZTogV2VkLCAyNyBNYXkgMjAyNiAxNTo1NDoxNiArMDIw
MApTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgdjYgNS81XSB2ZXRoOiB0aW1lLWJhc2VkIEJR
TCBjb21wbGV0aW9uIGNvYWxlc2NpbmcKIHZpYSBldGh0b29sIHR4LXVzZWNzCgpQZXItcGFj
a2V0IEJRTCBjb21wbGV0aW9uIGZvcmNlcyBEUUwgdG8gY29udmVyZ2Ugb24gbGltaXQ9Miwg
Y2F1c2luZwpleGNlc3NpdmUgTkFQSSBzY2hlZHVsaW5nIG92ZXJoZWFkIGFuZCBxZGlzYyBy
ZXF1ZXVlcy4KCkFjY3VtdWxhdGUgQlFMIGNvbXBsZXRpb25zIGFuZCBmbHVzaCB0aGVtIHdo
ZW4gYSBjb25maWd1cmFibGUgdGltZQp0aHJlc2hvbGQgKHR4LXVzZWNzKSBpcyBleGNlZWRl
ZCwgbGV0dGluZyBEUUwgZGlzY292ZXIgYSBsaW1pdCB0aGF0CmJvdW5kcyBhY3R1YWwgcXVl
dWluZyBkZWxheSB0byB0aGUgY29uZmlndXJlZCBpbnRlcnZhbC4gQ29hbGVzY2luZwpzdGF0
ZSBwZXJzaXN0cyBhY3Jvc3MgTkFQSSBwb2xscyBpbiBzdHJ1Y3QgdmV0aF9ycSBzbyBjb21w
bGV0aW9ucyBjYW4KYWNjdW11bGF0ZSBiZXlvbmQgYSBzaW5nbGUgYnVkZ2V0PTY0IGN5Y2xl
LgoKVGhlIGZsdXNoIGNvbmRpdGlvbiBpczoKCnN0YXRlLT50aW1lICsgYnFsX2ZsdXNoX25z
IDw9IGN1cnJlbnRfdGltZSB8fCBzdGF0ZS0+bl9icWwgPiBkcWwubGltaXQKCkZsdXNoaW5n
IHdoZW4gbl9icWwgZXhjZWVkcyBkcWwubGltaXQgaGFuZGxlcyB0d28gY2FzZXM6Ci0gQlFM
IHN0YXJ2YXRpb24KLSBUaGUgc3RlYWR5LXN0YXRlIGNhc2Ugd2hlcmUgdGhlIHByb2R1Y2Vy
IGFuZCBjb25zdW1lciBydW4gYXQgdGhlCiAgc2FtZSBzcGVlZCB3aXRoIGEgbGFyZ2UgdHgt
dXNlY3MsIHdoaWNoIHdvdWxkIG90aGVyd2lzZSBhbGxvdyBuX2JxbAogIHRvIGdyb3cgd2l0
aG91dCBib3VuZCAoYW5kIHBvdGVudGlhbGx5IG92ZXJmbG93IGludCkuCgpUaGUgY29tcGFy
aXNvbiBpcyBzdHJpY3RseSBncmVhdGVyLXRoYW4gYmVjYXVzZSBuZXRkZXZfdHhfc2VudF9x
dWV1ZSgpCmFsd2F5cyBsZXRzIHRoZSBwcm9kdWNlciBleGNlZWQgdGhlIGxpbWl0IGJ5IG9u
ZSBiZWZvcmUgaXQgc3RvcHMsIHNvCm5fYnFsID09IGRxbC5saW1pdCBpcyBhIG5vcm1hbCBp
bi1mbGlnaHQgc3RhdGUuIGRxbC5saW1pdCBsaXZlcyBpbgp0aGUgc2FtZSBjYWNoZWxpbmUg
YXMgdGhlIGNvbXBsZXRpb24gcGF0aCwgc28gdGhlIGNoZWNrIGlzIGNoZWFwLgoKQWRkIGV0
aHRvb2wgdHgtdXNlY3Mgc3VwcG9ydCBmb3IgcnVudGltZSB0dW5pbmcuIERlZmF1bHQgaXMg
MTAwIHVzOwpzZXR0aW5nIHR4LXVzZWNzIHRvIDAgZGlzYWJsZXMgY29hbGVzY2luZyBhbmQg
ZmFsbHMgYmFjayB0byBwZXItcGFja2V0CmNvbXBsZXRpb24uCgogIGV0aHRvb2wgLUMgPHZl
dGgtZGV2PiB0eC11c2VjcyA1MDAgICMgNTAwdXMgY29hbGVzY2luZwogIGV0aHRvb2wgLUMg
PHZldGgtZGV2PiB0eC11c2VjcyAwICAgICMgcGVyLXBhY2tldCAobm8gY29hbGVzY2luZykK
CkJlbmNobWFya3MgKDEwIHJ1bnMsIFJ5emVuIDUgNTYwMFggQCA0LjMgR0h6LCBTTVQgb2Zm
LCAzMjAwIE1IeiBSQU0pOgoKVGhyb3VnaHB1dCAocHBzKQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KbnJ1bGVzIHwgICAwdXMgfCAgNTB1cyB8IDEwMHVzIHwgNTAwdXMgfCAxMDAwdXMgfCA1
MDAwdXMgfCAxMDAwMHVzIHx8IHN0b2NrCi0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0tLS0t
LS0rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLS0rKy0tLS0tLQogICAgIDAg
fCAxLjYyTSB8IDEuODlNIHwgMS43NU0gfCAxLjczTSB8ICAxLjczTSB8ICAxLjczTSB8ICAg
MS43M00gfHwgMS43Nk0KICAgICAxIHwgMS41MU0gfCAxLjcyTSB8IDEuNjNNIHwgMS42ME0g
fCAgMS42ME0gfCAgMS41OU0gfCAgIDEuNTlNIHx8IDEuNjRNCiAgICAxMCB8IDEuMzNNIHwg
MS41Mk0gfCAxLjQ3TSB8IDEuNDFNIHwgIDEuNDFNIHwgIDEuNDFNIHwgICAxLjQxTSB8fCAx
LjQ1TQogICAxMDAgfCAgNjc1SyB8ICA3NDhLIHwgIDc1N0sgfCAgNzIySyB8ICAgNzIySyB8
ICAgNzI0SyB8ICAgIDcyOUsgfHwgIDczN0sKICAxMDAwIHwgIDExN0sgfCAgMTI1SyB8ICAx
MjVLIHwgIDEyNksgfCAgIDEyNEsgfCAgIDEyNEsgfCAgICAxMjRLIHx8ICAxMjZLCiAxMDAw
MCB8ICAgMTNLIHwgICAxM0sgfCAgIDEzSyB8ICAgMTNLIHwgICAgMTNLIHwgICAgMTNLIHwg
ICAgIDEzSyB8fCAgIDEzSwoKUGluZyBSVFQgbXMgKGF2ZykKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Cm5ydWxlcyB8ICAgMHVzIHwgIDUwdXMgfCAxMDB1cyB8IDUwMHVzIHwgMTAwMHVzIHwg
NTAwMHVzIHwgMTAwMDB1cyB8fCBzdG9jawotLS0tLS0tKy0tLS0tLS0rLS0tLS0tLSstLS0t
LS0tKy0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tKystLS0tLS0KICAgICAw
IHwgMC4wMTcgfCAwLjA5MCB8IDAuMTM3IHwgMC4xMzggfCAgMC4xMzggfCAgMC4xMzggfCAg
IDAuMTM4IHx8IDAuMTMzCiAgICAgMSB8IDAuMDE3IHwgMC4wOTcgfCAwLjE0NSB8IDAuMTQ2
IHwgIDAuMTQ0IHwgIDAuMTQ4IHwgICAwLjE0NyB8fCAwLjE0MwogICAgMTAgfCAwLjAxOCB8
IDAuMDkyIHwgMC4xNTggfCAwLjE2NSB8ICAwLjE2NSB8ICAwLjE2MiB8ICAgMC4xNjcgfHwg
MC4xNTkKICAgMTAwIHwgMC4wMzEgfCAwLjEwNCB8IDAuMTgxIHwgMC4zMTcgfCAgMC4zMTcg
fCAgMC4zMTcgfCAgIDAuMzExIHx8IDAuMzA1CiAgMTAwMCB8IDAuMTQyIHwgMC4xOTggfCAw
LjMxNCB8IDAuOTkxIHwgICAxLjY5IHwgICAxLjgyIHwgICAgMS44MiB8fCAgMS43NgogMTAw
MDAgfCAgMS4xMiB8ICAxLjcyIHwgIDEuNzQgfCAgMS43NiB8ICAgMi44OCB8ICAgOS4yNyB8
ICAgIDE1LjkgfHwgIDE3LjQKClBpbmcgUlRUIG1zIChwOTkpCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpucnVsZXMgfCAgIDB1cyB8ICA1MHVzIHwgMTAwdXMgfCA1MDB1cyB8IDEwMDB1cyB8
IDUwMDB1cyB8IDEwMDAwdXMgfHwgc3RvY2sKLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0t
LS0tLSstLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLSsrLS0tLS0tCiAgICAg
MCB8IDAuMDI4IHwgMC4xMTUgfCAwLjE1OSB8IDAuMTYxIHwgIDAuMTYzIHwgIDAuMTYxIHwg
ICAwLjE2MyB8fCAwLjE1NAogICAgIDEgfCAwLjAyNyB8IDAuMTIzIHwgMC4xNzAgfCAwLjE3
MiB8ICAwLjE2OSB8ICAwLjE3MyB8ICAgMC4xNzIgfHwgMC4xNjkKICAgIDEwIHwgMC4wMzAg
fCAwLjExNyB8IDAuMTkwIHwgMC4xOTMgfCAgMC4xOTUgfCAgMC4xOTIgfCAgIDAuMTk2IHx8
IDAuMTg2CiAgIDEwMCB8IDAuMDQ1IHwgMC4xMzQgfCAwLjIzMSB8IDAuMzY4IHwgIDAuMzY1
IHwgIDAuMzcwIHwgICAwLjM2MSB8fCAwLjM1OAogIDEwMDAgfCAwLjIzMCB8IDAuMzAwIHwg
MC40MDggfCAwLjk4OSB8ICAgMi4xMSB8ICAgMi4xMiB8ICAgIDIuMTMgfHwgIDIuMDcKIDEw
MDAwIHwgMC45NzkgfCAgMS41OSB8ICAxLjI2IHwgIDIuMDYgfCAgIDMuNzcgfCAgIDkuODcg
fCAgICAyMC4xIHx8ICAyMC4zCgpDby1kZXZlbG9wZWQtYnk6IEplc3BlciBEYW5nYWFyZCBC
cm91ZXIgPGhhd2tAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogSmVzcGVyIERhbmdhYXJk
IEJyb3VlciA8aGF3a0BrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBTY2hpcHBl
cnMgPHNpbW9uLnNjaGlwcGVyc0B0dS1kb3J0bXVuZC5kZT4KLS0tCiBkcml2ZXJzL25ldC92
ZXRoLmMgfCA5MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92ZXRoLmMgYi9kcml2ZXJzL25ldC92ZXRoLmMK
aW5kZXggZDU2NzVkOWQ1MjM2Li5iOTE3OWRlNjI4YTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bmV0L3ZldGguYworKysgYi9kcml2ZXJzL25ldC92ZXRoLmMKQEAgLTI4LDYgKzI4LDcgQEAK
ICNpbmNsdWRlIDxsaW51eC9icGZfdHJhY2UuaD4KICNpbmNsdWRlIDxsaW51eC9uZXRfdHN0
YW1wLmg+CiAjaW5jbHVkZSA8bGludXgvc2tidWZmX3JlZi5oPgorI2luY2x1ZGUgPGxpbnV4
L3NjaGVkL2Nsb2NrLmg+CiAjaW5jbHVkZSA8bmV0L3BhZ2VfcG9vbC9oZWxwZXJzLmg+CiAK
ICNkZWZpbmUgRFJWX05BTUUJInZldGgiCkBAIC00NCw2ICs0NSw4IEBACiAjZGVmaW5lIFZF
VEhfWERQX1RYX0JVTEtfU0laRQkxNgogI2RlZmluZSBWRVRIX1hEUF9CQVRDSAkJMTYKIAor
I2RlZmluZSBWRVRIX0JRTF9DT0FMX1RYX1VTRUNTCTEwMCAvKiBkZWZhdWx0IHR4LXVzZWNz
IGZvciBCUUwgYmF0Y2hpbmcgKi8KKwogc3RydWN0IHZldGhfc3RhdHMgewogCXU2NAlyeF9k
cm9wczsKIAkvKiB4ZHAgKi8KQEAgLTYyLDYgKzY1LDExIEBAIHN0cnVjdCB2ZXRoX3JxX3N0
YXRzIHsKIAlzdHJ1Y3QgdTY0X3N0YXRzX3N5bmMJc3luY3A7CiB9OwogCitzdHJ1Y3QgdmV0
aF9icWxfc3RhdGUgeworCXU2NAl0aW1lOwkvKiBzY2hlZF9jbG9jaygpIHdoZW4gY3VycmVu
dCBjb2FsZXNjaW5nIHdpbmRvdyBzdGFydGVkICovCisJdWludAluX2JxbDsJLyogQlFMIGNv
bXBsZXRpb25zIGJhdGNoZWQgaW4gdGhlIGN1cnJlbnQgd2luZG93ICovCit9OworCiBzdHJ1
Y3QgdmV0aF9ycSB7CiAJc3RydWN0IG5hcGlfc3RydWN0CXhkcF9uYXBpOwogCXN0cnVjdCBu
YXBpX3N0cnVjdCBfX3JjdSAqbmFwaTsgLyogcG9pbnRzIHRvIHhkcF9uYXBpIHdoZW4gdGhl
IGxhdHRlciBpcyBpbml0aWFsaXplZCAqLwpAQCAtNjksNiArNzcsNyBAQCBzdHJ1Y3QgdmV0
aF9ycSB7CiAJc3RydWN0IGJwZl9wcm9nIF9fcmN1CSp4ZHBfcHJvZzsKIAlzdHJ1Y3QgeGRw
X21lbV9pbmZvCXhkcF9tZW07CiAJc3RydWN0IHZldGhfcnFfc3RhdHMJc3RhdHM7CisJc3Ry
dWN0IHZldGhfYnFsX3N0YXRlCWJxbF9zdGF0ZTsKIAlib29sCQkJcnhfbm90aWZ5X21hc2tl
ZDsKIAlzdHJ1Y3QgcHRyX3JpbmcJCXhkcF9yaW5nOwogCXN0cnVjdCB4ZHBfcnhxX2luZm8J
eGRwX3J4cTsKQEAgLTgxLDYgKzkwLDcgQEAgc3RydWN0IHZldGhfcHJpdiB7CiAJc3RydWN0
IGJwZl9wcm9nCQkqX3hkcF9wcm9nOwogCXN0cnVjdCB2ZXRoX3JxCQkqcnE7CiAJdW5zaWdu
ZWQgaW50CQlyZXF1ZXN0ZWRfaGVhZHJvb207CisJdW5zaWduZWQgaW50CQl0eF9jb2FsX3Vz
ZWNzOwkvKiBCUUwgY29tcGxldGlvbiBjb2FsZXNjaW5nICovCiB9OwogCiBzdHJ1Y3QgdmV0
aF94ZHBfdHhfYnEgewpAQCAtMjY1LDcgKzI3NSwzMSBAQCBzdGF0aWMgdm9pZCB2ZXRoX2dl
dF9jaGFubmVscyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogc3RhdGljIGludCB2ZXRoX3Nl
dF9jaGFubmVscyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogCQkJICAgICBzdHJ1Y3QgZXRo
dG9vbF9jaGFubmVscyAqY2gpOwogCitzdGF0aWMgaW50IHZldGhfZ2V0X2NvYWxlc2NlKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYsCisJCQkgICAgIHN0cnVjdCBldGh0b29sX2NvYWxlc2Nl
ICplYywKKwkJCSAgICAgc3RydWN0IGtlcm5lbF9ldGh0b29sX2NvYWxlc2NlICprZXJuZWxf
Y29hbCwKKwkJCSAgICAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQoreworCXN0
cnVjdCB2ZXRoX3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihkZXYpOworCisJZWMtPnR4X2Nv
YWxlc2NlX3VzZWNzID0gcHJpdi0+dHhfY29hbF91c2VjczsKKwlyZXR1cm4gMDsKK30KKwor
c3RhdGljIGludCB2ZXRoX3NldF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAor
CQkJICAgICBzdHJ1Y3QgZXRodG9vbF9jb2FsZXNjZSAqZWMsCisJCQkgICAgIHN0cnVjdCBr
ZXJuZWxfZXRodG9vbF9jb2FsZXNjZSAqa2VybmVsX2NvYWwsCisJCQkgICAgIHN0cnVjdCBu
ZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykKK3sKKwlzdHJ1Y3QgdmV0aF9wcml2ICpwcml2ID0g
bmV0ZGV2X3ByaXYoZGV2KTsKKworCS8qIFBhaXJlZCB3aXRoIFJFQURfT05DRSBpbiB2ZXRo
X3hkcF9yY3YoKS4gKi8KKwlXUklURV9PTkNFKHByaXYtPnR4X2NvYWxfdXNlY3MsIGVjLT50
eF9jb2FsZXNjZV91c2Vjcyk7CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZXRodG9vbF9vcHMgdmV0aF9ldGh0b29sX29wcyA9IHsKKwkuc3VwcG9ydGVkX2NvYWxl
c2NlX3BhcmFtcyA9IEVUSFRPT0xfQ09BTEVTQ0VfVFhfVVNFQ1MsCiAJLmdldF9kcnZpbmZv
CQk9IHZldGhfZ2V0X2RydmluZm8sCiAJLmdldF9saW5rCQk9IGV0aHRvb2xfb3BfZ2V0X2xp
bmssCiAJLmdldF9zdHJpbmdzCQk9IHZldGhfZ2V0X3N0cmluZ3MsCkBAIC0yNzUsNiArMzA5
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBldGh0b29sX29wcyB2ZXRoX2V0aHRvb2xfb3Bz
ID0gewogCS5nZXRfdHNfaW5mbwkJPSBldGh0b29sX29wX2dldF90c19pbmZvLAogCS5nZXRf
Y2hhbm5lbHMJCT0gdmV0aF9nZXRfY2hhbm5lbHMsCiAJLnNldF9jaGFubmVscwkJPSB2ZXRo
X3NldF9jaGFubmVscywKKwkuZ2V0X2NvYWxlc2NlCQk9IHZldGhfZ2V0X2NvYWxlc2NlLAor
CS5zZXRfY29hbGVzY2UJCT0gdmV0aF9zZXRfY29hbGVzY2UsCiB9OwogCiAvKiBnZW5lcmFs
IHJvdXRpbmVzICovCkBAIC05MzcsMTMgKzk3Myw1NiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1
ZmYgKnZldGhfeGRwX3Jjdl9za2Ioc3RydWN0IHZldGhfcnEgKnJxLAogCXJldHVybiBOVUxM
OwogfQogCitzdGF0aWMgdm9pZCB2ZXRoX2JxbF9tYXliZV9jb21wbGV0ZShzdHJ1Y3QgdmV0
aF9icWxfc3RhdGUgKnN0YXRlLAorCQkJCSAgICBzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICpwZWVy
X3R4cSwKKwkJCQkgICAgdTY0IGJxbF9mbHVzaF9ucykKK3sKKwl1NjQgY3VycmVudF90aW1l
OworCisJLyogVGhlcmUgaXMgbm8gcmVhc29uIHRvIGNvbXBsZXRlIHdpdGggMCBhbmQKKwkg
KiBwZWVyX3R4cSBjb3VsZCBnbyBhd2F5LgorCSAqLworCWlmICghc3RhdGUtPm5fYnFsIHx8
ICFwZWVyX3R4cSkKKwkJcmV0dXJuOworCisJY3VycmVudF90aW1lID0gc2NoZWRfY2xvY2so
KTsKKworCS8qIFdlIGNvbXBsZXRlIGlmOgorCSAqIDEuIFdlIHJlYWNoIGJxbF9mbHVzaF9u
cy4KKwkgKiAyLiBXZSBwb3RlbnRpYWxseSBoYXZlIEJRTCBzdGFydmF0aW9uLgorCSAqLwor
CWlmIChzdGF0ZS0+dGltZSArIGJxbF9mbHVzaF9ucyA8PSBjdXJyZW50X3RpbWUgfHwKKwkg
ICAgc3RhdGUtPm5fYnFsID4gcGVlcl90eHEtPmRxbC5saW1pdCkgeworCQluZXRkZXZfdHhf
Y29tcGxldGVkX3F1ZXVlKHBlZXJfdHhxLCBzdGF0ZS0+bl9icWwsCisJCQkJCSAgc3RhdGUt
Pm5fYnFsICogVkVUSF9CUUxfVU5JVCk7CisJCXN0YXRlLT50aW1lID0gY3VycmVudF90aW1l
OworCQlzdGF0ZS0+bl9icWwgPSAwOworCX0KK30KKwogc3RhdGljIGludCB2ZXRoX3hkcF9y
Y3Yoc3RydWN0IHZldGhfcnEgKnJxLCBpbnQgYnVkZ2V0LAogCQkJc3RydWN0IHZldGhfeGRw
X3R4X2JxICpicSwKIAkJCXN0cnVjdCB2ZXRoX3N0YXRzICpzdGF0cywKIAkJCXN0cnVjdCBu
ZXRkZXZfcXVldWUgKnBlZXJfdHhxKQogeworCXN0cnVjdCB2ZXRoX2JxbF9zdGF0ZSAqc3Rh
dGUgPSAmcnEtPmJxbF9zdGF0ZTsKIAlpbnQgaSwgZG9uZSA9IDAsIG5feGRwZiA9IDA7CiAJ
dm9pZCAqeGRwZltWRVRIX1hEUF9CQVRDSF07CisJc3RydWN0IHZldGhfcHJpdiAqcHJpdjsK
Kwl1NjQgYnFsX2ZsdXNoX25zOworCisJcHJpdiA9IG5ldGRldl9wcml2KHJxLT5kZXYpOwor
CisJLyogUGFpcmVkIHdpdGggV1JJVEVfT05DRSgpIGluIHZldGhfc2V0X2NvYWxlc2NlKCku
ICovCisJYnFsX2ZsdXNoX25zID0gKHU2NClSRUFEX09OQ0UocHJpdi0+dHhfY29hbF91c2Vj
cykgKiAxMDAwOworCisJLyogQ2xhbXAgc3RvcmVkIHRpbWVzdGFtcCBpbiBjYXNlIHdlIG1p
Z3JhdGVkIHRvIGEgQ1BVIHdpdGggYSBiZWhpbmQKKwkgKiBzY2hlZF9jbG9jaygpOyB0cmll
cyB0byByZWR1Y2UgbGF0ZSBCUUwgZmx1c2hlcy4KKwkgKi8KKwlzdGF0ZS0+dGltZSA9IG1p
bihzdGF0ZS0+dGltZSwgc2NoZWRfY2xvY2soKSk7CisKKwkvKiBGbHVzaCBjb21wbGV0aW9u
cyB0aGF0IHRpbWVkIG91dCBzaW5jZSB0aGUgcHJldmlvdXMgTkFQSSBwb2xsLiAqLworCXZl
dGhfYnFsX21heWJlX2NvbXBsZXRlKHN0YXRlLCBwZWVyX3R4cSwgYnFsX2ZsdXNoX25zKTsK
IAogCWZvciAoaSA9IDA7IGkgPCBidWRnZXQ7IGkrKykgewogCQl2b2lkICpwdHIgPSBfX3B0
cl9yaW5nX2NvbnN1bWUoJnJxLT54ZHBfcmluZyk7CkBAIC05NjgsMTIgKzEwNDcsMTAgQEAg
c3RhdGljIGludCB2ZXRoX3hkcF9yY3Yoc3RydWN0IHZldGhfcnEgKnJxLCBpbnQgYnVkZ2V0
LAogCQkJfQogCQl9IGVsc2UgewogCQkJLyogbmRvX3N0YXJ0X3htaXQgKi8KLQkJCWJvb2wg
YnFsX2NoYXJnZWQgPSB2ZXRoX3B0cl9pc19icWwocHRyKTsKIAkJCXN0cnVjdCBza19idWZm
ICpza2IgPSB2ZXRoX3B0cl90b19za2IocHRyKTsKIAorCQkJc3RhdGUtPm5fYnFsICs9IHZl
dGhfcHRyX2lzX2JxbChwdHIpOwogCQkJc3RhdHMtPnhkcF9ieXRlcyArPSBza2ItPmxlbjsK
LQkJCWlmIChwZWVyX3R4cSAmJiBicWxfY2hhcmdlZCkKLQkJCQluZXRkZXZfdHhfY29tcGxl
dGVkX3F1ZXVlKHBlZXJfdHhxLCAxLCBWRVRIX0JRTF9VTklUKTsKIAogCQkJc2tiID0gdmV0
aF94ZHBfcmN2X3NrYihycSwgc2tiLCBicSwgc3RhdHMpOwogCQkJaWYgKHNrYikgewpAQCAt
OTgzLDYgKzEwNjAsNyBAQCBzdGF0aWMgaW50IHZldGhfeGRwX3JjdihzdHJ1Y3QgdmV0aF9y
cSAqcnEsIGludCBidWRnZXQsCiAJCQkJCW5hcGlfZ3JvX3JlY2VpdmUoJnJxLT54ZHBfbmFw
aSwgc2tiKTsKIAkJCX0KIAkJfQorCQl2ZXRoX2JxbF9tYXliZV9jb21wbGV0ZShzdGF0ZSwg
cGVlcl90eHEsIGJxbF9mbHVzaF9ucyk7CiAJCWRvbmUrKzsKIAl9CiAKQEAgLTEwOTEsNiAr
MTE2OSw5IEBAIHN0YXRpYyBpbnQgX192ZXRoX25hcGlfZW5hYmxlX3JhbmdlKHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYsIGludCBzdGFydCwgaW50IGVuZCkKIAlmb3IgKGkgPSBzdGFydDsg
aSA8IGVuZDsgaSsrKSB7CiAJCXN0cnVjdCB2ZXRoX3JxICpycSA9ICZwcml2LT5ycVtpXTsK
IAorCQlycS0+YnFsX3N0YXRlLnRpbWUgPSBzY2hlZF9jbG9jaygpOworCQlycS0+YnFsX3N0
YXRlLm5fYnFsID0gMDsKKwogCQluYXBpX2VuYWJsZSgmcnEtPnhkcF9uYXBpKTsKIAkJcmN1
X2Fzc2lnbl9wb2ludGVyKHByaXYtPnJxW2ldLm5hcGksICZwcml2LT5ycVtpXS54ZHBfbmFw
aSk7CiAJfQpAQCAtMTEzNSw2ICsxMjE2LDggQEAgc3RhdGljIHZvaWQgdmV0aF9uYXBpX2Rl
bF9yYW5nZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBpbnQgc3RhcnQsIGludCBlbmQpCiAK
IAkJcnEtPnJ4X25vdGlmeV9tYXNrZWQgPSBmYWxzZTsKIAkJcHRyX3JpbmdfY2xlYW51cCgm
cnEtPnhkcF9yaW5nLCB2ZXRoX3B0cl9mcmVlKTsKKwkJcnEtPmJxbF9zdGF0ZS5uX2JxbCA9
IDA7CisJCXJxLT5icWxfc3RhdGUudGltZSA9IDA7CiAJfQogCiAJLyogUmVzZXQgQlFMIGFu
ZCB3YWtlIHN0b3BwZWQgcGVlciB0eHFzLiAgQSBjb25jdXJyZW50IHZldGhfeG1pdCgpCkBA
IC0xODEzLDYgKzE4OTYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHhkcF9tZXRhZGF0YV9v
cHMgdmV0aF94ZHBfbWV0YWRhdGFfb3BzID0gewogCiBzdGF0aWMgdm9pZCB2ZXRoX3NldHVw
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiB7CisJc3RydWN0IHZldGhfcHJpdiAqcHJpdiA9
IG5ldGRldl9wcml2KGRldik7CisKIAlldGhlcl9zZXR1cChkZXYpOwogCiAJZGV2LT5wcml2
X2ZsYWdzICY9IH5JRkZfVFhfU0tCX1NIQVJJTkc7CkBAIC0xODM4LDYgKzE5MjMsOCBAQCBz
dGF0aWMgdm9pZCB2ZXRoX3NldHVwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJZGV2LT5t
YXhfbXR1ID0gRVRIX01BWF9NVFU7CiAJZGV2LT53YXRjaGRvZ190aW1lbyA9IG1zZWNzX3Rv
X2ppZmZpZXMoMTYwMDApOwogCisJcHJpdi0+dHhfY29hbF91c2VjcyA9IFZFVEhfQlFMX0NP
QUxfVFhfVVNFQ1M7CisKIAlkZXYtPmh3X2ZlYXR1cmVzID0gVkVUSF9GRUFUVVJFUzsKIAlk
ZXYtPmh3X2VuY19mZWF0dXJlcyA9IFZFVEhfRkVBVFVSRVM7CiAJZGV2LT5tcGxzX2ZlYXR1
cmVzID0gTkVUSUZfRl9IV19DU1VNIHwgTkVUSUZfRl9HU09fU09GVFdBUkU7Ci0tIAoyLjQz
LjAKCg==

--------------PiV1pwb044zmkApcZlhTjx1z--

