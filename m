Return-Path: <netdev+bounces-26385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC383777AD2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673A9282215
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067C1E1DC;
	Thu, 10 Aug 2023 14:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E7200B1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FCFC433C9;
	Thu, 10 Aug 2023 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691678059;
	bh=7Vwhp4p/XB6mca/2Nq2iQ1Eld7O1WIHV1khXbXPaM64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SC4wvhTAHNe74sHM1qaMTBG6OiQWGsAjGsQ1lWQEBEzeN1QsPl9c6Sw2LBaXtSLiQ
	 6iQnX2rDWiDmLLVGFzHxXrPSn50rELJw0s4FTeg8nwmQux+2uDwyD7zoc+I2OawE5Z
	 dVSB7DevxAR3Trkbz2SNetx6+FbxPnR7FG3LMar2RGwHjC/9cmgNSmjoJYgPds02ni
	 Y719c2GCoRkPMRbnQ4fZpL++XX9VINvelML1OLdbgCQbqnzkCIdP0fddmGWH5wJDbJ
	 QYKxI8xwkZM+NpgAswrAfyvCeBxIZNitNdxlkjqMBTbd/MxV1CXS21JS6AuL0T9VqH
	 WYDvd+hBLDxhA==
Date: Thu, 10 Aug 2023 16:34:14 +0200
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] octeontx2-af: Harden rule validation.
Message-ID: <ZNT1ZkWtLDg5rOnr@vergenet.net>
References: <20230809064039.1167803-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809064039.1167803-1-rkannoth@marvell.com>

On Wed, Aug 09, 2023 at 12:10:39PM +0530, Ratheesh Kannoth wrote:
> Accept TC offload classifier rule only if SPI field
> can be extracted by HW.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


