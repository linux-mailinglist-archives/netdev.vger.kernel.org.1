Return-Path: <netdev+bounces-43536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE88F7D3CE1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8251C20979
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04E1C2B2;
	Mon, 23 Oct 2023 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBG7jWc4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48061B279
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA43DC433C8;
	Mon, 23 Oct 2023 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698079956;
	bh=jQgUixbQL8W4wAwTjcJl3cwhkO3yCkXNSDqf574oSw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBG7jWc4h4+fJDaiS4Q/CaPIup2hO13Tne4/anTf6UAPe6fxoRMMivAn2M6uJKvgy
	 UrF4/gVI4IKFQbsAjygYKrjiUsEO9xHDnPLTl+cpgcYVDVk06QXpyak5mpqkBqoJU8
	 GMx+vshWWycWKcQU2nt0uL1VRjF83xSANNNOjYo8TM16Yn3Ra7K7URTRSIaWTUMv7O
	 3MkHeReIqsYdpYLmdD5PSyY4Uwske+NxTwOF2+KalNpMLM8R4UHrVahaxS2uEKIz3+
	 XpoEBCZQSyHPgDicSnvGFJC/bgMAOTi9Asxx8J2JAT0TWqOBe2HQaM+d8HdcJfJ3a/
	 lYe83bQx8Gi+w==
Date: Mon, 23 Oct 2023 17:52:14 +0100
From: Simon Horman <horms@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] igb: e1000_82575: add an error code check in
 igb_set_d0_lplu_state_82575
Message-ID: <20231023165214.GX2100445@kernel.org>
References: <20231020092430.209765-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020092430.209765-1-suhui@nfschina.com>

On Fri, Oct 20, 2023 at 05:24:31PM +0800, Su Hui wrote:
> igb_set_d0_lplu_state_82575() check all phy->ops.read_reg()'s return value
> except this one, just fix this.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Simon Horman <horms@kernel.org>


