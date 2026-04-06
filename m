Return-Path: <netdev+bounces-275769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLrQEhk01GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F93A7E0D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6749304F233
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C53A0B28;
	Mon,  6 Apr 2026 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBpXyPY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7039E6C9
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514569; cv=none; b=BRhe0dKMWuGD5bewixJxUVuWOKlcFluzwq6rPCXqoWL/CU87NFF2nbZff0MPpN4YCOgP6Z9yI2Y8MRZKK5CVWtcLiZby6/qg9YCWAaQnZEDr5GCRsi76iFPYhWcj+RdMQBgnoiXHRuqiFNt9aPBvAyYL356IBYgnG8gRdMmQU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514569; c=relaxed/simple;
	bh=ly20GkKm7KjhW4Dc1VIFXCpyqd8WAuk5mwY6t7I0cZI=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=OfnJ9NE09bdcc0AzRaKK5/SqKj759ms4Hh2x07JsoEXXC+ZEv1YNSQ7sFkI0E22QSHKPJ3+GhRa1zSLZphg2Ta6fgqLhzcNPXILnpyzM6WbhIa48jwpyo070eKWSTHa4jmsqjHk9KQyZ2URY9g4MnvjTsWCKmkPXIHCCJzd09Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBpXyPY/; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-662efd1bdd4so2574399eaf.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514567; x=1776119367; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lac1ksUZTxhmkaJqbjp3eZNyjVRnWnfYC4QU/bVakvg=;
        b=qBpXyPY/eyezT3xRLJkjT2K9I0fMvrIr/dAR/aEepz4oZ2TQq2OpZP5rD2kftBbWXv
         U2aooCwVxrJ0Gi7ZgAaHuFz/wmGnvM9iqr55fanEllwCcHK+df5VAAD/u4xKAzD8xtU8
         iM19trHIrvhUnAD/iqZu+2+1Nmg3gLsU4MPwFF9u4jlbcxg6dMJvoYIDw1ZXRVELYcEX
         Rexby2acbn5NOjAI1oswGayCMcnGGyyKtREuP0wbVGKscv6oWX5sZV0YzexNLzT73E4h
         GWJ0aILnZj9rZDPMX946qjwR1bwEWbqfA1IOxBQmWbZCkETRPQz/rOc9mRNFLMU0YSGs
         PSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514567; x=1776119367;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lac1ksUZTxhmkaJqbjp3eZNyjVRnWnfYC4QU/bVakvg=;
        b=Os20j8x7K0OSurDX0XumsG1aWtiMBeSkokF+1u6NcBnbkMKneGvUfGf7Or7ddCVVWG
         4nSYyRZYKAeQ9EEVDLUSYQL+0zEuW6HKrHdxndqGya0tgUPU3++B0AzKXPVgCEhN2qHX
         FB/PivRQcTdNYVCHJ63JszeJzsKL+d7o669daZ4GHhEW16tl6MOzxgWuQpg3SaXwLVdu
         9JgsYYVDtbzUR2MVtsb0STSXYdmw/T4PsS4GDYLWjWrvTS1YSLzE+W9jmwxvDIlnf8GL
         0IEXi2LqMWnaE42BpO9inrXLeDY7LSHYKpOm+ugPBDXysXCKjYTPBxvdqwLVxW9BrnRB
         HV7A==
X-Forwarded-Encrypted: i=1; AJvYcCVQY9WqjIEv9giw+5n3vqq+1Gi9xe3zHxOZDNx5fac8bxRUQlc1MuJSBR1KUV5WGeKsNGKcF/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBVZYHsEVTu2xN6RV4qrN56WHeR86f3CRZwzU5Rlmqvp73IO9
	41BOWdkNAXotA59CGCRqokviUX5EwfjtnB02OY12Pd68decC3EInXrlR
