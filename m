Return-Path: <netdev+bounces-305308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TFNUEcelTGpPngEAu9opvQ
	(envelope-from <netdev+bounces-305308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 09:07:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F9A71845E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 09:07:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=mLL6gMnQ;
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305308-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305308-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13BA430A914B
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAA3CF67F;
	Tue,  7 Jul 2026 06:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1503D4133;
	Tue,  7 Jul 2026 06:56:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407375; cv=none; b=ZhY5ZNhLW9MzcOFXc/R20gH7ZSsPProBnB5a16lX+DsOTdTPNVoz8TuSjFh4zP+l4n44/utNEJsXxlkFii77ROEiu5H8eFz3geDdvOjEtkUiFZ2SpEMHhHpE5QmuNpj9bhcm99oSnYI4vk1gA6/c+q39BPTmbNIsK0DbTCZeT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407375; c=relaxed/simple;
	bh=d2zIMR9iq0w7LbifymeuuWYynY61NTxqkRmejtC34nY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=c/8Ast0xzY6/5apfbklJ5GBwyAldMzbrte1AAg/gbW0oFUiP4KJltVxSfVX38qRAqIp2iqPfs/+w1UM++mJ8BLgMhodKAJQto0Wl65vOurcscVa9REZmtQSUhQuCwwCKI8XFO0EwZ5cIy0eQ6uXF2OZf+VhUfIkqQX62z+4qxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=mLL6gMnQ; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783407163;
	bh=vkhL/JvOqq4fLE594PfOty70FGTkM6Hi4ORlh27V1F8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mLL6gMnQemilnEzSUBr1hLMzQfINChn3sLCBmwQhrcz17bKjz7metpn7PeNcHh7to
	 gfPRQLK/F7a8sLxZLyK83M2eV2GinL5kfHAQKt48hic1LIL/oKP2MRZmqcFz5d+8sV
	 0wE9sET7qY+DyB64QIODanEvvNyH7w2ghvnVlReE=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6676qfJM019905
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 7 Jul 2026 08:52:42 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------0EZlX0AtzGB50MshNwbsRMPs"
Message-ID: <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>
Date: Tue, 7 Jul 2026 08:52:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
To: Brett A C Sheffield <bacs@librecast.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
 <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
 <akvhhy_JpH64KrcL@karahi.librecast.net>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <akvhhy_JpH64KrcL@karahi.librecast.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305308-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bacs@librecast.net,m:mst@redhat.com,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,librecast.net:email,tu-dortmund.de:from_mime,tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98F9A71845E

This is a multi-part message in MIME format.
--------------0EZlX0AtzGB50MshNwbsRMPs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 19:10, Brett A C Sheffield wrote:
> On 2026-07-06 17:33, Simon Schippers wrote:
>> But even if we could perfectly fix the performance issues, maybe users
>> even users rely on the dropping behavior. From Brett [1]:
>>
>> "In our multicast use case data is sent by multiple threads to multiple
>> groups simultaneously, this just breaks things to the extent that a 
>> <2 second test times out after 5 minutes."
>>
>> We are *not* factor 5min * 60sec/min / 2s = 150 times slower than without
>> the patchset.
> 
> I didn't mean to suggest 150x slower. It would have been more correct if I'd
> simply said "the test normally takes <2s but fails to complete with the
> patchset". The 5min timeout was irrelevant detail.
> 
> The iperf3 tests give a much better picture of the performance impact.
> 
> I thought a simple TCP test with a familar tool might be easier than explaining
> the ways in which we're torturing multicast ;-)

Yes :D

> 
>> My theory is that the sender sends a fixed amount of data
>> of which most is dropped without backpressure, which is much faster then
>> the real processing, and so the test *relies* on the tail-dropping to
>> work.
>>
>> @Brett can you maybe support this theory?
> 
> The test synchronizes two blobs of data. The amount of data that needs syncing
> is fixed, but the amount sent will vary as it is encoded with RaptorQ.
> 
> The test sends on several multicast groups simultaneously. Each group is a
> stream of RaptorQ encoded symbols and the receiver listens on that group until
> is has enough symbols to decode. In practice, on a local tap interface, the
> packet loss is normally zero, so the amount of data sent is more or less fixed.

Hmm seems like my theory does not really hold up :D


Brett, can you try the two attached patches here with iperf3?
I think testing with 8 and 16 threads is enough, so where there is a
regression.

The two patches are about time when to wake:
Currently we wake after consuming half the internal ring buffer.
One of the attached patches wakes after 2 cachelines (128 of 1000
packets) and the other one just wakes once the ring buffer is empty.

This would really help :)


