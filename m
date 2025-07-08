Return-Path: <netdev+bounces-205013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA3AFCDE9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547A5188586F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B252DEA9A;
	Tue,  8 Jul 2025 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X/tOGCvv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDF2DFA37;
	Tue,  8 Jul 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985531; cv=none; b=sdV7toQrc9tTQEfxVqLvS3GFew1jXHi6r/i4595qWpiRDfhPatKkdyqSy8ZverApWrosTby5ldehiE4HJ7WzUN7FZVMGZDizppYl/8oUbrCAQ2DBuBoVa50T8aKiEN3MuXtjslcvFfAF/8XFs2ZBs0N5jDG41cRWgx+pXIqqUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985531; c=relaxed/simple;
	bh=B+cIONCHSB63wz9Fmfq4zOnAoUqtOHM2u3uwmNMN1WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amo3LYLx5Ztdy1OVnIIrXWKFoTq9VgFbnxG+6mIwMG2pgenNT9DQDC0NWnjJdt6RVSy1q0K+GkyLduAEdAUSHjeTWPkZa1HKeAXdhITrEAEbFWR2aZube+SyFZNzOHMeZ2iV2GlKZPQGSWetAIWOql6mWDFZ6SkON620moxmXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X/tOGCvv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9pkbIkywSnRdqvZRasF/+xrU7kuQFUceQ1mqcQwDMC0=; b=X/tOGCvvFmDMyMXsG8lgmlimBj
	JSGonl4eExUSa+Zx98iJPbwC0Qk1wukLn1DPLfJI2EQREId6mmEgi4LTFSqjlfDBCyvlPujAiAbS/
	hy4uihWXWx1qDCnLOK0LTZLqBn1W/N0oXl/BU4Fr57aRdIHwcFjQJZrxYc0ONd7dnBPc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9Sz-000pXs-1R; Tue, 08 Jul 2025 16:38:41 +0200
Date: Tue, 8 Jul 2025 16:38:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] net: hns3: use seq_file for files in tm/
 in debugfs
Message-ID: <13154775-28f3-466c-8bd7-21ac51540a8b@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-6-shaojijie@huawei.com>

> +#define hclge_seq_file_to_hdev(s)	\
> +		((struct hclge_dev *)(hnae3_seq_file_to_ae_dev(s)->priv))
> +

priv is usually a void *, so you should not need the cast.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

