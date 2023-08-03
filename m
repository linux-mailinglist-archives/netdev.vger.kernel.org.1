Return-Path: <netdev+bounces-24120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06A76ED80
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BB928226B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49747200CE;
	Thu,  3 Aug 2023 15:04:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD3200CC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9313C433C7;
	Thu,  3 Aug 2023 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691075050;
	bh=QiRaXf3F65WtJzNiwzXsBrsbRQI88q2pid30CNFVANg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1RktGnfaBuL2qTnxctjzQHBLJ9jy361Vsh6PMAgtjhh5buVcadtrwWJo1Ql4Ex1e
	 wBRxRoG2CVLgncqn2fpHji541GGBnuNuISCrRhJiNZBlLXVqw2zFe7qr3TvUXnzP7S
	 B7v5KYGt5ZVVvci7cLtw63OuQ0Izz2GEyXId+1J1LJ8CGKifGAmbUuLs5wdXQOz0dP
	 IhPtSM6otHhD5Gillt7wb8T8EGvFWPtc9cyJt54dWZtsRbfiJP3i3YXQk5PnZBfibw
	 MbptBWm0/o/v2B/UIcf6Hs7blsWfskGttAksIChrV0M8SCoR24B6LpP1w5N30AiTa+
	 piIU8ocYkXgyA==
Date: Thu, 3 Aug 2023 17:04:06 +0200
From: Simon Horman <horms@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net] test/vsock: remove vsock_perf executable on `make
 clean`
Message-ID: <ZMvB5lFhNJC6I6h/@kernel.org>
References: <20230803085454.30897-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803085454.30897-1-sgarzare@redhat.com>

On Thu, Aug 03, 2023 at 10:54:54AM +0200, Stefano Garzarella wrote:
> We forgot to add vsock_perf to the rm command in the `clean`
> target, so now we have a left over after `make clean` in
> tools/testing/vsock.
> 
> Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
> Cc: AVKrasnov@sberdevices.ru
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

