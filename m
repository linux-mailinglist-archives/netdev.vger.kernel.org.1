Return-Path: <netdev+bounces-288652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMRkCjOcCGoGxwMAu9opvQ
	(envelope-from <netdev+bounces-288652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 18:32:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29755C9F8
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 18:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93B783006469
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CCB3E3D99;
	Sat, 16 May 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="o7bu4ttN";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Ryku/9CD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474F405C4D;
	Sat, 16 May 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949167; cv=none; b=RYdaf6Kgfv6d7jTfE8t34j2RRDLNPb1L7/H5TQiX9kC6nTWUVINEQfup4l2zvO6IcZi8uor/YUWwHy9bkM5s4o66mMZ88iTmjHFDiLrHhHshqHQnrGaW6dJSsTM0D7yzLuA3Oq95OvEzSI21kPHh1tQUrjHZ4H6MD8HIvCv1dMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949167; c=relaxed/simple;
	bh=PWRlz0bAYGNEss5NAODwa78EZdoYB4GvTMaDda35irc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D4+j2XOkfbGEbo5LalsbH7QWlqUy3VdrA8svKshZ0kY5HZk2ovwHC9lBlGREq8/kcKVjxejHyqdY5rmkmObV5+TcDzgpQoHtWBevQ5W/B8/JkGcVPK/zUuIF3LzNnu3VBBp4DFHHN1QW9WOXtTA4kFWduxUbHEaJa2N3FRiKH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=o7bu4ttN; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Ryku/9CD; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 64GGQ0f7022595;
	Sat, 16 May 2026 18:26:06 +0200
Received: from lubuntu-18.04 (host-95-246-236-184.retail.telecomitalia.it [95.246.236.184])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id DBF44122901;
	Sat, 16 May 2026 18:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1778948757; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTO1RAu7euvHtj4HzoctoToKt9Ch9IUKUgMEEx4QzpQ=;
	b=o7bu4ttNt52bH3A6pny5FyhRyrFs+Yn4MFCg9/fTZe27XN9jDx6O3FxJhA41tQo+R2DyA8
	dM+TGYj7SRzLH2BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1778948757; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTO1RAu7euvHtj4HzoctoToKt9Ch9IUKUgMEEx4QzpQ=;
	b=Ryku/9CDDmWB/aFrWWfQ0ClbLjlvV00F9zcAwNDPa1czzXWpj3zwoMx3F1aDO8Xenp/dSx
	XUsOri3sl7ZMaX+CBY5BBPIlYxp0dSUZ1UIpXy8UUDGD1jpCE1+nVuI0OULcAOtQ2tOGAm
	KZp7ERlmvcMGi6CP9UexUuOguskVP2274Y9d135F7XZ6YIAUClGgyzS5JYGsn/LrTd8Yh7
	EMMPE3MhF4VbQKSK2SYn42ZIVDDs7gw5FhXEVNu63znQLgAS4Sotnn1hQX9E9KzmMhJ41V
	xTaU65EK+l+ZKGk3gbqtRzEl3FMR9Q8KyXPUmcoyOZvvJY1kBu2zvnGuN/ykIQ==
Date: Sat, 16 May 2026 18:25:56 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Justin Iurman
 <justin.iurman@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, stefano.salsano@uniroma2.it,
        ahabdels@cisco.com, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433)
 behaviors
Message-Id: <20260516182556.66af27a9c63208435911990b@uniroma2.it>
In-Reply-To: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Rspamd-Queue-Id: AA29755C9F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288652-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,uniroma2.it,cisco.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uniroma2.it:mid,uniroma2.it:dkim,end.map:url,end.limit:url]
X-Rspamd-Action: no action

On Tue, 05 May 2026 01:30:10 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

Thanks for the work. Some comments on the overall design below. I will
reply on the individual patches separately.

