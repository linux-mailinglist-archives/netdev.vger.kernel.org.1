Return-Path: <netdev+bounces-26522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C1777FF1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695081C20EB5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1121D24;
	Thu, 10 Aug 2023 18:08:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E221512
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ADFC433C7;
	Thu, 10 Aug 2023 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691690932;
	bh=nZv6E2mt+6uhd16hMnF3qtJLtFMk5Z4Tzk4w0y3UqaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agm4Sm/vogldp/+2Ie18WRECFwuK6sOtUIdCHTJ10qATYLEmoGlr1k8/hMkJkAsia
	 82Oi1AgdNtvJK0mqN8Hr3GjgtLSzLZrOlE6ywlasAQrOfretLl/4N31129eSyJ4gkD
	 g79VTswCxFhO13LDUCHGI4LLoWim9OdTUluVZQzS05/KrsHqK4+yhLu1a2RsTcOQ0u
	 C5DFqFaOMiqXH8BNToeysfjnxv9X7eeMHPSnI4X7IU4U/8k43AqQpHUt66AJwMFMj5
	 PZhUbxFcaIomUY4b0Ak+Yd82Wr2O+gR6OB/o+jbgpjyRzGlf4A0IQKjO1sLgMZzC9D
	 pwGUzfLBrIdrg==
Date: Thu, 10 Aug 2023 20:08:48 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: santosh.shilimkar@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] RDS: IB: Remove unused declarations
Message-ID: <ZNUnsE+SuJ747yn4@vergenet.net>
References: <20230809141806.46476-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809141806.46476-1-yuehaibing@huawei.com>

On Wed, Aug 09, 2023 at 10:18:06PM +0800, Yue Haibing wrote:
> Commit f4f943c958a2 ("RDS: IB: ack more receive completions to improve performance")
> removed rds_ib_recv_tasklet_fn() implementation but not the declaration.
> And commit ec16227e1414 ("RDS/IB: Infiniband transport") declared but never implemented
> the other functions.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


