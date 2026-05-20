Return-Path: <netdev+bounces-290029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yANeAyj1DWoz5AUAu9opvQ
	(envelope-from <netdev+bounces-290029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:53:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A132B594DB0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03FC8315C84E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F803BBA0E;
	Wed, 20 May 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CBIJabsi"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C436F421;
	Wed, 20 May 2026 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298045; cv=none; b=Tf/2fzsyJC0XoASIXfppjUs5yI6sWk3sRxjCOr2AhB7UxWPFmLJUsD0htq0cm/wkp3TL/gDOp8Ufhqq1sl7ccmOlqFGW0p5q+gKL43IcLMOS8x45XezY/wVFdJ0s3gyXgsjn05pIw8SFZydECLFdGlO0gZZq3uE7qMN8tMhGFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298045; c=relaxed/simple;
	bh=X0txdFwz2nSY7i3sfY0DqlglxtMhA/Cxtg/abAKCOAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIgqovrdXYAUMRf/fH6h4+VEmIMp5DBZ16OIc6ugLSmtxvFlI4T06st2uN/7tpWTawIzSxYDOFxwC2K/WluXnFjkM1wxeGmjRuFt8aJ++zcs6YFvOZPxHxnvwROVZbGAgjVbXJbQxhWspgv/Hm0QT/mDGDGwH+/3hzX4dY43X2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CBIJabsi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ye4EgwQSw5kqIQb5WLTWB7hJ2bBb4HasauCnq34yJXA=; b=CBIJabsiTPY6sA3ESjOy9LxNKo
	sT9jNkexZOR4ZqVA0uk//TZRXhWWlOLQhX9MvQlP9BPW4Xj5m0oyDvnt3W4ziWiGEMNmUIOGzEb5p
	EBWN3M+AJkSc0lurihhu9MAxcS4zyv6k8OAzOK/XNAppezu+JTXjCGnOI/iHUy5CvgqCCm2kCDlN4
	AhUuE3JVdH8nJuAPN6xHyuoFR3qXpgKsTimoZOSPshlRs+rfFdpkPn4xSWTov6SB3Fqc87WfTSMtF
	3t85Po12709EI1tWHVMD5Muw0ngvRGOIiNb+u6Od1ZCbTKqedkPcyrSWUT5/5IQQdV4GjbtmhHhrN
	MkX3sIqg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkhL-003GVU-0z;
	Wed, 20 May 2026 17:27:11 +0000
Date: Wed, 20 May 2026 10:27:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, david+nfc@ixit.cz, sameo@linux.intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	oe-linux-nfc@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net] nfc: llcp: avoid userspace overflow on invalid optlen
Message-ID: <ag3uNJZ8uyn5jPry@gmail.com>
References: <20260513-fix_llc-v1-1-33c76f931ff6@debian.org>
 <20260518091103.427351-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518091103.427351-2-horms@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290029-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A132B594DB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:11:04AM +0100, Simon Horman wrote:

> > @@ -319,6 +319,9 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
> >  	if (get_user(len, optlen))
> >  		return -EFAULT;
> >  
> > +	if (len < sizeof(u32))
> > +		return -EINVAL;
> 
> Since len is a signed int and sizeof(u32) is an unsigned size_t, does C
> integer promotion cause negative lengths to bypass this check?

Good catch, you're right. `len` is `int` and might get promoted to unsigned in the
comparison, so optlen = -1 becomes a huge value and slips past the check, then
min_t(u32, ...) clamps it back to 4 and the overflow happens anyway.

I'll fix this in v2 by casting:

        if (len < (int)sizeof(u32))
                return -EINVAL;


