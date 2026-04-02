Return-Path: <netdev+bounces-274681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFc2A6TOzmlXqQYAu9opvQ
	(envelope-from <netdev+bounces-274681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:16:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DE38DE57
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA79300D450
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7232571D;
	Thu,  2 Apr 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FnuzpNzl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9391A0BE0
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775160988; cv=none; b=icB1i+Pi/pysigiiDU7f89daEELMTglDNf8HaLe1SORi/G+J1+RZ8L2dTj70DAS+jz5f4++QIqUYhfDn6djQjaalJ7QF8EHewj3AQhsSWACDBZJYj7IXJ5PRo1H5wO86eKqYaJdhY8PD8q5WZkpeGhM1HVALNGkwkmDxmDa/TQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775160988; c=relaxed/simple;
	bh=7ZrmvUDXG1nqHVwz8fitWvPqv1aHZgqAjLz6eU4qJ5w=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1OI+xu4itkD5hco/iDroJx+pzMwTTaz4Gg0RpYB+Ou/y4EGvVBL9sny7DCYpH7LeGQleGqiovHVrjNZ6FmrEwHiAWdsd1czZzAHRtWWq3L5kvpgsoz3vsSk5xFZjMIIa41ax+TzT48uXoX04PZMacXamTOwyIe/qXXqN3ERg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FnuzpNzl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so19034765ad.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775160986; x=1775765786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Je5DxdGmoM0opeAOPvJB609+NjnMtKeDSWjpBbbut0=;
        b=FnuzpNzlEjiUOTs+YUwvbdjlXpPiUN3TKpvhyuLn64Jpesui0dCXz6NQ+vBRL9UYLS
         aB/U27yIGMS2nRQY8fxt9qmZtYRhKV0o3B4egawFcb+iDBRwaiQhU8mc0ADsU2EMNMCr
         XNxx/r0XYzJl3+qZGBupm4j7qo1zZXPSddT2+45yCE3/M5e8lI0i6c6UPCDqBVsvqpTZ
         9g3zmYA1ECC2nfscjx8ubvq6hhRNK6zmnnyubyGCZsbX1ULfphoGJIeq/UNmVE6NWHTd
         uylXxXltRrw+tIGu1H7sD2jz+dW015pGOb8+TOsORxuT+onSTn+JTeR+j8c1QaFZlS+n
         Omxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775160986; x=1775765786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Je5DxdGmoM0opeAOPvJB609+NjnMtKeDSWjpBbbut0=;
        b=XKLZX9AZIVtiYhE5+Y5PuKshVCtfIaJAB2tsFweObNP1yFWr/L81xH+GHhXhAShAo1
         58U5UrbAij4VLAmrjNaUNsuplIa1LfwHKCdTbtJJMb2NINkFebu0jM0mbeEPeU6ofHOY
         Q2TEmlJdcHRWlujDVZ5nuQCEEA9bIdm/MoVMZdGExb3kZdvIHIblr7cEK9PHY0jTS6/l
         U9IYISaeE2OMXtbE2h3+wmsE5oPytHrMUNL3ZmicZ8BdMvpZZihL71tJzVSlTOvLlXVI
         cor7VssahZox5YifOiH7Vvc4nS6/66YdfeV97j+P/1Pi58fTU8GEWLJp9s82TM6NCCHn
         y9sQ==
X-Gm-Message-State: AOJu0YyIUmZGnvynlCBu3owUW/cDfwlyGCcdSOAb7XFl/68dTYcHi7IZ
	bPJKkD77lKpF2nWxjPWiK2ahbS25lxUydFFDkcV2GKBNzs01Lflef7oXyhjNDH+NliRqEEOgoLQ
	qr6ck
X-Gm-Gg: AeBDiescQbdJmZclIM/emEsCr6i8TQtsUQEUc6FOlzgRnvLtvutGhRjyXgpzeYFXNvo
	EKSbMzOoIv0yxzSGoFWkJmfnpMFmnDIQzWfJQJeXp3tnRRxVTL4a28hHhNM8nR2g0CRKbzQW3F1
	wVYQrsS7IYplj9WERjVvmtYrMR/376nKQyG6FwZNf1s1ve6FsKdQzL2gptt9kS8P7YukAwzbaRZ
	gJNGCrEfWsiQOxHvZVlr9H2qzwrcrVpwn6KSTeoAFqcmevg2WaPXNqufBJ+5rvPJ7B9zIZ26yi+
	i3cnydqxhfw5vNmQjjq1MlkXPh5dlTciO/5NDzIIux+h/uKeB8rt62GZPJr0n68TMQbUnDr49vb
	+B49HQCm1Fo5/YhMEpBkDHg/Kvl/JyllnyKgmFi/njaHEN57O1G2pDxWm9U5LGt5B8JUQv8YwNl
	ey/15jHlKPgbGbW1gpeuasEdeP08pdMm4Gtkk=
X-Received: by 2002:a17:902:c952:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2b282067e8cmr3820945ad.14.1775160986253;
        Thu, 02 Apr 2026 13:16:26 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747612b7sm36662635ad.23.2026.04.02.13.16.24
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:16:26 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:16:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/7] net/sched: Fix packet loops in mirred and
 netem
Message-ID: <20260402131618.21624737@phoenix.local>
In-Reply-To: <20260326181701.308275-1-stephen@networkplumber.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-274681-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim,networkplumber.org:email]
X-Rspamd-Queue-Id: 384DE38DE57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 11:00:59 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This a minor revision of Jamal's series that
> fixes packet loops caused by mirred ingress redirects
> and netem duplication in stacked qdisc trees.
> 
> The core idea is a 2-bit per-skb tc_depth counter that travels with
> the packet.  The existing per-CPU mirred nest tracking loses state
> when a packet is deferred through the backlog or moves between CPUs
> via XPS/RPS.  A per-skb field covers both cases.
> 
> Patch 1 adds the tc_depth field in a padding hole in sk_buff.
> Patches 2-3 revert the check_netem_in_tree() fix and its tests,
> which broke legitimate multi-netem configurations.
> Patch 4 uses tc_depth to stop netem duplicate recursion.
> Patch 5 uses tc_depth to catch mirred ingress redirect loops.
> Patches 6-7 add mirred and netem test cases.
> 
> Thanks to Jamal and Victor for fixing this.
> 
> There are additional netem bug fixes in the pipeline but those
> are held back until this series lands.

Why is this marked Changes Requested.
The only yellow in patchwork is AI review warning that the patch
didn't address my comments. Which is a clear case of AI confusion.

I updated comments and commit methods to my satisfaction.
Sorry if that didn't satisfy it.

