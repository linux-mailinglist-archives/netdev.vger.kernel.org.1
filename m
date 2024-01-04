Return-Path: <netdev+bounces-61657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0248247E8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A31C23F93
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664D728DB1;
	Thu,  4 Jan 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="evZtPSu6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6828E02
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d60ad5f0bso8289745e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 10:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704391409; x=1704996209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXGJByCBUD6AaMd3zRVvSFGt/wcE8NLywI52eNUPKvM=;
        b=evZtPSu6F/FdZMv1ZCLi4oguPJtlX6jL9zfDofE52DvrFnlEbya2dbHgbP+1F48OMq
         BDaknzkGabNLUhf0sh1eJaw2h4rOsZF2jsHI0d2lgJbS7onHa39sx0O816tbNh+oEQFr
         Lal8FeBDLEgIqSn/gwwF6f0WUf6rNat/sAzF62FY50zHrf8EnFnShi6k8Au+jcqrrvvy
         TrzNcFT4tPaIYQJ057M2yPR7bGVJ9wEwOMi/0tcLwLu+ymZWpspEoAAhlh8NuZeAFuxB
         Sr4ni5RpsCM0TueD6PA5O9phPmxQqXYT4uwWlTUO3rymvDWR2lxkvfpatrN50lrDdAfi
         8qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391409; x=1704996209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXGJByCBUD6AaMd3zRVvSFGt/wcE8NLywI52eNUPKvM=;
        b=spkyTczrVFh7z13hVKbmiXImsH+5M6A2gFVS87siqLqVt1GgTV9ftFxxPRxoVqznhl
         TGw2Pt1RxdvJdJKnHE8WBHoO5zH6TPrX+DCP4mo6uZDrNYNe9QXkIlzd5dn+LlSpr+sy
         YaJtO4Re2l+ivc+vjAzlt8bsAgjrwSAjLT1qpIcOyNhTAZBbhKpw7RtiWrbJeMzcJ306
         RZX9LSIWg/sj0j01OrL0zBHQxpUAIscoY405UouZzLwBuKwP/osnRLgvMWiFJfqIA6TY
         FvgNSqAlSsADb3e2K4EJNxz1Mx+h97nWJ1zQmJEMU/0a91qLXNVIqYlt0q7DqSG7Y3n2
         XEdQ==
X-Gm-Message-State: AOJu0YxDNtro3id3JfD83lYs0sBBVbWNZP6sd19SlstYatKbuKc3tBM8
	X/ONVqG3n23Sxcx8t3gxt2a4F01oxQJgWQ==
X-Google-Smtp-Source: AGHT+IEkK8fvj/6KrXUCbiF/1IS2mPV0BqAlCoWDu0kWVFSiULbNtYGGk09VgpuSJbAFxi4aPiQ9/A==
X-Received: by 2002:a7b:cb94:0:b0:40c:53c2:d7e1 with SMTP id m20-20020a7bcb94000000b0040c53c2d7e1mr651504wmi.48.1704391409483;
        Thu, 04 Jan 2024 10:03:29 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040d8cd116e4sm6445336wmq.37.2024.01.04.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:03:28 -0800 (PST)
Date: Thu, 4 Jan 2024 19:03:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com,
	victor@mojatatu.com, pctammela@mojatatu.com, idosch@idosch.org,
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZby7xSkQpWHwPOA@nanopsycho>
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <CAM0EoMkDhnm0QPtZEQPbnQtkfW7tTjHdv3fQoXzRXARVdhbc0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkDhnm0QPtZEQPbnQtkfW7tTjHdv3fQoXzRXARVdhbc0A@mail.gmail.com>

Thu, Jan 04, 2024 at 05:10:58PM CET, jhs@mojatatu.com wrote:
>On Thu, Jan 4, 2024 at 7:58 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Inserting the device to block xarray in qdisc_create() is not suitable
>> place to do this. As it requires use of tcf_block() callback, it causes
>> multiple issues. It is called for all qdisc types, which is incorrect.
>>
>> So, instead, move it to more suitable place, which is tcf_block_get_ext()
>> and make sure it is only done for qdiscs that use block infrastructure
>> and also only for blocks which are shared.
>>
>> Symmetrically, alter the cleanup path, move the xarray entry removal
>> into tcf_block_put_ext().
>>
>> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>> Reported-by: Ido Schimmel <idosch@nvidia.com>
>> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
>> Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/
>> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>Did you get a chance to run the tdc tests?

I ran the TC ones we have in the net/forwarding directory.
I didn't manage to run the tdc. Readme didn't help me much.
How do you run the suite?


