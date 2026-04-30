Return-Path: <netdev+bounces-282954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBeOGyKL82md4wEAu9opvQ
	(envelope-from <netdev+bounces-282954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:02:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF644A6288
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3B2303130D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516E36495B;
	Thu, 30 Apr 2026 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxbSnqUV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BB2E11C7;
	Thu, 30 Apr 2026 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568317; cv=none; b=OdZCrriECtV7xyVdH2t1xX27UgJijhvZhMpiWxfT8ZCmoQplcDIQ8FqzxhdV1TbDFHMSNe5BqjkVOiJ+NJWBvyjRAlLMz2YH9P9j2n00hd5FUsn4xVCUkvJjeKALrEYyLm7QdHRtSluFPLdDV8uZ8Whkxfs/+faWCtoYKzx9aNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568317; c=relaxed/simple;
	bh=oNHjGy1r4xF2BdPh7vABQlnmsczhl5WvYkdeW6mbptU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uios6FFjfMoEH4BOupcj6lkfNsWHtmef4zX0aFKaeV2fw0sNpR8ACpHKap7SdXz/31b4eZOod7s9cG+TV5zxfVdShhwajtDanFT3cEaxeE9tm3cMpT7Q98Rr83EN+DVphjaiqMlzes6SJxKSy0+zHMwe6SzXY6HbmfFmeRoOKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxbSnqUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54969C2BCB3;
	Thu, 30 Apr 2026 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777568317;
	bh=oNHjGy1r4xF2BdPh7vABQlnmsczhl5WvYkdeW6mbptU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxbSnqUVc7GhmciR0Mv21C2vykFgEax/IgQBMTl2neLs+v01uqHDCF4Y1xTAV100Z
	 d5/LUx6zBcMOc7gPV/3Ykt/7mKV9S9YFf00aMfTyHt0OQy41/7ktk+Fam7xrCoPNun
	 /ZtPkc4fCUHrTFoq0tOw9IMO5v/5bSJSuYXk0ZmgkNdbiF+Ax42ektWHkyyi3PnGFD
	 ClYjoce+BUtZ6JhDoogz1cCLCiuTyakB2LGhFIaIoTs9lAlP9URI+MRzT5HbPUUY5N
	 B96RHeDAFhHyvRizPG9CAFmiUUZGPmmYgsmL4bqdUVZ7+s/EVp2G8jodOxyTc5LZ/C
	 mkshd0Pn4rGsQ==
Date: Thu, 30 Apr 2026 17:58:31 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Alice Michael <alice.michael@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-net] idpf: fix RSS LUT memcpy size
Message-ID: <20260430165831.GD900403@horms.kernel.org>
References: <20260429074232.180528-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429074232.180528-1-larysa.zaremba@intel.com>
X-Rspamd-Queue-Id: 1CF644A6288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-282954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[aleksandr.loktionov.intel.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]

On Wed, Apr 29, 2026 at 09:42:30AM +0200, Larysa Zaremba wrote:
> Based on the following feedback from Sashiko (received for iXD phase 1
> patchset, but valid for the net tree):
> 
>  "Is the bounds check xn_params.recv_mem.iov_len < lut_buf_size sufficient?
>   Since lut_buf_size only represents the size of the array elements, should
>   this check instead verify that the payload is at least
>   sizeof(struct virtchnl2_rss_lut) + lut_buf_size?
> 
>   [...]
> 
>   Does memcpy copy the correct amount of data here? rss_lut_size stores the
>   number of 32-bit entries, not the size in bytes. Should it use
>   lut_buf_size or rss_data->rss_lut_size * sizeof(u32) instead?"
> 
> After inspecting the code, it was concluded that RSS memcpy size is in fact
> 4 times smaller than it has to be, since a single array entry in a u32, and
> rss_data->rss_lut_size is clearly used as an array size. Required Rx buffer
> size is also too small, but this is a common issue in the idpf code.
> 
> Use a full buffer size (lut_buf_size) instead of the array length
> (rss_data->rss_lut_size) when doing memcpy of RSS lookup table.
> While at it, increase required Rx buffer size to a whole flex-array
> containing structure instead of just the array.
> 
> Link: https://sashiko.dev/#/patchset/20260323174052.5355-1-larysa.zaremba%40intel.com?part=8
> Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI generated review of this patch available on sashiko.dev.
It seems to me that the issues raised there do warrant further investigation.
But that they are pre-existing problems that and don't need to
block progress of this patch.


