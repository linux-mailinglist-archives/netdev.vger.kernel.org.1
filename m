Return-Path: <netdev+bounces-273390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPaKHHQOy2msDQYAu9opvQ
	(envelope-from <netdev+bounces-273390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:59:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35B36281A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B282301C3F5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859AF3BED0F;
	Mon, 30 Mar 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy/uscds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E93BBA19;
	Mon, 30 Mar 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915183; cv=none; b=glXfVX4um8+nQyDtRPoq+jQhzEKA9bCBW0OgfWAMKL+9Uc3AzNt+Qvj5SsVRSFvVY9w679892LXj1UKkUaNcl0e6ey4IL+xTZ0zS+WNsYeR/IkTinwoWDWUOPTBr9fNPuuaPwMYDr5aWozZcKW5tgZ2s5Qkj1w2iVvb3GlBM9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915183; c=relaxed/simple;
	bh=YzhcoE0El7282uqSNI6M7gDLrPB5rd+MlYkZ+5lFVWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/POQK52RMnUNbbVUlLhpG8uUcdSxxtTO56qZzvifT8kDeGQtapl+8Vaf5SIzijsGLl3/Dj6whOQ+PkkhnTmlcZBZE9OAS2+oA9xoGuab2r1Ruv/Tayw86+Uv9kiXa7SbBJaljoN38rghH9niZKVx14z7L3EN0lmvCXP3Ez+kFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy/uscds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E01C4CEF7;
	Mon, 30 Mar 2026 23:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774915183;
	bh=YzhcoE0El7282uqSNI6M7gDLrPB5rd+MlYkZ+5lFVWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qy/uscds75K1lttTW7iuStONZPKkkXPZe4dligiy/JX1rV+fZk9dUPnPJHuoOVyR+
	 4t+swnqSLoNHemwdSaOI7yLFHBvCRSlPiSD+bFwjUmf+q+Y8LV83D76APkcOEI5A1M
	 FF0SwrOC7a/rhFiL2JY9xn3Iab2vgeTQxmOiOigkLldrRMQOCoRpXZjEQy3A3QD6Lb
	 j54+o43rwNz8QR9xfNZY1PsPtHwzN69GJCn1lQaf3C4isMzcHhnK5Z8x0Bbotcvy61
	 Uslqb5VggSiRyuLPJO07HeeqH1Cd81EwKp/Mzsdth3gSHeJQ2JrW+Ddk8LDZig3g2s
	 L7ihVWAJ+F/iA==
Date: Mon, 30 Mar 2026 16:59:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 09/12] net: bnxt: Add SW GSO completion and
 teardown support
Message-ID: <20260330165940.0e7d2e32@kernel.org>
In-Reply-To: <acqtxUBvQw7pXPY2@devvm20253.cco0.facebook.com>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-10-joe@dama.to>
	<20260329152236.6ad729e6@kernel.org>
	<acqtxUBvQw7pXPY2@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273390-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD35B36281A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 10:07:17 -0700 Joe Damato wrote:
> On Sun, Mar 29, 2026 at 03:22:36PM -0700, Jakub Kicinski wrote:
> > On Thu, 26 Mar 2026 16:52:28 -0700 Joe Damato wrote:  
> > > +			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
> > > +				if (dma_use_iova(&head_buf->iova_state))
> > > +					dma_iova_destroy(&pdev->dev,
> > > +							 &head_buf->iova_state,
> > > +							 head_buf->iova_total_len,
> > > +							 DMA_TO_DEVICE, 0);  
> > 
> > Do we have to expose the dma_use_iova() stuff to the driver at all?
> > Could we have a function the driver is supposed to call to clean up,
> > always, and what the function does is up to the TSO lib?  
> 
> I could add a tso_dma_map_destroy(dev, iova_state, len) that the driver calls,
> but the driver would still need to stash iova_state and total_len on the ring.
> 
> That would be easiest, but I'm not sure if you were thinking that the IOVA
> stuff should be as opague as possible?
> 
> Because if you do want it to be as opague as possible, maybe:
> 
> /* Add a struct to tso.h to track completion state */
> struct tso_dma_map_completion_state {
>   struct dma_iova_state iova_state;
>   size_t total_len;
> }
> 
> Add a save function: tso_dma_map_completion_save(map, completion_state);
> 
> And then: 
>  - the bnxt sw bd stores a struct tso_dma_map_completion_state.
>  - xmit calls tso_dma_map_completion_save to store the iova_state
>  - completion calls tso_dma_complete(dev, &head_buf->completion_state)
> 
> LMK if you meant the easier way or the more opague way?

I'm not gonna lie, only noticed you keep the tso struct on the stack
now. But the proposal above looks pretty clean to me.

