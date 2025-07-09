Return-Path: <netdev+bounces-205345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B157AFE38C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0477A1D59
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271C272E63;
	Wed,  9 Jul 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="kAAfCPbM"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F50235072
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052008; cv=none; b=CeIv3f3kpNxn/gLgfcrE3h2Dq3XgWMkykzGPhiJtvHMqfOd0uN4/XFlIz1SM1mz/yjpHWF8O5wbTairViP3cL9GLmMiVX6Yph+tsMXnYw+R8iTqWKCXl4pnTly7+baAkUi62vsNyAWK7kKj5ohq8YWBY9uUffXSe2fXFCrWKZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052008; c=relaxed/simple;
	bh=AfoilYlfWpGEd3haBozvUrrcMqpQ5UsOkIzMDxt8kkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULxn/wvTs5tx/wXu/kLKH8Qr5UITOgey6HY9HcCS9YZs6RFUq2C5nLYSGopG37PmFq74MrD1MudPOAl7UisywdvCdxlphu0lEQuJtoAIHYlzsic6njmrm41x+WWzxszPnJi7Xm07YX+drnkp6KDFrjuFhIs+3gr5B4ByAG9FHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=kAAfCPbM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752052005;
	bh=AfoilYlfWpGEd3haBozvUrrcMqpQ5UsOkIzMDxt8kkc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kAAfCPbM4MOSjCZwPzmbeW/5sHLIMiSyvT6Lv5oAjC1f0ZpANO15Wu7CFWmnfbh+z
	 EV1K0BHNRHeqzivZhbYEHm5VQNXz7BcnJpeJuNguqdp1ljS2FJh3GEh3ezVdqQjHaC
	 4wW8pnD03sZL+WZmNRFEojA5g3s7/lQOrVVLc4Na5k3wKo7aekqVBdqDrfBR4T012q
	 bPfg8YwlHT8Lzs/MrbzxChZPdJb8XcgvBOxZED4ZncAByyBJ6RTvwI4dKt8o95Ohbp
	 9FZDYSRcDvndAKyb2oYOjsTArJQ1Oo3YVV7l/ZI1UBCLZecfEoqFMocQPbGnJcXFYM
	 eYo7314Y6UJnQ==
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 17025640A0;
	Wed,  9 Jul 2025 17:06:45 +0800 (AWST)
Message-ID: <b6f1f50490db59454bca1cbe8edbf4ead85c7383.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v3 1/8] net: mctp:
 mctp_test_route_extaddr_input cleanup
From: Matt Johnston <matt@codeconstruct.com.au>
To: Simon Horman <horms@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Date: Wed, 09 Jul 2025 17:06:44 +0800
In-Reply-To: <20250709090311.GP452973@horms.kernel.org>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
	 <20250709-mctp-bind-v3-1-eac98bbf5e95@codeconstruct.com.au>
	 <20250709090311.GP452973@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Simon,

On Wed, 2025-07-09 at 10:03 +0100, Simon Horman wrote:
> >=20
> > Fixes: 11b67f6f22d6 ("net: mctp: test: Add extaddr routing output test"=
)
>=20
> Hi Matt,
>=20
> What I assume is that commit seems to have a different hash in net-next.
>=20
> Fixes: 46ee16462fed ("net: mctp: test: Add extaddr routing output test")

Yes that's correct, sorry I missed updating that.
I'll fix it in v4.

Thanks,
Matt

