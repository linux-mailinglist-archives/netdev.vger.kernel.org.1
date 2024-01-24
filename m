Return-Path: <netdev+bounces-65393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA283A55E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78470283C02
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ED218E0F;
	Wed, 24 Jan 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="KFkCKND5"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454818EAB
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088265; cv=none; b=qzEPOjVTLmkYW0p3xAR/JlwVIsmASPKCW7gGsvZ7Zb65/rTldMW4DwPhIRpHmF58+fuBKzGU5ABRZAeg+Z9j6WAiOVq1dLKmlu95V0H9ua923FQTaP0dBoOKZYiyw1YXEQipKzGayFIdqmCYdLJwq+ZnjE28j2blF1ncbbJrkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088265; c=relaxed/simple;
	bh=MeoFvYCX5I/4Iw9kDB6v7/eQYwHW6zdRyLzG3rP6rpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCMw2EtQjVoE9v6FpSGnuTqOdJ2mqcCDUB1C1lDBYeDJLhUrRY6w9rwE5QxgULbGN1S2Gyiu0lg+7QQ8Tk72nJqqZwMWwGoZGchGAdXb7r31y1gEYM50PzLkBxUmmYB+ro4RTq8wm9eBovKUmd/yLgDjUdqTm1/7LQ+vsbYDZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=KFkCKND5; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240124092414412d7080d218c5452d
        for <netdev@vger.kernel.org>;
        Wed, 24 Jan 2024 10:24:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MeoFvYCX5I/4Iw9kDB6v7/eQYwHW6zdRyLzG3rP6rpU=;
 b=KFkCKND5wlYq3tF8QVLXmi5XWvl6k/h21izYNYWzHKsSobtUBEjqlWhXY+2//kPhcfYWUY
 pDeaYxCum81P4MXMVRZ/vNA75lwLJ21HLvOMH5/xXgu0Rfzt3sg95gq4qDAJIMx9rztSIJyI
 gbHbwAH8wZsaoRMwhmNeJdmTGwLQk=;
Message-ID: <8c4e1e69-210c-4eb7-bd54-97adb16e7c06@siemens.com>
Date: Wed, 24 Jan 2024 09:24:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/8] Add support for ICSSG-based Ethernet on SR1.0
 devices
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 grygorii.strashko@ti.com, jacob.e.keller@intel.com, robh@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: jan.kiszka@siemens.com, diogo.ivo@siemens.com
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
 <6b345be6-3bd0-4410-8255-97bf661fc890@kernel.org>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <6b345be6-3bd0-4410-8255-97bf661fc890@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Hi all, thank you for your input so far.

On 1/23/24 12:15, Roger Quadros wrote:
> Hello Diogo,
>
> On 17/01/2024 18:14, Diogo Ivo wrote:
>> Hello,
>>
>> This series extends the current ICSSG-based Ethernet driver to support
>> Silicon Revision 1.0 devices.
>>
>> Notable differences between the Silicon Revisions are that there is
>> no TX core in SR1.0 with this being handled by the firmware, requiring
>> extra DMA channels to communicate commands to the firmware (with the
>> firmware being different as well) and in the packet classifier.
>>
>> The motivation behind it is that a significant number of Siemens
>> devices containing SR1.0 silicon have been deployed in the field
>> and need to be supported and updated to newer kernel versions
>> without losing functionality.
> Adding SR1.0 support with all its ifdefs makes the driver more complicated
> than it should be.
>
> I think we need to treat SR1.0 and SR2.0 as different devices with their
> own independent drivers. While the data path is pretty much the same,
> also like in am65-cpsw-nuss.c, the initialization, firmware and other
> runtime logic is significantly different.
>
> How about introducing a new icssg_prueth_sr1.c and putting all the SR1 stuff
> there? You could still re-use the other helper files in net/ti/icssg/.
> It also warrants for it's own Kconfig symbol so it can be built only
> if required.
> Any common logic could still be moved to icssg_common.c and re-used in both drivers.

Yes, that sounds like a more reasonable approach. I will refactor the code

and come back with a v3, hopefully with all patches getting sent out :)


Best regards,

Diogo


