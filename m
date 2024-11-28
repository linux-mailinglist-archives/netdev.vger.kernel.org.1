Return-Path: <netdev+bounces-147770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09999DBAFF
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2EC160694
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB91BD9C1;
	Thu, 28 Nov 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEFswcnR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F253232;
	Thu, 28 Nov 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809971; cv=none; b=k7q1OXTto5vRp4igwPuiGwn5VW0Sq0DD8gKImCxDalqYPJEhWPK/9iUjbEmERK3BoXE98t4S/gavOagdjV4yYmUiQPV+RIgEUL7ENwBXuFhhJi6/1B/Qemwu8r/jxiEjxVPm/IK6dMwirDQ+GaJO6BcbWipYvQ1YooCxbOmHP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809971; c=relaxed/simple;
	bh=X/20+SNwnw83e62Cg0VirreIAgYmJ/+v+D8Kh9ftvPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebF867tYc+nzeAKKPrAf05d/CtQB+2KPyBrSs46yzA6IQM5c7bkiqCHs1ms4kCzg2r0LAjqaSc9MLs6HnisSbwyYKr43DintJofWiMeUpayOWrYp8qqVOsZxnAAlF6u7aVHhGr4wgdyFaKtGXQkahHosMbaszimvScoO2xb9T1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEFswcnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799F8C4CECE;
	Thu, 28 Nov 2024 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732809970;
	bh=X/20+SNwnw83e62Cg0VirreIAgYmJ/+v+D8Kh9ftvPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEFswcnRbc0Kzyg+C1OZRMbiMuI8K1buJeVrKzrQqCP51sXr/KeRax/JAcS+pfaLR
	 uSfVBJ3gDhP3bbZaARqc4u0Xp30T9OArdVSa4yyN7iEGYePHQQoWYF9SDwQrWwo0bj
	 R344Q8IOnk48qcbO00o4K/ngaCYgt9SyeIhB02GuMT9E/OXA9GkmhhfyBZg7HRgOtD
	 J4DmGOqjTzk1kI43QSetJGT3JKYVHZj+yKP/dn///7UfujAYJ6KITT7OLza0egg5bY
	 2BawZJji4z4ThrrpYyFz02WQ51Z6iTJN0eVJQJ5Tt50yjAdt5x9PfvpN3gTX0VzoZH
	 09T6r0IFuMfeA==
Date: Thu, 28 Nov 2024 11:06:09 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.13-rc1
Message-ID: <Z0iU8QcgrC7QBEOQ@sashalap>
References: <20241128142738.132961-1-pabeni@redhat.com>
 <Z0iC2DuUf9boiq_L@sashalap>
 <a4213a79-dd00-4d29-9215-97eb69f75f39@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a4213a79-dd00-4d29-9215-97eb69f75f39@redhat.com>

On Thu, Nov 28, 2024 at 04:46:40PM +0100, Paolo Abeni wrote:
>On 11/28/24 15:48, Sasha Levin wrote:
>> On Thu, Nov 28, 2024 at 03:27:38PM +0100, Paolo Abeni wrote:
>>>      ipmr: add debug check for mr table cleanup
>>
>> When merging this PR into linus-next, I've noticed it introduced build
>> errors:
>>
>> /builds/linux/net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>>    320 | static bool ipmr_can_free_table(struct net *net)
>>        |             ^~~~~~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> The commit in question isn't in linux-next and seems to be broken.
>
>My fault, I'm sorry.
>
>I can't reproduce the issue here. Could you please share your kconfig
>and the compiler version? I'll try to address the issue and re-send the
>PR ASAP.

All the build info for one for the failures is available here:
https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25635-g6813e2326f1e/testrun/26111580/suite/build/test/clang-nightly-lkftconfig/details/

-- 
Thanks,
Sasha

