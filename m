Return-Path: <netdev+bounces-98885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E38D2E05
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DCE2827F3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7A1667ED;
	Wed, 29 May 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nIBaTk2p"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3881E86E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967305; cv=none; b=Mc0PCQV94AOje/1JoRB+/BiVPPArO8AG4C/qWSCuULDKh2dSmuG3zVYglgQ7rdPfsYDcMxKUD8U0Uppfa/w835V0CgGFc50ITXNlsmdF/AGrfaEQWUFRHg4gc1OyMhhZqyAea0SflJL6MHp/4zGOeIHR/2h1G/9OqZk9IV1aVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967305; c=relaxed/simple;
	bh=za40URO3XEGGSMZ7qFWEky6i8CVpSqUZNKlLLPfrqI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n60JHHB93pv+LVSqeYRrzrL0iD4QsmFG7zN948Y4UrACPZpwrd9d77CItt7myhLkfAPAzm6Zf5kdjJ8+Lg+PUP+ZmCa4XERuy80Hzcrj5+zpqzwK4tpWJDLx5oZqr7dLVznCYaHCS6nZ32aNuDU0Nvw3Nw7vi/5iKNS0x1iCqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nIBaTk2p; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716967293; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=PwOkjEKzfovpmUKP0x8U54qXkkToloOTuIoK1p6LPN0=;
	b=nIBaTk2pqOHOdCwcoNQZfPGSzUHguAwgCZXhk5eslEe6VLfhzA/L91yP31cIXES04lR9Gu9mxUhXCS44Jy/dbVZlNc7sUuoTYaf2SIwe3SG2XSdivy3zgr4jqmNq2h2rW46f3UKH0OKDpRukoBlnZKncj7w4F9EMguO9p3My5Sk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7Rsj8i_1716967292;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0W7Rsj8i_1716967292)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 15:21:33 +0800
Date: Wed, 29 May 2024 15:21:31 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Kevin Yang <yyd@google.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
Message-ID: <ZlbXeytf4RkAI40N@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20240528171320.1332292-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528171320.1332292-1-yyd@google.com>

On Tue, May 28, 2024 at 05:13:18PM +0000, Kevin Yang wrote:
> Adding a sysctl knob to allow user to specify a default
> rto_min at socket init time.
> 
> After this patch series, the rto_min will has multiple sources:
> route option has the highest precedence, followed by the
> TCP_BPF_RTO_MIN socket option, followed by this new
> tcp_rto_min_us sysctl.

For series:

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

I strongly support those patches. For those who use cgroup v1 and want
to take effect with simple settings, sysctl is a good way.

And reducing it is helpful for latency-sensitive applications such as
Redis, net namespace level sysctl knob is enough.

> 
> Kevin Yang (2):
>   tcp: derive delack_max with tcp_rto_min helper
>   tcp: add sysctl_tcp_rto_min_us
> 
>  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
>  include/net/netns/ipv4.h               |  1 +
>  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
>  net/ipv4/tcp.c                         |  3 ++-
>  net/ipv4/tcp_ipv4.c                    |  1 +
>  net/ipv4/tcp_output.c                  | 11 ++---------
>  6 files changed, 27 insertions(+), 10 deletions(-)
> 
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

