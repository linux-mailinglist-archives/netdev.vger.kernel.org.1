Return-Path: <netdev+bounces-93918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A98BD949
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59951C20C52
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B5546A4;
	Tue,  7 May 2024 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehue6E4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FA139F
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047538; cv=none; b=Q419WItnWgqlUGQx2mHsbxJ5tdD5ERVQ0YRpurxSjIVwvxMFh8pSspyOM9tnK/XBs8ZJlAXoOleDvIs2XX1BL3+AOdsJXgfV1gQVgeeOhEv7KmtQgr4LeKYpygGT7Mn44lb7B8oq9p1ILMuI9T/Di9HXYe04jFSue69Ci1n4F2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047538; c=relaxed/simple;
	bh=GNYpfqKrL2CCW6T0OZ3Wv9MtRoiI92O/W/TSYoQJ4tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCNbFJ0vZGELY2QfYEWK04loClvh2M2Ca+DkqeLfOJzm9OI43IFSsn/u4eqht0Aju4fh9gwFhkridBs7aHQ+O6ObYgAFeb8o6H2JOY1VtnxFET7NAevCUwvhSv51iWNq4tY94VMmgGQu6qfd2jCGrpofDVFB0KXO2twibihlmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehue6E4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B4DC116B1;
	Tue,  7 May 2024 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715047537;
	bh=GNYpfqKrL2CCW6T0OZ3Wv9MtRoiI92O/W/TSYoQJ4tw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ehue6E4PXgNpWtI5sc8FjAh44vP8KlszPHa/J6IqpWHDhKZJiZJQNFdZjw+aj00v1
	 QIqmrOMYTgCWvHFQov8ipoysnKjqAQ3PNwW4eryO8f92rLQhYMxZJYe83uMh/fem9K
	 f/sdpMzr5ypViIKoGm1njtQdri8gaBfK7xdogHwOCb4wdfKTw3G3BxG/cy5CVOp11s
	 wdmsNpSuq/eKwAK4dry2qEG0SxHJnvPxkUIZI5Z1F8u+aBghRmFRk8HGwd45TImeje
	 PDGcpC6ajoDyukud3rrVPnv50izrja8+0jpG3Yb5s/t7hVeGbgtBrUNNYvGyKIm2qK
	 mCnrn7j1F8B0g==
Message-ID: <1c36d251-0218-4e9d-b6e3-0d477a5e6a02@kernel.org>
Date: Mon, 6 May 2024 20:05:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Alexander Duyck <alexander.duyck@gmail.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <20240506180632.2bfdc996@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240506180632.2bfdc996@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 7:06 PM, Jakub Kicinski wrote:
> On Mon, 6 May 2024 13:59:31 -0600 David Ahern wrote:
>> Suggested topics based on recent netdev threads include
>> - devlink - extensions, shortcomings, ...
>> - extension to memory pools
>> - new APIs for managing queues
>> - challenges of netdev / IB co-existence (e.g., driven by AI workloads)
>> - fwctl - a proposal for direct firmware access
> 
> Memory pools and queue API are more of stack features.

That require driver support, no? e.g., There is no way that queue API is
going to work with the Enfabrica device without driver support.

The point of the above is a list to motivate discussion based on recent
topics.


> Please leave them out of your fwctl session.

fwctl is a discussion item not tied to anything else; let's not conflat
topics here. That it is even on this list is because you brought netdev
into a discussion that is not netdev related. Given that, let's give it
proper daylight any topic deserves without undue bias and letting it
dominate the bigger picture.

> 
> Aren't people who are actually working on those things submitting
> talks or hosting better scoped discussions? It appears you haven't 
> CCed any of them..

I have no idea. I started with a list of well known driver contacts and
cc'ed netdev with an explicit statement that it is open to all.

