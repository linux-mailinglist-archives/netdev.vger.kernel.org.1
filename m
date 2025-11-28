Return-Path: <netdev+bounces-242489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0256C90A5D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68EA134DC33
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E6263C91;
	Fri, 28 Nov 2025 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEf7Mjnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68739AD24;
	Fri, 28 Nov 2025 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764297825; cv=none; b=sTSkaWop/3YQj8oRkNMoZVYJWVFL5/LR/vg00jUyYp3VsHN7d+hkWJgGo1fVKHa1ILlZNdvoZrrtLJTkedCbx9rhQ/+ZVmJjvrdLQtuABaWGc3TcnhVvUOg6Bgc1/B5S0Jp+ZmQPoiUdofohKffVyyxm/e5UWWE5YE0ppbYKsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764297825; c=relaxed/simple;
	bh=ln9QIdNfBV9vq6z8MK7E/UKuylweqyhRbQa8dmt+i68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuMepZHdwSvyHRWOZIOsgVYqK6eJm87se6ijTBGpt7w8hDjEiHQQDjMtjq6AptJp1ipFOb9KIqHNF1B4r+9/oy7dhVIaW/du6dIaMVGMFV/x2CKJdQENGndXGBhPTRPvdkzZ7e86lqVv0RW/YQIlfZIw+hchCBG4i9KYr6E2kYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEf7Mjnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F053CC4CEF8;
	Fri, 28 Nov 2025 02:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764297824;
	bh=ln9QIdNfBV9vq6z8MK7E/UKuylweqyhRbQa8dmt+i68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fEf7MjndT/YLWqGXG4ZHRR77PH79/DpyYBkXcwZSFmw9KJ6R+wS5QVQIltnFah+m5
	 C/t0kuc0xZFK7dPhabIybUIZS4CDi1m2kyvrfMtP86oDoWV3l8QPl5pFBNeacxg8Bh
	 T9yhk8ccSk4vDv4PNSxpAlDoO+ziROKOb/zCY2+t07p5MtnQVYXDfngP1qWDacPq92
	 d1mU92BAKPz70YZsiQI/oKFIDhSS40F9wbM/IiVcByB1XvgO17FML/XtZElYOXUSmw
	 5+g0y3kFidKxcDCX50i5G7IMGoTJBnCpUaaMF8jWHwMpdgOx3PfSD2mF/6cRFDnrx/
	 hLzg/d5OOM7gw==
Date: Thu, 27 Nov 2025 18:43:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, basharath@couthit.com, afd@ti.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
 mohan@couthit.com
Subject: Re: [PATCH net-next v8 0/3] STP/RSTP SWITCH support for PRU-ICSSM
 Ethernet driver
Message-ID: <20251127184342.5d15c0e6@kernel.org>
In-Reply-To: <20251126163056.2697668-1-parvathi@couthit.com>
References: <20251126163056.2697668-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 21:57:11 +0530 Parvathi Pudi wrote:
> Changes from v7 to v8:
> 
> *) Modified dev_hold/dev_put reference to netdev_hold/netdev_put in patch 2 of the series.
> *) Rebased the series on latest net-next.

The only acceptable reason for reposting within 24h is when a reviewer
/ maintainer explicitly and clearly asks for it. Please (re-)read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h

