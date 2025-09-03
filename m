Return-Path: <netdev+bounces-219707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13613B42BF5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3467171D46
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515512D879A;
	Wed,  3 Sep 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWMecmn2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00F2BE64D
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935028; cv=none; b=uBePXvosKLopbG12VGwYJ1FnGcVVZrFUKMLl/e+6u3cshMXUWPBVLXEn45Uy2NVYdUFAXyWu9RSciIz/5SrwhM/8xUKgW42GaXGkv1Xgu5yo0qmLCx+8kv8jfiVacHqvnZfX3K98WmuhR7PUdrxOHUmEjb752hX1wuaNkyE3tgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935028; c=relaxed/simple;
	bh=rU/qDItNfsVfoWFyjlH3+6BWPAZpv69rTLdSs2C9A9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4Nl9b0MuUhoRNIhM+ZbLUzkkrucItd2H31eC+e6+aEz2AlmbMD1i44pMlThXmIzjuc9PwKYm+lyKHAg/DOIyAfVUqTdJrRmugi4+zzQjECvtzsdXfOl+5pNYKYR2qqCQE+ORyr/LyGj5OgRdAkZPXZGLK1w3aI/TC50zG41DZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWMecmn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52C0C4CEE7;
	Wed,  3 Sep 2025 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756935027;
	bh=rU/qDItNfsVfoWFyjlH3+6BWPAZpv69rTLdSs2C9A9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWMecmn2jbcqn3tFQdmyPcMasJW0a6zkS6epfok83IbqfNr+46t0rqVG2QgD6YIrU
	 9CG/VerXJyb4Repqg/NI8QdspDHkiPxCVOMIZEfeKski9N5c7W9zUuWNaKy0GLrlcE
	 bM2oPc3TbrJCtMxZCv44thh3zNpLeXoz1bkd0SYY9133vFXrEr2Mxd/aPG/kPTqSr9
	 /DR/vC6c2X/P5ScWaUrn0cy+k2UUUHfRhXs1007nidNolpzN14k0cEgv7ocfY0ccF/
	 /2tAEclwCszuePCzVbzUo05GOVb3zLu7wuxvMSg/XhPaJYuX7qAoH/jeDA7QC73LGJ
	 8IP7iWF2SbEIQ==
Date: Wed, 3 Sep 2025 14:30:26 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <aLizciLZEcF5hZ1g@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org>
 <aG9X13Hrg1_1eBQq@x130>
 <20250710152421.31901790@kernel.org>
 <aLC3jlzImChRDeJs@x130>
 <abdde2b3-8f21-4970-9cf3-d250ca3fb5c6@intel.com>
 <aLfj-9H-GL_amuYc@x130>
 <35fbf36c-a908-443d-b903-9a5410af7cf4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <35fbf36c-a908-443d-b903-9a5410af7cf4@intel.com>

On 03 Sep 12:59, Jacob Keller wrote:
>
>
>On 9/2/2025 11:45 PM, Saeed Mahameed wrote:
>> On 02 Sep 14:57, Jacob Keller wrote:
>>> Intel has also tried something similar sounding with the
>>> "link_down_on_close" in ethtool, which appears to be have made it in to
>>> ice and i40e.. (I thought I remembered these flags being rejected but I
>>> guess not?) I guess the ethtool flag is a bit difference since its
>>> relating to driver behavior when you bring the port down
>>> administratively, vs something like this which affects firmware control
>>> of the link regardless of its state to the kernel.
>>>
>>
>> Interesting, it seems that i40/ice LINK_DOWN_ON_CLOSE and TOTAL_PORT_SHUTDOWN_ENA
>> go hand in hand, tried to read the long comment in i40 but it is mostly
>> about how these are implemented in both driver and FW/phy but not what they
>> mean, what I am trying to understand is "LINK_DOWN_ON_CLOSE_ENA" is an
>> 'enable' bit, it is off by default and an opt-in, does that mean by default
>> i40e/ice don't actually bring the link down on driver/unload or ndo->close
>> ?
>>
>
>I believe so. I can't recall the immediate behavior, and I know both
>parameters are currently frowned on and only exist due to legacy of
>merging them before this policy was widely enforced.
>
>I believe the default is to leave the link up, and the flag changes
>this. I remember vaguely some discussions we had about which approach
>was better, and we had customers who each had different opinions.
>
>I could be wrong though, and would need to verify this.
>

So very similar to our device's behavior, thanks for the clarification.

>>>>>> This is not different as BMC is sort of multi-host, and physical link
>>>>>> control here is delegated to the firmware.
>>>>>>
>>>>>> Also do we really want netdev to expose API for permanent nic tunables ?
>>>>>> I thought this is why we invented devlink to offload raw NIC underlying
>>>>>> tunables.
>>>>>
>>>>> Are you going to add devlink params for link config?
>>>>> Its one of the things that's written into the NVMe, usually..
>>>>
>>>> No, the purpose of this NVM series is to setup FW boot parameters and not spec related
>>>> tunables.
>>>>
>>>
>>> This seems quite useful to me w.r.t to BMC access. I think its a stretch
>>> to say this implies the desire to add many other knobs.
>>
>> No sure if you are with or against the devlink knob ? :-)
>
>I think a knob is a good idea, and I think it makes sense in devlink,
>given that this applies to not just netdevice.
>
>> But thanks for the i40e/ice pointers at least I know I am not alone on this
>> boat..
>>
>
>The argument that adding this knob implies we need a much more complex
>link management scheme seems a little overkill to me.
>
>Unfortunately, I think the i40e/ice stuff is perhaps slightly orthogonal
>given that it applies mainly to the link behavior with software running.
>
>This knob appears to be more about firmware behavior irrespective of
>what if any software is running?

Agreed, and yes, behavior is to let FW decide what happens to link (physical)
regardless what SW asks, when this knob is on.




