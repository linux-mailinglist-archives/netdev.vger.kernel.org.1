Return-Path: <netdev+bounces-293597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNS8JLM1HWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 309CB61AEBF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D495300362B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAD351C11;
	Mon,  1 Jun 2026 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2xwNyjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8CE1531E8
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299185; cv=pass; b=pL2V+LQsaiQl38YEpn8vmubtFgpucKYW1qbl9WF/O/09xcSdv/acI4qM21H/r0joWQJ7ZhWi1L5TYLJWtA3xbQUnsp34ooo9qA3SeuuBpRb+zLqhf4mGkrsY/uRnDk478dlLNKnzRrkJvOdkkSrF6fF7s6o2kYr8h8Rh6jS9Rds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299185; c=relaxed/simple;
	bh=QC9KnSf8265zfj6rZB/Ra7SXcopwvCjex3DHkdIME5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeL3N6H5poqDBCp2Bg6tTTGLEYXkxKol4tM/yc7apNgA036E2j3IwyfXRf9ThlS7m5WbHN/MJOgJSsmDFODBku8qOmyZLxOYKpL1/S7n2hnO6ra3AhND2Oh8pLXonlPeQbSnOrssT8FeKm3yAtdD5Ex5/3aB3356WgQW9vKHcjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2xwNyjS; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91564c3a968so46483885a.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 00:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780299183; cv=none;
        d=google.com; s=arc-20240605;
        b=cEw76XMYgGatFsEd0B+rxrzEKXcyY5SOpyHtlnzeym2NqIZZ20qcxzczayOT2+IGZs
         vjiGbnrlmqgKmk6zOPb67r8hSmHSxDpOwePgEc+gBy+cPMggKZGZaX3PNWW53cYEBFl3
         /0v6yVlrbiF9xc8gYJjFNNB+6RDsTSObfsM+kglyhqt7eF7UsYhfK6SV1cpTIPZXX1DA
         URMSqHDkHhzOwBpxBGg6ZM+7smqLjWTyhyJqWP9VGek7YZfr9+96yT+ZopeyOjCuZnkv
         7OxX6Ko6+OQIeIpz0FHEMfxY1ZK9MwbmRPf3ax4IWkoJ2tsfMUeFPm3fKoLir5nK/IMN
         jVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5E+HN4HxKrgFBvQsvT2KkuRNEP2t4YH3L1p2Scabsk=;
        fh=bObAVhgmhqGXRza/vjHodDcHGoKD9CXaQH38Vzk6aBI=;
        b=SPK2SYB19ELsZJXKvo6tOqkZx1FK3EsoRyKCKeMuLWAIKz9t+jOe7KzGtf67Ah8UfI
         /jxgsiVoVk3deLRymcIlLxA9yrnFh4JEFEj2NdF62nYViPVE1gxxy4+B9pWdTxuh1Pm7
         iRHYtGt9mm91Pcr91CzxlFy8Fci2cGuvelN0kg4aq8rxGPyqvf6LFr88n9HxJiZVjmVo
         ghJ4sA6i+Pcoz9AyaWJZy+Bt2oHmLr8i7s7UCNJaTgYHFDAqJspCOfcc5Fw0bGT4PSIr
         cZLtW776Nw4rJydN+QuOXPXX97uZ+/76buKGU+6HTUgSA2tbiVt9E0rmvelGmeaaBGmW
         421Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780299183; x=1780903983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5E+HN4HxKrgFBvQsvT2KkuRNEP2t4YH3L1p2Scabsk=;
        b=G2xwNyjSRekknjUgp+HHOCQUEkuvEBoQ6vgVMZ4xC0PrjgYSYCGbBlyZZU/GRHcrO0
         7EBHlOm5howJgXtMtruGaa6jDp7ovxQNc50NjTRaBOULGs9KZEmCsOM/vwpXX52CRvVg
         oBudnRmZK/z0wcQroRIPuoSk9JQO8u8jpYEWM1pNsXKLNz0OlgUvVK7r+LqhsCamAvIQ
         7nflzWTHw/R3pf1A4vq+QT83Q0u3Wd9IJ6wQwQ0mj3b4Vjzil4B+Kt9kZAPpcN0uhHh/
         XnJzPUuYcygqks0FCcQEuws53yG7Woex7KvBHnBwmUoPbUvtgVzJbBOAOGkTpW9ssOzj
         OS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780299183; x=1780903983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5E+HN4HxKrgFBvQsvT2KkuRNEP2t4YH3L1p2Scabsk=;
        b=l/dVGjVKjQoDgPoGIerWxo8L3haRdC+AKQ7k4RsCyfupBhJ90MfDjYjeHDunldsr+B
         nY0Lc9XEmVqQU0zzTCQJ2j7MlekwS/jRmSOF300c59N+XIkv40AwNfUwyoCAKU82dguA
         RoNTeLHRqB0x+bu4MK042o6ETPrK2OM87+v9m9Rx9iBVVN7tRkvv2nOBu0BY4jednpQR
         YTit+sDFAsg913/e2pBX0W1xQyF54IyRhIwZMUJOf1NTkKHzkw+zXClAQoNVL5TTXHyx
         NGUIsZfohej6HDhoJfPYh6u+qfSUyXSZxED6l/X1lbNPIQyFM3RiiX03LLe5vh3sRhfH
         O3eg==
