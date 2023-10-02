Return-Path: <netdev+bounces-37493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD27B5A7D
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E119D1C20491
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148051F172;
	Mon,  2 Oct 2023 18:54:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C341E503
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 18:54:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D95AC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696272874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmM5ZNDegeZhf5s/Nz9vdWgDVovgTarUhb8l/wE2St4=;
	b=eGSmRxGEY6t+7qV28wsJn+Y8bSJ7CRhqO2v74Iw1gGMf5m6wb5zTA011gJtDJqPskXku9S
	gHiVvMKA3XPjHjMPHEVlfDaHKHegouvbffhqrPlsa5k+0RrDS/2XvT7HVzD2vUdUvXIyBb
	EwyIERF1tk6RXAzVbTed6x5yapLamcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-W4uLBja-N5WWgJ9pUCQOhA-1; Mon, 02 Oct 2023 14:54:22 -0400
X-MC-Unique: W4uLBja-N5WWgJ9pUCQOhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24FD3101A59B;
	Mon,  2 Oct 2023 18:54:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0BD310EE402;
	Mon,  2 Oct 2023 18:54:21 +0000 (UTC)
Date: Mon, 2 Oct 2023 14:54:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: Spelling s/preceeding/preceding/g
Message-ID: <20231002185420.GB1059748@fedora>
References: <b57b882675809f1f9dacbf42cf6b920b2bea9cba.1695903476.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fuzmqqeB7+mI12HN"
Content-Disposition: inline
In-Reply-To: <b57b882675809f1f9dacbf42cf6b920b2bea9cba.1695903476.git.geert+renesas@glider.be>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--fuzmqqeB7+mI12HN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 02:18:33PM +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "preceding".
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/vhost/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fuzmqqeB7+mI12HN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUbEdwACgkQnKSrs4Gr
c8jm3wf3SybCVag7HhsRlbQBB2qCWSsI12mkvW0sXMAwLbLvfBANqEWmTzmywolz
wzPqtLEJrTAScwq8jHk8r9R+V8Sq+thDzpNdI08PCGDVriCt8LBEgDIjvs0EvSNP
rAhQxFxP5ciDKCRnnVq3cdXdzwPdkKNifj02HiaXQknBCE99vXD71LTwYLY4MBXI
fIfva8/FlebeJYdBU91I9alORHAnlmgE7xZWh3j9QN8b+hT6TQKbcVKan2Z+/Zj+
uEsjUWce8P3nTF8jd1AkjFDTegRXSmc9TKX2iqiglCBRZPUT8Ya2pSacmGdk2Lm/
mNLVJfYcDmicuRAkTrTsok4iECvw
=P1kz
-----END PGP SIGNATURE-----

--fuzmqqeB7+mI12HN--


