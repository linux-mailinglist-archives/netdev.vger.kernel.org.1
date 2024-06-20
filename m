Return-Path: <netdev+bounces-105101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EDB90FA6D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05001F21B1E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6425218E;
	Thu, 20 Jun 2024 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yz7rsXOp"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E34C8D;
	Thu, 20 Jun 2024 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844527; cv=none; b=RNuqGG2zVAeK5R0wKURnot4PT3t186bRcoOUfdYYCHwU+IGdLzJtwG3QlvxgsuefTypVONYmDlEJ/UzjAuyDWYPylw06j0BVsSSvwnx6FSTQU2TcWsc8c5HFCVAiVlmqL3VNS6GKbf/iBZl23fyVOW+voQK+8PfQPRKqbLCnk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844527; c=relaxed/simple;
	bh=b1dUT1Ows2ufG/qsTYygygsaF3u3dF2TRZ3Hv+MJqVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4xT/Um3dfbxgIF0K1AcJxi0JoUM1Go3hyYtIoiNueil+y8BQY2R4x/Uq0jvPNA7TmgHbf/079SpF9/9tc7Pgof07sAON4IvnSQCBkVdBiRTWWi4M6iYYon4+Q3l/3/ueBCZAu1xwXSEp3GzOXrNdNRbSXMeJYmUp/JTMUpIP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yz7rsXOp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ydUCjhWpMR/hIpm7WjDhlhK4uJO+HIYEjI8QbEr2i6M=; b=yz7rsXOpip2/kdpn2bYLXzMwqm
	3QQIPhxybO/XV3wWrS/psHskzOr0YYGaMFaGunFKDDi/aE/STxBQeDSnDr7U6SN3jLqy1aK5yZIYp
	B5XyMkUoyD/gkXjS/D1pcBE70AB4GVTjChKYyuaRKqBHFycsvh9M8v+XxXRmAa+y+f2ka0GI30jcU
	TTdpkmO/YNAjx+a29PPM05oVxvs8R02fL6p0n9IJbLljS+hO5esUUw1PeGHmeTpVafpbJgn15nzB0
	weTCStvZiATlDcZOjER9IeBPIOePJt/Zky/+xdjM+/koin0OYM1t18pFsx46oKDkh550QDqSHRfjt
	IJxnx7Gg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK5yl-00000003B6G-28AR;
	Thu, 20 Jun 2024 00:48:43 +0000
Message-ID: <7dc51532-55b1-4f10-af8f-bf8a703e1874@infradead.org>
Date: Wed, 19 Jun 2024 17:48:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] docs: net: document guidance of implementing
 the SR-IOV NDOs
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 corbet@lwn.net, linux-doc@vger.kernel.org
References: <20240620002741.1029936-1-kuba@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240620002741.1029936-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/19/24 5:27 PM, Jakub Kicinski wrote:
> New drivers were prevented from adding ndo_set_vf_* callbacks
> over the last few years. This was expected to result in broader
> switchdev adoption, but seems to have had little effect.
> 
> Based on recent netdev meeting there is broad support for allowing
> adding those ops.
> 
> There is a problem with the current API supporting a limited number
> of VFs (100+, which is less than some modern HW supports).
> We can try to solve it by adding similar functionality on devlink
> ports, but that'd be another API variation to maintain.
> So a netlink attribute reshuffling is a more likely outcome.
> 
> Document the guidance, make it clear that the API is frozen.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - edits from Randy
> v1: https://lore.kernel.org/all/20240618192818.554646-1-kuba@kernel.org/
> 
> CC: corbet@lwn.net
> CC: rdunlap@infradead.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/index.rst |  1 +
>  Documentation/networking/sriov.rst | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/networking/sriov.rst

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

