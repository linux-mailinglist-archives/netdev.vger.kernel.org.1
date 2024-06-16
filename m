Return-Path: <netdev+bounces-103882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F52909F09
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 20:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04A0284810
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A0D1CABF;
	Sun, 16 Jun 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QodMZckG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129978831
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561755; cv=none; b=fFd2T94xg3yBlKf4VWB1t3AIseYDqAnQwv1YRg5xZESo8Z1MzmlUUDNfg8jdk2eY0NIpQ4a9zA/N5gJAWvtykwP85ENK8jPhkqzndF+TDNbQHX9njVTYUGsU39zM1fQ9sVLujIGdvawbqAL9aeY4JDBoA8B89FdSrZ32aCjeSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561755; c=relaxed/simple;
	bh=UeF5mF5Q4CzxohMVEFHleSAPSoYEvzx02C7GHlBFt40=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZzhW8OKLOr/CHosRRc1HdLC30he/cJsDhngW7EQG9z0xOcglOLkeKn94P+kPNp1XYr7JUIvYt39BQ+GaL97VaKcbFFXrx9qfj1RQIVWKL2HlshkTSkf6PANg4dxSqwxt2AUI5jHbJYVryMEarrWoA7hTB6atV0cJi7utF81soe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QodMZckG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AA6C2BBFC;
	Sun, 16 Jun 2024 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718561754;
	bh=UeF5mF5Q4CzxohMVEFHleSAPSoYEvzx02C7GHlBFt40=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QodMZckG5Cf9ZUfk3g75qg214jEKFuy7qX1EIokqe2OBwNXOkZKwS1yg+eYG3mEve
	 4SpMrrbh2u6rFPJfBwgGpkypc82t6NiJCX1BLmvxgv9qVqPwFrqnp7U5XdHPqUbwtw
	 V8lHsO9M8/Mlf8dHRtnVEmVrVS07OGTRlkVeeNnV1p02StMmlEx4cdhT4KHzmfnY6T
	 Ez5rIYNHFaRN5qN/rs8zzTTXywyut7ESwjbuHx/pSyZ7N5d5imoVLMwrcTBzqJZ1Yc
	 cNZU9FVnmR2od7hW1xLJV4I3G38Hu5+/ULX+tSpB0AvUZYdfWCmgES7nH1wIf+HgKo
	 g0UoXkZM9mnzg==
Message-ID: <ea1747c2-896e-4ea0-afb3-a0de3ea53ccc@kernel.org>
Date: Sun, 16 Jun 2024 12:15:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
In-Reply-To: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 1:59 PM, David Ahern wrote:
> Alex Duyck and I are co-chairing the "Driver and H/W APIs Workshop" at
> netdevconf in July.
> 
> The workshop is a forum for discussing issues related to driver
> development and APIs (user and kernel) for configuring, monitoring and
> debugging hardware. Discussion will be open to anyone to present, though
> speakers will need to submit topics ahead of time.
> 
> Suggested topics based on recent netdev threads include
> - devlink - extensions, shortcomings, ...
> - extension to memory pools
> - new APIs for managing queues
> - challenges of netdev / IB co-existence (e.g., driven by AI workloads)
> - fwctl - a proposal for direct firmware access
> 
> 
> Please let us know if you have a topic that you would like to discuss
> along with a time estimate.
> 
> Thanks,

Reminder about this workshop at the upcoming netdevconf. It is scheduled
for Tuesday, July 16, at 10 a.m. PDT. If anyone has topics to discuss,
please let Alex and I know.

Current responses:
- Jiri Pirko / Jacob Keller
  + multi PF device with shared resources

- Amritha Nambiar
  + NAPI config for queue-set API?
  + devlink-extensions

I have a couple of topics - uapis and possibly fwctl.

