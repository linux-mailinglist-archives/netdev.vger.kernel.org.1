Return-Path: <netdev+bounces-153995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5349FA9CE
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 04:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2755618830C5
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 03:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A37714D43D;
	Mon, 23 Dec 2024 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="eEejxG9I"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-37.ptr.blmpb.com (lf-2-37.ptr.blmpb.com [101.36.218.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0F148FF9
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734925518; cv=none; b=SOqAW3r2bfk90TgcWRY3tT1huvlpOoCjYs9DBIkw3b6KKTSdHwcyZibxPVukdNYnzYBSBYqXWLFlgGFnQZEvcbpGCvxwM5+6SLoGOIBK9iiB0Yf0obAWakoDFdHjhYOaLVBIUFjLOO3nygAatU4deYaZKCcVnBvqrrdDt2OLoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734925518; c=relaxed/simple;
	bh=gWmthGUbNPv6t6nHYGfJObod/JgDoIs5xQCXGEnruLY=;
	h=Message-Id:Mime-Version:In-Reply-To:Content-Type:To:From:Subject:
	 Date:Cc:References; b=bl30Sq2wyzjumsrulnOWwVmT/DN8KeGs9+8NmoKg1Hqs+wtzAJd0Quz0e2dz5Z0CFEwBEA62pBGinIgHloKlpmxqBanB1L3NmRmMFHfk8EBJYw5f/ShPBndblyUDeTv432Pvfey9uYKdLQ3TPykCgYSwXC//Iormkd+bLfIs1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=eEejxG9I; arc=none smtp.client-ip=101.36.218.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734925422; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gWmthGUbNPv6t6nHYGfJObod/JgDoIs5xQCXGEnruLY=;
 b=eEejxG9IAnb1JrAi+pv0CUtdDU3uFLXy0MZHRpYULXSqS/CNEDqXZrPc5UifKWk+/yb9MT
 zoz9By3OaBTRExMv4XviFCgG3ZP83nIka3BfOiqBFI/x2UvSGcRgCyaSmTc8U7PA5mJW+V
 0UatJuc74GcuU2DhYOyEG/f6NX449vEwNcn81Yi6l8tQ5zq2UAxMCwFN8ZMYzTlGp45WT+
 tqGocy+XKa7NeiI3MvnAcskxv01f8Tcwn5ejbrVghxo6+E33U7d9yeZ1KxJ8guJPSn4Ohw
 jSYzKlLiYq+HoWbkWNdRTybpoJGXxT3n67cyCNNVe6mxIY+xD5sOYWAg8BvOHQ==
Message-Id: <b02be8ae-c904-4d67-9d21-87abf315cb7f@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <efa084c6-8a06-4345-8bbc-5e6741dc5d0b@intel.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH v1 01/16] net-next/yunsilicon: Add xsc driver basic framework
Date: Mon, 23 Dec 2024 11:43:37 +0800
Content-Transfer-Encoding: quoted-printable
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Mon, 23 Dec 2024 11:43:39 +0800
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <netdev@vger.kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+26768dc6c+b57312+vger.kernel.org+tianx@yunsilicon.com>
X-Original-From: tianx <tianx@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com> <20241218105023.2237645-2-tianx@yunsilicon.com> <efa084c6-8a06-4345-8bbc-5e6741dc5d0b@intel.com>

On 2024/12/18 21:58, Przemek Kitszel wrote:
> On 12/18/24 11:50, Xin Tian wrote:
>> Add yunsilicon xsc driver basic framework, including xsc_pci driver
>> and xsc_eth driver
>>
>> =C2=A0 Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <Jacky@yunsilicon.com>
>
> Co-devs need to sign-off too, scripts/checkpatch.pl would catch that
> (and more)
>
got it
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> ---
>> =C2=A0 drivers/net/ethernet/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>> =C2=A0 drivers/net/ethernet/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
>> =C2=A0 drivers/net/ethernet/yunsilicon/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 26 ++
>> =C2=A0 drivers/net/ethernet/yunsilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 8 +
>> =C2=A0 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 132 +++++++++
>> =C2=A0 .../net/ethernet/yunsilicon/xsc/net/Kconfig=C2=A0=C2=A0 |=C2=A0 1=
6 ++
>> =C2=A0 .../net/ethernet/yunsilicon/xsc/net/Makefile=C2=A0 |=C2=A0=C2=A0 =
9 +
>> =C2=A0 .../net/ethernet/yunsilicon/xsc/pci/Kconfig=C2=A0=C2=A0 |=C2=A0 1=
6 ++
>> =C2=A0 .../net/ethernet/yunsilicon/xsc/pci/Makefile=C2=A0 |=C2=A0=C2=A0 =
9 +
>> =C2=A0 .../net/ethernet/yunsilicon/xsc/pci/main.c=C2=A0=C2=A0=C2=A0 | 27=
2 ++++++++++++++++++
>> =C2=A0 10 files changed, 490 insertions(+)
>> =C2=A0 create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
>> =C2=A0 create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
>> =C2=A0 create mode 100644=20
>> drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> =C2=A0 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfi=
g
>> =C2=A0 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefi=
le
>> =C2=A0 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfi=
g
>> =C2=A0 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefi=
le
>> =C2=A0 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>>
>> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
>> index 0baac25db..aa6016597 100644
>> --- a/drivers/net/ethernet/Kconfig
>> +++ b/drivers/net/ethernet/Kconfig
>> @@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
>> =C2=A0 source "drivers/net/ethernet/ibm/Kconfig"
>> =C2=A0 source "drivers/net/ethernet/intel/Kconfig"
>> =C2=A0 source "drivers/net/ethernet/xscale/Kconfig"
>> +source "drivers/net/ethernet/yunsilicon/Kconfig"
>> =C2=A0 =C2=A0 config JME
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "JMicron(R) PCI-Express Gigabit =
Ethernet support"
>> diff --git a/drivers/net/ethernet/Makefile=20
>> b/drivers/net/ethernet/Makefile
>> index c03203439..c16c34d4b 100644
>> --- a/drivers/net/ethernet/Makefile
>> +++ b/drivers/net/ethernet/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) +=3D intel/
>> =C2=A0 obj-$(CONFIG_NET_VENDOR_I825XX) +=3D i825xx/
>> =C2=A0 obj-$(CONFIG_NET_VENDOR_MICROSOFT) +=3D microsoft/
>> =C2=A0 obj-$(CONFIG_NET_VENDOR_XSCALE) +=3D xscale/
>> +obj-$(CONFIG_NET_VENDOR_YUNSILICON) +=3D yunsilicon/
>> =C2=A0 obj-$(CONFIG_JME) +=3D jme.o
>> =C2=A0 obj-$(CONFIG_KORINA) +=3D korina.o
>> =C2=A0 obj-$(CONFIG_LANTIQ_ETOP) +=3D lantiq_etop.o
>> diff --git a/drivers/net/ethernet/yunsilicon/Kconfig=20
>> b/drivers/net/ethernet/yunsilicon/Kconfig
>> new file mode 100644
>> index 000000000..c766390b4
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/Kconfig
>> @@ -0,0 +1,26 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Yunsilicon driver configuration
>> +#
>> +
>> +config NET_VENDOR_YUNSILICON
>> +=C2=A0=C2=A0=C2=A0 bool "Yunsilicon devices"
>> +=C2=A0=C2=A0=C2=A0 default y
>> +=C2=A0=C2=A0=C2=A0 depends on PCI || NET
>
> Would it work for you to have only one of the above enabled?
>
> I didn't noticed your response to the same question on your v0
> (BTW, versioning starts at v0, remember to add also links to previous
> versions (not needed for your v0, to don't bother you with 16 URLs :))
>
Will modify to PCI only, and move NET to xsc_eth Kconfig
>> +=C2=A0=C2=A0=C2=A0 depends on ARM64 || X86_64
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you have a network (Ethernet) device =
belonging to this class,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 say Y.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note that the answer to this question do=
esn't directly affect the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel: saying N will just cause the con=
figurator to skip all
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the questions about Yunsilicon cards. If=
 you say Y, you will=20
>> be asked
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for your specific card in the following =
questions.
>> +
>> +if NET_VENDOR_YUNSILICON
>> +
>> +source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
>> +source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
>> +
>> +endif # NET_VENDOR_YUNSILICON
>> diff --git a/drivers/net/ethernet/yunsilicon/Makefile=20
>> b/drivers/net/ethernet/yunsilicon/Makefile
>> new file mode 100644
>> index 000000000..6fc8259a7
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/Makefile
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Makefile for the Yunsilicon device drivers.
>> +#
>> +
>> +# obj-$(CONFIG_YUNSILICON_XSC_ETH) +=3D xsc/net/
>> +obj-$(CONFIG_YUNSILICON_XSC_PCI) +=3D xsc/pci/
>> \ No newline at end of file
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h=20
>> b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> new file mode 100644
>> index 000000000..5ed12760e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> @@ -0,0 +1,132 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#ifndef XSC_CORE_H
>> +#define XSC_CORE_H
>
> typically there are two underscores in the header names
>
Got it.
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +extern unsigned int xsc_log_level;
>> +
>> +#define XSC_PCI_VENDOR_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=
f67
>> +
>> +#define XSC_MC_PF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x10=
11
>> +#define XSC_MC_VF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x10=
12
>> +#define XSC_MC_PF_DEV_ID_DIAMOND=C2=A0=C2=A0=C2=A0 0x1021
>> +
>> +#define XSC_MF_HOST_PF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x1051
>> +#define XSC_MF_HOST_VF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x1052
>> +#define XSC_MF_SOC_PF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0x1053
>> +
>> +#define XSC_MS_PF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x11=
11
>> +#define XSC_MS_VF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x11=
12
>> +
>> +#define XSC_MV_HOST_PF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x1151
>> +#define XSC_MV_HOST_VF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x1152
>> +#define XSC_MV_SOC_PF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0x1153
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 XSC_LOG_LEVEL_DBG=C2=A0=C2=A0=C2=A0 =3D 0,
>> +=C2=A0=C2=A0=C2=A0 XSC_LOG_LEVEL_INFO=C2=A0=C2=A0=C2=A0 =3D 1,
>> +=C2=A0=C2=A0=C2=A0 XSC_LOG_LEVEL_WARN=C2=A0=C2=A0=C2=A0 =3D 2,
>> +=C2=A0=C2=A0=C2=A0 XSC_LOG_LEVEL_ERR=C2=A0=C2=A0=C2=A0 =3D 3,
>> +};
>> +
>> +#define xsc_dev_log(condition, level, dev, fmt, ...) \
>> +do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 if (condition)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_printk(level, dev, dev_f=
mt(fmt), ##__VA_ARGS__); \
>> +} while (0)
>> +
>> +#define xsc_core_dbg(__dev, format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 xsc_dev_log(xsc_log_level <=3D XSC_LOG_LEVEL_DBG, KE=
RN_DEBUG,=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &(__dev)->pdev->dev, "%s:%d:=
(pid %d): " format,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, __LINE__, current-=
>pid, ##__VA_ARGS__)
>> +
>> +#define xsc_core_dbg_once(__dev, format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): "=
 format,=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __func__, __LINE__, current->pid,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ##__VA_ARGS__)
>> +
>> +#define xsc_core_dbg_mask(__dev, mask, format, ...) \
>> +do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 if ((mask) & xsc_debug_mask)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_dbg(__dev, format, =
##__VA_ARGS__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +} while (0)
>> +
>> +#define xsc_core_err(__dev, format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 xsc_dev_log(xsc_log_level <=3D XSC_LOG_LEVEL_ERR, KE=
RN_ERR,=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &(__dev)->pdev->dev, "%s:%d:=
(pid %d): " format,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, __LINE__, current-=
>pid, ##__VA_ARGS__)
>> +
>> +#define xsc_core_err_rl(__dev, format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> + dev_err_ratelimited(&(__dev)->pdev->dev,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "%s:%d:(pid %d): " format,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 __func__, __LINE__, current->pid,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ##__VA_ARGS__)
>> +
>> +#define xsc_core_warn(__dev, format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 xsc_dev_log(xsc_log_level <=3D XSC_LOG_LEVEL_WARN, K=
ERN_WARNING,=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &(__dev)->pdev->dev, "%s:%d:=
(pid %d): " format,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, __LINE__, current-=
>pid, ##__VA_ARGS__)
>> +
>> +#define xsc_core_info(__dev, format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 xsc_dev_log(xsc_log_level <=3D XSC_LOG_LEVEL_INFO, K=
ERN_INFO,=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &(__dev)->pdev->dev, "%s:%d:=
(pid %d): " format,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, __LINE__, current-=
>pid, ##__VA_ARGS__)
>> +
>> +#define xsc_pr_debug(format, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
>> +do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 if (xsc_log_level <=3D XSC_LOG_LEVEL_DBG)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug(format, ##__VA_ARGS=
__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +} while (0)
>> +
>> +#define assert(__dev, expr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
>> +do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 if (!(expr)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&(__dev)->pdev->dev,=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Assertion failed! %s, %s, %=
s, line %d\n",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #expr, __FILE__, __func__, _=
_LINE__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
>> +=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +} while (0)
>
> as a rule of thumb, don't add functions/macros that you don't use in
> given patch
>
> have you seen WARN_ON() family?
>
Thank you, will use WARN_ON instead of assert.
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 XSC_MAX_NAME_LEN =3D 32,
>> +};
>> +
>> +struct xsc_dev_resource {
>> +=C2=A0=C2=A0=C2=A0 struct mutex alloc_mutex;=C2=A0=C2=A0=C2=A0 /* prote=
ct buffer alocation=20
>> according to numa node */
>> +};
>> +
>> +enum xsc_pci_state {
>> +=C2=A0=C2=A0=C2=A0 XSC_PCI_STATE_DISABLED,
>> +=C2=A0=C2=A0=C2=A0 XSC_PCI_STATE_ENABLED,
>> +};
>> +
>> +struct xsc_priv {
>> +=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name[XSC_MAX_NAME_LEN];
>> +=C2=A0=C2=A0=C2=A0 struct list_head=C2=A0=C2=A0=C2=A0 dev_list;
>> +=C2=A0=C2=A0=C2=A0 struct list_head=C2=A0=C2=A0=C2=A0 ctx_list;
>> +=C2=A0=C2=A0=C2=A0 spinlock_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ctx_lock;=C2=A0=C2=A0=C2=A0 /* protect ctx_list */
>> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 numa_node;
>> +};
>> +
>> +struct xsc_core_device {
>> +=C2=A0=C2=A0=C2=A0 struct pci_dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *pdev;
>> +=C2=A0=C2=A0=C2=A0 struct device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *device;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 priv;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_dev_resource=C2=A0=C2=A0=C2=A0 *dev_res;
>> +
>> +=C2=A0=C2=A0=C2=A0 void __iomem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *bar;
>> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bar_num;
>> +
>> +=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_state_mutex;=C2=A0=C2=A0=C2=A0 /* protect pci_state */
>> +=C2=A0=C2=A0=C2=A0 enum xsc_pci_state=C2=A0=C2=A0=C2=A0 pci_state;
>> +=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 intf_state_mutex;=C2=A0=C2=A0=C2=A0 /* protect intf_state */
>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 intf_state;
>> +};
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig=20
>> b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>> new file mode 100644
>> index 000000000..0d9a4ff8a
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Yunsilicon driver configuration
>> +#
>> +
>> +config YUNSILICON_XSC_ETH
>> +=C2=A0=C2=A0=C2=A0 tristate "Yunsilicon XSC ethernet driver"
>> +=C2=A0=C2=A0=C2=A0 default n
>> +=C2=A0=C2=A0=C2=A0 depends on YUNSILICON_XSC_PCI
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver provides ethernet support fo=
r
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Yunsilicon XSC devices.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, choo=
se M here. The module
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will be called xsc_eth.
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile=20
>> b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>> new file mode 100644
>> index 000000000..2811433af
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +
>> +ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>> +
>> +obj-$(CONFIG_YUNSILICON_XSC_ETH) +=3D xsc_eth.o
>> +
>> +xsc_eth-y :=3D main.o
>> \ No newline at end of file
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig=20
>> b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>> new file mode 100644
>> index 000000000..2b6d79905
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Yunsilicon PCI configuration
>> +#
>> +
>> +config YUNSILICON_XSC_PCI
>> +=C2=A0=C2=A0=C2=A0 tristate "Yunsilicon XSC PCI driver"
>> +=C2=A0=C2=A0=C2=A0 default n
>> +=C2=A0=C2=A0=C2=A0 select PAGE_POOL
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver is common for Yunsilicon XSC
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ethernet and RDMA drivers.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, choo=
se M here. The module
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will be called xsc_pci.
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile=20
>> b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> new file mode 100644
>> index 000000000..709270df8
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +
>> +ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>> +
>> +obj-$(CONFIG_YUNSILICON_XSC_PCI) +=3D xsc_pci.o
>> +
>> +xsc_pci-y :=3D main.o
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c=20
>> b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>> new file mode 100644
>> index 000000000..cbe0bfbd1
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>> @@ -0,0 +1,272 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#include "common/xsc_core.h"
>> +
>> +unsigned int xsc_log_level =3D XSC_LOG_LEVEL_WARN;
>> +module_param_named(log_level, xsc_log_level, uint, 0644);
>> +MODULE_PARM_DESC(log_level,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "lowest log level to p=
rint: 0=3Ddebug, 1=3Dinfo, 2=3Dwarning,=20
>> 3=3Derror. Default=3D1");
>> +EXPORT_SYMBOL(xsc_log_level);
>> +
>> +#define XSC_PCI_DRV_DESC=C2=A0=C2=A0=C2=A0 "Yunsilicon Xsc PCI driver"
>
> remove the define and just use the string inplace as desription
OK=EF=BC=8C will modify.
>
>> +
>> +static const struct pci_device_id xsc_pci_id_table[] =3D {
>> +=C2=A0=C2=A0=C2=A0 { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
>> +=C2=A0=C2=A0=C2=A0 { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIA=
MOND) },
>> +=C2=A0=C2=A0=C2=A0 { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_I=
D) },
>> +=C2=A0=C2=A0=C2=A0 { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID=
) },
>> +=C2=A0=C2=A0=C2=A0 { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
>> +=C2=A0=C2=A0=C2=A0 { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_I=
D) },
>> +=C2=A0=C2=A0=C2=A0 { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID=
) },
>> +=C2=A0=C2=A0=C2=A0 { 0 }
>> +};
>> +
>> +static int set_dma_caps(struct pci_dev *pdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D dma_set_mask_and_coh=
erent(&pdev->dev, DMA_BIT_MASK(32));
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D dma_set_coherent_mas=
k(&pdev->dev, DMA_BIT_MASK(64));
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_set_max_seg_size(&pdev->=
dev, SZ_2G);
>> +
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +}
>> +
>> +static int xsc_pci_enable_device(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev =3D xdev->pdev;
>> +=C2=A0=C2=A0=C2=A0 int err =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&xdev->pci_state_mutex);
>> +=C2=A0=C2=A0=C2=A0 if (xdev->pci_state =3D=3D XSC_PCI_STATE_DISABLED) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D pci_enable_device(pd=
ev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev=
->pci_state =3D XSC_PCI_STATE_ENABLED;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&xdev->pci_state_mutex);
>> +
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +}
>> +
>> +static void xsc_pci_disable_device(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev =3D xdev->pdev;
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&xdev->pci_state_mutex);
>> +=C2=A0=C2=A0=C2=A0 if (xdev->pci_state =3D=3D XSC_PCI_STATE_ENABLED) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_disable_device(pdev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->pci_state =3D XSC_PCI_=
STATE_DISABLED;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&xdev->pci_state_mutex);
>> +}
>> +
>> +static int xsc_pci_init(struct xsc_core_device *xdev, const struct=20
>> pci_device_id *id)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev =3D xdev->pdev;
>> +=C2=A0=C2=A0=C2=A0 void __iomem *bar_base;
>> +=C2=A0=C2=A0=C2=A0 int bar_num =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_init(&xdev->pci_state_mutex);
>> +=C2=A0=C2=A0=C2=A0 xdev->priv.numa_node =3D dev_to_node(&pdev->dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D xsc_pci_enable_device(xdev);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "failed t=
o enable PCI device: err=3D%d\n",=20
>> err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D pci_request_region(pdev, bar_num, KBUILD_MOD=
NAME);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "failed t=
o request %s pci_region=3D%d:=20
>> err=3D%d\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBUILD_MODNAME, bar_num, err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_disable;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 pci_set_master(pdev);
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D set_dma_caps(pdev);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "failed t=
o set DMA capabilities mask:=20
>> err=3D%d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_clr_master;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 bar_base =3D pci_ioremap_bar(pdev, bar_num);
>> +=C2=A0=C2=A0=C2=A0 if (!bar_base) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "failed t=
o ioremap %s bar%d\n",=20
>> KBUILD_MODNAME, bar_num);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_clr_master;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D pci_save_state(pdev);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "pci_save=
_state failed: err=3D%d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_io_unmap;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 xdev->bar_num =3D bar_num;
>> +=C2=A0=C2=A0=C2=A0 xdev->bar =3D bar_base;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +err_io_unmap:
>> +=C2=A0=C2=A0=C2=A0 pci_iounmap(pdev, bar_base);
>> +err_clr_master:
>> +=C2=A0=C2=A0=C2=A0 pci_clear_master(pdev);
>> +=C2=A0=C2=A0=C2=A0 pci_release_region(pdev, bar_num);
>> +err_disable:
>> +=C2=A0=C2=A0=C2=A0 xsc_pci_disable_device(xdev);
>> +err_ret:
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +}
>> +
>> +static void xsc_pci_fini(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev =3D xdev->pdev;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (xdev->bar)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_iounmap(pdev, xdev->bar)=
;
>> +=C2=A0=C2=A0=C2=A0 pci_clear_master(pdev);
>> +=C2=A0=C2=A0=C2=A0 pci_release_region(pdev, xdev->bar_num);
>> +=C2=A0=C2=A0=C2=A0 xsc_pci_disable_device(xdev);
>> +}
>> +
>> +static int xsc_priv_init(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xsc_priv *priv =3D &xdev->priv;
>> +
>> +=C2=A0=C2=A0=C2=A0 strscpy(priv->name, dev_name(&xdev->pdev->dev), XSC_=
MAX_NAME_LEN);
>> +
>> +=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&priv->ctx_list);
>> +=C2=A0=C2=A0=C2=A0 spin_lock_init(&priv->ctx_lock);
>> +=C2=A0=C2=A0=C2=A0 mutex_init(&xdev->intf_state_mutex);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int xsc_dev_res_init(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xsc_dev_resource *dev_res;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev_res =3D kvzalloc(sizeof(*dev_res), GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!dev_res)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 xdev->dev_res =3D dev_res;
>> +=C2=A0=C2=A0=C2=A0 mutex_init(&dev_res->alloc_mutex);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static void xsc_dev_res_cleanup(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 kfree(xdev->dev_res);
>> +}
>> +
>> +static int xsc_core_dev_init(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 xsc_priv_init(xdev);
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D xsc_dev_res_init(xdev);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "xsc dev =
res init failed %d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>
> return err...

Thanks for the feedback. The |return err;| is retained to accommodate=20
additional error handling logic in subsequent patches. After those=20
patches are added, this structure will look OK.

>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +out:
>> +=C2=A0=C2=A0=C2=A0 return err;
>
> ...so you could remove last two lines
>
>> +}
>> +
>> +static void xsc_core_dev_cleanup(struct xsc_core_device *xdev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 xsc_dev_res_cleanup(xdev);
>> +}
>> +
>> +static int xsc_pci_probe(struct pci_dev *pci_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const struct pci_device_id *id)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xsc_core_device *xdev;
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 xdev =3D kzalloc(sizeof(*xdev), GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!xdev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 xdev->pdev =3D pci_dev;
>> +=C2=A0=C2=A0=C2=A0 xdev->device =3D &pci_dev->dev;
>> +
>> +=C2=A0=C2=A0=C2=A0 pci_set_drvdata(pci_dev, xdev);
>> +=C2=A0=C2=A0=C2=A0 err =3D xsc_pci_init(xdev, id);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "xsc_pci_=
init failed %d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_unset_pci_drvdata;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D xsc_core_dev_init(xdev);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xsc_core_err(xdev, "xsc_core=
_dev_init failed %d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_pci_fini;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +err_pci_fini:
>> +=C2=A0=C2=A0=C2=A0 xsc_pci_fini(xdev);
>> +err_unset_pci_drvdata:
>> +=C2=A0=C2=A0=C2=A0 pci_set_drvdata(pci_dev, NULL);
>> +=C2=A0=C2=A0=C2=A0 kfree(xdev);
>> +
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +}
>> +
>> +static void xsc_pci_remove(struct pci_dev *pci_dev)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xsc_core_device *xdev =3D pci_get_drvdata(pci=
_dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 xsc_core_dev_cleanup(xdev);
>> +=C2=A0=C2=A0=C2=A0 xsc_pci_fini(xdev);
>> +=C2=A0=C2=A0=C2=A0 pci_set_drvdata(pci_dev, NULL);
>> +=C2=A0=C2=A0=C2=A0 kfree(xdev);
>> +}
>> +
>> +static struct pci_driver xsc_pci_driver =3D {
>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"xsc-pci",
>> +=C2=A0=C2=A0=C2=A0 .id_table=C2=A0=C2=A0=C2=A0 =3D xsc_pci_id_table,
>> +=C2=A0=C2=A0=C2=A0 .probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 xsc_pci_probe,
>> +=C2=A0=C2=A0=C2=A0 .remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D xsc_pci_remove,
>> +};
>> +
>> +static int __init xsc_init(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D pci_register_driver(&xsc_pci_driver);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("failed to register p=
ci driver\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>
> ditto plain return
>
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +out:
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +}
>> +
>> +static void __exit xsc_fini(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pci_unregister_driver(&xsc_pci_driver);
>> +}
>> +
>> +module_init(xsc_init);
>> +module_exit(xsc_fini);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION(XSC_PCI_DRV_DESC);
>
Thank you=EF=BC=8CPrzemek=EF=BC=8Cfor your thoughtful review and patient ex=
planations.=20
Your clarification of some important rules is really valuable for=20
someone like me who is new to this. I will make sure to follow these=20
guidelines in my future changes. I also appreciate all the feedback=20
you=E2=80=99ve provided earlier.

Best regards,
Xin Tian

