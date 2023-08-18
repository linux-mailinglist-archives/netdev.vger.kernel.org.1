Return-Path: <netdev+bounces-28686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F1478040F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E111C2156B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA9101E7;
	Fri, 18 Aug 2023 02:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67448BF0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148FCC433AD;
	Fri, 18 Aug 2023 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692327497;
	bh=oJkscY7k8ETbOBb5btkcsowLOEUU91ez5liTuP6HHl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O4wnYOln0ukb/XfENTUH4VGsVeu45Jd3RkU5zqAzKccWOQl/qar9jne1IYGHRiuPs
	 1rYHIBEXhxaLDYNalzA4tGYabalLBM1yx6AGj8MkwluL8wKV0+Q7Fjky9EGtuRWemj
	 x9/fnmuEggU1IFvE9xAncZxxrRzYZ62wphniX/4VD+yeL0DH+UcNP3QtyJGhoLcNMk
	 nUDMuX+3wYlbT/59BxPG5+Z3iXZBr1Ow/o4cZ+EKvpMuVIazuDJXHpisVFC4WlbOkm
	 uW7q99kvPnJ/GYgPF4DITX0IJaYMXyhsufKVLj2uzZ3tLK95p+U5nEuUFCamT4oEy0
	 81e19HJRAOh+A==
Date: Thu, 17 Aug 2023 19:58:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Alan Brady <alan.brady@intel.com>,
 pavan.kumar.linga@intel.com, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, andrew@lunn.ch, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org, Alice Michael <alice.michael@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Madhu Chittim <madhu.chittim@intel.com>,
 Phani Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH net-next v5 08/15] idpf: configure resources for RX
 queues
Message-ID: <20230817195815.4bf4f2b4@kernel.org>
In-Reply-To: <20230816004305.216136-9-anthony.l.nguyen@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
	<20230816004305.216136-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:42:58 -0700 Tony Nguyen wrote:
> +	page_pool_put_page(rxq->pp, rx_buf->page, rx_buf->truesize, false);

I think the truesize here is incorrect, there's new documentation 
for this very case:

https://docs.kernel.org/next/networking/page_pool.html#dma-sync