> This series adds the in-kernel data path for the SRv6 Mobile User
> Plane (MUP) architecture defined in RFC 9433.  SRv6 MUP integrates
> GTP-U mobile traffic into an SRv6 transport domain by mapping the
> 5-tuple (TEID, QFI, R, U, PDU Session ID) into a single SID, allowing
> operators to replace the GTP-U overlay between the gNB and the
> upstream UPF with native SRv6 forwarding while keeping the radio side
> unchanged.
>
> The series implements the six MUP behaviors that an SRv6 MUP gateway
> typically needs:
>
>   End.MAP         (RFC 9433 Section 6.2) -- swap DA with the next SID
>                                             without consuming the SRH
>   End.M.GTP6.D    (Section 6.3) -- IPv6/GTP-U to SRv6 headend encap
>   End.M.GTP6.D.Di (Section 6.4) -- drop-in mode variant of the above
>                                    (preserves the original outer DA at
>                                    SRH[0] and discards TEID/QFI)
>   End.M.GTP6.E    (Section 6.5) -- SRv6 to IPv6/GTP-U egress encap
>   End.M.GTP4.E    (Section 6.6) -- SRv6 to IPv4/GTP-U egress encap
>   H.M.GTP4.D      (Section 6.7) -- IPv4/GTP-U to SRv6 headend encap

RFC 9433 Section 6 is titled "SRv6 Segment Endpoint Mobility Behaviors",
but Section 6.7 defines H.M.GTP4.D as "SR Policy Headend with tunnel
decapsulation and map to an SRv6 policy". This behavior receives IPv4
packets and is not bound to any SID, so it does not fit the endpoint
model that seg6_local implements. Placing it there required relaxing the
ETH_P_IPV6 guard to accept ETH_P_IP and adding input_family to
seg6_action_desc, for a single behavior that does not share the endpoint
model.

seg6_local is not the natural place for this behavior. The UAPI cannot
be undone once merged, so where it should live needs discussion on the
list before we proceed.

>
> End.Limit (RFC 9433 Section 6.8) is intentionally out of scope.

>
> All behaviors plug into the existing seg6_local lwtunnel framework, so
> they are configurable through the standard "ip route ... encap
> seg6local action ..." interface.

This adds ~2.2k lines to seg6_local.c, bringing it from ~2.7k to ~5k
lines. The behaviors reuse the existing seg6_local infrastructure (SRH
validation, seg6_do_srh_encap, seg6_lookup_nexthop), while the GTP-U
parsing, encapsulation, and PDU Session handling, for example, is new
and self-contained. Given the volume, moving the MUP code into a
separate seg6_mobile.c (say CONFIG_IPV6_SEG6_MUP) would keep seg6_local
focused on the RFC 8986 endpoint framework. There are trade-offs
either way and I think this deserves discussion on the list.

There is significant duplication across the introduced behaviors: for
example the GTP-U parsing, inner protocol dispatch, and NF_HOOK plumbing
are nearly identical each time, and the small differences are already
hiding issues (HMAC validation missing in some, malformed SRH silently
accepted in others, wrong drop reasons). Some of the individual
functions are also well over 100 lines. Splitting them with helpers
would help.
The new code also has some style drift from seg6_local.c (variable
declaration ordering, scope blocks, blank lines) that should be fixed.

I think this patchset should be broken into smaller patchsets, one per
behavior, each with the behavior, its selftest, and any needed helpers as
separate patches. The same approach was used for End.DT4/End.DT6 and
End.DT46. End.M.GTP4.E alone is ~1.2k lines in a single diff.

> No new netlink families are
> introduced -- the new SEG6_LOCAL_MOBILE_* attributes extend
> SEG6_LOCAL_MAX in an add-only way, and the new SEG6_LOCAL_ACTION_*
> values are appended.

The attribute layout and semantics are probably the most sensitive part
of the series and need to be settled before it can go in, since the UAPI
cannot be changed once merged.

The series reuses SEG6_LOCAL_NH6, SEG6_LOCAL_SRH and SEG6_LOCAL_OIF with
semantics that differ from the existing behaviors. NH6 today means
next-hop in End.X/DX6. This series reuses it as DA replacement in
End.MAP and as prefix template in H.M.GTP4.D.
SRH is inserted verbatim in End.B6/B6.Encaps but augmented per-packet in
the mobile behaviors. These attributes have established UAPI semantics
from their existing behaviors. Giving them a different meaning in new
behaviors is a UAPI semantic divergence.

