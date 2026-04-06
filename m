Return-Path: <netdev+bounces-275763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACZ8Ddsz1GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B01423A7DD8
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71F9E301910E
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA239E199;
	Mon,  6 Apr 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDDE2B6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D7331215
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514564; cv=none; b=MLe1D0eTi2ztpFUcP99ONwnG6n+5Dc4RmDQHoBehG5MYCopkERLu1J6wi+vMY4HBZXgZkzxHeGQ+MQ/agDZmO9Kk+kMASR0dRttITciXykxrpss1gvwsa7LjIprCHtZaIKExUS74lTrnVcqvJWG+M9n/OP+zrcVdgyaR5q1HTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514564; c=relaxed/simple;
	bh=MzJD9UmEG4sMm67pvX/Vx2nBGsU/3YHgDlsehVqu5j4=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=Wr4DpJF2DcbPb4HrP/o0V1VOplzH5gctGUglK4CUhK6Gt2HHYjbNEZA8VeOqIXaOcRB3rG8YRU86UPEDxFDID+mB+gmwJcnN4WElAeMyw7pN8BaX3n3750/HqBzuOew6VGhTGt3wKQebERjhM15RDGVXtvdu1jLDqM5XxvTaO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDDE2B6G; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-46fb6d65c28so916898b6e.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514562; x=1776119362; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DkvqhizTxEB9VE/2Oox3stQjf2DifB+wrjIxsdhk4G8=;
        b=sDDE2B6Gc4+HdjPLyeI2pbn9ToCqpLXUQvcgDZsyi5oMnMm1W4lWirM+web03Nb2J0
         Gj6JEkE64Std1zSCh0jFi4mt+T4bxWPthhdDCLPg53fHLqnhwFc9S2oNSr7O5KQxaqZX
         iFKZEMzDe/aUvK3FeSNLscnsuIKuz7LWbJMiiN1dLVjL2N8j1+RviLRElYpV+ItyxyJR
         swF0kM4j8W8IWo3OCLJn4wi5FgWtXUY06pcV9YiBO+mkK61ynbzQWitioXeRmEX8VigD
         VZD5T5+3BWk5RuriaO1uprLwPKwQCUqO39XkpaQPfMmE+TR3c0i/BBiqjIf+iXLWOdTK
         MKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514562; x=1776119362;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkvqhizTxEB9VE/2Oox3stQjf2DifB+wrjIxsdhk4G8=;
        b=d7dg1eq69KvoU6WuuhAchZj9mQ1pNgqNASueJ6aiUhaqjx76omaOps3sfa+/9Jm4AE
         xOvQw4c6jvT4w755kGH0AY8OD1Sctw7l3u0CLxsX0ghTHpzClQFsbhhkTd4kMJyHV04r
         hxhiv0qCfLHvmL5o62uy4fk5ygmqvdjwHn3ApEY1s9b8/6gwvKsKSO5V0JtCSTrGEFzZ
         27F4Cwlc/a49KAXl6wQlNvnL+b+V8eQ4tXAAFu70bAgRNUfFewC5sGoQwroX1gDbd5aF
         2FA/QDkXA1lplpJVdZWT5k7/8KzMcnjQWkwp49SDNMihwUuPnZhGr4cUCZVns3RfwbiJ
         6Q2A==
X-Forwarded-Encrypted: i=1; AJvYcCUkMt/VenmhDPMyft0gKQBtJQ1m6whnS0ezB/ViyhUHN+B90BA3ANFw06MM5NO5Nr0ENFllKPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKB/2d4S8mZ+bJyR0VNBOPUnJSaokEv75j6QlUK09RBuIVs/P
	2whNhaJEcBTgVAQeI/u2Hn4II1k42Ec2Ocq1Ds+nsGG9t4t0HK/SL5SE
X-Gm-Gg: AeBDievWLIq1oxXGP4biqETlVx8hEm7Ppo/8wG2VY64sio2e2GYMWvSsSAeoFwZRlfZ
	OxvCvP5AQgCDaJUaM4zarCecNk0MHzWTtLZGpdJSAagKQEtkauEpw6bAqWm/c/msPmCywtrsnQs
	m8wQWFsRjwJy8jIjmH9BocMOmr+MKHp/1aKV/p1QpJCwUCaZJ6UuVMGf4sJhQzPsB8xNpdJ+Gc+
	0qzPXUgR77QNNbY0fPsu+h6zDFpdsr5ufCOkj0c01CPRZI2q0xx64p90D7DDEDWZHp4xbNbN1fm
	ETba/omoFzeiOas3s+8dHxetp6pXMGP15QjmBXJAGNdNIp87wBb1ccADkMdNXI/nWNDqVQVmKMJ
	p0LMI0XLB8sX3QJXvEJ3jhctTn4jpbufR8vVGLaX5D4dEpQl2mDu5NHr2H8AZ00nCBGCEq7gHdA
	g3c+FxO3OdKwf8BKiriA==
