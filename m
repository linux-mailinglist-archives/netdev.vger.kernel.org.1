Return-Path: <netdev+bounces-172286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F51A540D7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1939A3AF03F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F018B47E;
	Thu,  6 Mar 2025 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="Vl3WvGkS"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-13.ptr.blmpb.com (va-1-13.ptr.blmpb.com [209.127.230.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291E18BC20
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229327; cv=none; b=kQ9AA2GxIIErov0mPlaJ4LX54gMSAQjuJeXkVpug3mjnxKpnHWEmShz8mPAP5fTDWpkK2ek4YLAuIYEJEhMjHjImKVcOCQUkegBLNJFKr7XszJ71BY1nhmtCsowR+xa6MuBos+zW9vshlZyReUQNkFv/TRkHoA3iNMajk7gjG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229327; c=relaxed/simple;
	bh=p7+P7r7Qeqxx1HnRcFS+DKana3REK11PxiFrO11Nry0=;
	h=In-Reply-To:Subject:References:Message-Id:To:Cc:Date:From:
	 Mime-Version:Content-Type; b=DFW+HaEgh68QT/ZDeiYQjry5mLEN2wbSIczHU7ITvtY7f9Jdby09k7xjy2CwSqYeU62kBMxh+fMQvAnEaiIlBiA15WYxFlUSs8+0TD0IUqm9T9Vlkm6EvMxvdA/EQrDN2q3a1z7dAhWB9czQCgsFX7kTuGHWar2x83q5Ezt1NPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=Vl3WvGkS; arc=none smtp.client-ip=209.127.230.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741229309; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+JL/oPcbLT+fKXebS/5bSut3KkcutZMvvpsm8gBkkIo=;
 b=Vl3WvGkSR+qmM+Np1AW779PBR5x8qL6E7/OV+zUK9Lk8P1M4wiITmNC5NKHIUKkXrrsNIp
 ribFAGQgdRjEEkBD+E1Lc+2rkKVSXyuDc3Y68MLt8zAX0+M9Bt7ehJAGmhK4xtmQsmSj1L
 QR6UOMutzb60TcCN9vTYcOM8Yv1VaZZxTrsYNzQHi6dK8T1vcwbiBVmojPJIfZfddumL8J
 GUOQKPFZxyjm0eaZ1tESOlzwLr3QZ30vAAFtBvqD/9FTMfHfZtvLdedl9p/2iKHTl4DxJK
 QwJq462v8OtaNxjccY1GcdYuLLeRX8TzFfN2k09fQollUruKxRAIkB2HuotBrQ==
In-Reply-To: <CAH-L+nPNR4CjHAFEfzv8sVHvpuHcA1SXMPOMuGuLZ0bTechX0g@mail.gmail.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v7 01/14] xsc: Add xsc driver basic framework
X-Lms-Return-Path: <lba+267c90cfb+9e9bac+vger.kernel.org+tianx@yunsilicon.com>
References: <20250228154122.216053-1-tianx@yunsilicon.com> <20250228154122.216053-2-tianx@yunsilicon.com> <CAH-L+nPNR4CjHAFEfzv8sVHvpuHcA1SXMPOMuGuLZ0bTechX0g@mail.gmail.com>
Message-Id: <002d7a88-84ed-4f84-be51-f0bf957b903d@yunsilicon.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Thu, 06 Mar 2025 10:48:26 +0800
To: "Kalesh Anakkur Purayil" <kalesh-anakkur.purayil@broadcom.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <jacky@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Date: Thu, 6 Mar 2025 10:48:24 +0800
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8

On 2025/3/5 16:55, Kalesh Anakkur Purayil wrote:
> On Fri, Feb 28, 2025 at 9:12=E2=80=AFPM Xin Tian <tianx@yunsilicon.com> w=
rote:
>> 1. Add yunsilicon xsc driver basic compile framework, including
>> xsc_pci driver and xsc_eth driver
>> 2. Implemented PCI device initialization.
>>
>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
>> ---
>>   MAINTAINERS                                   |   7 +
>>   drivers/net/ethernet/Kconfig                  |   1 +
>>   drivers/net/ethernet/Makefile                 |   1 +
>>   drivers/net/ethernet/yunsilicon/Kconfig       |  26 ++
>>   drivers/net/ethernet/yunsilicon/Makefile      |   8 +
>>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |  53 ++++
>>   .../net/ethernet/yunsilicon/xsc/net/Kconfig   |  17 ++
>>   .../net/ethernet/yunsilicon/xsc/net/Makefile  |   9 +
>>   .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |  16 ++
>>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   9 +
>>   .../net/ethernet/yunsilicon/xsc/pci/main.c    | 255 ++++++++++++++++++
>>   11 files changed, 402 insertions(+)
>>   create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
>>   create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core=
.h
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cc40a9d9b..4892dd63e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -25285,6 +25285,13 @@ S:     Maintained
>>   F:     Documentation/input/devices/yealink.rst
>>   F:     drivers/input/misc/yealink.*
>>
>> +YUNSILICON XSC DRIVERS
>> +M:     Honggang Wei <weihg@yunsilicon.com>
>> +M:     Xin Tian <tianx@yunsilicon.com>
>> +L:     netdev@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/net/ethernet/yunsilicon/xsc
>> +
>>   Z3FOLD COMPRESSED PAGE ALLOCATOR
>>   M:     Vitaly Wool <vitaly.wool@konsulko.com>
>>   R:     Miaohe Lin <linmiaohe@huawei.com>
>> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
>> index 0baac25db..aa6016597 100644
>> --- a/drivers/net/ethernet/Kconfig
>> +++ b/drivers/net/ethernet/Kconfig
>> @@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
>>   source "drivers/net/ethernet/ibm/Kconfig"
>>   source "drivers/net/ethernet/intel/Kconfig"
>>   source "drivers/net/ethernet/xscale/Kconfig"
>> +source "drivers/net/ethernet/yunsilicon/Kconfig"
>>
>>   config JME
>>          tristate "JMicron(R) PCI-Express Gigabit Ethernet support"
>> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefi=
le
>> index c03203439..c16c34d4b 100644
>> --- a/drivers/net/ethernet/Makefile
>> +++ b/drivers/net/ethernet/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) +=3D intel/
>>   obj-$(CONFIG_NET_VENDOR_I825XX) +=3D i825xx/
>>   obj-$(CONFIG_NET_VENDOR_MICROSOFT) +=3D microsoft/
>>   obj-$(CONFIG_NET_VENDOR_XSCALE) +=3D xscale/
>> +obj-$(CONFIG_NET_VENDOR_YUNSILICON) +=3D yunsilicon/
>>   obj-$(CONFIG_JME) +=3D jme.o
>>   obj-$(CONFIG_KORINA) +=3D korina.o
>>   obj-$(CONFIG_LANTIQ_ETOP) +=3D lantiq_etop.o
>> diff --git a/drivers/net/ethernet/yunsilicon/Kconfig b/drivers/net/ether=
net/yunsilicon/Kconfig
>> new file mode 100644
>> index 000000000..ff57fedf8
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
>> +       bool "Yunsilicon devices"
>> +       default y
>> +       depends on PCI
>> +       depends on ARM64 || X86_64
>> +       help
>> +         If you have a network (Ethernet) device belonging to this clas=
s,
>> +         say Y.
>> +
>> +         Note that the answer to this question doesn't directly affect =
the
>> +         kernel: saying N will just cause the configurator to skip all
>> +         the questions about Yunsilicon cards. If you say Y, you will b=
e asked
>> +         for your specific card in the following questions.
>> +
>> +if NET_VENDOR_YUNSILICON
>> +
>> +source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
>> +source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
>> +
>> +endif # NET_VENDOR_YUNSILICON
>> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethe=
rnet/yunsilicon/Makefile
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
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/dri=
vers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> new file mode 100644
>> index 000000000..6627a176a
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> @@ -0,0 +1,53 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#ifndef __XSC_CORE_H
>> +#define __XSC_CORE_H
>> +
>> +#include <linux/pci.h>
>> +
>> +#define XSC_PCI_VENDOR_ID              0x1f67
>> +
>> +#define XSC_MC_PF_DEV_ID               0x1011
>> +#define XSC_MC_VF_DEV_ID               0x1012
>> +#define XSC_MC_PF_DEV_ID_DIAMOND       0x1021
>> +
>> +#define XSC_MF_HOST_PF_DEV_ID          0x1051
>> +#define XSC_MF_HOST_VF_DEV_ID          0x1052
>> +#define XSC_MF_SOC_PF_DEV_ID           0x1053
>> +
>> +#define XSC_MS_PF_DEV_ID               0x1111
>> +#define XSC_MS_VF_DEV_ID               0x1112
>> +
>> +#define XSC_MV_HOST_PF_DEV_ID          0x1151
>> +#define XSC_MV_HOST_VF_DEV_ID          0x1152
>> +#define XSC_MV_SOC_PF_DEV_ID           0x1153
>> +
>> +struct xsc_dev_resource {
>> +       /* protect buffer allocation according to numa node */
>> +       struct mutex            alloc_mutex;
>> +};
>> +
>> +enum xsc_pci_state {
>> +       XSC_PCI_STATE_DISABLED,
>> +       XSC_PCI_STATE_ENABLED,
>> +};
>> +
>> +struct xsc_core_device {
>> +       struct pci_dev          *pdev;
>> +       struct device           *device;
>> +       struct xsc_dev_resource *dev_res;
>> +       int                     numa_node;
>> +
>> +       void __iomem            *bar;
>> +       int                     bar_num;
>> +
>> +       struct mutex            pci_state_mutex;        /* protect pci_s=
tate */
>> +       enum xsc_pci_state      pci_state;
>> +       struct mutex            intf_state_mutex;       /* protect intf_=
state */
>> +       unsigned long           intf_state;
>> +};
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig b/drivers/n=
et/ethernet/yunsilicon/xsc/net/Kconfig
>> new file mode 100644
>> index 000000000..de743487e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> +# All rights reserved.
>> +# Yunsilicon driver configuration
>> +#
>> +
>> +config YUNSILICON_XSC_ETH
>> +       tristate "Yunsilicon XSC ethernet driver"
>> +       default n
>> +       depends on YUNSILICON_XSC_PCI
>> +       depends on NET
>> +       help
>> +         This driver provides ethernet support for
>> +         Yunsilicon XSC devices.
>> +
>> +         To compile this driver as a module, choose M here. The module
>> +         will be called xsc_eth.
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/=
net/ethernet/yunsilicon/xsc/net/Makefile
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
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/n=
et/ethernet/yunsilicon/xsc/pci/Kconfig
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
>> +       tristate "Yunsilicon XSC PCI driver"
>> +       default n
>> +       select PAGE_POOL
>> +       help
>> +         This driver is common for Yunsilicon XSC
>> +         ethernet and RDMA drivers.
>> +
>> +         To compile this driver as a module, choose M here. The module
>> +         will be called xsc_pci.
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/=
net/ethernet/yunsilicon/xsc/pci/Makefile
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
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/ne=
t/ethernet/yunsilicon/xsc/pci/main.c
>> new file mode 100644
>> index 000000000..ec3181a8e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
>> @@ -0,0 +1,255 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#include "common/xsc_core.h"
>> +
>> +static const struct pci_device_id xsc_pci_id_table[] =3D {
>> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
>> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIAMOND) },
>> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_ID) },
>> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID) },
>> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
>> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_ID) },
>> +       { PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID) },
>> +       { 0 }
>> +};
>> +
>> +static int set_dma_caps(struct pci_dev *pdev)
>> +{
>> +       int err;
>> +
>> +       err =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +       if (err)
>> +               err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MA=
SK(32));
>> +       else
>> +               err =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(6=
4));
> You can simplify this as:
>
>          err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>          if (err)
>                  err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MA=
SK(32));

