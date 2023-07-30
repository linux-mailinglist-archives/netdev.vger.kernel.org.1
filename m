Return-Path: <netdev+bounces-22636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8B768642
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5C72817D4
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB64DDBF;
	Sun, 30 Jul 2023 15:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969FA3D6C
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 15:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3635EC433C7;
	Sun, 30 Jul 2023 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690731743;
	bh=JR32eOsoska7WehA4yWwRMQ+wOTMGHFvNU7Io4yZsjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gfjo+GHtRvXFjipD0P5HmsTpC4wjW12gGL25nQMiHV0/0XJwQOWywC0Jyy5zBzeLL
	 H74HlyV0MJcnJJzXiEQlkUpjzOLFlktH1gNfG0otHdyxEMDidc/1XBv+2yVLVUdxtN
	 gHVc+EP52TPR8ZIRKlmrMH76IPvnTm8tr46rotni8dfMsgTv3d6iDO4a2D7c/0ONGi
	 f7f0CF0SWJ9KOWGc08eOmhPGFZC7/wO4FaXNNUwllr5QcO6Z3eSkKWZCW5Zn5SDdYM
	 0YTg5M2w70atVm/b+4NeaLl/hUxNvdvE8aGTvFI+C6dpleAc/tzBJ6mTlkeBuJSxHQ
	 ikhBhBGk6803A==
Date: Sun, 30 Jul 2023 17:42:19 +0200
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH v2 net-next 2/5] selftests: openvswitch:
 support key masks
Message-ID: <ZMaE24XVEcs5SBgq@kernel.org>
References: <20230728115940.578658-1-aconole@redhat.com>
 <20230728115940.578658-3-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728115940.578658-3-aconole@redhat.com>

On Fri, Jul 28, 2023 at 07:59:37AM -0400, Aaron Conole wrote:
> From: Adrian Moreno <amorenoz@redhat.com>
> 
> From: Adrian Moreno <amorenoz@redhat.com>
> 
> The default value for the mask actually depends on the value (e.g: if
> the value is non-null, the default is full-mask), so change the convert
> functions to accept the full, possibly masked string and let them figure
> out how to parse the differnt values.

nit: differnt -> different

