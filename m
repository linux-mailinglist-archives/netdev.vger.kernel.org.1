Return-Path: <netdev+bounces-269644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD5hF8NevGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:38:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C527E2D244F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F13530DDF2F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244953F7E80;
	Thu, 19 Mar 2026 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0vmyMca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CF3F786C;
	Thu, 19 Mar 2026 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952054; cv=none; b=UN08e8VrbFy+1rpBbKlrnga5UUCHy3swseE67dZqedWvsj/ED64ZzSrVkpqslJjFjBV86Ap4ScEpzFycqv/8yKyGPUvTLQA43a4RtyWNSQ8IkNMTfNA6D430zYtDaZfKsy9WuGKUEOcbDyH6gYovYpcTE1tsHDqLbr8C27V/ZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952054; c=relaxed/simple;
	bh=20NVRIFkxvCunFgcmYqmPFh5mx4iV47VCJg4IBht8iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ90zRi/JRSR3QoTwdXwx6+Ju7ziVkWCrQq39/NNCDna58wLsxV+kKX4Wfr4GfZrROIkXODLNm7/jfSjlnq8VSNcl07DM+2vH+RQ/GtYAfh30bOM0/Zg23B/wF+BPMeniUE7Q5Uko8RMuiI4JWg6PdteoNKio1wcVJKyGxDr9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0vmyMca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A619C2BCAF;
	Thu, 19 Mar 2026 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773952053;
	bh=20NVRIFkxvCunFgcmYqmPFh5mx4iV47VCJg4IBht8iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k0vmyMcahoW6i+h+LPcyuSciKo//+Bo7l/xImrsA+VsAa0W8OKzmt6i+fkbBfHxq3
	 t7Maa8SfGut8JBdbVfF8ZnCZJMSk3Bw5nmFAcqoW3vc7UsAGySGlhbuIYxlnzeQaLp
	 ik6sOCEH9HfK3uR7D2PnOeWTXES9v0Y2uzImuGdZNwdSBZFVzz52KGjxPzO4S+3+tr
	 cad0CnRSHtBY4pb7bwjH6t5MVsQJ3+erl4FsHLJZbEogOWJtfEPJ4OqZ3R8ZhbN/vB
	 3N61FC1vY55oOdeH4jQtDGU15xPygd2q/2cSZxdxvl5xo0zwrmBMtZnRbBYsRo4WAD
	 LtFWqppJSE0DQ==
Date: Thu, 19 Mar 2026 13:27:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next] net: add netdev_from_priv() helper
Message-ID: <20260319132731.504d34dd@kernel.org>
In-Reply-To: <20260319022608.323969-1-dqfext@gmail.com>
References: <20260319022608.323969-1-dqfext@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269644-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C527E2D244F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 10:26:08 +0800 Qingfang Deng wrote:
> +/**
> + *	netdev_from_priv - get network device from priv
> + *	@priv: network device private data
> + *
> + * Get network device from private data pointer
> + */
> +static inline struct net_device *netdev_from_priv(const void *priv)
> +{
> +	return container_of(priv, struct net_device, priv);

When you repost this with a user please format the kdoc as:

+/**
+ * netdev_from_priv() - get network device from priv
+ * @priv: network device private data
+ *
+ * Returns: net_device to which @priv belongs
+ */

