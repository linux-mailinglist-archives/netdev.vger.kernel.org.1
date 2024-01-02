Return-Path: <netdev+bounces-60912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDF821D5B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA80B223FE
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C4101C4;
	Tue,  2 Jan 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iACNXBnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3E12E47
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2345aaeb05so980393366b.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704204415; x=1704809215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NV+ggyahgswbdFr6hEdZZnIqxozi8JAXSsLgMmdhOK0=;
        b=iACNXBnbyE0hlGUEvXiNfgrOpThZhVJEXQunJfV6q8fzV/b0Na7FV2rLMvPqxSMuc4
         2im3DMhiinmxkJ0CltRooCcVnCDotaiMJqWE9avNRPoJDA43nbG2jwZNDpifm5NJJYFO
         ZYuixO8XKYZB2O1y5nyDstpuuTGnVUN3pO+IiYUtzAX3giYagBLhawRQQGF7kcNr5FrA
         udBNA+RpaLLmFEOejf5TGH1teIR4ilKvuulBE41jygg9Vnz0cu5/7DFlHxm5vYGtSu8z
         923AMCTTRm+l+YWGjZTjDThVI1M0F6qQ1XufHccS5TxIBb0m7FopQ6+8AZAj7dj44bhT
         RA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204415; x=1704809215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NV+ggyahgswbdFr6hEdZZnIqxozi8JAXSsLgMmdhOK0=;
        b=pF3z/dq1muKbTzCQVacG++tk7u1SREV3xdI6GxYiUm1l0AlI2TTTymLhblgjWMGBMi
         2SaESx2uvGgVDGmpmsHKnRDOL/t3raJ8Z6Xe76NfoGFpcpvdchAmTtXqLyhDrW/xhU6Z
         7bThWlFsFCf6Edu1eTwyHD3shOwGYaHiXHAMyA4W6qaVYP6tX94PopH5Uy9HtnrhtGCY
         mTzyKXNP0Z9sYGt0/bjijw/0sjrrY0jCa+tCKMNLx7TNjmC175+E9ff93TSytpZNShFc
         kesKpYQNp9hhE6I4oOJoU22bHp/scneYZIRf/JXEF9pVmBTdKHSKGtj+dl2o0rG4M6VQ
         kvuw==
X-Gm-Message-State: AOJu0YzI6/pKya8oQXThat4Up8NBY+LpUEHqWVsWiONPIVVkbsoF/3ef
	jgpq3Cz6EiQuw0OS0QoXQmI=
X-Google-Smtp-Source: AGHT+IE2FS0wAy+CQ5jLCP5Km5U8adgNNGcsnhBK+5HmIpF8oyeFCgzQ4U8y2HM3V9vxM18spSchGA==
X-Received: by 2002:a17:906:289:b0:a19:a19b:55c4 with SMTP id 9-20020a170906028900b00a19a19b55c4mr9297694ejf.84.1704204415436;
        Tue, 02 Jan 2024 06:06:55 -0800 (PST)
Received: from ?IPV6:2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c? (dynamic-2a01-0c23-c1df-9400-2dfa-6a98-a1f2-c23c.c23.pool.telefonica.de. [2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c])
        by smtp.googlemail.com with ESMTPSA id au16-20020a170907093000b00a27a25afaf2sm3813599ejc.98.2024.01.02.06.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:06:55 -0800 (PST)
Message-ID: <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com>
Date: Tue, 2 Jan 2024 15:06:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: ezra@synergy-village.org, Russell King <linux@armlinux.org.uk>,
 Tristram Ha <Tristram.Ha@microchip.com>, Michael Walle <michael@walle.cc>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
 <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02.01.2024 14:42, Andrew Lunn wrote:
> On Mon, Jan 01, 2024 at 11:44:38PM +0100, Heiner Kallweit wrote:
>> On 01.01.2024 22:31, Ezra Buehler wrote:
>>> Since commit 1a136ca2e089 ("net: mdio: scan bus based on bus
>>> capabilities for C22 and C45") our AT91SAM9G25-based GARDENA smart
>>> Gateway will no longer boot.
>>>
>>> Prior to the mentioned change, probe_capabilities would be set to
>>> MDIOBUS_NO_CAP (0) and therefore, no Clause 45 scan was performed.
>>> Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
>>> least with our setup) considerably slow down kernel startup and
>>> ultimately result in a board reset.
>>>
>>> AFAICT all SMSC/Microchip PHYs are Clause 22 devices. Some have a
>>> "Clause 45 protection" feature (e.g. LAN8830) and others like the
>>> LAN8804 will explicitly state the following in the datasheet:
>>>
>>>     This device may respond to Clause 45 accesses and so must not be
>>>     mixed with Clause 45 devices on the same MDIO bus.
>>>
>>
>> I'm not convinced that some heuristic based on vendors is a
>> sustainable approach. Also I'd like to avoid (as far as possible)
>> that core code includes vendor driver headers. Maybe we could use
>> a new PHY driver flag. Approaches I could think of:
> 
> We already have a core hack for these broken PHYs:
> 
Excluding all PHY's from a vendor for me is a quite big hammer.
I think we should make this more granular.
And mdio-bus.c including micrel_phy.h also isn't too nice.
Maybe we should move all OUI definitions in drivers to a
core header. Because the OUI seems to be all we need from
these headers.

> /*
>  * There are some C22 PHYs which do bad things when where is a C45
>  * transaction on the bus, like accepting a read themselves, and
>  * stomping over the true devices reply, to performing a write to
>  * themselves which was intended for another device. Now that C22
>  * devices have been found, see if any of them are bad for C45, and if we
>  * should skip the C45 scan.
>  */
> static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
> {
>         int i;
> 
>         for (i = 0; i < PHY_MAX_ADDR; i++) {
>                 struct phy_device *phydev;
>                 u32 oui;
> 
>                 phydev = mdiobus_get_phy(bus, i);
>                 if (!phydev)
>                         continue;
>                 oui = phydev->phy_id >> 10;
> 
>                 if (oui == MICREL_OUI)
>                         return true;
>         }
>         return false;
> }
> 
> So it seems we need to extend this with another OUI.
> 
> 	Andrew


