Return-Path: <netdev+bounces-292475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMPZA15+F2phHAgAu9opvQ
	(envelope-from <netdev+bounces-292475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB105EAEDA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293293044802
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C14380FE7;
	Wed, 27 May 2026 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLYH8m71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457E313E38;
	Wed, 27 May 2026 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924555; cv=none; b=r07EKTsW0/IdsopZnXORVUudnfdAwtFH0MklwSmcfQVmdJDmcnzt3g9/zW1dzRfBD+OLmQbsHfCobUyRa5P1Dd2rY4SDhHj/BWORHkN35HJ7SYe2adlRr1mGt9nI5+RNiyM2/pwx0fVN0LzNdblHRmgZy+WlbbpKuoVFE8Z2rWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924555; c=relaxed/simple;
	bh=PzqJZF1xdYj9co3AUZLJDg3CFgm+qDYISzsBVSrZRzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMu+B9TcpvQp3kEIoYaJ/QzQ8ebhU2SAojTn4jk0tp5UXK79kNXJghA4ediJ5h1P9NPfuZrY0QmifsR3JfhKUbMTq4ATW4C75HjVKMq+31jGI9MWXMI31gySvycByh9mbJ0dmfIFqkn17nz0pzdngCs8fS0nlu/4FuFMgfs2QFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLYH8m71; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C721F000E9;
	Wed, 27 May 2026 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779924554;
	bh=G6iUvpkAB9d6u96IHBLKPkgcdFU/CX1jIWC6DbQ19Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gLYH8m71qRyKtYHDSsK17h0MzIRzEhXV4nDIxVAJRy16Fd1F+7U7nAPFHFunA/gnM
	 3BkMTHsJvyNg7zFnF+FYXTVUdPrGxYkq2fSbbCc6UbP0SToAXU6ZXwwQaLn8ofV3mU
	 fOTHOIchRhvLSwxURPy+J+eyE9MatG+oeXtuca7fmLET/m9stsVQzkEFrrHVau6uYX
	 LH017auzHTs0QVlvQA4X+/1ZnyZhvl0XsFiEF3SLF8GXTfjifmh3vtozEUuJSwfwAT
	 LYVE5d0RcBdIvnNE6DlO97fcY2Wb2IzLncXKcMp1WyOwK0kesR+1Omir6mXEQr87MX
	 xOdTSurVL608g==
Date: Wed, 27 May 2026 16:29:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Prathosh
 Satish <Prathosh.Satish@microchip.com>, Petr Oros <poros@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] dpll: zl3073x: use __dpll_device_change_ntf()
 and remove change_work
Message-ID: <20260527162913.40aa00fa@kernel.org>
In-Reply-To: <d8226c8e-8821-45b4-9188-be81047ea6ba@redhat.com>
References: <20260526074525.1451008-1-ivecera@redhat.com>
	<20260526074525.1451008-3-ivecera@redhat.com>
	<d8226c8e-8821-45b4-9188-be81047ea6ba@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-292475-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5EB105EAEDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 09:51:43 +0200 Ivan Vecera wrote:
> On 5/26/26 9:45 AM, Ivan Vecera wrote:
> > The change_work was introduced to send device change notifications
> > from DPLL device callbacks without deadlocking on dpll_lock, since
> > the callbacks are already invoked under that lock. Now that
> > __dpll_device_change_ntf() is exported for callers that already
> > hold dpll_lock, use it directly and remove the change_work
> > infrastructure entirely.
> > 
> > This eliminates a race condition where change_work could be
> > re-scheduled after cancel_work_sync() during device teardown,
> > potentially causing the handler to dereference a freed or NULL
> > dpll_dev pointer.
> > 
> > Fixes: 9363b4837659 ("dpll: zl3073x: Allow to configure phase offset averaging factor")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>  
> 
> Hi Kuba & Paolo,
> 
> patchwork reported netdev/build_allmodconfig_warn failure for this
> patch. But it looks weird:
> 
> https://netdev-ctrl.bots.linux.dev/logs/build/1100767/14594344/build_allmodconfig_warn/stderr
> 
> I don't understand how this is related to this patch.

Sparse randomly generates this once a week on a seemingly random patch,
I haven't dug into why. Safe to ignore.

