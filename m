Return-Path: <netdev+bounces-33532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA079E68C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7461C211A2
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3B1E528;
	Wed, 13 Sep 2023 11:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960A23A0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:22:08 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDD2D79
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:22:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so77899115e9.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694604126; x=1695208926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNY7dLK2sLRjU73RMdAqQQsmbb3nM0f7a9UIK8fJ5wc=;
        b=gJ88OVb2toU01wvtDKk6DGyWTKnN9aq0/3P+r2ZFqjmUnAcK4c3BiEf1WaTHLANtUb
         D21CrlLW6vGD6/CXipatvpUngkWaUNaRa+M/6PnzIWka8IrBgIsHJhZyOzHcuVoirfoN
         des8mi2JUy1AES1c/MNh9SBh7WtLja59/FuMc1qROtwja7IzGCi04H2Ct1JniVlv1XiW
         3E9nTCK7iiYVPgttRIAt0nmHhH0d/D7o23/92c28DTu0CwMKy8bNXC97Nz2Q3SrXVQIz
         UX5epw6ZqOxyi9KyMHoven0pvTO9JZx9hK2CHVSmN2OmUE4iHf+jLL3AggjEMqzCek6v
         Hpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604126; x=1695208926;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNY7dLK2sLRjU73RMdAqQQsmbb3nM0f7a9UIK8fJ5wc=;
        b=IoaPoBkAhp94dLsTUGN0SoraYvycyt+/KmZnoXBjwmdzkyAoJyzSW/sNbHtE5yTrjj
         bQiUDmJSHLXqt8YAeF1RWUHXK7ULGDEK5V9ylXdl9vCVdbis4cg55v4b6AnhR3722Lgy
         G6NkilD0rf/NHZoZNuUtN+95ZY/kPOEQYWnOgCcIeD8kf5COP5Mf30rqnwNC60pAAaB9
         UFTTdc1P0RQRWIhRwh7N6+IzJYJqYeoQWGb3zjt9sn3nTFtZe0so9sI6z3xZI4yUswvm
         9gxV3AEnrZpau5kr8EicL2vRGsNPtoiV6nvvDO7uGLSy1mBSpZgPZuPhKTMy979cNWn0
         VPLA==
X-Gm-Message-State: AOJu0YwDIIwGEYp/UnE2xmrQSKw74uF+HAwXzKa1g+XEvXI5Am1l3R33
	sAJf8f1rXatOWZnCMlLRTxA=
X-Google-Smtp-Source: AGHT+IGePjc+fR2gkLOUOSLvOFcQaaCb9LZsvLpmbY4nUPCHGUaQhhFOjnfOxvOoU49O0DWHMmF58Q==
X-Received: by 2002:a1c:6a14:0:b0:402:f5d8:6de7 with SMTP id f20-20020a1c6a14000000b00402f5d86de7mr1709515wmc.33.1694604125817;
        Wed, 13 Sep 2023 04:22:05 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b00403038d7652sm1742347wmi.39.2023.09.13.04.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:22:05 -0700 (PDT)
Subject: Re: [RFC PATCH v3 net-next 2/7] net: ethtool: attach an IDR of custom
 RSS contexts to a netdevice
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 saeedm@nvidia.com, leon@kernel.org
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <9c71d5168e1ee22b40625eec53a8bb00456d60ed.1694443665.git.ecree.xilinx@gmail.com>
 <ZQCThixvWBoCeT4r@shell.armlinux.org.uk>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b2da6ed4-9475-6e49-709f-db87dcf8c810@gmail.com>
Date: Wed, 13 Sep 2023 12:22:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZQCThixvWBoCeT4r@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 12/09/2023 17:36, Russell King (Oracle) wrote:
> On Tue, Sep 12, 2023 at 03:21:37PM +0100, edward.cree@amd.com wrote:
>> +	struct idr		rss_ctx;
> 
> https://docs.kernel.org/core-api/idr.html
> 
> "The IDR interface is deprecated; please use the XArray instead."

IDR is a wrapper around XArray these days, right?
When I looked into the equivalent to use XArray directly it looked much
 more complicated for flexibility that really isn't needed here.
Is there an explanation you can point me at of why this extremely
 convenient wrapper is deprecated?

-e

