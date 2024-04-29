Return-Path: <netdev+bounces-92164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D18B5A6A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A97FB227FB
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455FA7441F;
	Mon, 29 Apr 2024 13:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E422C69C
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398436; cv=none; b=NXY4QH97sgzc0p5p9TJ3/zoZoKCwLMFPUgs0UDgRh1UmmgOIMsXDoZGLcZTv0n1VJo2ziBrSQp2+P9Pxoy/05eZ3R6i4qVAFRl7JcRly2DKgdtxuwGGiuchSTdLRLHm2eK3KGO3A1IlsJcgb/I5jZxLFdUb4apNDniWMjiOhgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398436; c=relaxed/simple;
	bh=mqkQEedfFiq4cug1djlG7kSNVF8ghbsq4vxofuBAmJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edabafXwS9Iy509PMA28vzall1fGu6vrP6VsuabIhgbMaKKC1f4mwM3NsSPYnv9lzL/L/bQF4iiLnrH4L3At6PnjDcjE0gmkyd5YiVm+8gaw5lFsejjwLt6SXAut3gOkGhXWZ+jRqJM8wiOR7txTCr7oP0KJgkfdMhuzmAXysuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-4r_Zqm5cNX-Ns80srMWlQQ-1; Mon, 29 Apr 2024 09:47:08 -0400
X-MC-Unique: 4r_Zqm5cNX-Ns80srMWlQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8713B104B506;
	Mon, 29 Apr 2024 13:47:07 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 39E59202450F;
	Mon, 29 Apr 2024 13:47:06 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:47:05 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leit@meta.com,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: loopback: Do not allocate tstats explicitly
Message-ID: <Zi-k2cAjbSMdIDjs@hog>
References: <20240429085559.2841918-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429085559.2841918-1-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

(nit on the subject: you mention "tstats", but the code actually uses
lstats. I guess that's not worth a v2)

2024-04-29, 01:55:58 -0700, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the loopback driver and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina


