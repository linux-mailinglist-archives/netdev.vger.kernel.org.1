Return-Path: <netdev+bounces-281313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M2HLv8572mD+gAAu9opvQ
	(envelope-from <netdev+bounces-281313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:27:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBF470FE4
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2427C300C01E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2130C63A;
	Mon, 27 Apr 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jBK36dUA"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66A2F616B;
	Mon, 27 Apr 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285608; cv=none; b=HTzbgLa42Mdgbku1PiMF50WLR9ZKcvytLbtyjLhyerfSDiNzyb3PXF6z/yCKhdmMYxmuRrBtGaQOEFD0zS/OMsbmhkn1YX38opFZxlCob2nYePI8KTXkDslVfy8EstzoMXhsPHuPctDRsMyjh+LT/NeauXM8cml8kVPCb23vuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285608; c=relaxed/simple;
	bh=1X99EAP2K6g8uMcZtmPY7Gs5ET1sqvM1m+wYK1yJ8n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1m8UeHe+slhpyHQu7awcJbnQFDjJcAi649CL7imOqyXktXYl8BTi9ZHkxmuR78ZuXbwsqJwV6PZQbeONGnR/xmLVSinsxHS3ff3U2CFNpIN/N+MC8ISPrL+ZE6P3wt+epMieHpH8DitXMjCXfbTs/m09MBSrDo6juafOl4uTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jBK36dUA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=4TEhCkAx4BwHd6dHPCDzNwYfW4yoSQBej42fgUEtSDU=; b=jBK36dUAbB4+h1x7LwfcpD33mi
	hdJiIWNRRmxaxkyQ9hmN4nrWna+qmyOLYZdWz2XeNdkVqkjE7EZc56TC43H90IBDkAYiSq9otTn1B
	5hWCTeXdfCAQTsiyROC0VEkdXpyO3cATJ98x23t4Q5NVZ/V5gNSmhvU1YN+b7m4Eif4Btz3HevpBj
	1IG87v+aMWbvJvCheRoXnhZAYn+XAKMcmZY4gceieY0harGHLw0+gcXeiHKFYx4/I/M6Sxr0NDf1v
	dq3fq59KZGaxzRlqUxMJZ0ynE/j2/qvH75pVfFjFgddTcYn98fwtpOFv5c/m0ZFU+TvJ9f49XRPgH
	rjGsQTrg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHJAg-005PoF-1L;
	Mon, 27 Apr 2026 10:26:35 +0000
Date: Mon, 27 Apr 2026 03:26:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, k-keiichi@bx.jp.nec.com, satyam@infradead.org, 
	akpm@linux-foundation.org, thepacketgeek@gmail.com, asantostc@gmail.com, 
	gustavold@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net 3/3] netconsole: propagate device name truncation in
 dev_name_store()
Message-ID: <ae85UEWf7dgJtmeS@gmail.com>
References: <20260423-netconsole_ai_fixes-v1-3-92b8b7de9a2c@debian.org>
 <20260426083904.1130399-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426083904.1130399-2-horms@kernel.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 5CFBF470FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281313-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]

On Sun, Apr 26, 2026 at 09:39:05AM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> netconsole: propagate device name truncation in dev_name_store()
> 
> This commit rejects interface name writes that exceed the size of the
> destination buffer to avoid silently truncating names and binding to
> unintended devices.
> 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 4bef003d9df64..3914fb90f9afd 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -816,6 +816,9 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
> >  {
> >  	struct netconsole_target *nt = to_target(item);
> >  
> > +	if (count >= IFNAMSIZ)
> > +		return -ENAMETOOLONG;
> > +
> 
> Does this check incorrectly reject valid maximum-length interface names when
> written with a trailing newline?
> 
> Standard userspace tools like echo append a trailing newline when writing to
> configfs attributes. If userspace writes a 15-character name, the count will
> be exactly 16 bytes.
> 
> Since IFNAMSIZ is 16, the condition count >= IFNAMSIZ evaluates to true,
> causing dev_name_store() to reject the valid input with -ENAMETOOLONG.
> 
> Prior to this patch, strscpy() safely truncated the trailing newline by
> copying the 15 characters and a NUL terminator.

That is a valid issue, if someone is using a 16-byte ifname, it will fail, for
instance:

echo eth0123456789012 (15 chars) writes 16 bytes including the trailing \n

With IFNAMSIZ=16, a valid 15-character interface name written via echo arrives
as 16 bytes (15 chars + \n), and the count >= IFNAMSIZ check rejects it — a
regression compared to the prior strscpy() + trim_newline() behavior, which
silently dropped the newline.

I think a better approach would be:

  size_t len = count;

  if (len && buf[len - 1] == '\n')
      len--;
  if (len >= IFNAMSIZ)
      return -ENAMETOOLONG;

That keeps the length check consistent with what trim_newline() does to the
stored string.

I will send a v2.

