Return-Path: <netdev+bounces-292269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G0/E57iFmpIvAcAu9opvQ
	(envelope-from <netdev+bounces-292269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:25:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF75E4219
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5EC30D7172
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687F3D34B3;
	Wed, 27 May 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNH55mtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE193C819A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884127; cv=pass; b=mUkwcCErQT6KCbj7dfQ11eOkC2I2T0oIeVFdc7UPGNA7GGB27PshTqrPnwePe5EzfPcVMxSWXxXzDVs2hI+xemChIBAAjvM6iUOPpGH5qpsR7A3ZgJoReO4hFSxM4No5xJADjxrh1Y3HyaEblOrJtPC9AVQtzM81Z1hN2nr0Wnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884127; c=relaxed/simple;
	bh=H7NTI8hKjTq+U5b3dI7qn3AUEE7WGFFZWbd9g2ZKHhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7vZVUNAK9LdtIUFxL4C14zV0mq69H6NXRy8cB3fY/ReGBzVtKEo6AgDUFKEKY8nsEBteQOZLdWRuA46S6X3WunKW1Gk4NLWu3CsbX6hCLL4kRd/GVB9FZMqoYWqK8KBF0BxWTfEGd7Rpa1ynAemJqsKhPq3253abl9wxGMdh1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNH55mtM; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51306c9f2a8so139682331cf.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779884125; cv=none;
        d=google.com; s=arc-20240605;
        b=TFUPU5J/eK0monIW8QpdXPfz+M+UcpIuAHiqEIXF5b2rcr+5r1Mb6S3p+Ni6gSoqlg
         9uvfd+b0akHp7TNoknX+ELLvAW75yuHWloQThxC5sQUGUMWZyuBdZUux31d+ekoqhHGl
         gM69vpcM2pDIdF3M6k0qv7GG+wq/bK4c6nNxApnjdJ9CH/di7U48zhtJA94QfpuSeUSk
         87fmkQaNQV2wUmLU762QRwSAxrGWu1E6iGDJx07KAyKK+4RVgxCCFyzVKCElmSi5nKMM
         Emg16B0HBjNjkDaQcl0NtUpGOLBT0GchPbY2DOqGtS6VBSNAv4SioGPg+HBwB7P5JSnA
         sdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KK5WRydXI+0VWGukJfdiVhiwzXbfrhgtoNXk++KkgNI=;
        fh=E/RogmPHM2Ev4liPX5CuDEBW8pKG1jmi9R4aVXcWl6M=;
        b=ccH4jcIaZu6VGivC2gSGdtrY05eL3qEOmRf8Jgj7dy6TJML3z1FiaZWwWMqYISYw9B
         mTntlhhDbTQ7yE2hbn44npelc+1ggC2pINp5PFAApK57aqAgmTo2tfh1/TpdTGV4zknd
         0UoKbdnFTXNz67z08HD+wGskLRCcW3Y2aI4BBxRlvc5VM+OH22RlINfhFYQgKIymkD0l
         t/4DCNdb7kBeSV2pbmK7UPpPjgSmG/l08CoZhS8cuvs8YcD8GTYQO7Cfp5ahxAVmLkTM
         5wWiGHQZNGLCnD+buxl6LXZhd+2TJboFI+ASSK/ai/QCYMI1xxEP3e7n6JMjA5JR6zsG
         jJqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779884125; x=1780488925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK5WRydXI+0VWGukJfdiVhiwzXbfrhgtoNXk++KkgNI=;
        b=lNH55mtMZw3E1hdYs3J7a8shdNBYbkqRnED4bu+zYZ7PFP3I+V2Rmry9iBc5y1lHFV
         ONY8FokpVCFaGDHBBKyb6nW7OKuGNLnQeUFR07vKdxNb9PCqJE/Lg2bAUjiI4cRAer3B
         a6ojPcSm63xV8loMiRVL8hnteCaq4z6nr0fCAoxc4yclpBoRP7yKFF0e0LAojGdIe4ij
         5W7RLWpJDrq1bBCsX1mpaehL6OmTtTx2yUCQOhhnpRymp8f7uevtEfexjqo5b+HX0bnz
         WHFnoMBylVfX7xDqtVYAq3ahpqlT1PPMVK0c/PBGjOEqwpG6NQCPP38L8sD/kelwXKVS
         4qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884125; x=1780488925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KK5WRydXI+0VWGukJfdiVhiwzXbfrhgtoNXk++KkgNI=;
        b=gxPTd9FEG/WNjpIDHscPDX9NUFH4Ivb33iivUdOjd8TeSS4dGDJlPWHRm2GR486bjn
         e/ZtUnHSH9dajUo2W7I+IpyqByDgv35FPl0JoE3zNb68mWZU9h7HPk7jDjZumt2PHbRV
         j8alHNdbobvP3JifzPIP78+Ny1F7HTGDS6P4Udl9YHbg7EyNBgmjdfeWXRrbjCPbbz7L
         nS85RMjsUMehJX8hY7f/5KBQtNJFtevUnPqtS8lzOFMzYZ+V/I4ctKAOTGaDqod1o+M/
         Qt/v5Ez2acwHn8nfZC3pcRCjNZlOGF4LtX8PbgoJGSL+8FSkP5cBlrqKsio2csJnSPpj
         p3ow==
X-Gm-Message-State: AOJu0YzJbvsNKXWC/zjjb0beV3YAHM87x3iXwo9GsROIZJ3e0IiPf5hb
	xqb6TEhW4uOgBSgph4VPtyr9FT5lIjsWEN/8WEj/anuRLMDc6qSTgPwUWcCnRK7zCeOTyvjXWz9
	vRL/1l0LVNyjwvPapz01vXjdUASDGo8frO05j/zqe
X-Gm-Gg: Acq92OGO7VuexjmKWWau9z9KxOnoOTZ+lR20hcJE43JoC3H2GX+4+joMRBtJo2Bf786
	IxTKbIOHT9arM6LbGz4XbZ0MxTdAYJ7fY5QzF2LWOSxW0hWB8Sb+llt+bREWJB9DET9ZWN7/mCq
	9oAlFao+VO/0o9bUTIrcqTMVHDFu0dWmmWJCvDzD3LLxmq5AokvSXS/6jgNl9tVR/nACm6asj3k
	K1WgzwNRMUP8zvUYT3XECLCKicOEucwhqr5gOCm0lgKf2RPsW7K0L1PqwWcOvHPKMmIqCFrt+Wq
	z93pwsi+MGfvXvQ4304KN5wQ+PW9+lTchpzEonNXjqNyJMEvEkOzdwzV9YAzDyr6ygse3POBrX8
	cSWOpk5yCuNoxFZWAtdsRc61ZL3s=
X-Received: by 2002:a05:622a:1b04:b0:50d:9c60:fe2a with SMTP id
 d75a77b69052e-516d43dc0ffmr314943301cf.1.1779884123925; Wed, 27 May 2026
 05:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526101622.38536-1-sayooj@aerlync.com> <20260527094601.23276-1-sayooj@aerlync.com>
In-Reply-To: <20260527094601.23276-1-sayooj@aerlync.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 May 2026 05:15:11 -0700
X-Gm-Features: AVHnY4IcAt1RvN4QSpDwL0yFgQ6tB1PtQxwNjtnPx0_QsN8HZa5CEEru64G5uuY
Message-ID: <CANn89i+KRyU5qKa7x3wh_G=NMqd27-wQOAQdg=NMzm8bC6SONA@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/ipv6: icmp: fix is_ineligible() to block
 errors for Redirect packets
To: Sayooj K Karun <sayooj@aerlync.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292269-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aerlync.com:email]
X-Rspamd-Queue-Id: BFCF75E4219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 2:46=E2=80=AFAM Sayooj K Karun <sayooj@aerlync.com>=
 wrote:
