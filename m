Return-Path: <netdev+bounces-224662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ADAB87A52
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 03:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706261B27AE9
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418382475CD;
	Fri, 19 Sep 2025 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="s89D/Lwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6811A7253
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247033; cv=none; b=rO9+Lhd3K3mUf35fukYsgAbeiDA4+B5kSGTYY0OXYQMfQl394FdN9QhWeR9JJrLY5SJ7VlLjo1YZUgF0p/Tn0+esaINlBcVuKm+K2uPVAnr2UWGZ8NqECL6mJBojXTgE2faCwI+f2RQ4G35m4jzoJbuxmYlcgJHTmGKLHtB1bOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247033; c=relaxed/simple;
	bh=XfR+O51u5DSj/MyZ8m8chd/PFtJtnMnMhud5oK5H4SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g114jsvvX9AS++fBvyNqAy5ApkFCw1R2pIoscy/keia3/3r/QmvPkqdnr8/2hjrjmn8kKxMGkCe37WwTPi/HnjINzNIi8fStu8j9Cc0eYaq6gcfFabROz2vz1kCphsKxhexLifJJRXRkop8ApLeMOHhQHoHCzR8rhG4ZLrhLpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=s89D/Lwe; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758246841;
	bh=xASehUQCMfbHPoLskKn3PKQlj1c783IKkTvqokyHjbw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=s89D/LweRoi4kVlbXK1oBtYIJjKxEbwa8WZ3gltYpVZ8atlpgYhO2o58hFOIbqRP+
	 ix6pImzLn8XNlqV6cMcctKaEAgbC2I0Jgot0v45sXfx1ROeh4BKx4b2sEE2LbQ5+nZ
	 znQnFjA1dW66OtBMAxbs+QCZFBumERjt5piy3PNg=
X-QQ-mid: zesmtpsz7t1758246839t85930164
X-QQ-Originating-IP: D0Vv2UCM47KRDisKfezBinjSJQgID5oV/tX5bqcI9KI=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Sep 2025 09:53:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7737609776143489833
EX-QQ-RecipientCnt: 16
Date: Fri, 19 Sep 2025 09:53:57 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <DC717B917DF04BF3+aMy3tTTi0NZc-lIg@LT-Guozexi>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MxdW4jxL6NvXFE5euaj/ahDIUGzNqvcnX6JR8MbFGO+NutfF9MW0CVAQ
	9P6aJu2uS4tnyUc1K0Yn9qbMStrf4Zk1zaSnOFvYyl41qx8u5Uw/JrloCerohL1QJhqbahx
	nE7lFN1uyUV+HT8PgnBJDLGOlklGVex9sxVOVRxMbvM7lGM4zdoJWTTqFrHlfsQ6iL2BJRr
	huFTG0bZfVMs5UnAQYJNOhEA7ETUXNpmUvQCPCVhCKP71ZIPW/7VWAkX5Sgiwdil4/QLUY4
	kyRUXCKvtljCmF70mpApzhQipeVAhnULF4lG+xgwEmN/SBa3MUxGOZx5bKHvIIyA43J7XzX
	pD1NtH5YMi58Z0Mmb606LY99F2QDYdRcLLfcb93niKv9Byun/eJTCvFT2Ap7YbqFc4ULuaM
	FefALoz9bYiCs1cefGisHD6qNn6pSOL83THLpxNRokkSrJ/aVMCquDeAmS9BDgEaoMVJriV
	WV7Yttg6vRi2+d/hhsvv+7uWMCTwv58nTPYOqFGylB8K8AWZbVC6VLz73U2ozWwOzg4z1P5
	niHsaOsYzB6sMsrBT1GKQHvJC54BARbF1myBB3tap/Zwmm+3DvACC2L9Li77rEx2LCdSai5
	wHDIZDFjbP9lubGLYRlbuDkhpe/qRPbmaTJDKkAJaOS/uc76TpMstGRqlFP8FqJo5KpyHw5
	OrPbTlpWK8J4rnTV+SvBbi9HjllEMcQVISUF9S9QVL/5SqN+ff0/g6YDWJvXhAsFC5xEpFT
	ujbPzV2MrS/O/D9GY5cx2rFKuVg7FrY4DpwZnhVGV1SnYVUVV2EsmfQ1Et3LhRk6aCma7rT
	eCzfKPcuRBLNQA+8KcsfHC7gTHeMiXjREd+mXqrcgEaFwkTzjfr1ErzlZBopLBxSUIc7qFg
	glvWvqniWiYBRAJKPERZs9etSpmxm6r9r/FcbDq0PQ1dIg+cMr2+h/nwOSjmFgNomJqFYls
	EyyQwEUMvU+M7wi+MJIYqUR41zSidzR6YHL0dAM0SGW/e5nELqNU+M4mvmeaxjcRg11kjjM
	POQ5J6iqCWbERXoPV0
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Sep 19, 2025 at 09:48:56AM +0800, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
> 
> This commit is indeed quite large, but further splitting it would not be
> meaningful. Historically, many similar drivers have been introduced with
> commits of similar size and scope, so we chose not to invest excessive
> effort into finer-grained splitting.
Maybe this note should go below the `---`
                - Troy
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

