Return-Path: <netdev+bounces-38687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939BC7BC236
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA20282096
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E945F47;
	Fri,  6 Oct 2023 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocWR7rKU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7627450D4
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7EDC433C8;
	Fri,  6 Oct 2023 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696631118;
	bh=XBLOBl7PBjoMm67FO0A3a8OPI29qL334wBMnsiJUWZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ocWR7rKUHrsVOT6QphT4ZhMtJwXiwBcJYrfk2va6yizhti3t11SpxMIgztlNVd3PW
	 vFiVcTJ/hqe3gIMyRw9Mw8n1Xo32RRb1eIL793tVbzr6I5Gl84NCWcNIhhziY9au76
	 OUQh9wajirgEgr35rFektSiEYFC3b/L250KMjv02XuYABso3gQpatgaAjWhkgw+BZ9
	 yrlAewcHc2eYPlDFtNuUdMYv5699gLkMGWnKh03c59yKqtyK+vMz7V9lf57QaW1vAh
	 q2eGJnvDzHcEEF8B3NtUIKS2Dyy6mAa4n/2jM87anPYwDA9iRRUo2UrAyyIbkm4g4M
	 YBQ3R33mNz7Yg==
Date: Fri, 6 Oct 2023 15:25:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>,
 xiyou.wangcong@gmail.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, mleitner@redhat.com, vladbu@nvidia.com,
 simon.horman@corigine.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
 kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
Message-ID: <20231006152516.5ff2aeca@kernel.org>
In-Reply-To: <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
References: <20231005184228.467845-1-victor@mojatatu.com>
	<ZSAEp+tr1oXHOy/C@nanopsycho>
	<CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
	<ZSA60cyLDVw13cLi@nanopsycho>
	<CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
> > I don't understand the need for configuration less here. You don't have
> > it for the rest of the actions. Why this is special?  

+1, FWIW

> It is not needed really. Think of an L2 switch - the broadcast action
> is to send to all ports but self.

We do have an implementation of an L2 switch already, what's the use
case which necessitates this new action / functionality?

