Return-Path: <netdev+bounces-111062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579492FA5B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C601F22856
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E916F0EF;
	Fri, 12 Jul 2024 12:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4C1662FE;
	Fri, 12 Jul 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787753; cv=none; b=axWfArI9+W9P1kb6caHorFuZZrj6Hgi+fc0c51j2ra3qVKFhG5zVPnVdCDgy5KQX2loGzMl88gZSwM+dJqrgeUkfyYaHcPpINqCJQsd6sRadhOUhrXNRWf/Y/Va0h4VY90rjA2s+zEvre/Veumtlb80yEO4p0KqNk1TOO0er5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787753; c=relaxed/simple;
	bh=9oTZH6MuHVYNkt6+xGWDnCLbT+CpXGCMIKW+nTirfis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQmZx4Dx+ii4Zgnz5Le6NtKVayB84G/0iNbGy+9Tpj85qGgeo+r7E8ctG/cKp1jaLziJdZVR14DVaU0VXfoxQ50XfcjLTNuxPBGz+0zNdJQfSJO2+15qFu85x9ySOnG+435cs8rM2/dhKiMjtdIzr5XI5iOiwxT/KMAfKbzhYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af442.dynamic.kabel-deutschland.de [95.90.244.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E6D1E61E5FE05;
	Fri, 12 Jul 2024 14:34:41 +0200 (CEST)
Message-ID: <131066c6-5ef6-450e-b85a-b75edf459368@molgen.mpg.de>
Date: Fri, 12 Jul 2024 14:34:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] MAINTAINERS: Add an entry for Amlogic HCI UART
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-4-7f1538f98cef@amlogic.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240705-btaml-v1-4-7f1538f98cef@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Yang,


Thank you for the patch. `git log --oneline` does not contain the/your 
name, so people would need to look it up. Maybe:

     MAINTAINERS: Add Amlogic Bluetooth entry maintained by Yang Li

or

     MAINTAINERS: Add Amlogic Bluetooth entry (M: Yang Li)

Am 05.07.24 um 13:20 schrieb Yang Li via B4 Relay:
> From: Yang Li <yang.li@amlogic.com>
> 
> Add Amlogic Bluetooth driver and driver document.

Does this match the change of `MAINTAINERS`?

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd3277a98cfe..b81089290930 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1140,6 +1140,14 @@ S:	Supported
>   F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>   F:	drivers/net/ethernet/amd/xgbe/
>   
> +AMLOGIC BLUETOOTH DRIVER
> +M:	Yang Li <yang.li@amlogic.com>
> +L:	linux-bluetooth@vger.kernel.org
> +S:	Maintained
> +W:	http://www.amlogic.com
> +F:	Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
> +F:	drivers/bluetooth/hci_aml.c
> +
>   AMLOGIC DDR PMU DRIVER
>   M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
>   L:	linux-amlogic@lists.infradead.org

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

