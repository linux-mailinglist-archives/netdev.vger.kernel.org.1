Return-Path: <netdev+bounces-279856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GRUIZFZ5mnGvAEAu9opvQ
	(envelope-from <netdev+bounces-279856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EB4301B9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56EAE3231E7C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B38332EB1;
	Mon, 20 Apr 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx9PmYZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12076331A77
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699615; cv=none; b=jW2OKrnTxPSl8peJMcr9AhuCaO4OexnB5Ww4nJ/5IPn2/PbD5szYR8dk/QTqVCStjiEXBc40C11lx4yPYoShR65oyEPGPuoiF44+6MlvYYpx3yipUbJQ6fTISFWlFvfu1wPeasz17Feb7R7bCFiZgZXs4pgtFSnb2r9Vl7VxD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699615; c=relaxed/simple;
	bh=+DeC3NJ9949CsEjMNzlTZbIE2sxqoybq0YGyXABSEXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3g37rtZk/13SecJn3UMXmjzk1cQYMwZ3/2vYbte5C9axxBp5dGisS7t5HxpgJIthTkqgfK3ug467WbcGF0IVNGK8fYPsRHB2btQXsl3RMvF14Vp39QHBB4YPEy/6a5/7ide2mphQOkI86V6E1ywZy80QfcVJWD2mcnBYvVqjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx9PmYZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC70C19425;
	Mon, 20 Apr 2026 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699614;
	bh=+DeC3NJ9949CsEjMNzlTZbIE2sxqoybq0YGyXABSEXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sx9PmYZBn+xekVj3wilMLpVG2kR/QHchoIukIJWWhTK6RklK+XBbfbhtzfDxtFW3c
	 kAtYRDQQyBR+iLTk3yGSPjjlVkzjTndg/4EfQ9TrskYptv/GHvoSoJl7awGTdZ4L3P
	 M3gSFU5zLYAN87YyriBPUjkrf0uVNcwon/fm8A3PQ1ZrpUeHmzIR+2EkuPKO4s3JBA
	 IG0VuX3sZNqLQDMOdjw9oDUecCANPYV6uxOFcP6sn/v6QYpFOXqs9HaGFQf2NV6dWM
	 v35u2GWBfLOUJj8edot6n5JW6jvmT2qW/7kAkm5hAPZmcI9ioAp/XGWWW37RwHS7TE
	 E5Vm/5tuasWGQ==
Date: Mon, 20 Apr 2026 16:40:10 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Tomasz Lichwala <tomasz.lichwala@intel.com>
Subject: Re: [PATCH iwl-net 1/4] ice: fix asymmetric pause negotiation
 reporting in ethtool
Message-ID: <20260420154010.GS280379@horms.kernel.org>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
 <20260417062954.1241900-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417062954.1241900-2-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279856-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 863EB4301B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 08:29:51AM +0200, Aleksandr Loktionov wrote:
> From: Tomasz Lichwala <tomasz.lichwala@intel.com>
> 
> Add Asym_Pause to the supported link modes so that asymmetric pause
> negotiation is properly reported via ethtool. Without Asym_Pause in
> the supported modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
> for asymmetric pause configurations, even when pause is properly
> negotiated and functional at the hardware level.
> 
> Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


