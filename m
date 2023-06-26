Return-Path: <netdev+bounces-14049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E874C73EB2B
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8364280E26
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23713AD3;
	Mon, 26 Jun 2023 19:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF013AC5
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66FFC433C8;
	Mon, 26 Jun 2023 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687807505;
	bh=cDD1qB0KwNErBzlvhgUdes1QzQxQ8D0lxjKAw3s3g8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQTx68U5LYH1cXZNGFAHyNfyEvxgt2/lIqgPR/k9FAn/4puR3n1I0M4Sh0SCTU7/Z
	 K8xdeAIgiEUxZtwUrJH0Xny4cGPB2w8H3Ei/Krq2xLw6YL+8/JemDZ7Cx1IIKrKgHc
	 EYICtRjj2LfjNd8lpfhF6vnErrrhuSV4m2tjRkLpL/toZZ4fTO7xRmGBDxPEWeztvC
	 4WYSN1AUrtl45moqORBOqkLCIcPnGIUzYFo54loZ6B+DF/uH0cYGFkJHKrlMVjX6tH
	 n+aGanNN8XDPizHrZX11WOfwejypQAY7mHCN7NWcaNSXaY7gm5WkiieifXfCxD04XJ
	 bgRh/5dHTvL3A==
Date: Mon, 26 Jun 2023 12:25:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, Xiubo Li
 <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>, Matthew Wilcox
 <willy@infradead.org>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] libceph: Partially revert changes to support
 MSG_SPLICE_PAGES
Message-ID: <20230626122504.064844fb@kernel.org>
In-Reply-To: <CAOi1vP9-5eE6fjJ8rjvMCqGx7y94FHBDi2iNdZQfjPL=pugNWg@mail.gmail.com>
References: <3101881.1687801973@warthog.procyon.org.uk>
	<CAOi1vP9-5eE6fjJ8rjvMCqGx7y94FHBDi2iNdZQfjPL=pugNWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 21:11:49 +0200 Ilya Dryomov wrote:
> This patch appears to be mangled.

In what way?

