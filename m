Return-Path: <netdev+bounces-292300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JNYF3vxFmpcxwcAu9opvQ
	(envelope-from <netdev+bounces-292300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D045E4F5C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 521EC309804A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571E40C5A8;
	Wed, 27 May 2026 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vcuUiUsz"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B9405C3E;
	Wed, 27 May 2026 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888140; cv=none; b=CAuFTbmo7f1fjsn2C9Oy3XZzXr/bJ4zPJ2kJrp/A9XC+lWPt15E96njUOMidl+tbErmeFuiBiqQdRPxenBoPvO5ny3M+ETLQ+WAs70TlKRX+tVlqu72YIC/kubcgTnXUiF6Kkl9FbgSfOFd7aoJbXoQ3d9/0z3ZJb/y19iauHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888140; c=relaxed/simple;
	bh=ZaNGpA5HYuZlzIwRGELlOp4CUVtlceg6mH6qVtqr4qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr5bOe/Z2xqSQ2e5CLzRZ3DaeIPHpLUIF7wS8ZPpHtRaEgo9HOJWtwuZJWk1yhHy6YFOokBiqREeIOH78UNoefiRV1eOGSHUSn1hxDa6gI8d5Nl1RH3gW+Md8hZ6tpP39sF5p+Dw2Gx+L7YhW2O8OEv48sU8KeUo11oCZ3Vf4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vcuUiUsz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bOQQcEyuk3Y4GLb+wbT9HyIT+hbK6P/u32spWLnRrCc=; b=vcuUiUszXcNhITfV5q9m4xNxTY
	n1ft3+W1BoUls6I5vtLKU8U1vsdj7GV4131emFWdPzvmacvG0dC1BefIlZUuocnTDcaFiC5/vuqc5
	jWLcJEWCGmAS4kZ9EpvK4yUjRW+LisG/vnR52WnB5YuWFVa1w3W8feqi/fPCPfUl5o8oQZ71cp4q2
	yHfTc6w/+0wjhGVaOnk3R2b/MUIxYU5G+tp6MxJP0NgRgWMeUu/mSstRh9OEbR0cz9ZSnOxl5GNBC
	rX1h33yhOEw8zmP1/GTnEgYlp22jF8CYG3JHjjWVOcJfnDvMQVLXo1txQGtDd4lDmjz0IM6cAjQjO
	+rkkRcCg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSED1-003BmS-23;
	Wed, 27 May 2026 13:22:07 +0000
Date: Wed, 27 May 2026 06:22:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gustavold@gmail.com, asantostc@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 0/9] netconsole: stop charging every netpoll user for
 netconsole-only state
Message-ID: <ahbvRJO-P2tgvmXj@gmail.com>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
 <20260526190053.619cc53d@kernel.org>
 <ahazcZw0KRwu5hUR@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahazcZw0KRwu5hUR@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292300-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D1D045E4F5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub and netdev maintainers,

On Wed, May 27, 2026 at 10:07:16AM +0100, Breno Leitao wrote:
> On Tue, May 26, 2026 at 07:00:53PM +0000, Jakub Kicinski wrote:
> > On Sun, 24 May 2026 09:12:16 -0700 Breno Leitao wrote:
> > > struct netpoll is shared by every netpoll consumer in the tree:
> > > bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
> > > netconsole users only need a per-port handle that lets them transmit
> > > SKBs.
> > 
> > Are any of the Sashiko reports real?
> 
> Yes, there are real pre-existent issues reported by Sashiko.
> 
> > At least one seems legit (parallel device and target removal).
> > If yes we should probably try to fix them before we shuffle the code
> > around?
> 
> Ack, I will get them fixed and them move them around.

I was reading Linus' Linux 7.1-rc5 email[1], and I am wondering if these
type of "fixes" should go to net or are you planning to change it to net-next.

"""
   These things are "fixes", sure, but at the same time a lot of them
   are simply so irrelevant that I think they'd be better off in
   a linux-next tree and get merged during the merge window.
""" --linus

Link: https://lore.kernel.org/all/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/ [1]

Thanks
--breno


