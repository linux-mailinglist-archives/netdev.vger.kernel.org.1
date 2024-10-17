Return-Path: <netdev+bounces-136735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8720D9A2C43
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A21C1F21200
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8318BC28;
	Thu, 17 Oct 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvZ3a4xE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11182188731
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190209; cv=none; b=WQ7YLuOVD85KzEdHD3inTKqcLAQvE5X8sRJU4OPjcZ/wfmU2Q+xDqcpYsahfRKcfMwKOPjq8RBsXZWiMvgMQa2njgBOqSQjRnJGTnSlvrqNT/KxJahlk6TkOTuq20Jvx8J5jgJ3d340kWMOEZzv0YvrVJeqJzxfcDEK3W7wqbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190209; c=relaxed/simple;
	bh=CnZOBThXjx5SD28J11hFNtXSWTTAjhOtDnYRBQFfw30=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N+pB0tkgF40TLI0kT4fL5WubJ1SfxNjlQPTlNnK9vMgZi8/30y+joGqBPrP+UVGqXR9/mpK+VUZd8elApAAG0BbKW80LmQg8f9xaHY8fP4wXsqCnZxqq8oAOuAe+q/k6ONe5+nBesH65IDM5hxk4SFvZflx31Mbwq4Rc5VPMVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvZ3a4xE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B117C4CEC3;
	Thu, 17 Oct 2024 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729190208;
	bh=CnZOBThXjx5SD28J11hFNtXSWTTAjhOtDnYRBQFfw30=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hvZ3a4xEtRIDIuQwpedVeYiXUJWw51NFss/2j3wDVI8t6e0I2iWimdpYFWAOdr1JL
	 R5WvPWPLzwjEGwgGbLEUVGOeonV/ra3s3oWHLsaa48CTx/v0s8lF+JV4dTbv6QHZiC
	 /2XvdzDoQJxWpHAfqvxrE0dZVCEASq0kSJ7Nd3MaaDcvAkEOSlKFbAkaGV7CIbsI/L
	 Th6RArJhgHyqaUDV9CUeGS56dqnQTDC9IsfNIJy2u+7+SrJ5CB+qgWlJXnrXsEsw7W
	 6620c4HQx0h044V7aWEIiAfBdiJOBhr+HWUGIrOtYegj6AHy/AvN0OYkXrqscfVS/l
	 N2kuuzeQ11Frw==
Message-ID: <61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
Date: Thu, 17 Oct 2024 12:36:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: yaml gen NL families support in iproute2?
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 11:41 AM, Paolo Abeni wrote:
> Hi all,
> 
> please allow me to [re?]start this conversation.
> 
> I think it would be very useful to bring yaml gennl families support in
> iproute2, so that end-users/admins could consolidated
> administration/setup in a single tool - as opposed to current status
> where something is only doable with iproute2 and something with the
> yml-cli tool bundled in the kernel sources.
> 
> Code wise it could be implemented extending a bit the auto-generated
> code generation to provide even text/argument to NL parsing, so that the
> iproute-specific glue (and maintenance effort) could be minimal.
> 
> WDYT?
> 

I would like to see the yaml files integrated into iproute2, but I have
not had time to look into doing it.

I have been using the cli.py tool a lot in the past few months and I
have it klunky and hard to use - especially around valid options for get
and dump requests.

Coping yaml files into iproute2 is the trivial part; we already do that
for uapi header files. The harder part is properly integrating the
commands into the package. To me requirements are along the lines of:
- aligning with iproute2 style of commands,
- a man page per command,
- proper help options to guide users

The last 2 should include attributes that can be added to get and dump
requests.


