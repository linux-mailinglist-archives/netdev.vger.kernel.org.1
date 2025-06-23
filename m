Return-Path: <netdev+bounces-200434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA68AE581F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9683AE9B4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237CA22CBF1;
	Mon, 23 Jun 2025 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwCcI4C5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5C22A4EF;
	Mon, 23 Jun 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722043; cv=none; b=dWOx/YKXFJivAs1xTUG9rMi/LkPTJLY8MbV6qeOz2QfuedvkyGjj1PYXYVrrtYtMi7ZRe2NcSVNrldGvIHDL1GHXflrODmFIUV5SYw1u50AscFH7KtDapkJz1hK1ZmyKwZ7Z8J1tTH+xRgUV7rnZv0ol35ed8K7h3ayjICaf/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722043; c=relaxed/simple;
	bh=VsI/42vgtdVPgkNI/zM0SZ7BpdbkioOf5/2lMgLEPFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4gSUwo3wuCiRS6OBZn4zaCJLdX6tb9tJ9r1PyUBIQ+kZfKlrkfw3RZ8FRG32yWEmrqFVkURTrq0/+YrGLZLqhVqRgj66xBKyIqdqcJYtE4bT/fjagY+4iQ+4P+fPs0REZJ4AbwnnPh0jhhK7Ibnbfw7wmaTx8CnRdELbgVkKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwCcI4C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F31C4CEEA;
	Mon, 23 Jun 2025 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750722042;
	bh=VsI/42vgtdVPgkNI/zM0SZ7BpdbkioOf5/2lMgLEPFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwCcI4C5uqM6LqURGnyegVDKQxX2hGExjyN6k9EaeF/VltjC+u1yt8bm63luMXy9Z
	 yTy3DTI1ihFmHK3bvRETIWKYM74wrWLrIyvkJ9H+H1Da7AHgLzFsRP/Ux/u7WlsrrE
	 d+yY24SMLeTAMgGN2UrwbNoYhf/ls4YPsJU0O/clY91655mG45x7ET/Rwnz4lXOWfg
	 gyda8o7RzjGHKJiO0i/mT67E09BeoRp5UXiTDcsh9NDU9wmgRgdvU9DH7lMAx8UuWQ
	 Z89jo4PhoxWRfDZAnaO4i2cyrY8CaxpsVOzVnQ42zv/YwDihGDbZM4tn9THg6q9rZs
	 Zb1x7t7H7czYw==
Date: Mon, 23 Jun 2025 16:40:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>,
 linux-atm-general@lists.sourceforge.net (moderated list:ATM),
 netdev@vger.kernel.org (open list:ATM), linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [PATCH] atm: idt77252: Add missing `dma_map_error()`
Message-ID: <20250623164041.66ef9cb3@kernel.org>
In-Reply-To: <20250619105707.320393-2-fourier.thomas@gmail.com>
References: <20250619105707.320393-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 12:57:06 +0200 Thomas Fourier wrote:
> @@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
>  		paddr = dma_map_single(&card->pcidev->dev, skb->data,
>  				       skb_end_pointer(skb) - skb->data,
>  				       DMA_FROM_DEVICE);
> +		if (dma_mapping_error(&card->pcidev->dev, paddr))
> +			goto outfree;
>  		IDT77252_PRV_PADDR(skb) = paddr;
>  
>  		if (push_rx_skb(card, skb, queue)) {

Hm, you're missing undoing sb_pool_add()

Like in another patch from you -- either jump to a new label in between 
the existing two which does the necessary unwind, or move the mapping
earlier, before we start adding the skb into the SW queue.
-- 
pw-bot: cr

