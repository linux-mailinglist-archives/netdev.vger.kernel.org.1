Return-Path: <netdev+bounces-50477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B97F5E8D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36BF281C9C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F4241ED;
	Thu, 23 Nov 2023 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReK8N3T9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6B2377F
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 11:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262BC433C7;
	Thu, 23 Nov 2023 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700740703;
	bh=6rq3wbNnETxmGO38nmjeAXuf2R7yIaTdB+RurHtR94s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ReK8N3T9qK44A4ISJlFiWiFFDjP+AZ13R55LmXzAECstsIG0PbM/mCm8RJjxXX5hJ
	 kP9D7KIB7sZeE8u/K9w89wgKRsDzRyuI1K1TmykhD4+SS9syKgtHAlrXwy4uOs4s5D
	 321wrppn1hKNaJDxT2IFPnSGOgehxTCQNAMkfwxw84yZrQqxk8E/0dARIP0r4fXcg0
	 uhN2iyBqwUOSBX+64+bJscIjZV/wajbCSQwZz/AiiwVlWMpUss+Ok1+A+8bTrOfUzJ
	 1iw9GrbgfP87j6gT92nwY0dNnSZgxR9o6HL8O9Q7GuJmoZzqD7aYCNQDWN3qCkDKlt
	 ZZ03JRsa1RdbA==
Date: Thu, 23 Nov 2023 11:58:19 +0000
From: Simon Horman <horms@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] e1000e: Use pcie_capability_read_word() for
 reading LNKSTA
Message-ID: <20231123115819.GC6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>

On Tue, Nov 21, 2023 at 02:34:28PM +0200, Ilpo Järvinen wrote:
> Use pcie_capability_read_word() for reading LNKSTA and remove the
> custom define that matches to PCI_EXP_LNKSTA.
> 
> As only single user for cap_offset remains, replace it with a call to
> pci_pcie_cap(). Instead of e1000_adapter, make local variable out of
> pci_dev because both users are interested in it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


