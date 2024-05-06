Return-Path: <netdev+bounces-93852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6739A8BD5F9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988F41C20C7D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0215ADB9;
	Mon,  6 May 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNUE6uIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D1158DA0
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025573; cv=none; b=TtXRRNwZCPU9kvTv6wzfQXOJnflY39R3eehZ81r1WNusoNvf4gzwM8JiIwqPqXOwNLOPNE8voADF4EP7SNjInfQaDTHthWRsUjSQN7xy1rTYAw09ja0ianbnbKXCbEecD78cejkFdp7v3Qh0nVjrSEpDXZ/vlnw9GYDxg+w33xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025573; c=relaxed/simple;
	bh=GVFwxIbewnjlXN1h+VX4swoU2imqR586tQQGnCZaClc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=f28k6ftBuY4s+riIH0BZ17UHvEgUW4mB2BbIpcbqngPfhI8qOFPvc9j1I8pbsX9Ojbax/iwIe3PdysuD6OYCzQ5iMHxCqcywC8U35cO2689w/r9RdbMyETsAvVLOLXlID9W5Nu2cj0DPRFkAAY3Tcoz8jgC/6rW6TfzTtseKOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNUE6uIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A720FC116B1;
	Mon,  6 May 2024 19:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715025573;
	bh=GVFwxIbewnjlXN1h+VX4swoU2imqR586tQQGnCZaClc=;
	h=Date:To:Cc:From:Subject:From;
	b=CNUE6uIML5T7UqJ9af/ZSHlxlWSb5fSCIgqDSqh+XBOgL/IIoFdtg3I9Y3EB2i9Re
	 KvEiQsVoi58E5ReFQ22RYeZwwK7d69Yykuq7rcEGfmcsPgd9pQ0A1pyojfjlObyRj3
	 LS0duH8F7D+tn7tzrqvX9M6jvjpVshftsME6y/aF2YJZbYeuyBoJt6cj6JQxMrBYW+
	 OR862m1QTaKSZ7TQkQ2uhGX7UyTJwHcnF1cRbiptjyb7lEmda30Qqi1Ui68h+HRxLu
	 Kx655715M7wnN3SX3oiGceuvKqqZGtgBhqepUNBWAvQwSz6RTNFINWuSnuWwuMfW3d
	 6alTrHHMLFZCQ==
Message-ID: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
Date: Mon, 6 May 2024 13:59:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
From: David Ahern <dsahern@kernel.org>
Subject: Driver and H/W APIs Workshop at netdevconf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alex Duyck and I are co-chairing the "Driver and H/W APIs Workshop" at
netdevconf in July.

The workshop is a forum for discussing issues related to driver
development and APIs (user and kernel) for configuring, monitoring and
debugging hardware. Discussion will be open to anyone to present, though
speakers will need to submit topics ahead of time.

Suggested topics based on recent netdev threads include
- devlink - extensions, shortcomings, ...
- extension to memory pools
- new APIs for managing queues
- challenges of netdev / IB co-existence (e.g., driven by AI workloads)
- fwctl - a proposal for direct firmware access


Please let us know if you have a topic that you would like to discuss
along with a time estimate.

Thanks,

