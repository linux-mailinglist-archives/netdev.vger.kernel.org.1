Return-Path: <netdev+bounces-29580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BCC783DB4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE153281007
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B0946C;
	Tue, 22 Aug 2023 10:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEF8944B
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:13:06 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2333318B
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:12:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so67857001fa.2
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1692699171; x=1693303971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8RcyAztl1AZBIG+BfwDP189kjI6Bbf9VazeGGkkEEk=;
        b=sZuWGFUmvpzhtxnwq/9qV0P/uSzEl5vYX/LnMXvvr8iGr01vs76b1sU3WC92MsM7td
         Vo9xe7UG9pk2CoHVRS8YvZ1tanCy71zk8JNaRYHwYAUSa7EJKobgIHwxNPnLmfWU0ll0
         vCHI/IO1yNTOfKHJTqnzQZjBTTXJAJMOarJIHhOKPjfYE/g+xEccWAn5Wmv+Qj8KbUO7
         1DYpjScYCH08YH5xwAa2nWzkZ1SQ8Mg5wIMWXFkbrR/irtibSo9eJ/9ongDtGTAegOg4
         jOGrJN7D+dk7h3Ewqq0cHJspIU2rjRMtUN6ynJevp8zQQldss/fiVU4l1lRc8snbmPRe
         UTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699171; x=1693303971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8RcyAztl1AZBIG+BfwDP189kjI6Bbf9VazeGGkkEEk=;
        b=JN6MN6FKwa0SNo3s4lDDCMWDshdFnbgay3zL00ef2l6UyXziz6KSK6cx0/EJ6PmHg+
         p8DC2DWafqkJ7gKmPw2yB7pXulE/IDag8OxPzV0kgSKWy/O5UZYNn8EBb+I3yRVUeJ6G
         r65VF/2BBMbp1625VfoZBnTOFwhQXIe/Q0wL6OTp/SPIMgjnvsZppAZQvsKeKA5fOaMB
         LXINDXCwtW/ma1NygfzpJby89AvPY1BttyANNgLBucJhnwnjA0dpzUuISfohpLSvGp4t
         TqdcFJupH0ijYA3xUY6jDKhsew/0zG/Bpe9vucvNor+DwKS1l9JMkb4TYyTL4v3MK+PA
         91bw==
X-Gm-Message-State: AOJu0YxB+ILZVMCgJ7KnuRCzoHjadK0MM86XzqxWa4SyR0gexVcAJZWK
	Tt5ovp8BECAMdP5OhvFpHZ2aMWLxSfkYK50js93Wbw==
X-Google-Smtp-Source: AGHT+IFvk73NXhW8VjYOzTLadCCa6mXwtqKfejqTz5eBFRnBvvnZn4jgYCoqVXUCd3HaAbA5KmySwQ==
X-Received: by 2002:a2e:944a:0:b0:2b9:f0b4:eaa1 with SMTP id o10-20020a2e944a000000b002b9f0b4eaa1mr5540238ljh.16.1692699171204;
        Tue, 22 Aug 2023 03:12:51 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906d10700b00992d122af63sm7946656ejz.89.2023.08.22.03.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 03:12:51 -0700 (PDT)
Message-ID: <6cf46180-689d-d6bd-ff39-4c20ff2bf9e4@blackwall.org>
Date: Tue, 22 Aug 2023 13:12:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next] vxlan: vnifilter: Use GFP_KERNEL instead of
 GFP_ATOMIC
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, mlxsw@nvidia.com
References: <20230821141923.1889776-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230821141923.1889776-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/23 17:19, Ido Schimmel wrote:
> The function is not called from an atomic context so use GFP_KERNEL
> instead of GFP_ATOMIC. The allocation of the per-CPU stats is already
> performed with GFP_KERNEL.
> 
> Tested using test_vxlan_vnifiltering.sh with CONFIG_DEBUG_ATOMIC_SLEEP.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index c3ff30ab782e..9c59d0bf8c3d 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -696,7 +696,7 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
>   {
>   	struct vxlan_vni_node *vninode;
>   
> -	vninode = kzalloc(sizeof(*vninode), GFP_ATOMIC);
> +	vninode = kzalloc(sizeof(*vninode), GFP_KERNEL);
>   	if (!vninode)
>   		return NULL;
>   	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


