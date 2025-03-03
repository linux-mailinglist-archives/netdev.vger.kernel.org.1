Return-Path: <netdev+bounces-171234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EDDA4C158
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D8D18899AD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E021147A;
	Mon,  3 Mar 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swyEXDmw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F121128D;
	Mon,  3 Mar 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007390; cv=none; b=FdJQf3C0V6z+/iJwkmai9q0EUpkpGnF1m2ZxTM1etBOl94WxqZl777yR/R9sL5atzBdVh3RVqXu90sVcdjcxdVN6ecQDpRS16lrD0gfWxfhs9yViKbruy4/qD7xjW0m7VSrvugKXVdP0+lWjyzXALv0FFGqta0ijY3O0j3N1Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007390; c=relaxed/simple;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz7JZMWxnvOViyg8wVY04DyIRkeqKZ+oEu4ZRiyHuhsz5XHQAl4r+EPFNofGblR1kzaeuO1bDyHQYI3x3/kvs/Us9qzqx9ZKaSwV8FxRKnWiUukBuq2XVG0R+M+BLWgV2o04O848YMZn6SrWCeruRRF5vxKBVjOHVAwVhkNbQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4727C4CED6;
	Mon,  3 Mar 2025 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007389;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swyEXDmw0R0g7ZRw44ogOiq1HHP3y2FeZWG29C850ReRwgC8lzNdttVBTaHFVe65o
	 zVYLN/A4vGP8u73Ji/YrtcfHWGBO9pVsAXxaZDTIvI6w4WA5owD39ZYG+WPsqvtxtt
	 6rfvzRPiOvRX9p4m3FK9k0hAmJI4VifjelwS3VIi+Qqzx89O2pq8cSMhGEWt4zeX5g
	 /J7PQGlObpo+3VnrZr33tGBzuiHEkzryDdXAGsvjicCP+5GLyi2yw93+6o12fFMSVU
	 ytDYWysry3KgQaYBbbyO5mF0BnaqsPZnYFKudU33iNwWvClH0C+6o57GuX/9dcgFSt
	 U2WifXCRtyomg==
Date: Mon, 3 Mar 2025 13:09:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>,
	MD Danish Anwar <danishanwar@ti.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Subject: Re: [PATCH net-next v3 2/2] net: hsr: Add KUnit test for PRP
Message-ID: <20250303130945.GS1615191@kernel.org>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
 <20250227050923.10241-2-jkarrenpalo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227050923.10241-2-jkarrenpalo@gmail.com>

On Thu, Feb 27, 2025 at 07:09:23AM +0200, Jaakko Karrenpalo wrote:
> Add unit tests for the PRP duplicate detection
> 
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
> ---
> Changes in v2:
> - Changed KUnit tests to compile as built-in only
> Changes in v3:
> - Changed the KUnit tests to compile as a module

Thanks, I see that this addresses Paolo's review of v2
and overall looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


