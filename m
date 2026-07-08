Return-Path: <netdev+bounces-305867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HdKmIHhvTmrAMgIAu9opvQ
	(envelope-from <netdev+bounces-305867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:40:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A9F72827B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:40:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=hBiuNXRz;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305867-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305867-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 261183269597
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D183B813A;
	Wed,  8 Jul 2026 15:26:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22C3A6F17;
	Wed,  8 Jul 2026 15:26:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524363; cv=none; b=aK9GXyoX+9i3EYdYb5TQ89oFsA65HI/nHhAX5TCVszcUPoMNsxoxTazUPF++KVoVoOLgeqJy4fwDwLm4C6Tdi5VDOhqrTIKxZfBh5G16tENXbLzIvLv8Ucnho7npgMRyXavNYfVgDOj5yFlAa787EjYAXkCzRPMq+4ogfwP/k8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524363; c=relaxed/simple;
	bh=odcECtMHFEoUn6zU4zviED276a4aIPGxcfNjbkl/W2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf7pIODjdJdb02ErX/m1AKtu7ZFE0Q9umGFPoDxckuMPq1nzAtQZhreQJY7bYy+iV2OEv59cToU+yDue2mPJTpphwkBkzyPPYbe3m/U2TtksUSZBWXm4rG+TJK6I4T0MJv2iEA6ckL0loWN2/HutRxz9fcs3DI7zNbJ+NJHYLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hBiuNXRz; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=odcECtMHFEoUn6zU4zviED276a4aIPGxcfNjbkl/W2I=; b=hBiuNXRz44gyJFpaWPuKfz6gri
	TnLPMnrqYk/DhyAjZ1aywdiQQlaIjzyWM0nq5FskuRqBV+eMyYt96hWOz+srAvJLOUmowTYXWY0YM
	2sTCI1LgaBjRYwj7DrlLR5pQejUPmmsPkNBxmkwptZ515o0R40xmvukBnp+dlrqDSh6KTUcnc6TML
	o56dxX9k6naSnKKQgF5VoxqGTLWGmWtU4/0JWDh0goiV2D+QDihcBOgz7+rwbYApwobIspxKi1pFp
	affFbVAyb7eC/5W/Oc4XVdH4NQ12KGylJIGmeEZrwRVZ+lnZ6YP6piS5bMOr0OIZaeZq+Q2aXDepC
	GEPybpfQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whU9p-0032gh-2n;
	Wed, 08 Jul 2026 15:25:54 +0000
Date: Wed, 8 Jul 2026 08:25:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH] net: use sync wakeups for socket error reports
Message-ID: <ak5rH-SWjiqR6MVe@gmail.com>
References: <20260708133815.3419465-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708133815.3419465-1-usama.arif@linux.dev>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:kuniyu@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:willemb@google.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:riel@surriel.com,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-305867-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03A9F72827B

On Wed, Jul 08, 2026 at 06:38:15AM -0700, Usama Arif wrote:
> Measured on a 176-core EPYC 9D64 host running a Meta production
> workload, bpftrace on tracepoint:ipi:ipi_send_cpu with a kstack filter
> attributed the sock_def_error_report -> ep_poll_callback ->
> try_to_wake_up -> ttwu_queue_wakelist -> __smp_call_single_queue
> chain to 16,326 IPIs/min.

I am interested in why so many sock_def_error_report().

That's seems a lot for genuine socket errors (RST/ICMP) on a healthy
host, so I suspect these aren't errors at all?

Can you share the full stack above sock_def_error_report()?

