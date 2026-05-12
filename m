Return-Path: <netdev+bounces-286981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OndNvbWAmpXyAEAu9opvQ
	(envelope-from <netdev+bounces-286981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44F51BD7D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79F25301705C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E08379C3F;
	Tue, 12 May 2026 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SK8KVo/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3D47B41C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570992; cv=none; b=YUlJ/lANJ1bqFJPZk8ukoptKhYu/0j8h7Yo4mMQpEl7XyGjobnLh/C96GQNNjZSVGddiGAJXxPg5nGNGTFaF7DnIOZC5nMWa2lbT1zZcyFe5TfVa/oEwocn/bGBkDfUVK05eoEW4iamK7fLbhosZOa2YZqxawgjau6XMspTGWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570992; c=relaxed/simple;
	bh=enrK6F8pF1+DC5xoUC1nLFSSKtttn4Ag5Tk54OKTLvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5e03gsu8HJ0IzE2XQlBjouuPpL4BYtqfZ71bu1zibE+Os1p1k9jHvPLD07uduHTJ/lVdyu4Zd6OiTjIsW//1M0XuW0Z6mtgwUekH3lRZrLoO9H4PfAP+5QVPk7jFP1F65UoPMxZi39uQsijd6UQxcFU2meAi0/nZAbaIl0yp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SK8KVo/R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48374014a77so47870145e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778570986; x=1779175786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S03clhA3X9e6T0mkVuCHL6VqCvjp6qi2JwB7RcWqO3k=;
        b=SK8KVo/RuOk2SrHe0Qtv2Ln29BBCw8PuC9z42vWZXG0YWTu89/jdtbQP8ErTVUm/65
         KiQVI/bpRTBt5EcD27SHHIKU/gLiJwSHwH+p5vGScgAJwHMbDrK3rGHvO8px3k2MoXXE
         +dAWo13bxugz4Weg/d3gDqZS+nNcPd6ng/K+Hn8pgpOm5ouzPJaCOoJr3FoHNOS3RnPd
         0J9ag6v+v6dXp2HCB7mTMwenFMer6Ww6u4RKZQdg+p6cf/mDw+pYDdErJyk0V7EBQjJh
         Js0M/iFR72TucnCFaMg96h/D8q19rgl7JXpPm3kbAVyxkpcu3YhmEYFylT0Dp8u2Y84+
         2bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778570986; x=1779175786;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S03clhA3X9e6T0mkVuCHL6VqCvjp6qi2JwB7RcWqO3k=;
        b=aRHEo8geQ37o6yth6oK72WWWv2s52P0wZWGpHItEH8RfCDmIYrmefFMfdBr1NPA/ny
         aMmhl3Sk8IoFo++xKnp/c17iiCqYLTDEcfGA8KJYu1UTFlTerTDOHq8leleLmL4wdbYl
         9oeZyI19oBDNqrUzHhQmmFhfrkuDsdBGRnGm2cWBQ+qg4LZ/RfCEnNLFa9ze1ZiDaI+d
         NQ9NNwPc7/SCp0SS/MRYxvHmyH+n0qlxiQEA7ukv2EsdAWn73uU5OyaM2kR1MP7uP/8/
         ZTUaBWRypZHze2SEN6En56J3gwG1qL3BqrHR8E1DB32fdNv/TRuFA7UO7cIm85rFoY4p
         Bvjw==
X-Gm-Message-State: AOJu0YxzTUCLEx9drtUU+bmLEJpKrOqLSS9XTIQyI235M5JoM8TwcePN
	/s4FDO0dUlTxBBcTfqdHfi8UoNSNhKBYsvvOu23DHlH1Mt4amnTpQftupb5G1fnFlvrtZIz/U7H
	5VMFljeGDmwRnUF1adSDr65mVnLNgja9NGKnz83YsRe9kDdbnvO4=
X-Gm-Gg: Acq92OH0VV+H5AaWqaBveoDt1wtOshLMAKaKtw2r4YaWhV9sDhMPw1zYl7fwZSe5a3E
	NlwMsaTr+onLZGMC0EHcOUSaBiJkLmYdmoU+fDHSDQ2uf8wY3cyma4TjBEBZ3cBn5Gx56LgCfzx
	zAM4bylB17fVRpe/D06IAGc+Wh132ZC6vLmw/PnJLutPkZ7VPq0az6EeG8FMDPzqFwHYJweaej3
	m1h6Ie3ghzHXrEUC7rqyVZ4tx/QfpKr7xgakqroGvffP597xII5AvCT3u/vYfZtQ6VwE0d38DkC
	7qXPvkjkX27UJEtxRFiaB0frXJ9NiMYHKz6h3p0QKvUtaNIwfFC6A/dtS8hhB1angN4DxMUOT4o
	8tWx9iq5OmQX9poeVDUtdVZUqr3LsiyhpGiBoaJ6BDmWDGWo0u2HUvSdWZ7d+GCNxxIeEKsp/6m
	FkcQaJm9Qi2QdePQJSVKxEBQ479ACmLPQ+2s2HOHAqEpVVQ4qI43f0svn3XWXpKQ==
X-Received: by 2002:a05:600c:8b83:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48e706acfb7mr193418595e9.3.1778570986524;
        Tue, 12 May 2026 00:29:46 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:7a81:9c57:657f:40cd? ([2001:67c:2fbc:1:7a81:9c57:657f:40cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b00fsm33726813f8f.11.2026.05.12.00.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 00:29:45 -0700 (PDT)
Message-ID: <359d25a9-e5f5-4e6e-adb0-0633f12191fb@openvpn.net>
Date: Tue, 12 May 2026 09:29:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in
 ovpn_tcp_close()
To: David CARLIER <devnexen@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-2-devnexen@gmail.com>
 <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
 <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D44F51BD7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On 12/05/2026 06:56, David CARLIER wrote:
> Hi Eric,
> 
> On Tue, 12 May 2026 at 05:29, Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Mon, May 11, 2026 at 9:20 PM David Carlier <devnexen@gmail.com> wrote:
>>>
>>> ovpn_tcp_close() loads the ovpn_socket via rcu_dereference_sk_user_data()
>>> under rcu_read_lock(), takes a reference on sock->peer, caches the peer
>>> pointer in a local, and drops the read lock. It then passes sock->peer
>>> (rather than the cached local) to ovpn_peer_del(), re-dereferencing the
>>> ovpn_socket after the RCU read section has ended.
>>>
>>> Unlike ovpn_tcp_sendmsg(), which uses the same "load under RCU, use
>>> after unlock" pattern but is protected by lock_sock() held across the
>>> function, ovpn_tcp_close() runs without the socket lock: inet_release()
>>> invokes sk_prot->close() without taking lock_sock first.
>>>
>>> ovpn_socket_release() can therefore complete its kref_put -> detach ->
>>> synchronize_rcu -> kfree(sock) sequence concurrently, in the window
>>> after ovpn_tcp_close() drops rcu_read_lock() but before it dereferences
>>> sock->peer. The synchronize_rcu() in ovpn_socket_release() protects
>>> readers that use the dereferenced pointer inside the RCU read section,
>>> not those that escape the pointer to a local and use it afterwards.
>>>
>>> A reproducer follows the pattern of commit 94560267d6c4 ("ovpn: tcp -
>>> don't deref NULL sk_socket member after tcp_close()"): trigger a peer
>>> removal (keepalive expiration or netlink OVPN_CMD_DEL_PEER) at the same
>>> moment userspace closes the TCP fd. That commit fixed the detach-side
>>> of the same race window; this one fixes the close-side at a different
>>> victim.
>>>
>>> Use the already-loaded peer local, which is held by the
>>> ovpn_peer_hold() taken under RCU and is the correct argument anyway.
>>> The remaining lines in the function already use peer; switching this
>>> call makes the function consistent and removes the dangling sock
>>> dereference.
>>>
>>> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
>>> Assisted-by: Claude:claude-opus-4-7
>>> Signed-off-by: David Carlier <devnexen@gmail.com>
>>> ---
>>>   drivers/net/ovpn/tcp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
>>> index 65054cc84be5..ed4782de141a 100644
>>> --- a/drivers/net/ovpn/tcp.c
>>> +++ b/drivers/net/ovpn/tcp.c
>>> @@ -588,7 +588,7 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
>>>          peer = sock->peer;
>>>          rcu_read_unlock();
>>>
>>> -       ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
>>> +       ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
>>>          peer->tcp.sk_cb.prot->close(sk, timeout);
>>>          ovpn_peer_put(peer);
>>>   }
>>
>> I do not see how rcu_read_lock() can protect sock->peer changes.
>>
>> I think we need to be more careful, in the prior code which reads
>> sock->peer 3 times.
>>
>> If RCU is used, we better use it properly.
>>
>> rcu_read_lock();
>> sock = rcu_dereference_sk_user_data(sk);
>> if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
>>          rcu_read_unlock();
>>          return;
>> }
>> peer = sock->peer;
>> rcu_read_unlock();
> 
> You're right. sock->peer is only assigned once, in ovpn_socket_new()
>    under lock_sock() before the ovpn_socket is even published via
>    rcu_assign_sk_user_data(), and never touched again - which is why the
>    three reads happen to be stable. But that's the kind of invariant the
>    next person has to go dig up, so the pattern is doing nobody any
>    favours.
> 
>    v2 tomorrow with sock->peer read once into the local up front, and
>    all the subsequent uses going through that.
> 
>    Same multi-read pattern shows up in ovpn_tcp_recvmsg(),
>    ovpn_tcp_sendmsg(), ovpn_tcp_data_ready() and ovpn_tcp_write_space()
>    - happy to roll those into v2 as well, or punt to a follow-up,
>    whichever you'd prefer.

I have to double check all the mentioned spots, however this sounds more 
like a larger refactoring for net-next that we should be carefully 
review, rather than a bugfix.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


