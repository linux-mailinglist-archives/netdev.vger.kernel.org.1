Return-Path: <netdev+bounces-45156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C27DB351
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036C41C2097F
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F77802;
	Mon, 30 Oct 2023 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfTZWcsu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5C6117
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D4DC433C8;
	Mon, 30 Oct 2023 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698647470;
	bh=mG4hdp7IHrT4ZQqHYQv1gv+qd3IAd5Xgre7bwsKrd94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QfTZWcsu5wYJwtIeyyX5O80pKbZUbPVYnWPEfyf4/vd8d+5iIy2GUFPCqCp0gBlFr
	 zxObu68aQB+DmUo5gbMunrsTKcozUaMnxXxAtWb+CBBf6gO6T5m5T6tVa7FVT7dZWb
	 xH+rWuZ4vsVUebl0kv2At89MlDcSAIhKB+ADQDVDQ4rwHcsRtYTkyAOf7VeWBSxQwR
	 vaqrlBG/z7nd3KdMJvtzI14qPuzOeoDd3mdDH+muDIoM8iSQA+UgP/2P0/TVfPLHid
	 8+bUV8d2imtbhxasZCq5TbS/0puEFJKYHxZd2uqSovu5cXqji/h66MC5L0QJAFIrnD
	 RFJgGXHxMnwgw==
Date: Sun, 29 Oct 2023 23:31:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
 <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>
Subject: Re: [PATCH net-next v3 0/4] Cleanup and optimizations to transmit
 code
Message-ID: <20231029233108.0bac2231@kernel.org>
In-Reply-To: <20231027121639.2382565-1-srasheed@marvell.com>
References: <20231027121639.2382565-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 05:16:35 -0700 Shinas Rasheed wrote:
> Pad small packets to ETH_ZLEN before transmit, cleanup dma sync calls,
> add xmit_more functionality and then further remove atomic
> variable usage in the prior.

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


