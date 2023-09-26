Return-Path: <netdev+bounces-36267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E07AEB54
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3EDAC281E12
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BF266D7;
	Tue, 26 Sep 2023 11:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263663AE
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:19:27 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67A1B8
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:19:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405417465aaso74892585e9.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695727160; x=1696331960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blSlydfKxDGQbwIVvTbhiY64+P49XOT7dIrtXFykXEc=;
        b=CkljKGXpoXG+6fsJ/4FiuivjCY+FrBIeEZiqpSa9g3ahZXvjqBvRStWWLV8EjptMYV
         QOCrkEG5lkg8SKbd0z1e2YwSCGD2MFXlsEmu+kX8toegH7nioFSUtcwKRwpP2Rk7lMIg
         JPJUQ7CLVo0CbPpvTaYhKtX0FnGH2DJ4x6FDMMKsSbiMcIKHAcNESUQux+6H2s0QBS1m
         R+KuXQhFQ8UyqtMmTT/A9cOxvvboPR/L6k1QBHsjdD0149Mq/mA8mo2MWlS4HsaoGz++
         D4b+qN/ypD3JO1Yz60EjSjjUFj3u+Km6g7XlZ9Ze09ez8JYZOnX6vOsZr2BNqS7nAxx5
         +Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727160; x=1696331960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blSlydfKxDGQbwIVvTbhiY64+P49XOT7dIrtXFykXEc=;
        b=EbgMs2BUveHio6Spb0wQ1fxIGid1iWEDOkYuXdxl2jkiS5l3n8K1PTbl/HzixHxFzP
         oaZOMj/JKfv0VxtPkNytFA8XPrD8/0UHysQ0KVGTXOVtS7qQcJddImpaa4SzHVfOhof2
         decH33MwEl1B5xgDx1mhbUhMvcD3KbvUKIbJjVRyGulzbR4mrWvROX554QKwXXa8KbLO
         W0AXqA021ZJ1J0NnAlXwGwtuiNSWo30i3jmQDYeRdgTA8LqeDRIvNJs7JIfruK9Oc/jL
         XxNHghdl7Ma6qLOnEFybNcA55KDW3dagj8kI7tOcd4s+ROEdNYW7TLuE3jK0hghHwfsa
         gI4g==
X-Gm-Message-State: AOJu0Ywf96JwTxF1hF3GiGVtuIkT70WjN2gVOGrwVuTpn0rfPap88+Xy
	0UYLNTte0ZlO2N0YRCMSCXuHNYSkl0AWSZStXan/+Q==
X-Google-Smtp-Source: AGHT+IF/PhoSnuwyVXmZzPlZ8hraiQ/1PwaCZsLPDHlnfQl+E1FjIAN+mGK+ua4waYdBbsKJDIEocw==
X-Received: by 2002:a05:600c:230e:b0:3fe:3004:1ffd with SMTP id 14-20020a05600c230e00b003fe30041ffdmr8384203wmo.4.1695727160014;
        Tue, 26 Sep 2023 04:19:20 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:b095:3966:9c75:5de? ([2a02:8011:e80c:0:b095:3966:9c75:5de])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c251200b00401e32b25adsm14870004wma.4.2023.09.26.04.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:19:19 -0700 (PDT)
Message-ID: <7788d9bf-a05b-40b7-ad90-80d15527d072@isovalent.com>
Date: Tue, 26 Sep 2023 12:19:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/8] bpftool: Extend net dump with meta progs
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@kernel.org, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com
References: <20230926055913.9859-1-daniel@iogearbox.net>
 <20230926055913.9859-7-daniel@iogearbox.net>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230926055913.9859-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/09/2023 06:59, Daniel Borkmann wrote:
> Add support to dump BPF programs on meta via bpftool. This includes both
> the BPF link and attach ops programs. Dumped information contain the attach
> location, function entry name, program ID and link ID when applicable.
> 
> Example with tc BPF link:
> 
>   # ./bpftool net
>   xdp:
> 
>   tc:
>   meta1(22) meta/peer tc1 prog_id 43 link_id 12
> 
>   [...]
> 
> Example with json dump:
> 
>   # ./bpftool net --json | jq
>   [
>     {
>       "xdp": [],
>       "tc": [
>         {
>           "devname": "meta1",
>           "ifindex": 18,
>           "kind": "meta/primary",
>           "name": "tc1",
>           "prog_id": 29,
>           "prog_flags": [],
>           "link_id": 8,
>           "link_flags": []
>         }
>       ],
>       "flow_dissector": [],
>       "netfilter": []
>     }
>   ]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!


