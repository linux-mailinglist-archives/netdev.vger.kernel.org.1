Return-Path: <netdev+bounces-154746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836579FFA86
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704E93A35D6
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49141AF0C9;
	Thu,  2 Jan 2025 14:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4611B395F;
	Thu,  2 Jan 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735828700; cv=none; b=bxMlpHWf5LV2pVfZJW+WNPtLFM9ywNWJtN83HgT8Xy8M+cHCuNCv7diyutS4X0TTGUrJJdo+zYun2WUXh/ThQinNdLkrB/KfBWneVeBRpZrhtegN6AmNizxa3N5slyLHm2Wfuc7aK+fMRZJVqy1ViGSeumCMBh5Hpbsu846Vx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735828700; c=relaxed/simple;
	bh=8gPoOeX+NjHt9MtT/767NBdGvUiDRdzQPFDXq+qmHyQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTD8aO2lyX4+P9KnKpbh/5O1Qoufys5s38FVYelMwYfRV7YaXnqFRcivzk3uX3TBqKCsYjImCAB/Ea/8joDjTrnTa6zHnHuE5ASofvozap2Z3iXL/E04EHfOg6zkSMVaUgAI19B9g8qyEGCoOsgH3QYTkV8aFdrQ5OuSd2UHegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YP8RP15mDz6M4yW;
	Thu,  2 Jan 2025 22:36:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 117A9140C98;
	Thu,  2 Jan 2025 22:38:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 Jan
 2025 15:38:14 +0100
Date: Thu, 2 Jan 2025 14:38:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 04/27] cxl/pci: add check for validating capabilities
Message-ID: <20250102143813.00002312@huawei.com>
In-Reply-To: <20241230214445.27602-5-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
	<20241230214445.27602-5-alejandro.lucero-palau@amd.com>
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

On Mon, 30 Dec 2024 21:44:22 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization and allow those mandatory/expected capabilities to
> be a subset of the capabilities found.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


