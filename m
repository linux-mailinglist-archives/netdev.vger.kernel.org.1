Return-Path: <netdev+bounces-25166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7324777314F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D122815B0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF617735;
	Mon,  7 Aug 2023 21:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0A174F9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733EEC433C7;
	Mon,  7 Aug 2023 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691444141;
	bh=cQAbajiXFNL2E5AtwK0bBXkSXN8vDJ6Vz3qiuBvSgt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=at6ZLDH+j2mS7VM5JuIxlHLLrv9sHxx8EXryFOYlJ9yY40dKgCghPkiNL3GbMWHGH
	 WUPsVUAokOpX09OlkICMSo4NyuTPO/5jt92cBClX+mzmRjYK36pAQKOxFn+ubwNSaB
	 Oog5SD8T53j1ZYCC0RfrSE0J8UC+8sFakjF8Zgzq0Fgr/ynuxcKIaniPBRk76dPFVD
	 Hn8MrsLVTH1n+701ps5A00b5879O6qoFhTHxh4BwM6UekZ1Si8zbYfBC5Kvtq/0rxS
	 zZrxaREc6/2pKeoUKoPmu5l6cOrUikak00Krt1MeeV4L27hopva9fYp7u1DckrrN0+
	 LMMz7zcyGsCgA==
Date: Mon, 7 Aug 2023 14:35:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
 manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
 skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4] bnx2x: Fix error recovering in switch configuration
Message-ID: <20230807143539.7461b319@kernel.org>
In-Reply-To: <7b4904f5-ceb1-9409-dd79-e96abfe35382@linux.vnet.ibm.com>
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
	<20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
	<20230731174716.0898ff62@kernel.org>
	<7b4904f5-ceb1-9409-dd79-e96abfe35382@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 16:08:50 -0500 Thinh Tran wrote:
> >> +static inline void bnx2x_stop_nic(struct bnx2x *bp)  
> > 
> > can't it live in bnx2x_cmn.c ?  
> It's in common header file for also being used by bnx2x_vfpf.c.

And bnx2x_cmn.c is the common source file. I don't see why it has 
to be a static inline.

>>> Why make it a static inline?
>    
> Just make it inlined where it is called.

