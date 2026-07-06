Return-Path: <netdev+bounces-304960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hedDBoScS2q4WwEAu9opvQ
	(envelope-from <netdev+bounces-304960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3484B710618
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:16:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304960-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304960-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092EA39735B2
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E153815CF;
	Mon,  6 Jul 2026 10:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7233F582;
	Mon,  6 Jul 2026 10:11:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332704; cv=none; b=VDESHk7jpURQihjTvV8QpQftf0ntCETGvF3gwGHIXodg2cXNKxye2ipClbqfLK2IOsdXl4gDdDqkC9qkCowBDUCIUXzv2S7JmEj8E/5rj5IQY799x133d3c3rJfO4+yGzYyqsf6acWV75Ar14+eQuEuW4ov1F2L5bVyaDPOT8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332704; c=relaxed/simple;
	bh=MBzYfn6wrT/moznkuon8LGgRLOwNEgezeJ/ZvYxKR6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv/Ya2K3VH/pYQnqAFe1gOES49fbCu9BaE15OCIxiS0oHMF5afoveFxdntk/XX9CGtuBlknUDJHBfQS2i/ncDnMfr+p5TEQYJPaB7N9wdsi/E6P/0Zsoq9dRGVJ+tEafPw4u2V8dMkFBGLGzZ13hO366BYxA4RWAU8EHikySyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Date: Mon, 6 Jul 2026 12:11:15 +0200
From: Brett A C Sheffield <bacs@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304960-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[librecast.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,librecast.net:from_mime,librecast.net:url,librecast.net:email,karahi.librecast.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3484B710618

On 2026-07-06 11:42, Simon Schippers wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
> when a qdisc is present") did not show a relevant performance regression
> in my testing but on Brett Sheffield's librecast testbed it shows a
> significant performance drop in a IPv6 multicast testcase. The regression
> can be pinpointed when multiple iperf3 UDP threads are sending. For 8
> threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
> the reason why this patch makes the qdisc backpressure behavior opt-in.

Your v1 commit message was correct.  The iperf3 tests were TCP, not UDP.

The original failing test that alerted me to the problem was IPv6 multicast
(UDP), but the reproducer tests I provided stats for in the regression report
were TCP "To eliminate my code and any multicast weirdness" and also to verify
that this also affected TCP.

Sorry for the confusion. The command lines used are in the regression report.

I've tested the v2 patch (with IPv6 multicast), and verified the
previously failing test passes.

Tested-by: Brett A C Sheffield <bacs@librecast.net>

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

