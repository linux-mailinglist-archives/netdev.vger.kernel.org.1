Return-Path: <netdev+bounces-65121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C7839498
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A59B2176D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ECE64A87;
	Tue, 23 Jan 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5ni6bSF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB266351F
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027152; cv=none; b=KUmvWBRqMTkljMtUkg324+igxkX8pIv+NEjD5HGEGFXGb+HFSLwZSzJVZP+k4GZB2STfuemfi6Svdl60mW4s2/oZAexnVan4OlZh4qoKKWuRB+dOhFovldcU3bFk+kFLu1FjF2ZBw+4GDIoRUCH5Azp+XSNMLcgPDCnDCyvywVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027152; c=relaxed/simple;
	bh=Db/jN7Jo2Il34tau7l6TXAThDAYrdAUA/UZhgrIh4Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdFHmXv+0386f4hH5nsqCVoPhXiNvPL4YO6ObX1kVKS64Bk5bHrD0PuU1L79eOxVOHUaaGbC+z/zA3srJunEvF+rD1n7cxNEncaZ3Olb9Os4am/TpcjL7zYJRF+MOg6alkLvyk9aFfwbdsCVSKsKUFur4BUA0WDOxmSSZtGGg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5ni6bSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5435C433C7;
	Tue, 23 Jan 2024 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027152;
	bh=Db/jN7Jo2Il34tau7l6TXAThDAYrdAUA/UZhgrIh4Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5ni6bSFBx5yE0uNeFPBXhRFxOrVjlLBoWxSViJdx0Q7kjcfRuXo+KqDghmh+0av1
	 0iwIXIpDkAdpflGuqVdNNdTbe09dPC1F2rw6Vr5vi3+QTQtQA2eJVUKKhJkddHRy5W
	 HcFEQRZGocc85Gs+nJtkRhJbPRfEpDarpHtfewP4Cpbi5BJSZt8C5INzAVuWR6jAxP
	 YLwp/hHiDFMGmbd2EN+vN8Rs5uoN6vOwNQpG2+itY1y3XxO8QYJ2S5iBeCPD0VHeSf
	 nIaWxoYd1rRaJkKMQOoerdIbC/y1rq+7U/3Wu0O7PB+FpzkAjAeo3CJ/s+z16ZINqK
	 7/lPapy0VGaew==
Date: Tue, 23 Jan 2024 16:25:47 +0000
From: Simon Horman <horms@kernel.org>
To: Alan Brady <alan.brady@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: Re: [PATCH 1/6 iwl-next] idpf: implement virtchnl transaction manager
Message-ID: <20240123162547.GA254773@kernel.org>
References: <20240122211125.840833-1-alan.brady@intel.com>
 <20240122211125.840833-2-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122211125.840833-2-alan.brady@intel.com>

On Mon, Jan 22, 2024 at 01:11:20PM -0800, Alan Brady wrote:
> This starts refactoring how virtchnl messages are handled by adding a
> transaction manager (idpf_vc_xn_manager).
> 
> There are two primary motivations here which are to enable handling of
> multiple messages at once and to make it more robust in general. As it
> is right now, the driver may only have one pending message at a time and
> there's no guarantee that the response we receive was actually intended
> for the message we sent prior.
> 
> This works by utilizing a "cookie" field of the message descriptor. It
> is arbitrary what data we put in the cookie and the response is required
> to have the same cookie the original message was sent with. Then using a
> "transaction" abstraction that uses the completion API to pair responses
> to the message it belongs to.
> 
> The cookie works such that the first half is the index to the
> transaction in our array, and the second half is a "salt" that gets
> incremented every message. This enables quick lookups into the array and
> also ensuring we have the correct message. The salt is necessary because
> after, for example, a message times out and we deem the response was
> lost for some reason, we could theoretically reuse the same index but
> using a different salt ensures that when we do actually get a response
> it's not the old message that timed out previously finally coming in.
> Since the number of transactions allocated is U8_MAX and the salt is 8
> bits, we can never have a conflict because we can't roll over the salt
> without using more transactions than we have available.
> 
> This starts by only converting the VIRTCHNL2_OP_VERSION message to use
> this new transaction API. Follow up patches will convert all virtchnl
> messages to use the API.
> 
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>

...

> +/**
> + * idpf_vc_xn_init - Initialize virtchnl transaction object
> + * @vcxn_mngr: pointer to vc transaction manager struct
> + */
> +static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
> +{
> +	int i;
> +
> +	spin_lock_init(&vcxn_mngr->xn_bm_lock);
> +
> +	for (i = 0; i < ARRAY_SIZE(vcxn_mngr->ring); i++) {
> +		struct idpf_vc_xn *xn = &vcxn_mngr->ring[i];
> +
> +		xn->state = IDPF_VC_XN_IDLE;
> +		xn->idx = i;
> +		idpf_vc_xn_release_bufs(xn);
> +		init_completion(&xn->completed);
> +	}

Hi Alan and Joshua,

I'm slightly surprised to see that
it is safe to initialise xn_bm_lock above,
but it needs to be taken below.

> +
> +	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
> +	bitmap_set(vcxn_mngr->free_xn_bm, 0, IDPF_VC_XN_RING_LEN);
> +	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
> +}

