Return-Path: <netdev+bounces-182813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BCA89F6A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A7619030D3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBC7297A7E;
	Tue, 15 Apr 2025 13:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A7297A55;
	Tue, 15 Apr 2025 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723675; cv=none; b=O+hkm/uoupPpBChHs/pzOpNRyPv+iZZ7CGjcYGI/kJdiutCqazA5BTrBb33dU8I6cUvwNd8z4j4/1rx5x0+8tRZq+Tx3a+OHcE5cQ/dkXA6rQKfupY1VifBlFcSxcqv1p0xrrDb+mgnusP+Ssrbt/cm2WgWyjecEn9TiaKXQBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723675; c=relaxed/simple;
	bh=5vIWnpx34IrIwlMaWnfTMqgc0h9UiEmWCwYdJOSdYx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2m7Valhl+pu+qqX2xsy0tGIQ9dtvDMrxS1VeQV+b0rlIKepK465AWx3Z2yKFH41G/gIS5YNaWHHk8E0IibwdJ+rnC1gy/TewrZHdL565SbpdlxAMW6r6hJVmiE1doIApXAnHuaLmHxNycz8B+KLTyKuKgZdh7UrHsnDrHOa9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcPxR72hcz6K9YH;
	Tue, 15 Apr 2025 21:23:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D3EB1402C3;
	Tue, 15 Apr 2025 21:27:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 15:27:50 +0200
Date: Tue, 15 Apr 2025 14:27:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 07/22] cxl: support dpa initialization without a
 mailbox
Message-ID: <20250415142749.00002b4e@huawei.com>
In-Reply-To: <20250414151336.3852990-8-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
	<20250414151336.3852990-8-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Apr 2025 16:13:21 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DMA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile and/or non-volatile hardware partitions.
> 
> Export cxl_dpa_setup as well for initializing those added DPA partitions
> with the proper resources.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


