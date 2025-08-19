Return-Path: <netdev+bounces-214970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B5B2C59A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC8824423A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E92EB84D;
	Tue, 19 Aug 2025 13:23:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CA2EB849;
	Tue, 19 Aug 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609797; cv=none; b=rFOB3VBGNGYStLmizGdqtYsklnqNaA7kWn5M8HyAy9JAkmoSPA3ntpJ9B6AUrm0hK+L4ULTySAbXmTR/xO7xXlo1obYroKojdjPjZjmQYbWCTqZbnsseonRvN/bWwlVpjEf01ye9/DUvm94q6nKrrJvUYGafU3EnS1XVXjkRJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609797; c=relaxed/simple;
	bh=g7lVuLOJfzcOyvSwkD9jimT7UWYMuZMkoDnVTcJaP/s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q6Rg3OcGf5g0M6yW/B/cysJS4nqNPobf2bXCahg3SuyJ6hsRGb2tEVIdHkc+q8SAb6sR/30YxCmAlv6vzCGiP1MOKPz+1mdIT5/9/KPdrls5EVliRYEtIa2WpOAT3WuvUQFDVAurVHC2/vF0ErfbNbMERYvgz6xyUY0hbvQjASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-61a8b640e34so545862a12.1;
        Tue, 19 Aug 2025 06:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609794; x=1756214594;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7zT9ArHzRnNEsVSsRp3MyL2KrDTh4G2uNF3hwr3qrY=;
        b=sA4F1Vbk1KVm/dYQNUlFe8TLUFhGE6DkIRPWER1IBidciOXbhlx8qkf0xFjduanKMD
         QIkY+pyqhW3ZvznqKv4vejmGXLzmSQr4Wqz4XPoT8gm2WMmNAokUKtzzRNrDh3YSTmYm
         RxKAsAd3DgZnvNf31J0s0IXVA3ebUDW9KWnbqV7gVr9I+cr2qOeu2RVCXImcnJFZ8nWA
         zAoXAxUTT2oU0+JzuVVN9V5lZWyNfSUQUhVcPgUjffefqckZSw8TS1k9z8L1hRJtY/O6
         8ZNUe994Zfr+9RQvX3lYum8eMxRzAxOkdTVrc0SK1WSjlzXX99S/I8GH8z2ir46CbUQN
         N6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkvySpjPv8g54yI/u3nKqDgeBpkMc4j/bU3j9UiR1Ad21mGBjwxdDfiDSgTvVaDiAW37D0zz4psZjEO50=@vger.kernel.org, AJvYcCW1DMdNjahfGY0m1teVSBRwudAYD4f8NywF4iIPCNyQ8YIYTa2qaSTiKz27T4a4B0i4iI+D8CWf@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6Tp8OuqYBcFa7SDmf+kCVPhxxA0mMgBLUZaxArgkZpyeaQA4
	druvfLz9hG2r7k6ZFXzMNLIspJyp1PJApynnp56EIOhDFilXz260JhB3aOPRjt5b
X-Gm-Gg: ASbGncsL+mGHvxrd4oWFZB88k7M3nfDcQ35We+9jKRMFWZcME0BP/NFdwt2cdgRCNh0
	sb5rXAFV0YJ6N/XrvS66aiZsXKUZzHGd8VADygvE7Z5ztVpXNivUSfLZ++iKAuRz1Do46YrLmXi
	NFBykbbQy7CxczEqWTzwGPwZ/+RFP3m94dWXZ6KtXRwkBL1w99TxAoUJ5EPQlNBTRnG5Xnj8i0H
	rJa8bMqBbU09MPTRPUXnuAgQ6f2pqaUGTSwq7toRlB+iGITxdJNFbjbxE1PPKc99/97SqitgUk2
	A+rctV9VwaMr0UnPEtKKYbaleCxmOUtyQ7zRQaA54TMSrWtJxsPJlgBPU98Rwy/GIzqhZOA6cUz
	EyzGuY6dZxMowjsBqlDZqVv8Gnm6A5H/YFFbATR/UjsgNTf8Ul+S1YIWexI5nXQ==
X-Google-Smtp-Source: AGHT+IEgtjUC6kdtwkIWR2iCtyIehYzwDm+qFKh/hi8sJZc9z2pqbpnTNgotVLNeqnsj0fvN17cOxQ==
X-Received: by 2002:a05:6402:1ec9:b0:615:a529:a988 with SMTP id 4fb4d7f45d1cf-61a7e709a5cmr1980253a12.14.1755609793816;
        Tue, 19 Aug 2025 06:23:13 -0700 (PDT)
Received: from [192.168.88.248] (89-24-35-28.nat.epc.tmcz.cz. [89.24.35.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9b37sm1741773a12.7.2025.08.19.06.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:23:13 -0700 (PDT)
Message-ID: <3b88c0fb-40de-41a4-9831-cb986bb6570e@ovn.org>
Date: Tue, 19 Aug 2025 15:23:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org
Subject: Re: [PATCH] net: openvswitch: Use for_each_cpu() where appropriate
To: Yury Norov <yury.norov@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <20250818172806.189325-1-yury.norov@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250818172806.189325-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 7:28 PM, Yury Norov wrote:
> From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
> 
> Due to legacy reasons, openswitch code opencodes for_each_cpu() to make
> sure that CPU0 is always considered.
> 
> Since commit c4b2bf6b4a35 ("openvswitch: Optimize operations for OvS
> flow_stats."), the corresponding  flow->cpu_used_mask is initialized
> such that CPU0 is explicitly set.
> 
> So, switch the code to using plain for_each_cpu().
> 
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  net/openvswitch/flow.c       | 12 ++++--------
>  net/openvswitch/flow_table.c |  7 +++----
>  2 files changed, 7 insertions(+), 12 deletions(-)
> 
> v1: https://lore.kernel.org/all/20250814195838.388693-1-yury.norov@gmail.com/
> v2:
>  - always include CPU0 (Ilya);

nit: The subject prefix should've been [PATCH net-next v2].

The change itself looks correct to me.  Thanks!

Acked-by: Ilya Maximets <i.maximets@ovn.org>

