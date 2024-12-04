Return-Path: <netdev+bounces-149159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF209E4839
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E2C168E65
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7266F202C22;
	Wed,  4 Dec 2024 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="fuT6POE0"
X-Original-To: netdev@vger.kernel.org
Received: from mx16lb.world4you.com (mx16lb.world4you.com [81.19.149.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66118DF6D
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353128; cv=none; b=DJFfcndwHUkrVzycj3f68gyX5fEnmwSifq/Ce7QwT7CsYQfRdtpYFZweV85HDzfy0+pHbsqKMKEGFDMEe7ZUgufXTXtb3QR2lsLLPhJ8sxViz8ncZwr/eXew7UaIuE0efb1fwE1NW/sJk26VeXkUsBqzSli2nSd0Qma7wXu4uwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353128; c=relaxed/simple;
	bh=gVKgzwl8ntKSWrOvFXyw8Z1n3CN0L59sb1DqfCJu1e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVPWqn+Xz8ctUuKCo6kDiUvc32IBh7IzcdBFg1glmzh6BdOPpgbTWmzeDW0s1Kya9PKkzzpFjoC0dJXuLA6D8OWLyRKWfOLTdggZ4ZN8Bt+w20wbxdeAI+KZPZwcEexZ4yoYxZWJ1WWUUZrcm6+yu5tw3TC4b93TQrcHOZmOLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=fuT6POE0; arc=none smtp.client-ip=81.19.149.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GirAyz2Vc6AyIWO7DCGREizNgX08C+P2Yh6QCGAaJaw=; b=fuT6POE0pV8AZkqh/tVR5YynqL
	ybsdQqZJkfj7yzQWM6Hb+vxiIHHM9chdE+auV+4txYxCGITqr4hBNupqwXlvbbKx+auJjGlMucEzg
	XZ3MRbMQAicd1V+mSnOBnkaVL7Mk54ygvfhPW5oJV2vNtBlwzLVE8z6kP4aaYq+/mDUk=;
Received: from [88.117.62.55] (helo=[10.0.0.160])
	by mx16lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tIvsb-000000008U2-1ODm;
	Wed, 04 Dec 2024 21:21:50 +0100
Message-ID: <06edcab8-280d-4397-8df2-58a35eb094ec@engleder-embedded.com>
Date: Wed, 4 Dec 2024 21:21:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] e1000e: Fix real-time violations on link up
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Gerhard Engleder <eg@keba.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20241203202814.56140-1-gerhard@engleder-embedded.com>
 <ef87bd20-6fda-4839-8cff-4ab10bf500a7@intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <ef87bd20-6fda-4839-8cff-4ab10bf500a7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 04.12.24 11:10, Przemek Kitszel wrote:
> On 12/3/24 21:28, Gerhard Engleder wrote:
>> From: Gerhard Engleder <eg@keba.com>
>>
>> From: Gerhard Engleder <eg@keba.com>
> 
> duplicated From: line

Nervous fingers, sorry, will be fixed.

>>
>> Link down and up triggers update of MTA table. This update executes many
>> PCIe writes and a final flush. Thus, PCIe will be blocked until all 
>> writes
>> are flushed. As a result, DMA transfers of other targets suffer from 
>> delay
>> in the range of 50us. This results in timing violations on real-time
>> systems during link down and up of e1000e.
>>
>> A flush after a low enough number of PCIe writes eliminates the delay
>> but also increases the time needed for MTA table update. The following
>> measurements were done on i3-2310E with e1000e for 128 MTA table entries:
>>
>> Single flush after all writes: 106us
>> Flush after every write:       429us
>> Flush after every 2nd write:   266us
>> Flush after every 4th write:   180us
>> Flush after every 8th write:   141us
>> Flush after every 16th write:  121us
>>
>> A flush after every 8th write delays the link up by 35us and the
>> negative impact to DMA transfers of other targets is still tolerable.
>>
>> Execute a flush after every 8th write. This prevents overloading the
>> interconnect with posted writes. As this also increases the time spent 
>> for
>> MTA table update considerable this change is limited to PREEMPT_RT.
> 
> hmm, why to limit this to PREEMPT_RT, the change sounds resonable also
> for the standard kernel, at last for me
> (perhaps with every 16th write instead)

As Andrew argumented similar, I will remove the PREEMPT_RT dependency
with the next version. This is not the hot path, so the additional delay
of <<1ms for boot and interface up is negligible.

> with that said, I'm fine with this patch as is too
> 
>>
>> Signed-off-by: Gerhard Engleder <eg@keba.com>
> 
> would be good to add link to your RFC
> https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
> 
> and also CC Vitaly who participated there (done),
> same for IWL mailing list (also CCd), and use iwl-next tag for your
> future contributions to intel ethernet

Will be done.

Thank you for the review!

Gerhard

