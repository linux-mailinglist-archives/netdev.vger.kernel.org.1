Return-Path: <netdev+bounces-299633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mrW7DNV6MGpqTgUAu9opvQ
	(envelope-from <netdev+bounces-299633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:21:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1768A581
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:21:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="R fQt3rO";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=aYlMd4pz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299633-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299633-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49B9E30C2AC4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107C3B776E;
	Mon, 15 Jun 2026 22:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1F2E424F;
	Mon, 15 Jun 2026 22:20:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562032; cv=none; b=FaxD6qjHmWYR4bBW+Zczr6Ygt3MC/aPG+42RYvHbIYdO16vINRdglOrLFPhITENBhJIU/oLcERbWf6P3uX45ch/VXaQMr02YYOgY50Q4tpr5jFv2GsovfrjHX5uJif6qDGZTRrsKku4/glUJoLxDuCbrQMCzBBSZtu3GMdn6zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562032; c=relaxed/simple;
	bh=MAgoF0GVfeHrwck+0R9JsdxcWGF3xDXMf6iJ4q5ye7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDqMwvspt/umNXMqOT24esKgFa5d5OX0cLyde+FEbZUBpI/Mq/DRjEMPEv9hC45GG1TVCYA1WzOPhfgU2W+hF0scJbBWlT9nWlqiTDlPGBNSrDa1xqOod7cXIwbQiYmKJ3kbvPUdXrquqRZkLOM0bnJLBDheBL8NGfVPHoyUWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RfQt3rOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aYlMd4pz; arc=none smtp.client-ip=103.168.172.145
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FC7FEC0187;
	Mon, 15 Jun 2026 18:20:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Jun 2026 18:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781562029; x=
	1781648429; bh=b1PFnsUgRaLHFda7C6QAgcMr/WZozGHAvkozYIIaKgI=; b=R
	fQt3rOcmrCAknmuBI1oIK+wh91RGzwoElu0VWJlp8fyqY9NDxMWSTGdTtH1LfhKn
	ysSAom6x6msctd5hb155I0sjPZl9WlnVfll7ZWHXi1vLDmZbBp5zldz3LkXA17Ug
	odY8J+EYoVq4cAz3wc++VmUc3ZC1W9lvKrej1f9evoNGuxbKOxsu9o4wR/oRgsL/
	T/dWhNCQ++cqh1pHxwO/e1+vtWNaUvD+FSrxok0swTQH/ztCJnCG7Ykap+7RlwOf
	Z7UH51MUWsSz/7bhKZe3ZZcYgqVDJT7nr3k27ze2VOMhJu6joM7W5zEVfwhIGptr
	5MPFUb4HpvTdM7I0C4wyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781562029; x=1781648429; bh=b1PFnsUgRaLHFda7C6QAgcMr/WZozGHAvko
	zYIIaKgI=; b=aYlMd4pzKcK8Qc68sc2agXlH6h5wDqn35W/Qy+4mrK53O3u871j
	vTdD5GgZRGoZk1KPf559eaz2gtNvp7NBXzOel0O7tWmCs8eUmBT3OwHU/G3KcNdK
	FYahu9T6VQv2iOJiuHieHl+ZPnRmu+168PlqxWNBmPz90zl1j6rq0iAQnBRstGaP
	oa5iM3MZGca5wKppgMO01qQBd9R9M39NS/0GxMvatAF808fEZNHc9OIXQvw7K/Ro
	NoZk4fYAsow3ctaHucEv2PDoTf9KAlk4VZ9XeXwhnH2WlUwr5SN513AS0brRIocV
	j6hNgPjUcyp3sHAFk+6Ulufrwn0p9nftiNg==
X-ME-Sender: <xms:rHowaoHusOpOzptfZbXKrc3Uh0NOt8YmFH7BhGCrOlbRYmyC_MYXxA>
    <xme:rHowakZ0_tDcJ93Mla-n208LnRFAmgogPqt7erZAqzn0hEOYiIq73uGV4mMgNn3nA
    6_YTiqbK30TwDlJ3_mqHuwIKSq48CUYtqPHFAaE9rxz6RCKGiUv5gk>
X-ME-Received: <xmr:rHowasw9dNmRgEn7JFK6_Imk2QJF_4ZjQG1iDMIqw6paY8yaZf1pQFmY_Sehe0xM-s-ldh7jlNEgk7GJKrpcI-A>
X-ME-Proxy-Cause: dmFkZTFflWFTg5W6e891k+laAd9uEF8YgaM1qzCarsez+ZDzoDBnwbW64wZZ9indZ+we5c
    yOcWmrsILi7ZO87B6ZNANarpDv4BCukX1+bZUEUVYSgHusUmFKeeO+6Y/4UFH2vEGWjFJG
    kuIwvzXTMAcEvs361XXlVu7C3LSRZ3YpnVu+iE9u6SbZUjxWP6CGRm6dnCNlHJLvXKMeqH
    EVRCDLrOR5tAD2FublBoKRL6yVkWM1iTvBcTg2ZdYfqAu/TfOcSJO9BamLkzE6jzU4t6xi
    FV5ulDePpSKge+6SQUG2FXHnILZD8xM3VXuFZT6+zg+ABUAuy4UgTlgedCru7JISaISHqy
    6h8WkOLYHn0IfF1q7AtcNQ8GD1ckT4uLL35iX5Hwtl05AT2ASitS8hyfouUuevpB/Ue8li
    QlGinpgCiutucyM21F0MVU3tguc2koZDOebVgE7WFV9RZt/V4mDmXGCH+hESP56XLlvEN6
    LMMpPSYVDPXL1ROx2KQKiIDIgF5kk/Z3AqARXoTMCKqrbb+xA/TzicA4aQ6M51O2XMcX53
    GSLBmQ5YXJ6x6XNjvb/13HlkrtKRG+rFDGx0cqXj+caMzlw0SIhF8CD2VEhnTNOCoaOv/Q
    DgWrNR4QGjxWfHUPQKHGJ9eGwoc836Gkhi5pQlgxH5iOrIq8nTtEtKM55JWw
X-ME-Proxy: <xmx:rHowamQPFr_oWlMiPlo5hRUWtizuywpm-7OHqVqc18DYtOOERXlXhQ>
    <xmx:rHowapLOKKqlTnSpL6NcjcMwIvccVQ2_d0rmQfcr1FDqaiWkiNmaiw>
    <xmx:rHowatUwAepy5121MgCoe_T47NbFJ8PbET5jazYf80Mk4hcL-MHaSQ>
    <xmx:rHowatTqN_h9yk5G-PMsuH_eOwRhMlRKx4pDNstsX1juFrckhGu96g>
    <xmx:rXowahQ0bmw-5LW60vO1VMocdjNoREmls4OSxEus5vOH2Jerlg8Y0kRO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 18:20:28 -0400 (EDT)
Date: Tue, 16 Jun 2026 00:20:26 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com
Subject: Re: [PATCH net-next 2/5] tls: remove dead sockmap (psock) handling
 from the SW path
Message-ID: <ajB6qqoeVGz1ab_S@krikkit>
References: <20260614014102.461064-1-kuba@kernel.org>
 <20260614014102.461064-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260614014102.461064-3-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,cloudflare.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ED1768A581

2026-06-13, 18:40:57 -0700, Jakub Kicinski wrote:
> TLS and sockmap are now mutually exclusive. Try to delete the code
> from sendmsg and recvmsg path which is now obviously dead.
> 
> The main goal is to delete enough code for AI security scanners
> to no longer bother us with sockmap related bugs. At the same
> time retain the code in case someone has the cycles to fix
> all of this and make the integration work, again.
> 
> If the integration does not get restored we can wipe the rest
> of the skmsg code from TLS in two or three releases.
> 
> The changes on the Tx side are deeper since that's where most
> of the bugs are, Rx side simply takes the data from sockmap
> and gives it to the user. On Tx split record handling and
> rolling back the iterator were the two problem areas.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/skmsg.h |   9 -
>  net/core/skmsg.c      |  52 +-----
>  net/tls/tls_main.c    |   8 +-
>  net/tls/tls_sw.c      | 399 +++---------------------------------------
>  4 files changed, 31 insertions(+), 437 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>


> @@ -2417,7 +2088,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  		} else {
>  			struct tls_decrypt_arg darg;
>  
> -			err = tls_rx_rec_wait(sk, NULL, true, released, !!copied);
> +			err = tls_rx_rec_wait(sk, true, released, !!copied);

nit: There's also a leftover sk_psock_get in that function. We can
clean it up later, let's get this series in.

-- 
Sabrina

