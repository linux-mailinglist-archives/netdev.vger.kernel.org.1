Return-Path: <netdev+bounces-125754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377F96E74C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223F91F24297
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25911CAF;
	Fri,  6 Sep 2024 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSUBsnyl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ADCD2FF
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586300; cv=none; b=OKNfj+4GpN78FuOe9hWngMNSf/JwzRPaGpenW7mNqaFj7AoK32SI+CamA/LYLFhpoNRCWQ99tNPWjYLuojxUI1EZQGsO4zt6/PKFtxGhc8rGC+G7MpbUQSB+b1ttPjZCea/3+mwXgRPtEgJjgc8BuKrSduJ7lI926/4aTedhjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586300; c=relaxed/simple;
	bh=yju+C4yb2LiS4fC9ztggL4ncm8cHMs66T/s8GNoBUKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH0UxEzbU2h3KIBs/ulz8UG9hRJlVI3n76wyz9/BQ6ae9wTsraVHtg9yHSdAy2EcMp57yDp8b0HGIhx2kFzAmra7eMLzuAsPGFV2SUIJdVJ7duDO0k3aV0jMzZgoatCIoKYRswqw1RjjU6OFmdnZTCAje9kjyWqE7IuREwSU8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSUBsnyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E91C4CEC3;
	Fri,  6 Sep 2024 01:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725586300;
	bh=yju+C4yb2LiS4fC9ztggL4ncm8cHMs66T/s8GNoBUKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KSUBsnyl1EK6uUVnruItlWV/YTIKGQxAyPe6aRGsD5Hym33yLxgR5WydKfkKdwuRZ
	 71iom8PL70nkP/GdmK5Cgn+P19OMha3Ng07DPVh8mEqXhacJeIVSNDg5YcjSVV2TyO
	 jCuFl1+KAs7UZKCdV4eVkL0eTXpI/W88+tNSsn1cTY4ql8kccEt3JKFHm0DipeXCUM
	 A+RC/NdfxfCaKjaDEskzzjE0gY9nNbfCOX+6C1X5hqyZQp1fbV2c7vI9YEgP28+dba
	 afMsTY2mBZXHxht0QFPc79vUU99IXbwbbdHH/wKfwO5RG+N78v7HhXdvxJMMD1MTnZ
	 0NKu/feM+Wuxw==
Date: Thu, 5 Sep 2024 18:31:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [PATCH net-next v2 4/4] enic: Report per queue statistics in
 netdev qstats
Message-ID: <20240905183138.308105b2@kernel.org>
In-Reply-To: <20240905010900.24152-5-neescoba@cisco.com>
References: <20240905010900.24152-1-neescoba@cisco.com>
	<20240905010900.24152-5-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 18:09:00 -0700 Nelson Escobar wrote:
> Report per queue wq/rq statistics in netdev qstats.

Nice! Have you had a chance to run the test?

tools/testing/selftests/drivers/net/stats.py

more info:
https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

