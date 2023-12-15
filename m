Return-Path: <netdev+bounces-57962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2118814983
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7231F23689
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F52DF98;
	Fri, 15 Dec 2023 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPQlok4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF82DF68
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so914904a12.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 05:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702647723; x=1703252523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWyY+1ZRwB7JSCluGmdigCtNxrtlYQpVrbJS1gPGz5w=;
        b=hPQlok4wox0ztFwbg3KjtCPhaieD9PRio3Rh8OeuTgCqswhwC/48FBKWwGz2Q3+4C+
         pmt3L1DO+gP66p6X2lpx+B8vXW2v2wf+2R0kFdgDRJfDV8j4z74tSxWH9yOfNW5S5UnP
         7FMxZGeOmgdtcW59/TB56uza38Q+21xcw9AmJuYXOwAltLAAAp2dqqLkQQrCtLo1hpL1
         hHjJlV++eGDLWyLKftDoSR7MjBcgorPnZwtXcrBV4IFI9uNkVDIcJ62OkPsti+ifsUXL
         UcPl3G4vLsvah3mIVVWW+4LS0qCaU8SbIcVXYn3dal4+n8X+ar3IPYzpWkXVZzcu3Qqa
         rsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702647723; x=1703252523;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWyY+1ZRwB7JSCluGmdigCtNxrtlYQpVrbJS1gPGz5w=;
        b=KGEU09lq0ODOa5EZ8KbyOkDp4RUA1odmyM3iMmhDOV+4zlCu8vCMZKmtu8Fmvc0dAH
         nvDYY3z4crjR1QbZx2Q97DP+JeLarz/BVZ3W4fu5LQ+sOD087FEo3SZOhvnrDCtVpmcp
         EPbaZiiVxItr/P/0T48wB+IC+VtLmibyN85aAFYiwubB4uIKng6ojxHvTtV9gGHqqNY1
         i0MVajZXwh3hk5F3ncJ1f0KUYmT9Pz9qd6+SNnlCfkGgBbLOxXpfaRxwCufujdB9X/vD
         9xR+7/syELD/zEHo84oheJKdCY29ocw38PYAZso9fpLi7Li6W2OfZ/Fy6y8Qr+6h0ohK
         GD5Q==
X-Gm-Message-State: AOJu0Yxe9GnetiAkCUU9L1pBTb55E/0wgQOKj1K0awU7MXoDeCRJVMXj
	t1DKzegtnt+6ltlIfu4PVq8=
X-Google-Smtp-Source: AGHT+IF25RzXmMk4vfMp7QaNzOQ98zw63IElqtHzdXCgyMKhef498DDQK2jhu9O5AH8nenEjjEm11w==
X-Received: by 2002:a17:907:7d8c:b0:a1d:58ff:df2b with SMTP id oz12-20020a1709077d8c00b00a1d58ffdf2bmr7117987ejc.17.1702647722883;
        Fri, 15 Dec 2023 05:42:02 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4af:da00:753e:3071:8b26:92a4? (dynamic-2a01-0c23-c4af-da00-753e-3071-8b26-92a4.c23.pool.telefonica.de. [2a01:c23:c4af:da00:753e:3071:8b26:92a4])
        by smtp.googlemail.com with ESMTPSA id cw15-20020a170907160f00b00a1937153bddsm10673996ejd.20.2023.12.15.05.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 05:42:02 -0800 (PST)
Message-ID: <83dc80d3-1c26-405d-a08d-2db4bc318ac8@gmail.com>
Date: Fri, 15 Dec 2023 14:42:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Content-Language: en-US
To: Marc MERLIN <marc@merlins.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
 <a44865f5-3a07-d60a-c333-59c012bfa2fb@intel.com>
 <20231207094021.1419b5d0@kernel.org> <20231211045200.GC24475@merlins.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231211045200.GC24475@merlins.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.12.2023 05:52, Marc MERLIN wrote:
> On Thu, Dec 07, 2023 at 09:40:21AM -0800, Jakub Kicinski wrote:
>> On Thu, 7 Dec 2023 11:16:10 +0100 Przemek Kitszel wrote:
>>> I have let know our igc TL, architect, and anybody that could be
>>> interested via cc: IWL. And I'm happy that this could be done at
>>> relaxed pace thanks to Johannes
>>
>> I think you may be expecting us to take Johannes's patch.
>> It's still on the table, but to make things clear -
>> upstream we prefer to wait for the "real fix", so if we agree
>> that fixing igb/igc is a better way (as Heiner pointed out on previous
>> version PM functions are called by the stack under rtnl elsewhere too,
>> just not while device is open) - we'll wait for that. Especially
>> that I'm 80% I complained about the PM in those drivers in
>> the past and nobody seemed to care. It's a constant source of rtnl
>> deadlocks.
> 
> For whatever it's worth, I want to be clear that all stock kernels
> are 100% unusable on lenovo P17gen2 because of this deadlock and that
> without the temporary patch, my laptop would be usuable.
> It was also a risk of data loss due to repeated deadlocks and unclean
> shutdowns.
> 
Why don't you simply disable runtime pm for the affected device as a
workaround? This can be done via sysfs.

> I cannot say what the correct fix is, but I am definitely hoping you
> will accept some solution for the next stable kernel.
> 
> Thank you
> Marc


