Return-Path: <netdev+bounces-276894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KryOkJo12myNggAu9opvQ
	(envelope-from <netdev+bounces-276894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:50:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC033C7F5D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36EE302E320
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA834DCF3;
	Thu,  9 Apr 2026 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="LP69PJVB"
X-Original-To: netdev@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B619E839;
	Thu,  9 Apr 2026 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724456; cv=none; b=WEjpF0ETA4Ev7DoRMBh9V8DGrkBEDkETr1T8reSgx84SGuh4oxAeoeUmL/ARzsPnQivT3g2P5wjQGZtDa9mos2DVs8O54DMxhl9P+App3+FXKQy5F9elITm2PJV2Oq/4mOYqcDEXew28cd+eQauec3rCPemnY2HTUmSel0pDT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724456; c=relaxed/simple;
	bh=uWfpcH/Aq8NLPtNxzg+ifTHzZUkluCT0p2AKfAgtp1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rK3s9wgiK6NwEyOhfoag/kOdhmeqsovVqizVzHyfxd3cerQlPBGi7JGE9LwjMIVqtLscGYJunR/IyukbLNTm7ptGtHJOmcnV6kpLMTzaMdjohAX2O3it9RpyPCiRW672OO9onilAbdujle9QZgU5tiHUffsd3/QI2qbwwqKS2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=LP69PJVB; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=fw4Fi2J7rWpChzRbVh6OVQ83bjYAyOleBcAdAZEagLQ=; b=LP69PJVBp2AAvvJhb+h7sgwMOA
	jk5BLH+tq9NMURwyv0gBh5ZXq9bXgfx2E1pJwSAPFsAzXcrBZ2dvOQfwJyjb8gnSLKm116gEYAUz4
	ggk0+72oTcH+RLJPWW3Lg0hd+2pryKTMClpXT7WqnpDUHpgMUbtLhdIQgbK55u7y66HHiKDCdknvE
	aif4QA+dufYcnvZ/BYhJ3WhPTff9SJt7xNHt2IEq+YgZFtrQs6dXrV2/YtvKaYR4XOFAZCGy1SNE3
	UIQ1KtimHodn9jQrwH9q/Xdp5IClUlit/vsClSmNzlEtmXZfNnVMOe0mIAPKAgujXA2ZKCLj8yore
	ih5GrRpBzwvlVLcLhCIVlNU7Rzzb99VxuAoNC8GBvHSONdaVcn0983O0sHxFZNChzlaW/6gzhnkL9
	/4SbDog1AHcsZbRhji/O4xG7wStB0Z7rEjQOkBhSNKCwgxiH5PgG1kTcNa8k5g9JOv1vSukA80UMl
	itZM/m4V6TIf6P6qSK+pX1CR;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wAl2v-000000087mr-3yWE;
	Thu, 09 Apr 2026 08:47:30 +0000
Message-ID: <fb21f224-310e-4744-8216-62fd93f36955@samba.org>
Date: Thu, 9 Apr 2026 10:47:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] uaccess: add copy_struct_{from,to}_bounce_buffer()
 helpers
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Michal Luczaj <mhal@rbox.co>,
 David Wei <dw@davidwei.uk>, Luiz Augusto von Dentz
 <luiz.von.dentz@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Xin Long <lucien.xin@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <cover.1775576651.git.metze@samba.org>
 <f29570914590c50b9b6f451eb3a38d0fe1d954df.1775576651.git.metze@samba.org>
 <20260407192540.321f3879@pumpkin>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260407192540.321f3879@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276894-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arista.com,kernel.org,davemloft.net,rbox.co,davidwei.uk,intel.com,holtmann.org,google.com,redhat.com,cyphar.com,chromium.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FC033C7F5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

> On Tue,  7 Apr 2026 18:03:15 +0200
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>> These are similar to copy_struct_{from,to}_user() but operate
>> on kernel buffers instead of user buffers.
>>
>> They can be used when there is a temporary bounce buffer used,
>> e.g. in msg_control or similar places.
>>
>> It allows us to have the same logic to handle old vs. current
>> and current vs. new structures in the same compatible way.
>>
>> copy_struct_from_sockptr() will also be able to
>> use copy_struct_from_bounce_buffer() for the kernel
>> case as follow us patch.
>>
>> I'll use this in my IPPROTO_SMBDIRECT work,
>> but maybe it will also be useful for others...
>> IPPROTO_QUIC will likely also use it.
>>
>> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
>> Cc: Dmitry Safonov <dima@arista.com>
>> Cc: Francesco Ruggeri <fruggeri@arista.com>
>> Cc: Salam Noureddine <noureddine@arista.com>
>> Cc: David Ahern <dsahern@kernel.org>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Michal Luczaj <mhal@rbox.co>
>> Cc: David Wei <dw@davidwei.uk>
>> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Xin Long <lucien.xin@gmail.com>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Willem de Bruijn <willemb@google.com>
>> Cc: Neal Cardwell <ncardwell@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> CC: Kees Cook <keescook@chromium.org>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-bluetooth@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>> ---
>>   include/linux/uaccess.h | 63 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index 1234b5fa4761..a6cd4f48bb99 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -513,6 +513,69 @@ copy_struct_to_user(void __user *dst, size_t usize, const void *src,
>>   	return 0;
>>   }
>>   
>> +static __always_inline void
>> +__copy_struct_generic_bounce_buffer(void *dst, size_t dstsize,
>> +				    const void *src, size_t srcsize,
>> +				    bool *ignored_trailing)
>> +{
>> +	size_t size = min(dstsize, srcsize);
>> +	size_t rest = max(dstsize, srcsize) - size;
>> +
>> +	/* Deal with trailing bytes. */
>> +	if (dstsize > srcsize)
>> +		memset(dst + size, 0, rest);
>> +	if (ignored_trailing)
>> +		*ignored_trailing = dstsize < srcsize &&
>> +			memchr_inv(src + size, 0, rest) != NULL;
>> +	/* Copy the interoperable parts of the struct. */
>> +	memcpy(dst, src, size);
>> +}
> 
> Return 'ignored_trailing' rather than pass by reference.

I also thought about that but it makes
the copy_struct_to_ case more complex.

I'm not sure but my guess would be that
the compiler would have the chance to skip the
ignore_trailing logic if (as all current callers do)
NULL is passed.

> And this is probably too big to inline.

In the next patch this replace open coded logic in
copy_struct_from_sockptr. So as all of copy_struct_*
consists of inline functions I thought it would be good to
keep it that way.

So unless there a real good reason to change it
I'd like to keep it as is.

Thanks!
metze

