Return-Path: <netdev+bounces-78911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE74D876F31
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 05:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD2A1F2195D
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA11E533;
	Sat,  9 Mar 2024 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/FVqiJa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0071E49B
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709959644; cv=none; b=ayznhtlBYGpqm4vs1ydaKPhvcSRlMxHj/k3CWczdKXRoi3EjrOupQtTIBwDjmjC5uc7EUa59/wfSsQm1afRFQiH+e+gg6KRU61VvYqGQFC2ORqMwTSPURB1EY71B6UD9BGkD3emY0EjaSGLwUq1lak4kSxrNuYcRJIzAFCSuKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709959644; c=relaxed/simple;
	bh=TJFDKQnZkcyARcxpCyufnhJJx71PjMA6/CKZs9HDtAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeAVc98r7kvLlOcpkWWXkh/VT+JZJq/IiUHZyACjTwqvLeUDUxAx2h1AN1HBCXUfszT/NcTVQox3YHADehxekMpS5erh9m2/bbLbOAknouBhnw32x3ymV+/MiEOaZIRLf1r8sDJtBAoX2V/9DerUNiIUX/W4Ynzhio1rr3Z9QOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/FVqiJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF423C433C7;
	Sat,  9 Mar 2024 04:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709959643;
	bh=TJFDKQnZkcyARcxpCyufnhJJx71PjMA6/CKZs9HDtAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M/FVqiJaZpBX09qXR5YsdCb9TtuCGwoCeReVk2hVcM23Y57aask9/Yu9oF4vtFAoB
	 pn3cOCwXrN/nnjDpOFrGUOaNU7Z/znH95IU9namuopCeEzZLzyRRLH7xfPN1bGj8cX
	 WVA9MnXJx0KW3GE2LWfcqJMW5gyGmM6hhiI0aXcO3XON2hjE/A80Pm7e+vpqxrCkJG
	 bfp13wJD5bck+2iYHxJPxTpQKP1LjMlJ/w+xupjebq1jJQTYqNkUU/zcRuifWWT2FS
	 EA9WSBMMVAR6Mz4XWmliU11rzVRac/uQHX3blirkcRcrF3hYyXkf84I+vevMedbi1t
	 DjI6IB4QbkXng==
Message-ID: <e2e6d10b-26e7-4a12-92d1-5fdf394b8b4b@kernel.org>
Date: Fri, 8 Mar 2024 21:47:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, mlxsw@nvidia.com
References: <cover.1709901020.git.petrm@nvidia.com>
 <2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
 <20240308090333.4d59fc49@kernel.org> <87sf10l5fy.fsf@nvidia.com>
 <20240308194853.7619538a@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240308194853.7619538a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/24 8:48 PM, Jakub Kicinski wrote:
> On Fri, 8 Mar 2024 23:31:57 +0100 Petr Machata wrote:
>>> Are the iproute2 patches still on their way?
>>> I can't find them and the test is getting skipped.  
>>
>> I only just sent it. The code is here FWIW:
>>
>>     https://github.com/pmachata/iproute2/commits/nh_stats
> 
> I tried but I'll need to also sync the kernel headers.
> Maybe I'll wait until David applies :S
> Will the test still skip, tho, when running on veth?

marked the set; will try to get to it tomorrow.

