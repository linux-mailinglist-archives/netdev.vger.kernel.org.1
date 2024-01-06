Return-Path: <netdev+bounces-62186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAB826153
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 20:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007C21C20E51
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F33DDCF;
	Sat,  6 Jan 2024 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUspDaMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9EE579
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4398266aso679755e9.0
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704570273; x=1705175073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CkvAM+9T+3/bDw8NejN2FDJUe3HtbPAFUn4ysLBAaXQ=;
        b=EUspDaMfMySfA3RwdsDcb0N+/M8nr/wYamK834LlwzLr1xcGXCng1fffZciCLI4TH9
         4aj9cHKnNVCE02v/0DKvGSEAwyZ/jPtRzgyM9DPzWGr0EEb208jWlHOzR7wGaQkaGGdy
         Sr2TXQllrqpWGf9aPxNeLZyieY7Xi0d+wg89XGrYmpGTQCFOtoQcUi0Tad37wpQIB005
         eX+U+hDnZz9V9y9JpUId0JkcnIOhsGDmrqT3FRYaNLwlF2biMAvAOLEU2qBFhHT7YRwQ
         OxXSIdQ2Yv4rphEf3OQ+aTwWGfKXQePa6eMVB9LakeQaQvY2XFQ9pxgBd56E5aM4e0ir
         +Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704570273; x=1705175073;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkvAM+9T+3/bDw8NejN2FDJUe3HtbPAFUn4ysLBAaXQ=;
        b=YGSBFBC97zsCuPETpU2z7EKy4tKDSYZ125bGssRJEabbsUPP8QWr7jqa0phVTLVLBa
         YOSG1lfIoqCqGcO51hxJeFAYA4RYJVjqLPJ9AXaJsmQqTreI0zmvM+Pn/6E3qgfA68QI
         VVjbKgPPbmOzlCFxRrFlgQIgTOFRjNZGYv/B/uQItShSD6BKxby2E+uF9/CCIlB3f7Ky
         3tZJaSnLzolQnD0EgjlKMRWiPtn+X2S9uLPt5fCc9PX3WJ39KIR/LzSN3hu6LaqIeyf8
         T9Ur3jR8e4N1WVf6SNlLaKSUuveH63nUqCU44Dn1fKrcOickPK9xevXueeFEawRNVrgr
         YBIA==
X-Gm-Message-State: AOJu0Yy68xhZK4By/DxT9ovz8FQn7skdp47Cp6smHIcMjwXnoPtjG8tk
	BNi+Xng6P+4lB+zmLK/3WulZon1F75U=
X-Google-Smtp-Source: AGHT+IHBK6kC1PwIdOK9CrErlwueBmVfcXiuiG1KkeHcOlsMxbL2uY5XlrYZoKacByHPXENMeP3l1A==
X-Received: by 2002:a05:600c:3551:b0:40e:3b99:6200 with SMTP id i17-20020a05600c355100b0040e3b996200mr801316wmq.28.1704570272795;
        Sat, 06 Jan 2024 11:44:32 -0800 (PST)
Received: from ?IPV6:2a01:c22:7310:c700:9da3:cda2:7a2c:5dba? (dynamic-2a01-0c22-7310-c700-9da3-cda2-7a2c-5dba.c22.pool.telefonica.de. [2a01:c22:7310:c700:9da3:cda2:7a2c:5dba])
        by smtp.googlemail.com with ESMTPSA id q26-20020a1709060e5a00b00a268b2ed7a9sm2234179eji.184.2024.01.06.11.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 11:44:31 -0800 (PST)
Message-ID: <61d44793-dbe3-4318-be37-847f2c0205c4@gmail.com>
Date: Sat, 6 Jan 2024 20:44:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] ethtool: add support for EEE linkmodes
 beyond bit 32
From: Heiner Kallweit <hkallweit1@gmail.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.01.2024 22:22, Heiner Kallweit wrote:
> So far only 32bit legacy bitmaps are passed to userspace. This makes
> it impossible to manage EEE linkmodes beyond bit 32, e.g. manage EEE
> for 2500BaseT and 5000BaseT. This series adds support for passing
> full linkmode bitmaps between kernel and userspace.
> 
> Fortunately the netlink-based part of ethtool is quite smart and no
> changes are needed in ethtool. However this applies to the netlink
> interface only, the ioctl interface for now remains restricted to
> legacy bitmaps.
> 
> Next step will be adding support for the c45 EEE2 standard registers
> (3.21, 7.62, 7.63) to the genphy_c45 functions dealing with EEE.
> I have a follow-up series for this ready to be submitted.
> 
> Heiner Kallweit (5):
>   ethtool: add struct ethtool_keee and extend struct ethtool_eee
>   ethtool: add basic handling of struct ethtool_keee
>   ethtool: send EEE linkmode bitmaps to userspace
>   net: phy: c45: prepare genphy_c45_ethtool_set_eee for follow-up
>     extension
>   net: phy: c45: extend genphy_c45_ethtool_[set|get]_eee
> 
>  drivers/net/phy/phy-c45.c    | 57 +++++++++++++++++----------
>  include/linux/ethtool.h      | 18 +++++++++
>  include/uapi/linux/ethtool.h |  4 +-
>  net/ethtool/eee.c            | 75 +++++++++++++++++++++++++-----------
>  4 files changed, 109 insertions(+), 45 deletions(-)
> 
This version of the series can be set to "changes requested".
I'll submit a follow-up RFC series as basis for further discussion.

