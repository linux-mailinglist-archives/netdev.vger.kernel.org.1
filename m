Return-Path: <netdev+bounces-29033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480677816DA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787BF1C20EA5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4DA4D;
	Sat, 19 Aug 2023 02:50:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CA807
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AA4C433C8;
	Sat, 19 Aug 2023 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413442;
	bh=zkt9PU/oOgNUJ6FKKoLOe558w9veSeidDWOpQEEZejw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RVMfRv2WT9roy4vPyP+NL7hto2hVfxL5qE9s6kfSVJ+OWLd4hFV8xsCMjCZCpreCZ
	 wdyWuGbG+On54WuiUgv5Q4VXjOOxnMrTWnGaYw0Eljr/H5WDwYdqhOPEB4cwUPSjMS
	 /vhGVw6rbxiyeaTYf/i9OymX4eEuRhUhmYRZL7ejDoIH8En8QH8S/TRR4DZUHTXBp8
	 fhc4quKoDzIc56MoEO9MLxD94MVV6NzWgVHxVndHqSxNh44wDZnNDPmfaSuZa5CkT7
	 kQZSfbHN4RqwPeNOorJkHCLHjBel8qn9+aEcsijsr9kdsKnNyHO7cqdtneY4RfK49B
	 goQyyxuYGgcbw==
Date: Fri, 18 Aug 2023 19:50:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <jerinj@marvell.com>, <lcherian@marvell.com>, <sbhatta@marvell.com>,
 <naveenm@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [net-next Patch 4/5] octeontx2-af: replace generic error codes
Message-ID: <20230818195041.1fd54fb3@kernel.org>
In-Reply-To: <20230817112357.25874-5-hkelam@marvell.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
	<20230817112357.25874-5-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 16:53:56 +0530 Hariprasad Kelam wrote:
> currently, if any netdev is not mapped to the MAC block(cgx/rpm)
> requests MAC feature, AF driver returns a generic error like -EPERM.
> This patch replaces generic error codes with driver-specific error
> codes for better debugging

The custom error codes are not liked upstream, they make much harder
for people who don't work on the driver to refactor it.

If you want debugging isn't it better to add a tracepoint to the
checks?
-- 
pw-bot: cr

