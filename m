Return-Path: <netdev+bounces-284093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJoAJ5Ew+WnA6QIAu9opvQ
	(envelope-from <netdev+bounces-284093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0D4C4F44
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A5E6302D5CF
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C93E717C;
	Mon,  4 May 2026 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olEPb3Bk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21653630A8;
	Mon,  4 May 2026 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938545; cv=none; b=j5aTPfkGYuqYmWTaDi/3mPtjL/F4+E2NrR3o5mWnrapXsrBPhHN2i/czvUsFThSJzrlvmQeVY8slKUz8xqSQpwtjJAjqsUZZBCkW0T4A7blbMh72CWWcKWv9Or1xF9Y2EfFXV60RT1iQ0ytCODd6N5H1fQxmdykwQrookhDjYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938545; c=relaxed/simple;
	bh=1YEgTXFnNhsezPKG1SL44lFyIWkcrIRXOaIiyF2/U/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6CNCowatv9NZmMOVYiBmczlRWbXoBR1YV6M+BXceFkLjneoqqSQ18Y+x5qHUjTkupBkDprq/tJFnh7cjtpZQj33B6GXH0pfYutgFS9kho//n+bn05D5Hb0n438EgcVBOIcNfDG32yZtVcoUEcyf+Xz4A1a4sacSD6HuZrxYTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olEPb3Bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2479C2BCB9;
	Mon,  4 May 2026 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938545;
	bh=1YEgTXFnNhsezPKG1SL44lFyIWkcrIRXOaIiyF2/U/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=olEPb3BkVZSMdwvb8IksdtZmYho7UQAw/qi3eGEGkFvEXIcFdKAb5a9heqA2UxJXQ
	 Pgtx3l6JBOZZs+U2A7Eq6gUFuCrvnWoOlrcfTZKgC4mANd0kINogsaJBjgMfBDyQkx
	 KcwM1yqw41GiCipWVyHOrsbnxMDxz/4FXOpyh69dt3nH/hxUjADAp/3jgmNO8pmnvF
	 /1ntDLWbav4ikzuuQpSpzFotHxIIHiU9pwAN9u7ONp4SZbfLm0V1QRh1EaUhqZgj9a
	 vMa/3wLzdMDxZv3ifTkmxxfxylh9VemKeQScdxkTdzHN2xmbucBZwL1RgdPko6lE2F
	 seY27d5owCHBg==
Date: Mon, 4 May 2026 16:49:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] e1000e: ethtool: add get_channels support
Message-ID: <20260504164901.7b3a737b@kernel.org>
In-Reply-To: <20260504154823.2535612-1-jon@nutanix.com>
References: <20260504154823.2535612-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 41B0D4C4F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284093-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon,  4 May 2026 08:48:23 -0700 Jon Kohler wrote:
> e1000e hardware supports a single RX/TX queue pair, add basic support
> for ethtool -l (i.e. get_channels), so that callers indeed see a single
> queue.

Why? Isn't EOPNOTSUP from ethtool -l implicitly saying that there's
only one queue?

