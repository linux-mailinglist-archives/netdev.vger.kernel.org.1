Return-Path: <netdev+bounces-270152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIYtGVkAvmn1FAMAu9opvQ
	(envelope-from <netdev+bounces-270152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:20:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AAB2E2E20
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352B23044A5F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F0C26B742;
	Sat, 21 Mar 2026 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odH6QzqE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BCC1684A4;
	Sat, 21 Mar 2026 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059585; cv=none; b=BnNxz103u3IdyF0jxQQH7jJkPYnlO1DSPuJa2E8h1MljJp86cY0FaizRANmlDDOwf/tSHtMkW4OhA+M9Z1vj0FFoAofam+oLc3tK3qMU3QOvsxKcxd2hDgCAUEfS2AimHS+8chqX93f6R7nmBDecPjhFXf39ccqv/ZMbjVthyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059585; c=relaxed/simple;
	bh=B46boP4KQH0aUYCmWrqmyddQC4iUSf3MZC1uLrDcju4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QApsi03f6fMqiDXBOKF2mhM5tkt24rZ542n2LA5kByybrxpNL4RZOaKG8pT3k+X12BsZaOHHc+1SAkFY96N0oJUHfVQ+z2kJOmcdE5uj+uk+LXfXIcck3B4+4MWLRqSlP7nzmOsZoEBcMANjXUAjGIzFhmvcN9W0/PK7P4MlaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odH6QzqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E2AC4CEF7;
	Sat, 21 Mar 2026 02:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059585;
	bh=B46boP4KQH0aUYCmWrqmyddQC4iUSf3MZC1uLrDcju4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odH6QzqEi9bJOy75ecffMuMrZKHkC1dvIMPN++qCChgSxTTkNl3p57vg9OrtkkTBO
	 SGd4OArKu76mmCLUZ1RfAFduNkQTDOCy3R1i5O9w6o+xYpajmA67O6s6wlh/n3LlWa
	 dZM3GEeZtERI7WlqEGfTS6hZ0kSkzNqSUbh38Zk6braO71wygiu3oxso4BbxwEeYyM
	 Wj9c25AiKONR1dw6FWdicX6NyGN39PYQCrhGyAnntybzuDdsU9JSTHkMGJxgCQeHJY
	 fzU2H8V07IuKLqWMwwfvzXVGtyM3HwyollrYdygydBJYVz7oKwdgz70OU/x4es7zRF
	 aeSG5W3lVznyg==
Date: Fri, 20 Mar 2026 19:19:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: dpaa2-mac: export standard
 statistics
Message-ID: <20260320191943.2325cf38@kernel.org>
In-Reply-To: <20260319142346.2483232-4-ioana.ciornei@nxp.com>
References: <20260319142346.2483232-1-ioana.ciornei@nxp.com>
	<20260319142346.2483232-4-ioana.ciornei@nxp.com>
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
	TAGGED_FROM(0.00)[bounces-270152-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: E4AAB2E2E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 16:23:46 +0200 Ioana Ciornei wrote:
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, undersize_pkts),
> +	DPMAC_RMON_COUNTER(DPMAC_CNT_ING_OVERSIZED, oversize_pkts),

AI says:

According to the RMON standard (RFC 2819), the etherStatsUndersizePkts
counter tracks the number of undersized packets received. Should this map
to an ingress counter rather than the egress counter DPMAC_CNT_EGR_UNDERSIZED
used here?

https://sashiko.dev/#/patchset/20260319142346.2483232-1-ioana.ciornei%40nxp.com

