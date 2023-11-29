Return-Path: <netdev+bounces-51945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F3C7FCC89
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8E528310A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F21854;
	Wed, 29 Nov 2023 02:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTsxw5HP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD21FB3
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981F9C433C9;
	Wed, 29 Nov 2023 02:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701223570;
	bh=J48/fIchDerAfTe+XMHLwJCGLpcbpOCj25sEWNYmtx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KTsxw5HPOcITg2lQyKEpwyU0CUn8X/oQBfc2WG+sWfzFZqmnVNL24ebrvj6tSjAFu
	 rq2XCKbGhZjtu7q++8iM1CblQG5CdX1WhkuVItOJ+9e18iLpV9/B1tl4SYUoO4lGa4
	 Y6xwmyugZygPH60CovENCo30sIELv34euI2NyOS/YvvMldDh/7faLBh4vib03lwqd6
	 q5nqNEhzSfTDqdBxLO2McG0epcOY3hiRO/6SnzhJSt2C/FzatyqoGN2TbLAsGG3fPY
	 b2q0x0XWRiuDcOUTS7e9IOP8spInvOmVb7h+Huf8O7hhZH8PBQ6wsmVe5G63CNMHOM
	 ibn5wZbjnRdMA==
Date: Tue, 28 Nov 2023 18:06:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v9 00/11] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
Message-ID: <20231128180609.34a4553e@kernel.org>
In-Reply-To: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 19:49:25 -0800 Amritha Nambiar wrote:
> v8 -> v9
> * Removed locked version __netif_queue_set_napi(), the function
> netif_queue_set_napi() assumes lock is taken. Made changes to ice
> driver to take the lock locally.
> * Detach NAPI from queues by passing NULL to netif_queue_set_napi().
> * Support to avoid listing queue and NAPI info of devices which are
>   DOWN.
> * Includes support for bnxt driver.

The changes since v8 look good.

Please respin because my page pool changes touched netdev.yaml 
in the meantime and this doesn't apply any more.

Please make sure you CC Eric on v10, and Michael on the last patch.
Right now the patchwork get_maintainer check is complaining that
some maintainers were skipped.
-- 
pw-bot: cr

