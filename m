Return-Path: <netdev+bounces-188689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58EFAAE36A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5887F16B2EF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8EC1DE4F1;
	Wed,  7 May 2025 14:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7E4B1E69;
	Wed,  7 May 2025 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628931; cv=none; b=qLzWasBuSeY9CfA1VZLu+nm2FbXrj0qnf0aoxGs58FUaeZmwiOIIVBzUdx0DaWfk4T3x5T/00+ol/1xbza05e28an8gjEFsSMypMe6VTHYQbBuxQcE23D4OBGBqQ+Zb7+vBkiWd+M5l9N0A0t4M3R2DLDcQS/tWomwM/npMHgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628931; c=relaxed/simple;
	bh=mjvDl+4iMo2A2RrTV+FBsr1v6OYbmDb+1KGiWXSgJ5E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adBGYqlMfzwVPpU/G9KR9DyuHwERIUMIh/0+UNum1bPhiVdjp2TRTsl0tPzfxuq6yuzpAXD4vxsO7o+scppy8cUw0xCCOghP5FggBT7UicA3+UnWAqIPKKf9isxwsu4qA2gfAjrJ0io9VvB+ZVc7amOBzWw4qvfzRxwb4V++/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsydY3rrFz6K9GP;
	Wed,  7 May 2025 22:41:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FEA31402A5;
	Wed,  7 May 2025 22:42:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 May
 2025 16:42:06 +0200
Date: Wed, 7 May 2025 15:42:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v14 02/22] sfc: add cxl support
Message-ID: <20250507154205.00003839@huawei.com>
In-Reply-To: <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
	<20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 22:29:05 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Much as everyone should trust my reviews...

Needs some tags from sfc folk.

Who else needs to tag if the plan is to route this through the CXL tree?
Or are we looking at an infrastructure series through cxl.git
driver next cycle, or immutable branch with infrastructure
going through appropriate net tree and cxl?

Jonathan

