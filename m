Return-Path: <netdev+bounces-300168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UTSRC8KXMmot2gUAu9opvQ
	(envelope-from <netdev+bounces-300168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:49:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE11699D9B
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:49:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=N+skJEbE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300168-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CD69301A90B
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB803EEAE9;
	Wed, 17 Jun 2026 12:48:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D93EEA8
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:48:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700536; cv=none; b=Gw4DGhPDr6O0xTFs2Nca/qT4yPtrnLZwo/SPMfwqcRoaDbZpN1eXVNHICaRQRl8GefQIQHMIMrUx5xkuWERguViUmu/DqWZlwq4cjV59Ue9Mqx2tvNZuuwXliFCEEoJLeVi78BrV9SW6UjEZgIykv9LlNkIPppGd4atoJFZ54Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700536; c=relaxed/simple;
	bh=IMIppte+gBwuC5XbBRIXlUQ0aozwvo/6xvW4VF9LfrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2zBo64Xm27ocazIGH9Xm8vBDQXgi44uMGa3qDJo7dWFPd7RBwzhc5L3kkxnNxGhgHTai/uTqFaz4A/aOifxwxlv1zerye/HmSzbsGvngGF7qzWa5utG+mEA8ouQnn1fLBGHk3AHPT330TqMqOut1xu2pBqp2484EmhcmcMZQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+skJEbE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9831F000E9;
	Wed, 17 Jun 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781700534;
	bh=IMIppte+gBwuC5XbBRIXlUQ0aozwvo/6xvW4VF9LfrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N+skJEbER87qujetlVk/j6Tkuyd1Vhrm3VXBA4mpK2P60nXN0b5oN1qOIIW6l7Wyj
	 2ms5f0Emq1qAEDkoFKTGqjGgSEtOPjFRk7/XMQBuCoSq6Nvn4CIfyx9BEHS8kIaHzk
	 aTjbGFxY9/L25JBs+T0SFQPMOKYOTOsaunEOmJQPHli7aEr6PlvgTDOQJ2VKMMSCdB
	 q7CRFMHrvi2z+xZaTYC/7Dsa3rYsqlHPTf2v/6JhZoacfchH8uET0V1q8BeohY8UJO
	 vs/F03aR3R1MwdkUoN5GqAtbKaI9jlrVPlelxSmRugQLTvpKc+PNOafKH1LhBkNzKp
	 NHJ3OkNZj3iXw==
Date: Wed, 17 Jun 2026 14:48:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] [net] net: airoha: Clean up RX queues in
 airoha_dev_stop
Message-ID: <ajKXtDxPipRcA20X@lore-desk>
References: <178161160256.2165161.14322392784449633554@gmail.com>
 <178170026659.2238511.17652659042899875248@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dwA6XgDlcLvaJ+Fq"
Content-Disposition: inline
In-Reply-To: <178170026659.2238511.17652659042899875248@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EE11699D9B


--dwA6XgDlcLvaJ+Fq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thanks Simon for forwarding the AI review. I've reviewed all three
> concerns:
>=20
> #1 (NAPI race) and #2 (RX refill) are valid. #2 is the decisive
> issue: airoha_dev_open() has no RX ring refill, so draining the
> queues in stop would cause RX stall on next open. This aligns with
> Lorenzo's earlier feedback =E2=80=94 RX queues don't need cleanup in
> dev_stop(). I'll drop this patch.
>=20
> #3 (q->skb leak) is a pre-existing issue, not introduced by this
> patch. It exists even in the module unload path
> (airoha_qdma_cleanup()). @Lorenzo =E2=80=94 do you think this warrants a
> fix? A one-liner in airoha_qdma_cleanup_rx_queue() would cover both
> paths. Or is this too unlikely to matter in practice?

Soon I will post a patch to run airoha_qdma_cleanup_tx_queue() just in
airoha_hw_cleanup() so I think we should just drop this patch.

Regards,
Lorenzo

--dwA6XgDlcLvaJ+Fq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajKXtAAKCRA6cBh0uS2t
rKmiAQDehtR9VrdOdbmTSHIKJQn9uL7BkvVVXPg39gdOUoJbDgD/cL9I+HyY/qdR
q4EY1FHiIibYx/ptSfwkEGZI8MtXrgg=
=owDH
-----END PGP SIGNATURE-----

--dwA6XgDlcLvaJ+Fq--

