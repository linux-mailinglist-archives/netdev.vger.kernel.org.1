Return-Path: <netdev+bounces-275570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFyHEumU02lWjQcAu9opvQ
	(envelope-from <netdev+bounces-275570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:11:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B913A3104
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F13A300D94D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A67330B0E;
	Mon,  6 Apr 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izZalmHg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B832694F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473894; cv=none; b=C3YZTPOWv4FBy+aNPxMk6QbJOeYDf+/rlR+HPHABlWXBZnYQwluddY9xL/jgTWkc6WglkaMr4IKRAcYpyw5zhyeVB6tvm4VZkBxD9UyxP653G0PEx2/ZYD80cR6bObW4u0inKkaJ2S2KuYy8zD5aNE1RdpxdAYsmlF6D6o8CsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473894; c=relaxed/simple;
	bh=iC+2ohcreA1PvKvOdfrHeMqJv86PUTt82H1u2Ppok9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWbQZSyXNBG3d8McrhLGohczKNxS0GVIASRoFoOmnRJx/qZ8OcGi8Ag2gazu92Lhg45hHuLHzqjheyBPAR8ode1oZOx8zVvSWO6DwhvvvSDuu2Z8k+hrOyUhkV3rQ+3F42+b25aHsO3QjAHo5qWgwv0yrpe+anMK25e5wvw1vcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izZalmHg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cbc593a67aso395717385a.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775473892; x=1776078692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNibLyDGLaj9kHfh+LazW3EKcAg7PW95+I2MB77p0e0=;
        b=izZalmHgpeuXHW42IaNxM3LHgMZhFB5YeAoH0s8d3vkkJiYLAQmcOoercjnp6yEbfC
         aGryvWqP3Owt+8uZGFfClXzOHm6/+XiUQm5aJo19q5BQTcwe52Jst5lC+Mz3CMYip6x7
         A+ERs7Y8m2S1VRoDn9Z4v67UgVqRmIXRldVRdp89gjK1ALsNTwIIpx/YoqmanKlhPpAy
         Ygu5Ag8/NEfh0l20PmmSXUOE5MdAsHhReIyOGNDa8g36MJNRRKt96XIGAlH/1ZFCJpLi
         5IAhZzC5WipIr72WFRgrikyE3WSv8hZn2TgmEdfkzQDkrEaCWH7FcZR/WEPYMjmYMVEM
         UrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473892; x=1776078692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNibLyDGLaj9kHfh+LazW3EKcAg7PW95+I2MB77p0e0=;
        b=Aw5W/qXqzs+lGvHUe2TDhjYjRfLWRDQoEcrNaimJsmSx2Owq7KG2ia+vrqNz9+CZFM
         XlLac5pQKezruksTLcHItJJFtTuDhjZs8oeKESB3lFrU1ckrD9XYGTriLd+5+JQTqG1b
         fYju/zBQ+vr6XDfU7t0B2zS/Yyc8pyoz5wF3tMOIcCl18IgrLM8ppDiuvytBvW8aUS4j
         toDSnBsPNk2CUvnfAHWZQKMx4VARuKEm/pFgpKfCsVIFmLIWidoekierMEgEhz4GWTpP
         sMtJLG+MUT7LLCijS19hSzyaqdJduHYAmDpfnPNxcnjqsa0gwUY+BmwtJuRa9A+6sz6O
         0uDw==
X-Forwarded-Encrypted: i=1; AJvYcCWTg7io021ixcLym2A01KjH25GNFhHprCKKRY6WlffyuWyV4n3QU4DNmtYS/25YpwvPUvIbVqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDw23Rg6FPbeYDXcxvqahUtaUkfDl9WM7ILJD2jr8FuFEeeJEO
	/lb9WrV8ZCsD1HXuE6nG+4ZES3pa0kn4ZAdsJBjq6qP/5S4mhznzdx7O
X-Gm-Gg: AeBDiev4/AkWlw5Z8sc06z5mfnFinb+RIUkKx6j7MlxL6Rb6lREwfBs+RxYVAhg2iqk
	NaPUuOOV5n4JoMq7gIsJ6oTRqw2mnKP6z1Fu8Q6eWaPd4W1UPW2xmatOI0sxN6N1IvlxZwhsAno
	vcAiAzZCks/MCfY6xsp8CQLGw6qIuUv3LdoAQPz0CZ3pOetCHuKaogMKhPQO6FXoTWQaldNzL4L
	lT+6ph3qixaofOucoyS46TtweQ9u3vpmoGGej6+or+ngtrCI/Xvi6iW5FRJeYig4zwb2yLmSXrn
	GtjVaPxi1IY8H2TOPuUdr5SyzmPdB5AEKme2x0Jcd9AKoE01eUribmRnYf1poNc5X56r92XpDyT
	7h+ZEXeaRY+pD3GS4y3VfC0+IlxsIK/b4epqjPsQslkbPXDxtyJQQW5pqOintCqQdpMU03zarA0
	Tq8VlmEfHOv0emlffim4/pxRqnIiUVswB9ehSpCVBSbOWMHkLT+CsdVFSBsIB8ANf7NQSgfXznl
	w2bx7QHH6gnp0vfjrMaD6wtra+RhN0K5chyiw==
X-Received: by 2002:a05:620a:2844:b0:8cd:b71d:b1ca with SMTP id af79cd13be357-8d41ec0ac41mr1696517485a.63.1775473892091;
        Mon, 06 Apr 2026 04:11:32 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:a22c:878f:7c1a:1976? ([2600:4040:93b4:e600:a22c:878f:7c1a:1976])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8740491sm1028685885a.38.2026.04.06.04.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 04:11:31 -0700 (PDT)
Message-ID: <0b4de4de-45d8-4d4f-a15f-87c527b87253@gmail.com>
Date: Mon, 6 Apr 2026 07:11:28 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 1/5] psp: add admin/non-admin version of
 psp_device_get_locked
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
 <20260405055853.3285534-2-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260405055853.3285534-2-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 93B913A3104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/5/26 1:58 AM, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
>
> Introduce 2 versions of psp_device_get_locked:
> 1. psp_device_get_locked_admin(): This version is used for operations
>     that would change the status of the psd, and are currently used for
>     dev-set nad key-rotation.


typo: "and"


> 2. psp_device_get_locked(): This is the non-admin version, which are
>     used for broader user issued operations including: dev-get, rx-assoc,
>     tx-assoc, get-stats.
>
> Following commit will be implementing both of the checks.
>
> Signed-off-by: Wei Wang <weibunny@fb.com>


Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>


