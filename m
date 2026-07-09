Return-Path: <netdev+bounces-306171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p3yYAY92T2rKhAIAu9opvQ
	(envelope-from <netdev+bounces-306171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539872F89D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XIt1Fwpq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306171-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306171-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CC183043576
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53D3FC5CE;
	Thu,  9 Jul 2026 10:21:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C330DECB;
	Thu,  9 Jul 2026 10:21:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592496; cv=none; b=Z76wsN+lb9hebK+YFfBfYQi5y/HN0k/PIJEzaF8jFCZ6+X/wcfgNUlzPAKvxGXGDPcNASm6XETLRwcYEfZKzwTT22PRl9rDouaDwnk3o5pISl9bP+KQoDAN8bG1Mu6Dov6rGh2ixuQ2H4fGkJJDc0TJafm15wA35jeYzP8Yv1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592496; c=relaxed/simple;
	bh=0yfdNP6ytHgFtBc2pDX26SjfaDnnkVCAxA4mFZolUA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCwDtRPq2n21czU09zOl43VP/KDpdzgkl3mmGdyknOAsn8TH4bIfx86ix+LlzyTCoWFnLnYJ7C/CtbnbD6l+d9sbrY4y0V2xd4x1fX8NKk/dix1NnQ9Vt8qQoJ2W/PoNKlfzZm58zG2LdVH5m2O/iMCpLlWccRJaREO8QAJ7ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIt1Fwpq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DCD1F00A3A;
	Thu,  9 Jul 2026 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783592495;
	bh=sj/JW3znLZQNwoK1Pq4M7LGw9HpiiuxxsroG/UR4DSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XIt1FwpqyBX9hIDI+S/yt7+4Yopx09kfCDwbxefKNlByV0F8lClNEzC7m3bjIi/8p
	 JfypPkJwzsr1Y6+aAF91TLjEiVX7mrSwxoPVXPoM2GMjWR9m0XGLh1baaH7vhsW96u
	 f23jWJFNVAEGZLnkicLz0370mOaDQsjjKWdMztaffvBOrYQMJefMSa+GzhOyM2lCSq
	 478CzuSuRiPpuai4Y+J0cq3T8V008l6EJ6oRqzkjU4WqYTp47sxHsHpEFTQtL5vIHQ
	 D15aDhXcE18m7Jg+arD0g9L52/4NyzKiNdQqFbiDFzqe2N5kGvwWPJPwsZ6jSvja04
	 7YqQ7A+3DdGag==
Message-ID: <1fb14039-b56d-4757-add9-22b97d3c9f44@kernel.org>
Date: Thu, 9 Jul 2026 12:21:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Content-Language: fr
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
 <f398373e-2cb4-4649-a491-9763df94d98b@kernel.org>
 <ak6jtwbct3C5lZPA@archlinux>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ak6jtwbct3C5lZPA@archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:asantostc@gmail.com,m:leitao@debian.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8539872F89D

Hi Andre,

Thank you for your reply!

On 08/07/2026 22:24, Andre Carvalho wrote:
> Hello Matthieu,
> 
> On Wed, Jul 08, 2026 at 05:50:53PM +0200, Matthieu Baerts wrote:
>>
>>> +function trigger_reactivation() {
>>> +	# Add back low level module
>>> +	modprobe netdevsim
>>> +	# Recreate namespace and two interfaces
>>> +	set_network
>>> +	# Restore MACs
>>> +	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
>>> +		address "${SAVED_DSTMAC}"
>>> +	if [ "${BINDMODE}" == "mac" ]; then
>>> +		ip link set dev "${SRCIF}" down
>>> +		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
>>> +		# Rename device in order to trigger target resume, as initial
>>> +		# when device was recreated it didn't have correct mac address.
>>> +		ip link set dev "${SRCIF}" name "${TARGET}"
>>
>> When I execute the test, the "ifname" bind mode works without issues,
>> but the "mac" one not. From what I see, the socat process doesn't get
>> any UDP packet when expected. I wonder if the problem might not come
>> from here: the interface is disabled before changing the MAC address and
>> renaming the interface, but not re-enabled at the end. Is it normal?
> 
> Yes, the expectation is that the target would be automatically re-enabled by
> netconsole. That is why we don't 'up' the interface here explicitly.

OK, that's what I thought when I looked at the previous commit of this
series, but it was still feeling "strange" :)

> The problem is that the test has an implict dependency on interface mac address
> changing when we recreate them, which is why we have to do this whole down/update/rename
> flow to trigger the reactivation in this case.

OK!

>> If I add 'up' at the end of this last line here, or if I remove the
>> whole if-statement block, the test passes.
> 
> For cases where the mac is persistent (e.g with systemd MACAddressPolicy=persistent),
> the actual re-enablement should "just work", which I suspect is why it works when
> you remove the whole if-statement block.

I see, I just noticed the discussion on lore about that on the previous
patch and on the v10. I now understand why MACAddressPolicy should be
set to 'none', and I can do that on my side.

> I think to make the test more robust to such scenarios, we should skip the
> if-statement block when we detect that the interface came back with the same mac
> as previously. Something like this:
> 
> if [ "${BINDMODE}" == "mac" ]; then
> 	CURR_SRCMAC=$(mac_get "${SRCIF}")
> 	if [ "${CURR_SRCMAC}" == "${SAVED_SRCMAC}" ]; then
> 		# Interface came back with same mac, no need to restore
> 		return
> 	fi
> 	ip link set dev "${SRCIF}" down
> 	ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
> 	# Rename device in order to trigger target resume, as initial
> 	# when device was recreated it didn't have correct mac address.
> 	ip link set dev "${SRCIF}" name "${TARGET}"
> fi
> 
> Could you confirm if this fixes the selftest in your environment?

Yes, it fixes the selftest (without MACAddressPolicy=none), thank you!

And maybe this could be used to avoid the 'return':

  if [ "${BINDMODE}" == "mac" ] &&
     [ "$(mac_get "${SRCIF}")" != "${SAVED_SRCMAC}" ]; then

A detail, up to you :)

