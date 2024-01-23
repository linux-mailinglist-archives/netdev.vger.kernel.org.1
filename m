Return-Path: <netdev+bounces-65023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E6838E44
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295E0286E85
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E875DF01;
	Tue, 23 Jan 2024 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiVC2Rhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE35C5F2;
	Tue, 23 Jan 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012155; cv=none; b=BrXvf1go9MncHPHky+opEr1Zg65EQKrjyPWQtHVdUvrL4dVRV++ZqEhtyP4CcjPuVpqdVpSU9e0XK7DfFdLETfEeL3SFFcy/x80RDTxP7Z4bsLJLdxBxuv1lYYL6MGcOAf7lWlGSWu7U0Fq9RUbnn3BInTI4GZBzd1v6XOjmK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012155; c=relaxed/simple;
	bh=1qGwqCKoaSdmwryi10V4qYWBhcT7+dmiOo5B2/mp7Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMKQhcanvGgzjTcLLEcRUwCgk1LMY0n90pAonJh3wugUHbXj1Ln8WhQXuGrjTKa07HQTCvCg6iO7eYqTO/p96EQiTqBeNskXZx49nZ3Y9f+UVTNHcYWb/5Yn8Cj3zEuHxVrB/Tnxdmuqns5P7JyOLS9YXzcJONmWCghh7F8t5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiVC2Rhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C4C433C7;
	Tue, 23 Jan 2024 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706012154;
	bh=1qGwqCKoaSdmwryi10V4qYWBhcT7+dmiOo5B2/mp7Gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UiVC2Rhi3Zk1qLcMPI4SDN8n9XthO/Y2WWSoYQbHQAUhcbwpPPDZtvGB0Pz9WxPEa
	 gtf5PNb77xmM7f3DvbBBx1k0nfwHBECKT3/oQEenaJ+cfOYw0TvNEbjf3mnniqAP8F
	 QFkRKoMAl80X+4o5VFLnhjWft5Yble2LFUZZcSITUiHlTr73P6T8dpUamn3mBj8wEU
	 y1lQrO+XR/ealTR58D7AjuieNXry3qC5R9a3Uk5HOQt7ODEYw44IGhkp0UOti2qnyZ
	 iEWKe151eAmFM5zQevlqFySAIqlEXP5zx29n04jG/HfS5d6T6G5ZsIynulAHXlICBF
	 24gZ4wtHB8HCg==
Message-ID: <6b345be6-3bd0-4410-8255-97bf661fc890@kernel.org>
Date: Tue, 23 Jan 2024 14:15:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add support for ICSSG-based Ethernet on SR1.0
 devices
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 grygorii.strashko@ti.com, jacob.e.keller@intel.com, robh@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240117161602.153233-1-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Diogo,

On 17/01/2024 18:14, Diogo Ivo wrote:
> Hello,
> 
> This series extends the current ICSSG-based Ethernet driver to support
> Silicon Revision 1.0 devices.
> 
> Notable differences between the Silicon Revisions are that there is
> no TX core in SR1.0 with this being handled by the firmware, requiring
> extra DMA channels to communicate commands to the firmware (with the
> firmware being different as well) and in the packet classifier.
> 
> The motivation behind it is that a significant number of Siemens
> devices containing SR1.0 silicon have been deployed in the field
> and need to be supported and updated to newer kernel versions
> without losing functionality.

Adding SR1.0 support with all its ifdefs makes the driver more complicated
than it should be.

I think we need to treat SR1.0 and SR2.0 as different devices with their
own independent drivers. While the data path is pretty much the same, 
also like in am65-cpsw-nuss.c, the initialization, firmware and other
runtime logic is significantly different.

How about introducing a new icssg_prueth_sr1.c and putting all the SR1 stuff
there? You could still re-use the other helper files in net/ti/icssg/.
It also warrants for it's own Kconfig symbol so it can be built only
if required.
Any common logic could still be moved to icssg_common.c and re-used in both drivers.

> 
> This series is based on TI's 5.10 SDK [1].
> 
> The first version of this patch series can be found in [2].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> [2]: https://lore.kernel.org/all/20231219174548.3481-1-diogo.ivo@siemens.com/
> 
> Changes in v2:
>  - Addressed Krzysztof's comments on the dt-binding
>  - Removed explicit references to SR2.0
>  - Added static keyword as indicated by the kernel test robot
> 
> Diogo Ivo (8):
>   dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
>   net: ti: icssg-config: add SR1.0-specific configuration bits
>   net: ti: icssg-prueth: add SR1.0-specific configuration bits
>   net: ti: icssg-classifier: Add support for SR1.0
>   net: ti: icssg-config: Add SR1.0 configuration functions
>   net: ti: icssg-ethtool: Adjust channel count for SR1.0
>   net: ti: iccsg-prueth: Add necessary functions for SR1.0 support
>   net: ti: icssg-prueth: Wire up support for SR1.0
> 
>  .../bindings/net/ti,icssg-prueth.yaml         |  29 +-
>  .../net/ethernet/ti/icssg/icssg_classifier.c  | 113 +++-
>  drivers/net/ethernet/ti/icssg/icssg_config.c  |  86 ++-
>  drivers/net/ethernet/ti/icssg/icssg_config.h  |  55 ++
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  10 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 556 ++++++++++++++++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  21 +-
>  7 files changed, 788 insertions(+), 82 deletions(-)
> 

-- 
cheers,
-roger

