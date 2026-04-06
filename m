Return-Path: <netdev+bounces-275762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMxzKswz1GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3D3A7DCA
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252E13022F76
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA4391845;
	Mon,  6 Apr 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sp100Owj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104F277029
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514563; cv=none; b=JrVcBELwpPZgLkMcn6vDK93Xn9W5ofo7d89wapbgQLrxhZydMOzbAW85cBKf3zR7V1VP+95EJtQyQCivdgZHMAY2cK57wsLCEJnx52gcuYxTm6uhLIZngpoaWwFA/PC+lsSHrPU6qxT/fWht6vdXg0agC2C7kgp/1C5htorJO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514563; c=relaxed/simple;
	bh=KrLFuMihCS8tuqnW4Biw2BV9nydLzoPm+VKN6vxkByI=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=SJwRWPbVLyYMak1d/A5dOu5nV8JY/rtYRpEBapjuqNgIaP7tuGlxmwnL2KIN8LhIvDhgshk+m0AQueLZ4Exr1vuo4vnLJ9t5ARDFpo1XcL2SqytQgb4DCdWrRLkjCVSOfqhUT9Vb0eSu+70nOpsTdTTTG1d9GCHDfY1ZNeyGOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sp100Owj; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so4429302a34.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514561; x=1776119361; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3GmcPnlUufMCDun34KQixtfd/ICERAmpqgEZxI54nNY=;
        b=sp100OwjzlQwk+yaPoWNjMKOSxcRCUiSXWQNZ++mcpmknbd5RZqaulzSs+3zCoTevI
         dYnVBNfLW6oj6XjbDTsZrPsjnD33Nno6l85+PjzpDG+2eyeTcaB+2i7TCID/uKDXmZRr
         qJK+UAx1rKuLsNnCddNRIODZq5iGtQs6vcjqH5exO8+2sWTqh4dYppnVj3uV3uIdGliK
         EtJzBpOaZp0n2kyC0kEzMKC6e0WbOG7Xxbg+HXoHtMcfkg+egXGaUqTp1PqpEjv/lElh
         vGeRiF2CVDJXeWMxza+lhaP8MIqRZw3Li81RUuDFnhAW+IWmXRxLjdyDbiBGQHvJvfUs
         HJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514561; x=1776119361;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GmcPnlUufMCDun34KQixtfd/ICERAmpqgEZxI54nNY=;
        b=L9d23PBhLEOyrF1pki4WBl0Kt4+d1fj+fZlGPtxIvst+93bigI/S3d57oMEZUSYMWw
         V9oPKsyZv0Gf36R2UbThYAdaHWyVdE3vlrhhfRQLq3BELJiYZjo4CXww/4h0LtM/9B0W
         ba6hWsfVALqFEpppxz+veGZ/9zZRnLFi6crttgByqkgpJWQdMxl+z+TqpfB6+tXk88Ns
         3KASFzfP/XzNFkfeWWmBxcDcslmTI5SdGW+VSzVeRTjr/nIurf+XvOA38CFPjiuWTiyl
         SoOEZRTWN9nbTJOzeDxsXCHfmXFW3lqFtO4Xt1EaI9AS6cTX9O6oPqgCjAWTDFP2FOV9
         O8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5xUrOalApNs3Z3d39Nyll55qU5UcVx31/x1W+EfSuxlXRBYKWtJXr+0ITAkID1xSWnUIL4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/AtCKTrqUJnP6saJXDzVCzHBd+bc79bYHzu4ChEzVsZpAkyy
	mYtQcTjwOVjmY48QEtZomDFBzSrfg61GmuIWWrOrsXmsaR2bYEoQjPIatTYyW2UHoyM=
X-Gm-Gg: AeBDiesYDuL8TeLl554IOC0bNp4m6nfB4TqLA2A2WWlkmofdWQ2m8/Z+W88gz9Dp5G9
	zZ2BkT2GqDZyWjHRSQyQEMI1hFrlXFD/Q5EFbiiwoRjY7t6mJqpVHvE4Ewuj607RYnTD+mAIqSw
	IENYd6/pexrm0YxN7PwCxmCO3emZU/nYYq4iVk6ZVDpdfecGeo/qxiv2mXydh0zItuJ1DeybEcJ
	D1PxYzqPxuaLgalc0rchz4J6pT0ekcWrXTQx87bHZa0IVb7VPenRsAOU4ODWolHJr2BQNzzInED
	qC5KuoFD7mr0dx4QbOSUJ37RQVw+XEa6Rb2UZdPzTJRnvdiMKQVUq3xlzgPU9EKT/b1++YEWcGy
	TnOE8mZzTX8czHcFJGKVw4CoKLlRDhJBbNENLCdn9SJAmD9joHsn7QeGohM1bBA+l8TooMZmjCt
	6+0uyxyEv2Pmffasb5mQ==
X-Received: by 2002:a05:6830:2546:b0:7d7:49bf:48cf with SMTP id 46e09a7af769-7dbb6ee704emr9338074a34.4.1775514561521;
        Mon, 06 Apr 2026 15:29:21 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbd7c98b11sm4442025a34.0.2026.04.06.15.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:21 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:20 -0700
