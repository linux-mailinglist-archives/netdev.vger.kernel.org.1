Return-Path: <netdev+bounces-154556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3BC9FE935
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06ED16257E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9F51ACED9;
	Mon, 30 Dec 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="WaSSJ8th"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043218C31
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735577962; cv=none; b=Cvnl0oclimevsmrhUR6QvRuJtIMGCdvSZw3AxaRZUpmwPANGSzb2skzlQj/HkfDEFF3rocMk/6mHySlfARACLx7IfZKL4aOgkq1Z19pjwGIoSHnHJw2QQSgGaP4M6ZLA9HUFdW1ypmk/B/cZTDdJhB9P/0J3L1OK4jldA/qxnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735577962; c=relaxed/simple;
	bh=efy13DgWLJ/WFV0jeDH3O7vKmb4JBCD9u29USH37bdc=;
	h=Date:To:References:Mime-Version:Content-Type:Cc:From:Subject:
	 Message-Id:In-Reply-To; b=Ps+GPNtyGS7k5JurrwK2rfSvpSeWYm8LSLTHKdJFGAMugmjl++gd8k8jJW4/Hq5p1ZT1yrSNakV6HTa0Hhxz24uhNeZJmwMFtb6dABsmoaVHtbm9U+o9KFq92j39HzQdvGvH4s8SLq4Ca8/9d2e4XmNsl5FCi6JszQaSvzCEn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=WaSSJ8th; arc=none smtp.client-ip=103.149.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735575208; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=aPh32+WNML/B2iNEfBnl2wxyyix9AllL7bXnF7ybylY=;
 b=WaSSJ8th8TVIkfHhiTu7BCfoU0lPpHP7MYn7wyM5e81ikZpboqMFZT1sGTmICCA7GP7h0D
 8KPcmN+mD8oXZTljv60VxRe2tUFQ8dPwRJKNoKrTm94EOtzdPwxvjNNCqmMVmi/K5DyIfU
 0VUlgof0TXWbe911TKsFksnrXH9gFMx5ccawNQ9L8bIy45iEBKzVaNeUT+NodM5QIKuXS3
 ejBmzEM0twH6Y7DNLUIie2lqv4ybZg8GVMENLVUglorx3GNcJoTAFYBP2lKu0arGG6x3pS
 pf+/+ZVUbtns5PzcRtSWqU35T1DbzfHVwYHYsPYFaWaYxra2vCax3/tvJ0RvSw==
Date: Tue, 31 Dec 2024 00:13:23 +0800
User-Agent: Mozilla Thunderbird
To: "Andrew Lunn" <andrew@lunn.ch>, "Xin Tian" <tianx@yunsilicon.com>
References: <20241230101513.3836531-1-tianx@yunsilicon.com> <20241230101528.3836531-9-tianx@yunsilicon.com> <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch>
Received: from [192.168.71.93] ([114.86.21.5]) by smtp.feishu.cn with ESMTPS; Tue, 31 Dec 2024 00:13:25 +0800
X-Original-From: weihonggang <weihg@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26772c6a6+e6f9a6+vger.kernel.org+weihg@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<wanry@yunsilicon.com>
From: "weihonggang" <weihg@yunsilicon.com>
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Message-Id: <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com>
In-Reply-To: <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch>
Content-Transfer-Encoding: quoted-printable

Andrew, In another module(xsc_pci), we check xdev_netdev is NULL or not=20
to see whether network module(xsc_eth) is loaded. we do not care about=20
the real type,and we do not want to include the related header files in=20
other modules. so we use the void type.

=E5=9C=A8 2024/12/30 =E4=B8=8B=E5=8D=8811:29, Andrew Lunn =E5=86=99=E9=81=
=93:
>> +static void *xsc_eth_add(struct xsc_core_device *xdev)
>> +{
>> +	adapter->dev =3D &adapter->pdev->dev;
>> +	adapter->xdev =3D (void *)xdev;
>> +	xdev->netdev =3D (void *)netdev;
> Why have casts to void *? There are clear type here, rather than it
> being a cookie passed via an abstract interface.
>
> 	Andrew

