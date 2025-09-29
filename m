Return-Path: <netdev+bounces-227216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7797BAA608
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992721C5C1D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563EE20C488;
	Mon, 29 Sep 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8TMh1Zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F43944F
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759171576; cv=none; b=mXXNFZdtcGtIsgjza9UT5FOCL1i0cRdKVyknZ7HxY6yOMEhA4ktjLGwD1zVs0c3qMn2ASsjXEv6jus+t0D6PbgFS6jLSZtayVZhaegELkwPMhUl3DNHHbufboPSG746tVo3XIr/5lj3bRLlCSNEm0coftx4sV933C6wN9Kp45Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759171576; c=relaxed/simple;
	bh=TeA/txrH4AIl9SQMBNmyifcrAmpFI146mMVpAp5vZIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fY9g9TD2OIdgNNWrYzy03X38uVplkjH0TS7nSurtjnUpm+PoMshvdbOMHrJH5lJZF83o0kKdDMvBMYoSPk/eVNloeKoRiWokW8PnzoL2VcR6C1xuAuL5Uv4kk8LOBzCH6C7cx9iRksjGLzpTwkPEWkGgpJBdF5ryZ8ZKpglHJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8TMh1Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CC4C4CEF5;
	Mon, 29 Sep 2025 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759171573;
	bh=TeA/txrH4AIl9SQMBNmyifcrAmpFI146mMVpAp5vZIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b8TMh1ZhFAU5Uphqo/ypyT/1GYqw+j4NH+QUFN1qYb/p+je83WuWy6cy+RqXtmg/1
	 Lnu+jtyO3LqdM2MuhRGrq6JrpP3gKGj4Sw+fwlkrPUWXal4ZTx/fBmf/d3FcaOSTcY
	 p6eD7Lo7bkgHYb2mjMA6z9LnQNUmmnzsf3rx7nOLxZNTFRa88Znh/gtc5hY5+1GG9x
	 WqJ2OP5tJtd2TzYpqbxey3htuZPhOH3v3Y9Xhki2w68SW5WaDNJ6gOlsPJzCUB6DDv
	 XUs3cF9P+Ibc/PstR0FAx0QMFB4LbXBzM6+oOzk4yV55QK4LwaxoyKTR5nCD2gcxPf
	 Ib/qhUY2HIAbQ==
Date: Mon, 29 Sep 2025 11:46:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
 saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
 corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v4 0/5] bnxt_fwctl: fwctl for Broadcom
 Netxtreme devices
Message-ID: <20250929114611.4dc6f2c2@kernel.org>
In-Reply-To: <CALs4sv0T=AL354Mj2UCQGwaqWAznjDoaPQX=7zLsXz9=WxAiGQ@mail.gmail.com>
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
	<CALs4sv0T=AL354Mj2UCQGwaqWAznjDoaPQX=7zLsXz9=WxAiGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 12:05:36 +0530 Pavan Chebbi wrote:
> Dear maintainers, my not-yet-reviewed v4 series is moved to 'Changes Requested'.
> I am not sure if I missed anything. Can you pls help me know!

There is 

drivers/fwctl/bnxt/main.c:303:14-21: WARNING opportunity for memdup_user

somewhere in the series.

Please note that net-next is closed.

