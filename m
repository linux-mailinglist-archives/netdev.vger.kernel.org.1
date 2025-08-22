Return-Path: <netdev+bounces-216012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD0B31782
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D665B63294
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1D43090CB;
	Fri, 22 Aug 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vK5SYRbK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F82FC007;
	Fri, 22 Aug 2025 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864978; cv=none; b=UnVbgHM/azXULeyzfpc5ajfwq+xr9nKMYq2n8RXAlEFZ3ujrT45KELB/itYT1cID2X6rzIt4/L0MdYhGjz6jfmu4EpCXefqhYhNV6Dol5AXik9xNV3NwrvYFt5hDe1RQwqi4d0ZDVtXNvN01Qq5Hxp88qHyv8hSmga0gKPXHKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864978; c=relaxed/simple;
	bh=3Ea7W0dwKnTlVfxRkgXHCe2WVUuOP11xif5wEmfOclM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LQZ1jICEBMNzx4+Z+kpdEESDIeQUqdN4iRxKdDzQrT4DSDhWiAp3dY3we1h4FdY9S/J3/oYKzJvZqolzcHkVbiZ5Ckf519+EE4KYfmLTXpeSSxwKpioswf6iP8UW3Yl25SfuC+eIItIMGnnyaPCbClyIpsjRU+mBL0+d+tDJ+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vK5SYRbK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755864978; x=1787400978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3Ea7W0dwKnTlVfxRkgXHCe2WVUuOP11xif5wEmfOclM=;
  b=vK5SYRbKb8No+twO1Sq/8UVyGGoMYlqLdRLXXXu9ztsq6jncKmbOo6+1
   shICueE5ZQ4WPleKmL/zDvaZghDlWQaE+u9ieMCIsnjUwRoNB5xSsFAML
   13tsQRaR8XKfOhdjh1jl1S8g3/fiqGnUhenhPxrauL5K01M5yW2mZPavj
   lCkvcCYxzC0deYNxd9Z7//5REpw3fq1Qvs5xMI3OM5y/p0f/CcAtMZJLs
   V46810FIpF5xktsoxzvJlpvRyJvTGG8Ag5PxjKcJuU8CqUVHg8g11yZKD
   UMs6z8VDWk+nnVcFfK3JLbqdLTYlUOSMzcOe/LUnGDlTEudkfjk/8ZcOg
   A==;
X-CSE-ConnectionGUID: jcwXdTWwTtyRRk6+L1Fb/g==
X-CSE-MsgGUID: /sDrhHoERLykyKvbaKhrcg==
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="276922450"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2025 05:16:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 22 Aug 2025 05:15:51 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 22 Aug 2025 05:15:47 -0700
Message-ID: <bc7b0167-7514-4aad-a4dd-bd1d9929e99b@microchip.com>
Date: Fri, 22 Aug 2025 14:15:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: net: cdns,macb: Add compatible for
 Raspberry Pi RP1
To: Stanimir Varbanov <svarbanov@suse.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-rpi-kernel@lists.infradead.org>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
	<jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor.dooley@microchip.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-3-svarbanov@suse.de>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250822093440.53941-3-svarbanov@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2025 at 11:34, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The Raspberry Pi RP1 chip has the Cadence GEM ethernet
> controller, so add a compatible string for it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index 559d0f733e7e..0591da97d434 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -54,6 +54,7 @@ properties:
>             - cdns,np4-macb             # NP4 SoC devices
>             - microchip,sama7g5-emac    # Microchip SAMA7G5 ethernet interface
>             - microchip,sama7g5-gem     # Microchip SAMA7G5 gigabit ethernet interface
> +          - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ethernet interface
>             - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
>             - cdns,emac                 # Generic
>             - cdns,gem                  # Generic
> --
> 2.47.0
> 


