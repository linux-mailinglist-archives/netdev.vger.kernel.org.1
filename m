Return-Path: <netdev+bounces-38363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A47BA92E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E9483281E9C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93A38DFE;
	Thu,  5 Oct 2023 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq7F6iyF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD53FB24
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:32:42 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22528DB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:32:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f8a093so11870495e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696530759; x=1697135559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw4mbkBXk6I24ntStZDyOzAB2TyDaWeJvj0gy/SZ6+g=;
        b=aq7F6iyFkMYmfGK8EBJhSNP2HDXKeLKxPFg5cnnIVAZQ9M0g2q+ZOixkdqkSXiU88o
         iyKB8TyErqQdM1Inw0wEZccPcV0alwKiSTtoYR4HUzK8p7+qD9yYjsCAP1CyWS9Ge8VI
         cR3Fxja0yWpAMDCi8Y689eWVD7iML59o9CP/iDl2pJ41YboqtQOH9oeinebUPYT6A0yM
         eIEejG0TyR96Xesiw3nA2aHcTGWQaIB3tibnk6P3hRtPI4OWZVNbfrJ3dPsROAXlUu5c
         8P+mBNZNN+uWDUadRqzJCnh8EHQEsSe8A3gQ/DtDnxuV5ERsTV6hlXGHyD9Pb0cNOYsF
         ruRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530759; x=1697135559;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lw4mbkBXk6I24ntStZDyOzAB2TyDaWeJvj0gy/SZ6+g=;
        b=nR1h2fzJ9MvNXsIzC6LtR41EVtdWwWHW0LK46hlOfyFo1JiP/3obndHJO2OAbjiqHG
         BBipK8dXNUyVLVFBjISCHQssokK192zOjKIlu3Gybc1sVZmNDEaPkg7bUBLk1OWYqaCZ
         Wre4blGYZJX1HoRRP4b/xe+RzY/QF9fXbNAD+yanxCoyIOvxd51IXxPHpx3ksRnpjYM1
         dl/LaGOA+9ZBitc1uilcvJs8o5m8dWiZc+6IhX9bDzvo8AJx0bZCNMN4SO3eQbWziSCi
         t6VUi5wUTaPdsEEHttVjUYXD2f8Ul2p/uKZjtrtyGmB4EiaNfHzSRNJ1o5dAhdmniaPd
         DOqQ==
X-Gm-Message-State: AOJu0Yy7aWXkov9XdUJyDvypMZStS01um6UBj5RO0LxZz8723RB/mo9C
	+CCbx1RhTApEj7YpH0PqnYg=
X-Google-Smtp-Source: AGHT+IHYuKg1H4bfiNMO40dRSLSKjhZqGhIh5iG3PLVHfgmSDX49RrPPx8Kj6U5g3tc1Ya/g3Ip5TQ==
X-Received: by 2002:a7b:c40a:0:b0:401:23fc:1f92 with SMTP id k10-20020a7bc40a000000b0040123fc1f92mr5737936wmi.25.1696530759172;
        Thu, 05 Oct 2023 11:32:39 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b004060f0a0fdbsm4333824wmi.41.2023.10.05.11.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:32:38 -0700 (PDT)
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
 <20231004160007.095b55fc@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <aba1d133-b10b-5931-bde1-1c24ea3cc536@gmail.com>
Date: Thu, 5 Oct 2023 19:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231004160007.095b55fc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/10/2023 00:00, Jakub Kicinski wrote:
> On Wed, 27 Sep 2023 19:13:33 +0100 edward.cree@amd.com wrote:
>> +	struct ethtool_rxfh_context *ctx;
>> +	unsigned long context;
>> +
>> +	if (dev->ethtool_ops->set_rxfh_context)
> 
> Can there be contexts if there's no callback to create them?

I don't believe so.  But maybe making that load-bearing isn't great...

> Perhaps you need this for later patches but would be good to
> mention "why" in the commit message.

Well, the loop below tries to call ->set_rxfh_context, which wouldn't
 go too well if there's no callback.  But I guess the code makes more
 sense to read if this just guards the actual call and not the kfree.

-ed

>> +		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
>> +			u32 *indir = ethtool_rxfh_context_indir(ctx);
>> +			u8 *key = ethtool_rxfh_context_key(ctx);
>> +			u32 concast = context;
>> +
>> +			xa_erase(&dev->ethtool->rss_ctx, context);
>> +			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
>> +							   ctx->hfunc, &concast,
>> +							   true);
>> +			kfree(ctx);
>> +		}


