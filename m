Return-Path: <netdev+bounces-53307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C880233D
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32761C2031C
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83BA9479;
	Sun,  3 Dec 2023 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5lqdJZb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7622F27
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 11:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCE4C433C7;
	Sun,  3 Dec 2023 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701603705;
	bh=XccCxYSOFM8R5fg3IGTtouCQNjtf99QVUi/l5Jh6WSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5lqdJZb4hhVJH0PsnHgitXGQdQJd18XdAvgVByoC9p5AJgHF+enWKjlVh7y2uU7v
	 AZXqOa+wQmtIao804WE0taU2rYoHHTZTjja4tetQYA71XEmxqCb96pMVHI2w5YlsNE
	 R9GPDbmcKEmBQ+MPI946qqEUgHLIQZATzAEHXSG25rsoC2oVbEMIQkJumvxFwGS/H9
	 0N85iI1IRVLc/PbOjbgjKpxGOLOrNrUao4yBRFa8TS2bhDi3wIiWCTUjkvOGbo+6nv
	 CxAPvFYqTwSawtGbs4sajQ4G8a3NpuQqAZm2y/8UARFhFumNyG28rHNPpGJc+TvxJH
	 /5qSMmhNR+68Q==
Date: Sun, 3 Dec 2023 11:41:39 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, mschmidt@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 2/5] i40e: Introduce and use macros for iterating VSIs
 and VEBs
Message-ID: <20231203114139.GG50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-3-ivecera@redhat.com>

On Fri, Nov 24, 2023 at 04:03:40PM +0100, Ivan Vecera wrote:
> Introduce i40e_for_each_vsi() and i40e_for_each_veb() helper
> macros and use them to iterate relevant arrays.
> 
> Replace pattern:
> for (i = 0; i < pf->num_alloc_vsi; i++)
> by:
> i40e_for_each_vsi(pf, i, vsi)
> 
> and pattern:
> for (i = 0; i < I40E_MAX_VEB; i++)
> by
> i40e_for_each_veb(pf, i, veb)
> 
> These macros also check if array item pf->vsi[i] or pf->veb[i]
> are not NULL and skip such items so we can remove redundant
> checks from loop bodies.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


