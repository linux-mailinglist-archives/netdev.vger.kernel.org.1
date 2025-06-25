Return-Path: <netdev+bounces-200892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F15AE7406
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C9E7A5A42
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64102AE72;
	Wed, 25 Jun 2025 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjv2LoFW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE52869E;
	Wed, 25 Jun 2025 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813458; cv=none; b=GZSGOq0hm8kJKy+j0cfVwN4KP8JKa6IM3oTO1LOfiQj3NjzxMzTQ4Yn6UWbgaoceL9haSX8frbUqLPhEfpLQwU/fINWgN61tz2QHmceavWMDvTqRdagUlJTZlD+umJ/P4Uqr7DStFZOYDcoqrft7gMdaCK6rW0RTQCaHZg+l0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813458; c=relaxed/simple;
	bh=wyBT6Gqu2evLQ8PxUiJukzllO4b6g0W0O3IGbgvUIh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6uAtuul5rX3fzfvecu884aJkeRXu4XuzZT+5pNnglQ49aYLkCSNVjzqg01YrPPIfMcsdRWo3jdSAnkcjyncB+AC8fGqCEKLA0zAFK6OeYg8Ze0iqKq4BgbEY/qfWW+L2n1mDy3CSJFp3diVgHexzxWgL3sl7E8nnyrQlur1uzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjv2LoFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC8C4CEE3;
	Wed, 25 Jun 2025 01:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750813458;
	bh=wyBT6Gqu2evLQ8PxUiJukzllO4b6g0W0O3IGbgvUIh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tjv2LoFWbkC2mGwlVQcsGLLuzedVnVf62zVM/GBqCw5pye/4AnjQbRtGFvg0kLQQg
	 sV7ciq/UQiXKCihpR/V8VVlqlJFK/US9Av6ifXQma34NqBaHeTDeM1sfIb2DyPADSF
	 UM4SeYunazIwo/EiiNLbusQbG+6HvgNHOrTuorba5RixO/M8vUqUoPnF7D//INCEpa
	 k8hneYe/b9Ahc30J3+hpT7sCQv0IQJa/eB03JxW6P2BjYHBlVwTRMQ5BXHeRacrZ2Q
	 EdzFG1/se5jTSTFM+kpkW0Ct37aLoAua0D9ORAWZcOJ8yYsb+3VpahKkBPblv59fzp
	 VDyWBb229cI8g==
Date: Tue, 24 Jun 2025 18:04:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
 <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
 <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v04 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250624180415.54d0f9ab@kernel.org>
In-Reply-To: <3fefa626dc1ad068d2994a3cd5d20fb7b8136990.1750665915.git.zhuyikai1@h-partners.com>
References: <cover.1750665915.git.zhuyikai1@h-partners.com>
	<3fefa626dc1ad068d2994a3cd5d20fb7b8136990.1750665915.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 08:14:22 +0800 Fan Gong wrote:
> Add async event queue interfaces initialization.
> It allows driver to handle async events reported by HW.

Unfortunately this patch does not build cleanly:

../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:203:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
  203 |         if (eq->type == HINIC3_AEQ)
      |             ^~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:206:22: note: uninitialized use occurs here
  206 |         set_eq_cons_idx(eq, err ? HINIC3_EQ_NOT_ARMED :
      |                             ^~~
../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:203:2: note: remove the 'if' if its condition is always true
  203 |         if (eq->type == HINIC3_AEQ)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  204 |                 err = aeq_irq_handler(eq);
../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:201:9: note: initialize the variable 'err' to silence this warning
  201 |         int err;
      |                ^
      |                 = 0
../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:346:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
  346 |         if (eq->type == HINIC3_AEQ) {
      |             ^~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:355:9: note: uninitialized use occurs here
  355 |         return err;
      |                ^~~
../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:346:2: note: remove the 'if' if its condition is always true
  346 |         if (eq->type == HINIC3_AEQ) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:344:9: note: initialize the variable 'err' to silence this warning
  344 |         int err;
      |                ^
      |                 = 0
-- 
pw-bot: cr

