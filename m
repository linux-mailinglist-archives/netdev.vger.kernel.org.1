Return-Path: <netdev+bounces-290225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ETKBbZxDmq8+gUAu9opvQ
	(envelope-from <netdev+bounces-290225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:45:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1A59E2F7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F40A63013A61
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB33783AE;
	Thu, 21 May 2026 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="OWuMXNpS"
X-Original-To: netdev@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371F377EDF
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331348; cv=none; b=mhsM7oXwkSbcxr9kep+7PnVLc4XEV6V7vU5hKPaSA2zcVZc1k//tuVgcDzWDkMspeQ4b/90FK7NQ5G358blQFctyYVl5GfgD1bqy6T7H51aL2EyUEDg8gIYV/8FZgr7D4EGJu+mR5WX5/HSVHqR70jiM23i7KGIiPd+xgoR8WAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331348; c=relaxed/simple;
	bh=x5T+ME9TY2Jx5EAJTi8qwbQSFVWQa6nlIBCK/SKgh/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP3ASokCHwwdzIDYUrZfEAfrg2HJwtqddOCc4Bm1h42cwV4Ewnr3ZFvHy96QIz1wZqxupIXBFe7Bm/oWyUAVqjXh4EGqdhEwq2hyfr/sO4fvnBp5yklfBaaB8kCEAmkfwvEFE8s+7lHcS4QXt4n5pZJxVu5iV2jV3bE2rVFCoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=OWuMXNpS; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=2875; t=1779331310;
	x=1779936110; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Autocrypt:Organization:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20from=20[IPV6=3A2603=3A7
	002=3A100=3A8400=3Aac07=3Aac1c=3A5feb=3Ac3e6]=20by=20auristor.co
	m=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=
	20PRO=20v26.0.2)=20=0D=0A=09with=20ESMTPSA=20id=20md500100529533
	3.msg=3B=20Wed,=2020=20May=202026=2022=3A41=3A48=20-0400|Message
	-ID:=20<c6b61797-b050-48ad-8ba1-8f19e338bdbc@auristor.com>|Date:
	=20Wed,=2020=20May=202026=2022=3A42=3A20=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PAT
	CH=20net]=20rxrpc=3A=20Fix=20the=20ACK=20parser=20to=20extract=2
	0the=20SACK=20table=0D=0A=20for=20parsing|To:=20Jakub=20Kicinski
	=20<kuba@kernel.org>,=20dhowells@redhat.com|Cc:=20netdev@vger.ke
	rnel.org,=20michael.bommarito@gmail.com,=0D=0A=20marc.dionne@aur
	istor.com,=20edumazet@google.com,=20davem@davemloft.net,=0D=0A=2
	0pabeni@redhat.com,=20horms@kernel.org,=20linux-afs@lists.infrad
	ead.org,=0D=0A=20stable@kernel.org|References:=20<488970.1779144
	259@warthog.procyon.org.uk>=0D=0A=20<20260521021910.687776-2-kub
	a@kernel.org>|Content-Language:=20en-US|From:=20Jeffrey=20E=20Al
	tman=20<jaltman@auristor.com>|Autocrypt:=20addr=3Djaltman@aurist
	or.com=3B=20keydata=3D=0D=0A=20xsFNBEwLlO0BEACu6yWFkd1+qwsGg8Zzg
	slSkcAKhSegWt5j86DpaRL0W8fxg6YjxwEPvwoH=0D=0A=20BGa/rpSdBd1gkmze
	YxD3hVZdj75r6nVS9f/mxNQzW+o1sW4vaeSxKgZSQz5RqHmwPDcqQP66=0D=0A=2
	0+ZSnjV+G88MKwZ9DIzA9AwpJhNAAlAlj3OvsQVsxd1ipc6C4/U3qjHL7Ih22UbP
	BM71ltIZx=0D=0A=20kqcrAlXPnUTeraJXtfzYbq4mJFJ9JC6/o1NRSjsBvRD+AD
	xlG50+KccZN4SS5xxdGuh1tA9U=0D=0A=20TydYBQB3YtJbq7CYau2kIYt/3HnyL
	YGo1s6Ti6cuAJJ/40iIE1xkqhvMiIz/Q+1ztmksJbLQ=0D=0A=20aCtW8kF42nF8
	MpPdIPTSPr2uGvpRtCjRbh4lgMXgyNUx1wpCEY0X11xce++H8HySmFwryE2y=0D=
	0A=20kkxUQeMUjaaXZDHYUSyQz7riChFiZ9ax9dmX0wUY/A05v0qcualglpk4wJ2
	kcsGKUEGkLvnV=0D=0A=20wwvya8zifPwKOw5JlGPvzX8t2m7jB2GXKzvVAsImqO
	qnDBTKUXWQQZCW9Rqt7acdE8bQ2vqr=0D=0A=20vP+3Ykf4SrPwcuNCDt6QSgjVb
	hc3hA3hCtE1iW/HhuBAzKiuzJ9era+q9QjTtLPIkQDHRpcC=0D=0A=20MMWvK0Y1
	uQ34Ql1BfKRA4gc8A7CuVUY6+Ga7PuJWd+FSglvmKQARAQABzTZKZWZmcmV5IEFs
	=0D=0A=20dG1hbiAoQXVyaVN0b3IsIEluYy4pIDxqYWx0bWFuQGF1cmlzdG9yLmN
	vbT7CwXkEEwECACMF=0D=0A=20AlY2YwgCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQ
	IeAQIXgAAKCRD3enNVkraaBDdzD/0XQUDW=0D=0A=20UWXrpapHdvZaHzPHc3xob
	Ri4PABWfLW1jfMK5Xy4DP/x7x3I2qAqTD6vv/OPFMx8gG6+Xeod=0D=0A=20Mj5v
	E7+7ZRd+J76J4DJH2qoaXX8qnUEABUJHZYDhw2/Ij5AQ6ZsuSwXuURGEMi0vu1ih
	BbP6=0D=0A=203bt4LRIa+F60ebDvCl9po+UB7TrjQCs+YV1r1YeCSv9hEHBly/W
	0u1OrnNCMWRcq7dmTCbZ0=0D=0A=20R5w6VJ/+QEio+T6paGGMjJmrNw2qUeuK+S
	xOOxOWS8lgdqzjcK3NsfiERrVbOWM83ZVy0/GN=0D=0A=20vpusjhI/3Q8lbV/p+
	IsJk/v1grkRzgU0frES2ANEPTpC4j2ggPOSMpsz3BZ8wIOg17rIWnK+=0D=0A=20
	gNLQe+XN7kvDwGu0jYhTIZO10jcVsRSrAJGtgBNrYxOjEUhpnaSJDVcjapRvRPCQ
	umA13Zkl=0D=0A=20nm4AYjp7L2oOIeOGcKRZwbrGDakksa5iaSIoywpwECWh2l9
	V0W3SeynBgPtR4qpt4N8yKCcw=0D=0A=20suLCAKfBv9RcL641XZi/Fp9btSuTPU
	m5Lw3SIGr5U+SyezmhzlwsObIF9W624aorriWoXNf3=0D=0A=20GgH9ZH0Hkc6aS
	99pIZhh5USWRO/pS+lv5eNkEdf9LUBGX9b6ZMan0fpoEayqUejtZw3O2rgs=0D=0
	A=20zA+pTSA+/HobvtL6L3XtlPJ1NXlkgM7BTQRMC5TtARAA88hJdpgcg2RU/uAW
	fAL46XZHA59c=0D=0A=20VpPNNly1tPWCSbG6+ONH6nOG/NarmNVxX6Mb9YRkEU6
	wmrZS85inz3otdyz/zlyNSWma8qGN=0D=0A=20UlMbiwFQqfXWVBAPGoRC0a0aJr
	d4IayLuvv1UqEwx7Otp7y5RNHtRv35/kho0Z+UheYVdGm2=0D=0A=20I06xIc+aN
	KW2LO7R5BNtjpADPIG+NSdsVIeamhAWPvLrwbf6mUb//eA9pF0w0QixLVrH/cCo=
	0D=0A=20z+S27gCGJvY6zF22NgdhnkIqNz8E/LKt6S36ZI9Mw/ixpQTozqRmdNzV
	QNgTHUZClbJj4iq1=0D=0A=20EPHB7XqpxOv+awrxSxq2jt8GFD0rU+sAuzW+F7c
	BoIw434/IrxKYwcPHpHLEVQ1tLP7d3ZpZ=0D=0A=20R30p3oqoliGiLsWvHHxyXj
	uMBF4XJ6MRXmD65/qOhuo2DKduHMNlmxzgSzvWgXZeNJq+OcS8=0D=0A=20jQZDt
	2Na2pMKjWytau7xQu2ndm0FwS48ngMrDYRQMxzL1NfnBnT9BCwjiU+/6NBSwcNKI
	qye=0D=0A=20a9IpTwsVfkF4/iui7xD9+LtzqeUkBAe7q5jEJmJMZhAfh7usZGT8
	TGxXegCaF4Jwz2nxS4Fv=0D=0A=207VRza/yUAOJlc0daR11TPeiUNCQWY7PpL1A
	XO9vaSyjFuOzTnU8vzXvI9fGoxIxKGRQpKMU8=0D=0A=20PROIFw0AEQEAAcLBXw
	QYAQIACQUCTAuU7QIbDAAKCRD3enNVkraaBIxXD/4xlaBwW2TLFfMv=0D=0A=20l
	cY/2XDSm6NO4JaJG2Nzp35xaaBVwMVzWvI+GgTgKNSFot9f4jiLBNQdnq3UKoETh
	R2ORKVL=0D=0A=200ZJS1QYR7yyrOo0MteDSy8ofU1FJ6xu4ND3ekOjP20BTrihD
	pqUdahir2uaRfMkwM+0imOlc=0D=0A=20utGMhJNF/LAjrhoDp9SeDMYBXZ1wfrb
	rEo/EEu0PbkGyzqPyEPqwN1iSJkcAnjuIA0rTf1jQ=0D=0A=20tJAaDov7yHsSRw
	UM+qTGsjOGQAN3wtYwjPpw7hI01sE+x0uq0pVeo4qeWTZ2TE4Vtp8FKXFA=0D=0A
	=20kqnP878q+kNk9Ve+DRs8UlRfa9Lgf5ETjXOTVGaT/UGxi9B4oo8k0lzvM/A1t
	xexL/lLw8AU=0D=0A=20LhUeGtyS6D2X9vFi6azna+o918R9BV86uXPiDOf1nMwq
	KchNCxmgH9vd0aQm8TKCrWAW4kU1=0D=0A=20Ig6aMNuZiWloVZfKrmWizbgeGKE
	9rhNPNqxkqBaA4lrJ8L6bdKbhAOe3NQjO2vUAXB53Jphl=0D=0A=20F74GwEsh+8
	5i9/yIbvwJVcsFYhdZz7fCAUOcnFkGnyrwIgkizQ3xXShPW8mqkgUk4kYMnucC=0
	D=0A=204kG/E7pI/4lke5X5X9vroXRHB7tkpAgT46SqSM/XTwCaseXG9orDgz3du
	RTUp6K0++S/qsqT=0D=0A=20akGVmjD5917A1HqWfMmiKA=3D=3D|Organizatio
	n:=20AuriStor,=20Inc.|Disposition-Notification-To:=20Jeffrey=20E
	=20Altman=20<jaltman@auristor.com>|In-Reply-To:=20<2026052102191
	0.687776-2-kuba@kernel.org>|Content-Type:=20text/plain=3B=20char
	set=3DUTF-8=3B=20format=3Dflowed|Content-Transfer-Encoding:=207b
	it; bh=TnPTKbrZ4mb0wyA5sNGsf29pVVrp95nrvMMIIJRTLIo=; b=OWuMXNpSW
	PYBjQejS99zjsIUq5/+Y/y2TBa/eJ0mkiZipeyp2vQ1IF1RSgQ7L9DW+mJb5lR4j
	pqAXVvp2Cnf8HrZMpgfK4SxH7PUynAdFA+VeArfSpLCEV096eoiGBl2tmt+HB/JK
	CH1n3h8nOyfXBSUX1WYN0XBGnbixxZNwtI=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Wed, 20 May 2026 22:41:50 -0400
