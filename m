Return-Path: <netdev+bounces-276785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ2VIDcR12kSKwgAu9opvQ
	(envelope-from <netdev+bounces-276785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:38:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6963C5928
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81CD030036F2
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8A35838A;
	Thu,  9 Apr 2026 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liPC04BF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8F1D5CD1
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702301; cv=none; b=K6zFfCqQ/gf+WrDJXw2/OMub+3zPXbbvEKoJWl+S3iO3PiqAAaE+m+dGBoS/TPD/Nb1KTCgOuRwVZ+6OJsTS6feNsM0p+1TSvbPlNpUu8+Ccwv4uVxSQUq9tEr2EUXRon/IWwKcD5p+bmsaS02W5USjk3BqnKzb/HJFIQbBSGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702301; c=relaxed/simple;
	bh=XbvmYxYToqOM+Ve4KTW+qEPJth2RCNBiqg1hn8bMxqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB4NtLMtSpNvhRYlZ//4oL1sytaK0ij6N/pCS+VV3flSdwE7wpgNzp/zfjpfduCsbeOGZ7fOXKwdmouy+ImbISpADIaPX3VbdQyke/BpGe6+6EB5iyROl26BB7ZHQyZc3SXlER+nLP9aO/0MuAsCgxjDCgIyL0mtYNy6sS9oPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liPC04BF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88793C19421;
	Thu,  9 Apr 2026 02:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702300;
	bh=XbvmYxYToqOM+Ve4KTW+qEPJth2RCNBiqg1hn8bMxqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=liPC04BFK8CxlL1psh4kemN3baKgd6BtQcJXqKqJzm4pSgK8MT+pZ8UplZM/s9Jg8
	 nKmfPib8Lv88EBWgnADj8xA0CdLX67C8r9UhFjd49DVLmhp2IIxnISAST3ZfF3mIxV
	 vMskZTUc+5uU/1hnsrfW228qp43fH5Z8eN9EUzlXVk9dN63VsAfeBKXkd3SZ7SyipX
	 HKNaltxvS3B+EvSr0jnWm4STR2GCnYE0ziqy9vrwN4tga/5NTW6Hg5Ff9HHG2l1z4B
	 Hvx+tlzIG0LC39maYkipaQyXCU04A342cncX3UeFkXJHIxzJS1mqv8co2GpTvwLEAX
	 VeXUVxKvUoQRg==
Date: Wed, 8 Apr 2026 19:38:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 1/4] net: dsa: remove struct platform_data
Message-ID: <20260408193819.11be1526@kernel.org>
In-Reply-To: <20260406212158.721806-2-vladimir.oltean@nxp.com>
References: <20260406212158.721806-1-vladimir.oltean@nxp.com>
	<20260406212158.721806-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276785-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B6963C5928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 00:21:55 +0300 Vladimir Oltean wrote:
>  - ``dsa_switch_tree``: structure assigned to the conduit network device under
>    ``dsa_ptr``, this structure references a dsa_platform_data structure as well as
>    the tagging protocol supported by the switch tree, and which receive/transmit

AIs point out struct dsa_switch_tree still contains a pointer to struct
dsa_platform_data and the doc above mentions it. Please follow up.

