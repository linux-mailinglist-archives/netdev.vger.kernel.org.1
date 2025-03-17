Return-Path: <netdev+bounces-175186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470CA641B7
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C013AC08A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76A219A89;
	Mon, 17 Mar 2025 06:35:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1BE219A86
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193323; cv=none; b=RB6LNYVKsDue2Fw8OvidYlqT1RQb68jJt06k5gTuq2QYCp4AlQd6OMKMCI+sffZ6eSk+ZT4PjNv6p2k7Tt08LFC1aaC4T0JOf4dtJNGmPcTN8p6rL6IIWwcywB+0ZvUphK/D3GwtCAv1SPX5hNQH7yFhDBCCsPB+poq1SwbCiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193323; c=relaxed/simple;
	bh=0kuli4Baa9SuseLOUwlDppkNgc0XCe7A81OtrYaFsN0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qWy17x/BB3YcEI+oBLgIfriJoUw2JL9uFodOZDA+LTi40a8LGWRYlWYrM/jxGQ0nqpaNwW8bI3xeQ1c2vXrmW2ZGdxuyNjGmi/9Az3zWawAZT5v0OMbrzRRdoPhcEKWbAj4k8WwsBuXxlmhd2qwIcZ6IoL9Sm78552kQXqp2kZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1742193292tw7pbu61
X-QQ-Originating-IP: mgFzkIMUlRDyXRZLNjZ+7ZyjqaFHXv5hx2jqd/5GvP0=
Received: from smtpclient.apple ( [60.186.240.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 14:34:51 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17723523954212527238
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v8 2/6] net: libwx: Add sriov api for wangxun
 nics
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250316132204.GB4159220@kernel.org>
Date: Mon, 17 Mar 2025 14:34:40 +0800
Cc: netdev@vger.kernel.org,
 kuba@kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B4E9B01-A3CF-4860-8A38-229AC8AA07B5@net-swift.com>
References: <20250309154252.79234-1-mengyuanlou@net-swift.com>
 <20250309154252.79234-3-mengyuanlou@net-swift.com>
 <20250316132204.GB4159220@kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NBwM60nxo3yx/YKZe8iU6xt67Ffykqn4VJIWmnSVwC9uHyv6c900vhuJ
	ooNo+dB6aPlHjUfxxbV0qswbxy0qVgMSQQHHxIvGvaF78pDRcDu1hQeUixGccYT5LwIiQre
	YWwbLWeKPUk/wMGdvhGptcbq2T7SFAcnAWPxr/s/ltA6D1AdRKQsvy6/iPmZncbFocxNaN2
	GE/7+GJ5ZOw9LOATOc7Y0H1O6KHk3XH+EiTJRh4fEe98bvb7bfFl6ig3Aei84n3g0QPLXfu
	MK0f9nV6dItFxW4kiUAD0eQ+dqsfFb24TSftKL02N9L4BhLVLGEdvmzuiR1yIg0suEGjGCw
	kgdGIeNsdc00ytOyj31gx5e4OzajDkGvszRDrWaFUaPkyCqaezDtfCuaOji4l3vY9e3q9S1
	Sw2Wtn0LXsnw1nKAKw/U//M99KPHL1Rm4igBZSRXSjjJRuMNn79oEUbAKRWop2oUR0pKBZB
	Bt9cwhXlvmkGATMzhJcr9V/8/1J0O7MEDkDhlcuEgIYbJqgOXCrIZE6X0hq68aossL6FjSd
	2noX4qqCxWySPS0UeOQmyfC2awttk+hInxVevIdAKzla1W5K20v6NTXqZPYyMqOM6IrU5Wa
	QTHCmI7MOIazPiLx/k0BzD7Cqch/i/ZuhMtgIa19Dc3hiQF3E1koJXtJz19nZmCZLlrL5qu
	TpE6rjkeVKg+FhY72HtiErV4I6bYol09Bqp6i2hU94x3MdK/0VvObspgI1vbbM1nW2m6Zfh
	omNBvKQA//6suyWX+Hl0k3enysFFNfxJHzG5wA0VgSdKq0LKj1SGGe5WYgr9evGjXIBZEpg
	T3W/X4wFamYU+h07WxCSsvaPVq1aFJtt2+FjL01xbpOvesicIX4aouCep1cUJ+NvcluPueh
	IBzAq4Qifj2ZjTAunNwU6irBHpvBFzjG0oWSXJFSFfJ7bstvI+USjLfJq54bMmLxGDU14Nd
	z/hO/IXSfHqKVppDmFv3AprqNfKSjig8fI++MFscmiQdp7Wy08iOyz2sEf9kYpAK3OiS0SP
	W8OdhRTA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B43=E6=9C=8816=E6=97=A5 21:22=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, Mar 09, 2025 at 11:42:48PM +0800, Mengyuan Lou wrote:
>> Implement sriov_configure interface for wangxun nics in libwx.
>> Enable VT mode and initialize vf control structure, when sriov
>> is enabled. Do not be allowed to disable sriov when vfs are
>> assigned.
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>=20
> ...
>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c =
b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
>> new file mode 100644
>> index 000000000000..2392df341ad1
>> --- /dev/null
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
>> @@ -0,0 +1,201 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
>> +
>> +#include <linux/etherdevice.h>
>> +#include <linux/pci.h>
>> +
>> +#include "wx_type.h"
>> +#include "wx_mbx.h"
>> +#include "wx_sriov.h"
>> +
>> +static void wx_vf_configuration(struct pci_dev *pdev, int =
event_mask)
>> +{
>> + unsigned int vfn =3D (event_mask & GENMASK(5, 0));
>> + struct wx *wx =3D pci_get_drvdata(pdev);
>> +
>> + bool enable =3D ((event_mask & BIT(31)) !=3D 0);
>=20
> Sorry to nit-pick, and I'd be happy for this to be addressed as a
> follow-up, but I think that it would be nice to:
>=20
> 1. Both use some #defines and FIELD_GET() for the masking above.
>=20
> 2. Use !! in place of !=3D 0

#define VF_ENABLE_CHECK(_m) FIELD_GET(BIT(31), (_m))

bool enable =3D !!VF_ENABLE_CHECK(event_mask);

Is that the way to do it?


>=20
> 3. Arrange local variable declarations in reverse xmas tree order.
>=20



>> +
>> + if (enable)
>> + eth_zero_addr(wx->vfinfo[vfn].vf_mac_addr);
>> +}
>=20
> ...
>=20
>=20