X-Gm-Message-State: AOJu0YwDIUSQKgopwvnhxnJXLIlNMzCOQ2dS6Ry/3zDQzQHQPzpjvVhI
	Ptvv+TZDCKhXH0e1iafdeG/90ZXGtZZztuP/jShjnBjBbA+BePkw0sNPbBS9Z/EpZ9HpObPMEX6
	3k7LZW8UYTz/qh7nrUd2/JNkitpd/2uOZMxSQA2vT
X-Gm-Gg: Acq92OEwyvgcNLAsH/9mvuXrbu7yjXGX5hXBogZEynaeIQuuYSTXQLqfO9bwsBFlSFB
	Cfb8OTxaCbNH25Qprm2uNvY46sQlKjkHZk/ea8u6URciEmADnRFi1c/7y1d09wQoS4a53wgc9av
	wqp1IEy4vSwRCWu9CrfTnPhJQk2EKokPB2L1F9BHaUqeT8mFFJTySiMXXrmY3zQLy/yYQW9bbYO
	SZDoKkT+VSM/4GsFGwOOEvvqhJtQy33pPAJHhk6pWv3gmFnjSiqqdUZIfstHIHYW7F780GrrUEK
	vy9Xdf7yEa4cH5pQ/v4eOgZB9kf49bFcknGILTAf8tlMu702NVPDT5nDrLtoj50y5jMtENWzW+d
	zKEZV1swkIJRmKxtwZLilWU1RdLK2dQ==
X-Received: by 2002:a05:620a:4085:b0:905:ebde:ffa4 with SMTP id
 af79cd13be357-9153e121526mr1335868585a.23.1780299182488; Mon, 01 Jun 2026
 00:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526101622.38536-1-sayooj@aerlync.com> <20260527094601.23276-1-sayooj@aerlync.com>
 <CANn89i+KRyU5qKa7x3wh_G=NMqd27-wQOAQdg=NMzm8bC6SONA@mail.gmail.com> <CAFdLOz67Sxne4yXi3hB7Nf0eX=SzE9-P1phG4OzYfrgjQvmcGw@mail.gmail.com>
In-Reply-To: <CAFdLOz67Sxne4yXi3hB7Nf0eX=SzE9-P1phG4OzYfrgjQvmcGw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 00:32:50 -0700
X-Gm-Features: AVHnY4L0seTMcKTuaB96kYjQYi1fv7PRPfDeY34GALBeWU1puv2YgBeKsATrq8M
Message-ID: <CANn89i+KFK5ap6S_wdR2eJUbQc9aqdXtAnGbQ2tqe6R_bGQiSQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/ipv6: icmp: fix is_ineligible() to block
 errors for Redirect packets
To: Sayooj Karun <sayooj@aerlync.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293597-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 309CB61AEBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 12:23=E2=80=AFAM Sayooj Karun <sayooj@aerlync.com> w=
rote:
>
> Hi Eric,
>
> Thank you for the review.
> The concern about REJECT becoming DROP for Redirect packets is correct, a=
nd that is intentional.
> RFC 4443  section 2.4(e.2) mandates unconditionally that the originator M=
UST NOT send an ICMPv6 error in response to a Redirect message.
> There is no exception for netfilter policy.


Really? Have you CC netfilter maintainers?

>
> To your question "how would the kernel send a reply?" : it cannot, as per=
 the RFC.
> A user who writes -j REJECT on ICMPv6 Redirect naturally expects an error=
 to be sent back, but the protocol leaves no room for that.
