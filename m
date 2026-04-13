Return-Path: <netdev+bounces-278135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL2lCmsg3WneaAkAu9opvQ
	(envelope-from <netdev+bounces-278135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:57:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C12DF3F054B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1D1A307BBFA
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B61314A8E;
	Mon, 13 Apr 2026 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvG2mcu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372E313298;
	Mon, 13 Apr 2026 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098832; cv=none; b=BOCpmnnUUCE9afclpeH35gwo9Ghqhu1BIRsKBI1z/7nGfKUWCKgbhxrCbWK0yijGiR8L7Ncu9YfFMbrZ2yVat7plfGdXj84PmusN53CJCphKQphMqaU6ZCsfg4+TqgjSpqhx1zvpxIqN4rekD6Oqb1ERJtMfrD6wWV/opmrVjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098832; c=relaxed/simple;
	bh=jNW0/buPHzZfl7bk0soR3fE7hl4JdwHL3dBiQwr/s+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8Pr182fUeH6b0RSEfLNVipcRoZMTCTVGx31Y4w9oDOmMBiPRN3MtTJye5PbV+kS3DF0PucUCw1DYtUs1XgkotcIOCg3DWsgcCAosTizpcC4SMl4q78diOMVn7PEWpIIAWYKXey12DB3lGfbmkFAE5wPWEBDVslUnKhWrhpODtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvG2mcu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3DAC2BCB3;
	Mon, 13 Apr 2026 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776098832;
	bh=jNW0/buPHzZfl7bk0soR3fE7hl4JdwHL3dBiQwr/s+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvG2mcu5j/XA3oxFBUu/Z/Ckhb+9VwD/m8gyJh4MxMuNdqi1+hNtyyO36fC0ior7/
	 A+OrhCQDF2Y/r5AOyCF/qW+trC5lrBHxUKd+W/lq0hUKNgu/p07Vu5v0r6RGt4txGZ
	 Yj7vCYGtNPF7zI/2VTqaM7GI7usYlK7+VYeJgt6zL11nMDdQRN2bjAXfLbqXsgcA2l
	 nGeQz7WBlWa8kKJnM4qhEWvhtu2639aThsDpjrzVJg4KsrWcRphtizM0gOwq2VrvNX
	 ztU3k+yLmc668bj4gr3L2wGMrXPttmZzSZOt/OvsgzOx3JYvd0GUq8mSOmq23Ts8u3
	 AI9XXdCH73d3A==
Date: Mon, 13 Apr 2026 17:47:07 +0100
From: Simon Horman <horms@kernel.org>
To: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
	corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: sysctl: document net core sysctls
Message-ID: <20260413164707.GT469338@kernel.org>
References: <20260407083213.27045-1-chakrabortyshubham66@gmail.com>
 <20260409174859.11854-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409174859.11854-1-chakrabortyshubham66@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C12DF3F054B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 11:18:59PM +0530, Shubham Chakraborty wrote:
> Document missing net.core and net.unix sysctl entries in
> admin-guide/sysctl/net.rst, and correct wording for defaults
> that are derived from PAGE_SIZE, HZ, or CONFIG_MAX_SKB_FRAGS.
> 
> Also clarify that the RFS and flow-limit controls are only present
> when CONFIG_RPS or CONFIG_NET_FLOW_LIMIT is enabled, and describe
> rps_sock_flow_entries the way the handler implements it: non-zero
> values are rounded up to the nearest power of two.
> 
> Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>

...

> @@ -238,6 +240,37 @@ rps_default_mask
>  The default RPS CPU mask used on newly created network devices. An empty
>  mask means RPS disabled by default.
>  
> +rps_sock_flow_entries
> +---------------------
> +
> +The total number of entries in the RPS flow table. This is used by

Maybe s/This/The table/ to make it clearer that it is the table,
rather than the number of entries, that track CPUs.

> +RFS (Receive Flow Steering) to track which CPU is currently processing
> +a flow in userspace. Non-zero values are rounded up to the nearest
> +power of two.
> +Available only when ``CONFIG_RPS`` is enabled.

I think it would be worth noting that a value of 0 disables RPS.

> +
> +Default: 0

...

>  netdev_budget_usecs
>  ---------------------
>  

The lines above the following hunk are:

netdev_budget_usecs
---------------------

Maximum number of microseconds in one NAPI polling cycle. Polling

> @@ -297,12 +332,16 @@ Maximum number of microseconds in one NAPI polling cycle. Polling
>  will exit when either netdev_budget_usecs have elapsed during the
>  poll cycle or the number of packets processed reaches netdev_budget.
>  
> +Default: ``2 * USEC_PER_SEC / HZ`` (2000 when ``HZ`` is 1000)
> +

Well, that is awkward.

Looking at git history, it seems that this sysctl was added by 7acf8a1e8a28
("Replace 2 jiffies with sysctl netdev_budget_usecs to enable softirq
tuning") in 2017. And at that time the unic was us, and the default was 2000 us.

But that was changed by a fix for that commit, a4837980fd9f ("net: revert
default NAPI poll timeout to 2 jiffies"), in 2020. As a side-effect of
that commit, the default was changed to what you have documented above,
and the unit changed to jiffies.

So while what you have is correct it seems nonsensical to me for the unit
to be jiffies. Because that's not a meaningful unit for users. And because
the name of the sysctl ends in usecs.

But I'm unsure what to do about it. Since changing the unit this would
represent (another) KABI break.

* Add another knob that shadows this one (But what to call it?)
* Simply remove this one (KAPI break)
* Change the unit of this knob (KAPI break)

If the code is left as is, then I think it should be documented that the
unit is jiffies.

...

