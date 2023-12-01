Return-Path: <netdev+bounces-52818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B058004B9
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D135D281628
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB414F88;
	Fri,  1 Dec 2023 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chnlz0FU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649C5953A;
	Fri,  1 Dec 2023 07:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD78C433C8;
	Fri,  1 Dec 2023 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415703;
	bh=/NE/moAh3fdf/+5E8j12TTLl01THg8y5hZenqpkVy+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chnlz0FUPAbKWmxlXhM0448J00ZCRI+MsdKXiXz7hHMr9PVKSfs2OMTYI1pLAhhLR
	 LUdwbXuRl84pb8zb/rq35oJZBJM9qQzBtqc8P6hFQDReZKzRKHQ4XqYSJXvPckjqIn
	 ck2fo83SqEECXBmX+JL2N6SwT9vw1RYbqq5mStSYV8JwZ6enIaQjL1Ci/CoMeB0t0N
	 +EYyAAxKZbtp7VjtispSEI1obQruvv6YWNObRzV8DvyCFxIOZitrRVjvsVFLYc8p0Y
	 K2AobjAcoC0CYzDjdHpZPBRJ1pHw711zWLt46l7VC/RPeEHVerdKO7GmmMzvnsTMv+
	 Pk1KaAlab5PIQ==
Date: Thu, 30 Nov 2023 23:28:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
 netdev@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Message-ID: <20231130232822.1dee5243@kernel.org>
In-Reply-To: <ZWhksS5C6mcvVPEN@lore-desk>
References: <cover.1701277475.git.lorenzo@kernel.org>
	<8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
	<20231129162832.4b36f96b@kernel.org>
	<ZWhksS5C6mcvVPEN@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 11:32:17 +0100 Lorenzo Bianconi wrote:
> > u8? I guess...  
> 
> here we need just 0 or 1 I would say. Do you suggest create something like an
> enum?

Ah, sorry, thought I must have already complained to you about this 
in the past - netlink aligns everything to 4B. So u8 or u16 or u32
it's all the same size at the message level. For the <u32 types some
bytes are just treated as padding instead of being useful.

But if you explicitly need only 0/1 then it doesn't matter.

