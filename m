Return-Path: <netdev+bounces-268417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDWPJDDMuGkrjgEAu9opvQ
	(envelope-from <netdev+bounces-268417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:36:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D852A3400
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59533015E06
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F702FF65B;
	Tue, 17 Mar 2026 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ5HYkgO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737C2C178D;
	Tue, 17 Mar 2026 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718573; cv=none; b=DSgXHRd9YrCjyP4tz2Us6Kp7qxmGhZT2xYPMnM7g9Rl+j3VUL8F0WcMLowRAbWvXh1kMVZNesfsqPIelFg0ax7Z1euZdopDZe6smXDvUJqnEXdRg+tVbHaIhuS3k7TecjKiV3O8qL7oNRIdGO0JC4BcL3/XiDguz0lw9H2oTsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718573; c=relaxed/simple;
	bh=UI92s/x3nVookfRitQLmwJg/pOLxlDlkE5Ya4sqKc9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7VRM4ort/wBBIX0bJXhZkHWhz4YFt3M6N3iTnLfeqXXuq37Kuh/umY8sb/6BlkuW4UfbTwNQS77UUBxZvDsBQe8xMGZBPUNW2+TWfxc5bRezBynRjO1pzykTzc6qv5T94jVsiG/7Vnf6A7KPUQdFD2xgr+m5U6HY1M69u29dWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ5HYkgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5007C19421;
	Tue, 17 Mar 2026 03:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773718573;
	bh=UI92s/x3nVookfRitQLmwJg/pOLxlDlkE5Ya4sqKc9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZZ5HYkgO30XDMA36enaHcgf9TI4n4F9+KviyslenrcKEcq8eBv8OaGbuyLa9k1E+r
	 +yWDRIFvt+i47J2pndgAe30/I74sxFqW+kqI6XaF0ZHWG8ix7pg1Kkfa+gMqVJE3BS
	 NgY5NsCUyqtmAIViRr9catUzC59AY/ZCAQ1nhN7dnnWnxhXSLFjhGGzJnEMxWx+eEe
	 M7qXw2dA4sm51gISRTANBzFGU8UvG0zQYXLYxUxrnAME1tpzMqMA1w7Qx5+WP7gDSc
	 TVsSS4w6y9T3wQH5h6uH8CAidyUPri64NkS3WzynZdADXqL6IyLm9b7DvVvfYsq5eq
	 sjTIKIfiyeBnQ==
Date: Mon, 16 Mar 2026 20:36:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
 <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
 <cjubran@nvidia.com>, <shshitrit@nvidia.com>, "Saeed Mahameed"
 <saeedm@nvidia.com>
Subject: Re: [PATCH v4 net-next 2/5] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <20260316203612.00100ff4@kernel.org>
In-Reply-To: <20260312022754.2029595-3-rkannoth@marvell.com>
References: <20260312022754.2029595-1-rkannoth@marvell.com>
	<20260312022754.2029595-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7D852A3400
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 07:57:51 +0530 Ratheesh Kannoth wrote:
> -	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
> -	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
> +	union devlink_param_value (*default_value)[DEVLINK_PARAM_CMODE_MAX + 1];
> +	union devlink_param_value (*param_value)[DEVLINK_PARAM_CMODE_MAX + 1];

let's declare this as a pointer rather than pointer to an array,
the (*arr)[i] indexing changes won't be necessary.


