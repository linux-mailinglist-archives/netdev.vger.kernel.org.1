Return-Path: <netdev+bounces-171755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB01A4E770
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F411419C080F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74C25F99E;
	Tue,  4 Mar 2025 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7hQIFxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C35264A91;
	Tue,  4 Mar 2025 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106126; cv=none; b=I8kKy91XM3nYALhz4xEeaBVC9er2mISSqs/DNZ1PobzbUbnGBTkwbLKyOEaGE4JbtfFxCkQRkvKKalCmVX1PPnIQ9f3/MEwyZE1Ql8Gf7AsB5EyOQuQELWpK96Gl+h53fEym0TqW1wbhcEMKoQMjK0Ipkxi6bWbbNNyc8hKMlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106126; c=relaxed/simple;
	bh=uTZtAcGD27ys5mwl7TA1zFMFkvyG6nq684nffzW7D+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTs13lHMFnWoIcuyZnLsV8JQaJu27xWQ6fw105kPEytb2HZGDgr6KsGh8s/ezZr4iwuQOxYPDGZ+d4Y7kzLrH+bhR4SqDi5FI1tummcsJdswrTv/wqYcS5WA8ybXFxPllORfl3WlYdF9o77CzBELR9moMxDUrDm++DNYffuGfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7hQIFxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38F0C4CEE5;
	Tue,  4 Mar 2025 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741106126;
	bh=uTZtAcGD27ys5mwl7TA1zFMFkvyG6nq684nffzW7D+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j7hQIFxOQbVS5TqOYMymW+CSIlJL61wC45Uupjdl3+yzYs5Si4DmYm3zhhYiKmvNk
	 Du9i+KeqqUG6B5c8UEmr9CzuW/j1eaeEufIMYE2c+WhGLu/EShCtUJuPJ4ex4ZLU5g
	 XJH/0ypQ8gM6O7oIAFMqPB50BXkSCcrdAQtVW1g4sbnxXz5xmAKgd9CNQkP3QXks90
	 dHkJZL+n1xuu9rlnAOPWkbFyM0TEupuonsmsycbmnWUcy6u7N8DKfS4yFCG7mxX/y/
	 shhNPv22SIQEZsKTi7ohoOYETJl+TnnciBHA5z9wmyKoqhts9k9PuLyyYesElH1oTH
	 KSxJnVonW+v+Q==
Date: Tue, 4 Mar 2025 08:35:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <20250304083524.3fe2ced4@kernel.org>
In-Reply-To: <Z8cC_xMScZ9rq47q@smile.fi.intel.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
	<20250303172114.6004ef32@kernel.org>
	<Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
	<5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
	<Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
	<Z8cC_xMScZ9rq47q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 15:41:19 +0200 Andy Shevchenko wrote:
> > > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > > index b79925b1c433..927884f10b0f 100644
> > > --- a/include/linux/dma-mapping.h
> > > +++ b/include/linux/dma-mapping.h
> > > @@ -629,7 +629,7 @@ static inline int dma_mmap_wc(struct device *dev,
> > >  #else
> > >  #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
> > >  #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
> > > -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
> > > +#define dma_unmap_addr(PTR, ADDR_NAME)           (((PTR)->ADDR_NAME), 0)
> > >  #define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
> > >  #define dma_unmap_len(PTR, LEN_NAME)             (0)
> > >  #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
> > > ---
> > > 
> > > Would that work?  
> 
> Actually it won't work because the variable is under the same ifdeffery.
> What will work is to spreading the ifdeffery to the users, but it doesn't any
> better than __maybe_unsused, which is compact hack (yes, I admit that it is not
> the nicest solution, but it's spread enough in the kernel).

I meant something more like (untested):

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..a7ebcede43f6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -629,10 +629,10 @@ static inline int dma_mmap_wc(struct device *dev,
 #else
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
 #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
-#define dma_unmap_len(PTR, LEN_NAME)             (0)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
+#define dma_unmap_addr(PTR, ADDR_NAME)           ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
+#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
+#define dma_unmap_len(PTR, LEN_NAME)             ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
+#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
 #endif
 
 #endif /* _LINUX_DMA_MAPPING_H */


I just don't know how much code out there depends on PTR not
existing if !CONFIG_NEED_DMA_MAP_STATE

