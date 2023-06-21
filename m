Return-Path: <netdev+bounces-12834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DF7390FE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25872814DE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968261B905;
	Wed, 21 Jun 2023 20:46:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3131B904
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 20:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7FDC433C8;
	Wed, 21 Jun 2023 20:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687380405;
	bh=O329r5W+FzSIRcXPObaj0b4+ySS/cGO8rsQcgR3StOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LkRCOJhceid4Has1NGR5z8jOosN+Xz9jfZU/DxQHceM232s4YUABb4SeZ0b63eTox
	 Pqa32lhfT+ATfeObgtl59nRZ0HNXYCNA9RBA3k5vPZ3a0qHk5j7PSniLRap6FoKXv/
	 mKq7SV4d0NbMT3wOzulrS06B8SW/PZUn+LDVWENqByz3g5+mjCgJ3FcGJG3J4J/CE0
	 YCmmNeT4Nomp5HGuLVyffQ5ri4JBiHFJAbKGiPJ/8pwdRSzGVUYJSoYGixfdJeQxQL
	 y0DjmzdtDzw+kZ6Ae0GUfu/lPUaK7EDh7zv0rOBd4kWlPqqj2IFt4cTvjey0ipekkk
	 6xjWB9q7Dgzsw==
Date: Wed, 21 Jun 2023 13:46:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, emil.s.tantilov@intel.com,
 jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
 shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com,
 decot@google.com, leon@kernel.org, mst@redhat.com,
 simon.horman@corigine.com, shannon.nelson@amd.com,
 stephen@networkplumber.org
Subject: Re: [PATCH net-next v3 00/15][pull request] Introduce Intel IDPF
 driver
Message-ID: <20230621134644.79ebe113@kernel.org>
In-Reply-To: <03819ef3-8008-43e9-8618-f37f5bc5160b@lunn.ch>
References: <20230616231341.2885622-1-anthony.l.nguyen@intel.com>
	<20230616235651.58b9519c@kernel.org>
	<1bbbf0ca-4f32-ee62-5d49-b53a07e62055@intel.com>
	<20230621122853.08d32b8e@kernel.org>
	<03819ef3-8008-43e9-8618-f37f5bc5160b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 21:44:55 +0200 Andrew Lunn wrote:
> > I think you're asking to be accepted in a Linux-Staging kind of a way?  
> 
> Or maybe real staging, driver/staging ? Add a TODO and GregKH might
> accept it.

Ah, I was half joking, that always backfires.

We merge a driver of this size in every release cycle. Nobody else
needed training wheels to upstream an Ethernet driver for as long
as I remember. It'd be best if Pavan left negotiations on how to get
the driver merged to people with more upstream experience.

