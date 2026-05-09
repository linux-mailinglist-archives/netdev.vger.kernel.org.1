Return-Path: <netdev+bounces-286065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAVPND6L/mmAsgAAu9opvQ
	(envelope-from <netdev+bounces-286065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:17:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB04FD3A4
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8367D301779B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FA322D792;
	Sat,  9 May 2026 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQSb3G6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E61A6829;
	Sat,  9 May 2026 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289462; cv=none; b=AN7m6hm2znumMrCWZVQk8yG21aVCWiu4CON/RgWoun+ryylIphDOoNhjdw0qloF+BmKy043oj9K71bAOTHs5mfRsnHNaCC8b+J2B6wW2iMML4csbGXy3tGCGbqm7FbcpDcjyjCuh9RiKDAZOIg/8k9RnDAG9LRlIe9OXr0VdYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289462; c=relaxed/simple;
	bh=dqbu/2cwJe9fc/ymneIOMGUzRsyVd9sMZhEcCdTLQTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+oXBtf03diEkLQJ9s83shgpNQJL4sQUXQgTYFFoQRVjIlfL9YrbBtxWQ2xJtOIzLN0MnHbCBCEX7N84nv1KLBqIf2gnV4afHyuOjQ5zjtwtYFN9nuyTE7LajWKzWhFadzYwOgPpF5xTPxLtBtkOCa2cMxnxf2YOnRobqzjy7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQSb3G6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1632CC2BCB0;
	Sat,  9 May 2026 01:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778289462;
	bh=dqbu/2cwJe9fc/ymneIOMGUzRsyVd9sMZhEcCdTLQTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQSb3G6ZWQixDHh127SxTxWsxzDeUMN/UbgL6qJPZX86UeiuW1Wh1llTt1mQqSSsO
	 OvIUoHM5nHa3ge6dmMf7s9zJN4aNw5MkRK41a3w5j6NiZRxHJ0s/k50uxQUDtTa1Gc
	 CZ8uP31v1MQ9kn69GHqkRYeCjdsOEHj0j6Nwxa+b79gLqbtHxzi3FvIFJ/ia7r68ty
	 KlIQyku30SSlxZaUflMeT7flXArxpXk/TsLTwjFM0qOKGXwKQckfTwExWGIw/hFjPS
	 e6Mq8IsG9u62KJVStVpscYYfUiawGFAwJTdn7YZp6GNVNl5ayrR5VKaDXnGqOtDJ2p
	 WKbzJ2NtOK2AA==
Date: Fri, 8 May 2026 18:17:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sajal Gupta <sajal2005gupta@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: pegasus: replace simple_strtoul with
 kstrtouint
Message-ID: <20260508181741.50c093ee@kernel.org>
In-Reply-To: <20260506152653.52329-1-sajal2005gupta@gmail.com>
References: <20260506152653.52329-1-sajal2005gupta@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 81AB04FD3A4
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
	TAGGED_FROM(0.00)[bounces-286065-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed,  6 May 2026 20:56:36 +0530 Sajal Gupta wrote:
> +	token = strsep(&id, ":");
> +	if (token) {
> +		err = kstrtouint(token, 16, &vendor_id);
> +		if (err)
> +			return;
> +	}

Why bother capturing err if we can't return it?

if (token && kstrtouint(token, 16, &vendor_id))

