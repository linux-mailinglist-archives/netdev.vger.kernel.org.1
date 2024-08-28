Return-Path: <netdev+bounces-122737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5439625FF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014DF1F26677
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3E16D307;
	Wed, 28 Aug 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naIJUapi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34A3FEC
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844383; cv=none; b=uAyX+ySapjAyPHYSb/cClMxf2QTtqlQ5nQywrMuXgfxvQYxTGdn4wDdX0skyq5v1dqumz+mSqn5WYsoh/FsgC3X83xbVCKvgPDcoyEuf47Pdfye5/r9ue2OlpiYYkrx2dKqLmmZbPD+17wNCN8i1WdwbHckMFlK3Kyy6gW9XHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844383; c=relaxed/simple;
	bh=5mimbGD1RLshSEpcHCY/Eb0s7Gm26lmThCbr+w+yclI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQnS50L+eNNmyu55mUHjdxiVd6T0xpyX6QRD6ZNMm9Ukbe0aiaTjAJLET7sJ9U3pUeORJFm4iiF/M4EHJ+04Ek1TUWcjopW1qPHrwX9DQRzo3HqppxIfV5CF2udM7Y3m1IApxAkuQ58I3U8Jei9P/NBEREZcPM+8CoWboKuu3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naIJUapi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DDCC98EC1;
	Wed, 28 Aug 2024 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724844383;
	bh=5mimbGD1RLshSEpcHCY/Eb0s7Gm26lmThCbr+w+yclI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naIJUapiFNxxbY+rLG+VoIEWJ8sqbJoEZQzzTeZc2um9xlbDeo+ahPmPm7MBRETAn
	 DFea5WZtYx+XrZgHHq8RV9k5yb2Qm8B0o1FVfBOxOkFc425aHEcBL3l+0wMwii00kc
	 lsOCk2f1EAl9vV7bE8LDLu8Rtki60ZppemwwXOrGfi8hMmDkn9l7Dt0/HxgV9E2Gvl
	 r7ui85uj7G2G/9QaXGe/Pxxpt9/P4iBOb6txIY6RYpA6dMjrheDCkWR9X8qYLqpcWN
	 AHnGwBJEGydAkho2PGTUh1k3Gs9wzeELq3AQa5QfFT0Dx3MfSLERnkQfRqyfAjHayV
	 YrSqZOzAmdnpQ==
Date: Wed, 28 Aug 2024 14:26:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240828112619.GA8373@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs62fyjudeEJvJsQ@gauss3.secunet.de>

On Wed, Aug 28, 2024 at 07:32:47AM +0200, Steffen Klassert wrote:
> On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> > From: wangfe <wangfe@google.com>
> > 
> > In packet offload mode, append Security Association (SA) information
> > to each packet, replicating the crypto offload implementation.
> > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > from the validate_xmit_xfrm function, thus aligning with the existing
> > code path for packet offload mode.
> > 
> > This SA info helps HW offload match packets to their correct security
> > policies. The XFRM interface ID is included, which is crucial in setups
> > with multiple XFRM interfaces where source/destination addresses alone
> > can't pinpoint the right policy.
> > 
> > Signed-off-by: wangfe <wangfe@google.com>
> 
> Applied to ipsec-next, thanks Feng!

Stephen, can you please explain why do you think that this is correct
thing to do?

There are no in-tree any drivers which is using this information, and it
is unclear to me how state is released and it has controversial code
around validity of xfrm_offload() too.

For example:
+		sp->olen++;
+		sp->xvec[sp->len++] = x;
+		xfrm_state_hold(x);
+
+		xo = xfrm_offload(skb);
+		if (!xo) { <--- previous code handled this case perfectly in validate_xmit_xfrm
+			secpath_reset(skb);
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -EINVAL; <--- xfrm state leak
+		}


Can you please revert/drop this patch for now?

Thanks

