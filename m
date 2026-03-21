Return-Path: <netdev+bounces-270159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLcMFTkOvmlQFwMAu9opvQ
	(envelope-from <netdev+bounces-270159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:19:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D62E3166
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A17B230467FF
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E21D2D0C82;
	Sat, 21 Mar 2026 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMbwq02s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4E288C2D;
	Sat, 21 Mar 2026 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063053; cv=none; b=WUEESOtlUsX2P6ud3GDS5bPDA7dbcTlI/S6V92Tm6JzGSUcRWOxxr+M+BvzKkI+HNUbvVwPdWLaSSvNLdVdM2rjiyXxiLOeV8mC+L+uj8bRTXMXesGgumiimHe04dC/Z6p+br44opQqYuQxA24kdE1C8RTMoNpE+Zlv1XL+fExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063053; c=relaxed/simple;
	bh=+hkoLcmn0GJw34LvrAADnB7gKSlzyx33Fk+lHQ2npvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHisyz/cdLgPlO5h/eoV9+vqsjdYIj6woMDj8bGPDruWjVDpQEeGi8PTBan0a6jEfv7JfM4SyzUpJqTbqzJbmnLJCruRwLmEPz7hOJNepxpg8EeD+XvFL4J7KFS8HXgTocsr8iRmQJe5bREVv1avqVfEt3Rw3EgTtr2tTpBDLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMbwq02s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E3BC4CEF7;
	Sat, 21 Mar 2026 03:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774063052;
	bh=+hkoLcmn0GJw34LvrAADnB7gKSlzyx33Fk+lHQ2npvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NMbwq02sHUKtXBB6nIUmBaqEIWaA5d2QpISvZXvVuOAzXkAmUFJVRDuhD9rP3NI1j
	 /4ojhNlxq41Fe4nXVfMBoGbWzHN07R/3Gv01enF6bxI7kfhE/ecDbaOH0XZcts7wQz
	 0eVODrWw7+ZjoIrojwKnstwR3RpUvAapdp52E8SNwaoVinwQFhEkAjUzhASRE7Sdye
	 M2vTMqmXbBHUYZL3PIOe7f2SF263MtFlfFtTtstFJvNQj3bS6XISBcohfNYvUgFVu/
	 XWAri4e2ZtkiBQ9aA4e/6AIbMdJ8PigLUEvgLWbu8TZvDtHZd6w9np2kV0K0zXdyqx
	 ByR2DUsqu3hEg==
Date: Fri, 20 Mar 2026 20:17:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, petrm@nvidia.com, willemb@google.com
Subject: Re: [PATCH net-next v3 9/9] selftests: drivers: hw: add test for
 the ethtool standard counters
Message-ID: <20260320201731.302b1026@kernel.org>
In-Reply-To: <20260319160410.2515105-10-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
	<20260319160410.2515105-10-ioana.ciornei@nxp.com>
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
	TAGGED_FROM(0.00)[bounces-270159-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ethtool_std_stats.sh:url]
X-Rspamd-Queue-Id: C22D62E3166
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 18:04:10 +0200 Ioana Ciornei wrote:
>  $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
>  TAP version 13
>  1..1
>  # timeout set to 0
>  # selftests: drivers/net/hw: ethtool_std_stats.sh
>  # TEST: eth-ctrl-MACControlFramesTransmitted on endpmac17             [ OK ]
>  # TEST: eth-ctrl-MACControlFramesReceived on endpmac17                [ OK ]
>  # TEST: eth-mac-FrameCheckSequenceErrors on endpmac17                 [ OK ]
>  # TEST: eth-mac-AlignmentErrors on endpmac17                          [ OK ]
>  # TEST: eth-mac-FramesLostDueToIntMACXmitError on endpmac17           [ OK ]
>  # TEST: eth-mac-CarrierSenseErrors on endpmac17 (not supported)       [SKIP]

The output needs to be KTAP for HW tests. NIPA tracks them on sub-case
basis, because most devices will skip at least one case. We need to be
able to catch regressions at finer granularity than in SW tests.

