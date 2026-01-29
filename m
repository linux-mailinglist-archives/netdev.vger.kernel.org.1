Return-Path: <netdev+bounces-254946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E+aDpHve2keJgIAu9opvQ
	(envelope-from <netdev+bounces-254946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB10AB5BCA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44541301690B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927936C0B1;
	Thu, 29 Jan 2026 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLhvKud+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600936A004
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729864; cv=none; b=E7EYAZb8ahPLPLKKXwFel3VnU0ZI5uY2FTlemaWOGLDoIqNudXwhDgxspy5AzyH3KD3o06qcjnTuYPCnNUX0UM1TVTfhPKebXzMDLjRxequ1wH1Ck6Xrn4ULq+cPfs/yEj4mpoInk2VPze0dI2jax1fo3R9o/YyzGVFd4iPy15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729864; c=relaxed/simple;
	bh=avK6K4EySPGpHdKfutthBx1Cs3DdmlsHH5kiQ1OF45I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD8WuzEbmImhPiHtSpqVR9HFuf5/dyv4KEq+HgiPZKbrHbnPZ91NgHmySTZz7z2EgEKXaMlt7u4zf4flfrVMiX2MCXND5f12C0ORidxyHBzp635TKpnsjU04Gr6rYgj0XAgB9YEgNqvw+702zQDiFEXx97EEnlw9CBXO7kFtgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLhvKud+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D837AC4CEF7;
	Thu, 29 Jan 2026 23:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769729864;
	bh=avK6K4EySPGpHdKfutthBx1Cs3DdmlsHH5kiQ1OF45I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SLhvKud+rfpOPXWpBH2g+s6LcJdHzwBCy26DaprpjDzRfla/JGuGNMql82fJj4xxp
	 hP5UO9Ws7Jv9CjJFYlbmsO9K9X+ugX3UTsSIgoVxrGZaLG6btsOe6mIMdwHBPwGsZb
	 q/6ziqAEa3Dn1b28nmKlsQY3XxpX0cvxDnrzEI2ZC/SqGvjUsVgseMFjkHhuVRp8zQ
	 vSPcCItyFBtCt980iSAt46opjoa470o2Te6G8jzwWOxSDX2QYZ3l5jByA673V9tMMA
	 lGKP94Lwcp7p6qiPtuQuZYL+1JXPg8yneI/VFyaVHXU8LqZ/BB3sJNQ3e3fZOb4maJ
	 Kuck3Nfa4l6Tg==
Date: Thu, 29 Jan 2026 15:37:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Sune <marcdevel@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 2/4] selftests/net: add no ARP b/mcast,null
 poison test
Message-ID: <20260129153742.7062638d@kernel.org>
In-Reply-To: <CA+3n-TprC7Fs0HiBndR+OpYmy2vq=raiuSE=_R49LVxjax8Aug@mail.gmail.com>
References: <cover.1769464405.git.marcdevel@gmail.com>
	<713d6f1ca57b402be420ade1331acee4898675c4.1769464405.git.marcdevel@gmail.com>
	<20260128202739.79af1bb8@kernel.org>
	<CA+3n-TprC7Fs0HiBndR+OpYmy2vq=raiuSE=_R49LVxjax8Aug@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254946-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB10AB5BCA
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 19:28:22 +0100 Marc Sune wrote:
> > > diff --git a/tools/testing/selftests/net/arp_send.c b/tools/testing/selftests/net/arp_send.c
> > > new file mode 100644  
> >
> > Could you check if mausezahn from netsniff-ng can send these
> > packets already? We already depend on mausezahn for other tests.
> >
> > Similar comments on patch 4, I'm not gonna repeat.  
> 
> I can do that for ARP, but not for NDP apparently. Only basic ICMPv6
> echo req/reply is supported. For NDP (ICMPv6), it needs to be
> specified using -P (hex). Kind of ugly...
> 
> In RFC v1 I proposed to use a scapy
> (https://lore.kernel.org/netdev/3cfd28edb2c2b055e74b975623a3d38ade0237f1.1766349632.git.marcdevel@gmail.com/),
> which is substantially smaller than arp_send/ndisc_send.c. I dropped
> it based on the v1 review I got. I see scapy is used in bpf/ and
> tc-testing/ self-tests.
> 
> What's your preference?
> 
> a) use mausezahn only for ARP, use ndisc_send.c for NDP
> b) use only .c progs for consistency
> c) recover the scapy patch and squash it in patches 2/4

Hm, I think there's another tool we use for ndisc - ndisc6
Could you try if that works? if not maybe grep around if any
other tool is already used by the tests, we have a bunch of 
ndisc and igmp tests, maybe one of those will do.

If not, my first choice would be to update ndisc6 or mausezahn
to teach them. Second choice a local C code just ndisc_send.c
scapy as the last choice.

