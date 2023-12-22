Return-Path: <netdev+bounces-59847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385781C3A8
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 04:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859CF1C23A17
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 03:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE016D6F9;
	Fri, 22 Dec 2023 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW28Xmpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74E5390
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fcea0ac1aso7487935ab.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 19:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703217072; x=1703821872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06aQVNDxgv4h6atnxJTE9zGZR62G00VbRyrZMDcVcvo=;
        b=LW28Xmpm9DyGfcPEaa07QkHygBOlpXdp3iPsv3x+iUotSlWLM+AoburMDTJU/c6BGP
         mU/PyslRSu7tqzkzz1gy1T8nHpS2NirR1n2Q6EE37hSnox7yHHGm8xo/1cRjmX5E6mnI
         BI4j3n5I3NmQBUcEspCTmv9id/za2MauOEFavL05P/72TkOCx9tZukHXHta7FVkl90ME
         C90cwZ0sNtw8Nt7Zh79d5nz3nfsvyUOTTjd+D5LyZXU2H9fb4liVhc4ucnCMjByHSymu
         n4RskL7wqRozG2MVbXsvpUsgCTbUuOEoFl1YWW7UCfQprAdi1pqSGTi9GCWosHP+QClr
         MPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703217072; x=1703821872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06aQVNDxgv4h6atnxJTE9zGZR62G00VbRyrZMDcVcvo=;
        b=EaotABs790ws4cx9GAxxBK1jrqTL6smK7QgZS2lxS7HnxVW0/dXVfockfIAHS+j54r
         jpKtcPZZlQuML2O/cmV8qmLat+SAqoxFsFEVLSgNuDstlUf3J1L8KWIh+Ey+OnaPyg8m
         gLXlMiW4riK3iIPx4MQpse4RJxNMRiRoY5093m2zJjtyp/tXoXBYfWaxQv4FgMIZErSn
         lp9w8QdjnuQwjSCSQoHnhmmoaP55NWkA9hUiG6eMc0ID828pV2g0lTLGw95/lRy5QdXq
         vkLiPhSRVNjAVc6VZo58SBA+9sDFk58OKWDF3cZgI2Iw+lFtvAlo401wtnK/iL+jpTLR
         Mq/Q==
X-Gm-Message-State: AOJu0Yxx8qVLs36pzgbg0bOwwkpaJpj5eht4O4IOaftci6KEflMtI8N7
	xaSJ+tEayiwl/xlUQIr+YWI=
X-Google-Smtp-Source: AGHT+IFWC1xb/wkdXEuUtMuglCZBzdnnuzHCzgA5V/p8qrg/Q5FW3z+45V7nAWTOW3uog9Md3/msaw==
X-Received: by 2002:a05:6e02:174c:b0:35f:b84f:ee5a with SMTP id y12-20020a056e02174c00b0035fb84fee5amr799408ill.75.1703217072239;
        Thu, 21 Dec 2023 19:51:12 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:c5db:e362:3bdb:d2c7? ([2601:282:1e82:2350:c5db:e362:3bdb:d2c7])
        by smtp.googlemail.com with ESMTPSA id r12-20020a92ce8c000000b0035fb6c37421sm893286ilo.30.2023.12.21.19.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 19:51:11 -0800 (PST)
Message-ID: <6f24a4f8-fb07-409b-955a-9aad4ab37ca5@gmail.com>
Date: Thu, 21 Dec 2023 20:51:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net/sched: retire tc ipt action
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 stephen@networkplumber.org, fw@strlen.de, pctammela@mojatatu.com,
 victor@mojatatu.com
References: <20231221213105.476630-1-jhs@mojatatu.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231221213105.476630-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/23 2:31 PM, Jamal Hadi Salim wrote:
> In keeping up with my status as a hero who removes code: another one bites the
> dust.
> The tc ipt action was intended to run all netfilter/iptables target.
> Unfortunately it has not benefitted over the years from proper updates when
> netfilter changes, and for that reason it has remained rudimentary.
> Pinging a bunch of people that i was aware were using this indicates that
> removing it wont affect them.
> Retire it to reduce maintenance efforts.
> So Long, ipt, and Thanks for all the Fish.
> 
> Jamal Hadi Salim (2):
>   net/sched: Retire ipt action
>   net/sched: Remove CONFIG_NET_ACT_IPT from default configs
> 

Acked-by: David Ahern <dsahern@kernel.org>



