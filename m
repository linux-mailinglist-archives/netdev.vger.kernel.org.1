Return-Path: <netdev+bounces-293668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKjuNJZYHWpLZQkAu9opvQ
	(envelope-from <netdev+bounces-293668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:01:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024561CF7A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9928A302847F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707B3AA4FE;
	Mon,  1 Jun 2026 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="gf9Qd7am"
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A6399CEC;
	Mon,  1 Jun 2026 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307387; cv=none; b=q3VASv0uiSJsvPLWjQqR91yHSarSFCFYduZgPEeuHri+2rxCFx3vxUFCcM5o9wKrBzQyO2DIGBdCcgRmbEyWoJXxB0tkd8EONh15G4LA9DAqu65amgo2/0rYZhVCfgPH6VK31Ap11vm5mSPqk4ysEKXnSLhjg/9ZgArX9AE/2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307387; c=relaxed/simple;
	bh=OCfbV/zebHB5PXi/X7vuyAvJawtZ4I6GsTI9EiPFP68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9Ltinz4PTFXRrlYfCSRYH1JRxPWkzW2ftHufgykUcZxzPCKNcvNL2xGR9UyeTmbpgZ2zwYYBIVqmmRavZHNeNh+opquL1KxUgU2tQhPSiBbNIuLpjEED5Eq6B6iN0naEftOnLy2JCYTHX/7GhLgp0BZcTWgs6DbjSmR8zT2eWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=gf9Qd7am; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 42DF56017F;
	Mon,  1 Jun 2026 11:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780307366;
	bh=2DqWZcgwpr7D5kXincB1huoOrfWwEOMLKgcT7H7XyTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gf9Qd7amuPPneI1AeTtTfhjdfaHDLsEq8J5aJPDU8wQZYiR5gAwetcjoJ08685khe
	 VkG/RWHaiA+rJWmeM8A3AAX1/E7mJXZu5HXZG5+SQUwFCsXeMSL1s665jK8EuyMvp+
	 oDBhR8H9dMgk0/8r3mc913ikh3Fvx5LypOKX5Br+aWvu6O5w0GMKV2IEVVJpeyXF5Q
	 1xxodVX5poEIhbIfBFUncnGtMdwj++VaA9KVbBsThjhIsurLepVD/0NldexMTxWjou
	 1cHErJui2b8IrIaHgw2jssqwQlr4s6yfBpo23j5Buf3IeQLTdC9/Ja+sz8feQiPtRv
	 yP0LCJ/CX8How==
Date: Mon, 1 Jun 2026 11:49:23 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Sayooj Karun <sayooj@aerlync.com>
Cc: Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	aleksander.lobakin@intel.com
Subject: Re: [PATCH v2 net] net/ipv6: icmp: fix is_ineligible() to block
 errors for Redirect packets
Message-ID: <ah1VoxXLbRAZIEC3@chamomile>
References: <20260526101622.38536-1-sayooj@aerlync.com>
 <20260527094601.23276-1-sayooj@aerlync.com>
 <CANn89i+KRyU5qKa7x3wh_G=NMqd27-wQOAQdg=NMzm8bC6SONA@mail.gmail.com>
 <CAFdLOz67Sxne4yXi3hB7Nf0eX=SzE9-P1phG4OzYfrgjQvmcGw@mail.gmail.com>
 <CANn89i+KFK5ap6S_wdR2eJUbQc9aqdXtAnGbQ2tqe6R_bGQiSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+KFK5ap6S_wdR2eJUbQc9aqdXtAnGbQ2tqe6R_bGQiSQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293668-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5024561CF7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Jun 01, 2026 at 12:32:50AM -0700, Eric Dumazet wrote:
> On Mon, Jun 1, 2026 at 12:23 AM Sayooj Karun <sayooj@aerlync.com> wrote:
> >
> > Hi Eric,
> >
> > Thank you for the review.
> > The concern about REJECT becoming DROP for Redirect packets is correct, and that is intentional.
> > RFC 4443  section 2.4(e.2) mandates unconditionally that the originator MUST NOT send an ICMPv6 error in response to a Redirect message.
> > There is no exception for netfilter policy.
>
> Really? Have you CC netfilter maintainers?

Thanks for Cc'ing.

> > To your question "how would the kernel send a reply?" : it cannot, as per the RFC.
> > A user who writes -j REJECT on ICMPv6 Redirect naturally expects an error to be sent back, but the protocol leaves no room for that.
> > RFC 4443  Section 2.4(e.2) forbids it outright. The pre-patch behavior (sending Destination Unreachable in response to Redirect) was the RFC violation.
> >
> > The same suppression already exists in is_ineligible() for section 2.4(e.1): a REJECT rule targeting any ICMPv6 error type (types 0–127) already silently drops without generating an error, because !(*tp & ICMPV6_INFOMSG_MASK)
> > returns true. This patch applies the same logic to  section 2.4(e.2) (Redirect, type 137). Both are entries in the same "MUST NOT" list in RFC 4443.
> > If the goal is to block incoming Redirects, -j DROP is the right tool. Using -j REJECT on Redirect packets was never RFC-compliant. The error response it tried to send was never allowed by the protocol.

Netfilter, through policy, allows to modify the box behaviour in
different ways that makes it non-RFC compliant.

But there is code already code such as nf_skb_is_icmp_unreach() which
does not allow to reject a icmp dest unreach with another icmp dest
unreach.

Also looking at your patch, how does it fix the REJECT case? Maybe you
can propose a patch for nf-next as enhancement that can be reviewed to
netfilter-devel@vger.kernel.org.

Thanks.

> > Thanks,
> > Sayooj
> >
> > On Wed, May 27, 2026 at 5:45 PM Eric Dumazet <edumazet@google.com> wrote:
> >>
> >> On Wed, May 27, 2026 at 2:46 AM Sayooj K Karun <sayooj@aerlync.com> wrote:
> >> >
> >> > Discovered while reading RFC 4443 and cross-checking the ICMPv6 stack,
> >> > which in section 2.4(e.2) mandates that an ICMPv6 error MUST NOT be
> >> > originated in response to an ICMPv6 Redirect message (type 137).
> >> >
> >> > is_ineligible() is called by icmpv6_send() to decide whether a received
> >> > packet is eligible to trigger an ICMPv6 error. It uses
> >> > ICMPV6_INFOMSG_MASK (0x80) to suppress errors for ICMPv6 error types
> >> > (bit 7 clear) while passing informational types (bit 7 set). However,
> >> > NDISC_REDIRECT has type 137 (0x89), which has bit 7 set, so it passes
> >> > the mask check and is_ineligible() returns false and icmpv6_send()
> >> > proceeds to generate an error in response to a Redirect, violating the
> >> > RFC.
> >> >
> >> > A triggerable scenario: a host with an ip6tables/nftables REJECT rule
> >> > applied to incoming ICMPv6 traffic (e.g., dropping Redirects from an
> >> > untrusted router). When the Redirect hits the REJECT rule,
> >> > nf_send_unreach6() calls icmpv6_send() with the Redirect as the
> >> > triggering skb. Without this fix, is_ineligible() returns false and a
> >> > Destination Unreachable is erroneously transmitted in response.
> >> >
> >> > Add an explicit check for NDISC_REDIRECT so that Redirect packets are
> >> > treated as ineligible, suppressing ICMPv6 error generation in response
> >> > to them.
> >> >
> >> > Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
> >> > ---
> >> > The bug can be triggered via a netfilter REJECT rule targeting ICMPv6
> >> > Redirect packets. Consider a host with the following rule:
> >> >
> >> >   ip6tables -A INPUT -s <untrusted-router> -p icmpv6 --icmpv6-type redirect \
> >> >             -j REJECT --reject-with icmp6-adm-prohibited
> >> >
> >>
> >> You are saying that after your patch, this ip6ables will no longer
> >> send a packet, and will effectively DROP
> >> the packet.
> >> This might break user choice/expectations/policy.
> >> If the user wanted a DROP, they would have instead specified "-j DROP"
> >>
> >> Apart from the netfilter world which is free to implement its own
> >> interpretation of the RFC,
> >> how would the kernel send a reply?
> >>
> >>
> >> > When a Redirect packet (type 137) arrives from that source, the packet
> >> > enters ip6_input(), which invokes NF_HOOK(NF_INET_LOCAL_IN). The
> >> > netfilter framework iterates the registered hook entries via
> >> > nf_hook_slow(), reaches the ip6tables filter table, and evaluates the
> >> > rules. The incoming Redirect matches the rule, causing reject_tg6()
> >> > (net/ipv6/netfilter/ip6t_REJECT.c) to be called as the rule's target
> >> > action. reject_tg6() calls nf_send_unreach6(), which in turn calls
> >> > icmpv6_send() with the Redirect packet as the triggering skb.
> >> >
> >> > Inside icmpv6_send(), is_ineligible() is called to decide whether to
> >> > suppress the error. The function detects that the inner protocol is
> >> > IPPROTO_ICMPV6 and reads the ICMPv6 type byte. NDISC_REDIRECT is
> >> > type 137 (0x89). The check !(*tp & ICMPV6_INFOMSG_MASK) evaluates as
> >> > !(0x89 & 0x80) = !(0x80) = false, so is_ineligible() falls through and
> >> > returns false and the kernel proceeds to transmit a Destination Unreachable
> >> > in response to the Redirect, violating RFC 4443 section 2.4(e.2).
> >> >
> >> > Tested using network namespaces with the above ip6tables rule. Without
> >> > the fix, tcpdump confirms a Destination Unreachable is transmitted in
> >> > response to the Redirect. With the fix applied and verified under QEMU,
> >> > no error is generated.
> >> >
> >> > From the RFC:
> >> > (e) An ICMPv6 error message MUST NOT be originated as a result of
> >> >     receiving the following:
> >> >
> >> >     (e.1) An ICMPv6 error message.
> >> >
> >> >     (e.2) An ICMPv6 redirect message [IPv6-DISC].
> >> >
> >> >     ...
> >> >
> >> >  net/ipv6/icmp.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> >> > index efb23807a026..3fdb3a97dd8e 100644
> >> > --- a/net/ipv6/icmp.c
> >> > +++ b/net/ipv6/icmp.c
> >> > @@ -157,7 +157,8 @@ static bool is_ineligible(const struct sk_buff *skb)
> >> >                  */
> >> >                 if (!tp && frag_off != 0)
> >> >                         return false;
> >> > -               else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK))
> >> > +               else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK) ||
> >> > +                        *tp == NDISC_REDIRECT)
> >> >                         return true;
> >> >         }
> >> >         return false;
> >> > --
> >> > 2.53.0
> >> >

