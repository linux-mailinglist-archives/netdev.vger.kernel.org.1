Return-Path: <netdev+bounces-51928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA87FCB45
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C811C20EDB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5B10E7;
	Wed, 29 Nov 2023 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyFGy8xp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B37D19AA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so1721482a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701217542; x=1701822342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=ZyFGy8xp8qD5QI9QwPDb+IhsSZRWf8AzRGUswbI12YDGc1xvIH0g+wLgQbCQ0MgByE
         7JaxlJ6LDrvTwD5v2u1BaaPpBH5R5YUNgb5xQN5Swj0XVMeLoAtP4ZQrlwUAhmY6b1f4
         lo4P74/huqLxXg4rQSkXW1y86RBYbZxCN4heVivo9RjTVn5xV88cmdZGNrBjexsDtvSV
         5HnfHukhNDWtzilONZrFm5fU8R7ZF8dU9NcWUXLUD8PtyHJZZPAj804uzq7F30DAe528
         xZNvGBU8xFyPrK3MZMejmdtbek7u0XA2xivLK10lXoEkODunFDDID+jqCIfmSYQFelmQ
         DpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217542; x=1701822342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=VPhDWx6gKai6NJyMKPEw8CC3axd0jjpG5hw58MXruS4VqXKICAvP6Iez7Yh7dM8cQ0
         Dk1yNGMGWNfBP4o48JQY4gfKmAZu1C63nCe+lk9UPL0nPtM83uncZzdzv7reXfcMhlOb
         dzBNAFvJBwYz8Lbhip0bwCL5CUh7dn3KRooS5RQv95krS6ckENV5t592Hosn/98Oe+xS
         fIieOjU6x42pwkUDFhUkocO9L4JultWRnGFJ9MJqZwyVaQS/Eg4SXaPJJe06EwH6BKHr
         qv+Ody3B1bdtletZfU4ayfOw75lN+vHE+FNUbxnGmsLUige9pn/5QNyJ5SAiHNzYWFXc
         g+rA==
X-Gm-Message-State: AOJu0YwNbn8IbsSQLpKF+te+8gLkVVVg9scjnlBuEJxL9AgdC3WmwGOP
	G9YAYHJ7p4EKD8rAOGcx//YYOGViDUjDsKeqmDQMwQ==
X-Google-Smtp-Source: AGHT+IFhvJD8pcFDSUkXj7rCXo1krioxrjZU+Fh9ydxhF7LIckb5ecLVgf1lGuB42STpvzRSm1nEjeoSzXAsfJKhmOQ=
X-Received: by 2002:a17:906:1091:b0:a0c:c09f:65fe with SMTP id
 u17-20020a170906109100b00a0cc09f65femr7312731eju.38.1701217542589; Tue, 28
 Nov 2023 16:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com> <20231128235214.GD1312390@ziepe.ca>
In-Reply-To: <20231128235214.GD1312390@ziepe.ca>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 28 Nov 2023 16:25:03 -0800
Message-ID: <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU memory observability
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org, 
	alex.williamson@redhat.com, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jasowang@redhat.com, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, kevin.tian@intel.com, 
	krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 3:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 03:03:30PM -0800, Yosry Ahmed wrote:
> > > Yes, another counter for KVM could be added. On the other hand KVM
> > > only can be computed by subtracting one from another as there are onl=
y
> > > two types of secondary page tables, KVM and IOMMU:
> > >
> > > /sys/devices/system/node/node0/meminfo
> > > Node 0 SecPageTables:    422204 kB
> > >
> > >  /sys/devices/system/node/nodeN/vmstat
> > > nr_iommu_pages 105555
> > >
> > > KVM only =3D SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024
> > >
> >
> > Right, but as I mention above, if userspace starts depending on this
> > equation, we won't be able to add any more classes of "secondary" page
> > tables to SecPageTables. I'd like to avoid that if possible. We can do
> > the subtraction in the kernel.
>
> What Sean had suggested was that SecPageTables was always intended to
> account all the non-primary mmu memory used by page tables. If this is
> the case we shouldn't be trying to break it apart into finer
> counters. These are big picture counters, not detailed allocation by
> owner counters.

Right, I agree with that, but if SecPageTables includes page tables
from multiple sources, and it is observed to be suspiciously high, the
logical next step is to try to find the culprit, right?

>
> Jason

