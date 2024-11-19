Return-Path: <netdev+bounces-146324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990D9D2E4B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9F4B2822E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148A1D0F63;
	Tue, 19 Nov 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOXnuZhV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9ED1CEAAA
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039708; cv=none; b=HWuQsHDEoBZ2hhbh2CY09w09lsgGTkwRD7McBW2V5Xfnn3f3lRJsAzSzefC6zdVP+UgHAf55s/kB6PrB4cR6UbbF0R5qOLCmegqxUobny+AWgHxWeE7hxvQVzErAzXPegPPeLX6wu1ZNuJNlh+UyXMn0COHDDdku1kb3Td1PIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039708; c=relaxed/simple;
	bh=Vv+gW5uxaqLnoE5RyXD5P8MD8HuCU1a+cW+9S5Nv/Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcNzit6n2zYNUQtH6ifbx2fjgI5aWDLVqlCgx0KGC3S78GZf3hoK8g7V/1SExx8DAupMFPkCQqGLWTAtVo3iIP7Me2JJ0sunnAt/GrCCeomqiZIBGKDy2Grn9UwfccWu4WS03n/PRrW5Ivvm24SHLNgLIpUTQQQ/ZdlWIfDtrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOXnuZhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F82C4CECF;
	Tue, 19 Nov 2024 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732039706;
	bh=Vv+gW5uxaqLnoE5RyXD5P8MD8HuCU1a+cW+9S5Nv/Tc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FOXnuZhV+DozeEJ2dBgwB2QVbBPf3bPaNrOu2lEzWW6uG8JZrX+7EmK6MXW/4hLtz
	 RLik3pA71FjeBhj9O+nWG4hGb7gh/tXrTV/h88q7iqr7jZ+5gcdlPXWQeR0PSyEvsv
	 h96KPGLV8qIga7/KkKQjk7VB1mrwUxLwYgmZyEA2xWnb9c1B9xoFfYGZqT66bsJY0w
	 imCNJFZ09IZLEDhRK+rWi6oxjfbRiGeGL/B6h7ZXENYg4ShvTxRqsxzc/T0MWgAlwv
	 pST/14P2m2JtMX78n1BRUPVDSJOfAFr5avmR3xPT8zP4iA6bDknylkf4dEAjdsb3XL
	 bdYANHB4e/VeQ==
Message-ID: <afef6b77-9981-459e-b6fb-883c02eb9c48@kernel.org>
Date: Tue, 19 Nov 2024 11:08:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GRE tunnels bound to VRF
Content-Language: en-US
To: Eyal Birger <eyal.birger@gmail.com>, Ben Greear <greearb@candelatech.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev <netdev@vger.kernel.org>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <ZzsCNUN1vl01uZcX@shredder>
 <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
 <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com>
 <b8b88a15-5b62-4991-ab0c-bb30a51e7be6@candelatech.com>
 <4a2f7ad9-6d38-4d9e-b665-80c29ff726d6@kernel.org>
 <303f83f8-e2cc-4a33-8bfe-ba490f932f18@candelatech.com>
 <CAHsH6GsiQGwP329zW2ZTB4q8fQnJm4dLRbZFCOvT842Z=LdDyg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHsH6GsiQGwP329zW2ZTB4q8fQnJm4dLRbZFCOvT842Z=LdDyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/19/24 11:04 AM, Eyal Birger wrote:
> On Tue, Nov 19, 2024 at 8:58 AM Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 11/19/24 8:36 AM, David Ahern wrote:
>>> On 11/19/24 7:59 AM, Ben Greear wrote:
>>>>
>>>> Ok, I am happy to report that GRE with lower-dev bound to one VRF and
>>>> greX in a different
>>>> VRF works fine.
>>>>
>>>
>>> mind sending a selftest that also documents this use case?
>>>
>>
>> I don't have an easy way to extract this into a shell script, but
>> at least as description:
> 
> FWIW I once created a tool for helping to jumpstart such scripts - see
> https://www.netpen.io
> 
> If I use it to create something similar to what you've described, the
> outcome is something like this (the link just encodes the relevant
> diagram info in b64):
> 
> https:://netpen.io/shared/eyJzZXR0aW5ncyI6eyJ0aXRsZSI6IkdSRSBFeGFtcGxlIn0sIml0ZW1zIjpbeyJzdWJuZXQiOnsibmFtZSI6ImdyZWVuIiwiY2lkciI6IjE5OC41MS4xMDAuMC8yNCJ9fSx7InN1Ym5ldCI6eyJuYW1lIjoiYmx1ZSIsImNpZHIiOiIxMC4wLjAuMC8yNCJ9fSx7Im5ldG5zIjp7Im5hbWUiOiJuczEifX0seyJ2ZXRoIjp7Im5hbWUiOiJ2IiwiZGV2MSI6eyJuZXRucyI6Im5ldG5zLm5zMSIsInN1Ym5ldHMiOlsic3VibmV0LmdyZWVuIl0sImV0aHRvb2wiOnt9LCJ0YyI6e319LCJkZXYyIjp7Im5ldG5zIjoibmV0bnMubnMxIiwic3VibmV0cyI6WyJzdWJuZXQuZ3JlZW4iXX19fSx7InZyZiI6eyJuYW1lIjoidnJmZ3JlZW4iLCJuZXRucyI6Im5ldG5zLm5zMSIsIm1lbWJlcnMiOlsidmV0aC52LmRldjIiXX19LHsidnJmIjp7Im5hbWUiOiJ2cmZibHVlIiwibmV0bnMiOiJuZXRucy5uczEiLCJtZW1iZXJzIjpbInZldGgudi5kZXYxIl19fSx7InR1bm5lbCI6eyJuYW1lIjoiZ3JlMSIsIm1vZGUiOiJncmUiLCJzdWJuZXRzIjpbInN1Ym5ldC5ibHVlIl0sImxpbmsxIjoidmV0aC52LmRldjEiLCJsaW5rMiI6InZldGgudi5kZXYyIiwiZGV2MSI6eyJuZXRucyI6Im5ldG5zLm5zMyJ9LCJkZXYyIjp7Im5ldG5zIjoibmV0bnMubnMyIn19fSx7Im5ldG5zIjp7Im5hbWUiOiJuczIifX0seyJuZXRucyI6eyJuYW1lIjoibnMzIn19XX0=
> 
> Eyal.

pretty cool. FYI - extra ':' in that URL

