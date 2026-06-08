Return-Path: <netdev+bounces-296333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rQ8cIngPJmqeRwIAu9opvQ
	(envelope-from <netdev+bounces-296333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 02:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62A652081
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 02:40:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=common-net.org header.s=mail header.b="Bcpq/5xV";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296333-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296333-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=common-net.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656B7300B9F6
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 00:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDA2E2DDD;
	Mon,  8 Jun 2026 00:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.common-net.org (mail.common-net.org [139.28.148.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE0F9D9;
	Mon,  8 Jun 2026 00:40:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780879204; cv=none; b=thNZTqbx7F2Q7kn1TnO2nPNrT5LsXGat04eu0uYryGuwm49mtFXPfdQ6XXaJG6oAcalkRYgJDUsKan03D44GRAYpBO874eppExeave6B8WGR2nAwZ4/EgcXvDHTqKapYm7ktgkacorjqWW4JM58OD4fQrEdOpd5FaLblpiSvD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780879204; c=relaxed/simple;
	bh=fE/ADlnkBPH9pTGhVSqA6lM2fhCG+KALo3TglJMi/KE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NhCenHf/yyqwwFIxbr8Qn5e66/lSo05VMO+mXxjFDC+orbDbyTvZAUB3FDNbqNr9oYxvIHtkxSUX+mHgW82CYE5AYSyRQiQQhUOvxFzcYlr97HFRe147J0+OgBTs+9VfJbyMuf8ZcuUApDRUzmdx2b37dXWdaoXpmvrN0jyQju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=common-net.org; spf=pass smtp.mailfrom=common-net.org; dkim=pass (1024-bit key) header.d=common-net.org header.i=@common-net.org header.b=Bcpq/5xV; arc=none smtp.client-ip=139.28.148.254
Received: from lubuntu-18.04 (host-80-116-255-177.retail.telecomitalia.it [80.116.255.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.common-net.org (Postfix) with ESMTPSA id 966276D20B88;
	Mon,  8 Jun 2026 02:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=common-net.org;
	s=mail; t=1780879193;
	bh=fE/ADlnkBPH9pTGhVSqA6lM2fhCG+KALo3TglJMi/KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bcpq/5xVd5Jc8Qd0t3so+RQsmrD8gSiyi51MwZEGXJ2KjbCZc2NDXka6s2g4064oO
	 WBGniBVD1Yy9RviQC0TXX1PwwJYusFIZ1dMyLQ1qEM+wcfXwG3B+UUkalekrTtme8v
	 LpAqxrH+3H8aGF8yOCp944Th+pBKMV6ux4THqHZs=
Date: Mon, 8 Jun 2026 02:39:51 +0200
From: Andrea Mayer <andrea@common-net.org>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, stefano.salsano@uniroma2.it, ahabdels@cisco.com,
 Andrea Mayer <andrea.mayer@uniroma2.it>, andrea@common-net.org
Subject: Re: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433)
 behaviors
Message-Id: <20260608023951.ccd278890d7c489dbfe21113@common-net.org>
In-Reply-To: <CAGCJULPdm8jbveZsUm467_LBHRf5g=Jqd=XvCVKdNE1F2U99jg@mail.gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
	<20260516182556.66af27a9c63208435911990b@uniroma2.it>
	<CAGCJULPdm8jbveZsUm467_LBHRf5g=Jqd=XvCVKdNE1F2U99jg@mail.gmail.com>
Organization: Common Net
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[common-net.org,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[common-net.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:yuya.kusakabe@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,uniroma2.it,cisco.com,common-net.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[common-net.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,uniroma2.it:email,common-net.org:mid,common-net.org:from_mime,common-net.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F62A652081

On Wed, 20 May 2026 12:12:08 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

Thanks for the reply. Inline answers below.

> On Sun, May 17, 2026 at 1:26 AM Andrea Mayer <andrea.mayer@uniroma2.it>
> wrote:
>
> > RFC 9433 Section 6 is titled "SRv6 Segment Endpoint Mobility
> > Behaviors", but Section 6.7 defines H.M.GTP4.D as "SR Policy Headend
> > with tunnel decapsulation and map to an SRv6 policy". This behavior
> > receives IPv4 packets and is not bound to any SID, so it does not fit
> > the endpoint model that seg6_local implements. Placing it there
> > required relaxing the ETH_P_IPV6 guard to accept ETH_P_IP and adding
> > input_family to seg6_action_desc, for a single behavior that does not
> > share the endpoint model.
> >
> > seg6_local is not the natural place for this behavior. The UAPI cannot
> > be undone once merged, so where it should live needs discussion on the
> > list before we proceed.
> >
> > Given the volume, moving the MUP code into a separate seg6_mobile.c
> > (say CONFIG_IPV6_SEG6_MUP) would keep seg6_local focused on the RFC
> > 8986 endpoint framework.
>
> I will move the MUP code out of seg6_local into a new
> net/ipv6/seg6_mobile.c under a new Kconfig symbol, and register the
> behaviors under a new lwtunnel encap type rather than
> LWTUNNEL_ENCAP_SEG6_LOCAL.
>

On the placement, the new lwtunnel encap type you propose could be a way to
implement the seg6_mobile.c separation. Since this touches UAPI in
include/uapi/linux/lwtunnel.h beyond the SRv6 subsystem and cannot be
undone once merged, it needs careful design.

> For naming I was thinking CONFIG_IPV6_SEG6_MOBILE and
> LWTUNNEL_ENCAP_SEG6_MOBILE to match the file name, but I have no strong
> preference over CONFIG_IPV6_SEG6_MUP if the list prefers that.

On the Kconfig symbol I agree, CONFIG_IPV6_SEG6_MOBILE matches the RFC 9433
Section 6 terminology better than CONFIG_IPV6_SEG6_MUP. Section 6 is titled
"SRv6 Segment Endpoint Mobility Behaviors".

> Once LWTUNNEL_ENCAP_SEG6_MOBILE is its own encap type, it feels
> natural to me to put H.M.GTP4.D there too rather than adding a
> separate LWTUNNEL_ENCAP_SEG6_MOBILE_HEADEND. What do you think?

H.M.GTP4.D in v2 shares the SEG6_LOCAL_MOBILE_* attributes and processing
helpers with the End.M.* behaviors. A separate
LWTUNNEL_ENCAP_SEG6_MOBILE_HEADEND would require its own attribute set,
lwtunnel_encap_ops, and iproute2 parser, similar to the current
implementation of RFC 8986 in the kernel (seg6 and seg6local).

As far as I can see, RFC 9433 has only one Headend behavior, and no L2 or
reduced variants. So a single LWTUNNEL_ENCAP_SEG6_MOBILE handling both
End.M.* and H.M.GTP4.D could be viable if accepting both input families
(ETH_P_IPV6 for End.M.*, ETH_P_IP for H.M.GTP4.D) is treated as a design
choice of the new encap type, not a stretching of the seg6_local endpoint
processing model.

These trade-offs are worth weighing in the final design. The patchset
rework (shared helper functions, the layout of the new UAPI attributes,
etc.) feeds into this decision. Like the encap type above, this is a UAPI
choice and cannot be undone once merged. I think the lwtunnel direction
will need feedback and comments from its community and maintainers.

> Will do, following the End.DT4/End.DT6/End.DT46 model: one patchset
> per behavior, with the behavior, helpers, and selftest as separate
> patches. The new code will be aligned with seg6_local.c style as
> part of this rework.

Sounds good.

> The mobile behaviors will define their own SEG6_MOBILE_* attribute
> namespace under LWTUNNEL_ENCAP_SEG6_MOBILE, with no reuse of any
> SEG6_LOCAL_* attribute. That keeps the established SEG6_LOCAL_*
> semantics untouched.

If LWTUNNEL_ENCAP_SEG6_MOBILE is added, using SEG6_MOBILE_* attributes
instead of SEG6_LOCAL_* removes the NH6/SRH/OIF overload raised in v2.
After solving the above, additional issues remain in the patchset,
for example src is overloaded across MUP behaviors, and v4_mask_len
needs revision. These are independent of the lwtunnel decision.

> I will drop VRF support from the initial behaviors and revisit it
> later as a separate optional attribute.

OK.

> Good idea. The prep patchset would introduce the SRv6-level reasons
> (SEG6_INVALID_SRH, SEG6_HMAC, ...) and convert the existing
> seg6_local and seg6_iptunnel call sites to use them. The
> mobile-specific reasons (BAD_SID, BAD_GTPU) would then be added
> together with the first behavior that uses them and reused by
> subsequent behaviors. NOMEM and MTU_EXCEEDED would be dropped in
> favor of the existing generic reasons, and the current
> INVALID_SRH_SL / BAD_INNER misuses would be replaced by the new
> SRv6-level reasons from the prep patchset.
>
> Would you prefer to lead on the prep patchset yourself, or would you
> like me to prepare it?

I can lead it. I have been evaluating the SRv6 drop reasons with my
research group, alongside other pending SRv6 patches.

We can sync offline on which SRv6 reasons fit your MUP behaviors, which
v2 MUP-specific reasons would fit better as SRv6 or generic, and what
stays MUP-specific.

> I will replace the python3/scapy heredocs with a statically compiled
> C helper for packet construction and validation, and extend the
> selftests to cover the cases you mention (SRH / no-SRH input paths,
> missing SRH where required, malformed SRH, and invalid attribute
> values).

Thanks. Maybe also worth covering bad packets, like fragmented input or
malformed GTP-U extensions.

> Thanks for taking that on. Given the cb/dst issues you described, I
> am inclined to drop NF_HOOK support from the initial mobile
> behaviors and add it in a follow-up patchset once your fix lands.
> The initial behaviors would then do a direct input -> output flow
> without the cb-context/finish-callback pattern, which avoids the
> issues entirely on day one and decouples this series from the
> pre-existing fix. Does that work for you, or would you prefer
> NF_HOOK to be present from the start and rebased on top of your fix?

Works for me. What matters is that the upcoming patches are well structured
so NF_HOOK can be wired in cleanly in the follow-up.

I am already working on the fix.

Thanks,
Andrea

P.S. I am temporarily writing from another address due to a mail
delivery issue at my @uniroma2.it address. Please always Cc my default
andrea.mayer@uniroma2.it address on replies.

