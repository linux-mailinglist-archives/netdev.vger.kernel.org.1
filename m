Return-Path: <netdev+bounces-275049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA+uMlrDz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4813949D7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A96FC301982B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0B3AB286;
	Fri,  3 Apr 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="len1WXHU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB43A4F2F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223538; cv=none; b=Zc1BPWD5hpyLFYs5bT7MxbQrucftDmL9EMjFpUUcvMXAPeAd4p8GoMY3bBxKgeUIxzXcFp/+pPVp8q6WpkfP/eQfrJ+/u3ONYSHYG+vJRHn6vXnYxU/cBgp39P58E8EK9WrXLmkT2DPTCrXTWWnTZUecJI2R6KQR0baNBsMBk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223538; c=relaxed/simple;
	bh=ON/nNOqI/OkiuXpJNKeSHyA+bBRHeRwSkEFs+cCTYWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udF7FUbBVNXL+v6sMoXDc4iPrfEtDJiMumy7c6Flz4or3vEQLnd4uxLLXbH1XCOd8hT1JmC3Qt+linmaHzvCzTv1THqD44jFvluCi7ggYgcZgpbTT1XpncV7MJuA7pXahVBLQU3un0I7ABuFQ9zSbMUWOs6GtXTExL8JdDh3AwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=len1WXHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADFC4CEF7;
	Fri,  3 Apr 2026 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223538;
	bh=ON/nNOqI/OkiuXpJNKeSHyA+bBRHeRwSkEFs+cCTYWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=len1WXHU9M1UIQTj5jzzxQ3gZLAvL9TzQU0+Z2peuAmauY94FrLx09aCQDeptmN+D
	 VjjSK+y1h/jmipcNVHbd9Xrr88NmqYWgjRNZcWg7jopv0Qt3T4sIFqQDYVKCkvJaoA
	 vAbxrjGKUQFqYGAh/6H3G66wQqtFCtAlEqHKa+24ksv/ZTgXibjWUwYOLE0V981SLD
	 LPlJhT+4TQ/0LpcMnylbUDOr11yIebnPnyLEA1TVUrZvl1MAvtWNm6y+AwZ5yJ4UJ9
	 4AE7nZw5f6iJyKQrq0lNZQJSlhP4a1TryDwjzLcYuNg+pMUNzQwIrdtY0ocACanoLN
	 ev+1aq89tMdEA==
Date: Fri, 3 Apr 2026 14:38:54 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: call ixgbe_setup_fc() before fc_enable()
 after NVM update
Message-ID: <20260403133854.GE113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-6-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275049-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 3E4813949D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:40AM +0100, Aleksandr Loktionov wrote:
> From: Radoslaw Tyl <radoslawx.tyl@intel.com>
> 
> During an NVM update the PHY reset clears the Technology Ability Field
> (IEEE 802.3 clause 37 register 7.10) back to hardware defaults.  When
> the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
> register is recalculated from the stale autonegotiated capability bits,
> which the MDD (Malicious Driver Detect) logic treats as an invalid
> change and halts traffic on the PF.
> 
> Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
> ixgbe_watchdog_update_link() so that flow-control autoneg and the
> PHY registers are re-programmed in the correct order after any reset.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This feels like a fix that should have a Fixes tag and be routed
via iwl-net. And some explanation of what effect this has on the user.

Otherwise, please reword the commit message to make it clear this
is not a bug fix.

...

