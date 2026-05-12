Return-Path: <netdev+bounces-286886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAloBAV1AmrjtAEAu9opvQ
	(envelope-from <netdev+bounces-286886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DB517DFF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F362B3016412
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6942620299B;
	Tue, 12 May 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvUYk7a/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB3D531;
	Tue, 12 May 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545921; cv=none; b=E0VrlydPtYeEUOcIjlcpR4M/mjiILiXCzAjWHG0cRdT9XommTjndl+BiH/3cBCldI9Dg303al46/Y+AkhbNGwhZgNzrjTC4aCxgn57PWifTWYX4eBpgJOu6S7A32uHteVOGrDHvaBFECYlqr/m7zwuX4oUCr2HlfU/GbZH6X2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545921; c=relaxed/simple;
	bh=+r/LiprO5vRvI5cDbWjwOg8u8xAZ4aT4o0snGZNdVDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6jLNgNjcHtEpRPqi8mK5P8vUBN2cYVsH/tPBVFvELZmXRn79ZY1V0VgxLdPoW2o0JXO2an7lTfvbPfuYejgcnvHcSuul1ZoprRJoe9+YG+UG5BeUMonbFSgu0fcBmVB6AZdM9OlxtGYw31cmYGdq8kH5lOyCYffukEOyKCLQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvUYk7a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E955C2BCB0;
	Tue, 12 May 2026 00:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545920;
	bh=+r/LiprO5vRvI5cDbWjwOg8u8xAZ4aT4o0snGZNdVDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CvUYk7a/ewstpO7yfbO7R51dfj1y+pRIreoQrgT5HLiclYQMzPS30FuXH0/NjVA+C
	 iTu7O2nJ2++QFoOv30/jNb8e29zfDKocV5FzOAEixn1ftZKpajqXBQSbyNNeVm+DwO
	 10x3c3p0EOXCB4P82Uq4ElwpcxaCxe+EKY0l4j+Mw05p6/7I6GC8+rIdEF+EMqGfiG
	 s6iWtCH0gZaVOvodO37jpO7rCUQOMZ4LCH60QlQCcCfh56r0VvSiZtHk3Ilitj7Axa
	 Tw3h9SGipoy9HLLhrE//m3TuXpoBNHPYrV1fGi9XRUrVDBgbvyZRMtbRUlDyt2SDmk
	 uW56ljSs/9W4g==
Date: Mon, 11 May 2026 17:31:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mention the convention for .ndo_setup_tc()
Message-ID: <20260511173159.5d71d05b@kernel.org>
In-Reply-To: <20260507214054.2539790-1-mmyangfl@gmail.com>
References: <20260507214054.2539790-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A34DB517DFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286886-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri,  8 May 2026 05:40:51 +0800 David Yang wrote:
> qdisc_offload_dump_helper(), originated from commit 602f3baf2218
> ("net_sch: red: Add offload ability to RED qdisc"), is designed to that
> 
>     Whether RED is being offloaded is being determined every time dump
>     action is being called because parent change of this qdisc could
>     change its offload state but doesn't require any RED function to be
>     called.
> 
> and returning -EOPNOTSUPP (for dump queries) does not mean "I don't have
> any statistics", but "I don't offload this qdisc anymore". At least two
> existing drivers did it wrong, so it is worth mentioning.

Applied (with a minor tweak), thanks!

