Return-Path: <netdev+bounces-38370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9997BA957
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BF7B1281E3E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD703FB18;
	Thu,  5 Oct 2023 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHMwONA4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A11F28DD7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:43:42 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24790
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:43:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so12588125e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696531419; x=1697136219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykWMw0a/DOEeXpcxVSUbzqU/j+EDBJFcYw7MYKQopYI=;
        b=bHMwONA45fMJQxHp0YGij/gf/Vk2OlZyJxix9M1AmlL3rt0dDezZLjUMDakD1GNDDK
         knBPn5X+Meda8EMqMtjH+gV22Qcknj20G9AgMpeXDm/AbitONaF0rBPiNwZbUm7UVgU4
         tXarzcsYSpAU1Rl/vM667PYvsRPiWr7vPZEEvXDlbBE/Xgz0oAkIB0qm5fpmOWOUSXS+
         hlsYftEDRI5ctEMw/v9KctMlvrTGJErJzxUJaay09Pbebpudt0qmSfDhOl0J2SbGmwp7
         b8Kx8yZxFi1YluRTVRckxgo2PLO8DjNGlxP7pKYyZXfrdhXSHWb7aZXFbMjLlFK73zNK
         gcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531419; x=1697136219;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykWMw0a/DOEeXpcxVSUbzqU/j+EDBJFcYw7MYKQopYI=;
        b=ME1s4sU6Tl0ggmcIgx70xhnkfq1fkLGhr9MOVcfAkGZdFRVUVKhRv9iWOIK2t9ZRBA
         0zIvhXnmgZf0aAx36ItHCMT8oYqhyE4fFd2gawhPQC78GQJBMsvG8Gou48PVfhnDF3Zc
         DlbDSu1ovI6Jx+Id+sIWF13lGzw1rNS2gofp8CH6q1KMYDRCGfNNGuqbNJOkl9cGQiYt
         sfpgYgye4/WpqbnvX3NT21fJqf3NfGqDxbBtrN+sdXWUOA9D8soyZfiT5C1sW4cqT0ok
         t24k8nrEtU4OuJAcWATmqDkZfM1mF45x6UKG2M3SGDnH40k/UWJhxzNQnfNukPRLZDZW
         nY/w==
X-Gm-Message-State: AOJu0YyyaRak9+SxDo0gT2i9WB4JOaIfbZuu3t9Brdc+/Swd8rr8fByu
	vFuUIzPyC3ZQ9hjcE54vb40=
X-Google-Smtp-Source: AGHT+IEl2trV4svlSZkVeFJvDIi5KN+xCOUZf9d8oJxMyR1kGs55i9E7jff5Oh6K2/jNhKaBrQ5AZg==
X-Received: by 2002:a05:600c:299:b0:405:3e92:76db with SMTP id 25-20020a05600c029900b004053e9276dbmr5448664wmk.5.1696531418556;
        Thu, 05 Oct 2023 11:43:38 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm4379636wmk.1.2023.10.05.11.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:43:37 -0700 (PDT)
Subject: Re: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of custom
 RSS contexts to a netdevice
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
 mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 saeedm@nvidia.com, leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
 <20231004161041.027b2d80@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <3e82593a-f083-8061-5ff3-3e04c70afee6@gmail.com>
Date: Thu, 5 Oct 2023 19:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231004161041.027b2d80@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/10/2023 00:10, Jakub Kicinski wrote:
> On Wed, 27 Sep 2023 19:13:33 +0100 edward.cree@amd.com wrote:
>>  /**
>>   * struct ethtool_netdev_state - per-netdevice state for ethtool features
>> + * @rss_ctx:		XArray of custom RSS contexts
>> + * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
> 
> Is this one set by the driver? How would it be set?

I was thinking drivers would just assign this directly in their
 probe routine.

> It'd be good if drivers didn't access ethtool state directly.
> Makes core easier to refactor if the API is constrained.

Would you prefer it as a getter in the ethtool ops?  The core
 would call it every time a new context is being allocated.

(In any case, arguably I shouldn't add it in this patch as it's
 not used until patch #4; I'll fix that in v5 either way.)

