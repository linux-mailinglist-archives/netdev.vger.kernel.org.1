Return-Path: <netdev+bounces-128504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEF979EC5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D09F1F23C79
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450514A0A3;
	Mon, 16 Sep 2024 09:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBD14900B;
	Mon, 16 Sep 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480326; cv=none; b=SrcVmuhheYenayJkZOlHmzBO1BYGku4/0YNgDyRd1U7x9bxpw+qxP7cDeot/9cylPsUG06YPBbay0/k0NCgVzbrvOPAYoSi1OQwu+DQfG/a1WLh5fPfL8HZBxM0MsQWatyCdXqfFvqOjHk8Y7T8P5H+SbaywxE9aYNzyZ0XVGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480326; c=relaxed/simple;
	bh=X2icocNhBXEuMZHjuTgfDcq3XClpztmChHcpGvDoJXE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6YSq1WDy4ANyUdfNMA4MWr7dlbFPM7R0QQrmCB4ttlJTxTAtgPuQSjUlxPsNtVGnJWhASslHFq0NTF93sLzVmMVFIpfKJ9/UMXrfiHEf0WnT2mJ9hhNf5wDv7N4XN43Tt7cuV852ijjgZ9EoJnZWoxI8M1U5NV/RjPE0obQIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6gDX3jWYz67JQP;
	Mon, 16 Sep 2024 17:51:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 346621400CB;
	Mon, 16 Sep 2024 17:52:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 11:51:59 +0200
Date: Mon, 16 Sep 2024 10:51:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
CC: <admiyo@os.amperecomputing.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
	<robert.moore@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, "Matt
 Johnston" <matt@codeconstruct.com.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Huisong Li
	<lihuisong@huawei.com>
Subject: Re: [PATCH v5 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <20240916105157.00001204@Huawei.com>
In-Reply-To: <a3f91c94-e829-4942-abde-193462769cba@amperemail.onmicrosoft.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
	<20240712023626.1010559-2-admiyo@os.amperecomputing.com>
	<20240801124126.00007a57@Huawei.com>
	<a3f91c94-e829-4942-abde-193462769cba@amperemail.onmicrosoft.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 17:21:06 -0400
Adam Young <admiyo@amperemail.onmicrosoft.com> wrote:

> >>+ * @shmem_base_addr: the virtual memory address of the shared buffer =
=20
>=20
> >If you are only going to map this from this pointer for the
> >initiator/responder shared memory region, maybe it would benefit
> >from a more specific name? =20
>=20
>=20
> I am not certain what would be more correct.
>=20
>=20
> On 8/1/24 07:41, Jonathan Cameron wrote:
>=20
> >> +	pchan->shmem_base_addr =3D devm_ioremap(chan->mbox->dev,
> >> +					      pchan->chan.shmem_base_addr,
> >> +					      pchan->chan.shmem_size); =20
> > devm doesn't seem appropriate here given we have manual management
> > of other resources, so the ordering will be different in remove
> > vs probe.
> >
> > So I'd handle release of this manually in mbox_free_channel() =20
>=20
>=20
> How fixed are you on this?=A0 mbox_free_channel is the parent code, and=20
> knows nothing about this resource.=A0 It does no specific resource cleanu=
p.


I've lost context on this unfortunately and don't have time to look
back at it this week. Maybe right answer is a cleanup callback?

>=20
> The only place we could release it is in the pcc_mbox_free, but that is=20
> essentially a call to the parent function.
>=20
> All other comments should be addressed in the next version.
>=20
>=20


