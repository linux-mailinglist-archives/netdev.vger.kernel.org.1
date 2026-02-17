Return-Path: <netdev+bounces-259168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCXrMHHulGnUIwIAu9opvQ
	(envelope-from <netdev+bounces-259168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:40:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A8151911
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161E430166F0
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1946C313555;
	Tue, 17 Feb 2026 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUfym3uw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1682F5A22;
	Tue, 17 Feb 2026 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368036; cv=none; b=jZbdBYLx/6Nfq8mlcqTkFdPdluhUd9hxB6XqiH+8VW2pez5vEEFTlS6bHwxUvPg4WNPGuHNUY/00Afjwzq5BY9yHrGoxUVFHqTcYKRYR5LrcL/P6vanHeH0Oh2QRENa4R6LfLLnlaj4B0d3fTJ5bZEkoKMmINLzztNjt8kCVAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368036; c=relaxed/simple;
	bh=dLfT/2fwONxxgBsVtxaLHV8JLu1cFuqKiO3pyuP3UYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0zsGVZShuIqmHORvbAsyWHJAEDDG0sw/YDeTSZMDArk14gN4ks/TrUDzScquL0WgyQGJolypPlAZao07IOg5m8elNmjdCm1CDWt268TX7iDfxoxwGy/EuuR83tbeLGn3FZchGQ2GhHWpeis//fnV7u2a5hN7M/ZUa9q81A0gwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUfym3uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE07C4CEF7;
	Tue, 17 Feb 2026 22:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771368035;
	bh=dLfT/2fwONxxgBsVtxaLHV8JLu1cFuqKiO3pyuP3UYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hUfym3uwC/0yai0ATEEjfypvEKaojpffA353VZb/1G41LRDcv4/jShCxlWemNHwlf
	 gUib7r3/3CCSiCiGqaupiukZ2mh8gQzwKWr5owqXDLYjFSX82YtwGPcKMYxX+GNkAg
	 Q2+yU0COAeyOqPVZbGmdnLQxYNgXT+R+Q9gQz/CNyGI7Vh19NkvtME1phqZfvoK3DZ
	 ci0cOBwKZXrkWU6qSQdU5iAn/SwasN7BrHqZtWIO3KE592scl/sBz3uEfoXVgqlI5+
	 QxegXecG/Ncg2EY+zkYa0B6XLn175co+gINWjHZTMLGbCoBSWKCEBOusYiDy37Ge6u
	 rxGuljxzDlCxw==
Date: Tue, 17 Feb 2026 14:40:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bhargava Chenna
 Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net] bnge: Fix typo
Message-ID: <20260217144034.6f497076@kernel.org>
In-Reply-To: <CAHLZf_v1R_9egWmHtkq2QttLYrG8FG=-whEQBw8vBLjmhq=RuA@mail.gmail.com>
References: <20260216140235.3764145-1-vikas.gupta@broadcom.com>
	<aZSPxEDPhyEVzAr_@horms.kernel.org>
	<CAHLZf_v1R_9egWmHtkq2QttLYrG8FG=-whEQBw8vBLjmhq=RuA@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259168-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 584A8151911
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 23:13:47 +0530 Vikas Gupta wrote:
> On Tue, Feb 17, 2026 at 9:26=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> > On Mon, Feb 16, 2026 at 07:32:35PM +0530, Vikas Gupta wrote: =20
> > > Fix the HWRM command type and use the appropriate command to reserve
> > > the resources.
> > >
> > > Fixes: 627c67f038d2 ("bng_en: Add resource management support")
> > > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > > Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com=
> =20
> >
> > I think this patch could do with a little more explanation.
> > It's not clear to me, at least: what the difference is between
> > HWRM_FUNC_QCFG and HWRM_FUNC_CFG; and why only one of
> > the instances added by the cited patch needs updating. =20
>=20
> HWRM_FUNC_CFG is used to reserve resources, whereas HWRM_FUNC_QCFG is int=
ended
> for querying resource information from the firmware.
> Since __bnge_hwrm_reserve_pf_rings() reserves resources for a specific
> PF, the command type
> should be HWRM_FUNC_CFG.
> However, HWRM_FUNC_QCFG was mistakenly used instead.
> Does it clarify?

Yes, please add this to the commit message.

Also please improve the subject. Something like (just a guess):

	bnge: fix reserving resources from FW

"fix typo" sounds like you're fixing spelling in a comment, it's not at
all informative :/

