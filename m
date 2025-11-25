Return-Path: <netdev+bounces-241370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6DBC8330D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E024E11AF
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08E71DF73C;
	Tue, 25 Nov 2025 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZEfA03V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BF3FFD;
	Tue, 25 Nov 2025 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040347; cv=none; b=s44a1B3QX5nsL7ADqoxzNtlWG7udaOGl7IRiKVSgXjBNohXLROm1S4aw6urLs96/WSPV1a3TLc8LgbY7SVoQo2CI1kCiEpRgKQt23gVmY+X18EEf89XvceyInmqJ112AN031x17DkFjjYSwBtIslhBkWXd/9Z+a6PTOd8lFL0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040347; c=relaxed/simple;
	bh=yKzqdJ+4/fK9kuEbDHAsv8iEDaMKdAL/UJHcDeIY3RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4vJYych4TyUEE4x1D0nZ0fCM0+WzxlwxFc7c4UakMPrQmfpLV0jl64uctFciqA/6H3JfGejuRY798HCju6oYlXcAzRqaSW1Ml2AsNGnJ73Wl4YMLVk/XKxSU/Csekr9Qwky6t1WT/v9GdIMmyHApuSLFRhzQbU5QIwVYoEkc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZEfA03V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA84FC4CEF1;
	Tue, 25 Nov 2025 03:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040347;
	bh=yKzqdJ+4/fK9kuEbDHAsv8iEDaMKdAL/UJHcDeIY3RU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oZEfA03VVjW/xo0HRmSno4oz1byIlle8TbkDCGmsHIZnNZ+POC3f+4nuCZbG6hlSc
	 d9EopX1FlG0I5PFWY0yfOCPFKYBwcRlvuFTOtptifutArzhFqneHyQYWXmt67KP3sq
	 cnTHs4pBrhpc4Nnp/5c/fuCcqQ8VgHvJp4bL7GFGruWr/vrlwaKVWCCGldvwvea0Wg
	 Y5Jd0iw9jdmEJZFo3yA+fNLEjCjijq9aH7HnEwnruELG7d6Io4qOIuf1cdQt35T36t
	 a7vrtMOZQUTy+ivDMGn7DsVqvewbIoeulXM9guGMTZ7ss4AF9ur8FfOd4NKcq6phn6
	 oKjiM0tApJsCA==
Date: Mon, 24 Nov 2025 19:12:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Slark Xiao" <slark_xiao@163.com>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
Message-ID: <20251124191226.5c4efa14@kernel.org>
In-Reply-To: <33bc243d.33c6.19ab8fa1cb4.Coremail.slark_xiao@163.com>
References: <20251120114115.344284-1-slark_xiao@163.com>
	<20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
	<605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
	<CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
	<623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
	<20251124184219.0a34e86e@kernel.org>
	<33bc243d.33c6.19ab8fa1cb4.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 11:06:30 +0800 (CST) Slark Xiao wrote:
> >Are you saying you have to concurrent submissions changing one file?
> >If yes please repost them as a series.  
> One patch of previous series has been applied. 

To the mhi tree?

