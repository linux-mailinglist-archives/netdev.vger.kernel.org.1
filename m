Return-Path: <netdev+bounces-38421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68457BABB2
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DD9EB1C208FA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E943FB27;
	Thu,  5 Oct 2023 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnLGK1W3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BA134B6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 20:56:52 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393881B4
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:56:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32325534cfaso1331823f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696539408; x=1697144208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DAHDrfXtdyG1iqpwyN2VAU+p3Dn2E1eqHCWxsU4Zlw=;
        b=BnLGK1W3JxsjlZzcPC6z+azEMv+qy/OeOeORhoqwRsuX1/ie+NuZZHkgr1dzaT392b
         hXiwhhDNstvYcvUuWqGq25c0rKioEV/U2hLJlGK+YLhNn9KXBLqgypAjo5ieSFLIC+AD
         y/5bG8rGbLjMnPYPUit4aU6d2IVFYM3+LmFY0Hplg9ebb2c7J+23JXEp9ZCbZVAGh1HL
         xqVaNsbAQyt276BQHpwk4BgLGrfZLsZPcWqJUsjylUOlZqNhYu5Q+JEsV+jDT6QT9O6M
         e6CcG3zuAq7SEW4rNMcOoFyK/fpgBCxymD9RnAn3yncluy7yuJTtpRNl4NDduv8cCfBZ
         sy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696539408; x=1697144208;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DAHDrfXtdyG1iqpwyN2VAU+p3Dn2E1eqHCWxsU4Zlw=;
        b=Z+/QdbrlHRyfgKR18h42CdzvWFXye7Z4QlJ1bOn+wqdddf1sjqUuOPc4iu046m6s1A
         txIQ38rrGlNPd/6iMMfkxIZ8PKqJ/5KFhTr3Eke8ff9jRVBfLB1KBgzBBOGvE842+M+o
         sYNkBQNWjzEqjo+SrQfu7t4EPVmF3wUnfsgCMjUdKJIrT2hvUPycxqBEp+Zq0BTur4cn
         7/s3w5+kwWHo73O0ZfmVHGpX9mj/oTUVSFqkECCYTAClBkYEV4x2rvmG0esN2UL5RC3j
         3KcTV8OOzj6oIzJ+XVpi9McvhttVkS6VnCCaY4+Afiz5riPIcwwYbhdtDvGQaD8xpYpw
         ZGkQ==
X-Gm-Message-State: AOJu0Yw8KaEohkolcX3lnsw5TeaB0jVcHc1BuGopeKCwzw+zVWrr0/8h
	MsTQdrB+c+MaVqs/LdcKLX4=
X-Google-Smtp-Source: AGHT+IGDYzPNgrXWA8qBk5sEVaUSdTaKytdHg6KwqdrpfPj21vEh0KRc/Vc7D/Ih/6dwAimXMsTneg==
X-Received: by 2002:a5d:6548:0:b0:327:e070:15b8 with SMTP id z8-20020a5d6548000000b00327e07015b8mr5912047wrv.41.1696539408560;
        Thu, 05 Oct 2023 13:56:48 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d50cf000000b00323330edbc7sm19537wrt.20.2023.10.05.13.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 13:56:48 -0700 (PDT)
Subject: Re: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
 mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 saeedm@nvidia.com, leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
 <20231004161651.76f686f3@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <70e5af64-b696-dec1-1afd-730559b96bfd@gmail.com>
Date: Thu, 5 Oct 2023 21:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231004161651.76f686f3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/10/2023 00:16, Jakub Kicinski wrote:
> On Wed, 27 Sep 2023 19:13:37 +0100 edward.cree@amd.com wrote:
>> While this is not needed to serialise the ethtool entry points (which
>>  are all under RTNL), drivers may have cause to asynchronously access
>>  dev->ethtool->rss_ctx; taking dev->ethtool->rss_lock allows them to
>>  do this safely without needing to take the RTNL.
> 
> Can we use a replay mechanism, like we do in TC offloads and VxLAN/UDP
> ports? The driver which lost config can ask for the rss contexts to be
> "replayed" and the core will issue a series of ->create calls for all
> existing entries?

I like that idea, yes.  Will try to implement it for v5.
There is a question as to how the core should react if the ->create call
 then fails; see my reply to Martin on #7.

> Regarding the lock itself - can we hide it under ethtool_rss_lock(dev)
> / ethtool_rss_unlock(dev) helpers?

Sure.  If I can't get replay to work then I'll do that.

-ed

