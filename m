Return-Path: <netdev+bounces-278790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOUlNYud32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:15:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 408AA405318
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36BB230154AE
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140C3D349B;
	Wed, 15 Apr 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b="VGZe5tVt"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34EB35E92F;
	Wed, 15 Apr 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.75.2.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262536; cv=none; b=ju5m7cpj/8jur/oEGH2mGqNcLlc9HZSzrqxkgNWEL/Cpk+2fMlZjbsLLB+4WKLV8hllSwo3lNwKQAdubbZv97giA3fUdmqkBFlnozt2JtGmnVjzkyy4jlDgWEP+hV9/DCpy5m/V87l5x3/OQ9kZvnv7N6hyANLyHO44VzzYVk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262536; c=relaxed/simple;
	bh=UEUy1cSDA4TXrf+kflBFz8gXKNYKkue5yW6TUl0QfNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMhgqpz41ECnzNQu8IC4XRVKdcSkC+E+Cf7XKcJUt8ukDM12rkgOjINRBqZpq1J5zTlPT1Q9CeaV5rjWXqkaNzhKGmfGi0b1VD4Lvkwya9dpWB1Vp1IjlYG7W7LT89ySXuW+eU2qNpjrA6AHMC1Lp9N0XNl/xLC/x3MOrEV/EPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de; spf=pass smtp.mailfrom=ikt.uni-hannover.de; dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b=VGZe5tVt; arc=none smtp.client-ip=130.75.2.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikt.uni-hannover.de
