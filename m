Return-Path: <netdev+bounces-275039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD7sDEe+z2nd0AYAu9opvQ
	(envelope-from <netdev+bounces-275039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:19:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A633945EF
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BA9A30158B1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDAB296BCB;
	Fri,  3 Apr 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q11as0GM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87616A001
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222340; cv=none; b=B8L4XVmtoytiCp2MtTjX+S1UgP6dLbCrZealf2JwN8baY89h3RqjLnT7f6rtVoAXv6+JNFn13MN0x7ToBL11Jg9rc8ActMcfo5PNoWDbZNL+liDEe53g7JeA4DjA+T3FSTbQyI4lar1z8deNk49KYt+Skn6Dn2RLURH4MOYa69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222340; c=relaxed/simple;
	bh=g1nTip99Zbu1z+sH7Y5JE6BpjHLM/Tk8483oMhcrWfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZeJReBnYMlzObpwsL66E0/wqN3YyW+yw8R7T4SBG/Y11/qZMZT3Lr3Vy1DADJY47mTQtq1iF/kJlohRuNYxqUEGo8bjIossuSX7LRLRpHCjMIweIg8UtOtEZigY1DK4LBvwQ4sNF4SgNjPgj7ytEQisOwYV1mK1YLnGMKBTHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q11as0GM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C51C4CEF7;
	Fri,  3 Apr 2026 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775222340;
	bh=g1nTip99Zbu1z+sH7Y5JE6BpjHLM/Tk8483oMhcrWfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q11as0GMEFuBHP7c3Dwe7+zIKVYzMkaVTZFyDG+S69gQdGy5h1R56b16cJhMQoqJG
	 jaM7BXrymI93BiW1rJ+apAo7EaNXEpAq9yUR1FXpAOEZUAlec1NXmk9nN3aptwe0pi
	 TzqRlg/VaV0V8/w11pWVkpeAUf0RVrIvJ8xSeYS+8qKS3YIjiu/NFaCtDDeTV58JDF
	 E4d63yTaLQsLlcB31PpN32w5E7Gs8jM3Eq85xDYmeR88V1W4uS9y1+Y9K9kFivtrTa
	 LuDP/jz6LGyGzW3A3X+b4V0lUMeXGcwATIyhEboOForoPL3XGAFYxI9qFq80JUL4ic
	 5dCogCWmFlg9Q==
Date: Fri, 3 Apr 2026 14:18:57 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: fix ITR value overflow in adaptive
 interrupt throttling
Message-ID: <20260403131857.GB113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-11-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-11-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275039-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 95A633945EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:45AM +0100, Aleksandr Loktionov wrote:
> ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
> and a usecs delay (bits [6:0]) into an unsigned int, then stores it in
> ring_container->itr which is u8.  Values above 0xFF wrap, corrupting both
> the delay and the mode-flag on the next readback.
> 
> Separate the mode bits from the usecs sub-field; clamp only the latter to
> [0, IXGBE_ITR_ADAPTIVE_LATENCY - 1] via min_t(unsigned int, ...) so
> overflow cannot bleed into bit 7.  Add a WARN_ONCE() when the raw usecs
> value exceeds U8_MAX so out-of-range ITR computations are visible in
> dmesg during development and testing.
> 
> Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Somehow - perhaps because there is no m/n notation present in the [] in the
subject - Patchwork has treated each patch in this series as it's own
patch-set.

And in the case of this patch, it didn't apply - I assume
because in order to do so an earlier patch in the series
needs to be present.

So CI didn't run on this patch :(

