Return-Path: <netdev+bounces-268983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CRyAmGLumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:24:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DA2BAC04
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D9A0300F9E8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AAE364EB7;
	Wed, 18 Mar 2026 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QoWTod0Z"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762C1DF987
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773832815; cv=none; b=l9hIV0R6/ekHnKUQ9MN0FL4kyawez2ix4wcXBzQA2/BZWtLBbtVFSDYli6uop4wB4gt+1q1QrU2GOxMxl5J3q8sXiQZBTKNgzpRXx209BKUhf6El0tu/7MACev7oz6dLsbySle4NrTJa7tXML3G2Mlf5Ic4JBUzjlAA89onWyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773832815; c=relaxed/simple;
	bh=SDzBH5PiYY6/zg+kyfjMt2wy1/ksLsFR5jCxNxf9a7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1QA43xNaf4qJ4eOaYjutnuLQ9jqT54BY9dMdkrCEB5iNf3WBPTz7yLVHNRIZd1aPqVkDrpFXHSLjrnOZhxPJFSJUZ+DPZFaWVDBTaS9HLrutklfSMmnf9S+PmPqrsOREXhN6PSt3xHDoh0ZfDc0498oikkYggfP648VrVYqpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QoWTod0Z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RH9UMaFvWCvpaRPBmtsQMQKPHpV1p5HwYe8rCF7OgSA=; b=QoWTod0Zbs5f6IPZnd68Jl0LQw
	VV1a8c9QGkzVP+uD9v573zS7JQkJKjcrGkVEfRRzjJWIFZi8RCHZQu6fbgPvLuAsMzlGCvNXbW1Jv
	OknjJVnuQkdUC1reL9cCO9+MKdNElmD1NlHXya7ZDwAyAoD9zJ8S1et6ohYda5u2FDTHr4VysQ/J1
	tEOlfELz/kB6HTTBmRZOail7K6vHMDQbtkENQyjUetWBR+JB9BekdPPzPUigwlJ8bXChsfbYyfcaX
	y8ZuROAFsWyajlfMnKMsd95CBSKAq6HN+pwMRVKvFqDlipaWzRBtAo3f4oBLlcdVE4nog9ALGFFNy
	vGjSPWlA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2owL-003cdG-5s; Wed, 18 Mar 2026 11:19:52 +0000
Date: Wed, 18 Mar 2026 04:19:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: propagate macb_open() failure in
 macb_set_ringparam()
Message-ID: <abqKQcjARIquRwsA@gmail.com>
References: <20260317202229.193375-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317202229.193375-1-nb@tipi-net.de>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268983-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: 5D2DA2BAC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:22:29PM +0100, Nicolai Buchwitz wrote:
> macb_set_ringparam() silently ignores macb_open() failure after
> closing and reopening the interface, always returning 0. Propagate
> the error so callers know the interface failed to come back up.
> 
> Suggested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Breno Leitao <leitao@debian.org>

