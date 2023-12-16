Return-Path: <netdev+bounces-58292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E14815BA9
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F321C21AA5
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870C32C62;
	Sat, 16 Dec 2023 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDWbmCsE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7316328D6;
	Sat, 16 Dec 2023 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2339262835so20613466b.3;
        Sat, 16 Dec 2023 12:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702758220; x=1703363020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvDfT9hUlqd//b2qmA2Q0ZygPz1sbEjPpPLswigsGbw=;
        b=VDWbmCsEFgT/qW4KPG9KLZaZD7c3CHuV/lAD4YuuctGgId5Ma9gMfYi1ckvZJX6ykx
         nWEkuR+f96xsWmXSVTCEB2ZqFTep5RWbEq8F90cZJz1mWejaCmIruEnPrUAEEkgKeivV
         iPCmhlTqEkmgm2UUmjdk/hzj/lG69HZ0OGo8wV/vL9vxfnTw0mwDjsSzVUfRo1IuAm98
         ua3JfJDXJiwmik+DX7jKJZiVNeeppq5jS58/yHtdac0x+ycWwcK0F1tESfbb/iIL5A6b
         6u5N3EB5I1TI4g7P/guIXaYuXZwx0UvKg2dcFOnRYNqOKArosC8upc7oSY8iopLTEv9Z
         /80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702758220; x=1703363020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvDfT9hUlqd//b2qmA2Q0ZygPz1sbEjPpPLswigsGbw=;
        b=tzN8/eO0B1BN6zy0ZZcdTauo9WQ60tFjrpTRyReSwu8IZ3SoHK0I1Y5k/NxHOxT1zG
         jk4kuZvFa5h4hXVAeU+slIGgo9BM51azmX9rO1eII2Nve5pM9xwYhOE71iJEQdvhfkog
         hW18MGQBlGHn39+WbAkHjJrY2xYdMG7kqGLkK16RtnC3PpvhaSXyabHv+ZuNfhBQvh/g
         cheR9ysgNmJcnqRt8swY3xLnZHh1C2K+8R6l3cStYWOSR37OLBiD1t/KsZMDWzBp32k+
         bH2AwUCMJEz7RnyUKJ17qymwvORVg6dkYHX3dNLcyFvYxnKrprJRGZskwFWkkaLc16FU
         Te2g==
X-Gm-Message-State: AOJu0YzzwWyTXUcTcztrmcz7ZhnW4S2irq1Krfu5y6CYd4zV9S2qjpU0
	NQB6Tm/Dpm8c7gnGF7VcAmk=
X-Google-Smtp-Source: AGHT+IGv3TjKn9mKLtvthLiz2xswkA4zxxNvNgsA6ZCF80vG1PfJNNksoFMPi2V5JzAzmgUtfGy6BA==
X-Received: by 2002:a17:906:1d7:b0:a23:309b:e0cb with SMTP id 23-20020a17090601d700b00a23309be0cbmr377715ejj.155.1702758219852;
        Sat, 16 Dec 2023 12:23:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1cf3fce937sm12170176ejc.162.2023.12.16.12.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 12:23:39 -0800 (PST)
Message-ID: <cd60b227-df1c-4fea-9554-695261c9d6a9@gmail.com>
Date: Sat, 16 Dec 2023 21:23:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 2/2] Add the Airoha EN8811H PHY driver
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20231216194432.18963-2-ericwouds@gmail.com>
 <20231216194432.18963-3-ericwouds@gmail.com>
 <a0a47222-769b-4aaf-9143-1d7ad3e6ade9@gmail.com>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <a0a47222-769b-4aaf-9143-1d7ad3e6ade9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



> 
> Why don't you use the module_phy_driver() macro?
> 

Thanks for the tip, I missed that in the conversion to recent kernel.

I will.

