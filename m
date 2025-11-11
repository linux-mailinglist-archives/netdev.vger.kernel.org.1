Return-Path: <netdev+bounces-237636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F36C4E36A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37931883EA4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103A633ADB2;
	Tue, 11 Nov 2025 13:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4131BC82;
	Tue, 11 Nov 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868514; cv=none; b=a4k3HyaMP5JEnleMToCqb2BO7Ngixs8wHS13GhSOXtDRp2Hq7ICaxSdLDwgy4WIMi+tN212PJDTSGsFpvjYsYjpQzvXs9HlQaeh9QmjHtwEpAhHvHtG07pZgSadJkCGjcLdVQu4VOGJyEqeCuCjsYMqNXJtQqjhliUj5l+o1lhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868514; c=relaxed/simple;
	bh=fe1+2gEl7BKxbS6yXkWkrlv07vfe9fxQ6miKsJwM5Qo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuFOMu99FGQstwfetL+d/HDj7fahX6nNOHG14EcBKx7b1yCIOqTjkKB0EGwCcNdt/jQ6yS4c1+V8kTmluf92UERygt2S6/XkaTJSFdqA6unW02OHrOQub5ii3E9IOAeja5Ht3YmVePovMa3esS0b+5Mm/8Bxj0KNnucTNeEgeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5SP60BxwzHnGgr;
	Tue, 11 Nov 2025 21:41:30 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 358701400D9;
	Tue, 11 Nov 2025 21:41:47 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 13:41:46 +0000
Date: Tue, 11 Nov 2025 13:41:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, "Ben Cheatham"
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, "Alison Schofield"
	<alison.schofield@intel.com>
Subject: Re: [PATCH v19 06/22] cxl: Move pci generic code
Message-ID: <20251111134144.0000513a@huawei.com>
In-Reply-To: <15f7fc60-b7e5-44f2-99aa-a73dbc145f59@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-7-alejandro.lucero-palau@amd.com>
	<20251007140113.000028ad@huawei.com>
	<15f7fc60-b7e5-44f2-99aa-a73dbc145f59@amd.com>
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

On Mon, 10 Nov 2025 11:23:53 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 10/7/25 14:01, Jonathan Cameron wrote:
> > On Mon, 6 Oct 2025 11:01:14 +0100
> > alejandro.lucero-palau@amd.com wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> >> meanwhile cxl/pci.c implements the functionality for a Type3 device
> >> initialization.
> >>
> >> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> >> exported and shared with CXL Type2 device initialization.
> >>
> >> Fix cxl mock tests affected by the code move, deleting a function which
> >> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
> >> setup RCH dport component registers from RCRB").
> >>  
> > Trivial but can we pull out that code removal as a separate patch?
> > It's something Dave would probably pick up immediately.  
> 
> 
> The justification for the removal comes from the changes introduced in 
> this patch, so I think it should be fine to keep it as it is now, but if 
> Dave prefers, I will do so. Not going it for v20 though.
Ok. My confusion is this commit message says the function was not being
used since commit ...
Which isn't this patch.  Either that is true and the removal is unrelated
or that description needs a tweak.

Jonathan