Received: from [IPV6:2603:7002:100:8400:ac07:ac1c:5feb:c3e6] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2) 
	with ESMTPSA id md5001005295333.msg; Wed, 20 May 2026 22:41:48 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Wed, 20 May 2026 22:41:48 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:ac07:ac1c:5feb:c3e6
X-MDHelo: [IPV6:2603:7002:100:8400:ac07:ac1c:5feb:c3e6]
X-MDArrival-Date: Wed, 20 May 2026 22:41:48 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1601107ed7=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Message-ID: <c6b61797-b050-48ad-8ba1-8f19e338bdbc@auristor.com>
Date: Wed, 20 May 2026 22:42:20 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] rxrpc: Fix the ACK parser to extract the SACK table
 for parsing
To: Jakub Kicinski <kuba@kernel.org>, dhowells@redhat.com
Cc: netdev@vger.kernel.org, michael.bommarito@gmail.com,
 marc.dionne@auristor.com, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, linux-afs@lists.infradead.org,
 stable@kernel.org
References: <488970.1779144259@warthog.procyon.org.uk>
 <20260521021910.687776-2-kuba@kernel.org>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Autocrypt: addr=jaltman@auristor.com; keydata=
 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
 akGVmjD5917A1HqWfMmiKA==
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20260521021910.687776-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com
X-Spamd-Result: default: False [1.34 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290225-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_X_AS(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,google.com,davemloft.net,redhat.com,kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[auristor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,auristor.com:mid,auristor.com:dkim]
X-Rspamd-Queue-Id: 1BF1A59E2F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/20/2026 10:19 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> rxrpc: Fix the ACK parser to extract the SACK table for parsing
>
> This commit fixes modification of the received skbuff and incorrect access
> of the buffer in fragmented UDP packets during SACK table parsing. It copies
> out the contents of the SACK table into a flat stack buffer instead of
> relying on skb_condense().
>
> Link: https://lore.kernel.org/r/20260513180907.2061972-1-michael.bommarito@gmail.com
>
>> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
>> index 24aceb183c2c3..0c15ebf19eae9 100644
>> --- a/net/rxrpc/input.c
>> +++ b/net/rxrpc/input.c
>> @@ -963,21 +963,34 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
>>   	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
>>   	struct rxrpc_txqueue *tq = call->tx_queue;
>>   	unsigned long extracted = ~0UL;
>> -	unsigned int nr = 0;
>> +	unsigned int nr = 0, nsack;
>>   	rxrpc_seq_t seq = call->acks_hard_ack + 1;
>>   	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
>> -	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
>> +	u8 sack[256] __aligned(sizeof(unsigned long));
>> +	u8 *acks = sack;
> [ ... ]
>
>>   	for (unsigned int i = 0; i < sp->ack.nr_acks; i++) {
>>   		/* Decant ACKs until we hit a txqueue boundary. */
>>   		shiftr_adv_rotr(acks, extracted);
>>   		if (i == 256) {
>> -			acks -= i;
>> +			acks = sack;
>>   			i = 0;
>>   		}
> Can this lead to an out-of-bounds access and an infinite loop if
> sp->ack.nr_acks is greater than 256?
>
> If a received packet has sp->ack.nr_acks > 256, on the 257th iteration
> (where i == 256), the shiftr_adv_rotr(acks, extracted) macro will execute
> before the wrap-around check resets the acks pointer.
>
> Since the acks pointer has been incremented 256 times by previous iterations,
> wouldn't it point to sack + 256 at this point, causing an out-of-bounds read
> and write on the sack[] array?
>
> Furthermore, resetting i to 0 inside the loop means the loop's i++
> operation will set it to 1 for the next iteration. Because the counter is
> reset without breaking out of the loop, will this ever terminate if
> sp->ack.nr_acks > 256, or will it cycle infinitely and eventually cause a NULL
> pointer dereference when tq->next runs out of transmit queues?

Due to the lack of support for Extended SACK within the current rxrpc 
implementation the value of ack.nr_acks cannot exceed 255. The value of 
ack.nr_acks is assigned in rxrpc_extract_header() from the struct 
rxrpc_ackpacket.nAcks field which is an unsigned 8-bit value whose 
maximum is 255.

When support for Extended SACK tables is added the processing in 
rxrpc_input_soft_acks() must be updated.

Jeffrey Altman