> RFC 4443  Section 2.4(e.2) forbids it outright. The pre-patch behavior (s=
ending Destination Unreachable in response to Redirect) was the RFC violati=
on.
>
> The same suppression already exists in is_ineligible() for section 2.4(e.=
1): a REJECT rule targeting any ICMPv6 error type (types 0=E2=80=93127) alr=
eady silently drops without generating an error, because !(*tp & ICMPV6_INF=
OMSG_MASK)
> returns true. This patch applies the same logic to  section 2.4(e.2) (Red=
irect, type 137). Both are entries in the same "MUST NOT" list in RFC 4443.
> If the goal is to block incoming Redirects, -j DROP is the right tool. Us=
ing -j REJECT on Redirect packets was never RFC-compliant. The error respon=
se it tried to send was never allowed by the protocol.
>
> Thanks,
> Sayooj
>
> On Wed, May 27, 2026 at 5:45=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
>>
>> On Wed, May 27, 2026 at 2:46=E2=80=AFAM Sayooj K Karun <sayooj@aerlync.c=
om> wrote:
>> >
>> > Discovered while reading RFC 4443 and cross-checking the ICMPv6 stack,
>> > which in section 2.4(e.2) mandates that an ICMPv6 error MUST NOT be
>> > originated in response to an ICMPv6 Redirect message (type 137).
>> >
>> > is_ineligible() is called by icmpv6_send() to decide whether a receive=
d
>> > packet is eligible to trigger an ICMPv6 error. It uses
>> > ICMPV6_INFOMSG_MASK (0x80) to suppress errors for ICMPv6 error types
>> > (bit 7 clear) while passing informational types (bit 7 set). However,
>> > NDISC_REDIRECT has type 137 (0x89), which has bit 7 set, so it passes
>> > the mask check and is_ineligible() returns false and icmpv6_send()
>> > proceeds to generate an error in response to a Redirect, violating the
>> > RFC.
>> >
>> > A triggerable scenario: a host with an ip6tables/nftables REJECT rule
>> > applied to incoming ICMPv6 traffic (e.g., dropping Redirects from an
>> > untrusted router). When the Redirect hits the REJECT rule,
>> > nf_send_unreach6() calls icmpv6_send() with the Redirect as the
>> > triggering skb. Without this fix, is_ineligible() returns false and a
>> > Destination Unreachable is erroneously transmitted in response.
>> >
>> > Add an explicit check for NDISC_REDIRECT so that Redirect packets are
>> > treated as ineligible, suppressing ICMPv6 error generation in response
>> > to them.
>> >
>> > Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
>> > ---
>> > The bug can be triggered via a netfilter REJECT rule targeting ICMPv6
>> > Redirect packets. Consider a host with the following rule:
>> >
>> >   ip6tables -A INPUT -s <untrusted-router> -p icmpv6 --icmpv6-type red=
irect \
>> >             -j REJECT --reject-with icmp6-adm-prohibited
>> >
>>
>> You are saying that after your patch, this ip6ables will no longer
>> send a packet, and will effectively DROP
>> the packet.
>> This might break user choice/expectations/policy.
>> If the user wanted a DROP, they would have instead specified "-j DROP"
>>
>> Apart from the netfilter world which is free to implement its own
>> interpretation of the RFC,
>> how would the kernel send a reply?
>>
>>
>> > When a Redirect packet (type 137) arrives from that source, the packet
>> > enters ip6_input(), which invokes NF_HOOK(NF_INET_LOCAL_IN). The
>> > netfilter framework iterates the registered hook entries via
>> > nf_hook_slow(), reaches the ip6tables filter table, and evaluates the
>> > rules. The incoming Redirect matches the rule, causing reject_tg6()
>> > (net/ipv6/netfilter/ip6t_REJECT.c) to be called as the rule's target
>> > action. reject_tg6() calls nf_send_unreach6(), which in turn calls
>> > icmpv6_send() with the Redirect packet as the triggering skb.
>> >
>> > Inside icmpv6_send(), is_ineligible() is called to decide whether to
>> > suppress the error. The function detects that the inner protocol is
>> > IPPROTO_ICMPV6 and reads the ICMPv6 type byte. NDISC_REDIRECT is
>> > type 137 (0x89). The check !(*tp & ICMPV6_INFOMSG_MASK) evaluates as
>> > !(0x89 & 0x80) =3D !(0x80) =3D false, so is_ineligible() falls through=
 and
>> > returns false and the kernel proceeds to transmit a Destination Unreac=
hable
>> > in response to the Redirect, violating RFC 4443 section 2.4(e.2).
>> >
>> > Tested using network namespaces with the above ip6tables rule. Without
>> > the fix, tcpdump confirms a Destination Unreachable is transmitted in
>> > response to the Redirect. With the fix applied and verified under QEMU=
,
>> > no error is generated.
>> >
>> > From the RFC:
>> > (e) An ICMPv6 error message MUST NOT be originated as a result of
>> >     receiving the following:
>> >
>> >     (e.1) An ICMPv6 error message.
>> >
>> >     (e.2) An ICMPv6 redirect message [IPv6-DISC].
>> >
>> >     ...
>> >
>> >  net/ipv6/icmp.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
>> > index efb23807a026..3fdb3a97dd8e 100644
>> > --- a/net/ipv6/icmp.c
>> > +++ b/net/ipv6/icmp.c
>> > @@ -157,7 +157,8 @@ static bool is_ineligible(const struct sk_buff *sk=
b)
>> >                  */
>> >                 if (!tp && frag_off !=3D 0)
>> >                         return false;
>> > -               else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK))
>> > +               else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK) ||
>> > +                        *tp =3D=3D NDISC_REDIRECT)
>> >                         return true;
>> >         }
>> >         return false;
>> > --
>> > 2.53.0
>> >

