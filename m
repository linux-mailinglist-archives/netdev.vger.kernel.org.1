Return-Path: <netdev+bounces-304266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FOZvJq/BRmqXdAsAu9opvQ
	(envelope-from <netdev+bounces-304266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 954DE6FC9EA
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:53:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HBBriLnE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304266-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304266-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB7F13001395
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 19:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8366D38D3F0;
	Thu,  2 Jul 2026 19:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E337701C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 19:53:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021992; cv=none; b=YuhqJb4UD8OyQ0LXOAm86ZP2erdKil4MkKqxE6iLi2m2XM9e8CwS+4yHWzk9Nu0CeQ6a8hYLeIQQT/P/ufRGnBLTUKOEJu0x1x8bI7JVZwwpy0xsNZD1U9ADEzDWZLhtER/Dql8l41uqSVmEyHnIHfrGAfnWU155YSIDZ5CwTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021992; c=relaxed/simple;
	bh=4sRN0tqJaMlvPKLwU154Nu6Fl/Mv9iggbxlIUQLpZUs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FMq+IE5znTDY+Z5ZBJIiRFHtebKENafYCyKFUHq2bNTqSs5OWfNWsc+QHZuhTE97RiVECE1Fgy8+AaVLUbZVdY6K+jD1pNaEN/3ZeYXiVWL/Wc1BOGw+KcxkdY+p54NJmXegtHXrd1z4HrqZK42IrUeaYdiLwHfKOwLUvur5pPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBBriLnE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC681F00A3E;
	Thu,  2 Jul 2026 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783021991;
	bh=YU3Ef9vZAZ5bPbAe/5qkgVMcRQjIkVRmrPKIT9YlH/c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=HBBriLnEjCA02b1waiXn7RAY1uU+gFqoXdzNMc/e3K0GjQTPfvnynRAcSt4Iybe5C
	 d1IUXC0bN2D5U5cHFwdR6XD7B/L8Oo6GguSVj9pXfruEKPQF+mse9vBbEil+IijgnJ
	 76S2IgrK9d0HGHFxk9k2EekuXRB1dBPqn1oTdCt7ZgcixKK0579wURgObDbTI2ShP8
	 UFFJ5CVFS60RHykYS8PPpRtc5hTBZ94Ga39CEe+0VkaOMG7o/Iwkyh5KBpE3qu6KnZ
	 Qkp5o/8kBoIsvSGR/wEVRUEVvZpaOdXx3mXlFWKRXCU3wNrbvATEKC8R7MsMrmvDcZ
	 1/a/Gf/F4YGYw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C1D4F40069;
	Thu,  2 Jul 2026 15:53:09 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jul 2026 15:53:09 -0400
X-ME-Sender: <xms:pcFGak3Qy8sXpohY3azb15eBoiRk_lNwlczTtYXQIDQu9foglJ2BgQ>
    <xme:pcFGap6yd4uC1y_p3_74yZTd3jjMSkxdEef1xsg1nNB-xsGu6PB_p3t1XOUMl0Fe7
    B6tBuKW8DouklHg-EhKYioQzWEOCYiPqnDGEu9YfdsAdP-WEFjMQKQ>
X-ME-Proxy-Cause: dmFkZTGrQSzlgzpGXM2zqOTwKboKO9T+kdSgIcUV0rdoJDp/GnGgaXKZ9Bf5NxMs0O07JD
    j2Wq7tx6KwCVMOAWUBjE7njj4zl6vVk7IFCw1O+JHGjiDo2m6Ymgqdga0c/t1QXE5mWivA
    PdlXUKD6qffGNgXkOEFxrQu/0HY5uRLN1skjnXXvzmiMS6w6Dds8ZUczCY6Hb4yazXN2xb
    lhoa/M+iUNx6mbF+0klnFaCyvRvnQpg0i3vBTvDTsKZtAeKSfso970Bu/vWuDjoBfkxzh1
    pLKUTh56xtw81dEBmp5PLQCY42rLFPH7RWh155nFuziyUkVrW6mKE71FACF0SMYL5vxKDf
    f85KV/O/QKL8qzy+yFGkM7KAJKiWZCmPRihEP/O4ngcrqAuE8lcXnX1QuLriGuPChYjeky
    eJ6Td9C54F7X3A9jTS7vuujxh4zgIaVR/bsc69XcM2+Imwc7xGqwFL4toRb1BxpQUHCBSg
    t6hJ/8qDvITKaHKsWXgNA3i4XfOsSXLbvczcfze0wDr2S+7p4KmG4BR8in/C71LireAmzi
    5lcnburZP88KYw4xFvvQxHG9xZnF8zJSPWFdg3IQ6aQDULwoLT1T3xCnr2N04kiDYpuJIe
    gSH5gT/Vz3gvcR5hmUIhXFBKoYpcJ20oMAw5sHDQcb+KpD9nhAakG0Nf4jMw
X-ME-Proxy: <xmx:pcFGagKOjEhtFDBBh0H61jJojT7mBSd1Y-cyR8mZQxON3_QMVz1MuQ>
    <xmx:pcFGaqJgL0bcNSlQf-RhqrNLRR1geUzVyPn69Wbsag_r7W1RxERjNg>
    <xmx:pcFGanU_lCwMHbmcjyrTEFHxAb99kY3iqNgkGCtyO9s5vK0qtOd3Tg>
    <xmx:pcFGarkgtgJ777bP3tnr2FIKB4yihotWoGMYGYNkzLDb4g0W54cHBA>
    <xmx:pcFGall1QeQs8EuuP-qLDsC8Fegj1qfUXzbsCp-vW7jqktp8s-3a9s6V>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 63CB9780AB8; Thu,  2 Jul 2026 15:53:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZOB0wyakXwF
Date: Thu, 02 Jul 2026 15:52:49 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 davem@davemloft.net, edumazet@google.com, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, netdev@vger.kernel.org
Message-Id: <0a03d16e-d4ce-422d-9492-3e31d910d8e5@app.fastmail.com>
In-Reply-To: <akaoXcfamBp8_mYe@krikkit>
References: <20260630191551.875664-1-cel@kernel.org>
 <akaoXcfamBp8_mYe@krikkit>
Subject: Re: [PATCH net] net/tls: Consume empty data records in tls_sw_read_sock()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-304266-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,queasysnail.net:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 954DE6FC9EA



On Thu, Jul 2, 2026, at 2:05 PM, Sabrina Dubroca wrote:
> 2026-06-30, 15:15:51 -0400, Chuck Lever wrote:
>> A peer may send a zero-length TLS application_data record; TLS 1.3
>> explicitly permits these as a traffic-analysis countermeasure (RFC
>> 8446, Section 5.1). After decryption such a record has full_len ==
>> 0. tls_sw_read_sock() hands it to the read_actor, which has no
>> payload to consume and returns zero. The loop treats a zero return
>> as backpressure (used <= 0), requeues the skb at the head of
>> rx_list, and stops. rx_list is serviced head-first on the next
>> call, so the empty record is dequeued, fails the same way, and is
>> requeued again; every later record on the connection is blocked
>> behind it.
>> 
>> tls_sw_recvmsg() does not stall on this: a zero-length data record
>> copies nothing and falls through to consume_skb(). Mirror that in
>> the read_sock() path by recognizing an empty data record before
>> the actor runs, consuming it, and continuing.
>> 
>> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
>> Signed-off-by: Chuck Lever <cel@kernel.org>
>> ---
>>  net/tls/tls_sw.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
>
> I think tls_sw_splice_read() suffers from a similar issue (returning 0
> even though more data may be available). Sashiko agrees, and also
> found a few more pre-existing issues.

Do you want a v2 series with those issues addressed?


-- 
Chuck Lever

