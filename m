Return-Path: <netdev+bounces-116871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F894BE8E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D1B1F23E81
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C11418CBE3;
	Thu,  8 Aug 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8CKfZTK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D3EADA;
	Thu,  8 Aug 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123899; cv=none; b=pRvny1OM2mqwIBJykHY2lzUnb5A814Gd5vlY2SU4yB7Ygfbe5+95JKZv3HP9p0lqfsgHARRBDeQooenIHx7htSrnG+woOAW7NSoOrYJbcbh+ADuU0vh35SpETOJ98VNTRfbsvDVEvFUi72rzWjPCKKrYs0GiaA/zFHcGid8FU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123899; c=relaxed/simple;
	bh=MTORAOFceoQ2MYt5Z2kuRm/1RLgpHkS7KNInhvKlds4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kw81+K1X58Sbgq6JES4LsUtuzETVLzg7HX72gKzfT7ZjaI5kTOjCqV2GVqa1ROIFQHl7Yi9Ed+wfcqdhQZXhX9O/DmPBstH+M8e6HoYxL4HYhkO4QAIMrXSRbehVnBhdfg8qopsRsCHcmf6PQW0UTPGgEBu7tciwl3GjmMRe3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8CKfZTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A13C32782;
	Thu,  8 Aug 2024 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723123898;
	bh=MTORAOFceoQ2MYt5Z2kuRm/1RLgpHkS7KNInhvKlds4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8CKfZTKudC3lypC1fHfHnKex/7dGzvrII/w2cLL2Ly4s+94Nf5EC9qkzUC1JrfrI
	 PnrMEDE4/suyeM3WMO5LK3nmpdUV07sjKo38gG9G1tM4ZfK7USi/tNI+gK/5bsI662
	 4Xns3Zte8zFJJR1qOaP8VeR+Glv47+OV0cxGFucT/6TM52cgx+w7A5QpKE6Ktoh5f8
	 wdZ7V0dZ8XTU90if6CsU1ilpcpXU59c+jwuYjBnntMYlKT1TGv9QgpHfIEpeCGLu/j
	 ZfBrshu9cTEK7sMAfJumm7d19ZqKyEywOd1MqYB/JwKEmv5MmEvaLSXeRQH8NBiPIM
	 LB+7U7UXMpEoQ==
Date: Thu, 8 Aug 2024 06:31:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v4 1/2] selftests: net: Create veth pair for testing in
 networkless kernel
Message-ID: <20240808063137.73427d0f@kernel.org>
In-Reply-To: <20240808122847.25721-1-jain.abhinav177@gmail.com>
References: <20240807182834.25b8df00@kernel.org>
	<20240808122847.25721-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 12:28:47 +0000 Abhinav Jain wrote:
> On Wed, 7 Aug 2024 18:28:34 -0700 Jakub Kicinski wrote:
> > That's not the right syntax..  
> 
> Thanks for the feedback Jakub. I have rectified this and while at it,
> I tested using vng on a network based kernel and found another issue in
> veth removal logic. I have fixed that as well.
> 
> Please kindly check the v5 series here

I'll take a look, but please try to follow the guidance in our process
doc: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

