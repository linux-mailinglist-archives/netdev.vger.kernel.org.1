Return-Path: <netdev+bounces-298514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VVwhFT7BK2qfEQQAu9opvQ
	(envelope-from <netdev+bounces-298514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:20:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16F677BF6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=LDrccjJz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298514-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298514-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C502730EC301
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C63379EC6;
	Fri, 12 Jun 2026 08:15:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83A379EE7
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:15:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252120; cv=none; b=G5+8NFVDEigtpVaZQG7elqx5+nxMSZfDZDt8TYXuZ3S9UK15ko3xOcxqRE4BbcsZ64NfdHkXynPwu3B9Uj6prJ+Xh1swNYR5LK2N8VeeelnMJ757ZUiSPAlODpCwK2JjnF8cdt1/27OIpLh3FUdOkzXAfCnSp/PLAWL4vdQbApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252120; c=relaxed/simple;
	bh=KTBSehNAM+YH6mkgwJXeUNubdB8Sv2SPE7m3diqW5IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mbn+pgnrd9PUHcI+EsC4YUDWVbG4kgUyUpVZ5T1r3kSF8uhFM0jTbV5pQqLGnGhND/j+JgsBn3BLoc6Ga2FHinJmCtRqdD2K/gNus6Ht5KUbaPsksZxq3pEnLrUkBJbnk232YQiYslrNjWBDE650Rngq2xKQ2XmLUmjV6Gj6R9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LDrccjJz; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so4958945e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781252117; x=1781856917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qJjmoQctO1wLtQiF3Iz4QtlKz4itv5MzE1hKs6AxBk=;
        b=LDrccjJzAdYJOHbj1TN3r1FrMl6AfLdrQpV9w7+xRYLlYSsuv/cun5Cjt3E3iuxzWh
         apbHPkBE7O1QOZkZzEW9uNn7U6U9VnljXU4m/FBFhvmG0MJpjk96eFUyBxqw7p/yI1cj
         pVkYJ8szKIcyjP1diEj/9qJSnjp2jRx9njmGn1EYklgbhLQKfFzbJVRe0Bovcv7Oz+KU
         hPp1dBUwewsIoWbnt6T2eGb0oRkrSvUwH5ZZBFi6HDntoUvr70iwEzJyJu6rI5U4BCZR
         a1GLf5b9Mg9eRU+tTuPUoM2MztlGvOwjQhL0k0Q0UdWPstkmpYkG3JPP8YqUFKD6PrT1
         33Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252117; x=1781856917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qJjmoQctO1wLtQiF3Iz4QtlKz4itv5MzE1hKs6AxBk=;
        b=sQR0o3RTH3IxXn72yqHwj8ICJSdwFDzlm/qC/h1rB9pDpJqdIBJ+tNS+74ZHznjVds
         FNy17wlLfeFh7r9mJK86nUvPDvk3Gh7bQ+Yuu5gQAtwfS9dzfXeW9r9BjUSI14EjB3cS
         kyZznXXdYeHfUbjhP4dYR/4drB3MCxEwNcO9czvtll6j9jn7pvL+UGxjxLzJhE3ESdhZ
         UrpezXkxj0UnvoJyAw+7Zoan5tmX1Zt2FeZMwUMCMI0l6X8YL2q+tjhHETOPayzoIlY6
         jD9QHC9Evo73mu3q+DblIOKdDYF1ui+gGym3mJrzPdrMcNe371MtmE6arcnn4HX2ohSE
         Tf3g==
X-Forwarded-Encrypted: i=1; AFNElJ+6WfGmlducCJOXD3nYCBooN5uqy26JsTFbBXsU151ZrriORQ1z3pqa29KxRSM67ZcjUA2N8A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQaUOpsgYo/2ifuvYar3CToo5ju3cCxI8Ru1QcCbSrr7cBfOyG
	8C84ZrLLVIyb4MbAgOn63T6ERQpdGuPdp0OgFqOulZ6WbS8qQkyAL2UWjX3vxWuBH1qVvX4Tabu
	kBa7qbuU=
X-Gm-Gg: Acq92OF9IEh4DzERvGIDYm+POLLmT7DXbCahJq0du1noq9UI2gE6+xGde3Jg8IFpuE/
	Jbb2QPzxiV/jM5zkn+q9aBfFlM9xEW+Rh5JpkLF7MER50xu8bsjz1l1Lk6vs0rPSXcS/u4Wo/eR
	ljQ4XV11hSJvYfwZZrWkbyBvfjC8sUPftEjJm9x5/+CIDZrS/E84TlCW2y9nM7hx0qJNjPQ8wc9
	JH+8Pq05KTlB47Ql7cGY+BqekLqGA8I6/txJmEgndeZBkhUBHDHgWCTDNVGhyVWefztRM7uH4Vt
	DeZK9m2bXDy01B/tlASzqgABuDgFBluVBVPIQMny2Ug3ykCsNhZsfG5El4SUufqLVCDDuzA0EKb
	/x1wm5oFAXllJykwf/zetMNPQGej5c+2Wgxug1K/yUYkWgSKqnbtrP33NUl+D46lA+fsC76ZouW
	5X+cBXId6P1bdG0/uCROt/tn4viJfQ5YIB2KbZxmgiu2BGA1gdIlqY+Q==
X-Received: by 2002:a05:600c:4fc5:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-490ec3388c8mr21577205e9.0.1781252116870;
        Fri, 12 Jun 2026 01:15:16 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d046d5sm126611675e9.13.2026.06.12.01.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 01:15:16 -0700 (PDT)
Message-ID: <2574c7ca-cfdb-4346-88c7-9f44492b70b5@blackwall.org>
Date: Fri, 12 Jun 2026 11:15:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/5] bridge: use atomic ops to read/change
 p->flags in br_netlink.c
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260611203453.3067462-1-edumazet@google.com>
 <20260611203453.3067462-3-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260611203453.3067462-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,blackwall.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE16F677BF6

On 11/06/2026 23:34, Eric Dumazet wrote:
> Change net/bridge/br_netlink.c to use atomic operations
> to read/change bits in p->flags.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_netlink.c | 91 +++++++++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 40 deletions(-)
> 

LGTM, thanks!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

