Return-Path: <netdev+bounces-201800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE9AEB194
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE1D4A5EF1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D127E06A;
	Fri, 27 Jun 2025 08:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4112279DD9;
	Fri, 27 Jun 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013958; cv=none; b=iKF+2KmSe4033yCLnyyd7qgEQuvsUvEjUDbEDybU7LdDBW3SO+esMrEv9rIcM8fCvZO9U0dvpM/Hvp7XADnOkKWI/obOS0G2VoHTQk+FxxH5tpvzABAEEoQSLDj1LxmLvG1dYJtXCXql8saJse0RSZHVoTUT/u++sf5/S1JbUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013958; c=relaxed/simple;
	bh=kDzLvO/h43dz7WnIFcS1RXacW8HL/F0fcjvrszRUqDk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CURUnCZKOGnjnSY/d5LF63arf1gIFhoWL0/POHyF1Kwu+WonYUrU+/77lhb56UKXsUAxE54EI8lgN6SmJTWKILRZ/FCWSZ9KKo6WdjDXFlp0n4A85l6Q3bEhw9oFltGXrHn0tNPFfU6xuE0/3UCCqZmszwtB1PjO8eKsjWCZ9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT8K43WDsz6L5XL;
	Fri, 27 Jun 2025 16:45:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B4AE14038F;
	Fri, 27 Jun 2025 16:45:53 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 10:45:52 +0200
Date: Fri, 27 Jun 2025 09:45:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v17 05/22] sfc: setup cxl component regs and set media
 ready
Message-ID: <20250627094551.0000360d@huawei.com>
In-Reply-To: <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-6-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 15:13:38 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping regarding cxl component
> regs and validate registers found are as expected.
> 
> Set media ready explicitly as there is no means for doing so without
> a mailbox, and without the related cxl register, not mandatory for type2.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Few things came to mind reading later patches...

Some of the calls in here register extra devm stuff.  So, given we just
eat any errors in this cxl setup in my mind we should clean them up.

The devres group approach suggested earlier deals with that for you as
all the CXL devm stuff will end up in that group and you can tear it
down on error in efx_cxl_init()