>
> Discovered while reading RFC 4443 and cross-checking the ICMPv6 stack,
> which in section 2.4(e.2) mandates that an ICMPv6 error MUST NOT be
> originated in response to an ICMPv6 Redirect message (type 137).
>
> is_ineligible() is called by icmpv6_send() to decide whether a received
> packet is eligible to trigger an ICMPv6 error. It uses
> ICMPV6_INFOMSG_MASK (0x80) to suppress errors for ICMPv6 error types
> (bit 7 clear) while passing informational types (bit 7 set). However,
> NDISC_REDIRECT has type 137 (0x89), which has bit 7 set, so it passes
> the mask check and is_ineligible() returns false and icmpv6_send()
> proceeds to generate an error in response to a Redirect, violating the
> RFC.
>
> A triggerable scenario: a host with an ip6tables/nftables REJECT rule
> applied to incoming ICMPv6 traffic (e.g., dropping Redirects from an
> untrusted router). When the Redirect hits the REJECT rule,
> nf_send_unreach6() calls icmpv6_send() with the Redirect as the
> triggering skb. Without this fix, is_ineligible() returns false and a
> Destination Unreachable is erroneously transmitted in response.
>
> Add an explicit check for NDISC_REDIRECT so that Redirect packets are
> treated as ineligible, suppressing ICMPv6 error generation in response
> to them.
>
> Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
> ---
> The bug can be triggered via a netfilter REJECT rule targeting ICMPv6
> Redirect packets. Consider a host with the following rule:
>
>   ip6tables -A INPUT -s <untrusted-router> -p icmpv6 --icmpv6-type redire=
ct \
>             -j REJECT --reject-with icmp6-adm-prohibited
>

