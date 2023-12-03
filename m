Return-Path: <netdev+bounces-53326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4D8025E6
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA69280D75
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B12168DB;
	Sun,  3 Dec 2023 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZyUG1bj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90E15AC3
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 17:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF0C433C7;
	Sun,  3 Dec 2023 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701623543;
	bh=C594qh/OKVwQZc6TZ7itti5dOI6pBQTMwVSTjIeQZRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZyUG1bjxANaV8iareFw/0h8QtxuYqbMtKZzlPazgvK/OwNe3l0cwj2p6kMUeAh9f
	 hEpioqTsAoinrK4UMCI/MVpTSRy+V9gvJFOUtXAxxBSvgEQEHJ0R4U690LJEZKQye4
	 QfuP2pO56XdsbrdcS5jrMA8t3+YKDIADu3d5IyfFpmTDl3grJSC6/JSuwnRRNyOjqs
	 8eIVoLXAPvEetSUaBJoMzePlstBCm39DBwfiQVSErDPnm2JN1ra04wz5GdViLk8qpP
	 VXqYMJK4i7eXMVhuyc3z6414hrrcyegL5zW03vyDDEv+CTJU+7JzBFSLU2F1/nysuo
	 6coUL5yXDhscg==
Date: Sun, 3 Dec 2023 17:12:18 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
Message-ID: <20231203171218.GN50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-5-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-5-gakula@marvell.com>

On Thu, Nov 30, 2023 at 01:28:17PM +0530, Geetha sowjanya wrote:
> If mcs resources are attached to PF/VF. These resources need
> to be freed on FLR. This patch add missing mcs flr call on PF FLR.
> 
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


