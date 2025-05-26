Return-Path: <netdev+bounces-193340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8713AC3927
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FE1189352C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EFE13D8A4;
	Mon, 26 May 2025 05:30:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDEA3D76;
	Mon, 26 May 2025 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237420; cv=none; b=UBjviH/2rUI/ypwS4Zqv+LRsiIiUuhuTSZRENXQsacH29o91V7NBCDfaKRViXYRPKmkRXjP+RCvKHwNAl67EdOZ8L+3ZlJjqnJr9vDU5O+EU/A7+y2lnsTKgjl84McDuWeFB4zezOTQoytceuxRTTGx9P1BiupcyVRocwyrKk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237420; c=relaxed/simple;
	bh=ihB9kmsFYOTM4O+AIj/y7KMLQmIWQpp0Qy5KMfBICrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niRVW3lpLiEeWvLfVeErand1VFBeJrdSjP4nPJ45+RvvpKE5eh8VrCu+XxKY0fR+dPMcoIOeF08MPYm4DtR+bTQbAExaEpdfBahrQUmNHR1TsS41p9fhTyFmWSVJpyrZMuudYeG10ieCgfZgsFskCSiY7MUFLjdJYTWC36/zX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35E6F68D0D; Mon, 26 May 2025 07:30:14 +0200 (CEST)
Date: Mon, 26 May 2025 07:30:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250526053013.GC11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-3-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> Let's rename sock_create_kern() to __sock_create_kern() as a special
> API and add a fat documentation.
> 
> The next patch will add sock_create_kern() that holds netns refcnt.

Maybe do this before patch 1 to reduce the churn of just touching a
lot of the same callers again?


