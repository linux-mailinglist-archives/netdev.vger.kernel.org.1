Return-Path: <netdev+bounces-33476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12879E14D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F941C20E0D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224F1DA3B;
	Wed, 13 Sep 2023 07:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054441DA3A
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1827C433C8;
	Wed, 13 Sep 2023 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694591905;
	bh=iIe/EVJUjeXRzwCh0/Mp/4IVeq58KNtEj6KHNildhCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEPppJF4o7yTDveQ3wwMBbd+meHaSYMxJGUNhBGss2DTdWJyJsqGFJPiuzlM0P2rp
	 2v/qwfrz2AHcjGmMOOoaNNnNlGtLT6axII4vsx/deE7m+OPCa7lrnLjKCxp4HYmc9z
	 rHg0eAW6bCF+chcYg/KfSO3kVPoRiWovgkVahJbKfCc7+A7+DespEcIunQXYHdDzsW
	 eaG2VypMrf7j1DhJP4r+/whCYrOiDqzy9JYEIJKMMLsuU6J5yLF1auS9bkteutRlsj
	 cMQPicHZUsrCvDdWdPTnTOmajRgNJGTswAfsbL96lRquAMfpqsX7cgiQviftDJ6ssP
	 ctUJC/KivwlFw==
Date: Wed, 13 Sep 2023 09:58:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Teng Wang <wangteng13@nudt.edu.cn>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, edumazet@google.com,
	netdev@vger.kernel.org
Subject: Re: Bug: rcu detected stall in rtc_dev_ioctl
Message-ID: <20230913-oberwasser-zustrom-e17237b2e154@brauner>
References: <5b52187e.3b86.18a8d4953cf.Coremail.wangteng13@nudt.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b52187e.3b86.18a8d4953cf.Coremail.wangteng13@nudt.edu.cn>

On Wed, Sep 13, 2023 at 02:45:07PM +0800, Teng Wang wrote:
> Dear All,This bug was found in linux Kernel v5.14

Familiarize youself with how to report bugs according to our
documentation. This isn't even minimal effort here.

I'll try this nicely once. Continued dumps of similar low-quality bug
reports will elicit a much stronger response.

