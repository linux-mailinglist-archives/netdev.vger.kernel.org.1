Return-Path: <netdev+bounces-285486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLBAGmf8/GmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F34EF054
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334E83085CFE
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836652D0C9D;
	Thu,  7 May 2026 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMaGAf2p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDA21CA13;
	Thu,  7 May 2026 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186727; cv=none; b=oueE6qd01KUrkFtWsoTaiaO9TAVHt8y3+5Im2HujM1lG5YL6+mM0sSWyvgL241flYaGB6abTM4n2QF38/+xXmZRZ/kesMTqVC2ZPqz3W4rs7sesVASYjDWjpoOQ84Cli7v7XRY/FBEVZTQa6rCCA9OfZCEBsmZICQpdfBv4qRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186727; c=relaxed/simple;
	bh=jWa/tvz2RA7Q/h9L12Bj02Egd3LiJODlv+0TiU1ebRc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ef/C3AQ+3wRCmybNjV+Y1F9VQfAbb+J0PuYK6ibuP1w3NSz95ctb2j5t0K4YvGV65UJCMSRD7g0TGOYz9NNJ6d7gTPgzGyJw9dUuAQgbP5QkBvh7fFM2mMwwfUt2cIjOuoIOm1zsVA9BwJbICdc9MuG+KMWmh9tYC5+1K+btq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMaGAf2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDD4C2BCB2;
	Thu,  7 May 2026 20:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778186726;
	bh=jWa/tvz2RA7Q/h9L12Bj02Egd3LiJODlv+0TiU1ebRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uMaGAf2p9ZQvQB/MpuNswbmA06THheTYRFmNoUYkOOYS+rnmjv3v/jQ23xt5L+RZM
	 rLEj59jp6swxg6dvlkCGfKaloZ6ILnS/2jwtVb9A8rIEdJZ13iF9yFrAAWl7qWfete
	 cRa/N980mlXRL2JnGmPjDbz/O93Hs8KOm/fNrS2ti/+qv2Fihxr4LU/U9GmchoYjyR
	 aZ1vyoemtnZZvH7NNa9c1+W6MVFp+lI+akWXnmfpuVUPGLturIjJ49ArolvOCzXcNb
	 Dj0E+qu3Y/RyjSDUO4Fp/hCoIFTuCkrVWvOZ5px0pP37U8c9on5bCd4UscxqY/CqP1
	 0uYFO6BVP/4bQ==
Content-Type: multipart/mixed; boundary="------------A7dxKhK90qNemO0vZWmLDmZn"
Message-ID: <3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org>
Date: Thu, 7 May 2026 22:45:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
 <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
 <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
 <68223314-1a44-4aee-8207-57437ef9f3ab@schippers-hamm.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <68223314-1a44-4aee-8207-57437ef9f3ab@schippers-hamm.de>
