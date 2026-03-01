Return-Path: <netdev+bounces-262413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEnUDL5kpGk2fgUAu9opvQ
	(envelope-from <netdev+bounces-262413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:09:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC011D089A
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C2DF3013495
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEF22A4F1;
	Sun,  1 Mar 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKPdMTwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC6175A86;
	Sun,  1 Mar 2026 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381370; cv=none; b=ZtjjDOuDnFlWrjcB3oo7J7026iPSxaemwjcqcHm5BMEPYBnpQ/cvRfb/AWfFNJ8eGbksuDmJwvsLTWIwGH/qgbkvBRuR35d5BawsVC3BIZow97EKWuBF58eOshZbrLHBAakcAjy2NK4tZJfy9AgrBrWZhsPWvyRf6QLraBubPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381370; c=relaxed/simple;
	bh=6aMzHQyDM4i4JKgvY1pq+wKEZ/2ebFUDNOaZdIxhcRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyrFuNJePP+7aIVhl0QrM6RU3x8MG1FztH/mdNNl3otaaljjqPH4LswLq4MmqyAlaW9nndq4YRZEmdq4sEadHy6rZw9hn/kgK9a9G3DCqwI4qkfFsO5EFbRdCrBhGVCGcvHPVPs8iSx2eu0Z9jhalAWJ0JvQHpNSbi7hToVwmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKPdMTwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA42C116C6;
	Sun,  1 Mar 2026 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772381369;
	bh=6aMzHQyDM4i4JKgvY1pq+wKEZ/2ebFUDNOaZdIxhcRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKPdMTwee2Icp4UmhsyWygY/4cVOLOgs1xyxTKsKhN1L68H27LTC1siA6LDuiwf+C
	 DE6GOUntmc1JlkD4Ei6KQrmBABUZ+95J3scMacAnEQoQWYGCR8f+d/hz9V/0UkSFzI
	 Xkl1MPzs2Qs3axgzOPQOU3XbudbKMSL/DJdVRlLV/RxoEz6f0Q+QYEDv+j9gBaySNl
	 JOc7mQFpigTW0LhCINTC3qHvTX/JID/Ydknc7g06S8MoG8mQsxYM4rBmwMxcOk5G24
	 LM8IwRW+pEgLukY13C3WvfTKoHbSm0j5kUzq9ibCUPS3MMs2YKpaRWroIOosmGFWZc
	 BTWad0MXcFDoQ==
Date: Sun, 1 Mar 2026 16:09:25 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: dpaa2-mac: retrieve MAC statistics in
 one firmware command
Message-ID: <aaRktVdeVUubxBLc@horms.kernel.org>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-3-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225150648.1542206-3-ioana.ciornei@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262413-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AC011D089A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:06:45PM +0200, Ioana Ciornei wrote:

...

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c

...

> +static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
> +				  size_t num_stats, const struct dpmac_counter *counters)
> +{
> +	struct device *dev = mac->net_dev->dev.parent;
> +	u32 *cnt_idx;

Hi Ioana,

The type of cnt_idx is u32.

> +
> +	stats->idx_dma_mem = kcalloc(num_stats, sizeof(u32), GFP_KERNEL);
> +	if (!stats->idx_dma_mem)
> +		goto out;
> +
> +	stats->values_dma_mem = kcalloc(num_stats, sizeof(u64), GFP_KERNEL);
> +	if (!stats->values_dma_mem)
> +		goto err_alloc_values;
> +
> +	cnt_idx = stats->idx_dma_mem;

As is that of idx_dma_mem. So the types match here.

> +	for (size_t i = 0; i < num_stats; i++)
> +		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));

But here __le32 values are assigned to elements of cnt_idx.

I think that the type of both cnt_idx and stats->idx_dma_mem
should probably be __le32 * rather than u32 *.

Flagged by Sparse v0.6.5-rc1.


...

>  void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
>  {
> +	struct device *dev = mac->net_dev->dev.parent;
>  	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
> +	u64 *cnt_values;
>  	int i, err;
>  	u64 value;

...

> +	cnt_values = mac->ethtool_stats.values_dma_mem;
> +	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
> +		*(data + i) = le64_to_cpu(*cnt_values++);

Likewise, I think the type of both cnt_values and
mac->ethtool_stats.values_dma_mem should be __le64 8 rather than u64 *.

And there is a similar problem in patch 3/5 centering on the use of
le64_to_cpu() in dpaa2_mac_transfer_stats().

Also flagged by Sparse.

...

