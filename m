Return-Path: <netdev+bounces-139118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF49B04A3
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573CA28520F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234E61DD0CC;
	Fri, 25 Oct 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC19/6Oy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39B1DAC90;
	Fri, 25 Oct 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864417; cv=none; b=OuWjZ9GFjX+oB83nOaKmkV/9NGr5R3GPpaPkkZ19Xh1ByI35HsNiu6CWDDo0MEUgwUlDHdj6SMkCjtuVsuNWEJKGnF0+udHIK0pbLHYHZ53PoCz0K3IBkwBjtPndXFTV5RtHoD/wKAlCbblpqh7jhRRWbmDlk7OLEfYfEWDNVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864417; c=relaxed/simple;
	bh=XBk3S6xgZ+z4/lHENN2+khzfrjgwZ6ZfGM+usPbyvoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG25f40sJXWZllwoJOY73rLj7F4RwZ3WmroORrq6TrWgtL3aCG8+ZXF4ghjVYa5R1D0GtPsOBRWlLlSX2dyX0ZvYkg1FGQ2FcAsh8WGnjnJWJsFaAc5IQYpgEQ1ii5V3QfmU+2xZBhks3wc/vtngAtXrCz9SzTm66WP71JNl9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC19/6Oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97078C4CEC3;
	Fri, 25 Oct 2024 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729864416;
	bh=XBk3S6xgZ+z4/lHENN2+khzfrjgwZ6ZfGM+usPbyvoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC19/6OyRAWI2Lz8xJuMUzr2BUCcGLPFCakpjjr/tsQhnmgYh/6ty/eGNpYtpljVY
	 Y8fhEttQnDO0Giz2o5aqc1721rGcr7rBA3k12J9/XSXE2EQ+bEwXuE/WEB0j9qXNtt
	 VzAqY3d/CCFxeXFnpKQ+rY55PlB5y/dtkOcQVO0rHdcLwcvGDm5e6Y7K2rBwHKu0na
	 OnKBI/TddOz9po1G+3QStaPfIjW+qwpf7Dx0Y1nyXh/iZhqd15kz17voU4DX6k+k5n
	 9zclBPhc0n6K0l01DazNWScgC3BOVJn+hEOQQI24PZ21AgK+PdHTMPb263hsck12xn
	 ogxEXD7JvvYDA==
Date: Fri, 25 Oct 2024 14:53:32 +0100
From: Simon Horman <horms@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	guodongtai@kylinos.cn, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH 1/1] netlabel: Add missing comment to struct field
Message-ID: <20241025135332.GY1202098@kernel.org>
References: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
 <20241025070229.1006241-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025070229.1006241-1-dongtai.guo@linux.dev>

On Fri, Oct 25, 2024 at 03:02:29PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> add a comment to doi_remove in struct netlbl_calipso_ops.
> 
> Flagged by ./scripts/kernel-doc -none.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

This revision is looking much nicer than the previous 2.
But I think it would be best to mention that you are
adding a Kernel doc entry, as per my comment on an earlier version:

https://lore.kernel.org/netdev/20241025065441.1001852-1-dongtai.guo@linux.dev/T/#mc951365b9ba02e3538efa0f0eb6a215199efc73b

...

-- 
pw-bot: changes-requested

