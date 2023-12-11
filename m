Return-Path: <netdev+bounces-56132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698BA80DF37
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D031F211C2
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164B56459;
	Mon, 11 Dec 2023 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juO4ZqdM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94519A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:04:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d2e6e14865so23602895ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335854; x=1702940654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfdSqtMjSmTXwOmbTgKK7YtzXOI9q5FfBdrvZbPzBSc=;
        b=juO4ZqdMpOHCcYIIkGwZ3MJ0ogL/A58RXTxTeBednl/bHimkEjkYht0KHbun1zcpU7
         VKIjxRcB45pxXReZQh7e61n48UlIFkxNqLJdJTi/leQmDh+kSFqxog5lOkRZ3qQ0sbea
         rxFnn4khMQfrATLLL7wOs82aBSAI1OOeQ8SA2GmW5M9YmXYsgovzWGVLLU//t0mGPfVc
         3xvfGJRgPB959jf6KPJP698RGPg8lbnkn6KaJtSgs3dKdYdS3x0hfbGkthihG+/LEEO0
         y536PWBucn3JXGWfiJDvVVzREyEKpIAierJoPBf1hyOqfGr3HrFy8yIpp8f1G4G1kIwr
         Hz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335854; x=1702940654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfdSqtMjSmTXwOmbTgKK7YtzXOI9q5FfBdrvZbPzBSc=;
        b=NouT9ExVQo4sRifqm4F4maYUNK0OrdbtdjeyvBEJl5OUaFPQcXT3Rokmvvo78DaQvC
         8SfQdTZxnpBlms0yedwWgVwhoTLj6QLyUQVvZ79PuIO/kpwaZESayOYk8GOH5n7qzrA0
         +YlvPOqGOitHeCFh5ITSUalXFMs1NCyB+G3nUgThWLMiqTB7qxrw6BL++aRGShxopHTo
         FHC/nCbVqlLxmq2d7lQC4xrYvyXAJ7bTYol6UQAHxStyCNbyX9/nc37fw0xqdz3OZ34f
         MP+Qf7DaqeJNfCXrWQhvCOIUK6tWC8jIRkF2OmQdFWtkSKGoixjSL2AD5C6YDodcP8i5
         uVGg==
X-Gm-Message-State: AOJu0Yz979mowlMwsaSFMhuCQ5qAJzrGy4iYYetPUazAqB92Lsy+jlgl
	uRhG66Sog8y7KX77cvvRZFA=
X-Google-Smtp-Source: AGHT+IEPLiZrXcqMhcykqLqUCwSoFCDwQz0apPScVV0EGbE2SYA4HMfESTxHLMLvb/qAVcnKcL947w==
X-Received: by 2002:a05:6a20:1018:b0:18f:479f:98e2 with SMTP id gs24-20020a056a20101800b0018f479f98e2mr2553797pzc.96.1702335854201;
        Mon, 11 Dec 2023 15:04:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n2-20020a170902d2c200b001cfcf3dd317sm7224203plc.61.2023.12.11.15.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 15:04:13 -0800 (PST)
Message-ID: <b5fa4a7c-e5d1-49d3-bbc3-7ad00764ea38@gmail.com>
Date: Mon, 11 Dec 2023 15:04:12 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 7/8] net: dsa: mv88e6xxx: Add "rmon" counter
 group support
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-8-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211223346.2497157-8-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 14:33, Tobias Waldekranz wrote:
> Report the applicable subset of an mv88e6xxx port's counters using
> ethtool's standardized "rmon" counter group.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


