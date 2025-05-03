Return-Path: <netdev+bounces-187564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65209AA7DD7
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EA24A0046
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE835957;
	Sat,  3 May 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHFGKKQh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2155DDD2
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234731; cv=none; b=EKcw+ZqhHfTa/O67MsZsvXS6UL+syG492PAx34245KZVQaYL0iJzlpzvC6+/UJW/+cwwka5zE+evyZyFTfWII8IEtdak3lKByMJTq4vrETsQXOOeariy3dg/1nXojbl1jKEt8F1nF4PhSoHaj6OuWCSizX7seYN6RjcAOh+Cttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234731; c=relaxed/simple;
	bh=UCr5T6K4CJuDDgOx4gvr+YTWhICDbwksYel5Qz0G/ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQNF+TkBut91/uSZx9slWdzo4a2M7ZleSutermFKNDrIOGNOcrgsYsIydbGs+wTOFETF6SelEraFnSx8+MtDUQk+MMiJhu8gm4IRNSpejLASWgjP0+q49pMk0BwzOVy6NXolwvRWHixRAx9WxoKUXDNbUdmqvANohVFQ+IymdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHFGKKQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6DDC4CEE4;
	Sat,  3 May 2025 01:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746234731;
	bh=UCr5T6K4CJuDDgOx4gvr+YTWhICDbwksYel5Qz0G/ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AHFGKKQhpOZXZ/n7SGpLF/QCisoPwAqzpozhOycDocS5gOxf186yPAauYsHGK5biY
	 8FMrsrQ0+stIWdv0B5CLELBHuflTxnuLDNj4vuzYxkKNoSlybhnQ1SwTgxOTkujlZd
	 4P+9tz+d3PAU4xVlSZWglYPuZS1H6oiaqBpDNlOM9RBbtysLef2nYD0MIbo8h0WzhY
	 ERQP6/Bd6/hATAx59HPXWQUOnTk3zxu0dUbDl2FPQRFSrIUotHvJGsA48YgUGcs7iL
	 0m7/LvWt/y4AemE0+mtSFFbFYKAbU79sUWq8jvULjwSo5quMkrpkWvN0bryy87Zf0s
	 lBe8flKVmEJhA==
Date: Fri, 2 May 2025 18:12:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <20250502181210.75b9d144@kernel.org>
In-Reply-To: <aBRzQaonAK0IyAsu@lore-desk>
References: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
	<20250501071518.50c92e8c@kernel.org>
	<aBPdyn580lxUMJKz@lore-desk>
	<20250501174140.6dc31b36@kernel.org>
	<aBRzQaonAK0IyAsu@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 May 2025 09:24:49 +0200 Lorenzo Bianconi wrote:
> > > What I mean here is the padding in the ppe_mbox_data struct used by the fw running
> > > on the NPU, not in the version used by the airoha_eth driver, got my point?
> > > Sorry, re-reading it, it was not so clear, I agree.  
> > 
> > You mean adding the "u8 rsv[3];" ? that is fine.
> > I don't get why we also need to add the 3 __packed  
> 
> I agree the __packed attributes are not mandatory at the moment, we just agreed
> with Jacob that is fine to add them. Do you prefer to get rid of them?

Yes, they also imply the structure may not be aligned, AFAIU.
__packed used to be one of DaveM's big no-nos back in the day.
Especially in vendor drivers it gets sprinkled everywhere without
thinking. So maybe it's all school of me, but yes, please remove.

