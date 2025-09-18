Return-Path: <netdev+bounces-224379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91384B843CA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ED01890758
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063962FFDC6;
	Thu, 18 Sep 2025 10:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982262D7DF5;
	Thu, 18 Sep 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192922; cv=none; b=cZwyFLheh+8uDX4qwSULZy4HLxrUp0WQWJ/j9XtV0GlbCNRcLnN1TNUNOqn72nMfWN+Y6U/jLAcVLjghBOE0+QyBMtgR3gNn5pAyq8gDTDSjTdjy9jUAHz3qYKWHJRoN1mVALiOwXpYL6aaXCCZbl/LbVPqqUfoVn6FQ5K+WQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192922; c=relaxed/simple;
	bh=Jzf7d4NPLv/m9fmRY8sv81t4C2v9/nH5P3FDHBe2rKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zw8bDwmz2ndazM/NpjIBQ71xw/JTkDX0iaWUOUCQsJ5AgG066HT+zU4MdLA6XK9AShvhprhl8RSJ/wnd2USZt+fmdy6Ls3lACsOWdzDl6cAGQAo967dS8GHYrThm6Xicx00wC8Xwakr3u9YKGfk8kO2ctnZFAih6kJ0pXiuEw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cSC8x3jzWz6L6Ks;
	Thu, 18 Sep 2025 18:50:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C38FA14038F;
	Thu, 18 Sep 2025 18:55:16 +0800 (CST)
Received: from localhost (10.47.69.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Sep
 2025 12:55:15 +0200
Date: Thu, 18 Sep 2025 11:55:12 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH v18 01/20] cxl: Add type2 device basic support
Message-ID: <20250918115512.00007a02@huawei.com>
In-Reply-To: <20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
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

On Thu, 18 Sep 2025 10:17:27 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
> index 257f513e320c..ab8ebe7722a9 100644
> --- a/Documentation/driver-api/cxl/theory-of-operation.rst
> +++ b/Documentation/driver-api/cxl/theory-of-operation.rst
> @@ -347,6 +347,9 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/cxl.h
>     :internal:
>  
> +.. kernel-doc:: include/cxl/cxl.h
> +   :internal:
> +

Smells like a merge conflict issue given same entry is already there.

>  .. kernel-doc:: drivers/cxl/acpi.c
>     :identifiers: add_cxl_resources



