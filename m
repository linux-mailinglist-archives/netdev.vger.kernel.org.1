Return-Path: <netdev+bounces-109683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF019298C8
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC822823BD
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192143611B;
	Sun,  7 Jul 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GknRDJL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F518E28;
	Sun,  7 Jul 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368973; cv=none; b=Cxz7rLDyyxB4maVWENibWvYMQd/pSWMvj1UnJMpX03gSyf4ospQORdQclNfvT3bAFESntZCyDJ7xIlSefq4IHITOtYDcrFq1Aj2EQTZGVG6AAsS237+AG6jUavhsxNmO0LGEBEG+HdKbV0/qKzCzfLDT6T+fphDEVHxVrrhCtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368973; c=relaxed/simple;
	bh=aA7uaVzlUG8Es5n7DDdXmzvi98lEyCK+vZrQB5OXVLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xv2DXwDU0fuXTd4FBCznu4KNMOkl1Ai8lHXAJF4OXBs+c+nBB7B2EfvCc0Ldx++akaNx04BIIBcXX3wyAd/LjTmRFzyPY5fWblQ0mCw726/qZ8ORbUcIaILd09ahtKvXVyQFEZe3F5e/WCi/ZMuFJbLL3l7itHUFfbMW5jxB59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GknRDJL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037FFC3277B;
	Sun,  7 Jul 2024 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720368972;
	bh=aA7uaVzlUG8Es5n7DDdXmzvi98lEyCK+vZrQB5OXVLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GknRDJL2+hHKP7Ic5uIA6BP906pcdNzabg7xdEV60em1p2IFkDYi/MyJ9anDshecm
	 +zWMUjIdrCBSAcRRH9P8Ynam8dfbvPCT6mUNuV0g0K23eg1SQV8HejQqkMrwa7ISvR
	 stlovuPa0vjCbLvOcHCKO6xhXTyRWipN/XEHROWr9XCH3Wy14rj4rz11kBL5ZMcUhj
	 r5toQXkwuu1LUefLJ8ceiXhtWwq8DBWiM3Ggy6wPw+M5Hc4TR7AOexvm/NUfGbkp/D
	 Ym6HaoWGUKSdulLuKGvYzs6ntdgwTQsW4XwzebUzVWLLH3j7msddcrzYEdOD8b5XKk
	 A3x+dpKo80xXg==
Message-ID: <c83bb901-686e-4507-b4b1-020ae86d2381@kernel.org>
Date: Sun, 7 Jul 2024 10:16:11 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com,
 Tobias Waldekranz <tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
 <172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
 <d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
 <20240705204915.1e9333ae@hermes.local>
 <547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
 <20240706125616.690e7b98@hermes.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240706125616.690e7b98@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/24 1:56 PM, Stephen Hemminger wrote:
> The original point was to have kernel -next and iproute2 -next branches
> and have support arrive at same time on both sides. The problem is when
> developers get behind, and the iproute2 patches arrive after the kernel cycle
> and then would end up get delayed another 3 to 4 months.

Then the userspace patches should be sent when the kernel patches are
merged. Period. no excuses. Any delay is on the developer.

> 
> Example:
> 	If mst had been submitted during 6.9 -next open window, then
> 	it would have arrived in iproute2 when -next was merged in May 2024 and
> 	would get released concurrently with 6.10 (July 2024).
> 	When MST was submitted later, if it goes through -next, then it would
> 	get merged to main in August 2024 and released concurrently with 6.11
> 	in October. By merging to main, it will be in July.

Same exact problem with netkit and I told Daniel no. We have a
development policy for new features; it must apply across the board to
all of them.

> 
> I understand your concern, and probably better not to have done it.

You applied patches for a new feature just a week or two before release.
It is just wrong. It would be best to either back up the branch or
revert them.

> The problem with accepting things early is the review process gets
> truncated, and new features often have lots of feedback.
> 

I see no problem here; that is normal development work.

