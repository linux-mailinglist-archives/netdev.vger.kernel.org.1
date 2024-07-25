Return-Path: <netdev+bounces-113006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7993C317
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 15:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56F91C20E34
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564451991C2;
	Thu, 25 Jul 2024 13:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A5C8DF
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914359; cv=none; b=IFNOYkcejLdk5aBFjEiuZcxaigrQA8Ocpb8u/VYVSyyvajiUKwu2PmziWAnmz0avdZjbB3VTx+z/a6PEDKFzIOwpBBao70P6vvxzLjVUkAzj0qfkhBBUg3OIT5jLQHWOIa4T9S5+512rtHqejbzVA2tXUMwIOBK+8hxCYlWYah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914359; c=relaxed/simple;
	bh=K4PTR5RVg2pOKD+K6GouP8AuPg4312hCwMR2q2BzxKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QUYstJfOMwyfdOAN7Ag7Xi/d2QRf53u0Nnn4A2IUAKsp7vpJHztvAUQ6zR8wqOeG9Wtq8LQyrDJtqV9dvwTwlO7tl2RmdQOfFhMOl/NzsGOQkgHFIY1pcrjmh7fT1X4VtpcBiwr2lXBMKIZ3rFBIb5N2yVJJaPhMjvPTwa95vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-fHE8KkJHPdmlpXb_nemvMw-1; Thu,
 25 Jul 2024 09:32:25 -0400
X-MC-Unique: fHE8KkJHPdmlpXb_nemvMw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A814A1955EB4;
	Thu, 25 Jul 2024 13:32:23 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06F231955D45;
	Thu, 25 Jul 2024 13:32:20 +0000 (UTC)
Date: Thu, 25 Jul 2024 15:32:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 06/17] xfrm: add mode_cbs module
 functionality
Message-ID: <ZqJT4llwpzag1TUr@hog>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-7-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240714202246.1573817-7-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-14, 16:22:34 -0400, Christian Hopps wrote:
> +struct xfrm_mode_cbs {

It would be nice to add kdoc for the whole thing.


> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 7cee9c0a2cdc..6ff05604f973 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -494,6 +497,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __b=
e32 spi, int encap_type)
> =20
>  =09=09family =3D x->props.family;
> =20
> +=09=09/* An encap_type of -3 indicates reconstructed inner packet */

And I think it's time to document all the encap_types above the
function (and in particular, how xfrm_inner_mode_input/encap_type=3D-3
pair together), and/or define some constants. Also, is -2 used
anywhere (I only see -1 and -3)? If not, then why -3?

--=20
Sabrina


