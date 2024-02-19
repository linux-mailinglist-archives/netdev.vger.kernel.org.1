Return-Path: <netdev+bounces-72867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE92785A021
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3431F218B1
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F4A24A1C;
	Mon, 19 Feb 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Dc14t3/E"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE22560B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336130; cv=none; b=RnTsO3HUkZf5R3OGPxdXXlwszb7U5AuexqMtoyxgSdmk/6EuGQWCQ6iBgDS8uEh1/vTq5o8gyozOWvNFo+MZhaJXEsXu30XgBFvAv45QkOaiWAseOwwAnT8X5bqAXHR++CX8A8KX4cD+6g77BcHfquIuhr1hU3oITSYDeddN34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336130; c=relaxed/simple;
	bh=znGfgWHVkB6v/FAXid5dXsdBs/89A2AbgcUp1qU/qjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3gsNE9Boc/xfMO5QqflBDWt3dBbvIVV1NLUqK75MPigY7Zkb+hFZM7yrDxcULvDbfe+zn28cXjO4xl3WD5olcD164MWYscWff+UM7NcabIY68XUOi7gWO39hMsd+7BixAdPMHInM24h6FU8JZjRsnQjT80pSkJY6aULEntc6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Dc14t3/E; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9F6B120016;
	Mon, 19 Feb 2024 17:48:40 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336121;
	bh=ajKyt/OSLz1bZTVzroY9kMSeBgQHijsghqIarpRALLE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dc14t3/EuPy4zSMh+EKx1Rl5aM9b3wyNAwgGo2kgcACmtsHzW5f2rJjcG/ZQC6mh/
	 NU6jos0J9S444pwQJBLrnBWQD9YaKFsEyYiY5Aqtcbyj/7eiYIYv4DRYKzVxvR03Jo
	 0ZiCPKCLWPMrek6KI2D546FtOWUSqQjo36NsiwsjyKE/xHANROae79zpkp8YtObNHa
	 rRk8ERv73yh77IOO8mRJOXCduWhQcfPvGSOhnwWIYWHce2AObWix35Ckx4vbRFSgwc
	 0RVgZJGGRBhVyFcgf18AUeOvY9yIDT7K34S3S0Zavp9tuZUzdT+FHssz4MEDdX113q
	 y+WeT73ik6/Kw==
Message-ID: <0462f31646e5ff0cc8ad2f6dc0529ecc2ba71f02.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 06/11] net: mctp: provide a more specific tag
 allocation ioctl
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev, 
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, Matt Johnston
 <matt@codeconstruct.com.au>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Howells <dhowells@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Liang Chen <liangchen.linux@gmail.com>, 
 Johannes Berg <johannes.berg@intel.com>
Date: Mon, 19 Feb 2024 17:48:40 +0800
In-Reply-To: <95174361-e247-4792-866b-d77152659fd6@moroto.mountain>
References: <95174361-e247-4792-866b-d77152659fd6@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan,

> 28828bad95a357 Jeremy Kerr 2024-02-16 @389=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (!(ctl->local_addr !=3D MCTP_ADDR_ANY ||
> 28828bad95a357 Jeremy Kerr 2024-02-16=C2=A0 390=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctl->local_addr !=3D MCTP_ADDR_N=
ULL))
> 28828bad95a357 Jeremy Kerr 2024-02-16=C2=A0 391=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
>=20
> Should be &&.=C2=A0 This function will always return -EINVAL.=C2=A0 I hav=
en't
> looked at the context outside of this automatically generated email
> but it suggests a failure in our test process.

Nice catch, thanks.

The issue means it would *never* detect that (not ANY, not NULL) case,
rather than always returning -EINVAL; so my ioctl test passed, but we
wouldn't have caught the forwards-compatibility check.

Given the potential for confusion here, I'll go with the simpler:

	if (ctl->local_addr !=3D MCTP_ADDR_ANY &&
	    ctl->local_addr !=3D MCTP_ADDR_NULL)
		return -EINVAL;

Jakub: I will send a series v2 soon, including those kunit all-tests
changes.

Cheers,


Jeremy

