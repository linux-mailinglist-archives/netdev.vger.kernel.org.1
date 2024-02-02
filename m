Return-Path: <netdev+bounces-68697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5290D847993
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A581F2C8D0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95515E5B7;
	Fri,  2 Feb 2024 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocLy2aZi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3C15E5AF;
	Fri,  2 Feb 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901770; cv=none; b=d9bpVKdqzXixyJGu8Mkf/dg7MdTP6dXzXiqTA0ah48Yw3THHdBrDi7E7EnPvh8J9ctJvyyul5laT0yO+w4LRm5uLFgwB6wTTWqAWokOZejbW0hu0hu/j8cejq+cTPTVzE1SqPWpwI6teqEV9GQMIreVA1H32ZvubqQ92raO0b+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901770; c=relaxed/simple;
	bh=V3kaQg+NArWG0vA3dsZqjgsHs9QDv1kjIrU7FQWv/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkA5v2IvTmYeYuRWfiYlnda12xwHhsMH4AzLDLk114Y5nnVj7RTNvvNtodknIjcSc7LkBzixAlv3svFBcpGXnEXschwNiTo4jwUtjDHyT+EbXA4Nb9Dd6SLttmZNWtpFEiuSBteo/AJ8tpEaxwRZAlmaZr9SReBVM/KeEMGzu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocLy2aZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C208C433F1;
	Fri,  2 Feb 2024 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901769;
	bh=V3kaQg+NArWG0vA3dsZqjgsHs9QDv1kjIrU7FQWv/vM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ocLy2aZizLLxiVJxS+kDMWHuplT5mq6wVwwMoDmh/IKAks7y/pzwMX0av/n1X/NlO
	 QVNuA4LmdcjRL7rQ6zn+x3hyV4OC1udHZxVSlxhS54v/+x7p2zL3BMUKqp0BO41IZo
	 +ckB/6bQgfDzCo3iivWsouB4kGfJAaRozqulGo4JuHTP/QC5hPF2x2OFl65EZAjCMl
	 anFczYaqr7qnFWtjyrFrzIkffi7zYE4dD2GSpYhN3WNqoMQCsjSsWx75/vruWG6IAS
	 Dum4Hq9JNUQqRqYUrhJXAVDSdyrJT1TdM7/TvLnbayW0XftoVkXunhVPgSJU3WLcXo
	 1m/JlXZEleJIA==
Date: Fri, 2 Feb 2024 11:22:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Persistent problem with handshake unit tests
Message-ID: <20240202112248.7df97993@kernel.org>
In-Reply-To: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 09:21:22 -0800 Guenter Roeck wrote:
> when running handshake kunit tests in qemu, I always get the following
> failure.

Sorry for sidetracking - how do you run kunit to get all the tests?
We run:

	./tools/testing/kunit/kunit.py run --alltests

but more and more I feel like the --alltests is a cruel joke.

