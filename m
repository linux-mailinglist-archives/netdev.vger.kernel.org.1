Return-Path: <netdev+bounces-280062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHn9KzpA52no5QEAu9opvQ
	(envelope-from <netdev+bounces-280062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:15:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D932A438B66
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E9430465D2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616C3A3E71;
	Tue, 21 Apr 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gksf2xDD"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E93A450A;
	Tue, 21 Apr 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762764; cv=none; b=jJS9CVlhVnGZA3usUltZ+BrKxf5de5EZj5FzKPXGDFiTExJdOYN49ccnSuHmNh3MI1IJk8LEVP/saxBBDlRaqORrCGCwYMRjKacUbLpeZPSykPwgbJNgcf5c78L8BWvGqo6AiLCRwWr3VnpAxTGijUioAHoRBQ/qybaMXgF/ZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762764; c=relaxed/simple;
	bh=qMZCs19zNH6r1sbcN8n+CvL8pFRMZpKqdg5NUnhlPD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HN2cdidIa9nwtYDgXWEECp7RlR7bZD2upxd+Ei060KdhZlRePWkptYbx6tS+Pylxf8o/gT5yU+HekGSvCdrvWAco1bdCVeucWufVrpeS7XWycMbaTZkXFW6Hg8n/59taXl1D5rcBC3gf13+RXmp9+Ot8cRjS0TKwKC9z3Qh4xd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gksf2xDD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C5qtPTtRQKr+SHyFy1jM+p1ujYTR3Qaj3gDSKzuF8+M=; b=gksf2xDDSfp89q43dyM6nM3/yG
	rPLiP7/I0gzBMEcT+NiXry5h5rQVUY1ys2Y67PaYGKK01hAXhnWxdd/oFoUzDJO+PXljdkAUyZgFG
	Lve+iAmRmBYn2YWZeaNwGRaa5mlOsiNizNEnbjKI0g5TobuRleDlAwM+vjrh/KSExv12kzVejJvh3
	Bkjrhwoq6ezVcQgYnSsFlyPc6IgWsTiILhEErCIxKjqAVgABtDypIvtM0GFD1a21Vl1bTWfo473/K
	z2FC+GGBgDFsbpdg9fug+r88HD0a+IWu8tWW5QiqlFdegRdHDm+f/paomqbQ7vJIjgvSM/Y7YCY6v
	V/u/zLjg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wF79n-000kKF-1n;
	Tue, 21 Apr 2026 09:12:36 +0000
Date: Tue, 21 Apr 2026 02:12:31 -0700
From: Breno Leitao <leitao@debian.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: Initialize all fields of ip header when
 building dummy sk_buff
Message-ID: <aec-UcPm5pRZjcSL@gmail.com>
References: <20260421073738.22110-1-zlatistiv@gmail.com>
 <aecyEArzjx8KRp8-@gmail.com>
 <9ce273bd-6912-4442-8672-4c89bebf32ed@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce273bd-6912-4442-8672-4c89bebf32ed@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280062-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D932A438B66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 11:54:19AM +0300, Nikola Z. Ivanov wrote:
> On 4/21/26 11:19 AM, Breno Leitao wrote:
> > On Tue, Apr 21, 2026 at 10:37:38AM +0300, Nikola Z. Ivanov wrote:
> > >
> > > Closes: https://syzkaller.appspot.com/bug?extid=23d7fcd204e3837866ff
> >
> > How do you check in the report above that the missig un-initialized
> > fields are "tos" and "id"?
> 
> I don't think it is visible here, my guess would
> be because the checksum calculator walks the
> header in small chunks instead of referencing
> its fields.
> 
> The whole "KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt"
> doesn't really sound quite right.

That's precisely my question - how does this fix relate to that specific
report?

Were you able to reproduce the KMSAN report?

Thanks for the quick answer,
--breno

