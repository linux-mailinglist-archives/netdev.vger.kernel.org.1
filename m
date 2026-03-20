Return-Path: <netdev+bounces-270049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHdTFzSlvWm4/wIAu9opvQ
	(envelope-from <netdev+bounces-270049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:51:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26AC2E07EE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE2B330C3F99
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67023542E2;
	Fri, 20 Mar 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHIZqIOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE03537FA
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035607; cv=none; b=FlNH2EY+3GD85Cwj1AOId3aGox4zr2r2V0LKi5W//Iz//r4JyqlJj5HqbXRly/iT5ILbk+6mhR/2ucpFv6c5stcfPSyrk94NegUTlgXDWWA6dRcwEdCVAvqRxP31P+3Lua/VvMB/bUeTsLBtdoMbW4po1xAZXwOrHv8vImxy3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035607; c=relaxed/simple;
	bh=BElYQCOMS5gjg9+VJTxM1lxF+ObjxENjnmmyLhWjFo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSYa5d4DGw+i7uJNYYF41uj7olP0hKYaaFUfkUNvuQRUNOBxXANRR8/YNG9q5g2Zqvbw0T6hkN9aRFKbpKkmNFz+/FTlmoIsqK8/6MD2VKAAsgcmkOMFBFyROnOtXx/zWXMfcRxHIvzHF8iq+JmHdI5UpZJkLSsIT6U3ntUKvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHIZqIOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3426CC2BC87;
	Fri, 20 Mar 2026 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035607;
	bh=BElYQCOMS5gjg9+VJTxM1lxF+ObjxENjnmmyLhWjFo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHIZqIOfmwBDxURmytwI1Y7iXepYKUDvX25V4lqNbQG2kLaqEZHAtcLIBrl0d5UnK
	 cLOD3XlQZvOjMCDD/v6/wCtTjLBvNP+FKorGIN7QEKzeKVmUXjafqattrhjvsko43q
	 r9bc9pbs37XCa7xOqftilMFMDSB0R7xiYwyfasJJfuQQj7XxXAVrHqiWBFHYVojHKR
	 N3IcmeooU2sY0An9BBUUcfV5Nox/xoR50Zw7F5OYv5c9SMqinLY2XWgIwiBYJnfT3n
	 LlmepAJN9eIYpizmzEp5vbiGMbfTYpakt4WNrbPKlfWcajbFSmMRdZJTFFe8/WU+2U
	 KTL4BAZD6F6VA==
Date: Fri, 20 Mar 2026 19:40:02 +0000
From: Simon Horman <horms@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v8 6/6] selftests: net: add TLS hardware offload test
Message-ID: <20260320194002.GI74886@horms.kernel.org>
References: <20260319213323.235559-1-rjethwani@purestorage.com>
 <20260319213323.235559-7-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319213323.235559-7-rjethwani@purestorage.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C26AC2E07EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 03:33:23PM -0600, Rishikesh Jethwani wrote:
> Two-node kTLS hardware offload test using NetDrvEpEnv. Tests TLS
> 1.2/1.3 with AES-GCM-128/256, rekey operations, and various buffer
> sizes.
> 
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   2 +
>  .../selftests/drivers/net/hw/tls_hw_offload.c | 902 ++++++++++++++++++
>  .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
>  3 files changed, 1185 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
>  create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index a64140333a46..6b12b0920cae 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -15,6 +15,7 @@ endif
>  
>  TEST_GEN_FILES := \
>  	$(COND_GEN_FILES) \
> +	tls_hw_offload \
>  # end of TEST_GEN_FILES

Hi Rishikesh,

I think you need to add tls_hw_offload to
tools/testing/selftests/drivers/net/hw/.gitignore

...

