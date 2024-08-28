Return-Path: <netdev+bounces-122818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC2962A82
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AB7B2145E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4273718DF8A;
	Wed, 28 Aug 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpwmrNLo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53518786F;
	Wed, 28 Aug 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856057; cv=none; b=qGrw0usb5bkIrq4qMRQddJRAppF8xAdnwqXfKfe5SgQdP1JEi6clvudFIfsz5lCd1RQNdpwwpSLkA+lLh2mBlCiXPTunxjJccEyLBDvdDMt/lM00kM3YqUYG00ZkzJYY/7TUW+e425/gmEsRKrJjNAKkLWfrKmSCJQyM+yGTKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856057; c=relaxed/simple;
	bh=LroqYbYQBPWnOteHCpoIwTjMn1sJcePqcyz2597RPUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+3Z2O7vS7dzYaEin2BB2SkK5WO68LB7VeEwT56NyAsb1TXdVkX87So4iPjco5FL4QxnAv3FSqb5HN+j4D782X7NYP+LBHrF8Zq3KmHqfNkEfM4MUWiANz5ES/2HnWYSaQ69NC/t0Gr237y04ckqBC0tvRKkdvTAO6OJldXKjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpwmrNLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69072C4CACF;
	Wed, 28 Aug 2024 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856057;
	bh=LroqYbYQBPWnOteHCpoIwTjMn1sJcePqcyz2597RPUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpwmrNLo8bo+jXPHdeDqDxtdEDhxvJYSRY1xgj80XdIWYFHXO6NWwbn+SGhOeoMMv
	 j/tWr0lKgVYMS/00Q76khcdq1HOEwTMvgXNWwhsCkVCXRSvplDFC+V3W0YiO8qNG/S
	 3PPFTPOa+rRPuvKBT05xvMXduL077eaIkShjXd47QkPeLvsrYm/DoUSyFlnm5X7+wI
	 d9pjMpUANYNszLW9N9++zNaN+jw/eQ0nb172vCbW9Gpi5TUrCLcAFswOxcCMt4QWhY
	 zPFDT2ecqkURNCHmlKHOcqqspdOR5sFALW3fEF2KtX1yrnsg4urhTnJAQ2eXSCtpo7
	 9RR2XZp4KsSYQ==
Date: Wed, 28 Aug 2024 15:40:53 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5 next] net: vertexcom: mse102x: Use ETH_ZLEN
Message-ID: <20240828144053.GM1368797@kernel.org>
References: <20240827191000.3244-1-wahrenst@gmx.net>
 <20240827191000.3244-6-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827191000.3244-6-wahrenst@gmx.net>

On Tue, Aug 27, 2024 at 09:10:00PM +0200, Stefan Wahren wrote:
> There is already a define for minimum Ethernet frame length without FCS.
> So used this instead of the magic number.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