Received: from [172.23.180.109] (gateway.ikt.uni-hannover.de [130.75.73.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id AF8761771;
	Wed, 15 Apr 2026 16:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-hannover.de;
	s=2024all; t=1776262525;
	bh=UEUy1cSDA4TXrf+kflBFz8gXKNYKkue5yW6TUl0QfNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VGZe5tVtWj6qoXZ7aMKf+C03Qk8QiyTmZHezkFZbz08ZQYTPTU03JLSJkgNWt9e1B
	 175keVj5pduXVHhfn8Pfxp0YqZBR5ZyeOzVvpWW85KAZ0X7btJ5ANsiGLBR+ltYQw/
	 fkmUKn93lzQTLJvOMZX4hejg+ZYDFd/9x939yoxbMcE70kJ2vHRYXCVTpJpd5GSc83
	 exZX6fKkpAsL11n/+YxJwH5+ktS1lsHoZ+gvhFRRDln/2si/Tn7qI9ZzfDte5MqFHl
	 1yw6lSbkz9G9hSPbcJU+nqP37YjeSDxMQwnxhfso8Bn2ztKneWqXxNxMddDIE8cFYj
	 vzJDvInc8g+bg==
Message-ID: <2b4d82b3-2142-4c1d-9267-acf80ef8e8d2@ikt.uni-hannover.de>
Date: Wed, 15 Apr 2026 16:15:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: Re: [PATCH,net-next] tcp: Add TCP ROCCET congestion control
 module.
To: Neal Cardwell <ncardwell@google.com>
Cc: Tim Fuechsel <t.fuechsel@gmx.de>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <adIUY2N6HOKZNzSJ@volt-roccet-vm>
 <CADVnQymmsispHew4-frsuBBfObZHdSbH+jfP-9aSW1HguK_N4A@mail.gmail.com>
 <1bce4c38-3bc3-4d59-bf36-6aa47c7a5c77@ikt.uni-hannover.de>
 <CADVnQy=+j3-Nkjn7hHax=GUcPrfJiM2iYbwgPa38aAZgL1BuQw@mail.gmail.com>
Content-Language: de-DE
From: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
In-Reply-To: <CADVnQy=+j3-Nkjn7hHax=GUcPrfJiM2iYbwgPa38aAZgL1BuQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.9 at mailout1n
X-Virus-Status: Clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uni-hannover.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uni-hannover.de:s=2024all];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278790-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[uni-hannover.de:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas.prause@ikt.uni-hannover.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ikt.uni-hannover.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 408AA405318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your quick reply!

>>> Please reference figures in the paper and mention specific concrete
>>> numerical examples of latency reductions to quantify these statements.
>> Figures 5 and 6 show the performance of ROCCET in stationary and mobile
>> scenarios (https://arxiv.org/pdf/2510.25281). In the analyzed scenario,
>> we have observed a lower sRTT with ROCCET than with BBRv3 and CUBIC. The
>> observed throughput was marginally lower than that of BBRv3, but still
>> on a similar level. A detailed quantitative evaluation can be found in
>> the paper in sections VI and VII.
> In https://arxiv.org/pdf/2510.25281 zooming into the Figure 6 sRTT
> box-and-whisker-plot seems to show that BBRv3 actually has a lower
> median sRTT value than ROCCET. So that statement seems misleading?
>
> I would recommend using numerical examples in the commit message to
> quantify the gains from ROCCET and avoid potential issues from visual
> interpretation of graphs.
Thanks for pointing this out. We created new figures that include the
numerical values for Figures 5 [1] and 6 [2]. In Figure 5, i.e., our
stationary measurements, it can be seen that ROCCET obtains lower sRTTs
while maintaining a similar throughput to BBRv3. In Figure 6, i.e., our
mobile measurements, ROCCET and BBRv3 have an overall similar performance.
We will adjust this statement.
[1] https://seafile.cloud.uni-hannover.de/f/cc39263dad6b45ca9952/
[2] https://seafile.cloud.uni-hannover.de/f/9556ec768c084fe2ae40/

>>> Can you please elaborate on this statement here? AFAICT from figures 7
>>> and 8 in https://arxiv.org/pdf/2510.25281 it seems ROCCET is
>>> essentially starved by CUBIC when sharing a bottleneck with CUBIC when
>>> the bottleneck has 2*BDP or more of buffering. AFAICT it sounds like
>>> ROCCET does have "fairness issues when sharing a link with TCP CUBIC"?
>> Our main use case is a connection where the bottleneck link is in the
>> cellular network, where the bottleneck queue is typically not shared
>> between flows. "Fairness" between flows is being implemented by the base
>> station's scheduler. In this scenario, ROCCET achieves its objective to
>> not "bloat" its own queue.
>>
>> We have performed additional fairness experiments in non-cellular
>> networks (figures 7 and 8). Here we show that even when used in other
>> types of networks, ROCCET does not cause harm (see
>> https://dl.acm.org/doi/10.1145/3365609.3365855) to other congestion
control.
> I do not see you objecting to my statement, "it seems ROCCET is
> essentially starved by CUBIC when sharing a bottleneck with CUBIC when
> the bottleneck has 2*BDP or more of buffering." So I guess you agree.
>
> IMHO it's important to keep in mind that a congestion control that
> starves in the presence of CUBIC may have limited deployment. This is
> a key reason why Vegas was never deployed at scale.
We see the main use case for deploying ROCCET in cellular networks, but
we agree that in other types of networks, it might be starved by other
congestion control. We argue that this makes ROCCET different from
Vegas, in that there is a specific environment where its deployment can
be advantageous.

>>> Please specify what side effect or side effects ROCCET is claiming to
>>> solve (presumably bufferbloat?).
>> The side effect we observe in cellular networks is that, in particular,
>> for loss-based congestion control, the cwnd often gets 'frozen' at a
>> size that is too large for the BDP of the current link. This effect is
>> caused by the TCP cwnd validation, which at some point stops increasing
>> the cwnd because it assumes that the sender is application-limited.
>> However, this often leads to a cwnd size that is too large for the link,
>> but too small to cause a congestion event by overfilling the buffer. The
>> result is a standing queue that causes permanently high RTTs. Figure 2
>> in the paper (https://arxiv.org/pdf/2510.25281) shows the described
>> behaviour for a single TCP CUBIC flow.
> OK, so that sounds like you are describing the standard bufferbloat
> problem. So you could replace the phrase "solves an unwanted side
> effects of CUBIC’s implementation"  in your comment with something
> like: "avoids the bufferbloat problems inherent in CUBIC."
With this statement, we wanted to describe the specific mechanism in the
TCP CUBIC implementation that can lead to bufferbloat, particularly in
cellular networks. But you are right, the result of this mechanism is
still the standard bufferbloat problem.

Thanks,
Lukas

