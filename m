Return-Path: <netdev+bounces-61165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CCE822C09
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB51C21B6D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D0A18E1B;
	Wed,  3 Jan 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL7WoSlG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774318E16
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336788cb261so9295486f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 03:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704281058; x=1704885858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ngSthQfVpWAykZk4bbBea413rZ+ZbV9IT5gC7/2Z+ss=;
        b=TL7WoSlGDiU+Dsr82IAxTU29DNv9qGCEqMhFUkU3i2BSSsH7PfwzhFNh4i2irDP6At
         Vj5EhU8ztHyaTC9mis6bSkXURsk8CAcuEam7D6tQOQrZmOsgrm1K8AlBe7Mv+FJCD7LP
         i/LQ3YqdxZBhFkPXAYmIgi/6A5xAkwXZFNZAL3ZG7S8/20Bd/RjJBiPc8PNffBtXAzJG
         29o/Pg+oXn1I2sj/FAO4+Fwo7vb1bHeP/msVeYC4yxDNxC4NWftcWMnis44KjpzbPclJ
         xl7/R5L5xEm2r6rdILoTvcxCZIuszVnTTXO4FB/9DqfN9M11SJnSiwVkriqfAD7i3+uM
         uFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704281058; x=1704885858;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngSthQfVpWAykZk4bbBea413rZ+ZbV9IT5gC7/2Z+ss=;
        b=ds5dcEEoxxKs0ni9ghVGzE8E9n6TInlft3AY77owbtWORB9YDFZsLD7ojKOYDR5zVv
         u63pPKf9wlox2CRRfmBrOsjRWiGmkalPApdiLF5EeUlqtaUfUq0eJ4g1O1N6m9k+I08J
         MpiNIAuh+6RyUXmEkbv0mzHIZfiFqzGgS1hKITwS5Leb6znaxTwzqV7AQ2nukqjzuh2T
         D8UhwZGf51/Kkqp9XrTyNhfbd5QVM54COXsniQ0EBpu1Vt0KI+/evjX8RChQ/Q9VJljX
         yHAhTcwIiDdSB3ZvZbxzj3cXe4OavEq1HGHc5StezsWMCInyhoIVnzVCb/64XRL9YEUy
         eCeQ==
X-Gm-Message-State: AOJu0YzyKrBrg4vrMvyoBn4pzJgcmHz8gtMr14NkPLlh0z6MIaYnwTmS
	1JgHt9i9aP4S9wgkCmQEjwk=
X-Google-Smtp-Source: AGHT+IH1Qbrow1QXHxOtiW8M8b0aKXY6MijQ/pZ9D21ZDkKzvFHuj56+JAVj/YzVaJSF42zt8U5kwQ==
X-Received: by 2002:a05:6000:1a45:b0:337:39db:2fd7 with SMTP id t5-20020a0560001a4500b0033739db2fd7mr2804192wry.96.1704281058150;
        Wed, 03 Jan 2024 03:24:18 -0800 (PST)
Received: from ?IPV6:2a01:c22:7399:5700:b8cf:27e9:e910:c205? (dynamic-2a01-0c22-7399-5700-b8cf-27e9-e910-c205.c22.pool.telefonica.de. [2a01:c22:7399:5700:b8cf:27e9:e910:c205])
        by smtp.googlemail.com with ESMTPSA id w11-20020adfcd0b000000b003367e35abd4sm30651812wrm.71.2024.01.03.03.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 03:24:17 -0800 (PST)
Message-ID: <615c97e9-0a43-4ae6-ae61-172fd64971ec@gmail.com>
Date: Wed, 3 Jan 2024 12:24:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org> <ZZU3OaybyLfrAa/0@linux.intel.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZZU3OaybyLfrAa/0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.01.2024 11:30, Stanislaw Gruszka wrote:
> On Wed, Dec 06, 2023 at 08:44:48AM -0800, Jakub Kicinski wrote:
>> On Wed,  6 Dec 2023 11:39:32 +0100 Johannes Berg wrote:
>>> As reported by Marc MERLIN, at least one driver (igc) wants or
>>> needs to acquire the RTNL inside suspend/resume ops, which can
>>> be called from here in ethtool if runtime PM is enabled.
>>>
>>> Allow this by doing runtime PM transitions without the RTNL
>>> held. For the ioctl to have the same operations order, this
>>> required reworking the code to separately check validity and
>>> do the operation. For the netlink code, this now has to do
>>> the runtime_pm_put a bit later.
>>
>> I was really, really hoping that this would serve as a motivation
>> for Intel to sort out the igb/igc implementation. The flow AFAICT
>> is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
>> back down immediately (!?) then it schedules a link check from a work
> 
> It's not like that. pm_runtime_put() in igc_open() does not disable device.
> It calls runtime_idle callback which check if there is link and if is
> not, schedule device suspend in 5 second, otherwise device stays running.
> 
> Work watchdog_task runs periodically and also check for link changes.
> 
>> queue, which opens it again (!?). It's a source of never ending bugs.
> 
> Maybe there are issues there and igc pm runtime implementation needs
> improvements, with lockings or otherwise. Some folks are looking at this. 
> But I think for this particular deadlock problem reverting of below commits
> should be considered:
> 
> bd869245a3dc net: core: try to runtime-resume detached device in __dev_open
> f32a21376573 ethtool: runtime-resume netdev parent before ethtool ioctl ops
> Reverting bd869245a3dc would break existing stuff.

> First, the deadlock should be addressed also in older kernels and
> refactoring is not really backportable fix.
> 
You could simply disable igc runtime pm on older kernel versions
if backporting a proper fix would be too cumbersome.

> Second, I don't think network stack should do any calls to pm_runtime* .

It's not unusual that subsystem core code deals with runtime pm.
E.g. see all the runtime pm calls in drivers/pci/pci.c
IMO it's exactly the purpose of the RPM API to encapsulate the
device-specific (r)pm features.

> This should be fully device driver specific, as this depends on device
> driver implementation of power saving. IMHO if it's desirable to 
> resume disabled device on requests from user space, then
> netif_device_detach() should not be used in runtime suspend.
> 
> Thoughts ?
> 
> Regards
> Stanislaw 
> 


