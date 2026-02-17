Return-Path: <netdev+bounces-259089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBFdKECVlGnNFgIAu9opvQ
	(envelope-from <netdev+bounces-259089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:20:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB0714E0AC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F83302F242
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495836D513;
	Tue, 17 Feb 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsIMRWr0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F131D618A;
	Tue, 17 Feb 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345213; cv=none; b=ZXvfCdn2T0sJgjf9CSCJ40rUKJKlWtKtoxWNjASl4SBei8ZtIKcLJY07EEo3LergC5xgXvCF7/Zl+iMY7goTAMj2c4oQddgBOXLqta+Glbnej1+lOt+oe3AoNpm8PMbhKWh1Sxn80WpQB1YprzJULVjHcneIviFd6AkyQ57yVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345213; c=relaxed/simple;
	bh=9hY5pUyrY2xeg3LvsbtSBqFtfEGz/QkUpu1tq1h/nuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el67kwl2O3GeRi42J31l0cmon6xBjhpfIFvw3CG8JUQQ8XnknNtMp9tqwqrm2NcMrX4fDYQAZVxcvNw7Oi+Ws323R6bmprgXAJtpGsot4nmatnN2wVvUAXjqBY+bCvkx7EIitiHMBtU/jCiWDasOoGtXtBGc4Ur9fsXOS3oP1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsIMRWr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EB0C4CEF7;
	Tue, 17 Feb 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771345212;
	bh=9hY5pUyrY2xeg3LvsbtSBqFtfEGz/QkUpu1tq1h/nuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsIMRWr0NLekYrsnqsYs/zzl24Q6WhF4xUSG06NnwYBAxrJOtbXIwX6ttUHFBAlTd
	 5BRvTkdBHQXtFy14kENlsue9MBdQfRcRiUfRF8e8ugMb8ThOXMHKgTj5rtcpl25zqo
	 VH5jzz/cSf8S1vvy6+EV8xjCR/Ft+0U8qbrfHZCZdT1cN2/Mxnm+YMun/2zW3wA+E0
	 aVTKduOEkWyg/Vpn+Tp3UwkA5DTTXvTyVEPRUtuFbbBJKxouznBd9r75bcWFyTqtt1
	 BhNdDPNWE68Al8YhGQLSZrZ3xB+O21a149Zjw7LRdcKpo1VmFPCdeJ+WZhteD9+Z0L
	 9/xXVEv2W9CRQ==
Date: Tue, 17 Feb 2026 16:20:08 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Oros <poros@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: zl3073x: Fix ref frequency setting
Message-ID: <aZSVOPmEGy31iDxd@horms.kernel.org>
References: <20260216194007.680416-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216194007.680416-1-ivecera@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 0BB0714E0AC
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 08:40:07PM +0100, Ivan Vecera wrote:
> The frequency for an input reference is computed as:
> 
>   frequency = freq_base * freq_mult * freq_ratio_m / freq_ratio_n
> 
> Before commit 5bc02b190a3fb ("dpll: zl3073x: Cache all reference
> properties in zl3073x_ref"), zl3073x_dpll_input_pin_frequency_set()
> explicitly wrote 1 to both the REF_RATIO_M and REF_RATIO_N hardware
> registers whenever a new frequency was set. This ensured the FEC ratio
> was always reset to 1:1 alongside the new base/multiplier values.
> 
> The refactoring in that commit introduced zl3073x_ref_freq_set() to
> update the cached ref state, but this helper only sets freq_base and
> freq_mult without resetting freq_ratio_m and freq_ratio_n to 1. Because
> zl3073x_ref_state_set() uses a compare-and-write strategy, unchanged
> ratio fields are never written to the hardware. If the device previously
> had non-unity FEC ratio values, they remain in effect after a frequency
> change, resulting in an incorrect computed frequency.
> 
> Explicitly set freq_ratio_m and freq_ratio_n to 1 in zl3073x_ref_freq_set()
> to restore the original behavior.
> 
> Fixes: 5bc02b190a3fb ("dpll: zl3073x: Cache all reference properties in zl3073x_ref")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

