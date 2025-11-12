Return-Path: <netdev+bounces-238033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58FC530D6
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BA95679F6
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF1532C95D;
	Wed, 12 Nov 2025 15:00:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046D34E763;
	Wed, 12 Nov 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959656; cv=none; b=L5ESHQQFHZKA9pmf2Tif7Ebe8fTsxfttNm7tey9z499dnIavHFeN6oW1SxQNqFNHsaPOhJIvJrcTCvDWiMGMJQ5gAuOyjzYVYDrtsY8D9lkPy0mem7NzY4GHwdAHxLwGY+FsxpZeh5XHJJZGKVZRyTvUpcfSzmXs6Vtt98feUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959656; c=relaxed/simple;
	bh=S+PyYYzTuXQCv8RPHj7xGnHIGy7tg7vHYYIK3s3OVDI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOsWXkbGdA8rMLSAS33fvj+xAqX5N/I8njDH74XSv540eN+V1jINYvvgULF82NUYLuLYBJpcBl+dydbuz/9S6omBmNvJDxsu6Tmhd0jODQbvtOGRkuuMplzynm9N8xXs2J2ZDKPoIMRxu79UvhoDAKERaahybiQxlAAbMf0MOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d665r6JDVzHnH95;
	Wed, 12 Nov 2025 23:00:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 232C51402CB;
	Wed, 12 Nov 2025 23:00:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 15:00:51 +0000
Date: Wed, 12 Nov 2025 15:00:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v20 03/22] cxl/mem: Introduce a memdev creation
 ->probe() operation
Message-ID: <20251112150050.00000578@huawei.com>
In-Reply-To: <20251110153657.2706192-4-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-4-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 15:36:38 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Allow for a driver to pass a routine to be called in cxl_mem_probe()
> context. This ability mirrors the semantics of faux_device_create() and
> allows for the caller to run CXL-topology-attach dependent logic on behalf
> of the caller.
> 
> This capability is needed for CXL accelerator device drivers that need to
> make decisions about enabling CXL dependent functionality in the device, or
> falling back to PCIe-only operation.
> 
> The probe callback runs after the port topology is successfully attached
> for the given memdev.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Other than possible churn form patch 1 feedback LGTM.
If that churn is large, perhaps drop this tag, if not...

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

