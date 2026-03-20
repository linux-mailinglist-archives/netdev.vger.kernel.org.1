Return-Path: <netdev+bounces-270059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJqpN3CpvWkAAAMAu9opvQ
	(envelope-from <netdev+bounces-270059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:09:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1E2E0BEC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A537B3004DA9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF93BADBA;
	Fri, 20 Mar 2026 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLd5wO0K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834A38F23D
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774037339; cv=none; b=rW8BDuqDMuQqxKhzLJ6KSfFYV+utDtmNaP7lZf2sJ7HawwdTkEyifq48fUqgS1r/v6SvOQSs1V9ZLR1CMt7ZlDvBOpzaRCPfiK/pmM1jpg5lV74Mx5go0MolNOODzt7PH4lNgnuNvqrYG2COBtBM/xgavHRB4jMuDEK8Ihn+sWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774037339; c=relaxed/simple;
	bh=m6LT0aN+/E9/S9hT8eBDG6yPYtLtpFcuVjjFa5Ig2Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU84ZO13HKUhZhSccZYasgsd6A+uL4Ipu9/LRaKSlaoCEgBcA4L/oQSvMuDRrg4iNeJr41ereXEwbberuXXCN6TX85EO6yQ02Ca3LH8ePUuu1L5ZBP30664lUkgVrDxYhlgMysZVrckDGTA0eoQGnz/fZNLwU/K2Ys9UJq2kfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLd5wO0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D31C4CEF7;
	Fri, 20 Mar 2026 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774037338;
	bh=m6LT0aN+/E9/S9hT8eBDG6yPYtLtpFcuVjjFa5Ig2Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLd5wO0KaUbxcNY1MaWGhpdnHu4C8b6nErXOfL7MA7NfKqYjIcK9mGwHKhVKQQc77
	 Af3arZuOSWxUcAqB6ZQuKHQlGLx32lDQfxWOGe1bLxuM3P65l1Td63u33ThseOvEth
	 2BHMNu1CPbP0ZsM82OJZbtmKFiwbfI6S1Fg43JGOxKsLwnxnf+7qEDg7lfAelcbH2Z
	 G3h6UoLC+HEqu7brFhMxtvezUZOnFF3y7SEv530FM+vwt1ASBAcE1OHMAWaVr5M7x2
	 z4JkHV2t3xAIWdCtOlhp7d9NuWLHhc6bH/wwxfpzBMBTnWKhXL49jAH3GgOxdOmdxe
	 8h3pS5NmnM8cA==
Date: Fri, 20 Mar 2026 20:08:54 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v1] ice: fix LLDP AQ filter fallback not working on
 E82x and E830 hardware
Message-ID: <20260320200854.GN74886@horms.kernel.org>
References: <20260320051034.425089-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320051034.425089-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270059-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid,intel.com:email]
X-Rspamd-Queue-Id: EAF1E2E0BEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:10:34AM +0100, Aleksandr Loktionov wrote:
> Commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary") restructured ice_vsi_cfg_sw_lldp() to first attempt a
> generic ethernet Rx filter and, on failure, fall back to the specialized
> LLDP filter control AQ command (0x0A0A) via ice_lldp_fltr_add_remove().
> This fallback is gated by ice_fw_supports_lldp_fltr_ctrl(), which only
> accepted E810, causing two distinct omissions.
> 
> E82x (ICE_MAC_GENERIC, e.g. E822/E823) support the same LLDP filter
> control AQ command with the same minimum firmware API version as E810
> (>= 1.7.1). On E82x systems where the generic ethernet LLDP Rx filter
> cannot be added, the AQ fallback silently returns -EOPNOTSUPP and the
> port is left with no LLDP Rx filter.
> 
> E830 has been supported since kernel 6.9 and implements the same AQ
> command but requires a higher minimum API version (>= 1.7.11). Starting
> with NVM 1.2 / FW 7.9.1, the generic ethernet LLDP Rx filter path is
> blocked on E830, making the AQ fallback the only viable option. With
> ice_fw_supports_lldp_fltr_ctrl() returning false for E830, no LLDP Rx
> filter is installed after a firmware-update-triggered reset (e.g. NVM
> 1.1->1.2 on an E830-CC in HPE DL380 Gen11), and the interface stays
> link-down with complete loss of network connectivity.
> 
> Replace the single-type if-chain with a switch on hw->mac_type so each
> family's version requirement is explicit. E810 and E82x share the 1.7.1
> constants; E830 gets its own 1.7.11 constants. The default branch returns
> false, covering any future MAC type that does not implement the command.
> 
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


