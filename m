Return-Path: <netdev+bounces-125582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AC296DC14
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DE5B26832
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5318179BF;
	Thu,  5 Sep 2024 14:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604F1C6B8
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547106; cv=none; b=XkBGjQFtKdL8QoZn0qtbCq3ksTdR0NK5IxVNZoNb0APo33F/WNXGf9tgbLXRfmmowgWZWGaYaeGskJOCRuIq0MRMkQcO7qcr/tTbUWe0ALlC6H2pr5ey7lLDy6+BSZdy05vcO11TJ4JCtD7QQrU0Qj/FlABYE4dNwlIqeTB8fgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547106; c=relaxed/simple;
	bh=VShNH51JfLclSp6NZU/tvyrPw5N/uoPMEzeZ9cH21EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OduigysIIRxVdm9OyWMwdhtXAVjxZuToRoza28Ge/o5dZdsUs6wHXM6UMlSUagx5c8oPjEK8AHIVUQ8yvD/we3+wNWFk2VXYUdhn57niRS3QS0DILMeu2AFSmCHMhrIIsGYn77OdwMlIhhurc8/E+aPiuP7wCa19AneL2HPk7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-3xOOc6PIOfW_KTAJfSL_Sw-1; Thu,
 05 Sep 2024 10:38:17 -0400
X-MC-Unique: 3xOOc6PIOfW_KTAJfSL_Sw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9776219560BD;
	Thu,  5 Sep 2024 14:38:15 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AA103001D11;
	Thu,  5 Sep 2024 14:38:10 +0000 (UTC)
Date: Thu, 5 Sep 2024 16:38:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
	steffen.klassert@secunet.com, antony.antony@secunet.com
Subject: Re: [PATCH net-next v6 03/25] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Message-ID: <ZtnCUJOTO9d1raQV@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827120805.13681-4-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-27, 14:07:43 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 9920b3a68ed1..c5743288242d 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -115,6 +115,19 @@ config WIREGUARD_DEBUG
> =20
>  =09  Say N here unless you know what you're doing.
> =20
> +config OVPN
> +=09tristate "OpenVPN data channel offload"
> +=09depends on NET && INET
> +=09select NET_UDP_TUNNEL
> +=09select DST_CACHE
> +=09select CRYPTO
> +=09select CRYPTO_AES
> +=09select CRYPTO_GCM
> +=09select CRYPTO_CHACHA20POLY1305

and STREAM_PARSER for TCP encap?

> +=09help
> +=09  This module enhances the performance of the OpenVPN userspace softw=
are
> +=09  by offloading the data channel processing to kernelspace.
> +

--=20
Sabrina


