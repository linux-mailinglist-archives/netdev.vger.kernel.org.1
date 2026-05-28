Return-Path: <netdev+bounces-292856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI64F1+1GGqkmQgAu9opvQ
	(envelope-from <netdev+bounces-292856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:36:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF35FA793
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0547031123D3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A91189F20;
	Thu, 28 May 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2LTUN/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812D32B133
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003829; cv=none; b=Q9QlHVr6ZhU2dgzt75wWiQUrXQ5pdxWuXNFU6LlDalFopaM4iny8H3SsLbGds7wbzCJVtMEf5ZmyJMFxs/kxLwiaf6ghOXJLxfrgeRylobYGymnYUrI6J7JNlIhapwe2cfpzPCP75e+UJM8N0cPjK3C46hAzaJ41AkdN29cVwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003829; c=relaxed/simple;
	bh=KktdQczfNPn6se2A3z/r3WvP5Fyt+sni/sBBiuynN44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukpxxM5y76U/T5/Lf2TXs+v9wjLAhhxU+Qk63buoJ6lmd/evVVBRc8pGyJ4p9/3SimmckYSJJdn/gqrRcwEwJDkaXZxR8z2mWuyMitXGPI0QxsUEpwzuZRLcJWSc7XitWHZ+iYd9XikRAN10crx/b0VCKKGin+UNqdef1nb71sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2LTUN/P; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36b900f350fso920502a91.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003828; x=1780608628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZKy82ELN5Whe0oTVvgWvJ3m4iw4Z7O8f3Er//w/MzI=;
        b=X2LTUN/PFYfJ/raHJYnEchlRkFcy9s9i1/VWJhayYk7A9z0NyOQmiJ1HMewkPTO+bY
         px1fUh7pAe3/NzMx5Hl9uvG36gB+n1+JTTyYTd/Vk2+xeXfOgJYbzdHWxnckbeaH6HJS
         J2WqFgwAjspi4DETg4mSFAPI9v4E5NTQEUKZu0AElOpsGgomTVGRu33C9KuB28DTGiNn
         w9gkVC6XefOE3x1S1tZXo8egfFD7a8z/NL+WPPTtOS2ladjlXvJXqdTazmObk9Ldwsg7
         fT49j77eMycZvYxn0R7GBn0gIJqp7gTAI9lRZiDyvWU0Zqn2/uZlpSUHyXdowZNpLjJJ
         oezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003828; x=1780608628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZKy82ELN5Whe0oTVvgWvJ3m4iw4Z7O8f3Er//w/MzI=;
        b=a9EaPYOC+bEMeiqmcskhRsCBfxCnPlP1Zd0QfvhHX7OiFjyw6w+0ItbLPXKzwH5KiR
         HbyzagiZ0q0OtUvfIHI7m528slr7pnlITWpko4y9QlycLY85aYtcWpLHWSqtgYZycniN
         5lFjyUvYY/wtxXYIFtSw8JqvWjos2n7GhjStU73uIRxuog8ksRy+IJ17xlyPDn+ASwA4
         2U+Y594xjvvtkA4URT3HhLY7OZmLTrSqh19JZS40mfp+BVhW+LE2HZHYin4d8tksJZHs
         yak8kdpCmq2nbOAMjzi7WTE04YsO/0OL8AQB3Dbf0NWXyb4W2f2LyXqMvSdT0neLhIiB
         WkHw==
X-Gm-Message-State: AOJu0YxOnmJgVW51q73GKBJmJ9cbY14AQaSy6cOQvL5lt88IvjeZrs2A
	LNMGUpNw53nAIXESABtVpxf70yKlMbJlf8WK4L+18s6RPlzYBl0q21GI
X-Gm-Gg: Acq92OFyGNtJfWiFWAotHvpd3zwbUbjBNXC8pO2A2ahAl6UliuUM9PucCcFdTDUAXFT
	sIhAYOB3Yd9wUcnV8hHoaB5Gq/kWRXVxw4yFrHnGmj8x/aYPyrETYj5ZxvGh80HFwZnkDEAgzv4
	IPLQoL4galdwixvDtqfedujsUNJVpVukAJc7Y4bJFepXAVSFIXUMWstCKulG9UDK+nB9/Ayns3K
	BjajkGyBOQP2BhRkvTEC6EwkEAyxa4yO5bgKx6vAKgcw+ELUjKXEqVHiPdASEoi6fwm7D9YstCm
	SPTs8eDhugvZm4oXfCVeFOZap1yG9TtjuH2t4JlP8UhgIQoDs+qWnESxm0wocEDatiPQ5B11hqU
	fs6jpv/pTUiH7/FtY/9dJsAVCNOrnhr/U5osPD//gw/uYuGQLmF0MOwtZRgPbkFEuGzLsvp/lMc
	4COwUQZIwQiMC9fiDon3QC5b7Y2rw=
X-Received: by 2002:a17:90a:ec88:b0:36b:203d:9755 with SMTP id 98e67ed59e1d1-36bbcdb10a0mr277692a91.19.1780003827702;
        Thu, 28 May 2026 14:30:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbf344eefsm18605a91.3.2026.05.28.14.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:30:27 -0700 (PDT)
Date: Thu, 28 May 2026 14:30:26 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next 3/3] bnxt: convert to core rx_mode retry
 mechanism
Message-ID: <ahizyCDm5Co5SlZI@devvm7509.cco0.facebook.com>
References: <20260527014117.1401809-1-sdf@fomichev.me>
 <20260527014117.1401809-4-sdf@fomichev.me>
 <CACKFLimk4fauCzfnPDZYjLPqYfo0bYTbCxoCsK3GHBSJ-9vmkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLimk4fauCzfnPDZYjLPqYfo0bYTbCxoCsK3GHBSJ-9vmkQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292856-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: CBDF35FA793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/27, Michael Chan wrote:
> On Tue, May 26, 2026 at 6:41 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > Remove the driver-specific BNXT_STATE_L2_FILTER_RETRY + timer + sp_task
> > retry mechanism and rely on the core stack's ndo_set_rx_mode_async retry
> > instead.
> >
> > bnxt_cfg_rx_mode() now returns errors (including -ENODEV when the VF
> > cannot reach the PF), allowing the core stack to schedule retries with
> > exponential backoff.
> >
> > Call core's netif_rx_mode_schedule_retry during reset to handle
> > VF reopen.
> >
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++---------------
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
> >  2 files changed, 12 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> 
> > @@ -13757,21 +13763,14 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
> >         for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
> >                 rc = bnxt_hwrm_set_vnic_filter(bp, 0, i, vnic->uc_list + off);
> >                 if (rc) {
> > -                       if (BNXT_VF(bp) && rc == -ENODEV) {
> > -                               if (!test_and_set_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
> > -                                       netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
> > -                               else
> > -                                       netdev_dbg(bp->dev, "PF still unavailable while configuring L2 filters.\n");
> > -                               rc = 0;
> > -                       } else {
> > +                       if (BNXT_VF(bp) && rc == -ENODEV)
> > +                               netdev_warn(bp->dev, "Cannot configure L2 filters while PF is unavailable, will retry\n");
> 
> Maybe we can set rc to -EAGAIN here so it's easier for the caller to
> check for retry.

Yeah, that makes sense, will do, thanks!