X-Gm-Gg: AeBDieuwD2BlKxV1VitUBEqtVQnjZeHlJbAMvQJQQhdlj6HVhcm2FOdPKA6baK3wdps
	Ugq9Unf+d0Sj4X7ZFsVEiXY8HYRKICzs/5WpbUkFapllDGH/GXRywpgXd6dMMYro/LQkvSb7J3o
	lvK2IQH1LFShhBO7Fmjub6kuFn7VE2fKBvl+0NS+0NziJ6FPVQ+PO7I/ppiH6ltJiWqUZCbBzt1
	VRrnJqmH88yhPeGsVhdmMUoEDuxR68sW6e9T1RGmKGyGAxfW7Ak00r1kSufoOs+bd/L7IVcvCwt
	0upyyXzSn6sqgsyeaIXSA9FIvLMtoZAWGkyJlB5IUQIjc4s9u34kbTvm7/SJKfLjyF+aV+nfSSY
	VwdUWGEqp0duhYk7PLgUZQAaDxqCOFZ/BlFQFnkq1LNEIGKOG3v7JVxTvUjjGsNUdRgQpQ3JtQL
	WQlsOJH7/QfCXTg0hf
X-Received: by 2002:a05:6820:1a07:b0:67c:28d6:430e with SMTP id 006d021491bc7-68220c420bcmr7072250eaf.28.1775514567375;
        Mon, 06 Apr 2026 15:29:27 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25acbesm14636279fac.11.2026.04.06.15.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:27 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:26 -0700
Message-ID: <a95cb49a0b70c701cdd1dd44c5e3094a.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000612.2414120-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 08/14] bnxt: use snapshot in bnxt_cfg_rx_mode
 (74e346419df6)
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
	TAGGED_FROM(0.00)[bounces-275769-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: DD3F93A7E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> bnxt: use snapshot in bnxt_cfg_rx_mode
> 
> With the introduction of ndo_set_rx_mode_async we can call bnxt_cfg_rx_mode
> directly. Convert bnxt_cfg_rx_mode to use uc/mc snapshots and move its
> call in bnxt_sp_task to the section that resets BNXT_STATE_IN_SP_TASK.
> 
> Link: https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com/
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> [ ... ]
> > -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> > +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
> > +			    struct netdev_hw_addr_list *mc)
> 
> This isn't a bug, but is the mc parameter used in this function? The
> multicast configuration appears to be handled synchronously prior to this call
> by bnxt_mc_list_updated().

True, mc is fully consumed in bnxt_set_rx_mode (bnxt_mc_list_updated), will
drop.

> 
> >  {
> >  	struct net_device *dev = bp->dev;
> >  	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
> >  	struct netdev_hw_addr *ha;
> >  	int i, off = 0, rc;
> > -	bool uc_update;
> > -
> > -	netif_addr_lock_bh(dev);
> > -	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
> > -	netif_addr_unlock_bh(dev);
> > -
> > -	if (!uc_update)
> > -		goto skip_uc;
> 
> By removing this check, will the driver now unconditionally delete and recreate
> all secondary hardware unicast MAC filters via HWRM commands on any RX mode
> change?
>
> For example, if an unprivileged user joins a multicast group via
> IP_ADD_MEMBERSHIP, does this create a time window where the hardware drops
> valid unicast traffic destined for secondary MACs?
>
> Also, if any of the firmware commands to re-add a filter fail, will the
> function return early and skip programming the RX mask entirely?

I don't think this is problematic, but I will the original uc_update and
bring back skip_uc, that will skip unnecessary uc list transactions.

> 
> [ ... ]
> > @@ -14684,6 +14675,12 @@ static void bnxt_sp_task(struct work_struct *work)
> >  	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
> >  	 * must be the last functions to be called before exiting.
> >  	 */
> > +	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event)) {
> > +		bnxt_lock_sp(bp);
> 
> Could this introduce a race condition with bnxt_close()?
>
> bnxt_lock_sp() temporarily clears the BNXT_STATE_IN_SP_TASK bit before
> blocking on netdev_lock(bp->dev). If bnxt_close() is called concurrently, it
> holds netdev_lock() and loops waiting for BNXT_STATE_IN_SP_TASK to clear.
>
> When bnxt_lock_sp() clears the bit, bnxt_close() could unblock, shut down the
> device, and free memory including bp->vnic_info via bnxt_free_vnics().
>
> After bnxt_close() completes and releases the lock, bnxt_sp_task() would
> acquire it and unconditionally call bnxt_cfg_rx_mode(), which dereferences the
> now-freed bp->vnic_info.
>
> Would it be safer to check test_bit(BNXT_STATE_OPEN, &bp->state) after
> acquiring the lock, similar to what neighboring handlers do?

Will do, this seems similar to handling in bnxt_reset.

