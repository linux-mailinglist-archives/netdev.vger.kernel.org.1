Return-Path: <netdev+bounces-298995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYlaMamSLWqbhgQAu9opvQ
	(envelope-from <netdev+bounces-298995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:26:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0ED67F2BD
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:26:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M+lmQSVS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298995-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298995-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E9BE300B845
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B9395AC5;
	Sat, 13 Jun 2026 17:25:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5A2C3768;
	Sat, 13 Jun 2026 17:25:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371556; cv=none; b=Xw304U/AEv/OKSLOUUkl2zABlZqnwMvm7/slUKXw71AMbhp0ORk6nAAD/7QEoa7+I4Xrrenm12OetfzYZqiEjFlOPt2ayiBLl5GoFDzz8LUl3dxlMKBHP0h/LLwhkjBmOTvauZYCM1k6dv9d7bBobBV+SwW5lsiEr65df85jS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371556; c=relaxed/simple;
	bh=XQt8n1j62y4Z33sOEEHpLj2LyMhlFYqQz2yKhwdHTxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm6zL4gpbi7yAescsh+na0OhTwSLi2J+tCQG5a9NBVUjnbr0zR/PNhgI0A9OFH4dXHJDIipV6w5mAwga/AMaqYVygf9vA964s284eWXPhtYUFllVqLZK13bvTgMq4MOhLmOJRu67d3Buci/k7WGZRSheu+qrf3gumAQDsbJVv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+lmQSVS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61EF1F000E9;
	Sat, 13 Jun 2026 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781371555;
	bh=XQt8n1j62y4Z33sOEEHpLj2LyMhlFYqQz2yKhwdHTxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M+lmQSVSP5qBsE4r0JwtuP00ps8iY6kFWwQnKCoYfE+tXicK6gwVqXw6tYfgHI8Uj
	 SOwbJxyybi8KdRTeMWT44alCU0z/pfRBrYJx6RDp6pS6zNs0u+Ne/sseIw+KiP9oGs
	 hY5N9XWXOHAxAE36TdKhjyFDSUw7Lo8mhtxG5rot0bMP8QxAC/HqsNyOmY93FKEtl5
	 e8/bPcQelAJHaTGOLumVF78EhSGd46DRmUFw0Lnr11a/+QwnzAXn2SzPsChFREgW5m
	 GOzxXKHSAnqWa2nRhIoyCPNwF9zRYm/Hu4fCLrScqHE2Z0cATfNKhF46Rzj0nqV9k4
	 yp27bqABvZdHA==
Date: Sat, 13 Jun 2026 10:25:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org,
 jiayuan.chen@linux.dev, toke@redhat.com, menglong.dong@linux.dev,
 emil@etsalapatis.com
Subject: Re: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on
 private skb
Message-ID: <20260613102549.0061a875@kernel.org>
In-Reply-To: <20260612114032.244616-2-sun.jian.kdev@gmail.com>
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
	<20260612114032.244616-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C0ED67F2BD

On Fri, 12 Jun 2026 19:40:31 +0800 Sun Jian wrote:
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

I did not suggest this

