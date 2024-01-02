Return-Path: <netdev+bounces-60802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226218218C1
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C0A1C21751
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C46122;
	Tue,  2 Jan 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMqnum8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B05CA62
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7aed09adso7033718e87.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 01:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704186870; x=1704791670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gfRZC+5W+64TPapfR6YTjYDCTOOmBUpfffxhg/weS4s=;
        b=FFMqnum8n6Q0rRZJGFAnj3GUaHvSXfSrro8iuyLVhNxzgNK2uDBmfHrWpp2wT/1GGP
         xfW9edOXENVJ7nMcBJpjfMmNkm9t2vgJTojMDeJegy9eb0uWjOQer3LQwLG4/1DaA5t+
         XBu8y7A1quxpjSFipUhc8FJ1mL7PjcrmYp6Y1Yf2tJBBsRINKscYtRT6pMOF1e7Rmdo8
         1VXu+0q9lC/SlGsPtfzGmYC/fcjPFNhmCfeDzThCyK8BNxms3p9llVax4qRStspAkiRr
         +8Xc6VL0FbJqZiMMwsYsSzYDinoWU8fdSkzOTchE12J7HUnJkP0FEGOuZ2An7lyT2iWf
         KjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704186870; x=1704791670;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfRZC+5W+64TPapfR6YTjYDCTOOmBUpfffxhg/weS4s=;
        b=UA0AI2iv8surrqaIcTycXwI9DCrPWpXerGMhG5hK4dae5PgDIAsqdINfI/72D5gQBD
         Av+h7iSVFvLx6PsTdCwYKShHnoN2lyAo4Xsi4Rz4cnd0fxNR0JlcX9taK9SdwQC+G0D7
         wsGpZAJNLDzSU/3mXEI5fcKeXNDrOJLMcyfkTpVdE2iGHc/c0b7UatkX5HpeNn5YWP1L
         xU+7VodyFm5+g1SMvCkrzjZLiVtXtkR2L69PsaLF5mec/XQclGMWgE2PLAY2D9mZrzVn
         p02YxsTEjVdJjFTJbFgMMuQiZEdUuy66HxWlO9Nrn8KVNw88Fl3OmoIBrHnYL5EluG1i
         482A==
X-Gm-Message-State: AOJu0YwGkSTlCAOIbiKradCai8js3Ychdtc3vcPO5K5bQhghfzuQYZjg
	IBT1vc7jStRdY2u6Tsn8OhM=
X-Google-Smtp-Source: AGHT+IFJg7ftkRjekc+r84Tv4Pj6WrH2l83tj+oum01mNqrTYc3lIcqMdFy0Vv7sHk/JFTZ6CXO9tA==
X-Received: by 2002:a19:e043:0:b0:50c:327:9932 with SMTP id g3-20020a19e043000000b0050c03279932mr7832066lfj.107.1704186869452;
        Tue, 02 Jan 2024 01:14:29 -0800 (PST)
Received: from ?IPV6:2a01:c23:c1df:9400:f193:7157:1393:5cbd? (dynamic-2a01-0c23-c1df-9400-f193-7157-1393-5cbd.c23.pool.telefonica.de. [2a01:c23:c1df:9400:f193:7157:1393:5cbd])
        by smtp.googlemail.com with ESMTPSA id wh14-20020a170906fd0e00b00a233efe6aa7sm11556478ejb.51.2024.01.02.01.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 01:14:28 -0800 (PST)
Message-ID: <d229f8c6-778f-4871-ac58-0a0ece00fb43@gmail.com>
Date: Tue, 2 Jan 2024 10:14:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
To: Michael Walle <michael@walle.cc>
Cc: ezra@synergy-village.org, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha
 <Tristram.Ha@microchip.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 netdev@vger.kernel.org
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
 <cf86ad14e88362952c9f746dfb04cff4@walle.cc>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <cf86ad14e88362952c9f746dfb04cff4@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02.01.2024 09:50, Michael Walle wrote:
> Hi,
> 
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
>>>     This device may respond to Clause 45 accesses and so must not be
>>>     mixed with Clause 45 devices on the same MDIO bus.
> 
> If implemented correctly, c22 phys should never respond to c45
> accesses. Correct? So the "Clause 45 protection" sounds like the
> normal behavior here and the "may respond to c45 accesses" looks
> like it's broken.
> 
>> I'm not convinced that some heuristic based on vendors is a
>> sustainable approach. Also I'd like to avoid (as far as possible)
>> that core code includes vendor driver headers. Maybe we could use
>> a new PHY driver flag. Approaches I could think of:
>>
>> Approach 1:
>> Add a PHY driver flag to state: PHY is not c45-access-safe
>> Then c45 scanning would be omitted if at least one c22 PHY
>> with this flag was found.
>>
>> Approach 2:
>> Add a PHY driver flag to state: PHY is c45-access-safe
>> Then c45 scanning would only be done if all found c22 devices
>>
>> Not sure which options have been discussed before. Any feedback
>> welcome.
> 
> I had a similar idea and IIRC Andrew said this would be a layering
> violation. But I can't find the thread anymore.
> 
Due to async probing we may have the case that the driver isn't bound
yet. Right. Maybe there are more reasons.

Then, as a compromise, maybe we can replace the OUI checks with a blacklist,
where the entries consist of PHY ID and mask. This would cover the case of
matching all PHY's from a particular vendor, but would also allow to be more
granular.

>> Related: How common are setups where c22 and c45 devices are attached
>> to a single MDIO bus?
> 
> At least we have boards which has c22 and c45 PHYs on one bus. And
> on one board, we even have a Micrel/Microchip PHY on this bus, which
> forces us to use c22-over-c45 for the c45 PHY. I really need to repost my
> c45-over-c22 series, although there was no consensus there unfortunately.
> 
> -michael


