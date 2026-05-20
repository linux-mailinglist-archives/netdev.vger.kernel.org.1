Return-Path: <netdev+bounces-290059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLW3GawFDmp25gUAu9opvQ
	(envelope-from <netdev+bounces-290059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:04:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09B597AAE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EEBA2466C7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661763EAC82;
	Wed, 20 May 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxN/XarZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8763FF1A4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302374; cv=none; b=lryTKGJjDVfruxVQAMf/c5/NrbVsrXud60LA95qC/ZWikbBh/MrlP9nYrVuZgWwUpdvCR9GWN8UahXQX3VEo0BRAAKwpK0YzzRnV/gNQwB/LY9iNJJ7jGMOsh/cH9tgbpSQfv0UARncyOKEaojntz+QPySDxYR+Yd/4c3A/DPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302374; c=relaxed/simple;
	bh=6tdWWTJ11C7Sr+A1qPIzMojRq37VjC1M8vczAlblpLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INOYL2JZ+s65gP3vrTXsRyo8yoTjQhE7NqgHtxJkGHe6jfebqNTqhXovOoAF7zrg8GMH/ozzY7n+UB/2yVKQq1ajDQHTXaZgDHgWtVuqhoJWlk0ZfX34WCIzc+q86Pbv7WBCYmwLKZBx1zEy35IzJ54a8WIdqEEUiJOIHJy0KNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxN/XarZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD1E1F000E9;
	Wed, 20 May 2026 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302372;
	bh=z/6d4XDsP8kzqaS2wZT45uE1TsRr5QPcLiTvEq5CEp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YxN/XarZZPxmKvMiwPj489ukmgHFMGOrsVkFyl/ynf53vG7zGHp8ViqspWjlnRwOT
	 qoZdVQJz8txRV0T774UZaKnd5hwRT7vU0vqdmrz14YL9vA8jd6AaB1bGjxyP02Ldp3
	 reCYb+KUZC1vQwHD9lNqMSiW0OXxJDCmRRhN+elpD/K7mQg6OWyQRA612on5CptqmB
	 Bmxtl9XkF7bz+b6VQw8FbabVhCgmnDq9y/vGLPY4SNanC7lPwS8NYGyzP8Al8A8+T1
	 /BDmie27y2nPmVCftGN7zoyQyvio1+JS+pnu+cq4tL9xHAYLPVBNE/xo/30uUIT5Ka
	 2+Hlp3yw4HC1w==
Date: Wed, 20 May 2026 19:39:28 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH iwl-net v2] ice: suppress DPLL errors during reset
 recovery
Message-ID: <20260520183928.GF988238@horms.kernel.org>
References: <20260520115213.10864-2-przemyslaw.korba@intel.com>
 <20260520183801.GE988238@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520183801.GE988238@horms.kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: BC09B597AAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 07:38:05PM +0100, Simon Horman wrote:
> On Wed, May 20, 2026 at 01:50:06PM +0200, Przemyslaw Korba wrote:
> > During reset recovery, the admin queue returns EBUSY which is expected
> > behavior. However, the DPLL subsystem was logging these as errors and
> > incrementing the error counter, potentially leading to unnecessary
> > warnings and even disabling the DPLL periodic worker if the threshold
> > was reached.
> > 
> > Suppress error logging and error counter increments when the admin
> > queue returns EBUSY, as this is expected during reset recovery and
> > not a real failure condition.
> > 
> > test case:
> > - ethtool --reset eth3 irq-shared dma-shared filter-shared offload-shared
> > mac-shared phy-shared ram-shared
> > - observe if dmesg EBUSY errors are gone
> > 
> > Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> > Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> > ---
> > v2:
> > add missing EBUSY check in ice_dpll_pps_update_phase_offsets()
> > v1:
> > https://lore.kernel.org/intel-wired-lan/20260520105311.5336-1-przemyslaw.korba@intel.com/T/#u
> 
> Thanks for the update.

Sorry, hit send too soon.
I meant to also include:

Reviewed-by: Simon Horman <horms@kernel.org>


