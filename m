Return-Path: <netdev+bounces-66817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3A840C70
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF141C21B82
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7115698D;
	Mon, 29 Jan 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDNlfGs3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD23155A50;
	Mon, 29 Jan 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547236; cv=none; b=cRjs+JGmogEs4WyZ14B1t8dyoJ3bNO78WJgQRMVIOuYkh8WhK03Mon229UeuwFehqHwthua64Xwhh12eLj5RZcUDSTWf6nHYccSGeaKX5go0BVEfFNqQmyYcUtfcsD6HGCFMCD5B+KnYWKG7y+arjtnjmxGSPupJxR+rfKDg7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547236; c=relaxed/simple;
	bh=Zg4p2X8pso/5Q2jnhHjqcMGLZEqNtvMlUk7th8fO7+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNDNq0d27fj4hpWkj2U3xEJtEYUsfccRe7xIlEb43hv6lMlD0OvPY25KTCHFTV4YaXe+JuyqVKFU5QE6G13Bl06N6P1GftiFHu3AUq/Td0fq9ivlmXfPVwhWjs/ciqcJ/WrUhitsSRy484CGtxi0pcK2vG9qAb/siPgdoeVBegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDNlfGs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE98C433C7;
	Mon, 29 Jan 2024 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547235;
	bh=Zg4p2X8pso/5Q2jnhHjqcMGLZEqNtvMlUk7th8fO7+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WDNlfGs3efcvNr+1nH1qbHDkJF8WsJKbXBeBjETLapo82eIWgelKr38zywLJBM7de
	 wTjsxGkAMRuBuMudQARvh8nNT7GM5d1CpA+Gtr2L3AFDr1a8kdkFrOc7GApwe7/sDC
	 o6+XdoG68aOw6rKhhn+HKDiZ9bhf07+IOOk913BaFvLLUZSeF81+VS9qzHnA/xwnYl
	 VUYn2e55+BWh5GiLxJfLr0Vb+iEIHk4rAtNIUIQYCg5kSCcW4oM350BhEh9Z0jKdbk
	 MLFEs22KdLPJJlZv7EmHEQbpC/iP4TMPDNgBnwTay11m6HtbHUR2NuqLCRkYyVVGSP
	 336mTtQiGSJUA==
Date: Mon, 29 Jan 2024 08:53:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240129085354.49c3c586@kernel.org>
In-Reply-To: <a2df88e6-5ecc-407c-a579-8c8b7b4fbd2b@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	<20240123133925.4b8babdc@kernel.org>
	<256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
	<7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
	<20240124070755.1c8ef2a4@kernel.org>
	<20240124081919.4c79a07e@kernel.org>
	<aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
	<20240124085919.316a48f9@kernel.org>
	<bd985576-cc99-49c5-a2e0-09622fd6027a@kernel.org>
	<c8420e51-691d-4dd9-8b81-0597e7593d07@kernel.org>
	<20240126171346.14647a6f@kernel.org>
	<317aa139-78f8-424b-834a-3730a4c4ad04@kernel.org>
	<ef884f08937fcaab4e4020eb3fca91a938385c75.camel@redhat.com>
	<20240129070304.3f33dcf2@kernel.org>
	<a2df88e6-5ecc-407c-a579-8c8b7b4fbd2b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 08:32:33 -0700 David Ahern wrote:
> >> Could the script validate the 'ping' command WRT the bad behavior/bug
> >> and  eventually skip the related tests?  
> > 
> > Skipping if the package has a bug would be best, if we can figure that
> > out. The latest version is fixed, right? I can build it locally, just
> > like pretty much everything else..  
> 
> yes, that is why Ubuntu 23.10 passes. I downloaded iputils, built ping
> locally at the Amazon release version and did a side by side comparison
> of behavior to verify it is the ping command.

Built iputils from git manually.
Could not figure out how to convince mason not to insert /local/ into
the install dir path so I copied the binaries manually :/ Seems to work,
tho.