Thanks, Kalesh

Jakub also raised a comment here suggesting that it can be simplified to

|err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)); |

There's no need to fall back to a 32-bit mask now. You can see the=20
reason here:

https://lkml.org/lkml/2021/6/7/227

>> +
>> +       if (!err)
>> +               dma_set_max_seg_size(&pdev->dev, SZ_2G);
>> +
>> +       return err;
>> +}
>> +
>> +static int xsc_pci_enable_device(struct xsc_core_device *xdev)
>> +{
>> +       struct pci_dev *pdev =3D xdev->pdev;
>> +       int err =3D 0;
>> +
>> +       mutex_lock(&xdev->pci_state_mutex);
>> +       if (xdev->pci_state =3D=3D XSC_PCI_STATE_DISABLED) {
> Why is this pci_state checking needed. any reason to not use
> pci_is_enabled(dev)?

This is just a personal habit.

I agree that it's somewhat redundant here, and using pci_is_enabled

is enough and clearer.

I'll change the code accordingly.

>> +               err =3D pci_enable_device(pdev);
>> +               if (!err)
>> +                       xdev->pci_state =3D XSC_PCI_STATE_ENABLED;
>> +       }
>> +       mutex_unlock(&xdev->pci_state_mutex);
>> +
>> +       return err;
>> +}
>> +
>> +static void xsc_pci_disable_device(struct xsc_core_device *xdev)
>> +{
>> +       struct pci_dev *pdev =3D xdev->pdev;
>> +
>> +       mutex_lock(&xdev->pci_state_mutex);
>> +       if (xdev->pci_state =3D=3D XSC_PCI_STATE_ENABLED) {
>> +               pci_disable_device(pdev);
>> +               xdev->pci_state =3D XSC_PCI_STATE_DISABLED;
>> +       }
>> +       mutex_unlock(&xdev->pci_state_mutex);
>> +}
>> +
>> +static int xsc_pci_init(struct xsc_core_device *xdev,
>> +                       const struct pci_device_id *id)
>> +{
>> +       struct pci_dev *pdev =3D xdev->pdev;
>> +       void __iomem *bar_base;
>> +       int bar_num =3D 0;
>> +       int err;
>> +
>> +       xdev->numa_node =3D dev_to_node(&pdev->dev);
>> +
>> +       err =3D xsc_pci_enable_device(xdev);
>> +       if (err) {
>> +               pci_err(pdev, "failed to enable PCI device: err=3D%d\n",=
 err);
>> +               goto err_ret;
> You can return directly from here
Yes, will change
>> +       }
>> +
>> +       err =3D pci_request_region(pdev, bar_num, KBUILD_MODNAME);
>> +       if (err) {
>> +               pci_err(pdev, "failed to request %s pci_region=3D%d: err=
=3D%d\n",
>> +                       KBUILD_MODNAME, bar_num, err);
>> +               goto err_disable;
>> +       }
>> +
>> +       pci_set_master(pdev);
>> +
>> +       err =3D set_dma_caps(pdev);
>> +       if (err) {
>> +               pci_err(pdev, "failed to set DMA capabilities mask: err=
=3D%d\n",
>> +                       err);
>> +               goto err_clr_master;
>> +       }
>> +
>> +       bar_base =3D pci_ioremap_bar(pdev, bar_num);
>> +       if (!bar_base) {
>> +               pci_err(pdev, "failed to ioremap %s bar%d\n", KBUILD_MOD=
NAME,
>> +                       bar_num);
>> +               err =3D -ENOMEM;
>> +               goto err_clr_master;
>> +       }
>> +
>> +       err =3D pci_save_state(pdev);
>> +       if (err) {
>> +               pci_err(pdev, "pci_save_state failed: err=3D%d\n", err);
>> +               goto err_io_unmap;
>> +       }
>> +
>> +       xdev->bar_num =3D bar_num;
>> +       xdev->bar =3D bar_base;
>> +
>> +       return 0;
>> +
>> +err_io_unmap:
>> +       pci_iounmap(pdev, bar_base);
>> +err_clr_master:
>> +       pci_clear_master(pdev);
>> +       pci_release_region(pdev, bar_num);
>> +err_disable:
>> +       xsc_pci_disable_device(xdev);
>> +err_ret:
>> +       return err;
>> +}
>> +
>> +static void xsc_pci_fini(struct xsc_core_device *xdev)
>> +{
>> +       struct pci_dev *pdev =3D xdev->pdev;
>> +
>> +       if (xdev->bar)
> Is this check really needed?
no need, will drop it.
>> +               pci_iounmap(pdev, xdev->bar);
>> +       pci_clear_master(pdev);
>> +       pci_release_region(pdev, xdev->bar_num);
>> +       xsc_pci_disable_device(xdev);
>> +}
>> +
>> +static int xsc_dev_res_init(struct xsc_core_device *xdev)
>> +{
>> +       struct xsc_dev_resource *dev_res;
>> +
>> +       dev_res =3D kvzalloc(sizeof(*dev_res), GFP_KERNEL);
>> +       if (!dev_res)
>> +               return -ENOMEM;
>> +
>> +       xdev->dev_res =3D dev_res;
>> +       mutex_init(&dev_res->alloc_mutex);
>> +
>> +       return 0;
>> +}
>> +
>> +static void xsc_dev_res_cleanup(struct xsc_core_device *xdev)
>> +{
>> +       kfree(xdev->dev_res);
>> +}
>> +
>> +static int xsc_core_dev_init(struct xsc_core_device *xdev)
>> +{
>> +       int err;
>> +
>> +       mutex_init(&xdev->pci_state_mutex);
>> +       mutex_init(&xdev->intf_state_mutex);
>> +
>> +       err =3D xsc_dev_res_init(xdev);
>> +       if (err) {
>> +               pci_err(xdev->pdev, "xsc dev res init failed %d\n", err)=
;
>> +               goto out;
> You can avoid this label by doing "return err" instead of "return 0"
> the line below

The code is added to maintain structure with additions of next patch. (=20
same for the latter two)

Since you feel it not suitable, I'll remove=C2=A0 and add it where needed.

Thanks

>> +       }
>> +
>> +       return 0;
>> +out:
>> +       return err;
>> +}
>> +
>> +static void xsc_core_dev_cleanup(struct xsc_core_device *xdev)
>> +{
>> +       xsc_dev_res_cleanup(xdev);
>> +}
>> +
>> +static int xsc_pci_probe(struct pci_dev *pci_dev,
>> +                        const struct pci_device_id *id)
>> +{
>> +       struct xsc_core_device *xdev;
>> +       int err;
>> +
>> +       xdev =3D kzalloc(sizeof(*xdev), GFP_KERNEL);
>> +       if (!xdev)
>> +               return -ENOMEM;
>> +
>> +       xdev->pdev =3D pci_dev;
>> +       xdev->device =3D &pci_dev->dev;
>> +
>> +       pci_set_drvdata(pci_dev, xdev);
>> +       err =3D xsc_pci_init(xdev, id);
>> +       if (err) {
>> +               pci_err(pci_dev, "xsc_pci_init failed %d\n", err);
>> +               goto err_unset_pci_drvdata;
>> +       }
>> +
>> +       err =3D xsc_core_dev_init(xdev);
>> +       if (err) {
>> +               pci_err(pci_dev, "xsc_core_dev_init failed %d\n", err);
>> +               goto err_pci_fini;
>> +       }
>> +
>> +       return 0;
>> +err_pci_fini:
>> +       xsc_pci_fini(xdev);
>> +err_unset_pci_drvdata:
>> +       pci_set_drvdata(pci_dev, NULL);
>> +       kfree(xdev);
>> +
>> +       return err;
>> +}
>> +
>> +static void xsc_pci_remove(struct pci_dev *pci_dev)
>> +{
>> +       struct xsc_core_device *xdev =3D pci_get_drvdata(pci_dev);
>> +
>> +       xsc_core_dev_cleanup(xdev);
>> +       xsc_pci_fini(xdev);
>> +       pci_set_drvdata(pci_dev, NULL);
>> +       kfree(xdev);
>> +}
>> +
>> +static struct pci_driver xsc_pci_driver =3D {
>> +       .name           =3D "xsc-pci",
>> +       .id_table       =3D xsc_pci_id_table,
>> +       .probe          =3D xsc_pci_probe,
>> +       .remove         =3D xsc_pci_remove,
>> +};
>> +
>> +static int __init xsc_init(void)
>> +{
>> +       int err;
>> +
>> +       err =3D pci_register_driver(&xsc_pci_driver);
>> +       if (err) {
>> +               pr_err("failed to register pci driver\n");
>> +               goto out;
> There is no need of this label
>> +       }
>> +       return 0;
> "return err" here
>> +
>> +out:
>> +       return err;
>> +}
>> +
>> +static void __exit xsc_fini(void)
>> +{
>> +       pci_unregister_driver(&xsc_pci_driver);
>> +}
>> +
>> +module_init(xsc_init);
>> +module_exit(xsc_fini);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Yunsilicon XSC PCI driver");
>> --
>> 2.18.4
>>
>

