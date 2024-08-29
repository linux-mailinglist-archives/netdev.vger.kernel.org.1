Return-Path: <netdev+bounces-123509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E4965200
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE071C23207
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7220518B489;
	Thu, 29 Aug 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg287s15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF251547D1;
	Thu, 29 Aug 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967070; cv=none; b=lhSFHu6WH4aBjUE0kX02VExI6G578o8NsenkN01tW216ERGv948YpdlohQk1SgAyc4KaSjth7V7hGSzHpAlAnWT5Eke8dFpC57upged0pAun2taHibVUxeIjB6lAhob0Nsdrx+vUSJaYZYgAhp2ad7bXcX4OD8AXE20YItWUbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967070; c=relaxed/simple;
	bh=EluZVKvQThmV/RhKCkbZPGWPataMV6xALoZyPVBhUUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEYHgXoAgWnhTvfqUYpr3/2oIQScYdjrq2vqOVL5gBR3S5q0ZvdyPIomYg6RPATHjrsj0I6yowcfwf7WMhDawoZ6L+ivj4Q9qb5Pncru4sd+V8N7yOIXYONWMIc/W3088Wl28yaFUWzV1hmMOXxa7qUnDOVtV2MLfGdnHYT7cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg287s15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4CEC4CEC1;
	Thu, 29 Aug 2024 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724967069;
	bh=EluZVKvQThmV/RhKCkbZPGWPataMV6xALoZyPVBhUUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eg287s15OqFkHZF0wMVvQS5nQ8VAQw/9nh8XGzJ8MNZm+AMcbkf3opcWsqBlw+J/d
	 zZ0SDnBxWFVN19q5uKw4j3hYAXKqnJliaJJiTkQZdp6iwbqyecBK01kGQuQjUojCJp
	 Ws8mZrWfwtJhgUWD964BULzBaiV3b+C3gzvNO6bhD09FAdKK4MPrqfEwgh372RotR2
	 7RuBm0zqbo41P7EtCsACk2el8JNz7k0TDH5bZLSZVcj3GXrAqPCmNUcMdMSJyfZvkx
	 AWU7eaSQetj092XzqIoW4FO8zQ5TqVy8ab2Z3n/J0zdJ/n+Z5Yu6LZeef8CivjeJHC
	 4K8CTsCc/cMRw==
Date: Thu, 29 Aug 2024 14:31:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Wahren
 <stefan.wahren@chargebyte.com>
Subject: Re: [PATCH 0/5 next] net: vertexcom: mse102x: Minor clean-ups
Message-ID: <20240829143108.4a0275fd@kernel.org>
In-Reply-To: <20240827191000.3244-1-wahrenst@gmx.net>
References: <20240827191000.3244-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 21:09:55 +0200 Stefan Wahren wrote:
> This series provides some minor clean-ups for the Vertexcom MSE102x
> driver.

Applied, thanks!

