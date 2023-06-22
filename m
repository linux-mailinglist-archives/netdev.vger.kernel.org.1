Return-Path: <netdev+bounces-13198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C506373A94A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 22:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025CF1C2117E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15AC21087;
	Thu, 22 Jun 2023 20:03:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578220690
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 20:03:37 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3E1FED
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:03:34 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-YH5G9RGsOf6YXa3DPHP2Gw-1; Thu, 22 Jun 2023 16:03:16 -0400
X-MC-Unique: YH5G9RGsOf6YXa3DPHP2Gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0C25858EED;
	Thu, 22 Jun 2023 20:02:44 +0000 (UTC)
Received: from hog (unknown [10.39.195.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3143E200A3AD;
	Thu, 22 Jun 2023 20:02:44 +0000 (UTC)
Date: Thu, 22 Jun 2023 22:02:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, simon.horman@corigine.com
Subject: Re: [PATCH net-next v2] netdevsim: add dummy macsec offload
Message-ID: <ZJSo4lmt58B_66-3@hog>
References: <d6841a34b9d69af9ad5a652d5cabe3927868d3c6.1686920069.git.sd@queasysnail.net>
 <20230621131834.345f4f60@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230621131834.345f4f60@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-21, 13:18:34 -0700, Jakub Kicinski wrote:
> On Wed, 21 Jun 2023 15:14:46 +0200 Sabrina Dubroca wrote:
> > When the kernel is compiled with MACsec support, add the
> > NETIF_F_HW_MACSEC feature to netdevsim devices and implement
> > macsec_ops.
> >=20
> > To allow easy testing of failure from the device, support is limited
> > to 3 SecY's per netdevsim device, and 1 RXSC per SecY.
>=20
> Quoting documentation:
>=20
>   netdevsim
>   ~~~~~~~~~
>  =20
>   [...]
>  =20
>   ``netdevsim`` is reserved for use by upstream tests only, so any
>   new ``netdevsim`` features must be accompanied by selftests under
>   ``tools/testing/selftests/``.
>  =20
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#=
netdevsim

Ugh, sorry. I'll repost as a series with a selftest.

> --=20
> pw-bot: cr

--=20
Sabrina