X-Received: by 2002:a05:6820:2007:b0:67e:3919:4aba with SMTP id 006d021491bc7-68221533624mr7808142eaf.51.1775514562416;
        Mon, 06 Apr 2026 15:29:22 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4235e32d9dfsm3936967fac.16.2026.04.06.15.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:22 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:21 -0700
Message-ID: <008bdbac81f0bab31aa80dd3cdb47acd.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000611.2414085-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 07/14] bnxt: convert to ndo_set_rx_mode_async
 (c1776bbe53ec)
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
	TAGGED_FROM(0.00)[bounces-275763-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B01423A7DD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> bnxt: convert to ndo_set_rx_mode_async
> 
> This commit converts the bnxt driver to use ndo_set_rx_mode_async, updating
> the rx mode callbacks to take explicit list parameters and iterate over them.
> 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index fe8b886ff82ea..569c7de7c5e44 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> 
> [ ... ]
> 
> > @@ -13523,17 +13524,17 @@ void bnxt_get_ring_drv_stats(struct bnxt *bp,
> >  		bnxt_get_one_ring_drv_stats(bp, stats, &bp->bnapi[i]->cp_ring);
> >  }
> >  
> > -static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
> > +static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask,
> > +				 const struct netdev_hw_addr_list *mc)
> >  {
> >  	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
> > -	struct net_device *dev = bp->dev;
> >  	struct netdev_hw_addr *ha;
> >  	u8 *haddr;
> >  	int mc_count = 0;
> >  	bool update = false;
> >  	int off = 0;
> >  
> > -	netdev_for_each_mc_addr(ha, dev) {
> > +	netdev_hw_addr_list_for_each(ha, mc) {
> 
> When iterating over the list, bnxt_mc_list_updated() performs a memcpy()
> into vnic->mc_list.
> 
> If this executes asynchronously while bnxt_cfg_rx_mode() is mapping
> vnic->mc_list for DMA to the firmware via bnxt_hwrm_cfa_l2_set_rx_mask(),
> could the NIC hardware read torn or corrupted multicast MAC addresses?
> 
> Even if a later patch addresses the explicit list TOCTOU issue, is a
> driver-level spinlock needed here to serialize vnic state access between
> the two concurrent workqueues?

This is not something new I think? The same split was already happening
prior to conversion: bnxt_set_rx_mode updates mc_list and queues
BNXT_RX_MASK_SP_EVENT while bnxt_sp_task does bnxt_cfg_rx_mode.

After the conversion, both paths should be under ops lock, so we should
be in a better place.

> 
> [ ... ]
> 
> > @@ -15881,7 +15884,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
> >  	.ndo_start_xmit		= bnxt_start_xmit,
> >  	.ndo_stop		= bnxt_close,
> >  	.ndo_get_stats64	= bnxt_get_stats64,
> > -	.ndo_set_rx_mode	= bnxt_set_rx_mode,
> > +	.ndo_set_rx_mode_async	= bnxt_set_rx_mode,
> 
> Since this callback now runs asynchronously without the netif_addr_lock_bh()
> that the core networking stack previously held, does this introduce data races
> on the driver state?
> 
> With bnxt_set_rx_mode() executing locklessly in the netdev_rx_mode_work
> workqueue, and bnxt_cfg_rx_mode() concurrently modifying vnic->uc_list,
> vnic->uc_filter_count, and vnic->rx_mask in the driver's bnxt_sp_task
> workqueue, can they race when accessing the vnic state?
> 
> For example, could lockless assignments to vnic->rx_mask in bnxt_set_rx_mode()
> temporarily drop hardware fallback states (like the PROMISCUOUS bit) set by
> bnxt_cfg_rx_mode()?

Hmm, this is completely bogus? I don't see "lockless assignments". After
async conversion all these paths run fully under ops lock.

