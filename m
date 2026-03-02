Return-Path: <netdev+bounces-262588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA7fKUddpWlc+QUAu9opvQ
	(envelope-from <netdev+bounces-262588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:49:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116741D5C0E
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A97C93008D35
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C1383C73;
	Mon,  2 Mar 2026 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cU0xRUpd"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18259316199
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444860; cv=none; b=BWN4mLXI1J5VeBt/gzH6FMN3qxj5e48eO05i+N9IvEVrt8Y36tVTwkQcqo0+RLoC9utqkTYGbR5eDouItRymuhm9Tt9wrvQ10wjkFRMESo2XCczWE0PNXBfMMBX7iFp1yz6wloOZmCBGCO8BA34fy/sZiFBXT2Fcz6hB1RmFMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444860; c=relaxed/simple;
	bh=pkfo9xAAmB4lkUPldzmNXbsKuegLh5yXTCET7EO12OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHvp7Xxc+h/v8b1xm8XeVaR91BhYHo4RSPj/oD0YoVNL//YwoSgStdk8RQWi25Y02LlCIDgKm+BEZrP5dWGYYqKmAi/4qUm0V8jiU+6Ll5zKvo8mg1IMS0vZu5HrBeXXzY9rWFa9KhSRbdI37zUtMMMgOpAF5MWNoLREHRtQol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cU0xRUpd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=POGLBn//kxkI+OrMk5uSkSnwSuGPHc4YQGBzV8+pC1U=; b=cU0xRUpduvxnLJho+e5E47fmne
	I3gL2RunT/bNTPdhrDldNwlsZtOfBgishDZsDtCKAF5W38tjfOD7laAu6qD6Te3/2EYtcL2sz8WO/
	cT60Cf/OMHA0/dze/gbcHht08FFPSUm9R8a6ollalXVgJfIIt+WKBaJQjUhl01jh1CHZWBdME7ik8
	pPU8779TxwfE/l1C7cHVz+im2a6mS5nbyMeBnWndl3diczUyMUxOYDm0Fh3T/6oWQrfKzUpddOwma
	BAbNb4jsPhjj55+kjiSCC1lcpZ2IDV/pfB9deH3taLvnvKuxqdPb5QPZpvPaTIrH6k7ste8sfMyTP
	/RcQ+aLg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vwzs4-00EJl1-Lm; Mon, 02 Mar 2026 09:47:24 +0000
Date: Mon, 2 Mar 2026 01:47:18 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net] netconsole: avoid OOB reads, msg is not
 nul-terminated
Message-ID: <aaVcivgYdauX6yGk@gmail.com>
References: <20260219195021.2099699-1-kuba@kernel.org>
 <aZsrH23rOB0Z4_fz@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZsrH23rOB0Z4_fz@horms.kernel.org>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262588-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 116741D5C0E
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 04:13:19PM +0000, Simon Horman wrote:
> On Thu, Feb 19, 2026 at 11:50:21AM -0800, Jakub Kicinski wrote:
> > msg passed to netconsole from the console subsystem is not guaranteed
> > to be nul-terminated. Before recent
> > commit 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
> > the message would be placed in printk_shared_pbufs, a static global
> > buffer, so KASAN had harder time catching OOB accesses. Now we see:
> > 
> >     printk: console [netcon_ext0] enabled
> >     BUG: KASAN: slab-out-of-bounds in string+0x1f7/0x240
> >     Read of size 1 at addr ffff88813b6d4c00 by task pr/netcon_ext0/594
> > 
> >     CPU: 65 UID: 0 PID: 594 Comm: pr/netcon_ext0 Not tainted 6.19.0-11754-g4246fd6547c9
> >     Call Trace:
> >      kasan_report+0xe4/0x120
> >      string+0x1f7/0x240
> >      vsnprintf+0x655/0xba0
> >      scnprintf+0xba/0x120
> >      netconsole_write+0x3fe/0xa10
> >      nbcon_emit_next_record+0x46e/0x860
> >      nbcon_kthread_func+0x623/0x750
> > 
> >     Allocated by task 1:
> >      nbcon_alloc+0x1ea/0x450
> >      register_console+0x26b/0xe10
> >      init_netconsole+0xbb0/0xda0
> > 
> >     The buggy address belongs to the object at ffff88813b6d4000
> >                 which belongs to the cache kmalloc-4k of size 4096
> >     The buggy address is located 0 bytes to the right of
> >                 allocated 3072-byte region [ffff88813b6d4000, ffff88813b6d4c00)
> > 
> > Fixes: c62c0a17f9b7 ("netconsole: Append kernel version to message")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the fix and review while I was out.

--breno

