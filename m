Return-Path: <netdev+bounces-151278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C49EDDF5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A021888C1A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B713D539;
	Thu, 12 Dec 2024 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa5922Bi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092147346D;
	Thu, 12 Dec 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733974735; cv=none; b=DT7EPziN/L3TYWHD/MgK+HRNuMPDyp2jOqY1qat8bC63GpfH70uRybs7BeQ1y3RhINKpn0oTY8cDELUjUvXbH0Hcp/4iX6KPPEaTgcEOTMpp+TqJh0nkj1kcym5d199gR7wDkC5jxpBm4YkhiNCpgwMdws3493+yfubgIOsAqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733974735; c=relaxed/simple;
	bh=xXIwQz+7Oo+XuICxcdAgCUZpGj0zV01YwKG/RaioLLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TziDxdlP14iISIb8w+lQLCogOQ9Fh3makrCcm5ICBzvjS3mDXR3HSUjCcooJdL61k8aqzPIlEPJZjj9Bo2CMeBESo42aARKCT6ACdApYIecEEsI7Fntlo4Hu2zvo90uC9uTMtagAkabSNlXBoYMp/FYcP56VwGX47VcCO8qlGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa5922Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB5DC4CED1;
	Thu, 12 Dec 2024 03:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733974734;
	bh=xXIwQz+7Oo+XuICxcdAgCUZpGj0zV01YwKG/RaioLLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wa5922BiQrE+b1XPh2agtoyvpfKyJY0mN8Sq6lqj0DK68Ad7GlWcII/hkeNKmbEUG
	 WPFel+z7HRTDO/UeZ6+LhkDWDT1mDJqPiLePn9j8sTSGFDdM9802AGuegFeLBNpA31
	 0Wa3qBYAqibN/Yxj8CLl1DdOb8VSns5USnVJ+vE6b4ZNDOThnJ71++p9han8gnSfyw
	 zFdPKMJGCbffh2K57Actpz5SzOqeIOLaYHhZAxk7p3Z0V2nSosSpdQoP9uLdmoA/2O
	 wys3cR53Snfi1ONoRKs6Nq+MNr+wlm2kmu24rZjgdyd+JOoodinrmBPZkJgv4qrUv9
	 Yf59/SLEw9lFA==
Date: Wed, 11 Dec 2024 19:38:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <gregkh@linuxfoundation.org>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V6 net-next 1/7] net: hibmcge: Add debugfs supported in
 this module
Message-ID: <20241211193852.262f11da@kernel.org>
In-Reply-To: <c36b6423-720f-4bb0-ac7e-8e69a5c2a81b@huawei.com>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
	<20241210134855.2864577-2-shaojijie@huawei.com>
	<20241211060018.14f56635@kernel.org>
	<c36b6423-720f-4bb0-ac7e-8e69a5c2a81b@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Dec 2024 09:35:02 +0800 Jijie Shao wrote:
> I think debugfs_create_devm_seqfile() is a better choice,
> if not use it, I might need to code like so=EF=BC=9A

Oh, sorry, I thought there is a non-devm version of create_seqfile().
Let me review the rest.