BTW: I will try to get hands on a Ryzen 9 9950X soon (I think we have a
     machine at our chair) and then try to reproduce.

Thank you!

--------------0EZlX0AtzGB50MshNwbsRMPs
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tun-set-waking-threshold-to-tx_ring.batch.patch"
Content-Disposition: attachment;
 filename="0001-tun-set-waking-threshold-to-tx_ring.batch.patch"
Content-Transfer-Encoding: base64

RnJvbSA4NzM1NmJkNTEyZjAzOWVhNTJmNWY5OTAxMjg4ZDA0M2Y3YWMzMmQ5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBTY2hpcHBlcnMgPHNpbW9uLnNjaGlwcGVy
c0B0dS1kb3J0bXVuZC5kZT4KRGF0ZTogVHVlLCA3IEp1bCAyMDI2IDA4OjIwOjIxICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gdHVuOiBzZXQgd2FraW5nIHRocmVzaG9sZCB0byA+PSB0eF9y
aW5nLmJhdGNoCgpSZXBsYWNlIHRoZSB3YWtpbmcgdGhyZXNob2xkIG9mID49IHJpbmcuc2l6
ZS8yIHdpdGggPj0gdHhfcmluZy5iYXRjaAphbGxvd2luZyBhbiBlYXJsaWVyIGNhbGwgb2Yg
bmV0aWZfdHhfd2FrZV9xdWV1ZSgpLiB0eF9yaW5nLmJhdGNoIGlzCmRlZmluZWQgYXMgci0+
YmF0Y2ggPSBTTVBfQ0FDSEVfQllURVMgKiAyIC8gc2l6ZW9mKCooci0+cXVldWUpKSwgbWVh
bmluZwphIGJhdGNoIGRlc2NyaWJlcyBhIHR3byBjYWNoZWxpbmVzIG9mIHRoZSByaW5nLgoK
T24gYSB0YXAgaW50ZXJmYWNlIG9uIGEgeDg2IHN5c3RlbSB0aGlzIG1lYW5zIHRoYXQgaW5z
dGVhZCBvZiB3YWtpbmcKYWZ0ZXIgY29uc3VtaW5nIDEwMDAvMj01MDAgc2ticyBpdCBub3cg
d2FrZXMgYWZ0ZXIgNjQgKiAyID0gMTI4IHNrYnMuCi0tLQogZHJpdmVycy9uZXQvdHVuLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jCmlu
ZGV4IGZmYmU2ZjEzZmIxZi4uNjkxNDMyYzA0MmQ2IDEwMDY0NAotLS0gYS9kcml2ZXJzL25l
dC90dW4uYworKysgYi9kcml2ZXJzL25ldC90dW4uYwpAQCAtMjE1OCw3ICsyMTU4LDcgQEAg
c3RhdGljIHZvaWQgX190dW5fd2FrZV9xdWV1ZShzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLAog
CXNtcF9tYigpOwogCWlmIChuZXRpZl90eF9xdWV1ZV9zdG9wcGVkKHR4cSkpIHsKIAkJdGZp
bGUtPmNvbnNfY250ICs9IGNvbnN1bWVkOwotCQlpZiAodGZpbGUtPmNvbnNfY250ID49IHRm
aWxlLT50eF9yaW5nLnNpemUgLyAyIHx8CisJCWlmICh0ZmlsZS0+Y29uc19jbnQgPj0gdGZp
bGUtPnR4X3JpbmcuYmF0Y2ggfHwKIAkJICAgIF9fcHRyX3JpbmdfZW1wdHkoJnRmaWxlLT50
eF9yaW5nKSkgewogCQkJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwogCQkJdGZpbGUtPmNv
bnNfY250ID0gMDsKLS0gCjIuNDMuMAoK
--------------0EZlX0AtzGB50MshNwbsRMPs
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tun-tap-vhost-net-make-qdisc-backpressure-opt-in-via.patch"
Content-Disposition: attachment;
 filename*0="0001-tun-tap-vhost-net-make-qdisc-backpressure-opt-in-via.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkY2VhMzZlMTA1YmMyMTI2ZTljNDhkMzRmOTU0MmMyMmI5MTIzZjViIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBTY2hpcHBlcnMgPHNpbW9uLnNjaGlwcGVy
