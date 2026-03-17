Return-Path: <netdev+bounces-268659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BYlFNt0uWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:35:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75872AD1FF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1755E30C8A18
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80772D73BE;
	Tue, 17 Mar 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbKSfdcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43261A8F84
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761546; cv=none; b=dAuqnEVYrHI2jjzWlqTfXDVb+6iSZeVPxxA9jRKcspJfRN2i6vQFQbc0xZ2nne9zYby6a+kK+6cdUapzOsZCW0qMM3M0Jldrhb9S8lMU99pXKUP3hnmjKCLEuQW0YgBMal+yfU5QGp9xC0ctNpN9PWhG/l5J92I971Oav7MqvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761546; c=relaxed/simple;
	bh=Q5lrsh5HjZNL/TFE1ebWiJnYZcKV+HazAKdcTxR1viU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBYHe7qrlRKaQdvB0f6HZNcYjiY7vPMz3IpLSAbpF+7s7De5tor2dnFOIsFgMrDg1Eylig0tAWtL3xvlB2J1CjCSYOqZrOQ1OXnbsK36GYD1cEyeU9rdBSiamnJgNqJwo3Mp5ahR3hHMYDUtaGFwAwqGIISKZXk5v4/p8Xm6Odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbKSfdcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB58C19424;
	Tue, 17 Mar 2026 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773761546;
	bh=Q5lrsh5HjZNL/TFE1ebWiJnYZcKV+HazAKdcTxR1viU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbKSfdcL4lxHKKOq2TCRHIJUrm4AlSGbq2TX7Yn3N3rMcLOckF92oOlqw9bKHkjLS
	 3ijDa7UHroP07/wqeLS9VSdS2dUcSbOUzIFpR1coNdHnU1qO3fAaBnIrUyc9ZUvhqr
	 BTm7YWXX7SjpU+6xY882tPA5h6KYNpq38sMb5QJta43OZY8aKZSOnHuU8ampMmf0VT
	 Ia/3LL1GTFpCyBk9zWEjcX2wtd5MG5fjMNlso35ggiT94mIonZvTs2Xvzv4++j/w4S
	 pxk80+epN7QdxGwGQ0Q9sCqndYYA0bGBMvvHVBzJk4zKZQ+MNEpnc+oa1678hSMxVA
	 8VRP2MCISoh7A==
Date: Tue, 17 Mar 2026 15:32:22 +0000
From: Simon Horman <horms@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	justin.iurman@uliege.be, willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v9 10/10] test: Add networking selftest for eh
 limits
Message-ID: <20260317153222.GD1710951@horms.kernel.org>
References: <20260314175124.47010-1-tom@herbertland.com>
 <20260314175124.47010-11-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314175124.47010-11-tom@herbertland.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-268659-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,eh_limits.py:url]
X-Rspamd-Queue-Id: A75872AD1FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 10:51:24AM -0700, Tom Herbert wrote:
> Add a networking selftest for Extension Header limits. The
> limits to test are in systcls:
> 
> 	net.ipv6.enforce_ext_hdr_order
> 	net.ipv6.max_dst_opts_number
> 	net.ipv6.max_hbh_opts_number
> 	net.ipv6.max_hbh_length
> 	net.ipv6.max_dst_opts_length
> 
> The basic idea of the test is to fabricate ICMPv6 Echo Request
> packets with various combinations of Extension Headers. The packets
> are sent to a host in another namespace. If a an ICMPv6 Echo Reply
> is received then the packet wasn't dropped due to a limit being
> exceeded, and if it was dropped then we assume that a limit was
> exceeded. For each test packet we derive an expectation as to
> whether the packet will be dropped or not. Test success depends
> on whether our expectation is matched. i.e. if we expect a reply
> then the test succeeds if we see a reply, and if we don't expect a
> reply then the test succeeds if we don't see a reply.
> 
> The test is divided into a frontend bash script (eh_limits.sh) and a
> backend Python script (eh_limits.py).
> 
> The frontend sets up two network namespaces with IPv6 addresses
> configured on veth's. We then invoke the backend to send the
> test packets. This first pass is done with default sysctl settings.
> On a second pass we change the various sysctl settings and run
> again.
> 
> The backend runs through the various test cases described in the
> Make_Test_Packets function. This function calls Make_Packet for
> a test case where arguments provide the Extension Header chain to
> be tested. The Run_Test function loops through the various packets
> and tests if a reply is received versus the expectation. If a test
> case fails then an error status is returned by the backend.
> 
> The backend script can also be run with the "-w <pcap_file>" to
> write the created packets to a pcap file instead of running the
> test.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>  tools/testing/selftests/net/Makefile     |   1 +
>  tools/testing/selftests/net/eh_limits.py | 349 +++++++++++++++++++++++
>  tools/testing/selftests/net/eh_limits.sh | 205 +++++++++++++
>  3 files changed, 555 insertions(+)
>  create mode 100755 tools/testing/selftests/net/eh_limits.py
>  create mode 100755 tools/testing/selftests/net/eh_limits.sh

Hi Tom,

Shellcheck flags several instances of the following:

- https://www.shellcheck.net/wiki/SC2154 -- ns1 is referenced but not assigned.
- https://www.shellcheck.net/wiki/SC2086 -- Double quote to prevent globbing ...

In the case of SC2086 I think this can be trivially addressed by adding
double quotes.

While I think SC2154 should probably be ignored using

# shellcheck disable=SC2154

We're trying to make new scripts shellcheck clean, so I'd appreciate it if
you could look into this.


Also, pylint has also something to say about this patch.

...

