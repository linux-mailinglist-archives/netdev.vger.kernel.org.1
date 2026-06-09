Return-Path: <netdev+bounces-297348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QfXWHsugKGrAGwMAu9opvQ
	(envelope-from <netdev+bounces-297348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:24:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 163EC664C57
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:24:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G0UDZVhX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297348-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297348-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 654E4303BA2C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2839060A;
	Tue,  9 Jun 2026 23:24:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372E320CAD
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 23:24:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047495; cv=none; b=ihYcFjkNQ3PZ5bbrRCJhG7On9Di6Pal2+GCA2o13TNr5B4I3WGNnPRW4QRua/nySaWe+gRjRdAbSmpBXZDCuBvQfXRR7DlmcDGYv+P025qPYl0cxsiNPZ8PEGyQM2MtxpTlGjipWCBjSM4hgKup+/r+RKzkzOiWptPtCB3G3W7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047495; c=relaxed/simple;
	bh=Ss8CuDUnbvm/KoC0IWoRrDApujyz+XdCUVhtiU6mCd8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FUKeDtUT3uWaYfDFPZtcgQ632iCzq547SBofIUnM+uel4h3rigdszBOPB76HGZ4J3isp7Gu8V/8C/vAT4QkpeSq1YBhFASyGhPGrYOvYpmQuvZdX4ZPEhkd/1nmk7sdVa1l2cbK6S+ByQfbeBLEfmOUCe3u6lWB7dJlqxd+VbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0UDZVhX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882371F00898;
	Tue,  9 Jun 2026 23:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781047494;
	bh=1xm4xzIJK6tPlNijeCKJBsNhudwiwx2S3gwnzBS1160=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=G0UDZVhXu9JMtD9KlEF6X/aAKL6cb2KBTnHYMuKJDqFhiyzLFUa4JRuv4yyqDmp2j
	 bQH4v6KeiWlwRQg/W6eRrvSRT4fe89PAUe52FfiPlW9KdivcRNq90fzIEa4/d/u7Vu
	 uMVrK68HVVR9u7jsidCGJwNfLk75BUvTQUHdyRK9BB4Z6cOv2TgvzpvLz0i/qumeAb
	 BdHkkO1dYaN8PEPIw3v8otWyE86suQ9YgYTJRC+BB1Sq45Tb0MIpTHBqIuoBPYwKzi
	 TlsHYhGQHEGDvnLLIK/hFaFg6qKgCNOgQHZ/eC0+++hj8/hdi8H6gRtLarXyPuKCeD
	 YVjygK4HN3lww==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BF38BF4007D;
	Tue,  9 Jun 2026 19:24:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 19:24:52 -0400
X-ME-Sender: <xms:xKAoajUZdc29Y10-cA2Lcml56EkImpAGgJQXdE3N_SO2aeSsXdK4qQ>
    <xme:xKAoagyh3RJV5IprKzipErwdyVRbydw8rxrKNk7Ikh5zl9WVBvHnSZLgGOgq0qMQA
    l8OX-6xQwDWPENb6HDtHec9T7cPkVTLeW84L89LaALbvHEJSUSFZrs>
X-ME-Received: <xmr:xKAoaiziiCXE6uPILO16wkR7Q5tXJ-gUE9fXk_fptvUZZ3LdoMOKSLWvg9Eu3WClqXOfz-QfXcE2swa0Pjx394_lck4gF1UhAW8>
X-ME-Proxy-Cause: dmFkZTGyuSDSzmUK7Bvry6ZZ3+g03myhtlP9WTQ6TpMUmV+SJbGaVFEffdrmNdpuDVWCIL
    jHrAIeCLo5G09VXhX0rFqYZ9cV5I8NkLEtJcFjOqTxhPYRepDLkCGnBnpdAdjU+b7KHH/0
    AJXB857VJZWo7RNEJVtV/bOudf2ZAN+Uja6UN8yN3yLdWEhO68yPRoF+vtJu332GM2q0Zo
    s0HaU+NKZs6r60mqj082ZPrFQFD8s7BtudYIr+AabmVWgffgdjA8T7nyxyXzMG8dXcos5h
    sAg8JpGXN+0Got2tT/LBiMI3j2kDJ5hPcf5FsdhMqG04MqZAPvFU7n9/L1uKQfJ5s8czH+
    mibFc+LgINgcpj3KQPu6mNizf6pjNJd2Mo0V3tqrsvrS2RZR092lrARogzZ669K/1hlE+7
    BEms8KXn1DvXyzbnqKEEo/pZZ/KgZQYn0vejjKsUEy9XLNeJJUmDvs63zaQ6MpP+lhVB2b
    KU85YIq04FS44VDCaoeiRNGXVr6fMR6dh98fR/Q/DUDCmcQ2D+O3LXOCa+DbII0ykFXA0m
    Rlb4gE59gY8OofpzAkMRvOGnwGIvvCdbrAEr8pNMekEdAwGIKZZ0f941aX0Gey9ewhu4Oy
    m2G741RazfNcVGvt7mfmdilxl66nljdX9Y2/ZQByJKwGy8vUvvgk6W9R2MUQ
X-ME-Proxy: <xmx:xKAoat0TKj0flOjnvQZue0vy1dGUUQILBmxyO2c99uQUQ4m82m0u8w>
    <xmx:xKAoaoqW-rBkePUWxx8doAXimzIw57xTVFXyBI3V7DfxjrtkYji-_Q>
    <xmx:xKAoarCUCjLNFf1L572KLt4Qsp4nI7mabKasEV1ZD4tqaevzQmG3RQ>
    <xmx:xKAoahoAE8X55FuPaiQ1YsFEoMihT-jiu_a8y7fIMoeyKGBcjaxSmw>
    <xmx:xKAoauB7WyaNuydB3IKb462MnP14u8HSU287r_XB3zqlCAGKXEpdDeLZ>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 19:24:52 -0400 (EDT)
Date: Tue, 09 Jun 2026 16:24:51 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 netdev@vger.kernel.org, 
 djbw@kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <6a28a0c349c9b_4fa7810099@djbw-dev.notmuch>
In-Reply-To: <20260609215755.8685-4-alejandro.lucero-palau@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-4-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v27 3/5] cxl/sfc: Initialize dpa without a mailbox
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297348-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:dan.j.williams@intel.com,m:benjamin.cheatham@amd.com,m:Jonathan.Cameron@huawei.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:email,amd.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 163EC664C57

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.

The code movement is not strictly necessary. Just add cxl_set_capacity()
and we can consider a move later if mbox.o and memdev.o are ever not
both included in cxl_core.o by default.

> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> +/**
> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> + *
> ++ * @cxlds: pointer to cxl_dev_state

Stray "+"?

