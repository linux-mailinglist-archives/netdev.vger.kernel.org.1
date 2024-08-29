Return-Path: <netdev+bounces-123493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965996514C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C0F1C24382
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9BB18C004;
	Thu, 29 Aug 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LodG1Mv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59318B46D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964740; cv=none; b=n+GlBzYOO24RtmpQg1JFs24oThopyxGwDflT+0vBUKZvWXVLs71Jc4ndC+ees0isuYhWbmaCw5G1+GMdecZWXzisWIUosOJT/dQNIC7Qk1wewhVNn+nny0QTN+xyh+UCULjAXCZIxvraa6T3YcuiBfhzxkiz+NM5QdP9jOicItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964740; c=relaxed/simple;
	bh=CZgmP2vHL7CyU54Sd3tLAqg6Is4OTiS5iTG4A1Yfy9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK/NJ3+D7HoY7FBa64xYcchV4XSazgez+O3AGuaAW9KokPBc2yOphqoUjyQf8jr+Mkzouvt2tBqFK7THuYksHaS5j7iiT7v19Skk8H6eXLQOoudBXcul2Ba2u4FIEYz+AdoZHaULsacnOox7FcEuR/xLAJ/r03A6hCczVqEf14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LodG1Mv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A69DC4CEC1;
	Thu, 29 Aug 2024 20:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724964740;
	bh=CZgmP2vHL7CyU54Sd3tLAqg6Is4OTiS5iTG4A1Yfy9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LodG1Mv6z/cyCDkb/QAxsJajE102YXxfVeC+HHEcMuSQR72SOk9DdmWyV8w2lLhlE
	 CrRrJaz7CjhGneAvO3+7KPm/OkCLqs1MbS0HbM2gSrVJ/LKPrpPAcP6xGFzE4JAP4k
	 JUMLpYZTT455qGgfemIJxntVuSIDPygZ3L87HD18dTNX7x4Jfpxlq5uVEBU4T1ETo9
	 RCSeDbk7aDCXIV2FidY4QOvExShgWO2mksp0bFW/xDVsHHlsPXxCyAXhF0xOlcxaMc
	 GGcuNsw/hk2U/s6eLBttnfOiV54xrVmo7TZVHV/Dxlh9iuCXyKx5m234EAwmYVFKt6
	 SmYanM40FE1nw==
Date: Thu, 29 Aug 2024 21:52:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@fomichev.me,
	martin.lau@kernel.org, ast@kernel.org, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: error check scanf() in a sample
Message-ID: <20240829205215.GB1368797@kernel.org>
References: <20240828173609.2951335-1-kuba@kernel.org>
 <20240828180246.GA2671728@kernel.org>
 <20240829124315.0d765696@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829124315.0d765696@kernel.org>

On Thu, Aug 29, 2024 at 12:43:15PM -0700, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 19:02:46 +0100 Simon Horman wrote:
> > I was able to reproduce the problem on Ubuntu 22.04,
> > although not on Fedora 40 or Debian Trixie.
> 
> Thanks for the info! Made me pause and consider putting the fix
> in net, but it's just a warning..

Yes, it made me pause about sending my version of the patch.
But I think it is worth fixing.

