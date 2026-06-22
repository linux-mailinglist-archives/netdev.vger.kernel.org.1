Return-Path: <netdev+bounces-301219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZDsrJzS+OWqIwwcAu9opvQ
	(envelope-from <netdev+bounces-301219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 011036B2B9E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NN06kNND;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301219-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C954300CC19
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15C37BE87;
	Mon, 22 Jun 2026 22:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C72264C0;
	Mon, 22 Jun 2026 22:58:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169137; cv=none; b=kt1ygrviOEa508UDXKG5oDTa4EpMstr9fYHi27u954VCA+fz/5RUK6fEr9M603Jwm1FSNjWJE8K0oXAgkNwtFGqMmGpvNu7R9GKCk5uSx1CdAR/rBxK/0KLvuil/0QTNnqOqz32PJb1CexjIN+1Km+TS3ounaFcf1nP3oJyd5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169137; c=relaxed/simple;
	bh=aRrJVhQclOJmF//g4+smCBLA0DaPcDpwIePt7tco7kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxNIAH5+BpcyUeEP9nxfOmAmYuOkEYp60kLjahGg1lgM7yXhv2nKkzLvu3dilpzDA5xB3h48wVqBbp6Go1ISoUNklgcVble0+/LvECZtuFx0MUAJoi9JCNua0FGoDC2lq7hAHP4Pl7alVV0AhO5gnea6W1Y/UdvZRjY+NQ7MsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN06kNND; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EED1F000E9;
	Mon, 22 Jun 2026 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782169136;
	bh=cf8VFMdKAKyQGQAVq54fhWDFVL5UEpiUpHWH51/HhdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NN06kNND8KS4FEj3AmGiy6HruE4DdxRM45pxeV9AhqRglDlV9ogNIZ/6H5HuvNEhq
	 6/5sBQ8wRfewVea9KM2gx0Og0HdpoJsPqYiA8WvzmdFy37t28KtQ4xRA7z/CXlUUwU
	 Vog1Cy7kzzay7E+a+Qe/8xj/QjzzvzfZ6OPIaIHakTq7CubW9/WsAckg/M6hGbNjo+
	 i9XhBM13YpnqTwoHce0w+XBMphexZEkVVqFUX7kvtP6HcPl0v3ughvgM2psvjqb9Wf
	 JwU+GZE/uUTAxacyoqeHxWhhI6Cg+bvwFOY0KN5rcJka9C72x5+k0FIaL8xYHgJasn
	 TJZzGjoWbL2fg==
Date: Mon, 22 Jun 2026 15:58:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Jesper
 Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Jussi Maki
 <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Weiming Shi
 <bestswngs@gmail.com>, Ido Schimmel <idosch@idosch.org>, David Ahern
 <dsahern@gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
Message-ID: <20260622155854.75977aac@kernel.org>
In-Reply-To: <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
References: <20260620201531.180123-1-xmei5@asu.edu>
	<7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
	<CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301219-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:jiayuan.chen@linux.dev,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:idosch@idosch.org,m:dsahern@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,kernel.org,vger.kernel.org,gmail.com,fomichev.me,redhat.com,idosch.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 011036B2B9E

On Sun, 21 Jun 2026 18:28:09 -0700 Xiang Mei wrote:
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 40037413dd4e..6037860d5283 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> > >       struct net_device *master, *slave;
> > >
> > >       master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> > > -     if (unlikely(!(master->flags & IFF_UP)))
> > > +     if (unlikely(!master || !(master->flags & IFF_UP)))
> > >               return XDP_ABORTED;  
> >
> >
> > I recall that when I previously modified this code, I removed the
> > !master check
> >
> > because this is on the fastpath. However, since this is a triggerable bug,
> > I think adding it here is fine.
>
> Thanks for the review. It's difficult to hit under normal statue, but
> the bug is real.
> We have triggered this bug with a PoC plus GDB to pause one thread (no
> other `cheating').

Can you double-confirm that this triggers on current HEAD
of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
NPD when removing a port from a VRF") was supposed to prevent all the
torn master fetches. Adding VRF folks to CC.

