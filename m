Return-Path: <netdev+bounces-187412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA1AA700E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354343BF405
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5B23C50A;
	Fri,  2 May 2025 10:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2F1EA7F1
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183114; cv=none; b=ZVt4RD3jWdliWBRHwLzZuUEqafcac54V4w+Oo01MZZ4+Hyeep6BJ5LxFNPW7H8h1O9Emc8z/gEuV3ljUThudC3aMwVY4n5jGGGnTq3b+uGax47yu6xp3c5ukW4b1ZVe0KKf78/K3xWFNjVIx1T1HAy/U4qHnXSUhPtCh0MOACfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183114; c=relaxed/simple;
	bh=/Bg1W3vx5VqNBb4X9ISt+wzbx9RV1XwLd37krZ0v+/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZOqTVC5XYaxnkzgQkxonmo4z+7gzkaAlBfezp+5iZiDZrHw8R/J0yWjx/zHd0nseIcyMQcOWrwmJX5yJ3ibs0dH3ziXUtOlA5vJD2E7+p+qQxnpmwgBWCxruU8QtaNJrjfy8XAm+ZvIWjg7lmcJamnfEya91iZ0Ic8RUen9CfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-NpDObbQYM_eFGHiT3Wb_ZQ-1; Fri, 02 May 2025 06:51:50 -0400
X-MC-Unique: NpDObbQYM_eFGHiT3Wb_ZQ-1
X-Mimecast-MFC-AGG-ID: NpDObbQYM_eFGHiT3Wb_ZQ_1746183109
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so7810225e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 03:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746183109; x=1746787909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pHoDrN/cn5NUfRY8+fhnaI8XRygteksiSbMuei/zJ8=;
        b=KEfov7nFun5LgcsIC/LvgaI152jWByN2u4SJI3365/KRAkhQS6hZC4S4Qkok9cwdUq
         I8k1ThAFmcsdLKDFdCUis/p1KPEkTQBrx8Htw2ZsFbPyjFhOL2wLW/D0O3dKvPANE2Gi
         71ql4LSRMiCDnvNOHjeCPZze/uswz6u0e9j/bx5OIx09U2QYvARgGZ3YFQ6Go8IMqMFo
         f2RrMo+VDzFXnobMMgcovk02rH9dYt1o7avy+dWOZ7ewdBkuCbJ/rWZNDdyU8M4DsNQD
         hvSUV4tE8nI0mPxYJucNzdjPi4srmnCFCkamO6sINR+tMPpusHz/8cvSv3NUC8jVTznl
         Mozg==
X-Forwarded-Encrypted: i=1; AJvYcCWxFdd31YGSLHjykf2ACmIh8OXL6BZjt38yac2haAWDWKfyRIhwZ6E4+fUovoF51mMp7gUxX/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeO/yPkMHyX1FIJIB+J8Ej8WckEXrgAtzvmckOt9mBthYfzLTX
	9BbfL/Pkt0BUIvfkB+eEH5894zvaEE7TdILYHLDeJZ8non1un4JgVKxNLrpguznyPIyPmyyo478
	GqI5Oy2eI4vwamrmuCCbqJ8dUdNLQ5NDQHUJjFH4BqdIqv7w0C1okuw==
X-Gm-Gg: ASbGnctKwX1h4PtfUSTvkziPgw81FmS9RbMocQx3dO2uPswdSQjy1KcBPWt5699IpuS
	PyhA5wGEV7urZGRXMnczZhycXc/Lm1OZ9D4WFFyWCs9AjZdYK+Sb/Iae2wxA4HPm3ka8CGC5RjM
	KiWKooIuFMp+/ya7HUj3KY581zAQofQFEtPL+4hn2tymXZQQh3oNHUgKAjPNnDl9/1hHlrc8Erl
	WIg4N0XWmidwh1/Dgt3Ctq4zCYUr/E24citrSOvp9UO83uZJH4XbtTTblFE9UxKjXDQU5PHNJ7h
	ddpKStM76g7uFhNBV5g=
X-Received: by 2002:a05:600c:3acd:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-441b72c0a66mr49043815e9.9.1746183109574;
        Fri, 02 May 2025 03:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0ji9b4/ZVgNefxRUhb/GlgmAOtjpg49JM7ialo/DRbM3k1g2bgLpI6NcCCmHH8X+ehawG3A==
X-Received: by 2002:a05:600c:3acd:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-441b72c0a66mr49043615e9.9.1746183109261;
        Fri, 02 May 2025 03:51:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af4546sm87615685e9.22.2025.05.02.03.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 03:51:48 -0700 (PDT)
Message-ID: <4e68ca40-85b8-4766-9040-edf677afd0f7@redhat.com>
Date: Fri, 2 May 2025 12:51:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>,
 Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
References: <20250429-marvell-88q2xxx-hwmon-enable-at-probe-v3-1-0351ccd9127e@gmail.com>
 <20250429200306.GE1969140@ragnatech.se>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250429200306.GE1969140@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/29/25 10:03 PM, Niklas Söderlund wrote:
>> @@ -765,6 +768,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>>  	struct mv88q2xxx_priv *priv = phydev->priv;
>>  	struct device *dev = &phydev->mdio.dev;
>>  	struct device *hwmon;
>> +	int ret;
>> +
>> +	/* Enable temperature sense */
>> +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
>> +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
>> +	if (ret < 0)
>> +		return ret;
> 
> nit: I wonder if it make sens to create a helper function to enable the 
> sensor? My worry being this procedure growing in the future and only 
> being fixed in one location and not the other. It would also reduce code 
> duplication and could be stubbed to be compiled out with the existing 
> IS_ENABLED(CONFIG_HWMON) guard for other hwmon functions.
> 
> That being said I tested this with mv88q211x and the temp sensor and PHY 
> keeps working as expected.
> 
> Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Since this is net-next material +1 for the helper.

Also AFAICS this is fixing a net-next regression, so it needs a fixes
tag, too.

Thanks,

Paolo