I think it would be interesting to have such check. If the MAC policy
can cause issues here, it might be good to also add a warning, or to
continue to fail, but with an explicit error message to look at this.

>>> +	echo "Running with bind mode: ${BINDMODE}" >&2
>>> +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
>>> +	echo "6 5" > /proc/sys/kernel/printk
>>
>> Can we remove this? Without that, it is hard to understand what went
>> wrong in case of issues.
> 
> Can you elaborate? This is typical for netconsole tests and I think required to
> ensure the write will show up on netconsole. I'm not opposed to changing it if
> there is a reason, but we probably want to make it consistent with other tests too.

I understand, and I asked because I was not sure if this was needed for
some tests. If it doesn't break some tests, I think it would be good not
to change the loglevel, because on my side, all I had was:

  # Running with bind mode: mac
  not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1

Even with the suggested modification to have "FAIL: File was not
generated.", that's not helpful enough to understand where the problem
came from. Having the extra info in the console was really helpful, but
it was not obvious I could do that.

There could be a message saying "comment this to have more debug", but
that means a CI will not get such useful debug info in case of error. So
I think this behaviour should be changed. Or at least printing debug
info only in case of errors.

>>> +	# Send the message
>>> +	echo "${MSG}: ${TARGET}" > /dev/kmsg
>>> +	# Wait until socat saves the file to disk
>>> +	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
>>
>> In my case, the script was stopping here, without any message. I can
>> send a patch adding "|| true" to go to the next instruction, and display
>> "FAIL: File was not generated.".
>>
> 
> This seems reasonable to me.

Good! I will send this patch.

Just to avoid a deadlock, do you plan to send one to handle the MAC
address that has not been modified (and eventually one to get more debug
messages in case of errors)?

Cheers,
Matt

