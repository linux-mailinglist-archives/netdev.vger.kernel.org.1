Return-Path: <netdev+bounces-235123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D60C2C4E9
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A61B4E6B13
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A91313E1F;
	Mon,  3 Nov 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGRdOvXV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mIz8OfvH"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B870313559
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178362; cv=none; b=Z15NoOZQVY6E9fTzhsUL7dKhalEXP04s5M9pSHa+QMGNuvPuOSGy8ARo9TzyC7/Vont02+vzwYjXGsUICjl7ldfKXKM3+VEoIUYcaCmlJubZl12f6jBY9xRUzSqne2ywgrSJwBehS7M7U0MNt+2Uul5o+4bjIylEHQFtsjI/JY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178362; c=relaxed/simple;
	bh=AfGiO5weZKEqhsuwYEy4Z3L+e2rEr5Jy4h7iUmkCAxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac0Sq991jTXe9qhwuHtmTMcINbgzL9dUHVmeff4SEwiybzhK6OPuDhqQvpCASWb+SLxntWmfyZ780IiFs8KWBcRx2VQlf05XYE2+uyJZhoow6NBe3FxmmXJoS8TrV37024bhHsQtoQ4omT2JGf037IQbT5q0AiVohZbtPo629v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGRdOvXV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mIz8OfvH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Nov 2025 14:59:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762178359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCTTsP+M9Xv7yx2yxX2rTauuNm+g3ejY3hL8Lx7meCU=;
	b=mGRdOvXVH0eZ/aLJrC7WJjEYHR2TdUvcdzoOCelBDiWReuT8NcyoIuLzWVEvXEhhDkSp6l
	WW4D3oGr7nnHwhQIfpawuprAi/+nVnhUAFewJTdF0U304M6HlUiDL4thKp4kT6PD/lZ+mL
	KmdCPAbqnbmfYJ7tDWGf7MSRnYidsCb6ojT2Vdb8NhZHqEroZldt1JKVVeB8pnO4q5nQ4Q
	Njs3nEX0lHiaNR/v6eI1CwVQVP7hq5BfycQg5Ey347Qi4pqsF2mlvt4fmiA9u7zR38UOMl
	WV6g6TY8eMo9MhyLKuIE5eo7V7m0DeFJFcz8vnqGmm2SoXi2l9JRIkT2zza65Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762178359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCTTsP+M9Xv7yx2yxX2rTauuNm+g3ejY3hL8Lx7meCU=;
	b=mIz8OfvHBbMboNiLck9kpuzjKfXSJ0+cN6JSQpPYLkxf2bTEEWFArqVb85BcBr3PwdbpBK
	36HEHWSh3lN18UBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: gro_cells: Use nested-BH locking for gro_cell
Message-ID: <20251103135918.mieB1dYO@linutronix.de>
References: <20251009094338.j1jyKfjR@linutronix.de>
 <66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com>
 <CANn89iKvgROcpdCJu726x=jCYNnXLwW=1RN5XR0Q_kbON15zng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iKvgROcpdCJu726x=jCYNnXLwW=1RN5XR0Q_kbON15zng@mail.gmail.com>

On 2025-11-03 04:36:45 [-0800], Eric Dumazet wrote:
> Adding LOCKDEP annotations would be needed (like what we do in
> netdev_lockdep_set_classes()

You mean something like

diff --git a/include/net/gro_cells.h b/include/net/gro_cells.h
index 596688b67a2a8..1df6448701879 100644
--- a/include/net/gro_cells.h
+++ b/include/net/gro_cells.h
@@ -10,6 +10,7 @@ struct gro_cell;
 
 struct gro_cells {
 	struct gro_cell __percpu	*cells;
+	struct lock_class_key		cells_bh_class;
 };
 
 int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb);
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index fd57b845de333..1c98d32657e85 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -88,6 +88,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net_device *dev)
 
 		__skb_queue_head_init(&cell->napi_skbs);
 		local_lock_init(&cell->bh_lock);
+		lockdep_set_class(&cell->bh_lock, &gcells->cells_bh_class);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
 

> Or I would try something like :

I'm fine with both. I can provide a patch body for either of the two.

Sebastian

