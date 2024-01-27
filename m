Return-Path: <netdev+bounces-66338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F3C83E8C6
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 01:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB51B24AB7
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 00:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D423D8;
	Sat, 27 Jan 2024 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIrThsCh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E2630;
	Sat, 27 Jan 2024 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316988; cv=none; b=i/8PjLOG251QSUgkHwf4jGdhMHJ/uTsBrlE/I0HfbviregPNv4BHZCLi6EWFG19gmsy4aWA9A9shiY8oZ7HT8Yw5yP9BrjVabkeg4DiRvYl/g9ZHWA3PPH7rCPXdcLmKAfAsFTolmGcmQZphs2m/jLYQ2tBm3ioJTmgCRytRNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316988; c=relaxed/simple;
	bh=zn1OpKVOFajNbKTB7PzeWk+tJLRHFIGs5bYssbmVwlw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SwfJDFaq1cyF8u7C6oFZaMm0FZRQ6o1zRMZWKx5IY6tWmG/q3CDbmgTuILbe6YYDEv37A2MDzC3shE+Z0OPA/rNeMogeiYNsNxYkMMq1uPfMTjms91TF5rXHbj6pLMH57KydY/cT6y2Bu2NEaGRbvamNQMS3mbjHLUeN4KMrZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIrThsCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8D9C433F1;
	Sat, 27 Jan 2024 00:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706316987;
	bh=zn1OpKVOFajNbKTB7PzeWk+tJLRHFIGs5bYssbmVwlw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QIrThsChACRjKkFLaLaHaRB1kADvcCsH585z1mNVNd6vGO7AuyqtRKZhTphkbP8Ih
	 b1B18OX31gdFePvIdDk+VTxlaFfDeTgGGW3d72CwtJlzzW1PK3NxGvF5Sytr0mZ++4
	 Ms+N40dK8ghROOQpqoM2xRhLZQMc1AQlhYamFo3/bd37CiGnmHnNmS0b4mkETioS6L
	 5DAY9a900NiRnUc28+wpgW9kQvZ6nWqqWYFgaL1wn9bChrWh9VFo61bj4ymS967lJd
	 ZQKKeY2zVe7UMmnJ2MRM+byiPoumHpxrqZ6JEg7pahNHl4PUWWx/4lKhJ+o9O1/pnF
	 DB21qlw2l57iQ==
Message-ID: <c8420e51-691d-4dd9-8b81-0597e7593d07@kernel.org>
Date: Fri, 26 Jan 2024 17:56:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <20240123133925.4b8babdc@kernel.org>
 <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
 <7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
 <20240124070755.1c8ef2a4@kernel.org> <20240124081919.4c79a07e@kernel.org>
 <aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
 <20240124085919.316a48f9@kernel.org>
 <bd985576-cc99-49c5-a2e0-09622fd6027a@kernel.org>
In-Reply-To: <bd985576-cc99-49c5-a2e0-09622fd6027a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 2:48 PM, David Ahern wrote:
>>
>>>> $ grep FAIL stdout 
>>>> # TEST: ping local, VRF bind - VRF IP                 [FAIL]
>>>> # TEST: ping local, device bind - ns-A IP             [FAIL]
>>>> # TEST: ping local, VRF bind - VRF IP                 [FAIL]
>>>> # TEST: ping local, device bind - ns-A IP             [FAIL]
>>>>
>>>> :(  

https://netdev-2.bots.linux.dev/vmksft-net-mp/results/438381/1-fcnal-test-sh/stdout

still shows those 4 tests failing. since they pass on default Ubuntu
23.10, I need some information about the setup. What is the OS image in
use and any known changes to the sysctl settings?

Can I get `sysctl net > /tmp/sysctl.net` ? I will compare to Ubuntu and
see if I can figure out the difference and get those added to the script.


