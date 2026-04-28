Return-Path: <netdev+bounces-282061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHquCyAP8WmXcQEAu9opvQ
	(envelope-from <netdev+bounces-282061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:48:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8B48B566
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A2CC300A24F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F6A3A9612;
	Tue, 28 Apr 2026 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XywkDYu9"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06383282F1F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405659; cv=none; b=hofMPD/J5MbHF1ELVFy1YQ7BWS54koeptrKcxv9MIarfbi/naEna/pLxeWRaW47GYrZngkm+hXT4WT2f9XlY2hVNZNNo0hg+SGtyDJSlmGM6f8ZvRjDKZ0rDfpeXb+YsbLsCAXtI58RwBRgqP3EZ1O4kHRoLkc/JvYRDq3LQMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405659; c=relaxed/simple;
	bh=LT0egybVhlL2Fg6NhI1vkNVlZv6pZw/7SLdXWtlWleA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuJwAaODKDUcf5b9dhVvkP0v69MfEOUiDSrOINKKKWC6YZy4VPZEQdfSg9mg+kb2ob8qsSCYoygindGPEmgIDhax8xiq9/+zzCjibW58MEIynamY4nK+fjZi9pa0zRhUkn7Z1hXxaZLZ+ZJZua/ntJO1ChyszJfWJ2BHSqtoSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XywkDYu9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eqWCOe1xfgqfRBn1e+kMhnAbNjljI2zLW/qsW5lfQlo=; b=XywkDYu9CXyMZzxEjF5f9i97Zd
	jh/6VMW5SisMcWkddKZwcddRZ4mnxH7m1bChXlVqCVGMZzNWQGuNV5qZR72Yk5Ami9PjsOhOZ3szx
	W/Wi1qOSbIFOi6L0kiBcxPg7lR5kQ26uhS/PkF2Xt9sePuUgRjSv3dHnLjT35furzE9AT3SossFPp
	VzQeheOEdaxgUXfa2CXBa2fSFmRnV3wDzHJO8k7dQIQtM6PFSoQMdgeygfvGXyKytah+nHi2nwMkw
	UE0M6ONmZoZGraGvQZt6hWU2UPHhlBQDKityu01BJmQzAIZvcrMABxn+zq7WCWlfgMdvonRpRY247
	fNVKKIcg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wHoP9-000BWE-1J;
	Tue, 28 Apr 2026 21:47:35 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wHoP9-0008bh-0i;
	Tue, 28 Apr 2026 21:47:34 +0200
Message-ID: <4d85df62-b4be-4929-841a-a844217a42ad@iogearbox.net>
Date: Tue, 28 Apr 2026 21:47:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv6: Implement limits on extension header parsing
To: Justin Iurman <justin.iurman@gmail.com>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260428153749.785611-1-daniel@iogearbox.net>
 <4497a340-b48e-4615-81eb-90ebc7a0b5d2@gmail.com>
 <34f6054f-5d5d-47c8-b06d-f7b40d74c3f0@iogearbox.net>
 <61387501-77a7-49b8-8124-7fca5168901c@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <61387501-77a7-49b8-8124-7fca5168901c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27985/Tue Apr 28 08:25:02 2026)
X-Rspamd-Queue-Id: 4CA8B48B566
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282061-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/28/26 8:54 PM, Justin Iurman wrote:
> On 4/28/26 20:16, Daniel Borkmann wrote:
>> On 4/28/26 7:58 PM, Justin Iurman wrote:
>>> On 4/28/26 17:37, Daniel Borkmann wrote:
>>>> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
>>>> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
>>>> find a non-extension-header protocol or run out of packet data. The
>>>> loops have no iteration counter, relying solely on the packet length
>>>> to bound them. For a crafted packet with 8-byte extension headers
>>>> filling a 64KB jumbogram, this means a worst case of up to ~8k
>>>> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
>>>> for example, is used where it parses the inner quoted packet inside
>>>> an incoming ICMPv6 error:
>>>>
>>>>    - icmpv6_rcv
>>>>      - checksum validation
>>>>      - case ICMPV6_DEST_UNREACH
>>>>        - icmpv6_notify
>>>>          - pskb_may_pull()       <- pull inner IPv6 header
>>>>          - ipv6_skip_exthdr()    <- iterates here
>>>>          - pskb_may_pull()
>>>>          - ipprot->err_handler() <- sk lookup
>>>>
>>>> The per-iteration cost of ipv6_skip_exthdr itself is generally
>>>> light, but skb_header_pointer becomes more costly on reassembled
>>>> packets: the first ~1232 bytes of the inner packet are in the skb's
>>>> linear area, but the remaining ~63KB are in the frag_list where
>>>> skb_copy_bits is needed to read data.
>>>>
>>>> Initially, the idea was to add a configurable limit via a new
>>>> sysctl knob with default 8, in line with knobs from commit
>>>> 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination
>>>> options"), but two reasons eventually argued against it:
>>>>
>>>> - It adds to UAPI that needs to be maintained forever, and
>>>>    upcoming work is restricting extension header ordering anyway,
>>>>    leaving little reason for another sysctl knob
>>>> - exthdrs_core.c is always built-in even when CONFIG_IPV6=n,
>>>>    where struct net has no .ipv6 member, so the read site would
>>>>    need an ifdef'd fallback to a constant anyway
>>>>
>>>> Therefore, just use a constant (IP6_MAX_EXT_HDRS_CNT). All four
>>>> extension header walking functions are now bound by this limit.
>>>>
>>>> Note that the check in ip6_protocol_deliver_rcu() happens right
>>>> before the goto resubmit, such that we don't have to have a test
>>>> for ipv6_ext_hdr() in the fast-path.
>>>>
>>>> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
>>>> IPv6 extension headers ordering and occurrence. The latter also
>>>> discusses security implications. As per RFC8200 section 4.1, the
>>>> occurrence rules for extension headers provide a practical upper
>>>> bound which is 8. In order to be conservative, let's define
>>>> IP6_MAX_EXT_HDRS_CNT as 4x that to leave enough room for quirky
>>>> setups. In the unlikely event that this is still not enough, then
>>>> we might need to reconsider a sysctl.
>>>>
>>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>>
>>> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
>>>
>>> FWIW, I prefer v4 over v3. I didn't like the idea of a new sysctl for several reasons I already mentioned. So, thanks for this new version, Daniel.
>>>
>>> However, I can't help but think 8 would pose absolutely no problem. I would be very surprised to see someone complain. We're choosing 32 over 8 to be extra safe, at the price of security. RFC8200 provides the following ordered list which is recommended for senders (without normative language, though, which was a mistake):
>>>
>>>        Hop-by-Hop Options header
>>>        Destination Options header
>>>        Routing header
>>>        Fragment header
>>>        Authentication header
>>>        Encapsulating Security Payload header
>>>        Destination Options header
>>>
>>> So this is the maximum you can have theoretically***, although you wouldn't for instance use the Authentication header with ESP. I'm not even talking about ordering or specific number of occurrences here, just the total number of Extension Headers in a packet (as your patch does). It's also worth mentioning that it's highly unlikely to see someone use them all at the same time (in production, of course). This is why I still think that 8 is safe too, and would provide security as expected.
>>
>> What do you think if we fix this at 12 then to also have the exotic cases
>> below covered just in case to be conservative? Would still be an improvement
>> over 32 fwiw. I'm also fine if you think straight to 8 is the better choice.
>> Either option I can spin a v5, np.
> 
> I'm fine either way. IMO, 12 seems like a good compromise to keep everyone happy.

Ack, sounds good, I'll do that in a v5 tomorrow.

Thanks,
Daniel

