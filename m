Return-Path: <netdev+bounces-258528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBCGDuuDjmkrCwEAu9opvQ
	(envelope-from <netdev+bounces-258528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:52:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C92132537
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34DB6306DF3B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 01:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F33597B;
	Fri, 13 Feb 2026 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6hpb4Ui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3E214204
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770947526; cv=none; b=JGpCPn8hrSY58i9EyuzZ83GYi3ylQincitMxDwQZWN44M+I6p8MlbpldoYqJan2uem/SbXjs8iBrNuw1FqW7U3lIaRhxr9PvvztZV8fXKeEGQUBVeoL6GDXI3t59qtd7zYC7cR1zvD6QT3plpLIldOrP2gPoUfuvdn6Ik7OHKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770947526; c=relaxed/simple;
	bh=gSq9SN/QGb4zuDM73pjz0wF96/gGTG4RHMLgmi3XhU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZMss2rHZzQwAe2OXt1w9D0GjWaWS8ylI4+/4bjjioUj4ljg4Kt51QYcfu5e+qs6wV4Utnv9BZQ49H/f64tB5d3QMtBYpO/vI2SWHsrnUOhl9dl3obXjhJN8Rp2Burmmuaa4v5vG21voBLkVPBq99B4EQ5nnL6fiVEcIX34z/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6hpb4Ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FF1C4CEF7;
	Fri, 13 Feb 2026 01:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770947526;
	bh=gSq9SN/QGb4zuDM73pjz0wF96/gGTG4RHMLgmi3XhU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D6hpb4Ui8Q0PD5kt9NsNqfO+YfQIS0VwHXE9c9BAYhjISb1AhNsJpPEjUOtoNaeK7
	 Kx4PEcyKIPiyjm5CLcmEV/OYQhGv+pyzeAEu4pgQKboR9jxSIzLutp7GC1P3VTAi8f
	 LIiYrrOkt6EbNSC46HSWatcDsgQ1Qt9OA+KW7NkCvPJxg5iYariht+q3+Fy5zdQPRQ
	 ML8kPrPU8knJbH1HE5iqgwYQ7Bg4A5VG5IJKAz7FfyR47cipXfxEsf7gZQJa31FU6i
	 IGGqUr8cW+WYrCeSfmXwCjBfODJ2wmYUMij21k4KZ9eoxdwhhSKZ17LCL9SZdPGGTI
	 b7KIkd0YMVd+w==
Date: Thu, 12 Feb 2026 17:52:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com,
 bobbyeshleman@gmail.com, davem@davemloft.net, edumazet@google.com,
 michael.chan@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH 1/1] Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx:
 test RSS contexts persist after ifdown/up
Message-ID: <20260212175204.5b467f67@kernel.org>
In-Reply-To: <20260212081250.4088970-1-pavan.chebbi@broadcom.com>
References: <20260211085822.184f85c2@kernel.org>
	<20260212081250.4088970-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258528-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,broadcom.com,gmail.com,davemloft.net,google.com,vger.kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97C92132537
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 00:12:50 -0800 Pavan Chebbi wrote:
> +    if not pre_down:
> +        ip(f"link set dev {cfg.ifname} down")
> +    ifup.exec()
> +
> +    wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
> +        lambda x: x.strip() == "1", deadline=20)
> +
> +    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]

I don't see anything wrong here :(

The diff I shared to re-open the carrier file instead of using seek()
doesn't make a difference?

If it doesn't please use the version you shared here, even if it's
unstable right now. I'll try to find the time to investigate what's
wrong with the test infra. Better that than accumulating workarounds.

