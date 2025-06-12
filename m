Return-Path: <netdev+bounces-196876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3FAD6C1D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1633AFAAA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11FC226CF1;
	Thu, 12 Jun 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xgTe/FN7"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C43227BB5;
	Thu, 12 Jun 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720496; cv=none; b=O8GXKBu8nmHJIdhIlNzyBeoAk1HJLdmNn6cUAPEknn8RwdzSXYe8ZkFGo1/o++HqWRmmM+DdA8xebS4Kk4i5PDO8PAJxpVobndDQWssUuolIVu4wGPEEfg+P5RM+2wLesIkO0z4sauU+Dz2+92Zl5I14x/j2GSf6kdjYYlcGnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720496; c=relaxed/simple;
	bh=VRX1FO0GnzrpWVk6k1T0HVFuQv1QigjCj6OHh9C97yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2dIiw4qNi8O4VujZCSe48lhR98/tVlX7bGPw6yvRoWyaT42ZBV7c0IosV3am2sSR4+oP3OTo8ngwlrVKh1Vj/GjuAChMymtZ8nUeM8AyCEBITeEIjsq1WoKIIfYAvlqANG+8afCuHbH3TM8CatTMsJkBSQxjyccQM4FmlZKNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xgTe/FN7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64b98bdc-5375-478f-813d-b2209986c253@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749720491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kSSs5d+mURldhTGN/D4hGaJTvjJYpIqJefyMHl21BE=;
	b=xgTe/FN73ktwVsc7fUPBN23gcKu79EvC4q84/rbc5wcbqC6WqfHSo1lv323W47baMOF2mB
	RC0yT8A9xXPxkpNp65M9CTcCX8IFoYM5jp1zb72p4tY4jc1QAd84Xh6uEgkHIWlqg61HiB
	3DGyEfQL+HfP9i8bAMXbtAkoTpKimxE=
Date: Thu, 12 Jun 2025 17:27:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: extend use of snps,multicast-filter-bins
 property to xgmac
To: Nikunj Kela <nikunj.kela@sima.ai>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, inochiama@gmail.com, l.rubusch@gmail.com,
 quentin.schulz@cherry.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250610200411.3751943-1-nikunj.kela@sima.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250610200411.3751943-1-nikunj.kela@sima.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 6/11/25 4:04 AM, Nikunj Kela 写道:
> Hash based multicast filtering is an optional feature. Currently,
> driver overrides the value of multicast_filter_bins based on the hash
> table size. If the feature is not supported, hash table size reads 0
> however the value of multicast_filter_bins remains set to default
> HASH_TABLE_SIZE which is incorrect. Let's extend the use of the property
> snps,multicast-filter-bins to xgmac so it can be set to 0 via devicetree
> to indicate multicast filtering is not supported.
> 
> Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng


