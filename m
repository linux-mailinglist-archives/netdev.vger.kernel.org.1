Return-Path: <netdev+bounces-256301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLwQJgD9gWk7NQMAu9opvQ
	(envelope-from <netdev+bounces-256301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:49:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B245ADA21A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65A493006013
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8F3164D6;
	Tue,  3 Feb 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EWpF+xY/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSgHnhC1"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4FF1F181F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126573; cv=none; b=bqoyd+z5V/SxEPPAq6Rld1DuPxz8yo8RrglebXDFnlsulLSEGYC/BndxQp3STFu9934W+r5tNwM9VFg7t/u1s2y8SBJ5buu+ds6KXmB4NImgO+Nwpq8k2aUezjDHXitHxU771kMdV86vXthTnFvZwf8Tg15LvLW5OEc9lDo3An8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126573; c=relaxed/simple;
	bh=AjEE9wTDa32hZEqKtBrnWaXRGc6+lc4Qyyv/r3OGKPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR5BTYiEgcRI1ICbmum3tlZskebE/ThxLfaScb6VBaUnyDYWkJXx2cUYzfUgqf599N6TwJdizOsOzk73WzdLX3JRfRAbfq87Xwal7tAEC0sBwXncYgRuJG1z0kFlm2XKXCUHtLAX3kRjEUiM1ciqkdlgyazlFtDmghTGR8yllPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EWpF+xY/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSgHnhC1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 14:49:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770126570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7B5X9WuXXq4lY73aRP+GXwW6TbDtSgszXX4sFtq0GjM=;
	b=EWpF+xY/cvnuFTzbv/2eDfqHqETD63s3CVB1GHEHX9NzhG1ZNlvK15c97wgUa4/0OjA4/v
	YEHV/1H2U1HDf0DuH1wWGUae6Gab5G/ZCB0efdkWWuxbVKXqcfJG15xp5JgmTRVwOsEn0Q
	jxdmNoe2ndT80TcAxU7H0/8dY7XMEZyifnaZV55drtgQ7o92v2rDNSvDTCyPn5WpD+QPAe
	Rziy62hmtrasPHrR5wdmEtVFsIQxGc+Zcm5lq1WlAsqt5eu5qBsBhbEBCkACFsl8Oynfgh
	4dwKv+1za+sPCkpT6I8/w5pr22yUXRB0ei4+68MWDW4sKh4NnlEzbSvI4wMXKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770126570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7B5X9WuXXq4lY73aRP+GXwW6TbDtSgszXX4sFtq0GjM=;
	b=NSgHnhC1MZGvhRsnTHr+4mzimSSG/gWrVb40SlNVXRLaC/A3qZpFvpd7PYRfvLo7xm5ngG
	0hMSHRoEWNxCyOCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <20260203134929.-HomS8WS@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260128163824.GB172540@kernel.org>
 <aXpXY0YSjA-ctoBa@thinkpad>
 <20260202165702.R9PI3JSM@linutronix.de>
 <aYHMvaGiuQSHBevG@thinkpad>
 <20260203115719.cU_6tnal@linutronix.de>
 <aYHtSP-Pl1mTpkJC@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aYHtSP-Pl1mTpkJC@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B245ADA21A
X-Rspamd-Action: no action

On 2026-02-03 13:42:48 [+0100], Felix Maurer wrote:
> Hm, I'm not sure I follow. Do you argue that the code already in the
> patch is incorrect or that it would be incorrect with Simon's
> suggestion?

The suggested change should have no impact.

=E2=80=A6

> I understood Simon's suggestion this way: in the error path, *also*
> reset block->time to 0. We'd still return NULL in that case and,
> crucially, don't advance the next_block. IMHO, that only makes the data
> more consistent (blocks in the buffer that are not in the xarray always
> have time=3D0) and prevents that we try to remove a non-existing entry
> from the xarray on the next frame when we try again to recycle the
> current "next" block.

That is correct but should have no visible impact.

> Thanks,
>    Felix
>=20

Sebastian

