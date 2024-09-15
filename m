Return-Path: <netdev+bounces-128423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C99797E4
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E650128187C
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755A1C7B8A;
	Sun, 15 Sep 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSXZHPeZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FC200CD;
	Sun, 15 Sep 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726420643; cv=none; b=eXn1/gFkr8aG8g+Z+kbUWqOZPzP7pwCTSce1YDcjGIrQK5seAWrWNOtJk9LbM4c1w5nsjOfYeswGLVZmzUrv7xZU0TBi+kRImzfFkAenGBYYqZxcMYW7942nfK8hEtKT1EwnvGVqk+j7d6o+KRDaZkDnDi2BFKMIFeL16tee5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726420643; c=relaxed/simple;
	bh=ySWSP/6B0wVdjoSXAvcqT2SOPGUizjoKyoYbxrOo3+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWNg3YrJltxQnSeQDvndXrX43DWceKy4argWFCk2Llq39vgmCyhf4gAitEUwoRG+c8Sq0ZUvKCE4Icp+xcGnHmIChdaXLzT6UJrnWtI52Bsi2ZlYHZNENmuHpitl1GhpxzjFn/QVv15aSrX18T6ScCoKWxGoVHJWkfM/yTMWwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSXZHPeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C565C4CEC3;
	Sun, 15 Sep 2024 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726420643;
	bh=ySWSP/6B0wVdjoSXAvcqT2SOPGUizjoKyoYbxrOo3+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BSXZHPeZXI+ar2S65BY1nn05TM96WbKvv0qsZvRwpVUvc43Ky9duSUryeFEwYaj1X
	 Vs84YevWm8ETurSeOFncnMw2w9zj43ZqUEO0llKLANbqt7Enw+bQAL5vXq81qiMLbA
	 AXhaLtppLQevbP4D8K34u1G9ribQmIj+Y8fn9NyNNLmRg4vAae7NWgt7WgTRr9760u
	 vCRiQzeSxK5NT4WZ1DN+IDVE3CTtEPqN6GtqekkLVcp3dITYYG6H9VADE5IMFonKJd
	 LiJX7w5PnTTguKGfkbmVDC3I76pl2QDTXhmGo2UpYBMoeaPs7BqYAsmoAqNZ1rwiuq
	 HkbiEJcPeWMVg==
Date: Sun, 15 Sep 2024 19:17:18 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <yuehaibing@huawei.com>,
 <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 0/2] ethtool: Add support for writing
 firmware
Message-ID: <20240915191718.1da2bc78@kernel.org>
In-Reply-To: <20240910090217.3044324-1-danieller@nvidia.com>
References: <20240910090217.3044324-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 12:02:15 +0300 Danielle Ratson wrote:
> In the CMIS specification for pluggable modules, LPL (Local Payload) and
> EPL (Extended Payload) are two types of data payloads used for managing
> various functions and features of the module.
> 
> EPL payloads are used for more complex and extensive management functions
> that require a larger amount of data, so writing firmware blocks using EPL
> is much more efficient.
> 
> Currently, only LPL payload is supported for writing firmware blocks to
> the module.
> 
> Add support for writing firmware block using EPL payload, both to support
> modules that support only EPL write mechanism, and to optimize the flashing
> process of modules that support LPL and EPL.
> 
> Running the flashing command on the same sample module using EPL vs. LPL
> showed an improvement of 84%.

this missed 6.12, sorry, I didn't get a clear enough signal form 
the discussion to merge it in time
-- 
pw-bot: defer

