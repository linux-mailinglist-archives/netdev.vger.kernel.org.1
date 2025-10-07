Return-Path: <netdev+bounces-228107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76009BC17B5
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 15:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B51594F6594
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE32C2DC76A;
	Tue,  7 Oct 2025 13:22:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767032D77FF;
	Tue,  7 Oct 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843329; cv=none; b=IoEdsJ1pFEaf1F71COXWKlFSXiQH70/u6zke0ljTHqCa1Ovs2ei9nTuSTaZzAFZWllhGlHLc76HTRPxibebgtO5xCLCEBUE/8uoOBFbw6UNjDYGn0tVyeykuY43PO9qubHuNXpHKL1KYPjBOcBHLgvEqMZSG6iSC73kXuFFwDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843329; c=relaxed/simple;
	bh=5TU8FHnQaEqyow6KHDzKj/enOXak8oqqD7sbJJrw1cM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzX3/w1EdbFhKDH/21bk5rcr7DwKJi6wNdIB8t1Yt4VJogtxIUq/7AL5fpW7MXbMf/8aQBKbiCK5lEd5rVBEjrFbXWPMOvdkWD/Cjv9u5oOgJlNLL5JB/4c4OaNymJg6ZA9xKHz373l7r5c5HdsmnoIcPfkr6o2xPo49NWtQoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgxY20Qwcz6M4dG;
	Tue,  7 Oct 2025 21:18:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 399EF140159;
	Tue,  7 Oct 2025 21:22:03 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 14:22:02 +0100
Date: Tue, 7 Oct 2025 14:22:00 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v19 08/22] cxl: Support dpa initialization without a
 mailbox
Message-ID: <20251007142200.00007840@huawei.com>
In-Reply-To: <20251006100130.2623388-9-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-9-alejandro.lucero-palau@amd.com>
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

On Mon, 6 Oct 2025 11:01:16 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>

I think this also needs to mention sfc in the patch title as we'll
need an appropriate RB/Ack for that part.

Lazy option would be
cxl/sfc: Support dpa initialization without a mailbox

but there are probably better options.

> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.
> 
> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

