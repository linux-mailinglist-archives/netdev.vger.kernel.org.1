Return-Path: <netdev+bounces-238062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD4FC53992
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 796465A148E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE9311C3F;
	Wed, 12 Nov 2025 16:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B132B985;
	Wed, 12 Nov 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964481; cv=none; b=fvrZjzVa+CicWs+gEMgkeZcZ/9RIG8SObf67/pKSBYM/S9i//n3Kd0mBVl+YXqjCAuBe2fqSmn6otoNW12IbcVfPhZcd+SK0w5fRhVlOmitlrsb1Yl7ySpPxnx5vMaUdQnj1hPIBv7lh2EcGLQsEcVOPAZPWXF4H3sqUqHuIjbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964481; c=relaxed/simple;
	bh=r4qfen/eplAbjJN8RtesoikARs7mno6zmB9J6FD42Qs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXdVinADVuYzekM1Uhvj0qwcnhLIgzmdJCdNsfr5I0iZJQREahhuJiRBZoRv08jRhLbIGHzvtfrc7bqvfJ4vIAdmztS9Yg+eGF5amJq/fhe6Cw3fgQq/vAr1tFf1+HeDQ6yEElzw1topf7rcivplc6WxFEFRjejYCphyKCNwl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d67tM0RpnzJ468k;
	Thu, 13 Nov 2025 00:20:43 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C735C1400FD;
	Thu, 13 Nov 2025 00:21:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 16:21:15 +0000
Date: Wed, 12 Nov 2025 16:21:14 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v20 20/22] sfc: create cxl region
Message-ID: <20251112162114.000019cd@huawei.com>
In-Reply-To: <20251110153657.2706192-21-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
	<20251110153657.2706192-21-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 10 Nov 2025 15:36:55 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range.
> 
> Add a callback for unwinding sfc cxl initialization when the endpoint port
> is destroyed by potential cxl_acpi or cxl_mem modules removal.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Given my v19 feedback was garbage this is fine (I just missed
I'd not tagged this as a result)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



