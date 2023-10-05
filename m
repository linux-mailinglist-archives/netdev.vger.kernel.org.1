Return-Path: <netdev+bounces-38420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248C7BABA6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id AE2CBB2097A
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591063F4B1;
	Thu,  5 Oct 2023 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWjiUAVB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97BD37165
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 20:54:29 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686393
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:54:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so12494545e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696539266; x=1697144066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW7J5Eogx0IMqgws4xItscTcrJtWbUjqxExVZKfWMf0=;
        b=PWjiUAVBXLptu5JReW8ZgRjkK/jtljnqYek0rGC2MXh8VJVyM1ZmDCBSc14MmF7GgS
         F3FyMjUwzJMy0Qrv3Zp2BkRxy66UrZ2hrdLigDF3VI69H7IFBiAfLoEKBTgOoxT1qX0m
         IQcdGRz0grxNAXtAugj45gR2/k/NPH9tGR1gHEBVHUlhEHQCcPUwjMuC902IU8pjZ6pQ
         bD3D4G+NQWwlx1e1szimFy9xkZvnmcPgkyVA0AFBoyK32BjXgZqjl+RNl1O83lpm717h
         QdvY+Thm62l0oUIFFUVmwLXY6aoRAjTERAYISQia2BQ7SwyENCyOqI/Fs1uwW1H2ShE7
         LU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696539266; x=1697144066;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LW7J5Eogx0IMqgws4xItscTcrJtWbUjqxExVZKfWMf0=;
        b=BH5skzY/8NWgMxRbcrfQ6LoXhC/1yGIOn463pzrjr1m0WrASurLYh+8RAHyzfUs/rm
         y4ujlsG0ZGv4BzNMCj5yjWCsqd9z0bJf7IwqEyBl4o/IEp9ZmvWBFA6s7v1teJbx+nGt
         Lqyoe9OHJtMN9bia0kqWBd0WfwFsqe5qzAEOONbCcbAIcizp4LOIsmLBTIYU7Uo8ttQK
         bSid7g7kodoHxSXoF796xH+9JgI6wsnYiBddMA9L36SIaRU48hR/AWhYGxeCk3clJNaS
         7F2EXqTH+ZtnhCT0LQFINnXqI5h3TiqUUadDdFUnCDakBsKRWkNlv7bGgyEXB2KJCepQ
         0DPQ==
X-Gm-Message-State: AOJu0Yz5ekvmgYOEYOgZ7m0D89PHdKmYlOZc8UDEM5LB49l5tMJH9umv
	VDGU+x63ud/BfRQFjf+JJk4=
X-Google-Smtp-Source: AGHT+IFzmybofl+Nu9ZxZo3Ei+XT4bl7BduYGf15yICC5f8ho0ONDYvJSsRXOuzuhs8ECGo6Ls8yeg==
X-Received: by 2002:a05:600c:2a4e:b0:406:3c2b:8639 with SMTP id x14-20020a05600c2a4e00b004063c2b8639mr5474180wme.30.1696539266392;
        Thu, 05 Oct 2023 13:54:26 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b0040531f5c51asm2334403wmj.5.2023.10.05.13.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 13:54:26 -0700 (PDT)
Subject: Re: [PATCH v4 net-next 7/7] sfc: use new rxfh_context API
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, sudheer.mogilappagari@intel.com, jdamato@fastly.com,
 andrew@lunn.ch, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <e4f1a70b649ade2fc03c41b3ee05803b2ee92975.1695838185.git.ecree.xilinx@gmail.com>
 <20231002130101.GG21694@gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b61284b2-8e8e-c867-62fd-0f8090f1eac1@gmail.com>
Date: Thu, 5 Oct 2023 21:54:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231002130101.GG21694@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/10/2023 14:01, Martin Habets wrote:
> On Wed, Sep 27, 2023 at 07:13:38PM +0100, edward.cree@amd.com wrote:
>> From: Edward Cree <ecree.xilinx@gmail.com>
>>
>> The core is now responsible for allocating IDs and a memory region for
>>  us to store our state (struct efx_rss_context_priv), so we no longer
>>  need efx_alloc_rss_context_entry() and friends.
>> Since the contexts are now maintained by the core, use the core's lock
>>  (net_dev->ethtool->rss_lock), rather than our own mutex (efx->rss_lock),
>>  to serialise access against changes; and remove the now-unused
>>  efx->rss_lock from struct efx_nic.
>>
>> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
...
>> +		rc = efx_mcdi_rx_push_rss_context_config(efx, priv, indir, key,
>> +							 false);
>>  		if (rc)
>>  			netif_warn(efx, probe, efx->net_dev,
>> -				   "failed to restore RSS context %u, rc=%d"
>> +				   "failed to restore RSS context %lu, rc=%d"
>>  				   "; RSS filters may fail to be applied\n",
>> -				   ctx->user_id, rc);
>> +				   context, rc);
> 
> If this fails the state in the core is out-of-sync with that in the NIC.
> Should we remove the RSS context from efx->net_dev->ethtool->rss_ctx, or do
> we expect admins to do that manually?
> 
> Martin

I definitely think it's a bad idea to have drivers removing things
 from the array behind the kernel's back.  Besides, I think it ought
 to keep the configuration the user asked for, so that if they fix
 something and then trigger another MC reboot the original config
 will get reapplied.
Possibly if we go with Jakub's suggestion of a replay mechanism
 then the core can react to failure returns from the reoffload call,
 either by removing the context from the array or by setting some
 kind of 'broken' flag that can be reported to userspace in dumps.

-ed

