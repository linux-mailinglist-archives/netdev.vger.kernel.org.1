Return-Path: <netdev+bounces-280502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NfyDhf46GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA323448B2A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02E52300827D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A8237F8DA;
	Wed, 22 Apr 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edStutVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1837C90B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875495; cv=none; b=U6pi0tpGh33N4YEr5KDSOJVKVoH+My6WNEbU0/imu85agGzdRTK3yNlcqSBKhaRmplB3dqb+dc4X5XpbGbLvuEQE/tOc1HaBca+JhU8jXAPWMEjFiPdnkuidjb7hwXepzaZGcitmPGDWJoGdEns4+I5o9A/J7GEV8CuuZuZ61/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875495; c=relaxed/simple;
	bh=EhbGxSycWRGGPRefyE2yZ3qZMYiLgTkVaA9SF3zTDqM=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=oou1wplPS5y+sJJYV9dfgjNOABooEVyrZsETjvmA1BRPBt+AvGi1E1K09/hxeXDAnTRQEiXuEdmGdowzU1S0pVSE6Ij8Wux+s52AMMt0BMWFpMRfgirXZXXOt83BT6dK2OOhJ4aasZiTDx5eLPiyzrXsONoB2SaxE4m9Cmuf0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edStutVr; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-40946982a78so2036627fac.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875493; x=1777480293; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=psTO9IXagb9gvkh6TivZ2kclv53ax7Oa2qxYLSN87Vs=;
        b=edStutVr04h0IppyIN6HYAGwxl2Q6hEMmn2/TVhKb+tfx2flSK5BpRwgIuNoErQrkG
         nRRknpM0yAaHnCnnVNxSMwwEfuB6VY9lwXdbQaL+k77jF81TByQaLu9usXzkwQYju7EN
         noZ0uMRZ9Aj2RFxZEhC1qGE4QFEUD2evB5cyDxjkd0yIayss0yqI0x+r7QvMjtV5nfkr
         v2iD7gIjQGkFYlJ8gOIgd6+S3SR/ytn5wlKeYfCfiG3+f3fnUDstRAW+OqvgYepYObXS
         FrCqHBC0JPz9F5mo9gGnKVltwqhv33dy9R+zlpkYD4bUSFDHdUCkVeFLHTef/geZEnNf
         3N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875493; x=1777480293;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psTO9IXagb9gvkh6TivZ2kclv53ax7Oa2qxYLSN87Vs=;
        b=Ij447Fi04GXseUi6nw2K2TnXZm3jQRbhMB92iiWNblLJ9mYOqKSijFAw3OhE+n1D69
         mkrJgEPzp094sriZEZOekdbxKKIAmypHc8A0fVwCRQkvLQEgzlfVBFWnYX8xX/3ID7SV
         lBPj+0x/ELiGPs6Ktu45E+IDU/HwbPXaAeMY/ZmNeTgqz/9bn+NFae5RtKWCbtGzEJDL
         EZV61HhsgXBNqxboGUNz0fZWo1UkdyLlTzBvLF/4OY4x+HFe74djAmSiNsHkmCw4vyZY
         v4Usmn8kKHQt91RWA2SzYemzVcCmRuJ4GquoTcn9PjRIIpqaoof6ufutaaWNzwMmmp82
         WiqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IazsNOx6ELDD74/tQG9cHdyS3lq+Bt0SQYtlkKVS8td8RNEh/aN5AnsGo/7VnruybP17B2cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhF3mThy0qThFbXsg3YFH/7GLg9DrLedXj6TmNYi1BnAM2latl
	aWZKeDyM10vVlrn/3G2FX3GysJaGrs2s4d9LHLWlJ/hsDyPnb9LM5QjK
X-Gm-Gg: AeBDietuupARMcD6nvrQLNnU/R3SEtWxeqfijkMVc/CxvWWOC1rgjb+sBd2NZ9B9RAW
	m6XLnBHZ0M4P5U48hEg0CpYHHpO2XXGD9YOFx/FdDKL+aGbeuqhoqmRTKxn/k24+V1tgjQbLiTs
	KtKbDoO05aPTqtbLnfpA/e1XFYbD58z25GcrNU6Shq5daeXA53tKxTovsqp8w+qvqw4WczlCHXW
	/aNRp9bwYvMTXw5yNbs3mhQtPew8EqKFwPWL7JEuJgtkbhi+1XygMEDpNsc84C50PnbPHzd9aeZ
	Oa7KEJisa0CwMS46plLlU0zvfBlRnaLeJdwyzLlXXah4rrTMjTQcCESbtpwbuDbg/DYtfL+ne97
	RJ0mArQezAQpF5tcjBTpMe98RSTB/yJgpnJlyxri62JxfFTrSy+GWPNIL5rjiMvvoINc7mTkENX
	tEQJkCVrVbEzN1T2sD6jrR/jjiMHM=
X-Received: by 2002:a05:6870:1767:b0:423:188a:f0c4 with SMTP id 586e51a60fabf-42abf2543a0mr13964157fac.3.1776875492480;
        Wed, 22 Apr 2026 09:31:32 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42fb269f69bsm4365305fac.12.2026.04.22.09.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:31 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:31 -0700
Message-ID: <1b3207ae8f4cfdea6bf857ca4211b355.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-4-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280502-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: CA323448B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> When xsk_build_skb() processes multi-buffer packets in copy mode, the
> first descriptor stores data into the skb linear area without adding
> any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
> to accumulate subsequent descriptors.
> 
> If a continuation descriptor fails (e.g. alloc_page returns NULL with
> -EAGAIN), we jump to free_err where the condition:
> 
>   if (skb && !skb_shinfo(skb)->nr_frags)
>       kfree_skb(skb);
> 
> evaluates to true because nr_frags is still 0 (the first descriptor
> used the linear area, not frags). This frees the skb while xs->skb
> still points to it, creating a dangling pointer. On the next transmit
> attempt or socket close, xs->skb is dereferenced, causing a
> use-after-free or double-free.
> 
> Fix by using a !xs->skb check to handle first frag situation, ensuring
> we only free skbs that were freshly allocated in this call
> (xs->skb is NULL) and never free an in-progress multi-buffer skb that
> the caller still references.
> 
> Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
> Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6521604f8d42..d23d1b14b8b4 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	return skb;
>  
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb)
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

