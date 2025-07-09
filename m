Return-Path: <netdev+bounces-205402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59208AFE876
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA1164091A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A52D8368;
	Wed,  9 Jul 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hztD9qzG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7342957CE;
	Wed,  9 Jul 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062181; cv=none; b=iI7ck2e33u3T4FZOTg+rP9eFuH39SZyX/964r23hn/3KzSiKmjVVH6UsU2MNjUwIbMdBcDGI07sjC23SxM+DBfl/DmMZUDl/63X+qkWQ1E7vPSb9JhoIFhngW3t9D6lnik92crVcng/Qo8CCgYxqSY4REf8RcRMhhF41CYLhhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062181; c=relaxed/simple;
	bh=o+MtEkPq/X8r9M1iAcEaJnSltLhc2qpekc45r2tDwbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtwxEY3r31Yf/cQXzaeIGRHUkK0yFwhSh6QjdDSUyaxjTMev6Qgi+0AniaBS/4cy3IHagldyJRsqDY+qMZmRfc5sN1kzl9HCFMhFzmHMDaW7xX/sPmTLLJpRDY4ox35g8ZhRCZD4ZoBH71JM/7F32s0afEoXTJ3L9SCfqcUACwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hztD9qzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F274CC4CEEF;
	Wed,  9 Jul 2025 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752062180;
	bh=o+MtEkPq/X8r9M1iAcEaJnSltLhc2qpekc45r2tDwbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hztD9qzGvemcgRvJgL4sNnAIXxx3DNEO3unSKn7rgeAOlmv1TwekB7npR1HJRtWlB
	 9dbqgjBtm8hFdx3VvWYGSlBb4u0vRfrwx+xw98VREv1DEI/1+MFRx8UK/xHoazx+r7
	 n9JVJSg2WheIReKSRBSNgkjILmudujDjCnIe3mGWYEVYLkqhtAaP8RH9/jjkvR3JmT
	 ufzWQwebsPofqDsIs9s4PkZQWFQ9LXijzI7wGC9AllSHd0uY9ElBuuC6T04dULJaUw
	 fSfhQ1o8XDQC25MyWmulJzHbC2qStvkSVpCRdZ79KLOOC/Co6Mi8XSo0guTgm7CRYE
	 PoagvLyLpHhxw==
Date: Wed, 9 Jul 2025 12:56:14 +0100
From: Simon Horman <horms@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: vadim.fedorenko@linux.dev, andrew+netdev@lunn.ch,
	christophe.jaillet@wanadoo.fr, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, gongfan1@huawei.com, guoxin09@huawei.com,
	helgaas@kernel.org, jdamato@fastly.com, kuba@kernel.org,
	lee@trager.us, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, luosifu@huawei.com,
	meny.yossefi@huawei.com, mpe@ellerman.id.au, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com,
	shenchenyang1@hisilicon.com, shijing34@huawei.com,
	sumang@marvell.com, wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v06 5/8] hinic3: TX & RX Queue coalesce
 interfaces
Message-ID: <20250709115614.GZ452973@horms.kernel.org>
References: <ef88247b-e726-4f8b-9aec-b3601e44390f@linux.dev>
 <20250709082620.1015213-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709082620.1015213-1-gur.stavi@huawei.com>

On Wed, Jul 09, 2025 at 11:26:20AM +0300, Gur Stavi wrote:
> > On 27/06/2025 07:12, Fan Gong wrote:
> > > Add TX RX queue coalesce interfaces initialization.
> > > It configures the parameters of tx & tx msix coalesce.
> > >
> > > Co-developed-by: Xin Guo <guoxin09@huawei.com>
> > > Signed-off-by: Xin Guo <guoxin09@huawei.com>
> > > Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> > > Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> > > Signed-off-by: Fan Gong <gongfan1@huawei.com>
> > > ---
> > >   .../net/ethernet/huawei/hinic3/hinic3_main.c  | 61 +++++++++++++++++--
> > >   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 10 +++
> > >   2 files changed, 66 insertions(+), 5 deletions(-)
> > >
> >
> > Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Procedural question about submissions:
> Are we allowed (or expected) to copy the "Reviewed-by" above to future
> submissions as long as we do not modify this specific patch?

Vadim is free to offer his own guidance, as it's his tag.

But in principle tags should be carried forward into future submissions
unless there is a material change. In this case I think that would
mean a material change this patch.

But if in doubt, please ask.
Thanks for doing so.

