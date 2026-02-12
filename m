Return-Path: <netdev+bounces-258503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Rt3cLbw9jmkMBQEAu9opvQ
	(envelope-from <netdev+bounces-258503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:53:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285D21310E4
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB2A302D5AB
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07442C324E;
	Thu, 12 Feb 2026 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML+Q0QqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C329A32D
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929591; cv=none; b=T7RoHntX0Jq5kXTZuXFZgSqqWJYJ/nKkL/2JXi0jOozrUT9MCNpbmcAC+FgszggZ883J0cfbP8WndlflHnB4U3ONfzgSCY0Okzw1lVoI894UOOzfVSM0CUJIkZtWF+ZgdiJGJmwoVrl/B72pThGDFMCZk5p601KN1bgoqemOLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929591; c=relaxed/simple;
	bh=iIYldWO1yWWolN4bbBuyPnJV93TUrrkg80C+Xk+0TG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5WFhW2K0yu5fA28di/s3GEJUd2IuZ6LVbsw05pCDVHXTC/kHywGtM2Fc6LvWCeAG4FI6H0xAaEPaH+SKn7ukkvKJH5OVUbNwBysht1S2Zw663yskaaO0ewDRrQL83to2jQRLU+Otu2y5qUoJrFEnRphN62W9jub+WqYazseeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML+Q0QqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BEDC4CEF7;
	Thu, 12 Feb 2026 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770929591;
	bh=iIYldWO1yWWolN4bbBuyPnJV93TUrrkg80C+Xk+0TG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ML+Q0QqQExCIEzt7Fb+XfoWE7sXr7uEQ2RqdkokUX7il/S+CSCfdRB3k/sQMUrHH1
	 m+vRPnrvgsty8IO9MCUPNz/DQ902Gwxty1eYKDmGHa9WpoZXNjoVexSfh52tOlOBZh
	 OubEyfYokGPMkr+kepYNT2l8stISbZJVW0TWhruWRAWivblb2GSqDCcTEJGZuqjtBN
	 kT0EG0lELKwdGPbk2czHkf009PosoKUKLMTAwhUcK2b3zXApEkTKxCgwIad/np1fCN
	 Pk6Xb5wHzl0G3cKH0j5iCFeb4otMKouIMKzBHqo43xa2QDTGLggZEdVGF3co5QoXN/
	 3Jhd990IAJcFg==
Date: Thu, 12 Feb 2026 20:53:08 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] libie: prevent memleak in fwlog code
Message-ID: <aY49tNkdtd48KLHq@horms.kernel.org>
References: <20260211091008.236185-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211091008.236185-1-michal.swiatkowski@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258503-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 285D21310E4
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:10:08AM +0100, Michal Swiatkowski wrote:
> All cmd_buf buffers are allocated and need to be freed after usage.
> Add an error unwinding path that properly frees these buffers.
> 
> The memory leak  happens whenever fwlog configuration is changed. For
> example:
> 
> $echo 256K > /sys/kernel/debug/ixgbe/0000\:32\:00.0/fwlog/log_size
> 
> Fixes: 96a9a9341cda ("ice: configure FW logging")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


