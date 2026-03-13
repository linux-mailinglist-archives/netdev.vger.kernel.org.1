Return-Path: <netdev+bounces-267245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P9YOd1gs2lcVgAAu9opvQ
	(envelope-from <netdev+bounces-267245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:57:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE61F27C156
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02FE5316B70E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683BB29BD82;
	Fri, 13 Mar 2026 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7KGb9T6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622F20468E;
	Fri, 13 Mar 2026 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362990; cv=none; b=SitBIX5P0bQj8GRoV9JkzCWiFN2OmUqru7fnKfdGU+KvUReEYiftkEF9QkP2B+lTzDItYYgI+k1/T8IkvH7T+//Nob2Zi4OfYhq7t1FpPx6+ZOJE0LS6gt4ChVKjnfrYXDAYKXxEBJdVxgpD+6pxQS40cuJyTpsf9sgC42TXylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362990; c=relaxed/simple;
	bh=1b3j4V41Td3jfEMgvtTcFh51Vztz/t2ysF3I7S1JhuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMmIoYzzZUIZlcw/M2IB/GH7vDk556e6oEOW732ZU5BRMKs8Ow5G3PAutO4ycM34aJEf/qT16okKllepZPPFA4Sw5af9EIbYF4xZFngTcyqPin0FwvlbmlQogoxS3Pum12alw/JzqIXv8y9MJjrHshxJM5zxZ8CZt5fwCOkZKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7KGb9T6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A66C4CEF7;
	Fri, 13 Mar 2026 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773362989;
	bh=1b3j4V41Td3jfEMgvtTcFh51Vztz/t2ysF3I7S1JhuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H7KGb9T62VmrVxeYeurB7WTnfpperHtPgtmFVjfLc1v/g4nqqwHRcWKuezmomh1YW
	 hBChECJzGPtGMn97RLb2KvcDLKkd19iajQg6biS8zRbK+7Fr1ErQV6u74i/rVqDxqG
	 Nu/i/087NIrmSvgpTPfv/s4WNAH/cV67gkfKxAiLfK6ZoEST6B56qVNkVbbG9i/RLl
	 493SW0YYp8+r7+G/j8FFBOPXClGz1QwKv0n7Qx7AxF9XouNps5r+yYH+NpICpKo0eX
	 nNimR4gbzCi4XfjnaoYqbvq1Hrhuat0W3G6TLlKZ9ivixAS7z1xrwmh6glwvlAhIFN
	 O90nMT9wv6qVA==
Date: Thu, 12 Mar 2026 17:49:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ShravyaPanchagiri <shravy112@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ifb: fix space after comma in for loops
Message-ID: <20260312174948.42d95f07@kernel.org>
In-Reply-To: <20260313003651.65612-1-shravy112@gmail.com>
References: <20260313003651.65612-1-shravy112@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE61F27C156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 19:36:51 -0500 ShravyaPanchagiri wrote:
> Add missing space after comma in for loop to fix checkpatch errors.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject

