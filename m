Return-Path: <netdev+bounces-60883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9095821C7A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C58DB209C2
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8F6F9E9;
	Tue,  2 Jan 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5HcgfaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81253FBEF
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5559bb6b29dso3992809a12.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704201536; x=1704806336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MMzF5MtXFQgvJhDv9u9sfZcH2ara5V4TbQc+tapY7cc=;
        b=K5HcgfaPkYHTm3d44gBEeNdlhX9jBdq0lr4avq5OpzFy3vwJe4u/YDA9yhSm2EYilF
         twFZpzXoiF38h97MCNVLEXX4GWLPokpem/7+oERAJ9djvjqjKKFLtRwbjATeLaXXZx7x
         uU1JMLHh3SM1k+GErvKD8YLT0Zg53cAhMb6n8BVRLXsp4jpkeVXypKuxec/g0oOv53zk
         A4xar/CPAdm/9ftD9MawSIGJEzb7NV+80BpHeky2vLH5ogq8zCzEXMokIiMaSEO12R1/
         VECpToAgTx49Rpfh8b5DQIbjhM6sV50FtGc8y95rTp1SnuRLXWQSbBVk7syEAsVTRNpV
         f6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201536; x=1704806336;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMzF5MtXFQgvJhDv9u9sfZcH2ara5V4TbQc+tapY7cc=;
        b=TJT3q65rx5JtMHrWTZYW87xnX3xZLE2fGeJpX5zktDXi5LBG+U7wpWMuHnKTbzxIsb
         6mV1sgYzLba4y/DaeVIYnSuXEw0VUF9Qo3mKfPH7P/PBWCP3b9Wi/iARwBY0SmXvOEU2
         2QQWd8+DuOl/Nop77mbyZmj1spZHHmjoAF/AeNSWOBPwb2+tUzzxyRdYDVQv9wZOYnrj
         mkFTyIq64pHeD0MNcpRbIK+blHBYTfDLblpQMV0zNikd9LUWFk5w+FgCAUcCs0tSuAyX
         5CCiKz5lKCl7t4/e9y137NrvchjV0sRfeKyuuN+aebbH8pmr/p5Ts1RXimCgjifn0uph
         jXAA==
X-Gm-Message-State: AOJu0YzSKGAHvSLVK1MqeAymCyZvdl5YGwC9Tc7HIpZvmQKqyINpnTqv
	csLhleHegfJVlzNc1NCMG8Y=
X-Google-Smtp-Source: AGHT+IHW5+vWQPoV9wIsUzUbM8QhPXatMD+WGVu6DCuyVnTDFgGgj0S2KQjPNFEk5VUgBf5CcfnOCw==
X-Received: by 2002:a50:cdce:0:b0:553:6c38:148a with SMTP id h14-20020a50cdce000000b005536c38148amr10049297edj.39.1704201535340;
        Tue, 02 Jan 2024 05:18:55 -0800 (PST)
Received: from ?IPV6:2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c? (dynamic-2a01-0c23-c1df-9400-2dfa-6a98-a1f2-c23c.c23.pool.telefonica.de. [2a01:c23:c1df:9400:2dfa:6a98:a1f2:c23c])
        by smtp.googlemail.com with ESMTPSA id r9-20020aa7cb89000000b005550844cd1dsm9858492edt.30.2024.01.02.05.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:18:55 -0800 (PST)
Message-ID: <ff0fb7aa-8985-48f1-8296-1b253625e19d@gmail.com>
Date: Tue, 2 Jan 2024 14:18:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 03/15] net: phy: realtek: rework MMD register
 access methods
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexander Couzens <lynxis@fe80.eu>,
 Daniel Golle <daniel@makrotopia.org>, Willy Liu <willy.liu@realtek.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, =?UTF-8?Q?Marek_Moj=C3=ADk?=
 <marek.mojik@nic.cz>, =?UTF-8?Q?Maximili=C3=A1n_Maliar?=
 <maximilian.maliar@nic.cz>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-4-kabel@kernel.org>
 <ZZPwdEgwCVaHdyZB@shell.armlinux.org.uk>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZZPwdEgwCVaHdyZB@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02.01.2024 12:16, Russell King (Oracle) wrote:
> On Wed, Dec 20, 2023 at 04:55:06PM +0100, Marek Behún wrote:
>> The .read_mmd() and .write_mmd() methods for rtlgen and rtl822x
>> currently allow access to only 6 MMD registers, via a vendor specific
>> mechanism (a paged read / write).
>>
>> The PHY specification explains that MMD registers for MMDs 1 to 30 can
>> be accessed via the clause 22 indirect mechanism through registers 13
>> and 14, but this is not possible for MMD 31.
>>
>> A Realtek contact explained that MMD 31 registers can be accessed by
>> setting clause 22 page register (register 31):
>>   page = mmd_reg >> 4
>>   reg = 0x10 | ((mmd_reg & 0xf) >> 1)
>>
>> This mechanism is currently used in the driver. For example the
>> .read_mmd() method accesses the PCS.EEE_ABLE register by setting page
>> to 0xa5c and accessing register 0x12. By the formulas above, this
>> corresponds to MMD register 31.a5c4. The Realtek contact confirmed that
>> the PCS.EEE_ABLE register (3.0014) is also available via MMD alias
>> 31.a5c4, and this is also true for the other registers:
>>
>>   register name   address   page.reg  alias
>>   PCS.EEE_ABLE    3.0x0014  0xa5c.12  31.0xa5c4
>>   PCS.EEE_ABLE2   3.0x0015  0xa6e.16  31.0xa6ec
>>   AN.EEE_ADV      7.0x003c  0xa5d.10  31.0xa5d0
>>   AN.EEE_LPABLE   7.0x003d  0xa5d.11  31.0xa5d2
>>   AN.EEE_ADV2     7.0x003e  0xa6d.12  31.0xa6d4
>>   AN.EEE_LPABLE2  7.0x003f  0xa6d.10  31.0xa6d0
>>
>> Since the registers are also available at the true MMD addresses where
>> they can be accessed via the indirect mechanism (via registers 13 and
>> 14) we can rework the code to be more generic and allow access to all
>> MMD registers.
>>
Marek and me had a separate communication about the version of these PHY's
used as internal PHY's on RTL8125 MAC/PHY combination.
Depending on the RTL8125 version the PHY's identify as either RTL8226 or
RTL8226B. Problem is that these internal PHY's are crippled and don't
support the indirect MMD access over c22.
In my tests all indirect MMD reads returned 0.
Therefore this patch has to be reworked.

In order not to break handling of the RTL8125-internal PHY's, we have to
keep the access to the vendor-specific registers. What could be done:
Split the PHY driver for e.g. RTL8226B into one for the RTL8125-internal
version and one for the standalone version (using match_phy_device and
maybe using the MMD read result as differentiating criteria).
Then the one for the standalone version could use core c45 functions.

>> Rework the .read_mmd() and .write_mmd() methods for rtlgen and rtl822x
>> PHYs:
>> - use direct clause 45 access if the MDIO bus supports it
>> - use the indirect access via clause 22 registers 13 and 14 for MMDs
>>   1 to 30
>> - use the vendor specific method to access MMD 31 registers
>>
>> Signed-off-by: Marek Behún <kabel@kernel.org>
>> ---
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
> 



