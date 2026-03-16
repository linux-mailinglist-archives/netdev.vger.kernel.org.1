Return-Path: <netdev+bounces-268333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMQMD/qPuGnifwEAu9opvQ
	(envelope-from <netdev+bounces-268333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:19:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAED2A1E17
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85EC9301DD80
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8E246BCD;
	Mon, 16 Mar 2026 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C35+f7Id"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E679146D5A;
	Mon, 16 Mar 2026 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703159; cv=none; b=Ty11tpGfek9Wdd+BfVlqbRi2r5hbVxg84u3nmQEbVh/M1BDVbfZM7na5wJv9R5NIAhacYm4acDbZvYqsfz95dMJ02wlsKVV7YcAtwBEYt9JDqRCTxigDoex3EIGYdghiJf0ie+3Nqvi5Fw4IF3xcybLXeZ1WFJdWMk3wrKlIqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703159; c=relaxed/simple;
	bh=xexa7+8EBmRNdWJhmM8L8BHEQdI+Hm8cKvr75VkAnAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdc2irtvhtBziTRb2xxUlZCilGlLPDnCynQf5te8DOZ93r461LtAlg+oz1JzLJL1jda6tM4BZBv7W3669rYp2XqNG3byCUoix3KlN/ydEGl+NX9RFn3+P+Yo+tSQi2tOVNI8G1F1ilkfia3eFzWmO/bfoAYMHDMwerbfcGC6aU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C35+f7Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D28CC19421;
	Mon, 16 Mar 2026 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703159;
	bh=xexa7+8EBmRNdWJhmM8L8BHEQdI+Hm8cKvr75VkAnAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C35+f7Idk1Qm1/jOT9yZD9nvgOglL8Xp5GN+ucA0qzDJXzRwZ/1hijMA2JEaiYfnr
	 UVulYNmlqIsG5KsHqufbqWSpjaMLrXLtmxZoNyx9TqsLTuqC2FQy89qKfDIOZxsHdF
	 Oer4xOY8dmlzLAQW38h1gg6xz90+t5tlJWNQIHmMGoK/DVKYZkxrUheM9Aueu5Wd0q
	 xPGUE6MxN1TshW1yQUmdbNVXW9/H+Rytjsky3lobkAL1YbM2KxbBQ3BsAMzT//Imly
	 f8/oTO7WqssZKB8HuLC7QvQQY661in3e/rvEPNRPcJ108MY+KOQjhV6aKdagkUl/+i
	 an0qNGc0B1i0w==
Date: Mon, 16 Mar 2026 16:19:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] net/sched: cls_flower: remove unions
 from fl_flow_key
Message-ID: <20260316161917.76f1ea87@kernel.org>
In-Reply-To: <20260316083447.GD1369074@kernel.org>
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
	<20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
	<20260313132651.GX461701@kernel.org>
	<20260314100002.122c8c73@kernel.org>
	<20260316083447.GD1369074@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268333-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9BAED2A1E17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 08:34:47 +0000 Simon Horman wrote:
> On Sat, Mar 14, 2026 at 10:00:02AM -0700, Jakub Kicinski wrote:
> > On Fri, 13 Mar 2026 13:26:51 +0000 Simon Horman wrote:  
> > > It seems to me that the use of a union is intentional here, as either IPv4
> > > or IPv6 addresses can be present in each case - never both.  And that
> > > control.addr_type and enc_control.addr_type are intended to allow
> > > differentiation of the address type in use for each of these unions.  
> > 
> > My reading was that the initial author simply wanted to save space in
> > the struct.
> > 
> > As the commit message explains this leads to complications in the logic
> > which sets the keys. The alternative is to complicate
> > FL_KEY_SET_IF_MASKED - doable, but given that the union feels like a
> > micro-optimization in the first place the simpler approach of separating
> > fields seems okay too? (TBH my mind also initially went down the
> > FL_KEY_SET_IF_MASKED rabbit hole but once I saw the simplicity of
> > Cedric's patch I changed my mind)  
> 
> Sure, now this has been put to me more than once I agree.
> 
> But if we go this way, then can we also simplify some of the existing logic?
> As a follow-up?

Which logic do you have in mind? Sorry if I'm being slow.

