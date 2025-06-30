Return-Path: <netdev+bounces-202558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4181AEE42E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE42716496D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF68528C5C6;
	Mon, 30 Jun 2025 16:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152218FDBE;
	Mon, 30 Jun 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300412; cv=none; b=feqdUnyzKeok9uYhTkCb44/lGhgAdwfoGkpeku4fhq+0d5L9lvVxoS88yZE1lLWJVL9EWyhYsHsMZhfv5j04Q/9+dXqRm8knqD4zzUhaMVRUV9fhSHi7pqlvMsN/3qreWVdeMZLIV8h1zvRSeWsZRZ1uLsiUYBXRDWw50LRNMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300412; c=relaxed/simple;
	bh=h2O33nuwtjpFHWEmgnMS0S2M8/JUawHb8t9kEuIlsGU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZuvtM99EtTuf8NmlwmtszqTLsEZBchIQnk4tfMcQJnqFMx7GGVoZnTDzhnrUCc6Lpo2opt8ROfItj7eS0d7zX7lGJKeGVD5/jzD+3cOlJDEQnPhlC7Ihz0qo5CDsWSR86sHaiz2SxubPRT4ux0YVW1asZpOWMWP4Fhmm/NhkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWBFb19H6z6L4sx;
	Tue,  1 Jul 2025 00:19:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F1711402FC;
	Tue,  1 Jul 2025 00:20:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 18:20:06 +0200
Date: Mon, 30 Jun 2025 17:20:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Message-ID: <20250630172005.0000747c@huawei.com>
In-Reply-To: <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-11-alejandro.lucero-palau@amd.com>
	<30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

Hi Dave,

> > +/*
> > + * Try to get a locked reference on a memdev's CXL port topology
> > + * connection. Be careful to observe when cxl_mem_probe() has deposited
> > + * a probe deferral awaiting the arrival of the CXL root driver.
> > + */
> > +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)  
> 
Just focusing on this part.

> Annotation of __acquires() is needed here to annotate that this function is taking multiple locks and keeping the locks.

Messy because it's a conditional case and on error we never have
a call marked __releases() so sparse may moan.

In theory we have __cond_acquires() but I think the sparse tooling
is still missing for that.

One option is to hike the thing into a header as inline and use __acquire()
in the appropriate places.  Then sparse can see the markings
without problems.

https://lore.kernel.org/all/20250305161652.GA18280@noisy.programming.kicks-ass.net/

has some discussion on fixing the annotation issues around conditional locks
for LLVM but for now I think we are still stuck.

For the original __cond_acquires()
https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/

Linus posted sparse and kernel support but I think only the kernel bit merged
as sparse is currently (I think) unmaintained.

> 
> > +{
> > +	struct cxl_port *endpoint;
> > +	int rc = -ENXIO;
> > +
> > +	device_lock(&cxlmd->dev);  
> > +> +	endpoint = cxlmd->endpoint;  
> > +	if (!endpoint)
> > +		goto err;
> > +
> > +	if (IS_ERR(endpoint)) {
> > +		rc = PTR_ERR(endpoint);
> > +		goto err;
> > +	}
> > +
> > +	device_lock(&endpoint->dev);
> > +	if (!endpoint->dev.driver)> +		goto err_endpoint;
> > +
> > +	return endpoint;
> > +
> > +err_endpoint:
> > +	device_unlock(&endpoint->dev);
> > +err:
> > +	device_unlock(&cxlmd->dev);
> > +	return ERR_PTR(rc);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
> > +
> > +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)  
> 
> And __releases() here to release the lock annotations
> > +{
> > +	device_unlock(&endpoint->dev);
> > +	device_unlock(&cxlmd->dev);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");



