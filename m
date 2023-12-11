Return-Path: <netdev+bounces-56124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635180DEA9
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203A3281793
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1353E13;
	Mon, 11 Dec 2023 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9skzAMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82628C7
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:55:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28abd1ecb85so15793a91.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335343; x=1702940143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpCO8M8u7JTPy3NA5O/1bcwGhDv/cEsX9d26pg1wuvU=;
        b=S9skzAMDN2DoO2FusT9qT/UDDwRIzUv/mWl/eI4qHyvo/EdovOEz09rWbXKaR+clC0
         /d3w8ulpl4Sp+U6FR8alWI8GkKfo1EsqVH2D4Z39qsOB6vQNgpRuFu1/zadIFS2eaGRZ
         vJzIRkLcdFMZ6U7GU2GMWDa0puRDTeC0PwAPPENaF0Grn6f51/6PGom9wpHcng9yEbTM
         XK1eKE4WBQIRtZs4NWkGrD5CD00Zb6W6nw78UvWEOzApL9MJ75qKTuPf9uU4xRmJpokp
         ygGZfp8O4PMsDrdiZVrtN35QTpj6HcmMsbHnSMo5Zv4wGpLAiDtQhiPPpl4UHgdYAswO
         xWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335343; x=1702940143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpCO8M8u7JTPy3NA5O/1bcwGhDv/cEsX9d26pg1wuvU=;
        b=aPMd2zusJGWOzuyTv8zHO1CLWPc0Be+5m2+fYxNsJ2XZVP/aio3hUt4Qd/2kWltmhB
         fctEkCLnuT6ne1YSQUXHl8aJ5e7QMZCEYzMOVNwNIaMr7extt6Zyi9b8p/LyMyLglC2B
         4YyhsALPNnArqhx2Kx5fM6c/8+JQ55NbDWnf821V/VsFBq4pVIOwlP1b7hpg86INThfT
         Cp2oI/fosKFdThZA3RrdgDhHqNMQq3yHCXJvKnnKNzzZ/5yzQtrQgm/dm3YD8dt6ypqS
         Lj6FcS0K8DVWtydzXFd6q2WIJeJemFDQfYyayLGQPZNmNsIVz1D/IspKKUotIO5ldhgV
         oSMA==
X-Gm-Message-State: AOJu0Yz1ldDxaTn2IQ+kXEjvrruLqcehePDjIU+iwA9shX3NsZcw29rI
	Y+UPbfKkBaT2w8a0LsmkWCE=
X-Google-Smtp-Source: AGHT+IHVPMUQznw1/8pblBDzxSLVsYMCw8JciMtghrzjCPyuBudDwJ+t2BRtoKfCoyj1FKRDzNeGGw==
X-Received: by 2002:a17:90b:b14:b0:286:c399:7c16 with SMTP id bf20-20020a17090b0b1400b00286c3997c16mr2404345pjb.44.1702335342921;
        Mon, 11 Dec 2023 14:55:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id qj12-20020a17090b28cc00b0028672a85808sm7594587pjb.35.2023.12.11.14.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 14:55:42 -0800 (PST)
Message-ID: <2c05c48c-eb86-429b-8496-a06b37f851a2@gmail.com>
Date: Mon, 11 Dec 2023 14:55:40 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/8] net: dsa: mv88e6xxx: Fix
 mv88e6352_serdes_get_stats error path
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-4-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211223346.2497157-4-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 14:33, Tobias Waldekranz wrote:
> mv88e6xxx_get_stats, which collects stats from various sources,
> expects all callees to return the number of stats read. If an error
> occurs, 0 should be returned.
> 
> Prevent future mishaps of this kind by updating the return type to
> reflect this contract.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


