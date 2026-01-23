Return-Path: <netdev+bounces-252886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MtwFmmnc2lnxwAAu9opvQ
	(envelope-from <netdev+bounces-252886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:52:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E440478A72
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4D22301E7E3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55A2E3B15;
	Fri, 23 Jan 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="G2/GY7mB"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3A285CBA
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187170; cv=none; b=rcIwdMR6sxicV+92QgiWlmox5ZUCMkouTS2hyOjljCUnijMBOWm7vYJKt2zgRK9/nchT2ZpT4zp5QFUl4drPjDDJk6WM8yuSoPMl10ArZTBZNhqsF1LJQkkhfsImYtT/DACerFeEGWMlaojlaQegzmqKv2b1WJzZkl7zYWwUoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187170; c=relaxed/simple;
	bh=podR4pzaAzcDb+GKwYY8v8JRh+vX6rU2JggSnBIxc7g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UlC1b12avXAtU3vYDj8ZTM+SxrELAst6o7V1ZYCkvJd53iWry/MrW47TvatKkEo4XbORU5WRB8RwzVwryHy7NurZVbC7kpRk694lAwvo234AqHoSp8xOmpPt91rDFCtp9TokclcGzS0s36RHN7Vs72d6ykZ+oRfburAitMAdtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=G2/GY7mB; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vjKOm-00F4mh-C7; Fri, 23 Jan 2026 17:52:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Dfuf1H7CdP7qwJBc1Q0ySDLiVxcnJtTh4PIozvwSnhw=; b=G2/GY7mBhEuuwUTV5TL5n++sG9
	fCjxhEGQrdP34358fLm9qY3JDDZ2y8Lxpd771JTW05TWmuNS+LFpAY7waA+hWSXiFDleWo6akJ6pp
	DSGKKIn5AELI3NDgjUJE1HJIi2yj1zvt1VSs/yNZwmACWM1fbw78hJ0WxhClRr5qBbprDUd2oKE7X
	m4KVFNKS0tJbU1hokLbqblFQ0UQD47HrwsyTA/Au9oUPrn93ncBa4kkNo0nypCXikW7KGncAcNzjc
	BzUGdGklqyCqOhjxWuqj0bJWre+zy96isozJb7ejYTz/BSX5LAj7Vg+hUSqeTCpFdSON00uvwWNZw
	+LPkr03Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vjKOl-0005hb-PG; Fri, 23 Jan 2026 17:52:39 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vjKOg-003ttE-TX; Fri, 23 Jan 2026 17:52:35 +0100
Message-ID: <6850ad0c-68e5-4d8c-b80e-7c6adee80fdf@rbox.co>
Date: Fri, 23 Jan 2026 17:52:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: John Fastabend <john.fastabend@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, leonardi@redhat.com
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
 <20250311155601.eui5j2lta3q46i6u@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250311155601.eui5j2lta3q46i6u@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-252886-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[rbox.co:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:mid,rbox.co:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E440478A72
X-Rspamd-Action: no action

On 3/11/25 16:56, John Fastabend wrote:
> On 2025-03-07 17:01:11, Michal Luczaj wrote:
>> On 3/7/25 15:35, Stefano Garzarella wrote:
>>> On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>>>>> Signal delivered during connect() may result in a disconnect of an already
>>>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>>>> been placed in a sockmap before the connection was closed. We end up with a
>>>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>>>> contract. As manifested by WARN_ON_ONCE.
>>>>
>>>> Note that Luigi is currently working on a (vsock test suit) test[1] for a
>>>> related bug, which could be neatly adapted to test this bug as well.
>>>> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
>>>
>>> Can you work with Luigi to include the changes in that series?
>>
>> I was just going to wait for Luigi to finish his work (no rush, really) and
>> then try to parametrize it.
>>
>> That is unless BPF/sockmap maintainers decide this thread's thing is a
>> sockmap thing and should be in tools/testing/selftests/bpf.
> 
> I think it makes sense to pull into selftests/bpf then it would get run
> from BPF CI so we can ensure BPF changes will keep this working
> correctly.

All right, a bit late (sorry), but here's an attempt:
https://lore.kernel.org/bpf/20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co/

> I guess the trick would be to see how long to run racer to get the
> warning but also not hang the CI. If you run it for 5 seconds or so
> does it trip? Or are you running this for minutes?
>
> If it takes too long to run it could be put into test_sockmap which
> has longer running things already. We also have some longer TCP
> compliance tests that would be good to start running in public somehow
> so might think a bit more how the infra for testing is going in
> sockmap side.

5 seconds is enough for the af_vsock case. I've added a af_unix test as
well, that one takes longer sometimes. But 5 seconds per protocol do add
up, the whole run takes some time.

[...]


