Return-Path: <netdev+bounces-300244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QT+AJy8OM2q/8wUAu9opvQ
	(envelope-from <netdev+bounces-300244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:14:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAAF69C7E7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:14:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HGpRBolR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300244-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300244-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86E58300B537
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841DE3F7894;
	Wed, 17 Jun 2026 21:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA913859FA;
	Wed, 17 Jun 2026 21:14:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730858; cv=none; b=sLAf1rBBZpV41PU56oCl3N/n40BGb4tJyGWCEttBhV5wnTxMehvUn498BnfWqLNbpADzq+fy6nwnOZrIcrTGuI3yCnhRdCb9xBsBCF1lopvkyEagNlKpVahFL2nIV1SLv6qaW4XxiWyPsSOehsvH5lWn5Ic1gjM5u/IHYKF8NiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730858; c=relaxed/simple;
	bh=DP4XsqgSCqRl4Z3knsvmPriVGaogb8fGF/TxZQznECs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAn1DbWUyUi6tM6ZWOqCoiGnrGyFbfaCSyqb480mdpDkOqbp4brgsrVF+CRpoxXQ0SvKMD7olr26rxzGWHmOsnmHQltc708or6790bvavN0rdPyD2o00X4L1mhME9eDdcNh/sn0H7VGC3odpg/oF2/aJKKai6TkQ2e82fKQ/IE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGpRBolR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B651F000E9;
	Wed, 17 Jun 2026 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781730857;
	bh=9nVBTi+PRr2qdNEg9BODiXO+ryEvvJq9cFm953MyMuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HGpRBolR1hIidUMLs6HJIMDGR48bg5rasBGjyVRxZtUkyqGgAnDSgbu6u9Z7ti8t8
	 Ccrdt5DuDZ3abmdLP75VJCwHjGTkbCcmOkkrk+izygBDOMw2nsaCfdj+9kg6rze7WG
	 zZFxl5JFCTJHZ+UPhHOgZJ/awRwmf6sV8njiv5I01j2740kKhdqk8dtRfKKIJMVZ3v
	 zA5B/+eeiiNblWKlK95Sltg5BLm2wOSQvMHibDVhtaPnhF9utD4hgs/O0V3Weooy4G
	 jPPi3oBLdythI/vDhOP8KnJwPy8E54uJcw2PyYvgi/MAWxQhmYN1bXnBi0hLzZoorJ
	 kXCPJlbubnBCQ==
Date: Wed, 17 Jun 2026 14:14:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in tls_err_abort
Message-ID: <20260617141415.0f479688@kernel.org>
In-Reply-To: <ajJwP14SWmdwwFYg@krikkit>
References: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
	<ajFpejsl1ukTbG96@krikkit>
	<20260616082816.4dd0f035@kernel.org>
	<ajG5hg9oJvyxPplG@krikkit>
	<20260616142359.43300727@kernel.org>
	<ajHENGWdBcbQUpWS@krikkit>
	<ajJwP14SWmdwwFYg@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,cca46a9d1276f38af2ae];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BAAF69C7E7

On Wed, 17 Jun 2026 12:00:31 +0200 Sabrina Dubroca wrote:
> 2026-06-16, 23:46:28 +0200, Sabrina Dubroca wrote:
> > 2026-06-16, 14:23:59 -0700, Jakub Kicinski wrote:  
> > > In which case the question is whether we should try to remove 
> > > the sock_error() instead? (stating the obvious I guess)  
> > 
> > That would make sense, but we can't prevent sock_error() being called
> > from some helper.  
> 
> Actually, getsockopt(SO_ERROR) will also clear sk_err. If we want to
> prevent further state transitions, we'll have to use something else
> (probably a flag in tls_context set by tls_err_abort()).
> 
> So I'd go with 2 separate patches. The 2nd one will be a change in
> userspace-visible behavior, but hopefully not one they'd be upset
> about.

Seems reasonable, FWIW