The selftests use OIF on all five GTP behaviors to select a VRF for the
lookup, but that is what TABLE and VRFTABLE are for (End.DT4, End.DT6).
OIF in the existing behaviors means output interface (End.X) or L2
egress device (End.DX2). VRF support is a nice-to-have that can be added
later as a separate optional attribute.

>
> The egress behaviors (End.M.GTP4.E and End.M.GTP6.E) accept an
> optional per-route pdu_type attribute that is the sole control
> for inserting the GTP-U PDU Session Container (3GPP TS 38.415 Section
> 5.5.2).  When pdu_type is set (dl/ul/0..15), every emitted GTP-U
> packet carries the container with that PDU Type and the QFI extracted
> from Args.Mob.Session.  When pdu_type is unset, the egress emits
> a short GTPv1-U header with no container.  pdu_type must be
> configured on egress routes serving 5G N3 traffic; omitting it is
> intended only for LTE-only / S1-U-style deployments where no PDU
> Session Container is exchanged.
>
> The matching iproute2 patch series has been posted to iproute2-next:
> https://lore.kernel.org/netdev/20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com/

The user-facing parameter names and their semantics are defined in the
iproute2 series (where the man page lives), so that is probably the
better place to discuss keyword choices and attribute naming.

> [snip]
>  include/net/dropreason-core.h                      |   40 +

The series introduces six mobile-specific drop reasons. Drop reasons are
visible to userspace via the kfree_skb tracepoint (perf, bpftrace,
dropwatch), so they look like a kind of interface and their names should
match the actual failure.

BAD_SID and BAD_GTPU make sense as mobile-specific reasons. The other
four have issues: NOMEM and MTU_EXCEEDED duplicate existing generic
reasons (NOMEM and PKT_TOO_BIG). INVALID_SRH_SL is used for multiple SRH
validation failures, not just Segments Left (HMAC failure is also
reported as INVALID_SRH_SL). BAD_INNER is used as a catch-all for outer
header pull failures and encapsulation errors, neither of which involves
the inner payload.

We could think about a prep patch introducing SRv6-level drop reasons
(SEG6_INVALID_SRH, SEG6_HMAC, etc.) that both the existing behaviors and
the MUP ones can share.

> [snip]
>  .../selftests/net/srv6_end_m_gtp4_e_test.sh        |  486 ++++
>  .../selftests/net/srv6_end_m_gtp6_d_di_test.sh     |  427 ++++
>  .../selftests/net/srv6_end_m_gtp6_d_test.sh        |  497 ++++
>  .../selftests/net/srv6_end_m_gtp6_e_test.sh        |  402 +++
>  tools/testing/selftests/net/srv6_end_map_test.sh   |  103 +
>  .../testing/selftests/net/srv6_h_m_gtp4_d_test.sh  |  487 ++++

Selftests for the five GTP behaviors heavily depend on python3 and scapy
heredocs embedded in the shell scripts for packet construction and
validation, which adds an external runtime dependency. A statically
compiled C helper would remove it and avoid embedding python heredocs
in shell scripts.
A few cases worth covering: SRH and no-SRH input paths where the
behavior accepts both, missing SRH where the behavior requires
it, malformed SRH, and invalid attribute values.

The five GTP behaviors pass per-packet context to a finish callback through
skb->cb, and recover the lwtstate via skb_dst(skb)->lwtstate.
When nf_hooks_lwtunnel is enabled, an NF_HOOK sits between the input
handler and the finish callback. Netfilter processing at this hook can then
corrupt the cb (IPCB/IP6CB aliases skb->cb) or drop/replace the skb dst, so
the finish callback dereferences a NULL or unrelated dst.
Even if the dst is preserved, the cb may have been modified.

The dst problem is pre-existing from 7a3f5b0de364 ("netfilter: add
netfilter hooks to SRv6 data plane") and affects seg6_iptunnel too. Both
issues need a robust fix before this series can go in. I want to look at
this myself and will Cc you when I do, as the five new behaviors may need
to be adjusted on top.

> [snip]

> Best regards,
> --
> Yuya Kusakabe <yuya.kusakabe@gmail.com>

Ciao,
Andrea

