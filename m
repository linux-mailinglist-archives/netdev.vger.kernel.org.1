Return-Path: <netdev+bounces-281442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEP/F4ep72kCDwEAu9opvQ
	(envelope-from <netdev+bounces-281442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:23:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF844787B8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579E3302C939
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C605A3E3C7E;
	Mon, 27 Apr 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="AyVIkuj3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431393D6CD9
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314031; cv=none; b=PDp2oCcuyUcGYChj1EHkOXXpHs7r3fMREVH3V1/u5zaPibFZrvDj+JEZCtS1Yh2rHwSEpSclte1//CVek8V4RESZqCgLiYl7YCFKTX3ahqWoRdCvdLCrPjRO2TaeRGUcMTj0asxCEijblEenfnmrTCXJw06fuU6y7lsw1sC8JhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314031; c=relaxed/simple;
	bh=bN76FJ2v7mzFwUIMDRt7QH0QWQYlu0rTdiySbpZ9Ko8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrcGj5xVMo8iUyAlg8IPVRkVEp6d7esW7WdAl4Rm2Y48kdZHEZ2yS7bXv9PopPYqHyfhCWXMFu3CNT4CplxXUmixEJ6MmI3xU37WLK0vqBfcKuT+2IYxFu2OPmFEcZ+Q48hmUokhGbtDU7MLiMBlfTGKEkkiQgBV4ZC9DJjRptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=AyVIkuj3; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2dec803f9f0so5880326eec.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777314029; x=1777918829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8RyeeF+uqUFvtkyKIQ0Q0DITbXIoGdPLgiE0VyWQRM=;
        b=AyVIkuj3STBSQ7TrDYvswGBwgaWkDNeMbrgkIMIubUysGpzSGS1228cnhlp7ETxM64
         4SDSnxTCrQUGBp+aVa5LxYXLxI0AUA74gHM5HxOT61pmefCDLQeLLyGwg37WllyL6a2p
         k7z6x4e9WfYF+a73d1fVxsOu/lRHJd6IeUjNILJcb1REhP8JnSre1kbkjMeC4FxXY/nh
         w3s7nrPO/djX1/VAXLtg1u9AZw63SJrRN20sDOkQotvgp9MfUq//whA4o9qG9sTg+Pv3
         D1/8IAC4nwZw3fw8aLnjN2vQtEaKSOZm4U+R88f9z58FKi9iMUeZIE2OtamBlT7YJJ9D
         /MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314029; x=1777918829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8RyeeF+uqUFvtkyKIQ0Q0DITbXIoGdPLgiE0VyWQRM=;
        b=a8PjGZBpcBP9P986o+Xnzr/rWG7mFNG7zWhx7sB43OEqGZ9Mh07rRpFq6kdHt16JMH
         6yoFeN9l0dFCqFKEg6L3ER0PmLHFVVoAU1wiwwcTTzll1BEPKUhBKKkBXou8PuUB9pgX
         d8TkGf7K2rnOBCnwIULFLeMzuCk+4/kCYxQbmWnOHjxgvH90YJxIHPpt2zyeZw1jtHEc
         wfFF++M3t+nrhm33aWrEQ4nxWNzfuTpwBLStEdyoXQYHJlfiZnVqRHknJ7FHo2RPYyuA
         vxMfaJqX3MMBKln4Z/J6FX3BpgtLhVeywJGbEE/yz0FUYqKF/HX9aHBQlZUjkrZrtvsO
         4DIA==
X-Forwarded-Encrypted: i=1; AFNElJ8nJjsj6tASoYSUETb8KFWVxOJZCGx9BHbVP+QD5e63Wi/QNOJp/fNSy4IJApf9KRV1YM69/qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvkwgFPtdF7wDrbaTojp2SB9eeczpASLMDROJCcVfAAPVr5lq
	DCqog8CLR/Y2q2yvAEpNAYQ9k9dK6oIohMW6GHKxXjJGxrtzVwgfNlgKWZgU3CtZPX4=
X-Gm-Gg: AeBDieuCc/QDHYBxZp0+/U1vFtTGElkGkYVIv4qc+gDERvmSG2rZyq2Qh20yN1hBzaI
	xHPkae4sxKXKjKmcONWNjpBFnPOo185rA7voNK4uaq1hR8k1LTqMBDX0XTqQQPIEnfiIjc7yb+Q
	yiyK/IeyNUA24e6QKdwQpeA76BBEIVAJuLV1XYu6N/tn1lOkDPenmmMi28PUYgl/6DVqqJmKr6V
	BgaVwYOT1dxrxC4TSiULlkkt0JggE5eREG4g6YtTOR7LpJ0fGUPozFIWB7V6XcjhqGr3+zSy9LP
	AwDexJU+HyMC1hNS+x3L3+VxVBAJ3TuMRLcpLqjXNIvv3capBJEbAY6czGTylwwrVLERXD8CDdg
	zNAL65/HkGuUcWCRtMlAlzYXyr0hKNo1U981Jat4XnyS1Mkl/6mTI2ZdyVru6SvwEHq+GE6S3Uo
	MDy/f3pl5vS0L7Zf4Xk8Oqhoq6FqR5k783IZMFmGNzRpQsuA==
X-Received: by 2002:a05:7300:214f:b0:2de:e194:5fb1 with SMTP id 5a478bee46e88-2ed097ed954mr68059eec.7.1777314029174;
        Mon, 27 Apr 2026 11:20:29 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm42915897eec.14.2026.04.27.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:20:28 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:20:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@gmail.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, leon@kernel.org,
 michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 0/4] Introduce FRMR pools
Message-ID: <20260427112025.49ebbd73@phoenix.local>
In-Reply-To: <a441f862-1ebe-4fd9-9ef5-aac718fb008c@gmail.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
	<a441f862-1ebe-4fd9-9ef5-aac718fb008c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9AF844787B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281442-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid]

On Sun, 5 Apr 2026 11:09:55 -0600
David Ahern <dsahern@gmail.com> wrote:

> On 3/30/26 11:31 AM, Chiara Meiohas wrote:
> > From Michael: 
> > 
> > This series adds support for managing Fast Registration Memory Region
> > (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> > pool behavior.
> > 
> > FRMR pools are used to cache and reuse Fast Registration Memory Region
> > handles to improve performance by avoiding the overhead of repeated
> > memory region creation and destruction. This series introduces commands
> > to view FRMR pool statistics and configure pool parameters such as
> > aging time and pinned handle count.
> > 
> > The 'show' command allows users to display FRMR pools created on
> > devices, their properties, and usage statistics. Each pool is identified
> > by a unique key (hex-encoded properties) for easy reference in
> > subsequent operations.
> > 
> > The aging 'set' command allows users to modify the aging time parameter,
> > which controls how long unused FRMR handles remain in the pool before
> > being released.
> > 
> > The pinned 'set' command allows users to configure the number of pinned
> > handles in a pool. Pinned handles are exempt from aging and remain
> > permanently available for reuse, which is useful for workloads with
> > predictable memory region usage patterns.
> > 
> > Command usage and examples are included in the commits and man pages.
> > 
> > These patches are complimentary to the kernel patches:
> > https://lore.kernel.org/linux-rdma/20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com/
> >   
> 
> applied after fixing up a few nits.
> 
> Please clone the ai review prompts from:
>   https://github.com/masoncl/review-prompts.git
> 
> Run the setup scripts and have ai review patches before sending. This
> should really be part of both kernel and iproute2 development workflow now.

I rebased UAPI headers based on 7.1-rc1 and iproute2/rdma will not build.
Looks like RDMA did not get merged in 7.1.

Will have to back it out if not going in 7.1

