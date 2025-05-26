Return-Path: <netdev+bounces-193342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C4AC3943
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4DE189364E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B343E1A0712;
	Mon, 26 May 2025 05:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323CE72615;
	Mon, 26 May 2025 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237607; cv=none; b=Iw2oL6S35rHTtI3K0SzbenSIw1nuXcCQR1jBzAGVLRr9iIzKAcBUKTibHX8olzF1b4/fbDO8TBDYL+cVKEEoWq2b1NCuysG+KRQlAdDGyOOyhjhhMV01J9qD87Bgh6Q6EAsSS/y1fGUsKjJebygbiMnsXd8PqkxVHmSzv2hDBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237607; c=relaxed/simple;
	bh=N17y5RgMY9Y26bM/MiYbgYZBYXhdYO9/ZcqCpTlK8rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3WUTiOCIUWM7SCZSGlkOj3N0kJZVR2WIR6f7VgVmex2GdRAFEsk9lrCDG3kFlySDAH+L4c2hDhiDaVXt/qdXIdeMX2uAbjb/frpRjHCsxRY6TuxCVcd840KaeYH0CClKy2USiHAaWx0TctCCdMLpb2myjQc5GiQq+xxA81ZgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2BEF68AFE; Mon, 26 May 2025 07:33:21 +0200 (CEST)
Date: Mon, 26 May 2025 07:33:21 +0200
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
Subject: Re: [PATCH v2 net-next 5/7] socket: Remove kernel socket
 conversion except for net/rds/.
Message-ID: <20250526053321.GE11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-6-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-6-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 11:21:11AM -0700, Kuniyuki Iwashima wrote:
> Let's drop the conversion and use sock_create_kern() instead.

Please send a patch per subsystem that is converted to make the
commit log better and help with bisectability. 


