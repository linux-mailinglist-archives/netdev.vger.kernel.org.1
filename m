Return-Path: <netdev+bounces-15233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0766274639B
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 22:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB75280D72
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0811C81;
	Mon,  3 Jul 2023 20:02:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A903111B6
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 20:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A652C433C8;
	Mon,  3 Jul 2023 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688414518;
	bh=V/OqSaDzAG+SkC0R5+/Fo5p488DAX5YE2UATCXuE0FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fOT5ktEgkGlDDngKTnqJkpTSl23aqqYmmGK3PfovR31sLklDv6O3FDBNgq/W7YxI4
	 VPlud367RVqb83kQNvjqf5/5YGTxYdY+we7zQw2V9L8JhCLaFKVV1sA4DsHlv7dEwO
	 AtJGizAi5Hp8NjkUXMHIg20xxmvwweIwq6mSZ2bliC5pe1jldElurTfZjDn+u1K5z2
	 mYt7eIZBpTs+n2pOs1SXVA7a07m1EcBKeqveDV4P/y0CSVm43qkY98Y93DKILc33OI
	 EZCIzScHkjVg0lKOCnxCIiypdWIY9HgAfDOZTGfSCfIA6bCHwYrnw0L2+NIF58D1DV
	 d11Fix/9uI8MA==
Date: Mon, 3 Jul 2023 13:01:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] octeontx2-pf: Add additional check for MCAM rules
Message-ID: <20230703130157.487e6f80@kernel.org>
In-Reply-To: <20230703170054.2152662-1-sumang@marvell.com>
References: <20230703170054.2152662-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jul 2023 22:30:54 +0530 Suman Ghosh wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~

  Allow at least 24 hours to pass between postings...

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

