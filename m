Return-Path: <netdev+bounces-273573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDq/Fs+ry2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:11:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D573688BB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A678305A71F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BB3A9610;
	Tue, 31 Mar 2026 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfFzbvRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9363822B5
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954873; cv=none; b=S3anyjzaf8U1N72QwQP5Wf55srx8cCoJ8w0mzBbNPAVRHQdPyWZs3T3JpS4KYca4K0bcxeYgjVmXC0g3k4baTdMWt6jW0sO1Mifzv0uAxZODMRqmtqa1pHumlUHj5G9MbnYG4My2D+hMUivicXaWGhoqAb+k5QCmKrwI8xGjGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954873; c=relaxed/simple;
	bh=EcqUphq1wWKi9Qrx2LqMu9kafXOOdcTX03pertRNwaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYvqFKeCi+n6uYQ4DQX+vPAjIQvIthIENSgJtBHMuF2jOho2ZHqm1svCzYELPHpHmDmiN4fEOf2FQC1YNsQXtUkto22mUoAx5nZ0z5emmLvK89kw+JMbjkCojaGpntdfLKcM9qp4r74eMLdOdf9Jl9ekGPIjmQtPZkq6ANGfjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfFzbvRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B238C19423;
	Tue, 31 Mar 2026 11:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774954872;
	bh=EcqUphq1wWKi9Qrx2LqMu9kafXOOdcTX03pertRNwaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfFzbvRc9ntIvLPffE2ihm5EwV/zP0QiKoUDYe4Ua2auvIHTAVUXvMllYf0H1Ca4B
	 snIqsUg6DGEXx8u/PwOK7h+ZHUOP27eCla2cdd4V+QTKPTgDbfxKBroZ+lDa7oQsDn
	 flG8FnSMVMcIpML9uzJ6g+LphiAAZh66lmsIBz37kF7C1XEgGxYuC7MzeZjZfmYijw
	 jsWb6jq8nw6kkWdY3B9EfYKqv4mCKaU5wzP6vt1Jc13IVZddt1gdrtbT28ZB1a991M
	 W9Ceg6nEPVPoNVrS4Paw6/2m1jXC11aw3g7w7I2b+3MYn4D4+jKt0GCcsZ+9m+/lO5
	 HXdehIJZCMqzg==
Date: Tue, 31 Mar 2026 13:01:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <Madhur.Agrawal@airoha.com>
Subject: Re: [PATCH net] net: airoha: Add missing cleanup bits in
 airoha_qdma_cleanup_rx_queue()
Message-ID: <acupditAioiehGSj@lore-desk>
References: <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
 <20260330172857.0c94685d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QNFGWspO91D9ZYhL"
Content-Disposition: inline
In-Reply-To: <20260330172857.0c94685d@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273573-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,airoha.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 36D573688BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--QNFGWspO91D9ZYhL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 27 Mar 2026 10:48:21 +0100 Lorenzo Bianconi wrote:
> > In order to properly cleanup hw rx QDMA queues and bring the device to
> > the initial state, reset rx DMA queue head/tail index. Moreover, reset
> > queued DMA descriptor fields.
> >=20
> > Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN758=
1 SoC")
> > Tested-by: Madhur Agrawal <Madhur.Agrawal@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Take a look at sashiko, please:
> https://sashiko.dev/#/patchset/20260327-airoha_qdma_cleanup_rx_queue-fix-=
v1-1-369d6ab1511a@kernel.org
>=20
> Looks somewhat orthogonal to the current patch but probably worth
> fixing.

Hi Jakub,

thx for pointing me to the sashiko's issues.

1- Could this code execute while the interface is still administratively up=
 and
   the hardware DMA engines are actively receiving packets?
   Looking at the teardown paths, airoha_hw_cleanup() is called before
   unregister_netdev(). Unmapping buffers and zeroing descriptor addresses
   while the hardware might still be actively writing to them could cause
   physical memory corruption and IOMMU faults.
   Should unregister_netdev() (which quiesces the DMA via ndo_stop) be call=
ed
   before airoha_hw_cleanup() to avoid this?

I think the issue described above is already fixed in the following commit
available in net-next:

commit b1c803d5c8167026791abfaed96fd3e6a1fcd750
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Sat Mar 21 15:41:44 2026 +0100

    net: airoha: Rework the code flow in airoha_remove() and in airoha_prob=
e() error path
   =20
    As suggested by Simon in [0], rework the code flow in airoha_remove()
    and in the airoha_probe() error path in order to rely on a more common
    approach un-registering configured net-devices first and destroying the
    hw resources at the end of the code.
    Introduce airoha_qdma_cleanup routine to release QDMA resources.
   =20
    [0] https://lore.kernel.org/netdev/20251214-airoha-fix-dev-registration=
-v1-1-860e027ad4c6@kernel.org/
   =20
    Suggested-by: Simon Horman <horms@kernel.org>
    Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
    Reviewed-by: Simon Horman <horms@kernel.org>
    Link: https://patch.msgid.link/20260321-airoha-remove-rework-v2-1-16c7b=
ade5fe5@kernel.org
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

How can we go ahead on this?

2- This is a pre-existing issue, but while reviewing this cleanup path, I
   noticed a potential NULL pointer dereference if initialization fails ear=
lier.
   If devm_kzalloc() or dmam_alloc_coherent() fails in airoha_qdma_init_rx_=
queue(),
   it returns an error before netif_napi_add() is called, leaving the embed=
ded
   q->napi struct zero-filled.
   However, q->ndesc is set earlier in that function. Since q->ndesc is now
   non-zero, the error cleanup path will try to disable and delete this
   uninitialized NAPI structure, leading to a crash in napi_disable() when =
it
   calls hrtimer_cancel() on the uninitialized timer.
   Could we defer setting q->ndesc until after the allocations succeed?

I think it is fine to set 'q->ndesc' at the end of airoha_qdma_init_rx_queu=
e()
routine but, considering net codebase, it seems the issue can't occur since=
 if
airoha_qdma_init_rx_queue() fails as described above, airoha_probe() will j=
ump
to error_hw_cleanup and netif_napi_del() in airoha_hw_cleanup() will return=
 if
NAPI_STATE_LISTED is not set in __netif_napi_del_locked().
Am I missing something?

3- Is there a missing reset for the CPU producer index (REG_RX_CPU_IDX) her=
e?
   The hardware DMA relies on the gap between the CPU and DMA indices to
   identify valid descriptors. By rewinding the DMA consumer index (REG_RX_=
DMA_IDX)
   to q->tail while leaving the CPU index at its old, advanced value, could
   this create a phantom gap of descriptors?
   If the DMA engine fetches these zeroed descriptors (with addr =3D 0), it=
 might
   attempt to write incoming packets to physical address 0x0. Both indices =
might
   need to be synchronized.

I will post a fix for it.

Regards,
Lorenzo

--QNFGWspO91D9ZYhL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCacupdgAKCRA6cBh0uS2t
rGAkAQC7aPrumxUx8kh0xKYbqQ6DhGvSZuNb2kDhfm3oCwm/cwEAle7Pisx9yp5u
VAyedjuT92Ot4VKnlokdUVIpSYjhOwY=
=x2rz
-----END PGP SIGNATURE-----

--QNFGWspO91D9ZYhL--

