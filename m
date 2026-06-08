Return-Path: <netdev+bounces-296737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ALZ5M8M2J2qWtQIAu9opvQ
	(envelope-from <netdev+bounces-296737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:40:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37E65AB5B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:40:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xlc8lD4B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296737-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296737-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2BE83027956
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF93AB27F;
	Mon,  8 Jun 2026 21:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40C3A6EEB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:39:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954756; cv=none; b=g1q6b1ewFYe+gX4zWfoscVcxSOb9/8owpISjivkl4htNBF0wCaFVcAQO9Dy9ThnpWzYF2yPV9Sd2SE6hK8ruXQMmtZZA3nXyDqRSwz36hs+Czu+WlW1XAgKl82z8CgRniVfPGeuIyvuKI2o2WJ/CYmy+3V7QyvzvRxAqgllYIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954756; c=relaxed/simple;
	bh=mKWI2odDW4UxxRm+DRJiRwsOPa7BFZpIaoH5Mfq899c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4kqRDTpQQnrj9F9lFSbvpy6ObkT/O2IoqDVO5jjD71Ct7yU5jvJYTH2kXU3/nqjXpz8+CTkpmoLPGKkjI16wVd5GbQ0/oB2CtZeHAXhSkFusmQZGBDo+IrF20aGJRAvJMKFXv+yEMYYZrjzr/gMGpJZFPMgxFqCUaS84Pk1RuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlc8lD4B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BED1F00893;
	Mon,  8 Jun 2026 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780954755;
	bh=1oIouYlhiCMj8QSPZzs4UCMaZWSSBZ13yHvdHY/uFIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xlc8lD4BW6Iex3qgN7EUW/bIAxuY7xKt66M91SXcvvNeiOE//nm9CykCt+uYxIoeV
	 0XmnOLN1WymMjBenu1KskmgnI/AeVl6hYMeoQOGDHFxeswoSBrrbXiJVgBNYAiKVUK
	 X0aai8WLrjAWzasHIQrkKLE4D0soMp7XFDhE45xE3P686/PZax+0nNo8ILfUQCUPo/
	 RHFE/5RD3GBeTjoR8Iiv/6rPqy9EyHBPQTVxLGXl3a/tL18lao4JtWSQYC6NsWu23B
	 FNfAAc+xmW2fBT+cKJMpCveqO2hYpUoz5WccO4t8EsN3VhHMIQ5fQbgDeIOMnfMYZj
	 XWqnVxsk/F2Qw==
Date: Mon, 8 Jun 2026 14:39:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: so_txtime: check IP
 versions
Message-ID: <20260608143913.349e45c4@kernel.org>
In-Reply-To: <willemdebruijn.kernel.cc30d5c2f9ee@gmail.com>
References: <20260608173305.372987-1-kuba@kernel.org>
	<20260608173305.372987-3-kuba@kernel.org>
	<willemdebruijn.kernel.cc30d5c2f9ee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296737-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lib.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E37E65AB5B

On Mon, 08 Jun 2026 16:25:01 -0400 Willem de Bruijn wrote:
> > diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> > index ddcd2c0e06a8..8fe061f52055 100755
> > --- a/tools/testing/selftests/drivers/net/so_txtime.py
> > +++ b/tools/testing/selftests/drivers/net/so_txtime.py
> > @@ -64,6 +64,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
> >  @ksft_variants(_test_variants_mono())
> >  def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
> >      """Run all variants of monotonic (fq) tests."""
> > +    cfg.require_ipver(ipver)  
> 
> This may cause aconflict with my outstanding SO_TXTIME series.
> And more importantly miss having it in the new test_so_txtime_fq_tai
> variant.
> 
> Could this test be moved to test_so_txtime that all of them call?
> 
> (there is WIP to add another mono_hw variant too)

Ah, sorry, missed that. Would you be willing to take these patches
and add it to your next series, then? Or the WIP stuff will take longer
than say a week to surface?

