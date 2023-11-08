Return-Path: <netdev+bounces-46650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B827E5998
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF062812E8
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24762FE39;
	Wed,  8 Nov 2023 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnAKGzXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA02FE36
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 14:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2715C433C7;
	Wed,  8 Nov 2023 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699455515;
	bh=QDjFCmHH6h+K9Er2ddj4qLmCjeHwGVRBq9EZ/5oimXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SnAKGzXDvtnJ4ZWT+2mPNjlDEpKunMDjWYVWGVwdfKFZA2nAl3qTQwEXB4+g80W+Q
	 hUovz9t9cRKokw6DS6l2JZsiQkB27QXGPWTfq+hu85EGh/twT4AzJjLJY0F5gkl5Bq
	 GE9lJvIuY6trGqCdAUbLm11y6u4LBZosK/wnquzMRctQ3UpDdrouOdI9B7uM//Cn/3
	 pv/cF+ZuX5WVxr0wyWfDB03P0hOle1qc+dznQZXo528O6WzZ2+HWFBSIgxMe3HmxJB
	 2kO5Meu/1ZyF0inBTuke86krTMRf7PP6wjKfPjoTUlN5Sxwybb8G/aJneaYYcwXtST
	 jOlB1UPMF8D3A==
Date: Wed, 8 Nov 2023 06:58:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1] net/smc: avoid data corruption caused by decline
Message-ID: <20231108065833.3d6ec1c6@kernel.org>
In-Reply-To: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
References: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Nov 2023 17:48:29 +0800 D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We found a data corruption issue during testing of SMC-R on Redis
> applications.

Please make sure you CC all relevant people pointed out
by get_maintainers. Make sure you run get_maintainers
on the generated patch, not just on file paths.

You seem to have missed the following people:
 pabeni@redhat.com
 guwen@linux.alibaba.com
 tonylu@linux.alibaba.com
 edumazet@google.com 
-- 
pw-bot: cr
pv-bot: cc

