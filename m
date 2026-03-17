Return-Path: <netdev+bounces-268634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIw2E4VpuWmZDwIAu9opvQ
	(envelope-from <netdev+bounces-268634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:47:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3B62AC448
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFBA3138E7E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51483E7168;
	Tue, 17 Mar 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcyX76dM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FF3E3C6A;
	Tue, 17 Mar 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758320; cv=none; b=lbxdfZqjGWf1M4HcpEa1bx7w8DHCgvi0h/vQIybV2JTYl+Kjqs+yOLAXd1IYPEGicqpR1eSjD5O0RRJL8hBIzItb882VWhNS0vabyF1eL4xAG2Mx+F3pjzvkDLSIJ7FTaf74GannZOyVY1RhdjTIu28OQRKL7jd2P+Pfrn5++mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758320; c=relaxed/simple;
	bh=PcAzoRBi0yShLCkc16qsSlrcC/1E0YR+hxCsyFSB/4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMhE5gjRr26mIHaKrcv3P/KXEwWrEYwkd9K2LqlE3cb/dcetLLmAAV1vZUBfn0UYcju51UJRRgUatU3T2wSJJnTKiAbA0477rcgWbGuFn0fq3DNBrE+BFbnPX1ucO3lCXEpO5M26QcMuVgXWUtLVjqZfA/OqCFeNBR9vl9ENdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcyX76dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D2DC4CEF7;
	Tue, 17 Mar 2026 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773758320;
	bh=PcAzoRBi0yShLCkc16qsSlrcC/1E0YR+hxCsyFSB/4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcyX76dMmj3/+2SWIEJra5NLxObLyvxsnKcZX8/hQJ50qQAXKDghHSmioaEmPf/mo
	 WbOfTb7hSNxGLvjZR0bZhAMBYNHM2GqDO7NaSvnmMzZtRpWWsT8wcYVENH8uh4mwjP
	 IYVfDpQnBflWcNYEnJo/OiNKhzgTzuwXSmPTMrYG1ioW3F/8G4pLDuipTNlnUb+1M7
	 nzb7Q3xoFtRlhvumM7DVSr4FPH0fDaPpoXRQKR8hC4Y4Y0XNOyA92zvx0j2hpaMLTg
	 NIIxA/KGW/sr4pOCVagifFK6Qz5uPfJwuqDuHtwdQm8YjL6rmkV9dFRiFwr6/aA6kW
	 WgpBAfd/Y6FBA==
Date: Tue, 17 Mar 2026 14:38:35 +0000
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
Message-ID: <20260317143835.GB1710951@horms.kernel.org>
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
 <20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
 <20260313132651.GX461701@kernel.org>
 <20260314100002.122c8c73@kernel.org>
 <20260316083447.GD1369074@kernel.org>
 <20260316161917.76f1ea87@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316161917.76f1ea87@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-268634-lists,netdev=lfdr.de];
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
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A3B62AC448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 04:19:17PM -0700, Jakub Kicinski wrote:
> On Mon, 16 Mar 2026 08:34:47 +0000 Simon Horman wrote:
> > On Sat, Mar 14, 2026 at 10:00:02AM -0700, Jakub Kicinski wrote:
> > > On Fri, 13 Mar 2026 13:26:51 +0000 Simon Horman wrote:  
> > > > It seems to me that the use of a union is intentional here, as either IPv4
> > > > or IPv6 addresses can be present in each case - never both.  And that
> > > > control.addr_type and enc_control.addr_type are intended to allow
> > > > differentiation of the address type in use for each of these unions.  
> > > 
> > > My reading was that the initial author simply wanted to save space in
> > > the struct.
> > > 
> > > As the commit message explains this leads to complications in the logic
> > > which sets the keys. The alternative is to complicate
> > > FL_KEY_SET_IF_MASKED - doable, but given that the union feels like a
> > > micro-optimization in the first place the simpler approach of separating
> > > fields seems okay too? (TBH my mind also initially went down the
> > > FL_KEY_SET_IF_MASKED rabbit hole but once I saw the simplicity of
> > > Cedric's patch I changed my mind)  
> > 
> > Sure, now this has been put to me more than once I agree.
> > 
> > But if we go this way, then can we also simplify some of the existing logic?
> > As a follow-up?
> 
> Which logic do you have in mind? Sorry if I'm being slow.

Sorry for being vague.
Let me do my homework and come back if I have a concrete suggestion.

