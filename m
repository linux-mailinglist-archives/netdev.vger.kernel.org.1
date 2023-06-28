Return-Path: <netdev+bounces-14457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D6741A07
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A6E280C56
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CB11187;
	Wed, 28 Jun 2023 21:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1711181
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 21:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F815C433C9;
	Wed, 28 Jun 2023 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687986373;
	bh=Ng9MErV+FXt3w7E3mEz9cVU8xZAj3zXrh381lvQcwJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=keaCDoxUZKxIZ0GIampVPP5V5J0kz0F6JiH28+AzKQUD11QXAvcmD+iB8DtEeJSsx
	 A9cdAh1P7UnPPlMaFIo3s1V2HMYVtQKNBK1R2hNyJWzkgVr9OqR+hGhPVPHelENQfY
	 /8OK+u+WQjfNnKFDiqRvVsC4306fj1UgHLWZTYAbBQESpQDzkbPhobzGdfkOfjFADf
	 txwJtkbsC8RcYeaVAj4/0KdNcRqVDsagvNdsTlO9Tvx2fL2RXSYLCl6PF0HwZOep9b
	 PizFD1q7G7B1pDU4OCOijEgQRTmhM57apqRM5uGo9ciONblPiATY5UiWVAVK5c0tuc
	 hnOqkMypa8VXg==
Date: Wed, 28 Jun 2023 14:06:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "brett.creeley@amd.com" <brett.creeley@amd.com>, "drivers@pensando.io"
 <drivers@pensando.io>, "nitya.sunkad@amd.com" <nitya.sunkad@amd.com>
Subject: Re: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
Message-ID: <20230628140612.4736ed58@kernel.org>
In-Reply-To: <1b33f325-c104-8b0c-099f-f2d2e98fed66@amd.com>
References: <20230628170050.21290-1-shannon.nelson@amd.com>
	<CO1PR11MB50899225D4BCFFA435A96FB6D624A@CO1PR11MB5089.namprd11.prod.outlook.com>
	<1b33f325-c104-8b0c-099f-f2d2e98fed66@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 11:26:18 -0700 Shannon Nelson wrote:
> > This message could potentially use a bit more explanation since it
> > doesn't look like you removed all the WARN_ONs in the driver, and
> > it might help to explain why this particular WARN_ON was
> > problematic. I don't think that would be worth a re-roll on its own
> > though.  
> 
> There has been recent mention of not using WARNxxx macros because so 
> many folks have been setting panic_on_warn [1].  This is intended to 
> help mitigate the possibility of unnecessarily killing a machine when
> we can adjust and continue.
> [1]:
> https://lore.kernel.org/netdev/2023060820-atom-doorstep-9442@gregkh/
> 
> I believe the only other WARNxxx in this driver is a WARN_ON_ONCE in 
> ionic_regs.h which can be addressed in a separate patch.
> 
> Neither of these are ever expected to be hit, but also neither should 
> ever kill a machine.

An explanation that this warning may in fact be hit and how in 
the commit message would be good.

