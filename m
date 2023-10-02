Return-Path: <netdev+bounces-37473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9C7B57E5
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CA236283F05
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F251DA47;
	Mon,  2 Oct 2023 16:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BF1DA3B
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685D6C433C8;
	Mon,  2 Oct 2023 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696264166;
	bh=QpCSpnoG7LwuCvkuSHevJxs6SD9AbPqTNcEG2W8M/Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XT+K0p2qqz7a84Jtl/K7iLbYPdyicA/3GSup+Q5pKxuPkGdcyQdZoGHAEKFCP6Ajg
	 dU8PMrJYpvNEDOBqmFheh9DOcYoQ9b+RobCG8eHZqk/ie6w6HdezHXhRVMX72SRH/e
	 RDeDNwim185wgjl+p9aT56z+OnH2OHDkTQAC7DdMQQpeC1LHeeKbR20o7nSjFvOyC0
	 dbTqP6HrMXhN/GxSzugw/KhmLmOhi0b3fOWl92xgcOccKF+usA3inETt6D3V7i4tZf
	 eLdL1Wv5Zhx/RSG+FHbVaHvzs7MJJ+HuDxZk8AFHeMut4SkNvjyFPis3ZCbbyVvtIY
	 SqWqHqhaI5FFg==
Date: Mon, 2 Oct 2023 18:29:22 +0200
From: Simon Horman <horms@kernel.org>
To: KaiLong Wang <wangkailong@jari.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: snmp: Clean up errors in snmp.h
Message-ID: <20231002162922.GZ92317@kernel.org>
References: <55bdec01.8ad.18ad9c80cca.Coremail.wangkailong@jari.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55bdec01.8ad.18ad9c80cca.Coremail.wangkailong@jari.cn>

On Thu, Sep 28, 2023 at 11:14:40AM +0800, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '==' (ctx:VxV)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

Hi KaiLong Wang,

unfortunately, patches that only contain checkpatch clean-ups
for Networking code are not accepted.

-- 
pw-bot: rejected

