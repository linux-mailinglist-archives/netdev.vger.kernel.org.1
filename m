Return-Path: <netdev+bounces-274956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKa3OW+Dz2mwwwYAu9opvQ
	(envelope-from <netdev+bounces-274956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:07:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C387392962
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4F8930614ED
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C02C324D;
	Fri,  3 Apr 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSFZ6Rio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAFE382F36
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207162; cv=none; b=PA0G3OBLOOsCsjTqOJZYJbAy8YLILJ6jl9Y91EHxJtZwWxfFxgFQ9IUKjApgfDDTRtsPg6aoJGQuRmABSSZMNLyF4UVT6q5ae9UrmUkM5vZxNL9Zis4MVK24S83yEnrIYyflGlYsuHL9G3R9CTGTxFlJB4JhtGdIY+qTPk4ZvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207162; c=relaxed/simple;
	bh=H37DUjLxE6C6eoONgTSfZeAyzqq6kkHrKPV6bhnkF2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dam6ajz+EGlLhgNYrHAgnP+apVgT1ocBvszXJgUfpltYxSOaFpHzrHHLY1+1tCP45B7zSR7oBlZaKldTl2XyDEsSORXm2bDCba6zO3Ybg+Jmx4MatqrwWrFhf/uZqY1Sv09W7VFe3YVOY/TxybypPvGoOOlBwMK735+ImIp73jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSFZ6Rio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A37C4CEF7;
	Fri,  3 Apr 2026 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775207161;
	bh=H37DUjLxE6C6eoONgTSfZeAyzqq6kkHrKPV6bhnkF2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSFZ6RioqUNtlia0e/Of/j7QUkUyb4O/qRfeWhV8ykGNImr48SrcahC4ZeJqlAr57
	 9FKryywykEALF89c1k3PiREEZwHTQryaxCdlUN+zW68RfQd2QG2g4mR6VnsmjlsnEx
	 139E6IePR/LyF2cz7Id89COM/rfF0DyN3EJ0/tpKVsGcnqbTYINLwEFiddNhu13XLV
	 lyYUBJO7sztziRtVbrxIm4rpVD7w154UJhSAf2NaDUgu0vdn+qMXesDGVYhX4vSDZF
	 c94IdMpofJIAcJbE9k0/fJLcHlfm9C/0vWQnqFB0btfVZ3Zgzxd3qwDQ9qRXx++ciZ
	 H7AskzF5Nk1iA==
Date: Fri, 3 Apr 2026 10:05:58 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH net] ice: fix PTP Call Trace during PTP release
Message-ID: <20260403090558.GE11973@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-3-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274956-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 7C387392962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:23:26AM +0100, Aleksandr Loktionov wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> If a PF reset occurs when the PTP state is ICE_PTP_UNINIT, then
> ice_ptp_rebuild() will update the state to ICE_PTP_ERROR. This will
> result in the following PTP release call trace during driver unload:
> 
>     kernel BUG at lib/list_debug.c:52!
>     ice_ptp_release+0x332/0x3c0 [ice]
>     ice_deinit_features.part.0+0x10e/0x120 [ice]
>     ice_remove+0x100/0x220 [ice]
> 
> This was observed when passing PF1 through to a VM. ice_ptp_init()
> fails because ctrl_pf is NULL and sets the state to ICE_PTP_UNINIT.
> 
> Fix by detecting the ICE_PTP_UNINIT state in ice_ptp_rebuild() and
> returning without error, preventing the invalid state transition to
> ICE_PTP_ERROR. The only valid path to ICE_PTP_ERROR is from
> ICE_PTP_RESETTING after a failed rebuild.
> 
> Fixes: 8293e4cb2ff5 ("ice: introduce PTP state machine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