c0B0dS1kb3J0bXVuZC5kZT4KRGF0ZTogVGh1LCAyIEp1bCAyMDI2IDE4OjIxOjU2ICswMjAw
ClN1YmplY3Q6IFtQQVRDSCBuZXQgdjJdIHR1bi90YXAgJiB2aG9zdC1uZXQ6IG1ha2UgcWRp
c2MgYmFja3ByZXNzdXJlIG9wdC1pbgogdmlhIElGRl9CQUNLUFJFU1NVUkUKCkNvbW1pdCAx
ZDZlNTY5YjdkMGMgKCJ0dW4vdGFwICYgdmhvc3QtbmV0OiBhdm9pZCBwdHJfcmluZyB0YWls
LWRyb3AKd2hlbiBhIHFkaXNjIGlzIHByZXNlbnQiKSBkaWQgbm90IHNob3cgYSByZWxldmFu
dCBwZXJmb3JtYW5jZSByZWdyZXNzaW9uCmluIG15IHRlc3RpbmcgYnV0IG9uIEJyZXR0IFNo
ZWZmaWVsZCdzIGxpYnJlY2FzdCB0ZXN0YmVkIGl0IHNob3dzIGEKc2lnbmlmaWNhbnQgcGVy
Zm9ybWFuY2UgZHJvcCBpbiBhIElQdjYgbXVsdGljYXN0IHRlc3RjYXNlLiBUaGUgcmVncmVz
c2lvbgpjYW4gYmUgcGlucG9pbnRlZCB3aGVuIG11bHRpcGxlIGlwZXJmMyBVRFAgdGhyZWFk
cyBhcmUgc2VuZGluZy4gRm9yIDgKdGhyZWFkcyB0aGUgcGVyZm9ybWFuY2UgZHJvcHBlZCBm
cm9tIDEzLjUgR2JpdC9zIHRvIDkuMTMgR2JpdC9zLiBUaGlzIGlzCnRoZSByZWFzb24gd2h5
IHRoaXMgcGF0Y2ggbWFrZXMgdGhlIHFkaXNjIGJhY2twcmVzc3VyZSBiZWhhdmlvciBvcHQt
aW4uCgpPbmUgb3B0aW9uIHRvIGFjY29tcGxpc2ggdGhlIG9wdC1pbiB3b3VsZCBiZSB0byBz
ZXQgdGhlIGRlZmF1bHQgcWRpc2MgdG8Kbm9xdWV1ZSBhdCBpbml0LiBIb3dldmVyIHRoaXMg
bWF5IGFsc28gYnJlYWsgdXNlcnNwYWNlIGFzIHVzZXJzIG1pZ2h0CmhhdmUgY2hvc2VuIGEg
Y3VzdG9tIHFkaXNjIGV2ZW4gdGhvdWdoIG1vc3Qgb2YgdGhlIHFkaXNjcyBkaWQgbm90aGlu
Zwpmb3IgdHVuL3RhcCBpbiB0aGUgcGFzdCBkdWUgdG8gbWlzc2luZyBiYWNrcHJlc3N1cmUu
Li4KClRoaXMgaXMgdGhlIHJlYXNvbiB3aHkgaW4gdGhpcyBwYXRjaCwgdGhlIGZsYWcgSUZG
X0JBQ0tQUkVTU1VSRSBpcwppbnRyb2R1Y2VkIGluc3RlYWQgd2hpY2ggaXMgcmVxdWlyZWQg
dG8gZW5hYmxlIHRoZSBiYWNrcHJlc3N1cmUgbG9naWMuClRoaXMgbWVhbnMgdGhlIHN0b3Bw
aW5nIGxvZ2ljIGluIHR1bl9uZXRfeG1pdCgpIGFuZCB0aGUgd2FraW5nIGxvZ2ljIGluCl9f
dHVuX3dha2VfcXVldWUoKSBhcmUgc2tpcHBlZCBpZiB0aGUgZmxhZyBpcyBkaXNhYmxlZC4K
ClRvIGF2b2lkIGEgcG9zc2libGUgc3RhbGwgZHVlIHRvIGRpc2FibGluZyBJRkZfQkFDS1BS
RVNTVVJFLCB0aGUgbmV3CmhlbHBlciB0dW5fZm9yY2Vfd2FrZV9xdWV1ZSgpIGlzIGltcGxl
bWVudGVkLiBUaGUgaGVscGVyIHNhZmVseSB3YWtlcyB0aGUKcmVzcGVjdGl2ZSBuZXRkZXYg
cXVldWUgYW5kIHJlc2V0cyBjb25zX2NudCB3aGlsZSB0aGUgY29uc3VtZXJfbG9jayBhbmQK
dGhlIHByb2R1Y2VyX2xvY2sgb2YgdGhlIHJpbmcgYXJlIGhlbGQuIFRoZSBoZWxwZXIgaXMg
cnVuIGluIHR1bl9hdHRhY2goKQp3aGVuIGEgcXVldWUgKHJlKWF0dGFjaGVzLCBpbiB0dW5f
c2V0X2lmZigpIGZvciBhdHRhY2hlZCB0ZmlsZXMsIGFuZAppbiB0dW5fcXVldWVfcmVzaXpl
KCkuCgpUaGUgZG9jdW1lbnRhdGlvbiBpbiB0dW50YXAucnN0IGlzIHVwZGF0ZWQgYWNjb3Jk
aW5nbHkuCgpGaXhlczogMWQ2ZTU2OWI3ZDBjICgidHVuL3RhcCAmIHZob3N0LW5ldDogYXZv
aWQgcHRyX3JpbmcgdGFpbC1kcm9wIHdoZW4gYSBxZGlzYyBpcyBwcmVzZW50IikKUmVwb3J0
ZWQtYnk6IEJyZXR0IFNoZWZmaWVsZCA8YnJldHRAbGlicmVjYXN0Lm5ldD4KQ2xvc2VzOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYWtWbm9PWVFPcnQ4ay1HdUBrYXJhaGku
bGlicmVjYXN0Lm5ldC9ULyN1ClNpZ25lZC1vZmYtYnk6IFNpbW9uIFNjaGlwcGVycyA8c2lt
b24uc2NoaXBwZXJzQHR1LWRvcnRtdW5kLmRlPgotLS0KVjEgLT4gVjI6Ci0gU2FzaGlrbzog
RW5zdXJlIGRldGFjaGVkIHF1ZXVlcyBhcmUgd29rZW4gb24gcmUtYXR0YWNoIGJ5IGNhbGxp
bmcgdGhlCiAgbmV3IHR1bl9mb3JjZV93YWtlX3F1ZXVlKCkgaGVscGVyIGZyb20gdHVuX2F0
dGFjaCgpLCBhbmQgcmV1c2UgaXQKICBhY3Jvc3MgdGhlIGV4aXN0aW5nIHdha2UgcGF0aHMu
Ci0gU3BlY2lmeSB0aGUgZmFpbGluZyB0ZXN0IGNhc2UgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
LgotLS0KIERvY3VtZW50YXRpb24vbmV0d29ya2luZy90dW50YXAucnN0IHwgMTcgKysrKysr
KysrKwogZHJpdmVycy9uZXQvdHVuLmMgICAgICAgICAgICAgICAgICAgfCA0OSArKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLQogaW5jbHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oICAg
ICAgICAgfCAgMSArCiB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvaWZfdHVuLmggICB8ICAx
ICsKIDQgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3R1bnRhcC5yc3QgYi9E
b2N1bWVudGF0aW9uL25ldHdvcmtpbmcvdHVudGFwLnJzdAppbmRleCA0ZDcwODdmNzI3YmUu
LjU5OTI2NDgyNWRkMiAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3R1
bnRhcC5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3R1bnRhcC5yc3QKQEAg
LTIwNiw2ICsyMDYsMjMgQEAgZW5hYmxlIGlzIHRydWUgd2UgZW5hYmxlIGl0LCBvdGhlcndp
c2Ugd2UgZGlzYWJsZSBpdDo6CiAgICAgICByZXR1cm4gaW9jdGwoZmQsIFRVTlNFVFFVRVVF
LCAodm9pZCAqKSZpZnIpOwogICB9CiAKKzMuNCBxZGlzYyBiYWNrcHJlc3N1cmUKKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KKworU3RhcnRpbmcgd2l0aCBMaW51eCA3LjIsIElGRl9CQUNL
UFJFU1NVUkUgY2FuIGJlIHNldCB0byBlbmFibGUgcWRpc2MKK2JhY2twcmVzc3VyZS4gV2l0
aG91dCBpdCwgVFggZHJvcHMgb2NjdXIgd2hlbiB0aGUgaW50ZXJuYWwgcmluZyBidWZmZXIg
aXMKK2Z1bGwuIFdpdGggaXQsIHRoZSBrZXJuZWwgc3RvcHMgdGhlIFRYIHF1ZXVlIGluc3Rl
YWQsIGxldHRpbmcgdGhlIHFkaXNjCitob2xkIHBhY2tldHMuIERyb3BzIG9ubHkgb2NjdXIg
YXMgYSByYXJlIHJhY2UuIFRoaXMgY2FuIGJlbmVmaXQgcHJvdG9jb2xzCitsaWtlIFRDUCB0
aGF0IHJlYWN0IHRvIGRyb3BzLiBCYWNrcHJlc3N1cmUgcmVxdWlyZXMgYSBxZGlzYyB0byBi
ZQorYXR0YWNoZWQgYW5kIGhhcyBubyBlZmZlY3Qgd2l0aCBub3F1ZXVlLgorCitUaGUgVFVO
L1RBUCByaW5nIGJ1ZmZlciBzaXplIGNhbiBiZSByZWR1Y2VkIGFsb25nc2lkZSB0aGlzIGZs
YWcgdG8KK2Z1cnRoZXIgc2hpZnQgYnVmZmVyaW5nIGludG8gdGhlIHFkaXNjIGFuZCByZWR1
Y2UgYnVmZmVyYmxvYXQsIGJ1dCBjb21lcworYXQgcG9zc2libGUgcGVyZm9ybWFuY2UgY29z
dC4KKworV2hlbiBydW5uaW5nIG11bHRpcGxlIG5ldHdvcmsgc3RyZWFtcyBpbiBwYXJhbGxl
bCwgdGhlIGZsYWcgbWF5IHJlZHVjZQorcGVyZm9ybWFuY2UgZHVlIHRvIHRoZSBleHRyYSBv
dmVyaGVhZCBvZiB0aGUgYmFja3ByZXNzdXJlIG1lY2hhbmlzbS4KKwogVW5pdmVyc2FsIFRV
Ti9UQVAgZGV2aWNlIGRyaXZlciBGcmVxdWVudGx5IEFza2VkIFF1ZXN0aW9uCiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIApk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdHVuLmMgYi9kcml2ZXJzL25ldC90dW4uYwppbmRl
eCBmZmJlNmYxM2ZiMWYuLjYyZTVlYWI0ZTM0NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQv
dHVuLmMKKysrIGIvZHJpdmVycy9uZXQvdHVuLmMKQEAgLTk4LDcgKzk4LDggQEAgc3RhdGlj
IHZvaWQgdHVuX2RlZmF1bHRfbGlua19rc2V0dGluZ3Moc3RydWN0IG5ldF9kZXZpY2UgKmRl
diwKICNkZWZpbmUgVFVOX0ZBU1lOQwlJRkZfQVRUQUNIX1FVRVVFCiAKICNkZWZpbmUgVFVO
X0ZFQVRVUkVTIChJRkZfTk9fUEkgfCBJRkZfT05FX1FVRVVFIHwgSUZGX1ZORVRfSERSIHwg
XAotCQkgICAgICBJRkZfTVVMVElfUVVFVUUgfCBJRkZfTkFQSSB8IElGRl9OQVBJX0ZSQUdT
KQorCQkgICAgICBJRkZfTVVMVElfUVVFVUUgfCBJRkZfTkFQSSB8IElGRl9OQVBJX0ZSQUdT
IHwgXAorCQkgICAgICBJRkZfQkFDS1BSRVNTVVJFKQogCiAjZGVmaW5lIEdPT0RDT1BZX0xF
TiAxMjgKIApAQCAtNjk0LDYgKzY5NSwyMCBAQCBzdGF0aWMgdm9pZCB0dW5fZGV0YWNoX2Fs
bChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogCQltb2R1bGVfcHV0KFRISVNfTU9EVUxFKTsK
IH0KIAorc3RhdGljIHZvaWQgdHVuX2ZvcmNlX3dha2VfcXVldWUoc3RydWN0IHR1bl9zdHJ1
Y3QgKnR1biwKKwkJCQkgc3RydWN0IHR1bl9maWxlICp0ZmlsZSkKK3sKKwkvKiBFbnN1cmUg
dGhhdCB0aGUgcHJvZHVjZXIgY2FuIG5vdCBzdG9wIHRoZQorCSAqIHF1ZXVlIGNvbmN1cnJl
bnRseSBieSB0YWtpbmcgbG9ja3MuCisJICovCisJc3Bpbl9sb2NrX2JoKCZ0ZmlsZS0+dHhf
cmluZy5jb25zdW1lcl9sb2NrKTsKKwlzcGluX2xvY2soJnRmaWxlLT50eF9yaW5nLnByb2R1
Y2VyX2xvY2spOworCW5ldGlmX3dha2Vfc3VicXVldWUodHVuLT5kZXYsIHRmaWxlLT5xdWV1
ZV9pbmRleCk7CisJdGZpbGUtPmNvbnNfY250ID0gMDsKKwlzcGluX3VubG9jaygmdGZpbGUt
PnR4X3JpbmcucHJvZHVjZXJfbG9jayk7CisJc3Bpbl91bmxvY2tfYmgoJnRmaWxlLT50eF9y
aW5nLmNvbnN1bWVyX2xvY2spOworfQorCiBzdGF0aWMgaW50IHR1bl9hdHRhY2goc3RydWN0
IHR1bl9zdHJ1Y3QgKnR1biwgc3RydWN0IGZpbGUgKmZpbGUsCiAJCSAgICAgIGJvb2wgc2tp
cF9maWx0ZXIsIGJvb2wgbmFwaSwgYm9vbCBuYXBpX2ZyYWdzLAogCQkgICAgICBib29sIHB1
Ymxpc2hfdHVuKQpAQCAtNzM3LDExICs3NTIsOSBAQCBzdGF0aWMgaW50IHR1bl9hdHRhY2go
c3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwgc3RydWN0IGZpbGUgKmZpbGUsCiAJCWdvdG8gb3V0
OwogCX0KIAotCXNwaW5fbG9jaygmdGZpbGUtPnR4X3JpbmcuY29uc3VtZXJfbG9jayk7Ci0J
dGZpbGUtPmNvbnNfY250ID0gMDsKLQlzcGluX3VubG9jaygmdGZpbGUtPnR4X3JpbmcuY29u
c3VtZXJfbG9jayk7CiAJdGZpbGUtPnF1ZXVlX2luZGV4ID0gdHVuLT5udW1xdWV1ZXM7CiAJ
dGZpbGUtPnNvY2tldC5zay0+c2tfc2h1dGRvd24gJj0gflJDVl9TSFVURE9XTjsKKwl0dW5f
Zm9yY2Vfd2FrZV9xdWV1ZSh0dW4sIHRmaWxlKTsKIAogCWlmICh0ZmlsZS0+ZGV0YWNoZWQp
IHsKIAkJLyogUmUtYXR0YWNoIGRldGFjaGVkIHRmaWxlLCB1cGRhdGluZyBYRFAgcXVldWVf
aW5kZXggKi8KQEAgLTEwNzcsNyArMTA5MCw4IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCB0dW5f
bmV0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikK
IAogCXNwaW5fbG9jaygmdGZpbGUtPnR4X3JpbmcucHJvZHVjZXJfbG9jayk7CiAJcmV0ID0g
X19wdHJfcmluZ19wcm9kdWNlKCZ0ZmlsZS0+dHhfcmluZywgc2tiKTsKLQlpZiAoIXFkaXNj
X3R4cV9oYXNfbm9fcXVldWUocXVldWUpICYmCisJaWYgKCh0dW4tPmZsYWdzICYgSUZGX0JB
Q0tQUkVTU1VSRSkgJiYKKwkgICAgIXFkaXNjX3R4cV9oYXNfbm9fcXVldWUocXVldWUpICYm
CiAJICAgIF9fcHRyX3JpbmdfY2hlY2tfcHJvZHVjZSgmdGZpbGUtPnR4X3JpbmcpID09IC1F
Tk9TUEMpIHsKIAkJbmV0aWZfdHhfc3RvcF9xdWV1ZShxdWV1ZSk7CiAJCS8qIFBhaXJlZCB3
aXRoIHNtcF9tYigpIGluIF9fdHVuX3dha2VfcXVldWUoKSAqLwpAQCAtMjE1MSw4ICsyMTY1
LDEyIEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9wdXRfdXNlcihzdHJ1Y3QgdHVuX3N0cnVjdCAq
dHVuLAogc3RhdGljIHZvaWQgX190dW5fd2FrZV9xdWV1ZShzdHJ1Y3QgdHVuX3N0cnVjdCAq
dHVuLAogCQkJICAgICBzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLCBpbnQgY29uc3VtZWQpCiB7
Ci0Jc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh0dW4t
PmRldiwKLQkJCQkJCXRmaWxlLT5xdWV1ZV9pbmRleCk7CisJc3RydWN0IG5ldGRldl9xdWV1
ZSAqdHhxOworCisJaWYgKCEodHVuLT5mbGFncyAmIElGRl9CQUNLUFJFU1NVUkUpKQorCQly
ZXR1cm47CisKKwl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHR1bi0+ZGV2LCB0ZmlsZS0+
cXVldWVfaW5kZXgpOwogCiAJLyogUGFpcmVkIHdpdGggc21wX21iX19hZnRlcl9hdG9taWMo
KSBpbiB0dW5fbmV0X3htaXQoKSAqLwogCXNtcF9tYigpOwpAQCAtMjc2NCw3ICsyNzgyLDcg
QEAgc3RhdGljIGludCB0dW5fc2V0X2lmZihzdHJ1Y3QgbmV0ICpuZXQsIHN0cnVjdCBmaWxl
ICpmaWxlLCBzdHJ1Y3QgaWZyZXEgKmlmcikKIAlzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuOwog
CXN0cnVjdCB0dW5fZmlsZSAqdGZpbGUgPSBmaWxlLT5wcml2YXRlX2RhdGE7CiAJc3RydWN0
IG5ldF9kZXZpY2UgKmRldjsKLQlpbnQgZXJyOworCWludCBlcnIsIGk7CiAKIAlpZiAodGZp
bGUtPmRldGFjaGVkKQogCQlyZXR1cm4gLUVJTlZBTDsKQEAgLTI4OTQsNyArMjkxMiw4IEBA
IHN0YXRpYyBpbnQgdHVuX3NldF9pZmYoc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3QgZmlsZSAq
ZmlsZSwgc3RydWN0IGlmcmVxICppZnIpCiAJICogeG9mZiBzdGF0ZS4KIAkgKi8KIAlpZiAo
bmV0aWZfcnVubmluZyh0dW4tPmRldikpCi0JCW5ldGlmX3R4X3dha2VfYWxsX3F1ZXVlcyh0
dW4tPmRldik7CisJCWZvciAoaSA9IDA7IGkgPCB0dW4tPm51bXF1ZXVlczsgaSsrKQorCQkJ
dHVuX2ZvcmNlX3dha2VfcXVldWUodHVuLCBydG5sX2RlcmVmZXJlbmNlKHR1bi0+dGZpbGVz
W2ldKSk7CiAKIAlzdHJzY3B5KGlmci0+aWZyX25hbWUsIHR1bi0+ZGV2LT5uYW1lKTsKIAly
ZXR1cm4gMDsKQEAgLTM2OTAsMTUgKzM3MDksOSBAQCBzdGF0aWMgaW50IHR1bl9xdWV1ZV9y
ZXNpemUoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1bikKIAkJCQkJICBkZXYtPnR4X3F1ZXVlX2xl
biwgR0ZQX0tFUk5FTCwKIAkJCQkJICB0dW5fcHRyX2ZyZWUpOwogCi0JaWYgKCFyZXQpIHsK
LQkJZm9yIChpID0gMDsgaSA8IHR1bi0+bnVtcXVldWVzOyBpKyspIHsKLQkJCXRmaWxlID0g
cnRubF9kZXJlZmVyZW5jZSh0dW4tPnRmaWxlc1tpXSk7Ci0JCQlzcGluX2xvY2soJnRmaWxl
LT50eF9yaW5nLmNvbnN1bWVyX2xvY2spOwotCQkJbmV0aWZfd2FrZV9zdWJxdWV1ZSh0dW4t
PmRldiwgdGZpbGUtPnF1ZXVlX2luZGV4KTsKLQkJCXRmaWxlLT5jb25zX2NudCA9IDA7Ci0J
CQlzcGluX3VubG9jaygmdGZpbGUtPnR4X3JpbmcuY29uc3VtZXJfbG9jayk7Ci0JCX0KLQl9
CisJaWYgKCFyZXQpCisJCWZvciAoaSA9IDA7IGkgPCB0dW4tPm51bXF1ZXVlczsgaSsrKQor
CQkJdHVuX2ZvcmNlX3dha2VfcXVldWUodHVuLCBydG5sX2RlcmVmZXJlbmNlKHR1bi0+dGZp
bGVzW2ldKSk7CiAKIAlrZnJlZShyaW5ncyk7CiAJcmV0dXJuIHJldDsKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdWFwaS9saW51eC9pZl90dW4uaCBiL2luY2x1ZGUvdWFwaS9saW51eC9pZl90
dW4uaAppbmRleCA3OWQ1M2M3YTFlYmQuLjczYTc3MTQxMzE1YyAxMDA2NDQKLS0tIGEvaW5j
bHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9pZl90
dW4uaApAQCAtNjksNiArNjksNyBAQAogI2RlZmluZSBJRkZfTkFQSV9GUkFHUwkweDAwMjAK
IC8qIFVzZWQgaW4gVFVOU0VUSUZGIHRvIGJyaW5nIHVwIHR1bi90YXAgd2l0aG91dCBjYXJy
aWVyICovCiAjZGVmaW5lIElGRl9OT19DQVJSSUVSCTB4MDA0MAorI2RlZmluZSBJRkZfQkFD
S1BSRVNTVVJFCTB4MDA4MAogI2RlZmluZSBJRkZfTk9fUEkJMHgxMDAwCiAvKiBUaGlzIGZs
YWcgaGFzIG5vIHJlYWwgZWZmZWN0ICovCiAjZGVmaW5lIElGRl9PTkVfUVVFVUUJMHgyMDAw
CmRpZmYgLS1naXQgYS90b29scy9pbmNsdWRlL3VhcGkvbGludXgvaWZfdHVuLmggYi90b29s
cy9pbmNsdWRlL3VhcGkvbGludXgvaWZfdHVuLmgKaW5kZXggMmVjMDdkZTFkNzNiLi45N2I2
NzBmNWJjMGEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9pZl90dW4u
aAorKysgYi90b29scy9pbmNsdWRlL3VhcGkvbGludXgvaWZfdHVuLmgKQEAgLTY3LDYgKzY3
LDcgQEAKICNkZWZpbmUgSUZGX1RBUAkJMHgwMDAyCiAjZGVmaW5lIElGRl9OQVBJCTB4MDAx
MAogI2RlZmluZSBJRkZfTkFQSV9GUkFHUwkweDAwMjAKKyNkZWZpbmUgSUZGX0JBQ0tQUkVT
U1VSRQkweDAwODAKICNkZWZpbmUgSUZGX05PX1BJCTB4MTAwMAogLyogVGhpcyBmbGFnIGhh
cyBubyByZWFsIGVmZmVjdCAqLwogI2RlZmluZSBJRkZfT05FX1FVRVVFCTB4MjAwMAotLSAK
Mi40My4wCgo=

--------------0EZlX0AtzGB50MshNwbsRMPs--

