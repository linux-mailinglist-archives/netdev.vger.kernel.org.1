Return-Path: <netdev+bounces-271252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLH1OfXhwmmPnAQAu9opvQ
	(envelope-from <netdev+bounces-271252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:11:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3515E31B43F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6C730210C2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288938AC60;
	Tue, 24 Mar 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTFmjFP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2426CE2D
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379242; cv=none; b=e/cDa1laLdt0SFkYUVHdbAXcMOYjJMkCulHqyJiQDd4Zq/MHodt7nD28DgvhNWGiXwaVNdJIqQ71lWVI92qQZyfTpz8OR01rFCobT1K63GwrsPcZAsISdJQU7N8/CQUocruGk/TpKP3xggvKe6l8JX+P/8E5AI6a/SsXkAibz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379242; c=relaxed/simple;
	bh=K66xp1mThxZBb716Y4QF9sTnen6rnGdVq5eWC4X7axM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uaJZjtBlqHhgBaURI5rMa7FDPBakiRfvoLqKg3x1Z9kGXOdlcgr8QQDFKZ4fBwQhofNbEZptKN9WMoe9Xa5x6peLpX9aj9w3iGqnOI/2PvEmBVxBEcxZ9JNTbMG/cYNYi86WmpYnHKL2w7J4MKViQn/Bjz2WlzZFU1vDB4GVqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTFmjFP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4094C2BC9E;
	Tue, 24 Mar 2026 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379242;
	bh=K66xp1mThxZBb716Y4QF9sTnen6rnGdVq5eWC4X7axM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CTFmjFP/I0iSCaqQWt92FcXRCROgJ+OmJVfUm/V+hpnV1L3hnDcq5l04fFaKkeW+y
	 TnrOj7vmiVrfC1wa2y1N1fgHws8DV5Seduh9Tna9bbrQW6D3Kr1CBdSdkg77/ANKrl
	 4RueH7i02bnkYrf4SjKItQ2Z9y1ADVmXDuu11YcePg2qPH9K5YirwsIDA7mVFnTVFR
	 9URkgtzweB2j5i1KpgWnEZ5WV+Faod55hY2C5KyvWL21L0rcWd1x/227sE6Rd2PnUP
	 my2USfER+3wNDhoIC9qGGAYA9za4O9frUX0NjBJMEThmfhSqBdsY6s8uEq03tTGlug
	 JHLhESkAiia0w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C4684F4006F;
	Tue, 24 Mar 2026 15:07:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 24 Mar 2026 15:07:20 -0400
X-ME-Sender: <xms:6ODCacP0j8AKPpVCkBiDSSQRrW3oCjZUS1YRquho04etOHmE0aINyw>
    <xme:6ODCadw8hexXFM4VO2jsXOGdzXAZC7s9stJKT7TUoirr8CXuvDNtIKpUZCIWpRLZO
    N3m0T0XXzpr4MJ8IXz8Ksy6MRLNZ3mgm_0Jvs9mq01T9iaaCPEij70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdq
    hhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthh
    hutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsugesqhhuvggr
    shihshhnrghilhdrnhgvthdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6ODCaV1rWb9z1kUfCuPpnsu1Afq8EXIfOmA0nY2mNQNBbs2Bn5RLNw>
    <xmx:6ODCaWKkkcGr-rD7tcNqxMjOrh8rimeIE7Lv_HcHvK9K6eGqdqjNVQ>
    <xmx:6ODCaVxl5T7CNolBg22Pw-Y9NkyL_Z_fy4u8aXxpRqSPSKKMO4F38w>
    <xmx:6ODCaUXL9afrgqmVn_Pd6zT2FV5qFgi4aW8VRxdiMdU720XvtR4knA>
    <xmx:6ODCaVhIcCWO9UKWFVlQe_1rgwjbtNWXlLpXZnmrA4vtsIsanoKUMcXd>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D073780070; Tue, 24 Mar 2026 15:07:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJdrMbW-WYaB
Date: Tue, 24 Mar 2026 15:07:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>
Message-Id: <66157d87-2cb8-4cd7-b8cd-1e2086825995@app.fastmail.com>
In-Reply-To: <acK5Qj-F0wGFLUhj@krikkit>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
 <20260324-tls-read-sock-v5-6-5408befe5774@oracle.com>
 <acK5Qj-F0wGFLUhj@krikkit>
Subject: Re: [PATCH net-next v5 6/6] tls: Flush backlog before waiting for a new record
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271252-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3515E31B43F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Mar 24, 2026, at 12:18 PM, Sabrina Dubroca wrote:
> 2026-03-24, 08:53:28 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> While lock_sock is held, incoming TCP segments land on
>> sk->sk_backlog rather than sk->sk_receive_queue.
>> tls_rx_rec_wait() inspects only sk_receive_queue, so
>> backlog data remains invisible. For non-blocking callers
>> (read_sock, and recvmsg or splice_read with MSG_DONTWAIT)
>> this causes a spurious -EAGAIN. For blocking callers it
>> forces an unnecessary sleep/wakeup cycle.
>> 
>> Flush the backlog inside tls_rx_rec_wait() before checking
>> sk_receive_queue so the strparser can parse newly-arrived
>> segments immediately.
>> 
>> Fixes: 20ffc7adf53a ("net/tls: missing received data after fast remote close")
>
> How did you pick that Fixes tag? That commit mentions FIN/connection
> closing, which doesn't seem related to the local backlog.

20ffc7adf53a introduced the sk_receive_queue check inside the
wait loop (then called tls_wait_data(), later refactored into
tls_rx_rec_wait()).

When lock_sock is held, incoming TCP will segments land on
sk->sk_backlog, not sk->sk_receive_queue. The sk_receive_queue
check introduced by 20ffc7adf53a doesn't see backlog data.


>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 8fb2f2a93846..84c4ae0330d1 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -1372,6 +1372,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>>  		if (ret < 0)
>>  			return ret;
>>  
>> +		sk_flush_backlog(sk);
>
> Do we need to update released when this returns true, like callers of
> tls_read_flush_backlog() do?

Good catch. v6 will do that.


> I also wonder if we'd want to update the
> caller's flushed_at to avoid bypassing the "smart checks" in
> tls_read_flush_backlog().

The flush in tls_rx_rec_wait() only fires when the loop finds
no ready message, which is the cold path. The redundant flush
from tls_read_flush_backlog() on the next iteration is wasteful
but harmless. I'm not sure the additional complexity would be
worth it, but if you believe it will add some value, let me
know and I will add it.


>>  		if (!skb_queue_empty(&sk->sk_receive_queue)) {
>>  			/* Defer notification to the exit point;
>>  			 * this thread will consume the record
>
> -- 
> Sabrina

-- 
Chuck Lever

