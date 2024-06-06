Return-Path: <netdev+bounces-101244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20948FDD20
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B213285462
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88158182BD;
	Thu,  6 Jun 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwa9sk9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4921340
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643079; cv=none; b=cCVVTQma0YRYTkrneXFnPD0uy5CYyfwRyYQ15RkXBHmzoYCharUSD2kTyHjaLfajoHWuOAEc1w84RA5A17ml0hwF5jFxTe+fv34cRzhGMJobKkuvoYzHl41RGEaZBDfEV5ayeMKyOxux0n8ZMDHOHkRpoqicRoq74lqELYDovo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643079; c=relaxed/simple;
	bh=ELFcCgD320MKHx4lJSn8D9lhl2ruW1n1pt0TALR8KcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/+NJIfe3ghMx5FkrO2poaNbcjvQ9px2tsMcike6BKdTSg2NuGHZ+RTg491JsI+rjcLuPadNb+K31vu0BtM4PE22tIjv+HW7mEo35JrKxA+bN7/MPxFThJOekm0gPx1JG8gMhmQWq7Trb2w16wJECeqz2wSAd6FdCsdol87zsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwa9sk9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC55CC3277B;
	Thu,  6 Jun 2024 03:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717643079;
	bh=ELFcCgD320MKHx4lJSn8D9lhl2ruW1n1pt0TALR8KcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qwa9sk9lZkkAJ3mzwEO6VLBT0ewisiqghpjQGJZl/FRf8UGWzKczOFWe3GH71riFC
	 m6QiqBAEMh1KsamRFyPN6Ix3Xdjp2ov0JUmyC8VE6domVNhQ6MFW0MmfANiB5ufFs+
	 L06Bfxdra1BhURqNvjPycPwkhSrYplDeA9nvUj++u/pHKaLZXOQs0fkF7RRuUOVjAE
	 n6oKFq4LQgsLS2DlnWnW/NdqewnOM2tS/x4JE+LdOTkaVfAFMILm2teyIHVMvvwcze
	 Cv8QBMPBcJkYFNKO2zmT52hl5UtXmBsySSkGLwbKgpg91TfvZk+b+uK8Jf13OwtA+/
	 CiOgZT/Yp5sRQ==
Date: Wed, 5 Jun 2024 20:04:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 0/3] add flow director for txgbe
Message-ID: <20240605200437.602f6f4e@kernel.org>
In-Reply-To: <20240605020852.24144-1-jiawenwu@trustnetic.com>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 10:08:49 +0800 Jiawen Wu wrote:
> Add flow director support for Wangxun 10Gb NICs.

Some nits:
 - please wrap the code at 80 chars where possible
 - please run ./scripts/kernel-doc -Wall -none $file; and make sure no
   new warnings get added:

drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c:114: warning: No description found for return value of 'txgbe_fdir_add_signature_filter'

