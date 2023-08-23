Return-Path: <netdev+bounces-29836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CDD784DF9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ECE281229
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3410E3;
	Wed, 23 Aug 2023 00:52:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67767E2
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E200C433C7;
	Wed, 23 Aug 2023 00:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692751928;
	bh=sPhejjQmGXXwZiarxNfyZoYdQozrlcRiKpo4M072i+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KgehLU77Wh2vDEKtbi4o8STryposvdc2lI9adccbIcKAg3SR40I2oAv866xgGGo4h
	 SID8P/VAH3lGyIn8GEqChtGCycdpE7SBxiDHnIGDiu3kTLUCvklCsvhZtN4wM0nwc7
	 6/E8/HI5DzUOWtOpPDTfXIGstTLfGusmK4u9TRa4mYnbKmaQfAfggBWtnnTwvfwO5/
	 Xtu4/nlEIqE1gHexUeMEHsPYHecpBmG7CAH464IC1klszT+m16K3D239pNq6mMpTlr
	 DyjUFlJGIlqpX3mByW1gIX9g4gIbAOxdMx8YzQJv1hWozzJkIQW3lTKQMovselvWE9
	 o7zxlQ8jMErPg==
Date: Tue, 22 Aug 2023 17:52:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v2 7/9] net: Add NAPI IRQ support
Message-ID: <20230822175207.17233a9e@kernel.org>
In-Reply-To: <169266034688.10199.12117427969821291880.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
	<169266034688.10199.12117427969821291880.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 16:25:46 -0700 Amritha Nambiar wrote:
> +	if (napi->irq >= 0 && (nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq)))

Unnecessary brackets around nla_put

