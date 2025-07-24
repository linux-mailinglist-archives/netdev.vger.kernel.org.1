Return-Path: <netdev+bounces-209669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920C4B10384
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5586A3A406C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE5272E4F;
	Thu, 24 Jul 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="he4a7OHM"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B021E32B7;
	Thu, 24 Jul 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345772; cv=none; b=ty3Oheccx56NyXGzcwX8KdFCoCqTLPZzkB2vYzNzS790oU/7L/AvvL/Tw0f1sQMqLy5zV3pxGGgA/j40p/ZA0GAHa3ls56j98763yXiJGvXuI63RAPIhYYkTOPuVgNVRnniwD+ZKMjXVspI0vL9ewYoVblQLLJ+9I6KYJlryBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345772; c=relaxed/simple;
	bh=tlzwZGCuIfcEqftp3h7uHc2ycvorKqwQFGrRHHg/6m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auY/9RIgVV04/bCDlJoSh/4Jt9fLod+m+Sa4ChaktfXtQ68AKhzALXptaH91MG52R922j4k9Fj5S+v6kl7QroF02u4tpdqO+IYAPHaLJVSEbByQU3C1Zeopyv1Hhvfxy+KNYqlt8cNM137P2RhStcho/y3EsR6hlyWOgw/HFNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=he4a7OHM; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <487ba043-ba5b-4071-ad84-2cdc8ef2eaf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753345767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODlto4/Gmeh1aGgrIs5jPYnBSPBuOWPalhw5GtoU864=;
	b=he4a7OHMN1IFpuoLBP732FEEPEQeNLynxheTL5kIeK896tGmTQ5qZqyIvCeTzvuo8Pne4Z
	v4NNSyFzPRhgkFeO42lpQU1OZrHE3xNot424krFz4QkOqpGeNH/J29yxRW5al2vDkUFKMq
	hWttLLIw10wivgtlDGqypsIod1WVEM4=
Date: Thu, 24 Jul 2025 09:28:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pch_gbe: Add NULL check for ptp_pdev in pch_gbe_probe()
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 mingo@kernel.org, tglx@linutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723034105.2939635-1-chenyuan0y@gmail.com>
 <b33f5cee-d3de-4cbd-8eeb-214ba6b42cb7@linux.dev>
 <CALGdzuq1BndVib-==ZEHapGsiKuReMxm-f8DB+xFK9qbSpWruQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALGdzuq1BndVib-==ZEHapGsiKuReMxm-f8DB+xFK9qbSpWruQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2025 17:29, Chenyuan Yang wrote:
> On Wed, Jul 23, 2025 at 2:37 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 23/07/2025 04:41, Chenyuan Yang wrote:
>>> Since pci_get_domain_bus_and_slot() can return NULL for PCI_DEVFN(12, 4),
>>> add NULL check for adapter->ptp_pdev in pch_gbe_probe().
>>>
>>> This change is similar to the fix implemented in commit 9af152dcf1a0
>>> ("drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()").
>>>
>>> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>>> ---
>>>    drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
>>> index e5a6f59af0b6..10b8f1fea1a2 100644
>>> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
>>> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
>>> @@ -2515,6 +2515,11 @@ static int pch_gbe_probe(struct pci_dev *pdev,
>>>                pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
>>>                                            adapter->pdev->bus->number,
>>>                                            PCI_DEVFN(12, 4));
>>> +     if (!adapter->ptp_pdev) {
>>> +             dev_err(&pdev->dev, "PTP device not found\n");
>>> +             ret = -ENODEV;
>>> +             goto err_free_netdev;
>>> +     }
>>
>> Why is this error fatal? I believe the device still can transmit and
>> receive packets without PTP device. If this situation is really possible
>> I would suggest you to add checks to ioctl function to remove
>> timestamping support if there is no PTP device found
> 
> Thanks for the prompt reply!
> Our static analysis tool found this issue and we made the initial
> patch based on the existings checks for pci_get_domain_bus_and_slot()
> 
> I've drafted a new version based on your suggestion. It removes the
> check from the probe function and instead adds the necessary NULL
> checks directly to the timestamping and ioctl functions.
> 
> Does the implementation below look correct to you? If so, I will
> prepare and send a formal v2 patch.
> 

I would say this patch looks way too defensive. It's enough to deny
enabling HW timestamping when there is no PTP device, then all other
checks will never happen. And I would keep the error message just to
inform users that PTP feature is not available on the particular
device/system.

Do you have HW to test your patch?

