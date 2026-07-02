Return-Path: <netdev+bounces-304264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S6GfLq69Rmr2cQsAu9opvQ
	(envelope-from <netdev+bounces-304264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:36:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE636FC8F9
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:36:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MOnhQbf1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304264-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304264-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6833019F28
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DB938D3ED;
	Thu,  2 Jul 2026 19:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726C38C412
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 19:29:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020578; cv=none; b=KFYocRi6Y7J5lGcbzB3p3uw+eGY04POXfmAVFhkykW3GIQfgH6PdyJ1RIshlgzIFNLCOetvqCa8v70j9qwKgOkWd575Q5/UzZhMCG6lGMIYRHy5q59TeNaNaI+A3R25a9nnO2rReGH81gskndq1+HPAQi+kFd6ZrcWDj2vj26Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020578; c=relaxed/simple;
	bh=UdMJM06ebK67YQ2Mnbs0Jp1/l3ZNaXIh/MKaQ3oYKr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkHbb8V/ZcZgLRECAPDqohfEJ2DODgUUlySVvhiQclBRmiveoaN2yj5kP+HqqRG7t+3d4PP9MwPtEeE8lBVHy2u2qt64EPzKmNdKRi39w7mPtwcG1X4kqifSTas8Gf6aA3Cqz12GIPASeFsbvqUYSqswtom+IGzR5XsfQ6UNkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOnhQbf1; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-476d8e647e9so1987543f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783020575; x=1783625375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zAwDyBfy9pmItaLqNOcnGFdZ3qhtmyuBm6fxfzFEds4=;
        b=MOnhQbf1/CqJFRSRzJybl3CWwBroY7cPKOcHx4jCNrtLqHUMyB6ujxtqzQhD4Q4xDh
         sudlR5oq3V72pp9i+NAt6O2GCCUkUdhSrA3AGe12ObYoXHPiguj9xOgRJ7m17BoLLkVO
         /F+TD0qhA47QA4NF3Ziw/3TsbzePPCk6tDNX0VYltyakCRYMVig7jUAwZIE67tCxWvvJ
         3VcdZMQyB793F7+xbGrSL3cMFnO/qVVWUDYuSYjeUTb6CdXMPPSFVHr1Xy1gJXBG1/fM
         4/MGvCAXEPHeGMgK84h+38rMddq9Ozuv6Y2ITiznjFl7luuxkSUkr9A9HGWRPzREg024
         In1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783020575; x=1783625375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAwDyBfy9pmItaLqNOcnGFdZ3qhtmyuBm6fxfzFEds4=;
        b=YXIOBc3bBkTiPRLp4JAts7T4pdAo137PBg2hy6kwFC6EMC6AA+QzcZKWoZwsJNwbaN
         Rc+BKFO5ynsDapBs9/tDDbBU5VdQ+acwZYuESqM05FPfMv7N0OXJyeLR4rphD8mlcAWO
         GFras9/htOTc62cUXquU2UbpNirkwpFl0Y7G0cAUowXlx2fHV1WdwvkJATE+9u3bLrsn
         BLZoNnbHWMrRCiv5yEe9QcBk6eN5ZxUDrnMrh+57QcCxOwBI9O1UR1Z05n1WagR6du2r
         SPoY51gCS6FsJGBudtp06D5G87PwBPJaTXh5ammEDJjOwpBiUap8EsA8dlWivcxH34tr
         vojQ==
X-Gm-Message-State: AOJu0YyVyfIMkUzrk76mESh813pA+OxP4XMAezTJg+XbrO40kF6fOA89
	6qoHqbmLR3R8YUvcWR8S1hZbCqp3EdOqTdow7yLRXQCd+Eagkh3vxhah
X-Gm-Gg: AfdE7cngDPJ0WRJsoAdi3KraQ/E9QUhr1cL38r9GPW/zQrVWPBt4sFiN+xQrJYwbvg7
	n8ERUWT8sl5R0geJOSpYF8Ishp+A07Xq2Py/Lmio1XdNrJRS/5a9Aqm5uKGzaFhKNytZZR9OOz2
	8EWLW8nyBasRLe5Vp9LpP/0HG0KzRuyn86F69+fOmhVbCg2Lt0xZqVPtPbUJ+Q+cLcy+Kns2ZwE
	b2SaD/Minvejuve0NKe0aSFEutBF+Z/2mwV+UEYPLnjNUTnpiIVkQ0pN7DZzkXsQ5V8UNGGsZUF
	1quXZzUHK5i6U9CWOzDiIdJRX3BN9cF5VGU0AiMzFfHYuUijoVX02ZYzx6GEg+lcm1R4fa3QWKk
	K/uWonOIbf0doFgzst+Va8gostJQ0emA/Skpg77fMyWTTEGgqjFe+ZQ05MJEKnWyQUGcOKiBpKZ
	gh+wB0ThR1b13s1KFRUK/Mf1HMuyha6PuxNddPRqQbe0yvfpxe0cJH3TXglOW+KOhyrPo+nk9bC
	6NoXRzJ
X-Received: by 2002:adf:ea82:0:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-4775be03177mr9148509f8f.37.1783020574993;
        Thu, 02 Jul 2026 12:29:34 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3db964sm11113317f8f.8.2026.07.02.12.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 12:29:33 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <d6a56d05-0c6f-49a5-9281-1194b62ab86e@gmail.com>
Date: Thu, 2 Jul 2026 20:29:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
To: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Jerry Ray <jerry.ray@microchip.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
 <20260629-s2500-mac-phy-support-v6-12-18ce79500371@onsemi.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260629-s2500-mac-phy-support-v6-12-18ce79500371@onsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304264-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EE636FC8F9

Hi Selvamani,

On 6/29/26 18:23, Selvamani Rajagopal via B4 Relay wrote:
> +if NET_VENDOR_ONSEMI
> +
> +source "drivers/net/ethernet/onsemi/s2500/Kconfig"
> +
> +endif # NET_VENDOR_ONSEMI
> +
> diff --git a/drivers/net/ethernet/onsemi/Makefile b/drivers/net/ethernet/onsemi/Makefile
> new file mode 100644
> index 000000000000..f3d4eb154313
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the onsemi network device drivers.
> +#
> +
> +obj-$(CONFIG_S2500_MACPHY) += s2500/
> +
> diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethernet/onsemi/s2500/Kconfig
> new file mode 100644
> index 000000000000..f2e8d5d1429d
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# onsemi S2500 Driver Support
> +#
> +
> +if NET_VENDOR_ONSEMI
> +
> +config S2500_MACPHY
> +	tristate "S2500 support"
> +	depends on SPI
> +	select NCN26000_PHY
> +	select OA_TC6
> +	help
> +	  Support for the onsemi TS2500 MACPHY Ethernet chip.
> +	  It works under the framework that conform to OPEN Alliance
> +	  10BASE-T1x Serial Interface specification.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called s2500.
> +
> +endif # NET_VENDOR_ONSEMI

S2500_MACPHY still has that duplicate dependency from being inside two
of these:
'if NET_VENDOR_ONSEMI..endif'

And I already pointed it out on v5:
https://lore.kernel.org/all/90f84945-e83f-40a8-8d9e-a477c45579e9@gmail.com/

:(

- Julian Braha

