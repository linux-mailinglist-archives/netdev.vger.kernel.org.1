Return-Path: <netdev+bounces-176506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98080A6A929
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1023B17CB0A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941311E1022;
	Thu, 20 Mar 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSVMFLXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766A8BF8;
	Thu, 20 Mar 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482566; cv=none; b=mh1ve5cv2flho31P+ityFIuaZD02Lg5LS5NARLEBtkTLZq779i9CbrWiPFdjpvseyNYdezbv90Jt8yX4+NKeQ8ifyBX0WNPOmQv0oCNlC0OODHj4UyF+PM3QPtIvaHTqK7foMTEJJcaFBeLKkT6fNomgMqoctLUDL2oPYQtqOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482566; c=relaxed/simple;
	bh=DEQ4SQovtGJhf5I7qm+v1bo7YXqeiuODFmBSdVBmv4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5XME/LgeFq9Z9/Aq9fTw/3G/2AwLZdgeKHwu00nRzPafU9jsL85tgWEjdedAbYFZSbIMg7bnAm6t7r8cZz32rwdT++5VzJcj+VOVmlBYAY1nnVajYl0VUGsyulkKbp4v8E/5a/AblfSWyOfgBVzI20Scc31VoY12fQo9Xt7/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSVMFLXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BBC4CEDD;
	Thu, 20 Mar 2025 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482565;
	bh=DEQ4SQovtGJhf5I7qm+v1bo7YXqeiuODFmBSdVBmv4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSVMFLXyFzPJI+hkOQlOLu+y4DXUt2bDNDNburzDNwR9viykexwmdG3Jdp0RaYwSH
	 +ZFT/SrMHPUxZyhpjyrx/+Py3pUnIqWDEUQVtfwjDTgGt8QEWFkeTLD6Xx0DW5xqN5
	 I4zBCSuzfgrNP3RZa9GPa7Pc3fjcgvoFxp2MiSjsSahfg90jCvZnlH+pqkUW3J96TH
	 pMIyyVQ/2xtap+g/qlVnh3opT3GX8psMTBXvIfD4J3/N/DFnXiUmsFlFmMw0s9UyOd
	 VT/IvIle3SPNmPK6GZF2A/CNEbwt0JfPV/i5zCxTtajyykItR9uTSkUOrUrRfDwUYA
	 7ytacpmnvrw/A==
Date: Thu, 20 Mar 2025 14:55:59 +0000
From: Simon Horman <horms@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Lee Trager <lee@trager.us>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v09 1/1] hinic3: module initialization and tx/rx
 logic
Message-ID: <20250320145559.GB889584@horms.kernel.org>
References: <cover.1742202778.git.gur.stavi@huawei.com>
 <60a3c7b146920eee8b15464e0b0d1ea35db0b30e.1742202778.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60a3c7b146920eee8b15464e0b0d1ea35db0b30e.1742202778.git.gur.stavi@huawei.com>

On Mon, Mar 17, 2025 at 11:40:39AM +0200, Gur Stavi wrote:
> From: Fan Gong <gongfan1@huawei.com>
> 
> This is [1/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional
> driver.
> 
> The driver parts contained in this patch:
> Module initialization.
> PCI driver registration but with empty id_table.
> Auxiliary driver registration.
> Net device_ops registration but open/stop are empty stubs.
> tx/rx logic.
> 
> All major data structures of the driver are fully introduced with the
> code that uses them but without their initialization code that requires
> management interface with the hw.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> Co-developed-by: Gur Stavi <gur.stavi@huawei.com>
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>


Thanks for addressing my feedback on v8.

Reviewed-by: Simon Horman <horms@kernel.org>


