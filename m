Return-Path: <netdev+bounces-51772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A97FBF2B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EAC282821
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80E3526B;
	Tue, 28 Nov 2023 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFWHfHx5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFA37D29
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 16:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D12C433C8;
	Tue, 28 Nov 2023 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701188834;
	bh=aK3/21f9RdYQmcl78FRdiNXVmir4FYYt7jy6fX2hIpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFWHfHx5ueIQ0Tg3EIGPSyC7hgzi/Jb+ytpkcUDYu3ppS3nmkvWds7wqI9z7dRVcv
	 wqtgM/4geSq5d9Dx57DkPryfc0Vc9TbJX/wQEFuyy2COHIBYEkUBcuA+fgB6McUwG2
	 79TqcJTuYyZwXlkF/fFa+C2B/W+atrX2ecSTWUMLJBiIAbnu1dqxZYGSepbOM7leei
	 2Ati39yHhzabrAgw7BSTTAAEXsiX4tMvaBrM59ZFYGkFQ0iBScxMDL/qVwsGKMqJOk
	 j71ETCHZKJgvr6s+ESmFYnqXHFJUZVAbz/7YJ28YU9GfDhOMwUoIYyN/Ye9bKwCalj
	 Ra9G7fV0xue1w==
Date: Tue, 28 Nov 2023 08:27:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
 <hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
 "egallen@redhat.com" <egallen@redhat.com>, "mschmidt@redhat.com"
 <mschmidt@redhat.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "wizhao@redhat.com" <wizhao@redhat.com>,
 "konguyen@redhat.com" <konguyen@redhat.com>, Veerasenareddy Burru
 <vburru@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v1 1/2] octeon_ep: implement device
 unload control net API
Message-ID: <20231128082712.223c4590@kernel.org>
In-Reply-To: <PH0PR18MB4734281BD887FD9AFD64B2DEC7BCA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231127162135.2529363-1-srasheed@marvell.com>
	<20231127162135.2529363-2-srasheed@marvell.com>
	<20231127184306.68c2d517@kernel.org>
	<PH0PR18MB4734281BD887FD9AFD64B2DEC7BCA@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 04:22:11 +0000 Shinas Rasheed wrote:
> > On Mon, 27 Nov 2023 08:21:34 -0800 Shinas Rasheed wrote:  
> > > Device unload control net function should inform firmware  
> > 
> > What is "control net" again?  
> 
> Control net is just a software layer which is used by the host driver
> as well as the firmware to communicate with each other, given in the
> source file octep_ctrl_net.c and the corresponding octep_ctrl_net.h
> interface, which is already part of upstreamed driver.

Yes, I think it went in before I had time to nack it.
I'm strongly against using the IP stack to talk to FW,
if you read the ML you would know it.

No new patches to octep_ctrl_net will be accepted.

