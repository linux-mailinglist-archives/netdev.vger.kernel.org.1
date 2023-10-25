Return-Path: <netdev+bounces-44213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A77D71A9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905C6B21039
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A42E658;
	Wed, 25 Oct 2023 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEfUUOJ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6626E3C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D304C433C7;
	Wed, 25 Oct 2023 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698251117;
	bh=m7No2rfE+Iq89ezChfzYe54dDUPkwPlydza1XqHZYtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jEfUUOJ98OYDwzq7UpMQUtS96abAU5UwZN0a/NPMQ95xGEIw5eAI5sTE4a/xwIJMi
	 Pk9ItYh9K2Z/1Whebt7oWfuZxkkQFmXr5u8mgd823RIGgEhU1EtSqDQVYlChDMGw1/
	 GOiu8TfBUFVgH14RHwwlYmdq6bsohf7wTM3Xz9+rux5iNEO01BHVfpONMuZNL+bMfQ
	 nm49QG1XQsgrZiSqduGzssL3DtFDEEVk5DqaWgLeGvy9c3L5NqsfdhULIh2sAL0Eim
	 ChlleWKL/Hvt3me4xY9WjvO/VX1MPZmUqyvdP9qr8nA9umtpueu5GroIIhGifsq/5c
	 /S/bBsVgqiw6A==
Date: Wed, 25 Oct 2023 09:25:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, David
 Miller <davem@davemloft.net>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 4/9] iavf: in iavf_down, disable queues when
 removing the driver
Message-ID: <20231025092516.3c08dfce@kernel.org>
In-Reply-To: <CADEbmW0qw1L=Q-nb5+Cnuxm=h4RcdRKWx1Q1TgtiZdEaUWmFeg@mail.gmail.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
	<20231023230826.531858-6-jacob.e.keller@intel.com>
	<20231024164234.46e9bb5f@kernel.org>
	<CADEbmW0qw1L=Q-nb5+Cnuxm=h4RcdRKWx1Q1TgtiZdEaUWmFeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 17:24:59 +0200 Michal Schmidt wrote:
> > This looks like a 6.6 regression, why send it for net-next?  
> 
> Hi Jakub,
> At first I thought I had a dependency on the preceding patch in the
> series, but after rethinking and retesting it, it's actually fine to
> put this patch in net.git.
> Can you please do that, or will you require resending?

I'd prefer if Jake could resend just the fix for net, after re-testing
that it indeed works right. I'll make sure that it makes tomorrow's PR
from net, in case the net-next stuff would conflict.

