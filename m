Return-Path: <netdev+bounces-215291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAF2B2DED0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178EC726528
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E5264A60;
	Wed, 20 Aug 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uUXR33tq"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861F26FA5B;
	Wed, 20 Aug 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698949; cv=none; b=r3pC3CAr+Qn2j79Wd7OCB6PursU5hb4VRRbKl3ppuPOIf5KClFBySjZYBClFhoNG7e1/hlBpaDDQ4jFZwNQWMDMULzpz93G7ExsA+QYWalshHGPmy3yrOKFJO/WCxMzb/EHqXbT/sngCFjVLabnQK89TSgJRtebtpDKN19z5LJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698949; c=relaxed/simple;
	bh=g8KSnjw4Ck2JxcfN5+vo6c/ojSXjlUFQbHOQplOuqc8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=I5fCkYMCRfFZ8Eo+TqYke6XKzQVb4gejEvdzZiLeZ9ANEUE5cJnWSaMDorJ8Tbxp7T7F8CK5fxncp3M/hBxrsDdfskoxO7eJQsSMGUYQAxmdM4iF/1M31K0sml2Pa2e84rqqG363u32mGywGtHaChTaH/Y9rRsmDoy1QzmCtESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uUXR33tq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755698928; x=1756303728; i=markus.elfring@web.de;
	bh=ByLJAhTWUgqF+nGIUsOp5gmmTr+wHhVv6eR+4UUhWig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uUXR33tqVuLVGMBE+xaDMVHgpjt5UYjArs0URqRkaqs3RhsoWq/KZijLuluAAGuz
	 CjcIDNKk6x3tDqZv8hV1HCvjX6LFo2KuvzPvlDRIADQAb/LXSaPIHU3beSHqCndnV
	 5yXgTdJ55IQscGyGYZjYY/j38AtAkib++w2eTXP/b72jPbIYujK1xEewtzuKTTdcT
	 a1ycwDdxubG90BAFstFtlTQKqV1bcDtx+uf5JcY3kp0JBm42bm8MU6Bw1l+Wp3uXk
	 BmzRilwD3imvnvrgDfj6cPoBrJfN+tY3II+26RvHZD8OtS1r/A7dglQ9F4F2eqitT
	 hZ1Pk4eOaNJvAcxwBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8gP-1uYrTF22S9-00sasF; Wed, 20
 Aug 2025 16:08:48 +0200
Message-ID: <d02c9ad2-ea89-4e82-80ad-6d8359f154a1@web.de>
Date: Wed, 20 Aug 2025 16:08:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250820132708.837255-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH net] net: pse-pd: pd692x0: Fix power budget leak in
 manager setup error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250820132708.837255-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lBG2nQqrP2Uc9DgvosKWjyhJpuCkWsUnzw8HnRsVtt1VXx24NYL
 GOC0tgxisyBXLE0SijUa8dg1JIyX8PYbCBVwB9IxcQCd7pb4VlZSIhe667MYhRxh2BhrNA6
 hdqWNHDBnssz6gfB9Ty8Q6duv3pB3vfyNSbJ1nxZ8uuOCjByM4ud7bdK033EVVK5MY0jY+b
 FREFJW8Pp6Oqz9j1Xgsrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jGaLJwtiFKI=;Gykr+nKJp2wWNF7yNjne5XJUEWz
 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
 mXrmDj7WnPdHWhAPeOh

=E2=80=A6
> +++ b/drivers/net/pse-pd/pd692x0.c
=E2=80=A6
> @@ -1185,31 +1217,27 @@ static int pd692x0_setup_pi_matrix(struct pse_co=
ntroller_dev *pcdev)
=E2=80=A6
> +	pd692x0_of_put_managers(priv, manager, nmanagers);
> +	return 0;

How do you think about to apply the following code variant?

	ret =3D 0;
	goto put_managers;


> =20
> -		for (j =3D 0; j < manager[i].nports; j++)
> -			of_node_put(manager[i].port_node[j]);
> -		of_node_put(manager[i].node);
> -	}
> +err_managers_req_pw:

free_pw_budget:


> +	pd692x0_managers_free_pw_budget(priv);
> +err_of_managers:

put_managers:


> +	pd692x0_of_put_managers(priv, manager, nmanagers);
>  	return ret;
>  }
=E2=80=A6


Regards,
Markus

