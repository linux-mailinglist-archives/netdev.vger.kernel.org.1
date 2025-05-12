Return-Path: <netdev+bounces-189780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC0AB3ABA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6887AB88C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12C229B23;
	Mon, 12 May 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYd1ZyFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F52288FB;
	Mon, 12 May 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060462; cv=none; b=bzaHSc4aC+T5sYhUA1TVMzqeh//M1z2X+gmXY6hjsfEyxETO2GuCZa0jXsuYuQztMCm2HiUA8M6YwvzPMt/jN2ync/WuR7H4848rXUpIMM78WStrBRci9WK5AtLevd+HsrRmoHiXt1pMxF2+uxOBKSeGfM9hCDTf/N/OoKoODKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060462; c=relaxed/simple;
	bh=VlIFsgYDVXWdTWkNJfheYZRoAUxvYsOa68ZD1Mj4cbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZLG021Todu4gT0Ndp4O8Z4A+RnvJMx8Mp/SSB4T5uEvMddxiJhmCEslumtitXSFwgDIrvZcMuBpRVa60nNU+wjifcqp3n0othXMk6dhoC5Mpw65Vhemc9p7awpVHdju3gJXVwHiMxYGaBcLY34+khcTn1DLcGSHDHy5bjkSHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYd1ZyFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0172C4CEE7;
	Mon, 12 May 2025 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747060462;
	bh=VlIFsgYDVXWdTWkNJfheYZRoAUxvYsOa68ZD1Mj4cbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYd1ZyFHU0tzsxlL6c95Cybu3vh8/CMQlfFAAC7pmbCskaRuQi4WJ/WN5senawLOq
	 bwe+etRNUQctrmdOanCRtwZlbSe3sPow+BXXLolF08rGgicaFrwWOiMo1ddkH1gYFb
	 pFugOoGuqxqnGQj5sqVYDUDgTsJFX7yeWRaa6u0+WL029FFuDY9K+rqFMmaELAqCyN
	 +8CHlvMizgFvEVakuRn2dEqbpldt//UL5vsyTutct86XOoah5BlPhKaN+BgLALkDMk
	 dC/j/ikfxCVTFUv9YYh8NBZLjVJFDYt047/l2SfzmFDLlg1gFioEyc93QVCDmXdKQC
	 UiYQHP1Sqw6Ow==
Date: Mon, 12 May 2025 15:34:16 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/5] eth: fbnic: Add mailbox support for PLDM
 updates
Message-ID: <20250512143416.GN3339421@horms.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-5-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510002851.3247880-5-lee@trager.us>

On Fri, May 09, 2025 at 05:21:16PM -0700, Lee Trager wrote:
> Add three new mailbox messages to support PLDM upgrades:
> 
> * FW_START_UPGRADE - Enables driver to request starting a firmware upgrade
>                      by specifying the component to be upgraded and its
> 		     size.
> * WRITE_CHUNK      - Allows firmware to request driver to send a chunk of
>                      data at the specified offset.
> * FINISH_UPGRADE   - Allows firmware to cancel the upgrade process and
>                      return an error.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


