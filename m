Return-Path: <netdev+bounces-257457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAhlEYFkhWl3BAQAu9opvQ
	(envelope-from <netdev+bounces-257457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:48:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3BF9D83
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F73B300D96A
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305933291A;
	Fri,  6 Feb 2026 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wy5vDbZ7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE52F8BF0;
	Fri,  6 Feb 2026 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349693; cv=none; b=kCbtTZYwI0Sr3XNuIvVjqwUg7NWJ1qdojw0XXNrIrUr7Qj7o0z+WCz64UHtY9I6TaGYhTeypYL5M+fOAkPGPGlILpWnJDxJchigd690by/AFlJ5isfunsOXLdu/eos8ojQMOWvz67ldWnfmLNJ8IgvDlZT7EUXQ0za1O4lh/jv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349693; c=relaxed/simple;
	bh=U5ojEWwpvn/zOfdKHlS59o7JIslr5vAjmqMoWbq0HEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avmyh3pCqroCOrZSMYVLHd92xqCYFHeKq18bR/YacEeglTnod+KvT+5V3eTz0j0ZNdWrki4ak6znwNy8Ng1nXk2DnHuFgZXvIMVkv5j4psZLHgIrNB6r75Chzoe4g/xXKEvMI+RrRQd7clxRBDR4l/Uvl/ICzg0jN3Z8ySjLjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wy5vDbZ7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9iktUB4hznH83pxUYZ3FydB1Eh6dRhOC/mDhwdJtZt0=; b=wy5vDbZ7CBkDahghJjiD8EHJ51
	rnLXIoyEw1y+bqF5T8TDgPuFxzyVkxMIa4ig0ErNPPFUBM+qtjFiAoNBlw5TcmpjbPgFYPataqVOU
	ykux7CVXQhLPvKHO7bSPR411d0sg6YvOOq2kIQwJCz5wVnQwkDmZQ4+bviVHNANnMtBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1voCp4-006L0M-RX; Fri, 06 Feb 2026 04:47:58 +0100
Date: Fri, 6 Feb 2026 04:47:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 05/11] net/nebula-matrix: add channel layer
Message-ID: <0adbe485-867f-48f5-a805-d45bfd300452@lunn.ch>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
 <20260206021608.85381-6-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206021608.85381-6-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257457-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96F3BF9D83
X-Rspamd-Action: no action

> +static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt)
> +{
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_hash_tbl_key tbl_key;
> +	int ret = 0;
> +
> +	NBL_HASH_TBL_KEY_INIT(&tbl_key, common->dev, sizeof(u16),
> +			      sizeof(struct nbl_chan_msg_node_data),
> +			      NBL_CHAN_HANDLER_TBL_BUCKET_SIZE);


> +#define NBL_HASH_TBL_KEY_INIT(key, dev_arg, key_size_arg, data_size_arg,\
> +			      bucket_size_arg)		\
> +do {									\
> +	typeof(key)	__key   = key;					\
> +	__key->dev		= dev_arg;				\
> +	__key->key_size		= key_size_arg;				\
> +	__key->data_size	= data_size_arg;			\
> +	__key->bucket_size	= bucket_size_arg;			\
> +	__key->resv		= 0;					\
> +} while (0)


Why a macro? This could be a function. I don't see anything magical
here.

	Andrew

