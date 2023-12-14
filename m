Return-Path: <netdev+bounces-57627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E75813A7E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBE8B20F93
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5C369280;
	Thu, 14 Dec 2023 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nveaMoXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7584123D;
	Thu, 14 Dec 2023 19:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B1C433C7;
	Thu, 14 Dec 2023 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702580983;
	bh=0zh/T1ccJ6H3ErxAaZTCEfbd8EoopARZsmROrnRp1Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nveaMoXUbx/nE45nYr03IIu+3OLICBCgOY73OUTcmookTsAsMjPyBaXFLl+fGaVtj
	 dbqMb+GFv5CuHJ5SYCWLBMIgajpEHGBXLHnejbXx7OIpIE/kCgtxz7czfiQHQ0Cm3+
	 waobIdGnw49ZdMcpGL//1Ccx/gPGtgY55qh1+OhiX//ejUQyhp/fB8Z+/no4B0R1z/
	 bUhRbzedxq0wberMu0z/IBnosQS27hBKVVKVLPcMoMnpFERlwzbrUXLi6O5v1rnfhh
	 uUfvPCUQWMojWUkNQKqlWjY5FdbLTAQNo030+fTu3YI17dVU/Bk+t/pDCXsVUqsG3T
	 rDJXtQJ2OrM0A==
Date: Thu, 14 Dec 2023 11:09:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 fancer.lancer@gmail.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v6 0/9] stmmac: Add Loongson platform support
Message-ID: <20231214110941.72d61bd4@kernel.org>
In-Reply-To: <20231214110901.216f11db@kernel.org>
References: <cover.1702458672.git.siyanteng@loongson.cn>
	<20231214110901.216f11db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 11:09:01 -0800 Jakub Kicinski wrote:
> On Wed, 13 Dec 2023 18:12:22 +0800 Yanteng Si wrote:
> > [PATCH v6 0/9] stmmac: Add Loongson platform support  
> 
> Please use --subject-prefix="PATCH net-next vN" to indicate that 
> the patches are for the networking tree.
> 
> Unfortunately they do not apply so you'll have to rebase and resend.

But perhaps wait for Serge's comments before reposting.

