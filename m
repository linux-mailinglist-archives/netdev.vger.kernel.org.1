Return-Path: <netdev+bounces-267480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNfSK+YgtGnahgAAu9opvQ
	(envelope-from <netdev+bounces-267480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:36:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA309285183
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A757304D977
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71A3A3E9E;
	Fri, 13 Mar 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAypwmcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532043A3E62
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412311; cv=none; b=vBI9uyC5M5PZ8TBtdCxCZKiZYq4ifpGJbcNUtlOxmAZ+nAXNVeiIwY3raj6u5e1Yq5lPW0dWZciCLfnL5fyzHVuqwS5tqd0J+UbBWOavei0maq/u8OOB2zYgT8D0Zk1EK0QQH0nctFJGIUGAA/gbiNxdwLSnbWxmBSpVjVUwPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412311; c=relaxed/simple;
	bh=sxCpbTctA+RZNdC597cmoMASeWWFt3FxcZxm5LfrmZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMW2vXx/fT6WGjqgpofdCdsfqejn66Ull163wYmXWRMfYYJ4mN62lcLoXGno0pYKao86WCjYllElr4RHqPRq2Fzliysu7+E0a3Q7bkSoGK3GH7HxF6vuiShmHALSRFFYhrA3WacHWzLy1qOyInvFflJW1H76Y4Mc72DfEW5C4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAypwmcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1517AC19421;
	Fri, 13 Mar 2026 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773412310;
	bh=sxCpbTctA+RZNdC597cmoMASeWWFt3FxcZxm5LfrmZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAypwmcy7+uC/mkkjD9zZ7DERx2WdIGWr8DmzfMV9N/WE+TqdxkV1l1QHvW77tR9Z
	 RGAh0XSObqRoomk32pz3RCTz4KyYv3jNyTDND5HI9Itlet9VNHcZJhHd+oGcAFU9dt
	 2oHHN0SkgDHy76DPA5nl3rSKN10TciiIb/wGwDFSR2lwk3AOxmLM+J6ePZOTIbOvaQ
	 9ZD+3Rt+6s4CIFZZJX8njW81mntAqhPgCkMgM0w8MG1FgWdRI5qxG/VKQni2Fop+WJ
	 RXbeX0HnnMbuLvRH8fi6RAuSIsClxs5gery43kaTTKl3nB10M27k5F00fi3e2l55Xf
	 YTq4OPWLxsPRg==
Date: Fri, 13 Mar 2026 14:31:46 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Remove airoha_dev_stop() in
 airoha_remove()
Message-ID: <20260313143146.GE461701@kernel.org>
References: <20260313-airoha-remove-ndo_stop-remove-net-v2-1-67542c3ceeca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-airoha-remove-ndo_stop-remove-net-v2-1-67542c3ceeca@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267480-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA309285183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:27:00PM +0100, Lorenzo Bianconi wrote:
> Do not run airoha_dev_stop routine explicitly in airoha_remove()
> since ndo_stop() callback is already executed by unregister_netdev() in
> __dev_close_many routine if necessary and, doing so, we will end up causing
> an underflow in the qdma users atomic counters. Rely on networking subsystem
> to stop the device removing the airoha_eth module.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Target net tree instead of net-next
> - Add missing Fixes tag and improve commit log.
> - Link to v1: https://lore.kernel.org/netdev/20260311-airoha-remove-ndo_stop-remove-v1-1-596fe853b2e1@kernel.org/

Thanks Lorenzo,

This seems much clearer.

Reviewed-by: Simon Horman <horms@kernel.org>


