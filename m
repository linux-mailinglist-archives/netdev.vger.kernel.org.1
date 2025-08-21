Return-Path: <netdev+bounces-215841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E22B309A7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48580A0737D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59732E1F13;
	Thu, 21 Aug 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTPabGmz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5522A7E6;
	Thu, 21 Aug 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816671; cv=none; b=f5lLXxEzu7rFzGmmBvCmJvuZz7pHFR34T2CuwDmyxIFxRab24cfTAvH5AufcIUBRO+m3d2Mos0mupoCO/ZcEZjFPahfUwbtl7b1OriKSBaHI5W9SlEcBFjszMP8N7sR/cHvkLm59l5CUBH/N9kkAcgyIKuDJp37W1FHoVmtfVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816671; c=relaxed/simple;
	bh=ZxbMwKUravrnOTsnplYFM/EOlISuTPfX+nRiX1gXKoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLtLvQVZwQDWe3oWc6LspAUdSfE6n1hioWfSBmbvKDaMisfg1+FGIhd4vmHlphFM51p1jcjdena9hPIai7onydVLwnFVbCFbda1KwuthPg9OXXh2YtVCIlM3DOfZhLPKZ3mlcGBNnPjGWnnbupU2N1iPdEUGb0SdZRGG3l4ktX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTPabGmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74A8C4CEEB;
	Thu, 21 Aug 2025 22:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755816671;
	bh=ZxbMwKUravrnOTsnplYFM/EOlISuTPfX+nRiX1gXKoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KTPabGmz8aMwoGAtJ5HzOvAg2Q/TNF0Ml9HTkpqoNw+NbqErD5lHmy6ByoShsIIR4
	 FQ5t6vh6qfB2lALSHAyd8mgrA1cHQdbBc20Vgd383XrEAOtUQmCAEbvecM4wZt7H9X
	 VQJxLZfRsvXO9huarN20ASTTkhMCPCOw2rOSabH8ob7ok6ZSs9aHgorhPdjB21I3Ka
	 blloOcdmMDx/f1jyU78smnbJA2KYjSf9mAFWnqZol98zMkw701nI3x/Bcb1nLTvh3z
	 HmR33xmdV7w6eZv2jBN3A8yFCpRNTIrdnQ3zn82Phj3iTEZk3HgMM509vr2OlJ06IA
	 Ewf9BE0i+1XnQ==
Date: Thu, 21 Aug 2025 15:51:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: Ido Schimmel <idosch@nvidia.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, rrendec@redhat.com, menglong8.dong@gmail.com,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: vxlan: remove unused argument of
 vxlan_mdb_remote_fini()
Message-ID: <20250821155109.56588b14@kernel.org>
In-Reply-To: <aKW4Ow61whhnM__V@shredder>
References: <20250820065616.2903359-1-wangliang74@huawei.com>
	<aKW4Ow61whhnM__V@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 14:57:47 +0300 Ido Schimmel wrote:
> On Wed, Aug 20, 2025 at 02:56:16PM +0800, Wang Liang wrote:
> > The argument 'vxlan' is unused, when commit a3a48de5eade ("vxlan: mdb: Add
> > MDB control path support") add function vxlan_mdb_remote_fini(). Just
> > remove it.
> > 
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>  
> 
> OK, but personally I wouldn't bother with such patches unless they are a
> part of a larger body of work.

+1, I'll drop this.

