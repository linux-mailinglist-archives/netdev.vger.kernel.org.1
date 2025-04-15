Return-Path: <netdev+bounces-182544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B9A890BD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57213B0060
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5812E552;
	Tue, 15 Apr 2025 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt2Tx2ng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE918E25;
	Tue, 15 Apr 2025 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677371; cv=none; b=jjxjbCT/RxiP2+YPhbAN6kzX4/dRpJ8Rp/AoZuUGJgUxvNanb0VCdlXx1m1D5pkOE77BRPPHTFbBKTfLBthno2RwuJSRUOwMj+OOUn0E8DL4LEcQAlMoqQB7KDK+LYzfPLMCpXiHKZmQkXQVak7kdALmzPYh7EcVac0TgdA8+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677371; c=relaxed/simple;
	bh=GuIZ8yrAqUdbPqcAgS2klGxGn5H/kj5wdhij/BBzaaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJn2i/vHQcpw5vzegySkIPtKVI5kNFp6onbRLdUh//FDwyBAGahrdmY4JnYe3MnBwHKkzsky4qkoBKubj5AJesnCvJKeEgHAMDsdXoGVZok8o2CJzFEJuvHeES4WQywQT9mzgXLRm2vwkcViJv5hmJVwQCtYr3Gp5LROKlOM+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt2Tx2ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BB4C4CEE2;
	Tue, 15 Apr 2025 00:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677371;
	bh=GuIZ8yrAqUdbPqcAgS2klGxGn5H/kj5wdhij/BBzaaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qt2Tx2ngxcaDvGpMmql/pIoIGKmeI4nrfjNQnbzNkBqtrN4yruvp7EcgrkyE/id2I
	 sf6aXHOnFDpdhbTGzaHBVYADa/QJ0//gItLQf5MTRBq6SpDJPLKrz209v1oCOKn1qy
	 1OVXNHDJg3D/VcbRwou2h6M8filWV4N465iEjGKeSFo4Udvp0PR1r8/Fi71z8Cin0k
	 sNLlKeyqb54x6GnnLPJ71oYBcOS71MtvlvKJ9v1k3tGLFkLdvqBSEdbru3q82Q3y4p
	 oRxPkvWy1hrA2erWXCDzCVLAO4ZhRmuVtEgDv6Q/ZPVYnkHCdlDq7bc2y1VVh695TV
	 w1ZUQSlgBWlew==
Date: Mon, 14 Apr 2025 17:36:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>,
 <michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net 2/5] pds_core: remove extra name description
Message-ID: <20250414173610.5dc3be9d@kernel.org>
In-Reply-To: <20250411003209.44053-3-shannon.nelson@amd.com>
References: <20250411003209.44053-1-shannon.nelson@amd.com>
	<20250411003209.44053-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 17:32:06 -0700 Shannon Nelson wrote:
> Fix the kernel-doc complaint
> include/linux/pds/pds_adminq.h:481: warning: Excess struct member 'name' description in 'pds_core_lif_getattr_comp'
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")

How is this a bug fix? The warnings are only generated on W=1 builds.
Please be more considerate of folks maintaining stable trees. There's
no need to waste their time with patches like this.
-- 
pw-bot: cr