X-Rspamd-Queue-Id: CE2F34EF054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285486-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------A7dxKhK90qNemO0vZWmLDmZn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/05/2026 22.12, Simon Schippers wrote:
> On 5/7/26 21:09, Jesper Dangaard Brouer wrote:
>>
>>
>> On 07/05/2026 16.46, Simon Schippers wrote:
>>>
>>>
>>> On 5/7/26 16:34, Paolo Abeni wrote:
>>>> On 5/7/26 8:54 AM, Simon Schippers wrote:
>>>>> On 5/5/26 15:21, hawk@kernel.org wrote:
>>>>>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>>>>                }
>>>>>>            } else {
>>>>>>                /* ndo_start_xmit */
>>>>>> -            struct sk_buff *skb = ptr;
>>>>>> +            bool bql_charged = veth_ptr_is_bql(ptr);
>>>>>> +            struct sk_buff *skb = veth_ptr_to_skb(ptr);
>>>>>>                  stats->xdp_bytes += skb->len;
>>>>>> +            if (peer_txq && bql_charged)
>>>>>> +                netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
>>>>>
>>>>> In the discussion with Jonas [1], I left a comment explaining why I think
>>>>> this doesn’t work.
>>>>>
>>
>> I've experimented with doing the "completion" at NAPI-end in
>> veth_poll(), but that resulted in BQL limit being 128 packets, which
>> leads to bad latency results (not acceptable).
>> (See detailed report later)
>>
>>
>>>>> I still think first that adding an option to modify the hard-coded
>>>>> VETH_RING_SIZE is the way to go.
>>>>>
>>
>> Not against being able to modify VETH_RING_SIZE, but I don't think it is
>> the solution here.
>>
>> The simply solution is the configure BQL limit_min:
>>   `/sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min`
>>
>> My experiments (below) find that limit_min=8 is gives good performance.
>> We can simply set default to 8 as this still allows userspace to change
>> this later if lower latency is preferred.
>>
>>>>> Thanks!
>>>>>
>>>>> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de/
>>>>
>>>> In the above discussion a 20% regression is reported, which IMHO can't
>>>> be ignored. Still the tput figures in the data are extremely low,
>>>> something is possibly off?!? I would expect a few Mpps with pktgen on
>>>> top of veth, while the reported data is ~20-30Kpps.
>>>>
>>>> /P
>>>>
>>>
>>> The ~20-30Kpps occur when thousands of iptables rules are applied and
>>> an UDP userspace application is sending.
>>>
>>> And there is a 20% pktgen regression (no iptables rules applied).
>>>
>>
>> The pktgen test is a little dubious/weird and Jonas had to modify pktgen
>> to test this.   John Fastabend added a config to pktgen that allows us
>> to benchmarking egress qdisc path, this might be better to use this.
>> The samples/pktgen/pktgen_bench_xmit_mode_queue_xmit.sh is a demo usage.
>>
>> If redoing the tests, can you adjust limit_min to see the effect?
>>   /sys/class/net/<dev>/queues/tx-N/byte_queue_limits/limit_min
>>
>> 20% throughput performance regression is of-cause too much, but I will
>> remind us, that adding a qdisc will "cost" some overhead, that is a
>> configuration choice.  Our purpose here is to reduce bufferbloat and
>> latency, not optimize for throughput.
>>
>>
>>> I am pretty sure the reason is because the BQL limit is stuck at 2
>>> packets (because the completed queue is always called with 1 packet
>>> and not in a interrupt/timer with multiple packets...).
>>>
>>
>> I've run a lot of experiments, which I made AI write a report over, see attachment.  The TL;DR is that best performance vs latency tradeoff is defaulting BQL/DQL limit_min to be 8 packets.
>>
>> I fear this patchset will stall forever, if we keep searching for a perfect solution without any overhead.  The qdisc layer will be a baseline overhead.  The limit=2 packets is actually the optimal darkbuffer queue size, but I acknowledge that this causes too many qdisc requeue events (leading to overhead).  I suggest that I add another patch in V6, that defaults limit_min to 8 (separate patch to make it easier to revert/adjust later).
>>
>> I've talked with Jonas, and we want to experiment with different solutions to make BQL/DQL work better with virtual devices.
>>
>> This patchset helps our (production) use-case reduce mice-flow latency
>> from approx 22ms to 1.3ms for latency under-load.  Due to the consumer
>> namespace being the bottleneck the requeue overhead is negligible in
>> comparison.
>>
>> -Jesper
> 
> First of all thanks for you work and I really see the advantages of
> avoiding bufferbloat :)
> 
> But the key of the BQL algorithm, which is the *dynamic* adaption of the
> limit, is not working. Always calling netdev_completed_queue() with
> 1 packet results in a static limit of 2 packets (as seen by Jonas
> measurements), which you force up to 8 packets.
> 
> So in the end this patchset has the same effect as just setting
> VETH_RING_SIZE to 8 (and giving an option to change this value).
> 

I've code up a time based BQL implementation, see attachment.
WDYT?

--Jesper





--------------A7dxKhK90qNemO0vZWmLDmZn
Content-Type: text/x-patch; charset=UTF-8;
 name="09-veth-time-based-bql-coalescing.patch"
Content-Disposition: attachment;
 filename="09-veth-time-based-bql-coalescing.patch"
Content-Transfer-Encoding: base64