You are saying that after your patch, this ip6ables will no longer
send a packet, and will effectively DROP
the packet.
This might break user choice/expectations/policy.
If the user wanted a DROP, they would have instead specified "-j DROP"

Apart from the netfilter world which is free to implement its own
interpretation of the RFC,
how would the kernel send a reply?


> When a Redirect packet (type 137) arrives from that source, the packet
> enters ip6_input(), which invokes NF_HOOK(NF_INET_LOCAL_IN). The
> netfilter framework iterates the registered hook entries via
> nf_hook_slow(), reaches the ip6tables filter table, and evaluates the
> rules. The incoming Redirect matches the rule, causing reject_tg6()
> (net/ipv6/netfilter/ip6t_REJECT.c) to be called as the rule's target
> action. reject_tg6() calls nf_send_unreach6(), which in turn calls
> icmpv6_send() with the Redirect packet as the triggering skb.
>
> Inside icmpv6_send(), is_ineligible() is called to decide whether to
> suppress the error. The function detects that the inner protocol is
> IPPROTO_ICMPV6 and reads the ICMPv6 type byte. NDISC_REDIRECT is
> type 137 (0x89). The check !(*tp & ICMPV6_INFOMSG_MASK) evaluates as
> !(0x89 & 0x80) =3D !(0x80) =3D false, so is_ineligible() falls through an=
d
> returns false and the kernel proceeds to transmit a Destination Unreachab=
le
> in response to the Redirect, violating RFC 4443 section 2.4(e.2).
>
> Tested using network namespaces with the above ip6tables rule. Without
> the fix, tcpdump confirms a Destination Unreachable is transmitted in
> response to the Redirect. With the fix applied and verified under QEMU,
> no error is generated.
>
> From the RFC:
> (e) An ICMPv6 error message MUST NOT be originated as a result of
>     receiving the following:
>
>     (e.1) An ICMPv6 error message.
>
>     (e.2) An ICMPv6 redirect message [IPv6-DISC].
>
>     ...
>
>  net/ipv6/icmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index efb23807a026..3fdb3a97dd8e 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -157,7 +157,8 @@ static bool is_ineligible(const struct sk_buff *skb)
>                  */
>                 if (!tp && frag_off !=3D 0)
>                         return false;
> -               else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK))
> +               else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK) ||
> +                        *tp =3D=3D NDISC_REDIRECT)
>                         return true;
>         }
>         return false;
> --
> 2.53.0
>

