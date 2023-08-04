Return-Path: <netdev+bounces-24428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274CC7702AF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9AF1C20A83
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC8CA54;
	Fri,  4 Aug 2023 14:12:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D1CA45
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F0FC433C8;
	Fri,  4 Aug 2023 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691158332;
	bh=9m8AC+bsdBEd4+3Ct67I+iUT7kNtSSnWTLcE0cxGOh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vxuq8GcfU8CbW82M1aPE6KQUpdVQFhf1egy51e7jMh1jToGCYvtjif15Xo0Mj4wQg
	 ijFSau1X9QiJ9uMAzVFonWEc/qIGnjHv3rpWYvFD1OuJecIAk5YuG9uIUGEIT4dldz
	 mPLImK4uTj2W6cn5rB83oa7IzkzIvIlhbcMDFS31aPlQi9n99QtjZUv2fSvv8gSZyM
	 NTWI6KkiXZ4e3jlznydwzqkDrlvPnaigvKdiQWa60AupQoHoquFuDPG53u9C6G0t5N
	 z2Wzfvvrc+QcF0dqdMlil02Iww5rIof7INw3rbmTPO/OYV0x0VAbRxgc8CQ7wpE15h
	 XAV0+XY8wDW3Q==
Date: Fri, 4 Aug 2023 16:12:06 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Liu Peibao <liupeibao@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 pci/net 0/3] Fix ENETC probing after 6fffbc7ae137
 ("PCI: Honor firmware's device disabled status")
Message-ID: <ZM0HNv8kxMIcjXst@kernel.org>
References: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803135858.2724342-1-vladimir.oltean@nxp.com>

On Thu, Aug 03, 2023 at 04:58:55PM +0300, Vladimir Oltean wrote:
> I'm not sure who should take this patch set (net maintainers or PCI
> maintainers). Everyone could pick up just their part, and that would
> work (no compile time dependencies). However, the entire series needs
> ACK from both sides and Rob for sure.
> 
> v1 at:
> https://lore.kernel.org/netdev/20230521115141.2384444-1-vladimir.oltean@nxp.com/
> 
> Vladimir Oltean (3):
>   PCI: move OF status = "disabled" detection to dev->match_driver
>   net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
>   net: enetc: remove of_device_is_available() handling

FWIIW, this looks good to me.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


