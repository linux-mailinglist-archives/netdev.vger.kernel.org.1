Return-Path: <netdev+bounces-66443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB78583F3B9
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 05:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729801F21D1E
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 04:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2773FEC;
	Sun, 28 Jan 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcX3qxmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009D6116;
	Sun, 28 Jan 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416013; cv=none; b=tRZh94atcIanuMDgHlIBwSCTF21MdNeZ5t1n4GPyqEcrMmIR9w9/39YPhk3AP83McPT3XkYAAQ8MRObm8RTc8jROriA328cZ/r6z7XMM01AETfZzZ7VaZVnJEAzEENhJV5UPyzyp75ohznWn6anG+tkaFbmGg49jU+Ty5Mc6pIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416013; c=relaxed/simple;
	bh=jrglnE1Adn+FnQAzS9EK8pkxfRZ7gSXGw3WqUZWIM00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3s5GgYF7IoraDegyaDTrgp5vmEFGwqSvOPRNjRXTncUARlYlKJ1c8GGyCweinibU/BdqYVm/tky19UvNOy8BfGvL0N9LnKn2lm2bfUi3UusiMkLK1kOwF6ec5rIJJCVW59c7HB7e3/srre/1npuiJtpe9iUN3N+jRONgSEkGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcX3qxmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1596C433C7;
	Sun, 28 Jan 2024 04:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706416012;
	bh=jrglnE1Adn+FnQAzS9EK8pkxfRZ7gSXGw3WqUZWIM00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZcX3qxmcvgyr8SZ1bCSTNeDvX1KtwWtf1yQN3Pj1WOgHHKMkugsiZBVerWDTukuWd
	 7ZHUFfSqz11UgBugc08Fq3BCOz5UI4N5HnB5L1B+Ig9fPcwa1lW5HPPA1QT04oUbh/
	 q2DdoU7IYFAX3wGztKhGJdyhINUrEr9kaaPCYm9RY8SLZ/4+CVb4HVN1vwClrnMPSI
	 57VoGzgp3QAKfolcH6rRCZV16dCOgvCfC2WhoXIhPPOTpYuhAqIhdqQKFPXWkJ4sFv
	 ddPsV4Ay12TD3QRVGjEjYMVq6S7vGgprfbTorWCU3+bECnFQhl6Pqa8MJq9yM7AGoB
	 3sckh/fatnaEw==
Message-ID: <317aa139-78f8-424b-834a-3730a4c4ad04@kernel.org>
Date: Sat, 27 Jan 2024 21:26:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
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
 <c8420e51-691d-4dd9-8b81-0597e7593d07@kernel.org>
 <20240126171346.14647a6f@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240126171346.14647a6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 6:13 PM, Jakub Kicinski wrote:
> On Fri, 26 Jan 2024 17:56:26 -0700 David Ahern wrote:
>> On 1/24/24 2:48 PM, David Ahern wrote:
>> https://netdev-2.bots.linux.dev/vmksft-net-mp/results/438381/1-fcnal-test-sh/stdout
>>
>> still shows those 4 tests failing. since they pass on default Ubuntu
>> 23.10, I need some information about the setup. What is the OS image in
>> use and any known changes to the sysctl settings?
>>
>> Can I get `sysctl net > /tmp/sysctl.net` ? I will compare to Ubuntu and
>> see if I can figure out the difference and get those added to the script.
> 
> Here's a boot and run of the command (not sure how to export the file
> form the VM so I captured all of stdout):
> 
> https://netdev-2.bots.linux.dev/vmksft-net-mp/results/sysctl-for-david
> 
> The OS is Amazon Linux, annoyingly.

It's a bug in that version of iputils ping. It sets the BINDTODEVICE and
then resets it because the source address is not set on the command line
(it should not be required).

There are a couple of workarounds - one which might not age well (ie.,
amazon linux moving forward to newer packages -I <addr> -I <vrf>) and
one that bypasses the purpose of the test (ip vrf exec)).

