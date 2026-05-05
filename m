Return-Path: <netdev+bounces-284445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IIjCLX/+WljHAMAu9opvQ
	(envelope-from <netdev+bounces-284445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5301B4CF78E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DFDF30041FE
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2CD37A4AF;
	Tue,  5 May 2026 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FRhJ8jmk"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145D36655C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991583; cv=none; b=C49fOLkJLzu/KhnXXWZK9pFMh62erByZVX8cbJl7bJvkRcz878Yf5+cXPLEGDhiYcgsWW3I+NhiQAuoKoEbJvOYaDn+9zK+j8c95Ca+4ydrb4vcx2UcPoEkK1PLOmBWrxth1xgFN3AQWxlN70a5f91N7Wgl8ke5BKrEBAqR0U5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991583; c=relaxed/simple;
	bh=idLwsskY1nQ6fEDf7yOuIuBNnwCtmZwzLrQQA0Pri0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RM+eiCB4IqmRDefREOfp2KHO7KjzKFeWew687VzO8T+qiGLEMLmVFS88oY+v7x5M4Xdj975gqC86wyBNrqRzujthi1DUmUZPcYkC7z8BoJ74aQQ3TIVHWtC58mo83c5bsOAS/pc4MpsIKvX9x2xBTTwEvEv/fta1seKmV7mk1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRhJ8jmk; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <61bfff07-0692-4966-8bd3-2a03ca07f3a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777991579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoewsMzavCsVXNSzMuJpXjgk6hfaZPr7sER+2iljfOs=;
	b=FRhJ8jmkPe4wOcUWu2TJsNxugGAv8nGCEwbZMat5NFK+hVHCdp/HZVATWvSxZILab5PbTQ
	FBNJrVie2/lyPR/p+TJvTIRSygOuEjOtOP9QFhz3RKOuE0ajTksj9YKY2Zm7iNvBbDqo+o
	LHsXYM8GzdksyGT0o8a+XdQpzqG6BTg=
Date: Tue, 5 May 2026 15:32:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iproute2] dpll: fix man page correctness issues
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260503164200.145679-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260503164200.145679-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5301B4CF78E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284445-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 03/05/2026 17:42, Ivan Vecera wrote:
> Fix several inaccuracies in dpll.8 man page:
> - Remove bogus "holdover" and "freerun" from operating modes list,
>    only "manual" and "automatic" modes exist in the DPLL API
> - Fix typo "locked-ho-ack" -> "locked-ho-acq" in lock status list
> - Add missing device show output fields: lock-status-error,
>    clock-quality-level, mode-supported, phase-offset-monitor and
>    phase-offset-avg-factor
> - Add missing pin show output fields: panel-label, package-label,
>    fractional-frequency-offset and esync-pulse
> - Remove non-existent exit codes 2 and 255, the tool only returns
>    0 (success) or 1 (failure)
> - Use canonical enable/disable for phase-offset-monitor to match
>    the tool's help text
> 
> Fixes: 656cfc3ce05b ("dpll: Add dpll command")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   man/man8/dpll.8 | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

