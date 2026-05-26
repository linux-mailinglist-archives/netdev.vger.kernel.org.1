Return-Path: <netdev+bounces-291833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFPKJ9vWFWrRcwcAu9opvQ
	(envelope-from <netdev+bounces-291833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:22:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DF5DA91A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD9B30A0EA6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8730402BAA;
	Tue, 26 May 2026 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L74nACt4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FD38E5D7
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815207; cv=none; b=r9npOOv6skXBoU1Y+u4P/Mu04abQVb230Vjv1E5+NSA3UpmzXKyoBWAP7BhCj2RFs70ahTVQ3KJ7g/nJYITgHwLhwb4W9+Tj36CERJb/dFABiseSoZ/auJk0lJ5O7Cwx3SMqWNHMn0YCa3/6VZI//ugtVNLG4LO9wFTtfKehfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815207; c=relaxed/simple;
	bh=5uI+TZfmbe+zgoA46MydWQGF/tG9ydpeVZNef3lT8pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMI0Ndke4C9ZhGdkfNsroOC/BfL4DkfzccFblF4yHV2bfqWe6ACgdTIDjWBHPToJlBg29wf37u5/cCpK0Fp7cbqbT+pKMtNcWChBEOvY7ZKfif+AVaNaRjUoHCdWxSu0Wre+hWWt/O4xHUN4SfItQGI1r1GERjZUCWv8JzcVQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L74nACt4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B761F000E9;
	Tue, 26 May 2026 17:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815206;
	bh=n11Yvwqz+rqZT/ZKP/UpHkRhFhWQS/84ypYO7E9okBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L74nACt4vDpTQ1KQExp061+LDxI5s2krwDeWN78xNPBref7J6thsPR6qAf/5kO7kt
	 aATz9hKovOTTaQ18g359htOPn+NvTMcKe5Zj7+Y4riJ69VD2G5Zj0I+y73i/kw4i/c
	 I1B7rE1i/SG/cTjLHasSy0Uzvlwvq2z4UY3abPM/aXqwNXeHtr2ju1RDb8oYLuPY7k
	 zZwRWW/x5tGsL/Zyr7yFBhWodkABOjqWKrcCAZNPHeww9UtJxMcygKVOv9u0ILCaeb
	 9XlGnd7Nt8g5V8n8mUkISvrfIsxvK12QrFfWvhkw3c192PUHaABUUg1qxhUeOPH6DQ
	 8iCfyYm8QmLWw==
Date: Tue, 26 May 2026 18:06:42 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH iwl-net v3] ice: support SBQ posted writes with
 non-posted support for CGU
Message-ID: <20260526170642.GA2256768@horms.kernel.org>
References: <20260520105311.5336-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520105311.5336-1-przemyslaw.korba@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-291833-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 0B1DF5DA91A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:52:03PM +0200, Przemyslaw Korba wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Sideband queue (SBQ) is a HW queue with very short completion time. All
> SBQ writes were posted by default, which means that the driver did not
> have to wait for completion from the neighbor device, because there was
> none. This introduced unnecessary delays, where only those delays were
> "ensuring" that the command is "completed" and this was a potential race
> condition.
> 
> Add the possibility to perform non-posted writes where it's necessary to
> wait for completion, instead of relying on fake completion from the FW,
> where only the delays are guarding the writes.
> 
> Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
> command to ensure that writes to all PHYs were completed and skip SBQ
> message completion if it's posted.
> 
> E810 only supports opcode 0x01, but its FW always sends completion
> responses for this opcode, so the driver waits for each write to complete.
> This makes E810 writes synchronous and eliminates the need for SBQ flush.
> 
> To analyze if delays are gone, look for and compare time spent in
> ice_sq_send_cmd — posted writes should return immediately after the wr32.
> That can be done for example by adjusting phc time with phc_ctl on E830
> device, for less than 2 seconds to use this new mechanism. Without it,
> command below will fail.
> 
> Reproduction steps:
> phc_ctl eth13 adj 1
> phc_ctl[4478170.994]: adjusted clock by 1.000000 seconds
> 
> Check trace for timing for comparisions:
> echo ice_sbq_send_cmd > /sys/kernel/debug/tracing/set_ftrace_filter
> echo function_graph > /sys/kernel/debug/tracing/current_tracer
> cat /sys/kernel/debug/tracing/trace
> 
> Tested on:
>   - Intel E830 NIC (FW version 1.00)
>   - Kernel 6.19.0+
> 
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> v3:
> - include information in comments and commit message about different
> E810 behavior
> v2:
> https://lore.kernel.org/intel-wired-lan/20260508102247.826375-1-przemyslaw.korba@intel.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


