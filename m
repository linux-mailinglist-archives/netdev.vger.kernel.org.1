Return-Path: <netdev+bounces-276203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMWnCd2R1WmZ7gcAu9opvQ
	(envelope-from <netdev+bounces-276203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C35BF3B5734
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6DA301F9A2
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89EC388E52;
	Tue,  7 Apr 2026 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="gYmOn3Ho"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AF345CAA
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604183; cv=none; b=f70Hggs+Lab0n2tLSMRznEdGpOWdmwSdxr77tJVpNF982GHZUJ0UwYwwI0WMqV8wfm/4DCxDTBhv7clCh76pq7Z+79XuRnpxpbm65l52rVlbUzbrrMhSUDMtRVjMlfD0IPAEDCyJMcDKBLCcfquP85+O0XK8+h0/T7NuZpXJYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604183; c=relaxed/simple;
	bh=2ld9iGsd3tkfTJ7I+r4T2HzSpJWuUQNwwqwlZBNXwho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amq1/2DDuPAbzmb+pVUCqnez98pl181p/4YUyt7Z5ppvzbjmxHXVgU8kinwWOZww2lQgwZxSnLOOjTvCFYhy2SVMFbDVF2RsBIrOY6gn30nDdJbap+ij28rDrIQUdn6xWowbojR1O0Ek0SN5BOFOaALsiyH5X/tOH831gmvmsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=gYmOn3Ho; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82d029fd52eso3161756b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 16:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775604181; x=1776208981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVvnM/2IBYVPmVA0rMm5aM3MfoNB4bAJvfYogxqAliE=;
        b=gYmOn3Ho/Fp1xqIJrny/Bj6a7wBAusnwTzAXirV+QIUkCjxiZytSWR7tgPyiu53Xg8
         WDmqFXeVUfsUqMZMoolVv+wp1XzsBk18QAF/OJkfJaHsSijmkADxAme2MVeR4WnQr3p/
         nV1DcE+K8wso6kkg5/MTZ+W2Hknkpt+ptFbJWfBaN9yRKTH3uGF08S5SRZ2FE4EfX7KJ
         3Ex4LhGUinLTRG74I2sAoPB7SrmMj3zQ6XweMRhTFwwrF5kvMyc9s5zHClQqX3mvxAO2
         3s3el7jpu7KjAS3oqMSMhNWU/A8aIdbXDzj2fgMZLbj0LxDeLDdJ1AVohGec+psDDe7O
         zs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604181; x=1776208981;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVvnM/2IBYVPmVA0rMm5aM3MfoNB4bAJvfYogxqAliE=;
        b=c1K2SVf5uqFalEQU9sk9tuD/JcxCGhoew4PHqSJCWgNiK9A/gRBHLLi5Ctl8QdsEM/
         UWPAV+/8d0WsFDNrFxd2vdjao8e8XBnYWXQRy+grSynGXEN0hkDP5PQ3C8vBzNxuAqTM
         bE6oM8CvB0+YoV+Gmsn3+Xz1/HiFCHluIbbKLxtkvSdcntt3NgO9PA8AK5wCfZQ9tek0
         kyvFdy0wE44I3ZjTvY80zSQmNxzEXDXSOjBxHCuQYhPWjAV27D4wHVdS/kcGv1t+G0Zv
         WRTuihsj9T9i295jry13+nibPeTBCWt9T0gcD/SNhW15XpJVmWELlpxsJ9ZUUG7Xl74k
         CuPg==
X-Gm-Message-State: AOJu0YzUxVpIB/u4I0ds0i9BjHQ5UmDAYuMI9Q9kx5t6IwEVdBlSfuAJ
	7UgYTseL7fmb9D5w7ZzoqXFpo0qz7kLsPDSg6Atu7jKSD3fVzqYOMXreZxvLAPag1SSGfo7EJf8
	4vzEjfMY=
X-Gm-Gg: AeBDietWYY+Lf+zX/M5iuJYd6nr0GXCFxSRIwE2zwgxVlTscLpzgBo6rnL+hRTLIXXz
	+zCgjAuOg/diEe3CKvZU1W7U5ZYUU6PJjGlxLPs5iMm01zilgXOOYBPjkjbXUWNWsObRyC+o1NF
	GBPiOcbpSgYIVPBIp2/w7KOBdLxDNaEQ7p+w4e9q3A1GReGzDdbdR6Tqy35D2dAvcwS0qJ+IgEj
	4noePqO8gX2iJ/AvVP6P4piN5xLe4xgazSycym5UJ7V+i8Z1TwC9yU4A3SAnDrmo20bjMsWYQxt
	f/xmPOgtcF27sljIN6NHzLJUfxahicdEKbDZMRxWTyMzHS8gK7Sb5H7bsdL4oNnkRDeFmXV7tv8
	TjkmR1B1XuOL3tfGqIWtAlyf3YtfJYAioy3JtsIfIjtG80jqSWu3KEcZ1KnK3HAvScJ0sO6mcqb
	Kn089l6h46i7VS+ZA=
X-Received: by 2002:a05:6a00:9083:b0:82c:d7c9:5489 with SMTP id d2e1a72fcca58-82d0db7e287mr17570997b3a.31.1775604181371;
        Tue, 07 Apr 2026 16:23:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm22750950b3a.58.2026.04.07.16.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 16:23:00 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:23:00 -0700
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v9 07/10] net: bnxt: Implement software USO
Message-ID: <adWR1OiPlQCJ8idj@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260407220313.3990909-1-joe@dama.to>
 <20260407220313.3990909-8-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407220313.3990909-8-joe@dama.to>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276203-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C35BF3B5734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 03:03:03PM -0700, Joe Damato wrote:

[...]

>  v9:
>    - Added inline slot check to prevent possible overwriting of in-flight
>      headers (suggested by AI).

[...]

>  netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
>  				 struct bnxt_tx_ring_info *txr,
>  				 struct netdev_queue *txq,
>  				 struct sk_buff *skb)
>  {

[...]

> +
> +	/* BD backpressure alone cannot prevent overwriting in-flight
> +	 * headers in the inline buffer. Check slot availability directly.
> +	 */
> +	slots = txr->tx_inline_prod - txr->tx_inline_cons;
> +	slots = BNXT_SW_USO_MAX_SEGS - slots;
> +
> +	if (unlikely(slots < num_segs)) {
> +		netif_txq_try_stop(txq, slots, num_segs);
> +		return NETDEV_TX_BUSY;

This is the check I added. AI says this is wrong and netdev_queues.h says:

  * @get_desc must be a formula or a function call, it must always
  * return up-to-date information when evaluated!

which I obviously failed to do, so I'm pretty sure I got this wrong.

