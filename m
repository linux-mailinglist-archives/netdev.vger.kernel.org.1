Return-Path: <netdev+bounces-289485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBNjEq51DGqihwUAu9opvQ
	(envelope-from <netdev+bounces-289485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F18580A9D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F0233014FE8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB04A340C;
	Tue, 19 May 2026 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="W+6Sw8i3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4133BBAF
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201448; cv=none; b=CAQYrgKjtEuTYWgC7aCWM7s8Br+7y3Vc4NGn3Ysqc87S4fzF2FnjCBSx+gEfP7+RgPVAmZGs9fVaSeftmk+p1a4MToDJHhbxEYxzzoRis0hBDDilpUXzAG9Dfg5IQSRuAJPqwPSAJYX/LSsEbaPfeaYZncLVy6277oEYT9S/nAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201448; c=relaxed/simple;
	bh=WQ3wcX+D39uFMWOxd4vHAYNFHjiJkcqHTKuCXJ6D6l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqJZrCrHFHNmGeJZgBp19fqU7GAKsVJHlsVZyMg8lyWtsTy4gJ8RsNpPX48XNJyADm12CqH2MR2BIuWvSUCr57UInA4yG/2ykplN4ut/jMUKTNS75WaxFhbX1NCowMre5jOZSZvfIhyekmewGqCmU3BEZ3N6rmqwNHVhGXKYU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=W+6Sw8i3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso19911715e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779201444; x=1779806244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QIR0ltgYgJv3qI2h9wRTRONFNcfM8AeocnCLlnLiMXU=;
        b=W+6Sw8i3FXE9LAOEH4g5A+qVUBDkf8/7uBJjpamQ4H/9kqSbvkh0CsKkpW0Kr6x22E
         YMoD+JdsdN24cb1DlGg6adKdwMuOIgoZfYhQKX9BdR8dmNiLm8FqWKEucfZJCpPCFKk6
         JTiLxl2O1G/2PcMizRtfUtF+3P1dm5xeHJ5996mYUao9LfWPTQCuUJwpu5xSio+/WkBz
         u+EEr3xPBxIymHVnCa/kfCUqZHSikGgz6GqXJshL+o3HRHNq7Tvo/GHRiHPU3dT/mHyI
         8ZEEJqO/78dtP3scTuVluePbypjcOoZYJ8e8QahpUTHlOdGPb7V1C9vdjWJlEgETUvH8
         vldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201444; x=1779806244;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIR0ltgYgJv3qI2h9wRTRONFNcfM8AeocnCLlnLiMXU=;
        b=RdiwyNgLqpGBn0oC73mzcHbZL0buzHzFgC/E6nb6HhenA05yY3H+Y+j6TauVs7V6CZ
         JR53R2Y2RjBVNapbfiEkbiXQN3VD8isa/V+4pA816MZ3x9Am1N1MdCUETa3OZFQZnWer
         LAjTq3qqB8Wxem++Kz4NWvIYRk53Vq7x2YRsoc0nz7JTyBCkqeC2RbPRvp6fovP6++5j
         fTPNZ8AtB9pOc8v0a1oTdUqMoNejRSCqO0MZTxVThSd+aDqwMOibTivNI5NOvbBLUVjb
         Q2PB6dAKCXFWXh3NTzPZtBCDRiiLg+5/jA6u0e9Vm89tdiNVA/dfEMJe8/vbXtn+agL5
         lkgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OFVqZOKOqL+yVeI9U4rtiuwk7T1Ke+FVQohYDjKA2l1VGqgegFo+8m3oYn+2wHeVOIAEQl0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTvY5sVAjnzuxcO3dlmLIcH4yTtpLcS4rn5YgBBqbEhsWfVjx
	VRwYlk3EgmuJb6zgyLSmIyIE8IUD0X41Co5Cro4p0gKFMHzn2owTOzsHjAwzXF3Fq2kspm0vwGW
	LEid6TvGJf4wypCoXoHuw5R03Pwg+I9bKuwiEcHfY5HAjPoibwd4=
X-Gm-Gg: Acq92OHUAU5hl1t+BvtD6hFIqnVmhWysOe+R9lo62IuwfpqQS5nD/xujyzrJyN6TuOe
	3HUsnyNxTpjRfh+ub4r/7F8KAsUlXO7oB3EiI5usUuCnc3WGzJkxzb8i7bSfjuwmEZJv0aDA57C
	SZ7Fsv0GdZFO+KmAzZP/1FChdsrs5LSG5P0k3qY5D6/RxYZETHKipreK6q4aKyJ4eo2KXjqPwCu
	rIJzMSGtGRXHVNDdgzQJ/Bs9UlwiTxk7M754DyliRzNpEMUvwBJ5CguEcR3U60U8vqLSnYf8QIv
	RT1iDihadp8KCbVqCCLjZyoEqEdvTJ/3bEYNC3LdZa6aeRkCdzVgdK5bS/j9qnnvmL+tPWiT1Nn
	TYUTNlvSnc+Yj2Fty9CbDfNa0xLzDaLXxz6TdGk88WLBSRe5zhTUdbjtVuKZ/2dGDgW27FfGJ4L
	KAldJRPdR/ol3zGMUlp0TYk4HO/r1zodnr9ca2ySUVBXyct4Hi6HbQXsTZBep5NQ==
X-Received: by 2002:a05:600c:a406:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48fe59b06acmr261599055e9.0.1779201444019;
        Tue, 19 May 2026 07:37:24 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:fcdd:239e:4fa1:a75d? ([2001:67c:2fbc:1:fcdd:239e:4fa1:a75d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53767ecsm298353015e9.10.2026.05.19.07.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:37:23 -0700 (PDT)
Message-ID: <a91b5359-68e7-49a6-8701-fa37f3e5ae21@openvpn.net>
Date: Tue, 19 May 2026 16:37:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ovpn: refuse TCP socket layering with an active
 ULP
To: Sabrina Dubroca <sd@queasysnail.net>,
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260517155645.3882533-1-michael.bommarito@gmail.com>
 <agx0ZRfgc7WhuJtI@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <agx0ZRfgc7WhuJtI@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289485-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[queasysnail.net,gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9F18580A9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/05/2026 16:32, Sabrina Dubroca wrote:
> 2026-05-17, 11:56:45 -0400, Michael Bommarito wrote:
>> ovpn's TCP transport replaces sk_prot, sk_data_ready, sk_write_space
>> and sk_socket->ops by direct field writes when a peer is attached, and
>> restores them by direct field writes when the peer is detached. That
>> layering scheme is not compatible with a TCP ULP (e.g. kTLS) being
>> installed on the same socket: ULP setup also captures the current
>> sk_prot as its lower layer and replaces sk_prot with its own. The two
>> schemes are not aware of each other and can be combined in either
>> order on the same fd.
> 
> It looks like we should make ovpn-tcp a ULP (without requesting
> userspace to do the setsockopt, since we messed that up a year ago. I
> thought I had suggested that at some point, but maybe not). That's
> what it is anyway, and layering ovpn on top of (or underneath) ktls or
> espintcp makes no sense. It would save us the messy restore hacks in
> this patch.

I agree. I was just thinking about a way to prevent this entirely 
without having to make each module (somewhat) aware of each other.

> 
> mptcp calls tcp_set_ulp() from the setup, maybe ovpn can also do
> that. detach() may be an issue.


Yeah, looking into using tcp_set_ulp() makes sense.

> 
> 
> [...]
>> @@ -583,6 +610,26 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
>>   	sock = rcu_dereference_sk_user_data(sk);
>>   	if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
>>   		rcu_read_unlock();
>> +		/* No (or no-longer-attached) ovpn state on this socket.
>> +		 * That happens when ovpn_tcp_socket_detach() already ran
>> +		 * and cleared sk_user_data, but the caller chain still
>> +		 * dispatches ->close() on ovpn_tcp_prot. The two cases
>> +		 * that exhibit this are:
>> +		 *   - a TCP ULP layered on top of ovpn whose close hook
>> +		 *     chains via the captured ctx->sk_proto (which is
>> +		 *     &ovpn_tcp_prot) after detach has run;
>> +		 *   - the close-vs-detach race window where sk_user_data
>> +		 *     has been cleared but sk_prot has not yet been
>> +		 *     restored.
>> +		 * In both cases the TCP layer still owes the peer a
>> +		 * graceful close, so chain to the base TCP close.
>> +		 */
> 
> This is a whole commit message, not a code comment.

I am also not sure what would happen if ovpn goes away first and then 
kTLS is left with the ovpn CBs saved in its captured sk_proto.

Anyway, if we can prevent this from happening at all, as per Sabrina's 
comment above, we would make our life much simpler.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


