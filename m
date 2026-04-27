Return-Path: <netdev+bounces-281518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FcFMu7k72kFHgEAu9opvQ
	(envelope-from <netdev+bounces-281518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:36:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138B47B88D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4531302A6D5
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB913A6F01;
	Mon, 27 Apr 2026 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="npN4mFu9"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C5386441
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329387; cv=none; b=Sn+NxjqEhEnRa28n5gQOFpiHSgUY7fxS1NT6KjDWv4aDv4L/VhSFYPL0aDX2gUgLuQ+4b8SAf8pxnS/X744h2ynJ/ZehhqVE2CCWFhBYfBT3c019IykS1nneMyDBaqylYrukN+V3ypw0Sukx+e7npL75gqELZTNsc7Z+V0WoMr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329387; c=relaxed/simple;
	bh=MnOzzzamYXiwghHrVckJNVajr4kLMULxSd8oeLokv0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvAgvBmTBZBlqpF65nh2h2m/uBlMa9ngdjG0XIACECARTktK3lpC6BUJAlx1LtsfO8Opkgu2USmIh/mcSTZ6u3vrCqJfiD+1WKjCvdMF7wCd2jDYESikwWVYnVw/UNPtpjRzpsfvzy21KdkXisR2fmUwpxQkG53kHKnF+eiTKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=npN4mFu9; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 27 Apr 2026 15:36:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777329373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LsQU2/LjFk+qRAd2b5lbs1cknpmT2BXH5jVMeLp8gG0=;
	b=npN4mFu9PZrqDAG0R8FzMVWqfso7n+haulHAzPTGd9Rax1uBCE5S/e/on4S6r+8qovHxsa
	5JNXDhWy0RnO5IQBexuNjeIv5Wcg68hyBJprcoXHFGKpzrnTcm4MAPmjcpwZjLCMtAwuO5
	/Sm3VA3mUeZh15hz1Jcju3Yft/En86U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: nhudson@akamai.com
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v5 6/6] selftests/bpf: tc_tunnel validate decap GSO state
Message-ID: <2026427222011._PrH.martin.lau@linux.dev>
References: <20260420104051.1528843-7-nhudson@akamai.com>
 <2ea5cc41fd138e94dc34b1d4073833118b93ae48d802aabe480e355e27417b62@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea5cc41fd138e94dc34b1d4073833118b93ae48d802aabe480e355e27417b62@mail.kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7138B47B88D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,meta.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]

On Mon, Apr 20, 2026 at 11:19:30AM +0000, bot+bpf-ci@kernel.org wrote:
> > +	if (!shinfo->gso_size)
> > +		return TC_ACT_OK;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> > +	    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
> > +		return TC_ACT_SHOT;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> > +	    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> > +		return TC_ACT_SHOT;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> > +	    (shinfo->gso_type & SKB_GSO_IPXIP4))
> > +		return TC_ACT_SHOT;
> > +
> > +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> > +	    (shinfo->gso_type & SKB_GSO_IPXIP6))
> > +		return TC_ACT_SHOT;
> 
> Are these IPXIP4 and IPXIP6 checks reachable?
> 
> Looking earlier in decap_internal(), for IPPROTO_IPIP and IPPROTO_IPV6
> cases, the function only sets BPF_F_ADJ_ROOM_DECAP_L3_IPV4 and
> BPF_F_ADJ_ROOM_DECAP_L3_IPV6 on the flags variable (around the protocol
> switch statement).
> 
> Because BPF_F_ADJ_ROOM_DECAP_IPXIP4 and BPF_F_ADJ_ROOM_DECAP_IPXIP6 are
> never added to flags, wouldn't these validation checks always be skipped?
> 
> Ref: https://lore.kernel.org/bpf/20260416124324.B0CE6C2BCAF@smtp.kernel.org/

This comment has been mentioned again. It seems legit. Please don't ignore
the review comment. Otherwise, it will be assumed that the solutions are
being worked on and patchwork will eventually archive the patches after
some time.

Also, there is a 'SYS(fail_close_ns_client, "ethtool -K veth1 tso off");'
in prog_tests/test_tc_tunnel.c. Is the shinfo->gso_type ever set?
What will break if tso is kept on?