Message-ID: <d6fb496a84ec3809eaa6c417132d5e2d.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000602.2413848-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 01/14] net: add address list snapshot and
 reconciliation infrastructure (123ac7a76378)
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 54A3D3A7DCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
>     net: add address list snapshot and reconciliation infrastructure
> 
> This commit introduces address list snapshot and reconciliation routines
> to support the async rx_mode path. It provides functions to snapshot the
> lists, and to reconcile the hardware sync state back to the original lists
> after driver processing.
> 
> > diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> > --- a/net/core/dev_addr_lists.c
> > +++ b/net/core/dev_addr_lists.c
> [ ... ]
> > @@ -501,6 +503,114 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
> [ ... ]
> > +void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
> > +			      struct netdev_hw_addr_list *work,
> > +			      struct netdev_hw_addr_list *ref, int addr_len)
> > +{
> [ ... ]
> > +		real_ha = __hw_addr_lookup(real_list, ref_ha->addr, addr_len,
> > +					   ref_ha->type);
> > +		if (!real_ha) {
> > +			/* The real entry was concurrently removed. If the
> > +			 * driver synced this addr to hardware (delta > 0),
> > +			 * re-insert it as a stale entry so the next work
> > +			 * run unsyncs it from hardware.
> > +			 */
> > +			if (delta > 0) {
> > +				real_ha = __hw_addr_create(ref_ha->addr,
> > +							   addr_len,
> > +							   ref_ha->type, false,
> > +							   false);
> 
> Does this code silently leak a hardware MAC filter if the GFP_ATOMIC allocation
> fails? If the software loses track of this address, it appears future sync runs
> will never unsync it from the hardware.
>
> Could this failure be avoided by unlinking ref_ha from the ref list (which is
> about to be unconditionally freed via __hw_addr_flush) and moving it directly
> into real_list?

Will unlink the ref_ha from ref list and relink, that should work.

> 
> > +				if (real_ha) {
> > +					real_ha->sync_cnt = 1;
> > +					real_ha->refcount = 1;
> 
> Does this code break compatibility with reference-counted sync APIs?
>
> While __hw_addr_sync_dev() increments by 1, drivers processing snapshots with
> __hw_addr_ref_sync_dev() might increment sync_cnt by the total number of
> references. If such an entry is concurrently removed, recreation with a
> hardcoded value of 1 could instruct the next async run to unsync only 1
> reference, permanently leaking the remaining hardware references.
>
> Should these be dynamically initialized to real_ha->sync_cnt = delta and
> real_ha->refcount = delta?

Idk, I did convince myself that the delta can be only 1 here and felt
like it's easier to follow, but will switch to sync_cnt=delta.

> 
> > +					list_add_tail_rcu(&real_ha->list,
> > +							  &real_list->list);
> > +					__hw_addr_insert(real_list, real_ha,
> > +							 addr_len);
> > +					real_list->count++;
> > +				}
> > +			}
> > +			continue;
> > +		}
> [ ... ]
> > diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
> > --- a/net/core/dev_addr_lists_test.c
> > +++ b/net/core/dev_addr_lists_test.c
> [ ... ]
> > @@ -225,6 +245,339 @@ static void dev_addr_test_add_excl(struct kunit *test)
> [ ... ]
> > +static void dev_addr_test_snapshot_sync(struct kunit *test)
> > +{
> [ ... ]
> > +	netif_addr_lock_bh(netdev);
> > +	__hw_addr_init(&snap);
> > +	__hw_addr_init(&ref);
> > +	KUNIT_ASSERT_EQ(test, 0,
> > +			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
> > +	KUNIT_ASSERT_EQ(test, 0,
> > +			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
> > +	netif_addr_unlock_bh(netdev);
> 
> Will this cause a system deadlock if the assertion fails?
>
> If KUNIT_ASSERT_EQ triggers (e.g. from an out-of-memory condition in
> __hw_addr_list_snapshot), it immediately aborts the test case thread and skips
> the rest of the function, leaving the netif_addr_lock_bh spinlock permanently
> held and bottom-halves disabled.
>
> Could this be replaced with KUNIT_EXPECT_EQ and explicit goto error handling
> to ensure netif_addr_unlock_bh is always reached?

Will do.

> 
> [ ... ]
> > +static void dev_addr_test_snapshot_benchmark(struct kunit *test)
> > +{
> [ ... ]
> > +	for (iter = 0; iter < 1000; iter++) {
> > +		netif_addr_lock_bh(netdev);
> > +		__hw_addr_init(&snap);
> > +
> > +		start = ktime_get();
> > +		KUNIT_ASSERT_EQ(test, 0,
> > +				__hw_addr_list_snapshot(&snap, &netdev->uc,
> > +							ETH_ALEN));
> > +		duration += ktime_to_ns(ktime_sub(ktime_get(), start));
> > +
> > +		netif_addr_unlock_bh(netdev);
> 
> Will this also cause a deadlock if the assertion fails while the lock is held?

Same here, will do.

