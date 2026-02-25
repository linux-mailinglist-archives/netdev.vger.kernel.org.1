Return-Path: <netdev+bounces-260720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN6VKyVcnml3UwQAu9opvQ
	(envelope-from <netdev+bounces-260720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:19:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09435190D36
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95A2D3114957
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152C25E469;
	Wed, 25 Feb 2026 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmZDx1wj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F631225A3B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771985145; cv=none; b=MTnO+VVL+RXonlr74eb2VfwPXW94LjxkL051vFkUwq0uvsRnT9UECCFfDOpcYP8gazGJyTbkHUNy0OY65L9zsCsCXCyAx2lFNpZChBHYoq9cXnESfpJIbbyrGpTHYuyOKMqADPhwcu+8mDpOLaihaxcYYh7TtgzaEDRL/8Dw9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771985145; c=relaxed/simple;
	bh=v+qnGLmRs2u/OsMFcH7y05io0Xo5IDzOIJPF0NxgkIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5abS9YxBiwZGrf4CHxmplnPy44NCSY+G832WqaflDBAGCpwemVjis753AEv174571WgU2lSFAOzkmbavz8czCW/8wQwJMEE3y+mRzLGL/A/nvKTHbEc4QvGu2Lpa1cH4f8stXE138gctwJcjUtKyWyFWCrh139Ad1G16Y2W4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmZDx1wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A896C116D0;
	Wed, 25 Feb 2026 02:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771985145;
	bh=v+qnGLmRs2u/OsMFcH7y05io0Xo5IDzOIJPF0NxgkIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tmZDx1wjsxQ+aosDoQ3opneQBZ/VbWJ0qTIoV6LlRKZ/8DeihkW/HCSik4hWecrVs
	 wM6oZO8o4xiG/VaUzKeWfgjGGti9ADRFxsJVSYv6KfxLZIpogOiyV91Uz2diaJXHFK
	 9tcTjvTU1ywMUGtZP6sfwlBiVcr4Fc10ejMoJ4lAapF8XDXZTTyEycSJGdAAB1tAGq
	 hQnq+fhyDaKq0ACrn402w4JfYSgeVeQ12AaRWmsJ7v++QQwa8LKnmFB5l8yOUKPY6z
	 IZdzmWn1gm+V/LwW+Oni5vTvIqhzE6615649lkvwgLGx+mPNBqAfFzVBCzQiWb6t2d
	 lnFpezTc/SqFA==
Date: Tue, 24 Feb 2026 18:05:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ipv6: move ip6_dst_hoplimit() to
 net/ipv6/ip6_output.c
Message-ID: <20260224180544.3c865751@kernel.org>
In-Reply-To: <CANn89iLjKzLwPirGBY3SzrC33OioPCrnZMcGuP4PGj7GWp39eA@mail.gmail.com>
References: <20260223153342.892477-1-edumazet@google.com>
	<20260224174909.59f52345@kernel.org>
	<CANn89iLjKzLwPirGBY3SzrC33OioPCrnZMcGuP4PGj7GWp39eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260720-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 09435190D36
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 02:52:55 +0100 Eric Dumazet wrote:
> On Wed, Feb 25, 2026 at 2:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 23 Feb 2026 15:33:42 +0000 Eric Dumazet wrote: =20
> > > Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
> > > can (auto)inline it from ip6_xmit().
> > >
> > > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > > add/remove: 0/0 grow/shrink: 1/0 up/down: 47/0 (47)
> > > Function                                     old     new   delta
> > > ip6_xmit                                    1481    1528     +47
> > > Total: Before=3D25076476, After=3D25076523, chg +0.00% =20
> >
> > allmodconfig is not happy:
> >
> > ld.lld: error: undefined symbol: ip6_dst_hoplimit =20
>=20
> Oh well, this maze of config options...

I don't recall last time we discussed removing support for IPV6=3Dm
but maybe we should consider it?

