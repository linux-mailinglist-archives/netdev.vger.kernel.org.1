Return-Path: <netdev+bounces-307446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dD1wOYoqVmoZ0gAAu9opvQ
	(envelope-from <netdev+bounces-307446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:24:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC0B7547CF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:24:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307446-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307446-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82702306E162
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9B3C1992;
	Tue, 14 Jul 2026 12:17:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9B3C1966
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:17:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031438; cv=none; b=Fd1Y8AxAi3pPy2O6Uxh+/PjCkyKIj6LJ9qD2LsFlDMlDhdUlG7t7rVuzBR1ttIcL3yZfMkTILqNIbIAFw0YaEGooJ/VjDLEMvhKCp5EUMVnLVoTUwIl5WaSNRVZe9G/dUtxjkUvQ2ONd8dg+P3E9G5XiotFpD8NP/672cKnvuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031438; c=relaxed/simple;
	bh=YEpNs6pmYVxz4PQh8SzmAkXFrjWAYq6cWXXi9C3jIkw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z0OlzAvXm6jrqOxvJqHN73hS67TttPkmLtqoIrAl4WdckU8ACQbIOeyptvzIpV/cdVXVYLiRm8J6FCraXVXEKiNxXGZcJk9SbeIBW/675ssM7dZFvyH7YJvEmStdAm2kaHdX31U1DV1Sxs/naEXhHhxV95kXK9Wd01Rr9RqmMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-493d43b6c28so3783195e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031433; x=1784636233;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=egZiSxqHD1w/P79BBVFkvOie28f1koI4NWZWuHndLxE=;
        b=WfWjP3fzUERWaaofdp0Mxq//Co1L/WuWKoz8PO8Yx4ehFaWu9EcJdpq9oqRppwKR3y
         Cc5em8d5WgzZfuEQWhDXm5JvIJDmkZSh46xskrdq2wT61eNtRNcqxy27vOvSgRLNOWti
         8Z0PO5f4tOZX7/TDY14ZhVmN68yEi2SqwyK1a2CXh1BIhkmU9oY7vXO1svhyyYSDArEx
         YTtdMAb8bCFXFutMgItWaeW9DZd11rgVPlEjpiLukEP1Iog15YwRKmvFMgNxLGdjJdn9
         tv6QVQ+Vq92JVi5NGELmkAZeBxaD63I12AQFXz0wQoP4agYPxyERKJBTNY5wDsIyrG9Q
         pfbw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/ORs7bS7kSPzkyVLbhh1ARvzpZRUpbtIheJ98p2sXQTUowYTJju+PDwg3FIjvw/jDuG0P0vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRV9FDN8/2Ev/1yNSuuqauf8VxhauHiWEfHx9zhD/0RsmGkpS
	LFkZSj3QAl7kcBFPcJut6XjymfhVW6BNXoLnSw9IPV0Qt+Dq1hMqyojK
X-Gm-Gg: AfdE7cnbl5QTmDDeh2ufxv0Yy89hTMDflSaNA3JUSSz7ArALhjKLE8yasXOzpVjgIuR
	XmnAJvfp17mYln1eLku4Ilg21MOM1WY+UML85g3mkqjOFGCrKYSEUrpv6SOjSSmPhtShvCtFY9l
	Ddc/EK+QPSxqcK1ryqZNhFTyuN1dTYz08JYJQFHhOoeaUbTBOmVC0PwJADBJH+MJArxITBPnoVL
	VEdh2HTyI9NXitGchOOxtWVGpDxk/dLtoxh6FaClHJTftcLVih53qQrhfESOOKDWGhJin0rtwE5
	BYrnAPsH+YKV+7CBBo7wQLmrxbA9mJYxsLSd8pckFWsfyA87I+0s9VOxmpr7oXJTUvkvZFrJNim
	ho2srQ19AOvSNeZqrevFefvVwBowOjaBgmv6ORVddc3jzU4HlzvE2nDu0asTuz5JDzKLl94W4+h
	qGozZwCxOXvWOn4CrSerYvrGnc0rNy3arJpolmWrfTF1kdY5eUvQ==
X-Received: by 2002:a05:600c:1f87:b0:493:f870:fbf0 with SMTP id 5b1f17b1804b1-493f88b3693mr166046515e9.34.1784031432765;
        Tue, 14 Jul 2026 05:17:12 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871cbd6sm84393335e9.3.2026.07.14.05.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 05:17:12 -0700 (PDT)
Message-ID: <87f03ccc-5f60-4e8e-a6ef-8f5f8dcb4e12@ovn.org>
Date: Tue, 14 Jul 2026 14:17:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 davem@davemloft.net
Subject: Re: [ovs-dev] [PATCH net-next v2] selftests/net/openvswitch: add SCTP
 flow key test
To: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
References: <20260707034718.2717982-1-houminxi@gmail.com>
 <f92c4b8a-601a-4e22-822a-ba00705fe60c@ovn.org>
 <CAJ0BgHeDpvS1-stvrDp0HpUgQY8ZSdJZvAiw7fLpL2EHPeRwHg@mail.gmail.com>
 <CAJ0BgHc_3fRLFpaUkb2P2jY4avtB3XJQmk0jE-4UC=1abtKLaQ@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAJ0BgHc_3fRLFpaUkb2P2jY4avtB3XJQmk0jE-4UC=1abtKLaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	TAGGED_FROM(0.00)[bounces-307446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:davem@davemloft.net,m:houminxi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ovn.org:from_mime,ovn.org:email,ovn.org:mid,conntrack_sctp_collision.sh:url,sctp_vrf.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,openvswitch.org:email,openvswitch.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEC0B7547CF

On 7/14/26 2:01 PM, 侯敏熙 wrote:
> Hi Ilya,
> 
> Thanks for pointing this out.  I looked into this and found that
> nc (netcat-openbsd) on Debian/Ubuntu does not have SCTP support at
> all. The upstream OpenBSD nc only handles TCP, UDP, and
> Unix-domain sockets, and the Debian patches don't add SCTP either.

AFAICT, 'nc' in netdev CI is the nmap version of netcat, it's not
the openbsd one.  Does nmap version support sctp?  Google seems to
think so at least.  The test should be skipped though if sctp is
not supported.

Note: sashiko had some comments on the daemon pid handling in v2.

Best regards, Ilya Maximets.

> 
> I see two cleaner alternatives that already have precedent in the
> kernel selftests:
> 
> 1. socat: net/netfilter/nft_queue.sh already uses
>    "socat -u SCTP-LISTEN:PORT STDOUT" for SCTP data-plane testing.
>    Many drivers/net/ selftests already gate on require_cmd("socat").
> 
> 2. A small C helper: similar to sctp_hello.c used by sctp_vrf.sh
>    and conntrack_sctp_collision.sh.  The shell test would call
>    "./sctp_test server/client IP PORT" instead of ncat.
> 
> Which approach would you prefer for v3?
> 
> Best regards,
> Minxi
> 
> 侯敏熙 <houminxi@gmail.com> 于2026年7月13日周一 11:02写道：
> 
>> Ah so many thanks for your suggestions, Please forgive me,
>> I've always used ncat to write test cases.
>>
>> I will re-spin this patch.
>>
>> Ilya Maximets <i.maximets@ovn.org> 于2026年7月13日周一 10:39写道：
>>
>>> On 7/7/26 5:47 AM, Minxi Hou wrote:
>>>> Register OVS_KEY_ATTR_SCTP in the flow key parser so that sctp()
>>>> can be used in flow specifications. The ovs_key_sctp class already
>>>> exists (with src/dst fields matching the TCP/UDP siblings) but was
>>>> not wired into the parser, so the token was silently dropped and the
>>>> kernel rejected the flow.
>>>>
>>>> Add test_sctp_connect_v4 exercising the SCTP flow key with
>>>> port-specific matching: sctp(dst=4443) for client-to-server and
>>>> sctp(src=4443) for server-to-client.
>>>>
>>>> Wait for ncat readiness with ovs_wait instead of a fixed sleep so
>>>> the test does not race against ncat startup. Use grep -c on the
>>>> listening message to distinguish between successive ncat instances
>>>> that share the same stderr log. Kill the previous server before
>>>> respawning to avoid EADDRINUSE on the SCTP port.
>>>>
>>>> Signed-off-by: Minxi Hou <houminxi@gmail.com>
>>>> ---
>>>> v1 -> v2: replace sleep with ovs_wait on ncat listening output,
>>>>           kill previous ncat server before respawning to avoid
>>>>           port conflict (Aaron review feedback)
>>>>
>>>>  .../selftests/net/openvswitch/openvswitch.sh  | 102 ++++++++++++++++++
>>>>  .../selftests/net/openvswitch/ovs-dpctl.py    |   5 +
>>>>  2 files changed, 107 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>> b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>>> index 2954245129a2..9c364eeb2ec2 100755
>>>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>>> @@ -32,6 +32,7 @@ tests="
>>>>       dec_ttl                                 ttl: dec_ttl decrements
>>> IP TTL
>>>>       flow_set                                flow-set: Flow modify
>>>>       action_set                              set: SET action rewrites
>>> fields
>>>> +     sctp_connect_v4                         sctp: SCTP flow key
>>> matching
>>>>       psample                                 psample: Sampling packets
>>> with psample"
>>>>
>>>>  info() {
>>>> @@ -443,6 +444,107 @@ test_action_set() {
>>>>       return 0
>>>>  }
>>>>
>>>> +# sctp_connect_v4 test
>>>> +# - sctp(dst=4443) matches client-to-server INIT
>>>> +# - sctp(src=4443) matches server-to-client INIT-ACK
>>>> +# - remove flows and verify connection fails, reinstall and recover
>>>> +test_sctp_connect_v4() {
>>>> +     local t="test_sctp_connect_v4"
>>>> +
>>>> +     which ncat >/dev/null 2>&1 || return $ksft_skip
>>>
>>> Not a full review, but can we avoid ncat?  We already use nc in other
>>> tests, using different implementations of the same thing in different
>>> tests doesn't sound like a good idea.  On mnay systems nc and ncat
>>> will be different implementations with different options and behavior.
>>>
>>> Best regards, Ilya Maximets.
>>>
>>
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
> 


