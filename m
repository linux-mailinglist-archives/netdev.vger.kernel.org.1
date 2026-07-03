Return-Path: <netdev+bounces-304558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id op7yMwS7R2pheQAAu9opvQ
	(envelope-from <netdev+bounces-304558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:37:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60888702EFF
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:37:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GcPyCS2x;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304558-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304558-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F168F3034229
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCB3C13EF;
	Fri,  3 Jul 2026 13:35:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD973D4119;
	Fri,  3 Jul 2026 13:35:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085715; cv=none; b=qgP8C5BHvYtXoHPRwk8GbS7laWDSkJ3oEamxegeMUeCFejVDUEX84IpNNJhS9L5/Z8ycCmyZc6S0Kw3hHW5/quiS1It/7CkrLAyPE0KHuDVTwkn/kiuuBq6Ump3P/GYiWnCSfluJjMWOItlFbpqO0mRRSI6w5DZQRRoVDWLqov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085715; c=relaxed/simple;
	bh=2rVwwsXFJJhYdfGetd4gi9f1UtCNitUIk38yq5Z/XlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sreUyCE0oE8K8sc1/qENR2VbU8VkIoehMMOVeKYkPbXA+LSSjewF6/NTu13zFFDY1PVnTV4c7IppX8S9tk6easCFFMBb49KKmZwPS6YV8YOSskG7cbZA1AemF8PHkT1S++x4Jb/YZuRIUJoufVp7GUlMJT4CzFIwQlk/PIPCRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcPyCS2x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896DA1F000E9;
	Fri,  3 Jul 2026 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085714;
	bh=bNRaOtegL6fhKlkRt3+q17rWiDqhMVyOW7Qokbnm7SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GcPyCS2xUeqeD9bs+29INeL0tFqHdGwsDcRxS6ApH2OtbkTDOs3Q0ImxmyTIJ/YQF
	 AVLGsr47gkqTVmRcMR/wOIHfYSTrcM2QcYQ1KXTTeAyw4InMoQuyCqOZ1cK1a5BMqk
	 DRGyYAsaT5ydwbf20VnYmZrde5rley+0I0mF5XXQVh3xZsC/ElKX7V9AShHVnXFuko
	 veyMZbfnUHAz7hEqw6CfqpR5kukNFGrjHVQjlykt3k+a7cFBrYlwV9q6W4URy1GJZW
	 0HFbKFuV69A+CckEDzemJabgl4O41xHC0H4mmYjTzf06XtY8h2F+O4kZsGLvvMQzcO
	 hVRBGU2Rpn2CQ==
Date: Fri, 3 Jul 2026 15:35:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <mail@johnericson.me>
Cc: Cong Wang <cwang@multikernel.io>, Li Chen <me@linux.beauty>, 
	Andy Lutomirski <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	network dev <netdev@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Message-ID: <20260703-teamgeist-ganoven-kundig-eff19aa92e38@brauner>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
 <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
 <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:cwang@multikernel.io,m:me@linux.beauty,m:luto@kernel.org,m:axboe@kernel.dk,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304558-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60888702EFF

On Tue, Jun 30, 2026 at 04:22:25PM -0400, John Ericson wrote:
> I'm bumping this and adding new recipients again in light of the
> discussion happening elsewhere in
> <https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/>.
> I don't want to count my chickens before they are hatched, but it is
> looking to me like a consensus in that thread is building around the
> ability to opt into intentionally empty/unusable root and working
> directories (at least with nullfs, maybe but less likely with other
> mechanisms instead).
> 
> That new functionality concretizes the motivation for what I am
> proposing in this thread: in such a world, there is little to no point
> binding listening sockets in the file system, because the containing
> directory would have to be conveyed by file descriptor anyways --- might
> as well just directly convey the socket to connect to by file
> descriptor. Likewise, abstract sockets are not appealing, because the
> abstract socket namespace is either too coarse-grained (leaking info in
> the same way root/cwd would), or too cumbersome to keep it from leaking.
> 
> To recap (with some slight changes, like renames), my latest proposal (a
> new version, not either of the two variations in the original email) is
> new syscalls `bind_unix_anon` and `connectat`, supporting a workflow
> like this:

Please stop sending a bunch of disparate patch series that all do
slightly related or overlapping things and point back at each other.

It's completely impossible to follow for anyone what's going on without
chasing down discussion state across multiple subsystems. The net people
have zero insight onto the fs struct discussions and it's completely
pointless to try and design all of this based on thin air. Nothing is
locked-in yet. This is not how this goes.

This frantic pushing of various features doesn't scale. It is requesting
costly review time for multiple RFC series.

