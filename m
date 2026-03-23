Return-Path: <netdev+bounces-270559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAdQNAxMwWlbSAQAu9opvQ
	(envelope-from <netdev+bounces-270559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:19:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1372F4366
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C10B30C2D93
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35153AF675;
	Mon, 23 Mar 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUSxAObN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047C3803EF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275081; cv=none; b=HNTVD1szInM0Ruj1psYMORe0PCpxqt+Q8qTRhmmvy+uG7yNq/Bq9kocoI638soJBYJUDpFwaewR5cNommI/vdT7mx+VOTsu+F6Sbg12kENxQCOyfnTc4sxfTTXMxoDzFOyB0CDXr3AKD8B/3+Jqy7FnUzs0P2vSNUkZvufaQtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275081; c=relaxed/simple;
	bh=NPLgoQ54nUrpRSpjDicHyvfMEJi3QQp4eYQt9XoqXIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko57kazuRZx8Utaq9KrNETIp5svDwM9gYhGvXA/T5p1mI31zi4Js5zHnM/WuHRRASM0eGrjsirBRduy1AyxgqhN8MJvCXobjZK90kCbVHBt+XN6e+e7un2EB9M9dsGdxFBSw+O0SEld/yYqVqIC0bsN8p1myRRa3HOrUTVJ1JzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUSxAObN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41920so90040b3a.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774275080; x=1774879880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WF+92fBA4xLIl6WYCDqgvYmoigvLq3NhTY5OAPE/7Rs=;
        b=hUSxAObNhW0Ud7z96K42trUcLkb8SbhTX92Hw7QJsAdJ7pd3CVJM+7kVa7SqOHBjEX
         nH6DJ7bHaRXgCJs1+2yLaTstScpW53rbDbCDJ7W/EStm9UZ3saFuznmHO0mokFcotyhD
         KuO1ClZ5on8PZOmFln96GRtJ3RgqjY71IG0+D9jfe7XFx0Ho3rDqtksC2apbJjEWnTVe
         MXT5dcTJzoVbkjm3jLmm1NSHzZ3rTcSk7QpxpcO3I7XJk1iyo0u+qgyuC8e2aM010nM4
         ZMwdJbi5Xv283nstllsPNI7atQp2NN1PEFQwhnOi+Md4bjAAeWxTKcPRa6PLpsU6AYwR
         9HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275080; x=1774879880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WF+92fBA4xLIl6WYCDqgvYmoigvLq3NhTY5OAPE/7Rs=;
        b=ktd8+6t0VqhqFfW/FiOZ0sv6SsVJN8pWNJQknoyskStnlweSkFYhEMn1Elnq7/ydPD
         ca8Faz3qIsPPAz98ITtykfxjcyVwBpjs/Til0UekLv0zqd60wJ+8WxHfFS8o4sDPJMow
         jYUCxHtk5qHOQBkL/VfcTq57ZE1uaPmYmspHL42kQ8zK7o7CtW558x19mI90v8auRvR3
         +6DGmAMOoyKSZ8iBSG5ppwYayV0swo2tL8UtfDrQAjR5bCTNoE+JVucUTloqVoisr/29
         cPBhQlL+10lEzH4Dr5Px1IuO/Mqggmw9JU4+YRF6Vn95QAjHJXM/DyF+gV6iSixSPGGt
         OSNw==
X-Forwarded-Encrypted: i=1; AJvYcCWZfZYW0fcHuOMKrqhU6ssTgt6E37Y8t1oJQc/s2paEg39nfMdszzHZm3jX0COVMj2+kFTvzE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhM8ASNrqHyQBKAwy2QceDEgU66Jduu3jVhR/B94FKABwrGKV6
	xb1GPVHjMif5djAAg2IPkCi9vjo8eBo5AflKsgGr09RQOAey5w3jLC/W
X-Gm-Gg: ATEYQzyhcwBGePSMAaTEiHShaUvAIJfQJJ2wt/lUBVWLyIeweE6IRzXxJsxqBbZSonm
	Jqm+eRfzBao53D0BxZUeFvmr6B6U/PUr+zbzSvLcHQ6N9b0++mV+jLcqtqpVe1sctc4B9ZzUZJT
	2XIQeR5kkYT6F1elulc8R8VZbY4kzhwMt9zU0y/ex+ySUipqkdXvJzYMIWut2DpDBz2N8ue3vT+
	hzfM/wpdzLQwXGg9TxsepP+e2ypFrAs0MT86i2UpFOBvxjpjsW0OSgx3pUrnP5nogZEqBnWnAFo
	+7+FYzmXXpyjohLI71H63HRBW/ECOGl6m5WIrJh5Ajg9Wo0Pt9n/gEP3ZSNGilX6a0DFPrwAgzq
	6wscUfN/jZOumopNR13LRi036urR90NBvI42inhO0XXiBXrJrQliSoHqIO+97iSUjmVR2tzlwkO
	ysoBwWAt5TdCIvlKUiKlgJPi9VxGPAMvrvCLjQXEsvaJ6VWy1/hcZHiKNbHHFO6mocO3uoR+Ziw
	nTlvuYHDu2lXQx0XBO8Sw==
X-Received: by 2002:a05:6a00:180e:b0:824:9bc5:e946 with SMTP id d2e1a72fcca58-82a8c39d91bmr10357018b3a.46.1774275079959;
        Mon, 23 Mar 2026 07:11:19 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c38565096sm4628944b3a.51.2026.03.23.07.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:11:18 -0700 (PDT)
Message-ID: <042ec7fb-a5a6-4d21-9bf7-26a58a97bbea@gmail.com>
Date: Mon, 23 Mar 2026 22:11:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: phy: airoha: add AN8811HB MCU assert/deassert
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ericwouds@gmail.com,
 frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com
References: <20260315134155.142750-1-lucienzx159@gmail.com>
 <96563ae4-f5fc-437c-b90e-92e7981490fe@lunn.ch>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <96563ae4-f5fc-437c-b90e-92e7981490fe@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,public-files.de,makrotopia.org,airoha.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270559-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8D1372F4366
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew

Sorry for the late reply.

Andrew Lunn 於 2026/3/18 上午 02:18 寫道:
> On Sun, Mar 15, 2026 at 09:41:55PM +0800, Lucien.Jheng wrote:
>> AN8811HB requires the MCU to be held in reset before firmware
>> loading and released afterwards via a dedicated PBUS register
>> pair (0x5cf9f8 / 0x5cf9fc), accessed through the PHY-addr+8
>> MDIO bus node rather than the BUCKPBUS indirect path.
>>
>> Add __air_pbus_reg_write() as a low-level helper for this
>> access, then implement an8811hb_mcu_assert() / _deassert()
>> on top of it.  Wire both into an8811hb_load_firmware() and
>> en8811h_restart_mcu() so every firmware load or MCU restart
>> on AN8811HB correctly sequences the reset control registers.
> What happens if the MCU is not held in reset? Should this be
> considered a fix?
If the MCU does not perform the assert/deassert sequence before loading 
the firmware, the AN8811HB may not function correctly.

Yes, this should be considered a fix.
>
> What are the valid PHY addresses for this device? Do we need to worry
> about the PHY is at address 31, is the dedicated PBUS register is at
> 7?
The AN8811HB PHY address is restricted to 8–15 (decimal); therefore, the 
PBUS address will only be within the range of 16–21 (decimal).

Therefore, we don't need to worry about the PHY is at address 31.
>> +static int an8811hb_mcu_assert(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	phy_lock_mdio_bus(phydev);
>> +
>> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
>> +				   AN8811HB_MCU_SW_RST_HOLD);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
>> +	if (ret < 0)
>> +		goto unlock;
>> +
>> +	msleep(50);
>> +	phydev_info(phydev, "MCU asserted\n");
> Please don't spam the log. phydev_dbg() or not at all.
Got it. I’ll use phydev_dbg() instead to keep the log clean.
>
>>   static int an8811hb_load_firmware(struct phy_device *phydev)
>>   {
>>   	int ret;
>>   
>> +	ret = an8811hb_mcu_assert(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = an8811hb_mcu_deassert(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
> Assert and then deassert, but no firmware download between? That is
> not what the commit message says.
The intended sequence is: asserting the MCU, deasserting it, and then 
downloading the firmware."

I will update the commit message.
>
> 	Andrew

