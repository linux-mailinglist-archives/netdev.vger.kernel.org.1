Return-Path: <netdev+bounces-278546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II05FGV33mmsEgAAu9opvQ
	(envelope-from <netdev+bounces-278546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:20:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21D3FD013
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4271730A6EB9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D33ECBDE;
	Tue, 14 Apr 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqJi3uzP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BD3E0C4E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186994; cv=none; b=KfsqwDLeKr7Vn8aJbT24WT1LJkXlM4R4Ka8vSem3kRKolgCasWNrjMEmsJJRQvn2eCSlPEyzfdmEpATUQF4BEf1Hk1bXD+iB+Hec7Y1shYlhtkkFMxPeYO9wXgGsgjfVTu973rP1IzCEuZjr+CHmHaLVqY80FhgLlsYyVMn4Q8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186994; c=relaxed/simple;
	bh=YglCd9xnuRc5fVSgrwjKGLYx/Zqhu1YuloxrREYHN98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSOfceTy0Lbc3x8m/TjKFDV41EWBkBmdPLgcyMzdZziO+deG1i1IcirNjpgnuw0gFjhEaQPjXa80bphvEjz2DztTHPSwwTorHNnSkR+z9+yLqj2DA+Oe9Z127fJ0uN1VQhHIvVDe63EdjUV1oWjHvGZmQfgU6xoYLDBuWYsOWC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqJi3uzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433ACC19425;
	Tue, 14 Apr 2026 17:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186994;
	bh=YglCd9xnuRc5fVSgrwjKGLYx/Zqhu1YuloxrREYHN98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqJi3uzPfg8O/OIubAf/jG0KpIY5PG8BorLO55teIT3h8Ol1Wm9gA8o2dub7pdIiz
	 kKW2f9iZugbrw7OumA1v01sV16LJsEBkhevAZ6X8NCtgbdB9pCRL+YajrcSiVTuAxi
	 xB2A+0TVCW8J7/XFAaeEMizpQiUoTQZ28fShibOPArFq5feMVCp7RPTtFIB7FvyJk7
	 GStBouimnx8nG5q67mQV5LpSCAIl8OlvmK0cal9jx7uFRVBVcG255g8asQWr+ba3W6
	 EuINzZocNLYJVFqHId80Gtq+YJI24BMThCu5TPK3W89Vads5nlgQ/ryW2EGfKzSHHK
	 wNG6Xr47OioLQ==
Date: Tue, 14 Apr 2026 18:16:30 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/6] ixgbe: add bounds check
 for debugfs register access
Message-ID: <20260414171630.GA772670@horms.kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-3-aleksandr.loktionov@intel.com>
 <20260413103050.GL469338@kernel.org>
 <dda1f0f3-f57b-418a-93e6-2cdaa1d2ef35@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda1f0f3-f57b-418a-93e6-2cdaa1d2ef35@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278546-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,intel.com:email]
X-Rspamd-Queue-Id: AB21D3FD013
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 06:00:28PM -0700, Jacob Keller wrote:
> On 4/13/2026 3:30 AM, Simon Horman wrote:
> > On Wed, Apr 08, 2026 at 03:11:50PM +0200, Aleksandr Loktionov wrote:
> >> From: Paul Greenwalt <paul.greenwalt@intel.com>
> >>
> >> Prevent out-of-bounds MMIO accesses triggered through user-controlled
> >> register offsets.  IXGBE_HFDR (0x15FE8) is the highest valid MMIO
> >> register in the ixgbe register map; any offset beyond it would address
> >> unmapped memory.
> >>
> >> Add a defense-in-depth check at two levels:
> >>
> >> 1. ixgbe_read_reg() -- the noinline register read accessor.  A
> >>    WARN_ON_ONCE() guard here catches any future code path (including
> >>    ioctl extensions) that might inadvertently pass an out-of-range
> >>    offset without relying on higher layers to catch it first.
> >>    ixgbe_write_reg() is a static inline called from the TX/RX hot path;
> >>    adding WARN_ON_ONCE there would inline the check at every call site,
> >>    so only the read path gets this guard.
> >>
> >> 2. ixgbe_dbg_reg_ops_write() -- the debugfs 'reg_ops' interface is the
> >>    only current path where a raw, user-supplied offset enters the driver.
> >>    Gating it before invoking the register accessors provides a clean,
> >>    user-visible failure (silent ignore with no kernel splat) for
> >>    deliberately malformed debugfs writes.
> >>
> >> Add a reg <= IXGBE_HFDR guard to both the read and write paths in
> >> ixgbe_dbg_reg_ops_write(), and a WARN_ON_ONCE + early-return guard to
> >> ixgbe_read_reg().
> >>
> >> Fixes: 91fbd8f081e2 ("ixgbe: added reg_ops file to debugfs")
> >> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >> ---
> >> v1 -> v2:
> >>  - Add Fixes: tag; reroute from iwl-next to iwl-net (security-relevant
> >>    hardening for user-controllable out-of-bounds MMIO).
> > 
> > Thanks for the update.
> > 
> > And sorry for not thinking to ask this earlier: this patch
> > addresses possible overruns of the mapped address space if the
> > supplied value for reg is too large. But do we also need a
> > guard against underrun if the value for reg is too small?
> > 
> 
> I don't think so. This is bounds checking a register offset which is an
> unsigned 32-bit value and begins at 0, so the map goes from 0 to
> IXGBE_HFDR. Since the value is unsigned, if it does underflow somehow it
> would then get caught by the check for IXGBE_HFDR right?

If the entire range from 0 to IXGBE_HFDR is mapped,
and it's ok for reg to have any value in that range,
then I agree there is no problem here.

Reviewed-by: Simon Horman <horms@kernel.org>