dmV0aDogdGltZS1iYXNlZCBCUUwgY29tcGxldGlvbiBjb2FsZXNjaW5nIHZpYSBldGh0b29s
IHR4LXVzZWNzCgpGcm9tOiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5v
cmc+CgpCdWZmZXJibG9hdCBpcyBmdW5kYW1lbnRhbGx5IGEgbGF0ZW5jeSBwcm9ibGVtIC0t
IHdoYXQgbWF0dGVycyBpcyB0aGUKdGltZSBwYWNrZXRzIHNwZW5kIHdhaXRpbmcgaW4gcXVl
dWVzLCBhcyBwZXJjZWl2ZWQgYnkgdXNlcnMgYW5kCmFwcGxpY2F0aW9ucy4gQmFzZSBCUUwg
Y29tcGxldGlvbiBjb2FsZXNjaW5nIG9uIGVsYXBzZWQgdGltZSByYXRoZXIKdGhhbiBwYWNr
ZXQgY291bnRzIHRvIGRpcmVjdGx5IGNvbnRyb2wgcXVldWluZyBkZWxheS4KCkFkZCBldGh0
b29sIHR4LXVzZWNzIHN1cHBvcnQgdG8gdmV0aCBmb3IgdHVuaW5nIEJRTCBjb21wbGV0aW9u
CmNvYWxlc2NpbmcuIEluc3RlYWQgb2YgY29tcGxldGluZyBCUUwgcGVyLXBhY2tldCAod2hp
Y2ggZm9yY2VzIERRTCB0bwpsaW1pdD0yIHdpdGggaGlnaCBOQVBJIHNjaGVkdWxpbmcgb3Zl
cmhlYWQpIG9yIHBlci1OQVBJLXBvbGwgKHdoaWNoCm92ZXItYnVmZmVycyBhdCBidWRnZXQ9
NjQpLCBhY2N1bXVsYXRlIGNvbXBsZXRpb25zIGFuZCBmbHVzaCB0aGVtIHdoZW4KYSBjb25m
aWd1cmFibGUgdGltZSB0aHJlc2hvbGQgaXMgZXhjZWVkZWQuIFRoaXMgbGV0cyBEUUwgZGlz
Y292ZXIgYQpsaW1pdCB0aGF0IGJvdW5kcyB0aGUgYWN0dWFsIHF1ZXVpbmcgZGVsYXkgdG8g
dGhlIGNvbmZpZ3VyZWQgaW50ZXJ2YWwuCgpUaGUgZGVmYXVsdCBvZiAxMCB1c2VjcyAoVkVU
SF9CUUxfQ09BTF9UWF9VU0VDUykgcHJvdmlkZXMgYSBnb29kCmJhbGFuY2U6IERRTCBjb252
ZXJnZXMgdG8gYSBzbWFsbCBsaW1pdCB0aGF0IGtlZXBzIHF1ZXVpbmcgZGVsYXkKYm91bmRl
ZCB3aGlsZSBhbGxvd2luZyBlZmZpY2llbnQgTkFQSSBiYXRjaCBwcm9jZXNzaW5nLiBTZXR0
aW5nCnR4LXVzZWNzIHRvIDAgZGlzYWJsZXMgY29hbGVzY2luZyBhbmQgZmFsbHMgYmFjayB0
byBwZXItcGFja2V0CmNvbXBsZXRpb24gKGxpbWl0PTIsIGxvd2VzdCBsYXRlbmN5LCBoaWdo
ZXN0IE5BUEkgb3ZlcmhlYWQpLgoKVXNhZ2U6CiAgZXRodG9vbCAtQyA8dmV0aC1kZXY+IHR4
LXVzZWNzIDUwMCAgICMgNTAwdXMgY29hbGVzY2luZwogIGV0aHRvb2wgLUMgPHZldGgtZGV2
PiB0eC11c2VjcyAwICAgICAjIHBlci1wYWNrZXQgKG5vIGNvYWxlc2NpbmcpCgpVc2VzIGxv
Y2FsX2Nsb2NrKCkgKHJkdHNjIG9uIHg4NiwgfjIwbnMpIGZvciBzdWItamlmZnkgcmVzb2x1
dGlvbi4KClNpZ25lZC1vZmYtYnk6IEplc3BlciBEYW5nYWFyZCBCcm91ZXIgPGhhd2tAa2Vy
bmVsLm9yZz4KLS0tCiBkcml2ZXJzL25ldC92ZXRoLmMgfCAgIDU5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA1NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3ZldGguYyBiL2RyaXZlcnMvbmV0L3ZldGguYwppbmRleCA0MTAzZDI5OGFhOWIu
LjYwMzVmN2VjOTJiNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdmV0aC5jCisrKyBiL2Ry
aXZlcnMvbmV0L3ZldGguYwpAQCAtNDMsNiArNDMsNyBAQAogCiAjZGVmaW5lIFZFVEhfWERQ
X1RYX0JVTEtfU0laRQkxNgogI2RlZmluZSBWRVRIX1hEUF9CQVRDSAkJMTYKKyNkZWZpbmUg
VkVUSF9CUUxfQ09BTF9UWF9VU0VDUwkxMAkvKiBkZWZhdWx0IHR4LXVzZWNzIGZvciBCUUwg
YmF0Y2hpbmcgKi8KIAogc3RydWN0IHZldGhfc3RhdHMgewogCXU2NAlyeF9kcm9wczsKQEAg
LTgxLDYgKzgyLDcgQEAgc3RydWN0IHZldGhfcHJpdiB7CiAJc3RydWN0IGJwZl9wcm9nCQkq
X3hkcF9wcm9nOwogCXN0cnVjdCB2ZXRoX3JxCQkqcnE7CiAJdW5zaWduZWQgaW50CQlyZXF1
ZXN0ZWRfaGVhZHJvb207CisJdW5zaWduZWQgaW50CQl0eF9jb2FsX3VzZWNzOwkvKiBCUUwg
Y29tcGxldGlvbiBjb2FsZXNjaW5nICovCiB9OwogCiBzdHJ1Y3QgdmV0aF94ZHBfdHhfYnEg
ewpAQCAtMjY1LDcgKzI2NywzMCBAQCBzdGF0aWMgdm9pZCB2ZXRoX2dldF9jaGFubmVscyhz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogc3RhdGljIGludCB2ZXRoX3NldF9jaGFubmVscyhz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogCQkJICAgICBzdHJ1Y3QgZXRodG9vbF9jaGFubmVs
cyAqY2gpOwogCitzdGF0aWMgaW50IHZldGhfZ2V0X2NvYWxlc2NlKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsCisJCQkgICAgc3RydWN0IGV0aHRvb2xfY29hbGVzY2UgKmVjLAorCQkJICAg
IHN0cnVjdCBrZXJuZWxfZXRodG9vbF9jb2FsZXNjZSAqa2VybmVsX2NvYWwsCisJCQkgICAg
c3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQoreworCXN0cnVjdCB2ZXRoX3ByaXYg
KnByaXYgPSBuZXRkZXZfcHJpdihkZXYpOworCisJZWMtPnR4X2NvYWxlc2NlX3VzZWNzID0g
cHJpdi0+dHhfY29hbF91c2VjczsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCB2ZXRo
X3NldF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAorCQkJICAgIHN0cnVjdCBl
dGh0b29sX2NvYWxlc2NlICplYywKKwkJCSAgICBzdHJ1Y3Qga2VybmVsX2V0aHRvb2xfY29h
bGVzY2UgKmtlcm5lbF9jb2FsLAorCQkJICAgIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4
dGFjaykKK3sKKwlzdHJ1Y3QgdmV0aF9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsK
KworCXByaXYtPnR4X2NvYWxfdXNlY3MgPSBlYy0+dHhfY29hbGVzY2VfdXNlY3M7CisJcmV0
dXJuIDA7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMgdmV0aF9ldGh0
b29sX29wcyA9IHsKKwkuc3VwcG9ydGVkX2NvYWxlc2NlX3BhcmFtcyA9IEVUSFRPT0xfQ09B
TEVTQ0VfVFhfVVNFQ1MsCiAJLmdldF9kcnZpbmZvCQk9IHZldGhfZ2V0X2RydmluZm8sCiAJ
LmdldF9saW5rCQk9IGV0aHRvb2xfb3BfZ2V0X2xpbmssCiAJLmdldF9zdHJpbmdzCQk9IHZl
dGhfZ2V0X3N0cmluZ3MsCkBAIC0yNzUsNiArMzAwLDggQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBldGh0b29sX29wcyB2ZXRoX2V0aHRvb2xfb3BzID0gewogCS5nZXRfdHNfaW5mbwkJPSBl
dGh0b29sX29wX2dldF90c19pbmZvLAogCS5nZXRfY2hhbm5lbHMJCT0gdmV0aF9nZXRfY2hh
bm5lbHMsCiAJLnNldF9jaGFubmVscwkJPSB2ZXRoX3NldF9jaGFubmVscywKKwkuZ2V0X2Nv
YWxlc2NlCQk9IHZldGhfZ2V0X2NvYWxlc2NlLAorCS5zZXRfY29hbGVzY2UJCT0gdmV0aF9z
ZXRfY29hbGVzY2UsCiB9OwogCiAvKiBnZW5lcmFsIHJvdXRpbmVzICovCkBAIC05NDIsOCAr
OTY5LDE0IEBAIHN0YXRpYyBpbnQgdmV0aF94ZHBfcmN2KHN0cnVjdCB2ZXRoX3JxICpycSwg
aW50IGJ1ZGdldCwKIAkJCXN0cnVjdCB2ZXRoX3N0YXRzICpzdGF0cywKIAkJCXN0cnVjdCBu
ZXRkZXZfcXVldWUgKnBlZXJfdHhxKQogeworCXU2NCBicWxfZmx1c2hfbnMsIGJxbF9mbHVz
aF90aW1lID0gMDsKIAlpbnQgaSwgZG9uZSA9IDAsIG5feGRwZiA9IDA7CiAJdm9pZCAqeGRw
ZltWRVRIX1hEUF9CQVRDSF07CisJc3RydWN0IHZldGhfcHJpdiAqcHJpdjsKKwlpbnQgbl9i
cWwgPSAwOworCisJcHJpdiA9IG5ldGRldl9wcml2KHJxLT5kZXYpOworCWJxbF9mbHVzaF9u
cyA9ICh1NjQpcHJpdi0+dHhfY29hbF91c2VjcyAqIDEwMDA7CiAKIAlmb3IgKGkgPSAwOyBp
IDwgYnVkZ2V0OyBpKyspIHsKIAkJdm9pZCAqcHRyID0gX19wdHJfcmluZ19jb25zdW1lKCZy
cS0+eGRwX3JpbmcpOwpAQCAtOTcyLDggKzEwMDUsMjMgQEAgc3RhdGljIGludCB2ZXRoX3hk
cF9yY3Yoc3RydWN0IHZldGhfcnEgKnJxLCBpbnQgYnVkZ2V0LAogCQkJc3RydWN0IHNrX2J1
ZmYgKnNrYiA9IHZldGhfcHRyX3RvX3NrYihwdHIpOwogCiAJCQlzdGF0cy0+eGRwX2J5dGVz
ICs9IHNrYi0+bGVuOwotCQkJaWYgKHBlZXJfdHhxICYmIGJxbF9jaGFyZ2VkKQotCQkJCW5l
dGRldl90eF9jb21wbGV0ZWRfcXVldWUocGVlcl90eHEsIDEsIFZFVEhfQlFMX1VOSVQpOwor
CQkJaWYgKHBlZXJfdHhxICYmIGJxbF9jaGFyZ2VkKSB7CisJCQkJaWYgKCFicWxfZmx1c2hf
bnMpIHsKKwkJCQkJbmV0ZGV2X3R4X2NvbXBsZXRlZF9xdWV1ZShwZWVyX3R4cSwgMSwKKwkJ
CQkJCQkJICBWRVRIX0JRTF9VTklUKTsKKwkJCQl9IGVsc2UgeworCQkJCQl1NjQgbm93ID0g
bG9jYWxfY2xvY2soKTsKKwkJCQkJbl9icWwrKzsKKwkJCQkJaWYgKCFicWxfZmx1c2hfdGlt
ZSkgeworCQkJCQkJYnFsX2ZsdXNoX3RpbWUgPSBub3c7CisJCQkJCX0gZWxzZSBpZiAobm93
IC0gYnFsX2ZsdXNoX3RpbWUgPj0gYnFsX2ZsdXNoX25zKSB7CisJCQkJCQluZXRkZXZfdHhf
Y29tcGxldGVkX3F1ZXVlKHBlZXJfdHhxLCBuX2JxbCwKKwkJCQkJCQkJCSAgbl9icWwgKiBW
RVRIX0JRTF9VTklUKTsKKwkJCQkJCW5fYnFsID0gMDsKKwkJCQkJCWJxbF9mbHVzaF90aW1l
ID0gMDsKKwkJCQkJfQorCQkJCX0KKwkJCX0KIAogCQkJc2tiID0gdmV0aF94ZHBfcmN2X3Nr
YihycSwgc2tiLCBicSwgc3RhdHMpOwogCQkJaWYgKHNrYikgewpAQCAtOTg5LDYgKzEwMzcs
OSBAQCBzdGF0aWMgaW50IHZldGhfeGRwX3JjdihzdHJ1Y3QgdmV0aF9ycSAqcnEsIGludCBi
dWRnZXQsCiAJaWYgKG5feGRwZikKIAkJdmV0aF94ZHBfcmN2X2J1bGtfc2tiKHJxLCB4ZHBm
LCBuX3hkcGYsIGJxLCBzdGF0cyk7CiAKKwlpZiAocGVlcl90eHEgJiYgbl9icWwpCisJCW5l
dGRldl90eF9jb21wbGV0ZWRfcXVldWUocGVlcl90eHEsIG5fYnFsLCBuX2JxbCAqIFZFVEhf
QlFMX1VOSVQpOworCiAJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmcnEtPnN0YXRzLnN5bmNw
KTsKIAlycS0+c3RhdHMudnMueGRwX3JlZGlyZWN0ICs9IHN0YXRzLT54ZHBfcmVkaXJlY3Q7
CiAJcnEtPnN0YXRzLnZzLnhkcF9ieXRlcyArPSBzdGF0cy0+eGRwX2J5dGVzOwpAQCAtMTgx
Myw2ICsxODY0LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ZHBfbWV0YWRhdGFfb3BzIHZl
dGhfeGRwX21ldGFkYXRhX29wcyA9IHsKIAogc3RhdGljIHZvaWQgdmV0aF9zZXR1cChzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQogeworCXN0cnVjdCB2ZXRoX3ByaXYgKnByaXYgPSBuZXRk
ZXZfcHJpdihkZXYpOworCiAJZXRoZXJfc2V0dXAoZGV2KTsKIAogCWRldi0+cHJpdl9mbGFn
cyAmPSB+SUZGX1RYX1NLQl9TSEFSSU5HOwpAQCAtMTgzOCw2ICsxODkxLDggQEAgc3RhdGlj
IHZvaWQgdmV0aF9zZXR1cChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogCWRldi0+bWF4X210
dSA9IEVUSF9NQVhfTVRVOwogCWRldi0+d2F0Y2hkb2dfdGltZW8gPSBtc2Vjc190b19qaWZm
aWVzKDE2MDAwKTsKIAorCXByaXYtPnR4X2NvYWxfdXNlY3MgPSBWRVRIX0JRTF9DT0FMX1RY
X1VTRUNTOworCiAJZGV2LT5od19mZWF0dXJlcyA9IFZFVEhfRkVBVFVSRVM7CiAJZGV2LT5o
d19lbmNfZmVhdHVyZXMgPSBWRVRIX0ZFQVRVUkVTOwogCWRldi0+bXBsc19mZWF0dXJlcyA9
IE5FVElGX0ZfSFdfQ1NVTSB8IE5FVElGX0ZfR1NPX1NPRlRXQVJFOwo=

--------------A7dxKhK90qNemO0vZWmLDmZn--

