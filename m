Return-Path: <netdev+bounces-59836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F017681C2FA
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 03:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF82287BFC
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A3A41;
	Fri, 22 Dec 2023 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKSxcwlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284A6106
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b7d65d4eecso55815339f.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703210561; x=1703815361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSAVs41n0L8ues18S6WzlAsK1I1VmmPsgD+K/0+rqnM=;
        b=aKSxcwlbla8pJxxCBgHFp7AufwlVidyCwcgeXKLv/diSPJqma4ZGQhte6DjWlEzu5k
         QoQH5rS5Ycx7Hb0SdCdZrZZUz3ulm1v6IKosiMX2YNdVWcV8FtpyUBSNi9BGFS9d07BX
         0x/US9Zf5CH2Px15PK+R5AlAS/EEOhGav9nLZsfD5KGBsSUC5AxIuwTju6RZSypUHVhS
         L951Tlh5IivwYAt8TEMnrr9mV5631fe7+WsEzGjbPcjso7gQ7edZ9ijOyblc9I0rNFQ5
         3Yt/vxlZDVdv1Xyy8E868ZXooxg1YQi8LfQwnFsRTpOMiLKN59w/ORLmB2qit2HngOoQ
         WH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703210561; x=1703815361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSAVs41n0L8ues18S6WzlAsK1I1VmmPsgD+K/0+rqnM=;
        b=caxBK3D9msNoUVaFS4JVy8ZhBJjdb2wRFVE7CNkbvhz99//vkOZ8toAv3+Uvj0Z0pu
         k1rtqE6AXS8uqchUnmdQbjIiampJ7HQer4dQ3edbsA50SIgEScLjggn1FD/rSjyTJkcy
         KhxtuHVZK2x6mgru/9IrNp2vmrRWeFuNmi7nULaqckJB0qvdCpK/vl3asRyDE5NEYaNC
         aJcWzne8MVD8AtWZAE9z1/njq8GQgvHfEuNSVrB455gmPNf6hGo1NWdifq2i1NuC1LU+
         PcpsM8htcZkGDh9OJKBxd3iaZgr+BCJbs0fihQ6dQZBPt4vuIj4NwMY3M5g/H+uZrbrU
         QQFQ==
X-Gm-Message-State: AOJu0YwisZ21xlLw6xRFyXQjt/Z40VuHPSplqdEkvs0TeuR+CF8qT79D
	jWHMAedCtC8wT/sJohn1+Jo=
X-Google-Smtp-Source: AGHT+IHYKFIV6ea8LG1phsV9w8mOYG8vD48hCZe2BpdGnZEWLTsqqBBMYaJLe+uOfrCd2iFkC3gG4Q==
X-Received: by 2002:a05:6602:58:b0:7ba:8316:cad4 with SMTP id z24-20020a056602005800b007ba8316cad4mr762735ioz.37.1703210561615;
        Thu, 21 Dec 2023 18:02:41 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:c5db:e362:3bdb:d2c7? ([2601:282:1e82:2350:c5db:e362:3bdb:d2c7])
        by smtp.googlemail.com with ESMTPSA id g10-20020a056602072a00b007ba963ef375sm288035iox.16.2023.12.21.18.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 18:02:41 -0800 (PST)
Message-ID: <e17d5e1e-acd0-4185-ab9d-3efe2833cdd1@gmail.com>
Date: Thu, 21 Dec 2023 19:02:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/sched: Retire ipt action
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Pedro Tammela <pctammela@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 fw@strlen.de, victor@mojatatu.com
References: <20231221213105.476630-1-jhs@mojatatu.com>
 <20231221213105.476630-2-jhs@mojatatu.com>
 <6aab67d6-d3cc-42f5-8ec5-dbd439d7886f@mojatatu.com>
 <20231221171926.31a88e27@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231221171926.31a88e27@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/23 6:19 PM, Stephen Hemminger wrote:
> 
> Yes, it breaks iproute2 build if tc_ipt.h is removed.

iproute2 header sync would need to remove it. It only breaks apps that
do not import uapi files from the kernel.

