Return-Path: <netdev+bounces-293143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO41LMumGWruyAgAu9opvQ
	(envelope-from <netdev+bounces-293143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:46:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA0603DFD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ADD231D870E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D747B3ECBED;
	Fri, 29 May 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiWa20TQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44093ECBFB;
	Fri, 29 May 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065129; cv=none; b=f4OOTsnsMY9ND7X11M8WBzFAaM7Y77qWoMYwHOnKt7RpN6NnCj13K6+/t6SFMM5o9qosXbr8guYbrNaw65t9VumjXIANr068KRHsvtSFC+U4PXOKuUKuNcsXpxS30BtEwTPKxzKR5PPCB3oRw+nnlnCuvVa6KE+Qz8cxry/cH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065129; c=relaxed/simple;
	bh=nGtd+DVlXHUdUZmpRGiHCZsFgz+aRf95Dwcx+EFRgr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQIb5OtmAnwVveNA6zGwDfMhEFE/+e/Dz0t4zN0TzzYwnaDHYv3moIktX/XYOwegK+kgisGJ3KZOIsjUo+KJ61VzwL0pV/ehlUY7RtmD+nrQwPaIJHEwH8+0OBKeS1sBbuOm+RBjis3zIIs/TYqs6VgLCbHZwtRQMQ3dkZ3pOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiWa20TQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECF11F00893;
	Fri, 29 May 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780065127;
	bh=0w6zYF8AbOQ414/tNXkjIf7qAh21STz/SV17oxV/kCk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YiWa20TQmrue5rLRFPE/D4ifPV5/SCxDxgghPPLtsjKAiyVEdyeFwQ+e0HNArc4pn
	 nyrRFvE6ioDqGWoppVoqZqc/Vvvbl5bd0MXs7+cPB1jFJT1CNgBeEGBu3QHlH5Cbay
	 pJaGLBYeEVa1IqM77C8N4lqFzMmtKcXt+GYHdcNICcFcCK/RfhxIh8l4amEroAVviu
	 mmICUniiqEnUfCcGSR4r3GUcKKjYvgaOX2/T8Lzx4BO1uiAr2DQARaSRjVZc86wj7i
	 yvApIl+TbaJhEOT4X3uNmwRsdOm2hkObFGKBPJwxQJjPdCRZemfDAf9sFZjzlZnFfa
	 g2wrHRpEo4IXQ==
Message-ID: <f9125ef792fa3182983efe287175777a134e8696.camel@kernel.org>
Subject: Re: [PATCH 00/11] NVMe over MPTCP
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Matthieu
 Baerts <matttbe@kernel.org>,  Mat Martineau <martineau@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan	 <shuah@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>, 	linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Hannes Reinecke <hare@suse.de>, John
 Meneghini	 <jmeneghi@redhat.com>, Randy Jennings <randyj@purestorage.com>,
 Nilay Shroff	 <nilay@linux.ibm.com>, zhenwei pi <zhenwei.pi@linux.dev>, Hui
 Zhu	 <zhuhui@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Fri, 29 May 2026 22:31:56 +0800
In-Reply-To: <20260528084210.GA8141@lst.de>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
	 <20260528084210.GA8141@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0CDA0603DFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christoph,

On Thu, 2026-05-28 at 10:42 +0200, Christoph Hellwig wrote:
> You need to talk to the NVMe technical working group, not us.
> 

Sure. Thanks. I'm already pushing forward with the NVMe membership and
trying to reach the NVMe technical working group.

-Geliang

