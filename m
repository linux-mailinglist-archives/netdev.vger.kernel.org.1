Return-Path: <netdev+bounces-87231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534408A23A3
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094211F218F5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 02:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575386AB8;
	Fri, 12 Apr 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6yIvEvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31844101EE
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887579; cv=none; b=Ujv5i99Fletw0up5xfL8pMOBMypoaYtuo1KO+iLPlQ2J+hagZTVLKHkUnfktVftbKFmeIzgUeFFGbP28mzBWXYmM1AtlGnoNrZ9YH/ntBQRXYUXOqGVg0J1Eop6yFFo1sbFhFgGVAj3Vs0mS3lLS18bb9pk4fRY8xSiotSZ7fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887579; c=relaxed/simple;
	bh=XuYgQ1VcisxGks5FsNLPVV3QVm4Gz6eC2mrKzcImW9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Caop6uiBAVLlqGub2OFtxzjzsk6euFLrGctjlCDyOSG8LTNa+2psptsjeO95pb0ksXsk1XMuMvdk6qXseKhOkmUKudvMr6vsxIrwK23dYj9Pw8OZzEg8psfvnr77E0zqzv1zJ+cl7YpZxrC+r15KbZYE39l+TjdpyqncPMrn+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6yIvEvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21990C072AA;
	Fri, 12 Apr 2024 02:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712887578;
	bh=XuYgQ1VcisxGks5FsNLPVV3QVm4Gz6eC2mrKzcImW9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V6yIvEvkG9d/FbvdUZI5tFFvYiOgqXJb7sYr5Mn+W6D4Dq1H38ffGbtUVIEPNagr9
	 dZxzjVoHoGK2yoSUp/hYRpcwCRd/1CjqKVQHxS8hHiY5A5xEhx3oYvkbxRcJnIh2hu
	 SzdRZEWJuXF7UPwE+TeHhF22EZG+iTj/hCK7DgpWlNj01uEzKmztLvAkZ5ixhVERwI
	 AclZCnJoP4ldSCeEjq0+YgU7ArAdV2HOzzuSwPqOOCDesK5/Qq2evV6URnHMGRCRbt
	 9a2YxI1/JU2RhcH8rGJaStPOnydn+i/mQSQfz/9v4ME67RN8YRbtvcEU0JzqThfEjo
	 CrcjO8kH9KddA==
Message-ID: <68b0f6e2-6890-46f9-b824-2af5ba5f9fd4@kernel.org>
Date: Thu, 11 Apr 2024 20:06:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Content-Language: en-US
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Cc: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>
References: <20240410115808.12896-1-parav@nvidia.com>
 <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
 <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
 <dc7eb252-5223-4475-9607-9cf1fc81b486@intel.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <dc7eb252-5223-4475-9607-9cf1fc81b486@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/11/24 5:03 PM, Samudrala, Sridhar wrote:
> 
> 
> On 4/10/2024 9:32 PM, Parav Pandit wrote:
>> Hi Sridhar,
>>
>>> From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
>>> Sent: Thursday, April 11, 2024 4:53 AM
>>>
>>>
>>> On 4/10/2024 6:58 AM, Parav Pandit wrote:
>>>> Devices send event notifications for the IO queues, such as tx and rx
>>>> queues, through event queues.
>>>>
>>>> Enable a privileged owner, such as a hypervisor PF, to set the number
>>>> of IO event queues for the VF and SF during the provisioning stage.
>>>
>>> How do you provision tx/rx queues for VFs & SFs?
>>> Don't you need similar mechanism to setup max tx/rx queues too?
>>
>> Currently we don’t. They are derived from the IO event queues.
>> As you know, sometimes more txqs than IO event queues needed for XDP,
>> timestamp, multiple TCs.
>> If needed, probably additional knob for txq, rxq can be added to
>> restrict device resources.
> 
> Rather than deriving tx and rx queues from IO event queues, isn't it
> more user friendly to do the other way. Let the host admin set the max
> number of tx and rx queues allowed and the driver derive the number of
> ioevent queues based on those values. This will be consistent with what
> ethtool reports as pre-set maximum values for the corresponding VF/SF.
> 

I agree with this point: IO EQ seems to be a mlx5 thing (or maybe I have
not reviewed enough of the other drivers). Rx and Tx queues are already
part of the ethtool API. This devlink feature is allowing resource
limits to be configured, and a consistent API across tools would be
better for users.


