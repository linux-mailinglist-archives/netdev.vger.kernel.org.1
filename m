Return-Path: <netdev+bounces-271182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAVOBNvCwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:59:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631131987D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A15830A294C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6339EF07;
	Tue, 24 Mar 2026 16:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD1373BF8;
	Tue, 24 Mar 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370901; cv=none; b=Z7P9dGyH/njtCy7mM20fqay/B7iOw5UqbDqPp8xNWoQKVlGwmsqQGBCf25I54Uf2Sg3w3bYCtc3sJdipcqz1yUXNPmOaS8fp8Ax/6B1DvRHksJeEkn7alkSD4R+pHbtmPooxQKiwqIQU5AKReCBH9aZ55sftHjE4W7M74yZPpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370901; c=relaxed/simple;
	bh=C7GcttILgCJe0hsy4zaidgG+iFB/1S2SbsquItMtaXI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkS0fMtCxZKbjsUVr27GJqvciolIM4yfaLwChxr6CalDnIIhXNEnvXqngCh2RGSLqaRQpvqKoAB27kCrqiVFLb3JONZK7wM8G2nRujBOcbEzxwR979e4TcVxMUGy+/xXW07daGzLbJ4qTF60RcxkV4amKPvKJODqJVA9XqPjUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgGF51C08zJ46BV;
	Wed, 25 Mar 2026 00:48:09 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5547240587;
	Wed, 25 Mar 2026 00:48:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Mar
 2026 16:48:15 +0000
Date: Tue, 24 Mar 2026 16:48:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v24 06/11] cxl/hdm: Add support for getting region from
 committed decoder
Message-ID: <20260324164813.00003801@huawei.com>
In-Reply-To: <20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
	<20260323113117.2352709-7-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271182-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,amd.com:email]
X-Rspamd-Queue-Id: 3631131987D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 11:31:12 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type2 device configured by the BIOS can already have its HDM
> committed. Add a cxl_get_committed_decoder() function for cheking
Spell check commit messages. checking if there is one


> so after memdev creation. A CXL region should have been created
> during memdev initialization, therefore a Type2 driver can ask for
> such a region for working with the HPA. If the HDM is not committed,
> a Type2 driver will create the region after obtaining proper HPA
> and DPA space.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

I'm not following the logic below. Perhaps some comments would help
me understand why the condition is sufficient.

> ---
>  drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  3 +++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c222e98ae736..006be88efaa5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	return cxled->cxld.id == port->hdm_end;

This condition is non obvious enough that to me it maybe needs a comment on
why it works.

> +}
> +
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +
> +	if (!endpoint)
> +		return NULL;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);

	struct device *cxled_dev __free(device) =
		device_find_child(&...)

or something along those lines to avoid need for manual put below.

> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
> +				      find_committed_endpoint_decoder);
> +
> +	if (!cxled_dev)
> +		return NULL;
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +	*cxlr = cxled->cxld.region;
> +
> +	put_device(cxled_dev);

> +	return cxled;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");



