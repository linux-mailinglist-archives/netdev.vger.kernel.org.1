Return-Path: <netdev+bounces-262451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNDWAFCVpGmxkwUAu9opvQ
	(envelope-from <netdev+bounces-262451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:36:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF61D15FA
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EDD300C591
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE0B30EF7E;
	Sun,  1 Mar 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFiKNB0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B8175A6A
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393804; cv=none; b=n2ySODdvWKtzBBD8KHz54gaiaOG+r3kiH25ZHNutvbOJgCvly9ISHfFFilE4k8gozjrk+MNSNdonpMIqNAXiltVUFotcvX48EPm6Xv8SiTtZVaVT1tcM3nZ2JcW5JB1gN1sTDc/Bq3DPRxaScBl68t82JLMah+LT1u1TADdNjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393804; c=relaxed/simple;
	bh=mMinuXJf6kcaZzz3FylxQOx+yWWMpGbMVqpuXWP0jbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaxhOEeOnlGT7vzOT9hTxU9ZZDgKvPXfRG5T97/W00+HxBOYHqqMQixPG/k7f69bCJ4TrEa0k0H2k+vN0KMxV6Vca2XdkSfQjOJjPW6vTGTHXs/n8UtngFCvVPuu3BsXcoDNnc1ik0Yda1Xa9cJkNNvhMIU/jLqZv30yZHPi/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFiKNB0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CF1C116C6;
	Sun,  1 Mar 2026 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772393804;
	bh=mMinuXJf6kcaZzz3FylxQOx+yWWMpGbMVqpuXWP0jbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HFiKNB0Pr4SGgKChmcMmk+4j1hi9nlef6EF4FUHfLZ3xB6QO140bApUNjG5jUdmX7
	 vdxtiAkqNRSPSggZDa67YKgwSabK2DrT6dsSBjwsOHDJyjgKypg1eiEcp0zooFwIsu
	 ybB7E9a9rlG5NoV7itOjiINTFR/7tuG+YI+aZgL5qGWBoHgUEsvKWtTNOq0WUZgJc6
	 kB1128wRIfCsgbFdI20TxEMW8sAjhWq0ixiJ34oS7XHZ1U0L4Pw2VgDmOg8rg8+PXo
	 CGyMeSBQrCTIlAJzhHl1BKwe8TZ8qYJTK4Wc+b0cnczynjADkNpXm252IXdzO739Kw
	 pWAfFGNvtazRw==
Date: Sun, 1 Mar 2026 11:36:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
Message-ID: <20260301113643.65e4e90c@kernel.org>
In-Reply-To: <20260301112413.1b6c785e@kernel.org>
References: <20260301162514.3347319-1-edumazet@google.com>
	<20260301112413.1b6c785e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262451-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5BBF61D15FA
X-Rspamd-Action: no action

On Sun, 1 Mar 2026 11:24:13 -0800 Jakub Kicinski wrote:
> On Sun,  1 Mar 2026 16:25:14 +0000 Eric Dumazet wrote:
> > ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> > even if this pointer can only change once.
> > 
> > Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> > direct calls when CONFIG_IPV6=y.  
> 
> Some crashiness detected here, I think

Took me a minute to grok it but its obvious in hindsight so to possibly
save you time: fib6_update_sernum_stub() vs fib6_update_sernum()
We now call the wrong function due to the funny naming.

