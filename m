Return-Path: <netdev+bounces-52572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D767FF3AE
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE870B20C95
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B477524BA;
	Thu, 30 Nov 2023 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADF910C2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:36:22 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-g4Xi-z4AObWIR-u41jy2cg-1; Thu,
 30 Nov 2023 10:36:17 -0500
X-MC-Unique: g4Xi-z4AObWIR-u41jy2cg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E095D29ABA09;
	Thu, 30 Nov 2023 15:36:16 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 20D1CC1596F;
	Thu, 30 Nov 2023 15:36:16 +0000 (UTC)
Date: Thu, 30 Nov 2023 16:36:15 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 5/8] iptfs: netlink: add config (netlink)
 options
Message-ID: <ZWir75Z_0CRA7RYI@hog>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-6-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113035219.920136-6-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-12, 22:52:16 -0500, Christian Hopps wrote:
> @@ -3046,6 +3056,12 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] =
=3D {
>  =09[XFRMA_SET_MARK_MASK]=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_IF_ID]=09=09=3D { .type =3D NLA_U32 },
>  =09[XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
> +=09[XFRMA_IPTFS_PKT_SIZE]=09=3D { .type =3D NLA_U32 },
> +=09[XFRMA_IPTFS_MAX_QSIZE]=09=3D { .type =3D NLA_U32 },
> +=09[XFRMA_IPTFS_DONT_FRAG]=09=3D { .type =3D NLA_FLAG },

Do we want to be able to turn this off with an update? Flags don't
really allow this.

--=20
Sabrina


