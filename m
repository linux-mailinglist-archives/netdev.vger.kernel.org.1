Return-Path: <netdev+bounces-298732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NQRuA4w4LGqnNwQAu9opvQ
	(envelope-from <netdev+bounces-298732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:49:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34A67B111
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:49:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DdenUG4n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298732-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0881430055A5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1B3BCD12;
	Fri, 12 Jun 2026 16:49:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0A31F998
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:49:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282952; cv=none; b=C0pHOac7zz3cGwzMKJT9y2vl0a5LgqLYi2IjO7zY3yqS0iVG6XX0BVD1JLEVJlG22M7X5cv/XTn94tdAeN3ONji6JxgRUm9ULKp0DrAoaGF8Wg/fFmm0+yiaoaRmw18vCESKBIiVt+iORFWUfHvWOeMJGWwIHb8NXSZsFMo8enA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282952; c=relaxed/simple;
	bh=uX3Lpx4f7WFzbDyghMLEkCIbGiSRhGiSGuY3cUKCkn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZcHe3wHh73tiwfEJFt1idUWHU+tV8sk1gsZKrgBqweZVopKmyTBosfRUAcS1f4/tciAMyE4OHe0LA0WhdKb7TZxd0qVOhl3Re2Csby1PvUdceVS8EJa81isL/jHnq/CKAppKg3MWq7+ZzQq3+uhUppFFIk/dpvweB+3n08Qi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdenUG4n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2E01F000E9;
	Fri, 12 Jun 2026 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282951;
	bh=I3+0NpVchnIFcN1iCq9hCjRAuxbBaM1XX3Xm/Foxhoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DdenUG4nj9oU87PrgFFgD7nrbzQ39OOuK3NC4G6xdJRfmgLGB4gm4SvuD2HMLD2TP
	 Hu/t09ugVW+UFUrUNOLbFmytX+Fo9I+mT+BO2wfeOZRBneYIzKlWJo8yfSwdCk717f
	 DkI3rHsQ1X9E44VcmIh7Fo/4g5tZ4LlFpL/mkfekQqc4yixhRXcB4fsnahIDVqKsVX
	 3VMBcb0TbQimC1mvctJ0CVdXgIMwF1bUzcfvRTw/T9S+g4o1PSnxbC4Bxnw6Y9fXTr
	 EJ/RWpkh/8FC8Wc7zqeZHFTd9vicuGLmsIEiJaQ21BqKZa8DREieGn8yoNQ32a3bGR
	 RCVIBl7yl5/Gw==
Date: Fri, 12 Jun 2026 17:49:07 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ip_tunnel: annotate data-races around t->err_count
 and t->err_time
Message-ID: <20260612164907.GG671640@horms.kernel.org>
References: <20260611165247.2710257-1-edumazet@google.com>
 <20260612162818.GF671640@horms.kernel.org>
 <CANn89iLw_wT+fqYNixYiTP4y14R5YeyZXXhbOhSTvvtKris_3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLw_wT+fqYNixYiTP4y14R5YeyZXXhbOhSTvvtKris_3w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F34A67B111

On Fri, Jun 12, 2026 at 09:31:51AM -0700, Eric Dumazet wrote:
> On Fri, Jun 12, 2026 at 9:28 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Jun 11, 2026 at 04:52:47PM +0000, Eric Dumazet wrote:
> > > ip_tunnel_xmit() runs locklessly (dev->lltx == true).
> > >
> > > ipgre_err() and ipip_err() also run locklessly.
> > >
> > > We need to add READ_ONCE() and WRITE_ONCE() annotations
> > > around t->err_count and t->err_time.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Maybe this should have a fixes tag?
> 
> Ah this was meant for net-next
> 
> We just merged into net-next the IPv6 equivalent patch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f6033078a9e671e3c8b83d387b91591a6f6a54e7
> 
> Sorry for the confusion

Thanks for clearing up my confusion.

> > In any case, this looks good to me.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >

