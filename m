Return-Path: <netdev+bounces-298325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P7RIJkcPK2oM2AMAu9opvQ
	(envelope-from <netdev+bounces-298325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:40:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DFB674CD9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=etSC55gK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298325-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298325-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B801312BC16
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402E37B010;
	Thu, 11 Jun 2026 19:40:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A40376A0F;
	Thu, 11 Jun 2026 19:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206834; cv=none; b=ik5VyfC8jMoq1B+LjZrKCaQb0nm8r3cWWjOHudud7FFDXfw773j6TSkDK0aIWPRmuPhkt9ZGonG4e/3eWR0PjpJGNQOMG6jJMCEsvyls7qFwa3+M0fDDvsMI/OC36lkXEnise6W/VIZFRfSsK8qHxzLJvqqP2lu3yQq/kQmQRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206834; c=relaxed/simple;
	bh=U4Xj1hQqU/3M4nuoS+3S0SUI0tNKy4XUROHbzbDE9tA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FVUDnZ9gANtU8o+bqV3EvmA1j9rD8WsWVpw9Ou0aWDR3eOcqOv7qVGCDgcoR4mVBgu8qR/fjnZhZY4OMtoWe0ysgo5WJ0t2WPaCG3XZVqvNL5YiwSJoPeDxFSTePuLNP9gTHoxDGpnZ2QHFeup7MOGADs7+4tivIQyzHFahkM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etSC55gK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD701F000E9;
	Thu, 11 Jun 2026 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781206831;
	bh=U4Xj1hQqU/3M4nuoS+3S0SUI0tNKy4XUROHbzbDE9tA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=etSC55gKPX3QoSmuTW0MmDBogGaYjXiWndd8YvtlSdOrGUL6n2egruf3H9pHQz9Bl
	 Fr0BnYioyPB2rQQPqJrx8jmg7kYeyhELTIaiicB+H6yriHlPqPG/SzrwqduLW89o7U
	 XjMjHAE5Dxsgn2n3qzuPPoEkMKqlj+rkj/c55xX8SbZzlRiNIfe5JjYau2DN8Aluvi
	 76U/k13hBa7zSZ6Fqcg04+DWqkopBoIIdO6ACw2xTy6EFSnpnF843ZO955nGGRsRYI
	 Cz6kcw+TXZsVl2p5KboZBRrAlORrYJdnt/rO8vI1eux5pfEnYihz7s+Y8z1eTNDsiv
	 YbYE3T3SEkGtw==
Date: Thu, 11 Jun 2026 21:40:23 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Message-ID: <8d744049-65b7-4652-ae9f-a4a159fff56c@kernel.org>
In-Reply-To: <airt3_dPSfV54Aph@gandalf.schnuecks.de>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org> <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org> <airt3_dPSfV54Aph@gandalf.schnuecks.de>
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <8d744049-65b7-4652-ae9f-a4a159fff56c@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:gmbnomis@gmail.com,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298325-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04DFB674CD9

Hi Simon,

Thank you for you review.

11 Jun 2026 19:18:29 Simon Baatz <gmbnomis@gmail.com>:

> Hi Matt,
>
> On Fri, Jun 05, 2026 at 07:21:49PM +1000, Matthieu Baerts (NGI0) wrote:
>> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
>> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
>> this case, it is then not possible to send the address signal.
>>
>> The idea is to let MPTCP dropping the TCP-timestamps option for some
>> specific packets, to be able to send some specific pure ACK carrying >28
>> bytes of MPTCP options, like with this specific ADD_ADDR. A new
>> parameter is passed from tcp_established_options to the MPTCP side to
>> indicate if the TCP TS option is used, and if it should be dropped. The
>> next commit implements the part on MPTCP side, but split into two
>> patches to help TCP maintainers to identify the modifications on TCP
>> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
>> MPTCP sysctl knob.
>>
>> It is important to keep in mind that dropping the TCP timestamps option
>> for one packet of the connection could eventually disrupt some
>> middleboxes: even if it should be unlikely, they could drop the packet
>> or even block the connection. That's why this new feature will be
>> controlled by a sysctl knob.
>
> RFC 7323 (which obsoletes RFC 1323) specifies an "all or nothing"
> approach for the TS option.=C2=A0 Section 3.2 states:
>
> =C2=A0=C2=A0 Once TSopt has been successfully negotiated, that is both <S=
YN> and
> =C2=A0=C2=A0 <SYN,ACK> contain TSopt, the TSopt MUST be sent in every non=
-<RST>
> =C2=A0=C2=A0 segment for the duration of the connection, [...] If a
> =C2=A0=C2=A0 non-<RST> segment is received without a TSopt, a TCP SHOULD =
silently
> =C2=A0=C2=A0 drop the segment.
>
> So, selectively omitting the TS option on established subflows
> appears to go against RFC 7323 at the TCP level.=C2=A0 Do we consider tha=
t
> an acceptable deviation for MPTCP subflows?

Yes, to me, it is acceptable. Please note that here, TCP TS is only
dropped on some specific packets -- ADD_ADDR with v6 + port --
which are TCP pure ACK acking the same sequence as the previous
one (dupack from a TCP point of view). So it is just a signalling packet,
specific to MPTCP. If it is dropped by a middlebox, that's not nice, but
that's OK.

Or do you think something would break when this happens?

One last thing: sending an ADD_ADDR with v6 + port is certainly
specific to some use-cases, most connections will not do that.

> (Maybe I am missing something obvious here, but I couldn't find any
> prior discussion on this aspect.)

The discussions were on the MPTCP mailing list and bug tracker.

Cheers,
Matt


