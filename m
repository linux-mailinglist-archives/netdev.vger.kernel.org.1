Return-Path: <netdev+bounces-42798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39B7D02C7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19A1280EC3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA933C6A8;
	Thu, 19 Oct 2023 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDlcoXnC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6B2EAFF
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F586C433C7;
	Thu, 19 Oct 2023 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697745069;
	bh=zmKyiXUw03PdyIG0l9m5rnG2yY3mAiEOaPgc0wFDN8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IDlcoXnC+v/L+LqFlXCtOMWMZkI/loh/Gnyl+S3J9VMidgUZG/CS37uRJmKD8NoYE
	 g48Z1Tw7C62vixL1+yVHnnE1elOD0nCR1fvR+9ADIol0+IZwc2H8cqBM+2qH+fwqyS
	 2NOItxcxQ0eTg0sKjOASRJn4TK8/HbZpcPOEv5EKCaKYA5LO4zPIx9KP1EmtrZxr0B
	 L9nWEJp9tFIYRkji2lLxZFyf/juFWX/xnFxhIIUUyWtW8V3yFFKQNB6ZUrD2Gm3AV6
	 ZkW5/xtlxni/+13DEBSBn42KYDVPxQhttsPFXV9znlJmwMRPxi3mKQ5wLS58yX0o61
	 H3WqF17ua9ifw==
Date: Thu, 19 Oct 2023 12:51:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "egallen@redhat.com" <egallen@redhat.com>, Haseeb
 Gani <hgani@marvell.com>, "mschmidt@redhat.com" <mschmidt@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Sathesh B Edara
 <sedara@marvell.com>, Veerasenareddy Burru <vburru@marvell.com>, Vimlesh
 Kumar <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net-next PATCH v3] octeon_ep: pack hardware
 structure
Message-ID: <20231019125107.5acd7c1e@kernel.org>
In-Reply-To: <PH0PR18MB4734672BE30C49F09E2C7D65C7D4A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231016092051.2306831-1-srasheed@marvell.com>
	<20231018170605.392efc0d@kernel.org>
	<PH0PR18MB4734672BE30C49F09E2C7D65C7D4A@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 18:46:09 +0000 Shinas Rasheed wrote:
> Since these structures represent how hardware expects data, there can
> be a lack of alignment.

Doesn't the host allocate at least most of those?
Therefore controlling the alignment?

> I'm afraid static asserting all the hardware data structures might
> force some compilers to fail?

C has structure packing rules which mean that in 99.9999% of the cases
none of your structs need explicit packing. For the 0.0001% of arches
breaking build is fine.

At least that's my guess, again, I wasn't the one who rejected the
patch. I just noticed it was dropped in patchwork and made a guess
based on past experience.

