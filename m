Return-Path: <netdev+bounces-282141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G9yHVRB8WlsfQEAu9opvQ
	(envelope-from <netdev+bounces-282141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:23:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE548CFA1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5500D3032F60
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6521388391;
	Tue, 28 Apr 2026 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVn9by+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22172C08DC;
	Tue, 28 Apr 2026 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418575; cv=none; b=Wn43w9r3hNyW9LM0Ttkz9BCWAk4fmz85HNm7mG+ZRs6r0kZAHyDbXwcikuBGABBGS8cTyyNvo1bY5RDs8qDTiL7O1KoJF6QDqjQ9SdLETXqkd1Hkc4gxTKw/gZ7PYUgBa5AxAoGiDBeI6nL2fB6vnT1KtJjrnuh82IdLlx63FzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418575; c=relaxed/simple;
	bh=l8W1qxSrVvflCqGmyesfCsVCe328OIy0LwoIhCBOM1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJfdRmDsYSTkB/HWBXE/1xKKy31a5Jckoi7t8MRJIWAYWMEb2zMLkJMgEMEmb42jPsBpi0o5ELB59kG63yKHAj8B9Vxwpodd4AWV6FA/jIbg8I7lClV/CXza6t9UvTZxKzyDp3swzbuje6RAlHC6uxNyPMftOFsarbeZuRgQJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVn9by+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E775C2BCAF;
	Tue, 28 Apr 2026 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418575;
	bh=l8W1qxSrVvflCqGmyesfCsVCe328OIy0LwoIhCBOM1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LVn9by+iLoKBLMnBlHU+Y/zYOUPoHgd/Mmb1fWnwxS9RE++hyw1bKIFXyUO9nQQ/i
	 yuwuEf2j8bmOxDUe8L+ia9/9tAPu5pDA5BIwEu0T5EXwOqPf346+Svm5dBS9uGcQNb
	 wKRmUxAJsx68abOBhEOV+AY5e1HhZZA3D2qNgYOIAyaXE7YhEG+VhcFFTX3VQigdFX
	 xM+Q5G3WtkpXdD2pYVwZToAf0C47CdHvRnXpmevN6tjg87JcfdSY3Aby5KOT+ubXZ5
	 h0nn/pYfERcnDv2CWxHa6on3sRbpaec1EoxtMIEDMiHLB/DpSy9yA05UjmsAXxQC7j
	 qIaav6eCtrajQ==
Date: Tue, 28 Apr 2026 16:22:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jordan Rhee <jordanrhee@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 willemb@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, thostet@google.com,
 jefrogers@google.com, alok.a.tiwari@oracle.com, yyd@google.com,
 jacob.e.keller@intel.com, linux-kernel@vger.kernel.org, Naman Gulati
 <namangulati@google.com>
Subject: Re: [PATCH net-next v4 3/3] gve: implement PTP gettimex64
Message-ID: <20260428162253.2228dd5f@kernel.org>
In-Reply-To: <CA+mzVtuviy1k5-m3saQEtCL0YPUwfKBJWjC54rw+1y9ypFM+Ow@mail.gmail.com>
References: <20260406234002.3610542-1-hramamurthy@google.com>
	<20260406234002.3610542-4-hramamurthy@google.com>
	<20260409201646.6af5235d@kernel.org>
	<CA+mzVtuviy1k5-m3saQEtCL0YPUwfKBJWjC54rw+1y9ypFM+Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C6FE548CFA1
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282141-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 08:49:31 -0700 Jordan Rhee wrote:
> > > +static int gve_cycles_to_clock_fn(ktime_t *device_time,
> > > +                               struct system_counterval_t *system_counterval,
> > > +                               void *ctx)  
> >
> > Does this do anything GVE specific??  
> 
> No, however, I would caution against adding an API to the kernel to
> convert TSC to ktime since this could invite further abuses of TSC.

I don't understand. You caution against doing something you're about 
to do? In case I didn't ask for it already - please make sure you CC
time keeping maintainers on v5.

