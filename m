Return-Path: <netdev+bounces-62205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDED8261F0
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D84D1F21C4A
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAE101CD;
	Sat,  6 Jan 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5CfVGmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93470101DE
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33761e291c1so292379f8f.0
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704580195; x=1705184995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmW7jzMLAIw85LezifD0O7xh2ljRoYXuf3AHdKctfrY=;
        b=e5CfVGmhXZfsR4NF1o6Bts6fSnkRKBkJD9uMxNQPrIBko9eCG0Ur5UBEE+lELMvSTf
         agT8ELjtcaPeKfp1yU+H/Fm1rzT2Y3tWudWz0CMd4CPNPRl6rzYRSB80TyQLF0VY/JQm
         6kArsUnBnSNL6qSIbKkHR8YJ+BkMpYxcRwN2Lpve15mTeP1nnCjtDjrGjVam+w5uLVxx
         Kr+RLuiVXy1D+n3Uo0Ok9X243qR3xucDrJ3TVX8AKjhTyh6Qji1h6Jxzwpvry3QYV88h
         6KvO51Iqdt1a/X4bcJozMzPYVDdzhnrv5c/EQt0CALzIMelIdJN4fbO8o6bxFZ78VhXA
         SRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704580195; x=1705184995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmW7jzMLAIw85LezifD0O7xh2ljRoYXuf3AHdKctfrY=;
        b=b+molT1PNtfHx2k6jCMzcfgGwPxwufdLSTUPGJJcmpttFlxPhjJlAaILvJiYWF8v3u
         CnJNRioFqyrjQ4r5hKlrXdFwfy+2T4ZEjRVvlfVEg61f8oXoHdOZxeEw7JWvHeuQzcXn
         rWh+QFBZg2k8/kFr8d3+bHMWKm9kLP583dP/d1e9Ys31Ss3DpETAwt0UNNllVgKPqlQb
         WrnfIKaLCOv9o8H5CFwPrM764o+uO9CzeNr3+o2PWnK/rFf6BMuXDRAm/jqeeIZE4VyB
         o0zHGanCQargqLlovMheeM/Uolhyn7/brqitGpUbB5ja4FjwyM3T16M6z5n3gsh3ya6Y
         1DPQ==
X-Gm-Message-State: AOJu0YwLMYCXYBwkvGq6U2DsY4C7A2Dj0udZnqD2792GtvWCzaLy4rzk
	jRnVbKKlOp5R10iLAxd5vZnsd2zUcItukw==
X-Google-Smtp-Source: AGHT+IFy84nhZpdRnVAWcavQ6Ak/pn7hAU7hJBt1JFvCwAXj6VTGP5Sg2Cxq/LSTv8A7E9q6IAYOFQ==
X-Received: by 2002:a1c:7419:0:b0:40b:5e26:2379 with SMTP id p25-20020a1c7419000000b0040b5e262379mr672828wmc.42.1704580194777;
        Sat, 06 Jan 2024 14:29:54 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b0040d8d11bd4esm5890076wmq.36.2024.01.06.14.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 14:29:54 -0800 (PST)
Message-ID: <d807ea60-c963-43cd-9652-95385258f1ad@gmail.com>
Date: Sun, 7 Jan 2024 00:29:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] Introducing OpenVPN Data Channel Offload
Content-Language: en-US
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20240106215740.14770-1-antonio@openvpn.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240106215740.14770-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonio,

On 06.01.2024 23:57, Antonio Quartulli wrote:
> I tend to agree that a unique large patch is harder to review, but
> splitting the code into several paches proved to be quite cumbersome,
> therefore I prefered to not do it. I believe the code can still be
> reviewed file by file, despite in the same patch.

I am happy to know that project is ongoing. But I had stopped the review 
after reading these lines. You need AI to review at once "35 files 
changed, 5914 insertions(+)". Last time I checked, I was human. Sorry.

Or you can see it like this: if submitter does not care, then why anyone 
else should?

> ** KNOWN ISSUE:
> Upon module unloading something is not torn down correctly and sometimes
> new packets hit dangling netdev pointers. This problem did not exist
> when the RTNL API was implemented (before interface handling was moved
> to Netlink). I was hoping to get some feedback from the netdev community
> on anything that may look wrong.

A small hint, if the series is not going to be merged, then it is better 
to mark it as RFC.

--
Sergey

