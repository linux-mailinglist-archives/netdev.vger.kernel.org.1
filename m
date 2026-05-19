Return-Path: <netdev+bounces-289654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIf+BkLxDGoGqQUAu9opvQ
	(envelope-from <netdev+bounces-289654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:24:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F2585FE0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E75F30115B0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24E3559CA;
	Tue, 19 May 2026 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8V4NLE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6C26C385
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233062; cv=none; b=kAkcThcBijEVsNQMyHKDatmgbQp90pMWjWzypvkroOyXt+hksPIL28BN6IMQs8BpAymuiWQMudKU4jIkBKDc2gtVZj/SOd5kOzzi4F65zZzdEWTOzkX+Nq6Gjwa9Ep4/5gTS2zMufH8VUh6hwGV///0Xkmo4srjsRJ2a948vpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233062; c=relaxed/simple;
	bh=df9Uz/KDKnR+qMCFB935HcslJOm/LoyN8vQQG6Mpjow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEVtsPFfPpvlZIw/S00Kmc4hSebYtL5lJAHuzBstFB06Lp9SiLP1LhkGkbV8Tqix1/ua0WlmC10yIMtwM00JQjqJYkHx3WQgHNslukYLFi0JzfY4r00PykbeOHLCLAS240BQa3VJijR2G/K2cW0sLbct/4Q1lZboTYMqtQKt93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8V4NLE9; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-366375c4076so1508662a91.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779233061; x=1779837861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlJPo8NWv0XWCKszMuw4IcN4+PqFO7AqbFAgh1yOfbM=;
        b=L8V4NLE91WECrgnIN+FLN0hknpImiZatF6LNCFURwePyWdbdMxunwHU6p6cJSOTKv1
         P+2/qCpRzFH2DwbAyBwQ7ZdCLbE42Kyg4zVmPKYaINAW0Qx08q0WVwtm0C3YPvjB4VKe
         4uDCN9J43WAFXjFalaJhr5U10kZD4FTf7kL9Ebca3yFWS8cxx4J8c43UmemTGYSbz+i4
         z+BVac+Phj9KBxm3tbdcVRvgLZ7cSVkD3KyhvG4y9m+KXngBj7tZxTVRGNW/7dEuc0b9
         hUWDSJsUOTdlSoaTSrneTofid5eyTbtxE0sdDXttn3f8+VxIbKl4RUPmPhc4rnFVf3ev
         Nurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233061; x=1779837861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlJPo8NWv0XWCKszMuw4IcN4+PqFO7AqbFAgh1yOfbM=;
        b=sIbEsfZuP/WFG6xLMIAJwMws3CgCvEtjlk5JqtkGs8d+dOXEYqVsM9l4OQnU0nzo8D
         SYBtMDQFzOzNA1F3pnIPdJ7N/RWmvhCYSpZFMvSRJ9ukiMrodCCBw0v2/n3vH46QlLrZ
         b79kuDIajZkzUEky8CVQEv9U4opw72/bzmyykASmlKqRQJp4DD6kPr4RbfHe93Z0hPs5
         UD1kFKwTgPxaKwaiTvgun9SpZ/27Rez/Y6s9LX6pK0TOaAB/5Hv2TYsoSaAhFM5cAAK3
         gnpPaqm3yyW3I4YwgPqccJc9uRE1JRHWysHzmbqTW/Du4ot1gtdqeptAlyV51wJMHPYX
         NR1Q==
X-Forwarded-Encrypted: i=1; AFNElJ80kA9+Bu5Sn9M1nbcbFcVY/HewnCDz9fLATRGYSml0U1I9wcxIDNHnIU9CYSCnPQIBOGSwjjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOC+Gx9+qxEkVj08RI/dOudDytuMaJ9lQdem2AAZww+2P71lJ
	2dN3lg2wetRe4siF7TLEcS3F8ClSlELsyMxxIEzeMuJKLPShWNxY7Pw7
X-Gm-Gg: Acq92OFZX8lOX/QAwRgkdA/E5jVyYsAb+6yT00WGsa5QK+ZanEVmUzrU4MibNvjdkcy
	9wuZYf32gRFFz2Q6d8Sm9hSPJhUivQNiyAtlnN757EEjO76q/OLqL0ZKVFJRK7CDYMV0Nri/AiO
	v6z/oSJleQx+kwpjKcrCgV6DLva5lxpvDt+d0/wgBxxGfVYLb+9dG4kIAXgim7ytxi/Yrxdrfvi
	9Q1ydhsZ4FzPXYBwiiVHjag3NZ+4FBA1ZKY0nL6PgY4ZCJnpXVgEOUhm8wNN+/3DWhrqBoYP0+m
	yEMxeuUH5zN49H4dzs5UV3YUuXaM1vUPTO/3fuVOHp5Fyc/nv6uXIzG4gRklcqj7yqXO6abPkkS
	qolSpY4ZnKh19ENn9Z8UTwM1cS/+UnbGkLXa73YmY3wXZ7voloyrPWLdjoDFfxkHWGraXxphmBx
	GEG29CVCep0zVE1XJijQJ5gRwIx6M=
X-Received: by 2002:a17:90b:3505:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-36951ca7638mr21358539a91.24.1779233061141;
        Tue, 19 May 2026 16:24:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36970458700sm5912344a91.5.2026.05.19.16.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:24:20 -0700 (PDT)
Date: Tue, 19 May 2026 16:24:20 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zijing yin <yzjaurora@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Qingfang Deng <qingfang.deng@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dev_addr_lists: don't WARN on GFP_ATOMIC
 kmalloc failure in netif_rx_mode_run
Message-ID: <agzt_6t-ibaULJ53@devvm7509.cco0.facebook.com>
References: <20260519095557.3749407-1-yzjaurora@gmail.com>
 <878q9fod8m.fsf@cloudflare.com>
 <d864aff0-d9e9-42c9-87e8-0074dc35e857@gmail.com>
 <ewjfjqocrhwmdoa6mgz3mibtuepp7c3mr5c6zixz26lzfa3g5r@4qfqvbesfv5n>
 <8f25efa5-bd29-49d5-a260-e0ed0ab9ea75@gmail.com>
 <20260519155410.0526f104@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519155410.0526f104@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289654-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,cloudflare.com,fomichev.me,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 7D0F2585FE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/19, Jakub Kicinski wrote:
> On Tue, 19 May 2026 14:26:55 +0200 Zijing yin wrote:
> > Thanks! I will attach it accordingly. 
> 
> Please don't top post. Please wait for Stanislav to chime in.
> From maintainer's perspective it'd really be preferable if the author
> of the code had been given a day or two to fix the bug, rather than
> (forgive me) random people (forgive me) feeding the syzbot report 
> into an LLM.
> 
> My recollection is that we added this WARN to convert the whole thing
> into pre-allocation / GFP_KERNEL if it actually hits on real systems.

I was mainly thinking towards the retry mechanism (which also covers bntx's
BNXT_STATE_L2_FILTER_RETRY), but it looks like pre-allocation is less
controversial :-) Let me sketch something, I think I can keep the same
GFP_ATOMIC in a pre-alloc path and bubble up ENOMEM to the caller..

