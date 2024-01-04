Return-Path: <netdev+bounces-61621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64A824693
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3A01C23FC4
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3394250F1;
	Thu,  4 Jan 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4/5y99z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693028DD1
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5f402571so7513145e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704386806; x=1704991606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x25dIFSpteFo3vtkg7qikEycSHWLCc+KLJqjb8BRqzg=;
        b=h4/5y99zTW/TciAksQ7cs2cyGTodtwgAFk1G+BbqxGEA6bSLDeaubmhXOQ6wkTgwkF
         N5FdF8WOcOUffqGqoL772Azvpdi92lECFpuciu1MN6g8boQ8DDoN7VczQgFgfUkqXaLF
         GE/bbBdMr1wmpVezRA1dqhhNwXxsHmT4gYggpNFUUxzalxXtehDJhwmhS7OBE6xYdLZY
         HrU/s2ejbjHNb3f3ANX7RUB5sHrUuCAjIJN8UFeCCbSE4xteoo2JfGdLNGJrjVsSmJn6
         EVhmgQR0ffOI3ctmZKMlRkU/fDG8g5pgUFNWpkOe6cu4qux/cOPdMDhEa3M+wky2QMii
         DUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386806; x=1704991606;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x25dIFSpteFo3vtkg7qikEycSHWLCc+KLJqjb8BRqzg=;
        b=PBukcJvNHkP8b+ijfXlCgt8hd5M6se+HNMtf61dlMGFgr2V11FkPiTWyxxZGL0r4Sc
         uV+5/TSnwuLcJ/uQl0KoZeMztglGBpEiuMa+DDRPIjwfTeXc9m5QNrc9R8YKoQIivGrP
         uh0T0fZXRFcOk0S+mmX51Ri9qzZRn2iJQzxICAZOJOW1Ndq7e4GOFSW4mI5Beff2rxfj
         SEl38irhcwUS3no7XZg+bn7nSCsvTHxEIASsxeijprs8SWjlzlsY9oiSVDsm3zSr+seC
         4yc5QYgAN626n/0vESKaRX22iR/b6H9achD1BDDEVWrJyKWG95C+UoW2MPMihp12fDE5
         s/Rg==
X-Gm-Message-State: AOJu0Yyyp8i/vfegLWtJ13Ni7rBFD8RFn2BkEwjeA58zJsoNSeo8lJKG
	haNrBTuOy9/lMVJJ9nO9JIY=
X-Google-Smtp-Source: AGHT+IHWeGi5DjidgEj9IXjmGJVfm9tKD9njWc9grV0EE45bhVlfhxbH3q2/E7aJBe7nq3cMjNvksQ==
X-Received: by 2002:a1c:4b11:0:b0:40d:8818:8ea5 with SMTP id y17-20020a1c4b11000000b0040d88188ea5mr439755wma.122.1704386806504;
        Thu, 04 Jan 2024 08:46:46 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ffe:b000:1d0:e6df:b486:c903? (dynamic-2a01-0c22-6ffe-b000-01d0-e6df-b486-c903.c22.pool.telefonica.de. [2a01:c22:6ffe:b000:1d0:e6df:b486:c903])
        by smtp.googlemail.com with ESMTPSA id u21-20020a05600c139500b0040d7c3d5454sm6289744wmf.3.2024.01.04.08.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:46:46 -0800 (PST)
Message-ID: <57f1dfef-a18a-462c-9f13-938b6b155980@gmail.com>
Date: Thu, 4 Jan 2024 17:46:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] ethtool: add struct ethtool_keee and extend
 struct ethtool_eee
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
 <a044621e-07f3-4387-9573-015f255db895@gmail.com>
 <20240104172708.2db5ddaa@dellmb>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240104172708.2db5ddaa@dellmb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04.01.2024 17:27, Marek Behún wrote:
> On Mon, 1 Jan 2024 22:23:15 +0100
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> + * @is_member_of_keee: struct is member of a struct ethtool_keee
> 
> I don't like how the name of a field in a UAPI structure refers to
> kernel internals.
> 
Actually this new member of struct ethtool_eee is irrelevant to
userspace. It just has to be member of struct ethtool_eee because
that's what we pass to the kernel EEE ethtool callbacks.
OK, in theory we could also pass the new flag as a new member of
struct net_device, but this would be hacky IMO.

> Can we rename it somehow?
> 
I'm open for suggestions.

> Marek

Heiner


