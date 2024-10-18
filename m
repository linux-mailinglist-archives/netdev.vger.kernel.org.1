Return-Path: <netdev+bounces-136908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6519A396F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E221C235A8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA614389F;
	Fri, 18 Oct 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DyV1Kjz1"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BE18C333
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242493; cv=none; b=LP0oMWyB5V6c3cFgWRBgJ+zYUSHKobcRDMsMxGNm9QwGAtrN3YrL0Nbu+fiSMbEtGNyqSbSoQOy+p+qs1JHeNx6emtS5t/AAjk+3lm19+mKX4thY2VWkrvF2oQA8Y3pRGWKZvwNYF39pOhkEzPUThRNxrJq/jstMgvnGARD5ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242493; c=relaxed/simple;
	bh=YMmcc3Wis3icc3aLPMDq8dbste7mP+UuAIULbxcjKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdspVc/h/NA8SeZevmjMlN+9hvmMM+NUIeInDa1rexCq9iO+3m4VgbtGGeK0hIvX/+3ptv9S/6wiUiyDVqdhuaHAo8tGy+f5v4VDtMlqm/BAES8k43by34oBh8ITcuRBoEfztRoB5KOziVmIG8zT5bWGJuDzAnVl5HniQWXV0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DyV1Kjz1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64A6240004;
	Fri, 18 Oct 2024 09:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729242484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUsHrBhukW8VmSLp5C/rG7na1wFrgU0GeCjk8CLxAvc=;
	b=DyV1Kjz1BDlTWQlths+hSne+oBNp0Jrmt7x3KY3W2d3jsS9g+6EvVvzAsAy3X7tkT07UOx
	kchRfwkDtQMs33ZUOLgkWh9TxMQNeCBcgP2gFhorAZGg+PG7DLKWabMRmPMhp0g1NdGARD
	YG+NXyJiHQ3hWlA0u/ZcIf1+h+kpHoKNwVY0x6753FsS2T1xSmiG6kdgXXZrYIS2JWAzo1
	96XqcmG4b/mcwSqwqaUv/j8MwlWiFBkgKMIvBadqz6Fe/GazNKjJce0QqP31zzKLPJBDwm
	A+CRUu2MQwAzdvUVTrnS5CGGAyWIixka2dJDBvrQzIrMi+WOQtBUHGjd8zwPqw==
Date: Fri, 18 Oct 2024 11:08:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] netlink: specs: Add missing bitset attrs to
 ethtool spec
Message-ID: <20241018110802.6e467882@kmaincent-XPS-13-7390>
In-Reply-To: <20241018090630.22212-1-donald.hunter@gmail.com>
References: <20241018090630.22212-1-donald.hunter@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 18 Oct 2024 10:06:30 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> There are a couple of attributes missing from the 'bitset' attribute-set
> in the ethtool netlink spec. Add them to the spec.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Tested-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
=20
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Closes:
> https://lore.kernel.org/netdev/20241017180551.1259bf5c@kmaincent-XPS-13-7=
390/
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com> ---
>  Documentation/netlink/specs/ethtool.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/netlink/specs/ethtool.yaml
> b/Documentation/netlink/specs/ethtool.yaml index 6a050d755b9c..f6c5d8214c=
7e
> 100644 --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -96,7 +96,12 @@ attribute-sets:
>          name: bits
>          type: nest
>          nested-attributes: bitset-bits
> -
> +      -
> +        name: value
> +        type: binary
> +      -
> +        name: mask
> +        type: binary
>    -
>      name: string
>      attributes:



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

