Return-Path: <netdev+bounces-273275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hh2MvytymnU/AUAu9opvQ
	(envelope-from <netdev+bounces-273275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:08:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32535F2EE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E6323006B3E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCE390235;
	Mon, 30 Mar 2026 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="SIgBJmKI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02132ED21
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890441; cv=none; b=VIDs1WVORNic7CnJP9R/K8YJyP4Br5cn419FIg7alEoIt0zM5+jUEH6+oA69DYPghPRcvp/VYJ/UKODHyyEstcBZ2QBtXwIseu3i+Sqzg2VOwZ7VPu2+aIg1J0yjCuis7m6k0entvJZfPzvezvGZ5rXrNT80reVEY2jiBH/859w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890441; c=relaxed/simple;
	bh=4R6RuBKBYUfoRqRS7x9RMplVEtjk9a5AM1rRdQYGRNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkzEPYu7tVMwOb9qE6YLCgxeTU5IycmhbEwPwmPKpZk+fG0j8Nk0JUOryH9kdamhTKaDqmS8hnrHuk1aHj9rSQFgPoWSCeecTN9xSJXjUDjgkac9t13VHuQeTPo7uk0jO1cQxSfhCgIYwPHJ+ePEw9bxVYYQxCJwCkBSkmSV0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=SIgBJmKI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so1290202a91.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774890439; x=1775495239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2ckhJIZxyCoIszlFarfOvV6+4UuzFAlnFaLl53XZ3c=;
        b=SIgBJmKIR5Rul8mOcu7f6kBrOcexNFJBGm6I0vwFjjiBc/Qz19AbbuEu+IyJob475U
         jq5VcHdBWclKA0KHo/Bh+3dL9v6LE5J/UJY4HUI/a7feqHDBqdPRpM9TB7J84AHUIjOk
         ysfy2I/LJLUl8s4vx7g/Iys4Znpfp5px+Lx8C7KieuG8u53hFC2FpzNamFcfjSsif/mQ
         D+3zUCpKjgVSTUCVJwuWYIL/+LmSnXRP3HxmQpSSijynx94dUnf68BKMl2oPJBuXbVjQ
         rcogqthv/cgIm0iGJbkAxxFZ0ii7Nfaj55uwNXTlrLJ8DEv++TXI+D2psitwCiQSk4Yd
         AWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890439; x=1775495239;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2ckhJIZxyCoIszlFarfOvV6+4UuzFAlnFaLl53XZ3c=;
        b=IElQb9bs7ca21HQlfE2VRiIxeMgXQ6LsvioIFNXnlHo+8Lj9jZolM3lNqjhuT/j0Ik
         NayGo4+JK3/2h7kBUxuUPqxEjGZU5q4KoXAMX+8wlAjS5wzjj0wPO6wBqYg3KTFS8IJw
         k0OBA1icwWIcZa5rGPgRQ8wv73WXW/bXcGC8abzAsdCBKLldGl69rV9+AC4pI3RMbdTt
         HhvI1lxHqjb7umI35HMbM6GZDkvUcWnHhDV19yaNXfeqtRypPU6dFmPupHyJ+jj3MJTF
         C8/rsEMPquOd5yf3xWVg+nODy3d9CdJ01nr5XoVfpk3eeuPp6EnFzu5Ulg7wiBkg22QL
         hAAw==
X-Gm-Message-State: AOJu0Yw32DQ7PMLo/I2UnOQaMNhOpUocsyB3fUslF51BlkS2P8vXcitS
	7cBBTbhhxKEIhfb3UE5JXK+xafLMlo4wXpdSbalAq/tPThObyNuh/PrayeU+vrBxoYy3hMZsl5M
	L1RZNfcc=
X-Gm-Gg: ATEYQzzS0uUg3/iNJjd2w9f17pQ9vySYope3vh+3CcQMBF7fPMxU9/HFGRyDzbgkZiU
	kO4gueoB/enJuJIrnk8DqAD07c+UYKlN7PrlWkkG3x6hqtOk6771mt6sWWYx/BOR07/kX+F2Vgp
	8ukafE0OkW3aV5fn4xff3hoiNi6Me4I86cOHKIdRWIaAEWkJzZh9uweOaeyKcg/3L5G58zpZiv8
	c6j/KFBn24RODnLsXQ6nzjhVgVGyv/3gc+9iN5vJi+yInUMe87BcpCpTrZQkEdxxhSOhtrD5uZp
	gyU2bfV+Ve5vPE/EteAcsn7o4w6CawvjuIrsHsPYVLv1q9NdyTjrLrL9hfDPNs+fNG91+C5ycx/
	LpXnAyTKTERSLT7/EVRWC3IAsyjSiFSXzgiBgDbYdE90KCZAA16Jl2KrHqnxq1ZFeEuEKwh9pvG
	4gmNPi
X-Received: by 2002:a17:90b:4a8a:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-35c2ff1e0f2mr11509143a91.4.1774890439144;
        Mon, 30 Mar 2026 10:07:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2ec9c8d8sm4126258a91.12.2026.03.30.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:07:18 -0700 (PDT)
Date: Mon, 30 Mar 2026 10:07:17 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 09/12] net: bnxt: Add SW GSO completion and
 teardown support
Message-ID: <acqtxUBvQw7pXPY2@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-10-joe@dama.to>
 <20260329152236.6ad729e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329152236.6ad729e6@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273275-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 3A32535F2EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:22:36PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:28 -0700 Joe Damato wrote:
> > +			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
> > +				if (dma_use_iova(&head_buf->iova_state))
> > +					dma_iova_destroy(&pdev->dev,
> > +							 &head_buf->iova_state,
> > +							 head_buf->iova_total_len,
> > +							 DMA_TO_DEVICE, 0);
> 
> Do we have to expose the dma_use_iova() stuff to the driver at all?
> Could we have a function the driver is supposed to call to clean up,
> always, and what the function does is up to the TSO lib?

I could add a tso_dma_map_destroy(dev, iova_state, len) that the driver calls,
but the driver would still need to stash iova_state and total_len on the ring.

That would be easiest, but I'm not sure if you were thinking that the IOVA
stuff should be as opague as possible?

Because if you do want it to be as opague as possible, maybe:

/* Add a struct to tso.h to track completion state */
struct tso_dma_map_completion_state {
  struct dma_iova_state iova_state;
  size_t total_len;
}

Add a save function: tso_dma_map_completion_save(map, completion_state);

And then: 
 - the bnxt sw bd stores a struct tso_dma_map_completion_state.
 - xmit calls tso_dma_map_completion_save to store the iova_state
 - completion calls tso_dma_complete(dev, &head_buf->completion_state)

LMK if you meant the easier way or the more opague way?

