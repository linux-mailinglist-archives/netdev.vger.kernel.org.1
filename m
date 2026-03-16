Return-Path: <netdev+bounces-268053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KAgEXPBt2n5UwEAu9opvQ
	(envelope-from <netdev+bounces-268053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:38:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B342964B8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E624C302BE32
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F93815EE;
	Mon, 16 Mar 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUGkNkmd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438B378D8B;
	Mon, 16 Mar 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650092; cv=none; b=nvB8IrXo03sD4dbAHm2bN+sI+81AbikI8nsC3AB7eBJEcTMu8l35WwaKadLqgTeT6dpWB1QyCZD0cfcP+eycUiFp1uQNW9LUTD7xSMDbi1p0SuSs/jYlosP9jYLZyFJpWy3MQPZBALDcjUIM8zLX84r+A0+yEKPxvy5/4hIUqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650092; c=relaxed/simple;
	bh=hMqbwfvRVhSS49NZ+HECA3aCvX2neT+KBSR2v6gZ184=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxwlclehayxdLpp6EuLxJWYEGcXICnOMGzKRw9Ck8aVzJw+tKK69Dp+CyeqqyeME/E8f/ejWf05ikZdUPXakc+mBhagB5xNpbZ5OSKtaPW6EiHkfphhkJgxyeH5T+JvjLCckzDvh6jU/ZfIkoIjbxIaT0sDhwhgl0+QHwfdE95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUGkNkmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D58C19421;
	Mon, 16 Mar 2026 08:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773650091;
	bh=hMqbwfvRVhSS49NZ+HECA3aCvX2neT+KBSR2v6gZ184=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUGkNkmdNI7ymhURA3KNomJCg+rnaDxsvZMpDNSJLDEaVeQlj8PwvfrGkhfvUV6R7
	 KEJya/byxyTrmzCb8lyAMrWfNFrsCYhPhnK+MHR6Tae7vkfK9ly1FiOOEUzLTVajnn
	 owhjI2Pbndcj/mxOMpxp/wnZATCNAxdUHfQLtKBNhd80QhdaEqFMtamVWtyE/JKdTS
	 3tBEoWMm4X0wb5D7ReGDeIlW64H6ckV0b89S8riBH64zobRgRE7MBrbmg4Xj8Pzahp
	 sRW60HW/VYGySSvAEtpP3A9sWMF/gdIk6W+D10P4L2j9S4ePKGNH9eLSoSTFhxsY1V
	 A/jLYLoTV9p5A==
Date: Mon, 16 Mar 2026 08:34:47 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] net/sched: cls_flower: remove unions
 from fl_flow_key
Message-ID: <20260316083447.GD1369074@kernel.org>
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
 <20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
 <20260313132651.GX461701@kernel.org>
 <20260314100002.122c8c73@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314100002.122c8c73@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268053-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90B342964B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 10:00:02AM -0700, Jakub Kicinski wrote:
> On Fri, 13 Mar 2026 13:26:51 +0000 Simon Horman wrote:
> > It seems to me that the use of a union is intentional here, as either IPv4
> > or IPv6 addresses can be present in each case - never both.  And that
> > control.addr_type and enc_control.addr_type are intended to allow
> > differentiation of the address type in use for each of these unions.
> 
> My reading was that the initial author simply wanted to save space in
> the struct.
> 
> As the commit message explains this leads to complications in the logic
> which sets the keys. The alternative is to complicate
> FL_KEY_SET_IF_MASKED - doable, but given that the union feels like a
> micro-optimization in the first place the simpler approach of separating
> fields seems okay too? (TBH my mind also initially went down the
> FL_KEY_SET_IF_MASKED rabbit hole but once I saw the simplicity of
> Cedric's patch I changed my mind)

Sure, now this has been put to me more than once I agree.

But if we go this way, then can we also simplify some of the existing logic?
As a follow-up?

