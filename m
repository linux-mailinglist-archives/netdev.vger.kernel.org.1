Return-Path: <netdev+bounces-263989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA9LNw97qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-263989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:33:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E631520668C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D29B302C6E8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C037AA6D;
	Wed,  4 Mar 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbZ5OvMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0962374E41;
	Wed,  4 Mar 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648578; cv=none; b=f5FouOCxirIzIqLdwO9jGzmUQjG5axDpE2id3Hjzo4yt47iMAr/J9MejSD0hLxWUsdriATt0tZFtjrifN5bfSzhNfrKqu9Iq7FS/ulIM6OaUu1gTf5qGgnIAMhkpg2vM8XHIX7qnkWyKQq6PvIP8eA/nCCGMYCKgNDdhy0ZfulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648578; c=relaxed/simple;
	bh=WLIqTExMhzSN6tZ1C/rmypHqQDRRSZGLRT7nBlVIDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXYEkRklaA2zLpJN5wxiUztNg6CHywZvO1dDH003pInd9/akhAfFRCETPol8XntcmK4EiO5LehjgOEBnzbjX6cXCX4jsA9iZKCQgv6lxp6Hstz39aJM/4u9Y4pRkuL6v5hquaE4zHMRJJIJpEONLvcMmoU1bLFkEz3TyB8ghdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbZ5OvMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D8EC4CEF7;
	Wed,  4 Mar 2026 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648578;
	bh=WLIqTExMhzSN6tZ1C/rmypHqQDRRSZGLRT7nBlVIDd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gbZ5OvMMJ0njiTfQCg6mLVnzPXZBhW1PZvkqEA5ClrxU+3BHQl2pXSECYIJFQCZUh
	 BjGbVJY9ZtIl98jdIr8V9JcHNN7sXbRI2XM9AKt1Yqy5Qjrx0s79elqhWMOSpRYitI
	 hnwY3oMWw6dY6gy6lmfIrLLbr1yMDD5FhywyOUqd6+BULa6jOty7+orKe+A5yI2zyZ
	 PR3RknvgzOjPRHi5ytOnisGHlxFGtOqLDGQPxbvS24NRTfaZevH4t52i7dOQK4HSOt
	 YpezVyki51WRmxbAasPvDSKQvBOuHOsf/hgFvVB2+bwPYHi1/bw5k0lfOKSB4rDH0Z
	 +lEZ4UHjzVXHA==
Date: Wed, 4 Mar 2026 10:22:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: edumazet@google.com, andrew+netdev@lunn.ch, ajit.khaparde@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, michael.chan@broadcom.com,
 linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 rajashekar.hudumula@broadcom.com, vikas.gupta@broadcom.com,
 pavan.chebbi@broadcom.com, rahul-rg.gupta@broadcom.com
Subject: Re: [net-next,v3,6/8] bng_en: add initial support for ethtool stats
 display
Message-ID: <20260304102256.0771e576@kernel.org>
In-Reply-To: <CANXQDtaMHmzU32jyyooXk7qdHPqroW9Y-Nni==qritBgegn2Dg@mail.gmail.com>
References: <20260228072715.1632280-7-bhargava.marreddy@broadcom.com>
	<20260303030036.1885679-1-kuba@kernel.org>
	<CANXQDtaMHmzU32jyyooXk7qdHPqroW9Y-Nni==qritBgegn2Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E631520668C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 13:38:35 +0530 Bhargava Chenna Marreddy wrote:
> I see the issue. These aren't actually duplicates of the standard
> per-interface stats.
> They are unique per-ring hardware counters, but the strings happen to match.
> 
> To fix the collision, I'll prefix the entire ring stat arrays with
> rxq_ and txq_.
> 
> Example of the new output:
>   - Per-ring stats (via ethtool -S):
>       # ethtool -S eno12399np0 | grep rxq_errors
>         [0]: rxq_errors: 0
>          [1]: rxq_errors: 0
>          ...
>         [n-1]: rxq_errors: 0

Unrelated to the previous comment, but could you perhaps not use 
this `[id]: name: value` notation in bng_en? Having spaces in the name
of the stats in bnxt breaks a bunch of scripts for me. rxq$id_$name is
the notation majority of the drivers use.

>   - Standard interface stats (via .ndo_get_stats64 / sysfs):
>       # cat /sys/class/net/eno12399np0/statistics/rx_errors
>          0

Standard stats does not mean just rtnl_stats. Please TAL at the per
queue stats for instance. If you think some of the counters don't
match you can keep them but please include in the commit msg the
analysis of what counters you considered + what the HW counter is doing
= why the two don't match.

