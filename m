Return-Path: <netdev+bounces-259763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHiUEizEmGl/LwMAu9opvQ
	(envelope-from <netdev+bounces-259763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:29:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BBA16AA72
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A013010520
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24602FF147;
	Fri, 20 Feb 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp5kac6r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A62FB99A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619286; cv=none; b=Ht8kJv3bVRX4ckfnQtDv/JCAwfckwQvlwbQ9OF0K9COG35Q6JW9WpF/5ntIldXaiKGT8MqWUBWGgcpeCu9rbzvYGycHoe3HSDYkjeFkhTXYehGYEnbaYRWk4x+zH9eG1DJSu16kM98ERouuBAJliy4twy1AWx/cKnCerCjwAjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619286; c=relaxed/simple;
	bh=w1OoQgJr7uXesrr4Of/AetwFqQpTBamN42u/afVJ12U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S46wjzZM8qNNFLJDVjfSksOP5ii4omUjvITJXJPlitYjS1UYJtJo0K3i7rA0hqXRNJgGTBW5egOkVj/pwgiRnwVRibYQaHHeOTjz+ZMBrYmLwQvFXmkdi76x9q1lpWG9XeXNihvc76s2kgscaNqlzMo9D6fVWJXDNCa7K0758nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp5kac6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3AFC116C6;
	Fri, 20 Feb 2026 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771619286;
	bh=w1OoQgJr7uXesrr4Of/AetwFqQpTBamN42u/afVJ12U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pp5kac6r8yJcXfpOGvr0JxWfWlYEocYk42h/W85ofHjdAOuXrhzOsGpnWItIUhm7L
	 qb52k/wV/DXCUyb+L/XNJxk+VgnI9n9WEC7f4rSf622f8sVg1AEM3wZCqySXQxQ+S5
	 /MmKpbe/32SQf8h+UI2xJfmIGvT3kQ3xolZGDP+oyXK1d8gPQdfZitGSojVu1i03n9
	 Bup/lMrz0Le1/wAP7I/1prYWP8yKaYcFtWZj5z3ko+FoDq1mNkc0v6U+H8AFuely75
	 AZJHJS9gUrVsApH0aMlIXVRtu9p4ChdzPIHH0VRLzMnw2WpbG50WJbgp+oOY1pVWaA
	 73VqNpXKqF9JA==
Date: Fri, 20 Feb 2026 12:28:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, fgont@si6networks.com
Subject: Re: [PATCH net v2] ipv6: addrconf: reduce default temp_valid_lft to
 2 days
Message-ID: <20260220122804.572e70de@kernel.org>
In-Reply-To: <b3466d97-cbd2-4288-8da4-9f30df1ae477@suse.de>
References: <20260214172543.5783-1-fmancera@suse.de>
	<177137761857.765825.5185653389299397165.git-patchwork-notify@kernel.org>
	<b3466d97-cbd2-4288-8da4-9f30df1ae477@suse.de>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259763-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2BBA16AA72
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 16:39:27 +0100 Fernando Fernandez Mancera wrote:
> > Here is the summary with links:
> >    - [net,v2] ipv6: addrconf: reduce default temp_valid_lft to 2 days
> >      https://git.kernel.org/netdev/net/c/9e371b0ba7f5
> >   
> 
> FTR; the patch was merged without the fixes tag. I think it would be 
> good to backport this to stable kernels because otherwise the 
> documentation and the real configured value are contradicting each other.

Yes, because it's a functional change. We can take it in for 7.0 
but IMO the justification is too weak to treat it as a stable fix.
Imagine this from the perspective of someone who was promised 
a _stable_ long term support kernel. If this change breaks their
expectations - what will be our defense? "But we said in the doc 
(that nobody reads) that it was supposed to be 2 days"? Dunno.
Deciding backports is quite tricky, borderline impossible.
I took the executive decision to take the patch ASAP but not to stable.

Of course the stable auto-selection process may suck this patch in,
anyway. But I won't be culpable :)

