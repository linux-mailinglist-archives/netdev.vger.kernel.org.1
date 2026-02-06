Return-Path: <netdev+bounces-257373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NuIG4w1hWlf+AMAu9opvQ
	(envelope-from <netdev+bounces-257373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:27:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE5F89E5
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2A233077509
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8511F2B8D;
	Fri,  6 Feb 2026 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzua87+F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A225B305;
	Fri,  6 Feb 2026 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337459; cv=none; b=WePAaz8KrgFiLrZksEEuJF7F4B1p/xmcLKekRxwKa8xDtuVg9S3r10MTHQE3WUakmqRABnzpbWWqdyjiyuXU/DUYKc3KyXlMgdQVc63HMLb9Uf/koI+eAHqzSIW0LMPX3PLLLOeOE7MYYECHdvsRqql41Ns9vDh/RO9GuBnghoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337459; c=relaxed/simple;
	bh=FzacWZOycLmb1z1P+m8rf0bLUI57xeUY2XxyxSqj1DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blOs2dMbMtDliS/m4gtcgqsbXHorCrXM7/8tDbdxIzzObxXuaIIY3duDe2dT3/jGsuF7qJUQ4I8gVgQlzbqJ3HEwDCCLKtfYuvts76BWFXFwrcP+QBH3SFVU/a0EMGnmfYwJz7phtuHL10B/8TlD0rSCODa+aW+KMw8YfMQIews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzua87+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB709C2BC9E;
	Fri,  6 Feb 2026 00:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770337459;
	bh=FzacWZOycLmb1z1P+m8rf0bLUI57xeUY2XxyxSqj1DQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzua87+FqhXh4d7C9WvEmMdcUfxUI9Hh0bJUhOmF2sNG9XsmY9LDZ4bgVP8gleQ7L
	 BJ6CTciAADDmBlXHrBLSbXE7owLIOSaRiIE2rEmkbNL/wMmWlszHx6oM8SRjj5X7r4
	 7bAufw1Dcov3dTL2OTM+rxixImofgNsURQCsCeR22pyp4qOJNJO8yx8Mrw6hqhu6U1
	 o9clRGzeFMatqSUPnTukeML127ntkQCopL9ge3T8HdisWAtUbdWLDPdIguiKRbrdh9
	 swVthODJihsGUa6RHzInhUeBiizU/azNiggpVRQTW0l6hSF99Tn94uOlkdfyESzFnM
	 dLHvRc+m9hwTg==
Date: Thu, 5 Feb 2026 16:24:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 donald.hunter@gmail.com, pavan.chebbi@broadcom.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] eth: bnxt: gather and report HW-GRO stats
Message-ID: <20260205162417.3e735880@kernel.org>
In-Reply-To: <CACKFLinY4qNTf-pPQZ4R3efm8F4EnAiZsOqPknLcc32qTaiHUw@mail.gmail.com>
References: <20260205220541.2992807-1-kuba@kernel.org>
	<20260205220541.2992807-2-kuba@kernel.org>
	<CACKFLinY4qNTf-pPQZ4R3efm8F4EnAiZsOqPknLcc32qTaiHUw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DBE5F89E5
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 14:44:53 -0800 Michael Chan wrote:
> On Thu, Feb 5, 2026 at 2:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > Count and report HW-GRO stats as seen by the kernel.
> > The device stats for GRO seem to not reflect the reality,
> > perhaps they count sessions which did not actually result
> > in any aggregation. =20
>=20
> Yes, the HW count includes single packets without additional
> aggregations.  In the driver, when we see only 1 segment, we treat it
> as a non GRO packet.  That's likely the discrepancy you're seeing.
>=20
> Also, for completeness, should we count LRO packets as well?

Not in this counter:

      -
        name: rx-hw-gro-wire-packets
        doc: |
          Number of packets that were coalesced to bigger packetss with the
          HW-GRO netdevice feature. LRO-coalesced packets are not counted.

I don't think we have a counter defined for LRO, yet.

> > @@ -1814,6 +1815,11 @@ static inline struct sk_buff *bnxt_gro_skb(struc=
t bnxt *bp,
> >         if (segs =3D=3D 1)
> >                 return skb;
> >
> > +       if (bp->dev->features & NETIF_F_GRO_HW) { =20
>=20
> If we enter this function, NETIF_F_GRO_HW should always be true.

Ah, I see it now.. will drop the condition.

