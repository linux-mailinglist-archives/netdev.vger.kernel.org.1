Return-Path: <netdev+bounces-234787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8ECC273B6
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 00:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9901A4E36C1
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E3330310;
	Fri, 31 Oct 2025 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBwnA3q/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44CD32ED5B;
	Fri, 31 Oct 2025 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955102; cv=none; b=bmgA6bGfc/SOhn/OKKeaV2lYA/yk9FGd321+yhaGPxoCQMEvLUkBWga1GYIsnyLYGD34uXn2GKnkeT0zLtdled1ts7skYRNE73D/smmdKtXafHLA5Mh/hc5RdaiCrO+A/OIsm3Xuom8rkzrbB0JIXsVESdGxx2c1T/wCorcnkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955102; c=relaxed/simple;
	bh=6lDOXEoS0ooUoLPXtfjnnWqan0MhKFfz/xn5trjVv74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRBidsdyOuDxIucLtCpMIylFD/22y970MOE/ORYcDuquvYDEWpH92kFeBqQaD7fsK0wLLU/wp8pA+vEC/+ehakwIrMuF//Nh9N1d5JMsq3AGWIMX/49YDTOtY7aj+JN6KSrSQ6ygtY22zF/TeFhAdYQQAmfCL6qckINH1EMQclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBwnA3q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CBDC4CEE7;
	Fri, 31 Oct 2025 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761955102;
	bh=6lDOXEoS0ooUoLPXtfjnnWqan0MhKFfz/xn5trjVv74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HBwnA3q/4VrCnBUyLdFAd2u11xKRZxNnGOmAMH1ehoXyS/tf6Rvi1hDkw+d9AZWUP
	 VxaAuTtBPrxuzf4VAGJj4xFaO+Cw6NSwHRbAc65r9L4bqgs++DGpTXzVaaO3WRPzGQ
	 TkI+FIVibKRhhqUNWhXOXsmm1l907+2I+eagTnsx9mjOKhL/FgCBSYuOmeiBti4o7V
	 mfbwIkxfBbjPtvklcb1P0lHV37CC1v0Mjm1qGpjvz270/+9lyXp0c+8kjbB1w1oiy5
	 eD+p9DRP9fLbgKuqnGzPhN129a6Dytfv3U+uTfU/IN97iK3IArKA76yiLIGWbQaGSY
	 zO9MIBeoEE9BA==
Date: Fri, 31 Oct 2025 16:58:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
Message-ID: <20251031165820.70353b68@kernel.org>
In-Reply-To: <20251030121314.56729-2-guwen@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	<20251030121314.56729-2-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 20:13:13 +0800 Wen Gu wrote:
> This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
> infrastructure of Alibaba Cloud, synchronizes time with atomic clocks
> via the network and provides microsecond or sub-microsecond precision
> timestamps for VMs and bare metals on cloud.
> 
> User space processes, such as chrony, running in VMs or on bare metals
> can get the high precision time through the PTP device exposed by this
> driver.

As mentioned on previous revisions this is a pure clock device which has
nothing to do with networking and PTP. There should be a separate class
for "hypervisor clocks", if not a common driver.
-- 
pw-bot: cr

