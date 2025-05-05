Return-Path: <netdev+bounces-187818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29435AA9C0A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F473B2FC9
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58212266584;
	Mon,  5 May 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU+Ejm9e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6C269AFD
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471314; cv=none; b=C+8aIRY05HD/tviTgONbqaO8pDTJxWLI5nFD8cHkEC303USYV69B/BZZJIUyQq8EcddpaXlm+meAP8IMwQB3l5oAOsTLYYAQ9m6cuoj7jQEu/f6GV8KS3s6I2ogqaDc00Kxlw1aZvK2RgVGd0GGLbqRit4vites+7d4cSXqy5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471314; c=relaxed/simple;
	bh=I4HzKEyD1rlq0HzCyLVHIDrrEYqhGPaM/olU2DuiDfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uApxf4SiGtgl00gfRi9rKAcmnE2k7hbb2qJy05MrTsfbk+0ZMAmFZ5kcdg91SCyR6mrocTpiCQO8uUBjC8yuIPcIa0abUlccgt9X2nW0zU/Hfcz0OJf1UfkX3JMV53tjSMXcbpDW5544ofQFSx/W1WLXI4P76HDxD7UwTn7xX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU+Ejm9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41953C4CEE4;
	Mon,  5 May 2025 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471313;
	bh=I4HzKEyD1rlq0HzCyLVHIDrrEYqhGPaM/olU2DuiDfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kU+Ejm9eLL2aYuf1dg44hIaPsJlvbnqpt/+bAUYXuAV8jdZ6H2eN208GxWOkufvbY
	 R4g/Ds/qps+WvAz3y51EIZGbJEBYZJLc3w9n4nrvrGalI9LHFfSLK82PEYc4Ydc5N4
	 JZ9EiI8fQAbl9iKZ3/hrbG6R1iU8y5SYueUeT3XzOD+Yb34KmN8ZkaqSMV0ODvRFt6
	 LivfCUY4zoXDpUmGY8QbiKXlx+3wvep0L5ACzlcIW3PQANnaoxzgUQ3iUxQwDCn7m8
	 VHwGbw9PZKFU1OJNgn21Y9vPR59HIu/ZML0D9goqFWINrAsQr95BjP60SEhikcOcim
	 Ria0mIotZtp7A==
Date: Mon, 5 May 2025 11:55:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250505115512.0fa2e186@kernel.org>
In-Reply-To: <d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
	<20250424162425.1c0b46d1@kernel.org>
	<95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
	<20250428111909.16dd7488@kernel.org>
	<507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
	<20250501173922.6d797778@kernel.org>
	<d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 May 2025 20:46:51 +0300 Mark Bloch wrote:
> On the DPU (ARM), we see representors for each BDF. For simplicity,
> assume each BDF corresponds to a single devlink port. So the ARM would
> expose:
> 
> PF0_HOST0_REP
> UPLINK0_REP
> PF0_HOST1_REP
> UPLINK1_REP
> 
> In devlink terms, we're referring to the c argument in phys_port_name,
> which represents the controller, effectively indicating which host
> the BDF belongs to.
> 
> The problem we're addressing is matching the PF seen on a host to its
> corresponding representor on the DPU. From the ARM side, we know that
> this rep X belongs to pf0 on host y, but we don't which host is which.
> From within each host, you can't tell which host you are, because all
> see their PF as PF0.
> 
> With the proposed feature (along with Jiri's changes), this becomes
> trivial, you just match the function UID and you're done.

Thanks for explaining the setup. Could you please explain the user
scenario now? Perhaps thinking of it as a sequence diagram would
be helpful, but whatever is easiest, just make it concrete.

> As a side note, I believe this feature has merit even beyond this
> specific use case. 

I also had that belief when I implemented something similar for the NFP
long time ago. Jiri didn't like the solution / understand the problem 
at the time. But it turned out not to matter in practice.

