Return-Path: <netdev+bounces-290052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O5ZIcIaDmpT6AUAu9opvQ
	(envelope-from <netdev+bounces-290052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBC599C66
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E852132515A1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6E3F9F2D;
	Wed, 20 May 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPy9Gp62"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9C3F39EE
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302287; cv=none; b=DwHe4ni2DDW09iyIrqx1Rq9cpVRXFieMeW7oJtKpoJUJ31eA0HCS/doJGr74HqzI38299ePfl/C4q+OB5ER8coXoSZ78nssF4AU8A3Km90kVkqadFfWfZKDVGWvu/4WCeJDxVDgsDY8PruFf7NvqqTv2ANDaHjsdBabNpkMbkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302287; c=relaxed/simple;
	bh=oiDmDzRlvpUWP3j3IZra960yjAD9qjRZTM8+sInDwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqr+9JgPAwG41hudKoi3rShJfc9g0sedrsPufWOE0Ks960ByQsn+T/220/5OAxzRC7hhTYmH9cwHRmOhr/s/0/vZhKG8blNLYuWiSWbyufFi/D4WUiIG/4yrIkHSA6JM/ICXQkKOZCQNUY6NsbSCEhtf1nRheX38TEOQ007v3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPy9Gp62; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D661F000E9;
	Wed, 20 May 2026 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302285;
	bh=Vli160Be25ufAg5UH9YxzHJ/rgEgzlQQ8hmf32U8RDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPy9Gp62SyYkWC9q0Pwf85qOMAwbN/7sf54xlrfeKS+OI32FRNd2lllcORwt35a1o
	 qzdB3Le0JFXjqfMBrhuZ97JU5avCMKa+K287iMNzRZEzgFKvi1V8lkqC3BT+ODgqlF
	 mDjzpe3Ts9qU7WtysPE8G/6dLi/DqV7OLXxYNz/VrbxHC+QItZUhC5neBwxswCAZcC
	 3dUbtQ4hhaivh7OwosRe/zoqxoeTgXf6KxwGiCYQhKzS0k0U/OB5hnUmGvIAD1446P
	 Y3/M+UDIdYre6x1qW5nSDZHsrExexnJXP+BBnqHubQTVfJA/P2xC6jYchmveLSB7rB
	 z6SKBWLsaoNEQ==
Date: Wed, 20 May 2026 19:38:01 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH iwl-net v2] ice: suppress DPLL errors during reset
 recovery
Message-ID: <20260520183801.GE988238@horms.kernel.org>
References: <20260520115213.10864-2-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520115213.10864-2-przemyslaw.korba@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 93BBC599C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 01:50:06PM +0200, Przemyslaw Korba wrote:
> During reset recovery, the admin queue returns EBUSY which is expected
> behavior. However, the DPLL subsystem was logging these as errors and
> incrementing the error counter, potentially leading to unnecessary
> warnings and even disabling the DPLL periodic worker if the threshold
> was reached.
> 
> Suppress error logging and error counter increments when the admin
> queue returns EBUSY, as this is expected during reset recovery and
> not a real failure condition.
> 
> test case:
> - ethtool --reset eth3 irq-shared dma-shared filter-shared offload-shared
> mac-shared phy-shared ram-shared
> - observe if dmesg EBUSY errors are gone
> 
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> add missing EBUSY check in ice_dpll_pps_update_phase_offsets()
> v1:
> https://lore.kernel.org/intel-wired-lan/20260520105311.5336-1-przemyslaw.korba@intel.com/T/#u

Thanks for the update.

