Return-Path: <netdev+bounces-287237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMGsGUVdA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:03:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2D52559B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D3130B735A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3483C8C73;
	Tue, 12 May 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HssJZg38"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292763C8C56
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604733; cv=none; b=JCxvdyaDzayhct2ZEcqmjIJmV8VYSlgLtX3BR290cvMwPXhplNYC0d38gxUP2bnQ2cNZm7zLN1Ktn7dLmHw5Zb1R/q1OgAfDQBVwvPNorSJ0KxOQlIGNjF+W7fLAFXEq5xVmU6qhWN1Ce+XOWdzwHJXRIHevHkn4p1ZVGu3lJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604733; c=relaxed/simple;
	bh=uMkUDHv26fadIJfwxhlXn+Q0B6/mz2BnhUKt8UxkY80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8EPkWYLAvxumWkTpFdF4I/VOYCc7jBIXymrnqDankSXuDUEqtR4VQEUuwrC4OxpQE/W8EmpQ69KaJSe0FxQcB3Zqs0Mye83iOaqrc4Y3Z1U/qwMi5oPnOI/1/Yv4mbbF9NAeWooqqXPpYBfNa8HoMbqTb2Jm51uwi0pfqqK4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HssJZg38; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778604732; x=1810140732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMkUDHv26fadIJfwxhlXn+Q0B6/mz2BnhUKt8UxkY80=;
  b=HssJZg387A8meNKvWxIvos9hmaMOnPdBE8QjlMsl5ozV07G2CrtWQswM
   VS4xfVZ9/wQFGpXsXJ6RJG0ed+kVVTgzCSUmqRrP3TdGCgZ/hV8jGeMVz
   t3eL/rFKiaex2LXs8QIpJHwdiQYTQmPZJIYl4BVGnWGCNMWnleyz1Ouhw
   6xWg0RW5XAxCbKfwsaoIHz1s0aAK7ZKk4Hpt4/f6Yu7rJnygHeIZGU3Wy
   T0vOuCuDKbPYQ2c2OCAhTzTzYKw+lZU7Ae7PI5efdx/iCEF7hlccBNz7o
   dA+SrJI9k8gk3THQTb8R2Kq7/f/VBb8p1PycYtlOvR+EvtMXLQYk6B1J9
   A==;
X-CSE-ConnectionGUID: zQzf8CNWSq2mgebIqY/LDQ==
X-CSE-MsgGUID: tx5MwK3HStW0A2A2quw56Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83392654"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83392654"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:52:11 -0700
X-CSE-ConnectionGUID: mdXamUsESZybcZORmnVW8A==
X-CSE-MsgGUID: 7WKw3oElQ361cW01f6HeUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237911691"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:52:06 -0700
Date: Tue, 12 May 2026 18:52:03 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
	kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	maarten@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com, soham.purkait@intel.com,
	anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v1 09/11] drm/xe/ras: Set error threshold support
Message-ID: <agNasxWroK70Z_Jg@black.igk.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-10-raag.jadav@intel.com>
 <5e90b9aa-9432-43b5-ae40-1fce383bb043@intel.com>
 <agM8ynv2w-iqsp-O@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agM8ynv2w-iqsp-O@black.igk.intel.com>
X-Rspamd-Queue-Id: B5C2D52559B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-287237-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,black.igk.intel.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:44:34PM +0200, Raag Jadav wrote:
> On Mon, May 11, 2026 at 10:51:38PM +0530, Tauro, Riana wrote:
> > On 4/18/2026 2:46 AM, Raag Jadav wrote:
> > > System controller allows programming per error threshold value, which
> > > it uses to raise error events to the driver. Set it using mailbox
> > > command so that it can be programmed by the user.

...

> > > +	if (response.status) {
> > > +		xe_err(xe, "sysctrl: set threshold operation failed %#x\n", response.status);
> > 
> > Status should be converted to visible error codes. check [PATCH v5 3/6]
> > drm/xe/xe_ras: Add helper to clear error counter - Riana Tauro
> > 
> > <https://lore.kernel.org/intel-xe/20260504065614.3832331-11-riana.tauro@intel.com/>
> 
> Coming right up.

So I went through this and I'm wondering if these would be applicable
for non-RAS mailbox users as well? In that case should they be part
of sysctrl code?

Raag

