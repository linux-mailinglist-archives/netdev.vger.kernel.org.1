Return-Path: <netdev+bounces-164257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED14A2D269
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154363ACD14
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A3F79CF;
	Sat,  8 Feb 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSXK2vjz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830736FBF
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738976328; cv=none; b=TF/UImCeN36NzM/WTYpOYgxq8N90DyQHW/UgZXhmRI7z97QxDoA+L32xwbx24/aUwPKP+moNvV5Wof/PPUaPbw+T3S2hLNQk7mmA4RQzhTIcNXdpQ4Hm3ktr7RfuMlFvLknaDUqlfIaTpE40S201RxgR8q5CB7zEV7kgkvQIHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738976328; c=relaxed/simple;
	bh=GYf7HwR051ZEhHpJzoUGU4eNggpT3ZZX52etWY2c3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFd8LqQKylhLZK30dJmRNL9lU6F2uqVoq/RBci6S7sdTBgK2a1+cnteT/hcjHDxBo6NhaZvkWVkLEy4ZoHWnjTHtR56t55NMklj9IP2MHhfX5+X+XNl1S9hVV8sxXgBMERR7EsmD3ZqmhVpfhaYuZZN1kw43Mv6BMDOY5WTo3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSXK2vjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA1C4CED1;
	Sat,  8 Feb 2025 00:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738976328;
	bh=GYf7HwR051ZEhHpJzoUGU4eNggpT3ZZX52etWY2c3ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jSXK2vjzINK+2yMhBYMcwGOvswDDQ3mUUGqGFmjxyAtYdXCd0IFo1sEG+91Fe0rD6
	 pDXQjrgLQQobprRT3TAiZ7RhdbYLhNddIFpLV9Lq8cNf+N/iUbb6bnWYtsFy/sgX0H
	 uaP634A2jKaxanfZEUxoRsMgCm1pWr2yp7BmteQ6oKVyyIP5j79W/l06OcUT1Ho/sF
	 JDaUr4iJc/B0UzFQVoHiKrRo0FyYjCegbHimX5OcEZ4UxGQsw2LJbaLT78fjnlp7V4
	 nOzIdWnRWB6GR9TLKLJAG+DFjJoGvPN+mSQdehyEQgl4y2XvLe/1wc57PxsR6A+Se1
	 roJfb7fs9xvqA==
Date: Fri, 7 Feb 2025 16:58:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v6 net-next 0/4] PHC support in ENA driver
Message-ID: <20250207165846.53e52bf7@kernel.org>
In-Reply-To: <20250206141538.549-1-darinzon@amazon.com>
References: <20250206141538.549-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 16:15:34 +0200 David Arinzon wrote:
> This patchset adds the support for PHC (PTP Hardware Clock)
> in the ENA driver. The documentation part of the patchset
> includes additional information, including statistics,
> utilization and invocation examples through the testptp
> utility.

Vadim, Maciek, did you see this? Looks like the device has limitations
on number of gettime calls per sec. Could be a good fit for the work
you are prototyping?

