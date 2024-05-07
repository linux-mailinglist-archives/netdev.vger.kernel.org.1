Return-Path: <netdev+bounces-94214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4C8BE9F6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9E1F221A3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA9A54BD3;
	Tue,  7 May 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erY2vLaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09D548F8
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101327; cv=none; b=cD21mUZyhsDOQMzP8vMvPF/wtbQGs8UifEuZ2ALGNXHZeVWYNiU94jfGRDHW5hq+k231bAPLv5hTFZe/VSvnYRl+6D7NOCJoYE3XC6MH1otXkI2G0jN/CJ6nmDXvI3nC5R9z6UuZ1aN7zGvznPWYAreM3Dklmf/T0Nt6DScxq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101327; c=relaxed/simple;
	bh=Go0viVAUOndFNWuoabEoMSfyScRFp+lAXAS0ui1M42U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pX2NwavlBAiK5v+P/h0OWespXdosqkghqLuA54OlpBW0I/XPPQA+Z4HhXZ227DKj+QTx5lOCRrIThNZccajuU1RF+J6wmkgr3NbrGAjclyB5dxEpphRqQZlle1FXAEeNd6FMy6AVjibPcUYmcBJTV/22qA5BcGePVXbMsMOafXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erY2vLaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE68C2BBFC;
	Tue,  7 May 2024 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715101327;
	bh=Go0viVAUOndFNWuoabEoMSfyScRFp+lAXAS0ui1M42U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=erY2vLaGsHqniqzjmPJcQWIbpuMhh2KSpGxcXnaFCQQgllFol02uugsgsSolah+Dx
	 RVj1B1R8sDLKSCy11hdNt2nAHzbY30Q5CEQ945jZ0nUnyj/RkN5nCTiELP7xbET3nI
	 klca+jrhG8RRcMbUyC85Ec22akq98iOFzbtWhSo+bSqjTdEri2SeJtDCNzkgrTTwuy
	 +dWljqKEwnNJHhA+YpeSzVFH1Kea5RX/vkDOmqODHXelkbzREVmJMJFHYvX8gHlA8Z
	 FxdBj2eDVU2Xf9bLXPa3x4AZ6AlnnifPY1rq3RuEv82nYtWYmcYTvEhSzcuGHwcnn4
	 0MGJobvDtuFlA==
Message-ID: <12ab765e-d808-4bbe-a2d3-87a8c5fb8b54@kernel.org>
Date: Tue, 7 May 2024 11:02:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Content-Language: en-US
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Alexander Duyck <alexander.duyck@gmail.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <20240506180632.2bfdc996@kernel.org>
 <1c36d251-0218-4e9d-b6e3-0d477a5e6a02@kernel.org>
 <ZjpdV2l7VckPz-jj@C02YVCJELVCG.dhcp.broadcom.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZjpdV2l7VckPz-jj@C02YVCJELVCG.dhcp.broadcom.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/24 10:56 AM, Andy Gospodarek wrote:
>>
>> That require driver support, no? e.g., There is no way that queue API is
>> going to work with the Enfabrica device without driver support.
> 
> I defintely think that there should be a consumer of the queue API
> before it lands upstream, but if it cannot work without a
> driver/hardware support that seems a bit odd.
> 
> Maybe I've missed it on the list, but do you have something you can
> share about this proposed queue API?
> 

commit 087b24de5c825c53f15a9481b94f757223c20610
Author: Mina Almasry <almasrymina@google.com>
Date:   Wed May 1 23:25:40 2024 +0000

    queue_api: define queue api

    This API enables the net stack to reset the queues used for devmem TCP.


and then gve support for it:

commit c93462b914dbf46b0c0256f7784cc79f7c368e45
Author: Shailend Chand <shailend@google.com>
Date:   Wed May 1 23:25:49 2024 +0000

    gve: Implement queue api

    The new netdev queue api is implemented for gve.

