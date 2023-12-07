Return-Path: <netdev+bounces-54932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B59808F8C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E2B1F21151
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01CB4B5D9;
	Thu,  7 Dec 2023 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaQB/1QQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922641400F
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D14C433C7;
	Thu,  7 Dec 2023 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701972341;
	bh=1rHnRo1OxdwPdjBcECC27VCHGCyW8gdU2nJP9R/mPpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VaQB/1QQtlH3X5JWQu5Wjh9B4+qcmIC5eAtKaSteSgszABQZM4t8fYxAEEPNVXEag
	 pJqTtoWM6GQypqO8T/4C5fWhdbwXjv4Uwf0x5M/EYm9A2dah8fkZzrsflEdYEQP4PO
	 gO4jKv+u6sMUiZF12kXWsCx6xLP3MRv+H4OspacSMre+g7GnPuEzMFI2TIE8g5A4A0
	 VVednt0rfRNoP/9zuGfhCdo9dXWpqcoohKkOBZ455Fi5jVtQm6KEQArx+FbKqwd+kK
	 qThpvyo64JvTZAgPsoO8QARI/YN/neeUpZsE7Syc+mN+9eyKPmqAwr7dt0IWkv8ICO
	 W5UncTTZ+QHdA==
Date: Thu, 7 Dec 2023 10:05:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: duanqiangwen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com,
 jiawenwu@trustnetic.com, davem@davemloft.net, andrew@lunn.ch,
 bhelgaas@google.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net] net: wangxun: fix changing mac failed when running
Message-ID: <20231207100539.210efc63@kernel.org>
In-Reply-To: <20231206095044.17844-1-duanqiangwen@net-swift.com>
References: <20231206095044.17844-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 17:50:44 +0800 duanqiangwen wrote:
> in some bonding mode, service need to change mac when
> netif is running. Wangxun netdev add IFF_LIVE_ADDR_CHANGE
> priv_flag to support it.
> 
> Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")
> 
> Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>

Enabling something is not a fix, sorry :(

