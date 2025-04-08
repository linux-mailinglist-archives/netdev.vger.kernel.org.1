Return-Path: <netdev+bounces-180044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1498BA7F3F5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E093A5F4F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABFA20B7EF;
	Tue,  8 Apr 2025 05:04:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246533FE;
	Tue,  8 Apr 2025 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744088661; cv=none; b=gft+2RFuHKWjO7ImYGcNk9Ps8RF2Vu23EJCIx5OX1GKJmVSDqFEmnVyPU4jZT3jsjUW1Ch8S8u8X5OTi6KIX2otYGadTD7cCq+DHhQ3x+0k2npH0uk+AgFuIZKwGOeWXvQ5612b2cEVVFSWGTpzSVWtezGuK1uw1KEZ8MmKTppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744088661; c=relaxed/simple;
	bh=26XhyeM8AFQGiP6XkOLlekexwUhU6P7xEPsqEwPV7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH8nSumPnwMvFFQwb2IxDmgOOIP5/uOGLIUBuUHkHEn+MAF2XJSWDzuAsmBYwQDBEoHVxBf3dG8bVhPUE+9CU9Wit5CsmSHaPYQu6emkJC48xnfVOzfdemxvV1U1oTR3Npf4cM3ngS5K6rjuCMbIr0E9iGTK1+mTVx3GjpbWPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF6D767373; Tue,  8 Apr 2025 07:04:08 +0200 (CEST)
Date: Tue, 8 Apr 2025 07:04:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: hch@lst.de, axboe@kernel.dk, gechangzhong@cestc.cn, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, shaopeijie@cestc.cn,
	zhang.guanghui@cestc.cn
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit
 1be52169c348
Message-ID: <20250408050408.GA32223@lst.de>
References: <20250407143121.GA11876@lst.de> <20250407171925.28802-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407171925.28802-1-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 07, 2025 at 10:18:18AM -0700, Kuniyuki Iwashima wrote:
> The followup patch is wrong, and the correct fix is to take a reference
> to the netns by sk_net_refcnt_upgrade().

Can you send a formal patch for this?


