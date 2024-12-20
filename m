Return-Path: <netdev+bounces-153603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF69F8D11
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F716507B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550C198823;
	Fri, 20 Dec 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="UfHHaw0v"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F0143895
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678441; cv=none; b=G8nynYnq8MWwluzXJfXWWEjjNUaYQQMoXO+vtWC0CPeomk8kC9s4zYZ3oCXE8nweJZ7oXtvprrj5vVevBBPQ1hBkWlbwvU/zllnRiveSKrB3F1LC+6df8OAhZsOguKhqO3w8KHvbBsqfFWrKc+zcYVtcL+N0N7bnzV3qhQ48UaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678441; c=relaxed/simple;
	bh=8+SnHvjcsqSWZ64PtxHe93n2GTHJmSFulLase6qJQUo=;
	h=Subject:Date:Mime-Version:Content-Type:To:Cc:Message-Id:From:
	 References:In-Reply-To; b=VvHlIVYdcT9Betov+0Orny0FOhVt7BwRhDqWSAw1V3fMz3RihGsXbXLqMaGtPMt22NahrDyURbjv7wy9Qb82W5EFq1aX6XM5S496C2FRIUaw5siMY0lpC1g0h3Y/Z7sQanBb23cx7ckPFXV/k3qp5asSeWIi2+0TpLdiBqrsUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=UfHHaw0v; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734678431; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xXo+LQSdFf6Qlvu8DFlTdKTDicmgb3071bT5uy2uTGw=;
 b=UfHHaw0v0oCiTiwwb5BO9+R6NBRkyjnapLI9VywJF3seDL/F2zMLxoQmJDpzOFCSTwVG/E
 Q77gHkbx2tda9vydoC9PcK9abIj1iJ0UjM4xfhPxHz1HxkKMl1rM90Vz17cZ0Pv2oMfobN
 jwOwJjB6C4G3b1C5yaIO2TxR1jNSR2acUUE1uPsPLO3IMb1eNANUHc45he+0Qpu2/VnkTa
 Os02pSA/VgkHSb8DpCQDaHO+Mm5TyrS8UWU8H0UshfL4EjdivM3HKcCtBeBqT+BbuQ9upS
 sTYV5eVYa3fN4oAms01hh9OxoJme3s8Y+gXZqqcB/EUJR7lSgYn5Dl78u064OA==
Subject: Re: [PATCH v1 16/16] net-next/yunsilicon: Add change mtu
Date: Fri, 20 Dec 2024 15:07:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26765179d+964012+vger.kernel.org+tianx@yunsilicon.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Message-Id: <22dd6297-8a08-4271-84a1-7198227278dc@yunsilicon.com>
X-Original-From: tianx <tianx@yunsilicon.com>
Content-Transfer-Encoding: quoted-printable
From: "tianx" <tianx@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com> <20241218105057.2237645-17-tianx@yunsilicon.com> <c8ffef39-ce76-4028-b54f-7ec919a4620c@lunn.ch>
In-Reply-To: <c8ffef39-ce76-4028-b54f-7ec919a4620c@lunn.ch>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Fri, 20 Dec 2024 15:07:08 +0800

You=E2=80=99re right, the check is redundant. However, as per Jakub=E2=80=
=99s suggestion=20
to reduce the patch count, this patch will be excluded in the next=20
version. I'll address it locally and submit in a future update.

Thank you for pointing that out!

On 2024/12/19 2:31, Andrew Lunn wrote:
>> +static int xsc_eth_change_mtu(struct net_device *netdev, int new_mtu)
>> +{
>> +	struct xsc_adapter *adapter =3D netdev_priv(netdev);
>> +	int old_mtu =3D netdev->mtu;
>> +	int ret =3D 0;
>> +	int max_buf_len =3D 0;
>> +
>> +	if (new_mtu > netdev->max_mtu || new_mtu < netdev->min_mtu) {
>> +		netdev_err(netdev, "%s: Bad MTU (%d), valid range is: [%d..%d]\n",
>> +			   __func__, new_mtu, netdev->min_mtu, netdev->max_mtu);
>> +		return -EINVAL;
>> +	}
> What checking does the core do for you, now that you have set max_mtu
> and min_mtu?
>
>
>      Andrew
>
> ---
> pw-bot: cr

