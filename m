Return-Path: <netdev+bounces-268343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBGOGQKTuGkUgAEAu9opvQ
	(envelope-from <netdev+bounces-268343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:32:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904A2A2005
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34085303DAD8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C933C53A;
	Mon, 16 Mar 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN1fRzFk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5B26E6FA;
	Mon, 16 Mar 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703893; cv=none; b=Bm5R16rDIjgpLUcSpKh0wilSgvZ2KWx11yckNZu4T8Sj44VNnITX4yTHMmKSoLAF7xBOV2aM/kJ2PWxrOeWPMr5IccM6DmEFLxLqrNoFpuyqvHqqyWUpMLmRDjLL+MSJmicxNuA4R0iOMpASRw91DQ/FdeZcOlqlsfzFNilh9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703893; c=relaxed/simple;
	bh=mokbVaSNGRbUCQQ4SGbI4E3yKDImZ3QdINhNbLzi8Po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJOxktom5xoSENDTSL6KYlNk5xLg/ZFHmKCTk/7PNpeuPAtJ1fqvrfOoThwvOPdpP5gtRYVsv751Y0iXrtySzmHawfvtq6Na3fGveEKbj6yXc6/8TqiJgpnFdgAWSlp4OwnbrZKVFZDxIh7k1cqUfq9cyF4vviGIUAGQPDVWboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN1fRzFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A749C19421;
	Mon, 16 Mar 2026 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703893;
	bh=mokbVaSNGRbUCQQ4SGbI4E3yKDImZ3QdINhNbLzi8Po=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hN1fRzFkuoAPo5qf7cCUj/3UZ74Zrg2FGMIpeV+WXs3DgSmup1ufDh90hMZjFc0TC
	 DFJ5TZCjZPQKQKjORnD6nXc/kg4X+SL6SJtuFZKzc/SmJH8x3Lpni7zXRGSJmC7zCx
	 g7VH7wJOZJqANs6wbO3dzR0eI7+48NtQaOEffLB3o9yHJpLmt0FdQpGcv1EWJJtNb/
	 ADvmnC44FS9xSHGIWnlJtVwSRO6c9ouBQkKC+O0VI4rosda2SYh3oAyxbDRgyDV0SU
	 SPJVnJB69/VFFVSBjUhPhbnu67KO1WBCN7X1nUwGRmGsi0HPAY8in067EPcMCo8ChC
	 2fFBt9f9P7NSg==
Date: Mon, 16 Mar 2026 16:31:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 intel-wired-lan@lists.osuosl.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v4 0/3] ethtool: Dynamic RSS context
 indirection table resizing
Message-ID: <20260316163131.2ff161c5@kernel.org>
In-Reply-To: <87a4w9p95i.fsf@all.your.base.are.belong.to.us>
References: <20260313071322.3489243-1-bjorn@kernel.org>
	<20260314093518.43b820b7@kernel.org>
	<87a4w9p95i.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0904A2A2005
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 13:30:33 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>=20
> > On Fri, 13 Mar 2026 08:13:12 +0100 Bj=C3=B6rn T=C3=B6pel wrote: =20
> >> Some NICs (e.g. bnxt) change their RSS indirection table size based on
> >> the queue count, because the hardware table is a shared resource. The
> >> ethtool core locks ctx->indir_size at context creation, so drivers
> >> have to reject channel changes when RSS contexts exist.
> >>=20
> >> This series adds resize helpers and wires them up in bnxt. =20
> >
> > Sorry Bjorn, I was typing the explanation below and I realized that=20
> > we may be violating user intent. We should already record the user_size
> > from rss_set_prep_indir() as part of the context (and presumably some
> > netdev state for the main context?) and don't allow shrinking the
> > context below that mark.. =20
>=20
> Don't be sorry! Good catch, and glad you caught it now rather than after
> it landed.
>=20
> I'll respin with user_size tracked in the context (and netdev state for
> context 0) as a lower bound, so resize never folds below the size the
> user explicitly configured.
>=20
> WDYT?

Yes, keep in mind that AFAIR context 0 is not currently tracked
in the xarray. So maybe add the size of the main / default context=20
as a field in struct ethtool_netdev_state ?  Or we can start tracking
it (partially). IDK what's cleaner.

