Return-Path: <netdev+bounces-176333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D8A69C40
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C1E427B4F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97A221DB5;
	Wed, 19 Mar 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAWlRwpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840E221DB2
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424338; cv=none; b=RdKWfeyu4+TgiapRnrrBEHYklkEdGDabMLcjIbymIP++Et2WHNBlaWt7W7IBkw9yaJk9epZLJlXUUNhLnDgNdi3k2DiPv8U1WK3x98SCLC4VHBICVqpGT6LfokLXtFWaG9ltArZH6/TAtTytpPW4czuZUlv+B9iWYREGjJtPtR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424338; c=relaxed/simple;
	bh=KZIjRBeYKCvqoZEHqvc9rJFfyPirsVK5LfzVOx0k8SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiHKLzpswGdy7pFGeMSU98Tg2ai+DjQWb4b+kSN+exJmFxBoqc3T1vTVn+BLL/ypcIDT6AXN4boU9GDd5TWCN0UPVNE5B3R+j/4z/9LhNGXCvnHld/WPePnO2J1O//cZsV8BShPuAHD8JcEc+5YhjfrLRrMLX7/hsaLgELZSi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAWlRwpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA651C4CEEA;
	Wed, 19 Mar 2025 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742424337;
	bh=KZIjRBeYKCvqoZEHqvc9rJFfyPirsVK5LfzVOx0k8SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAWlRwpc1WmhewpsgyV+RjCmko3tLFSE4Q6jYEkuFnmhA9LpclRzzOgdR5sil6gGD
	 df9lPmd0p7EeJj/LCl5wha85Wp30W23LFL1p2LEdAUPeazsb5Uqif689epGxKTvgdb
	 bGYX+9qRp8NZnxBH3fELYbyvz9xuutjGPWn2eLcOGDtawRB1JuZKWwjN4DnDpiysvn
	 ppj1hiOFVYo1cLBJ+aPEXlf32h9Zzvu5GscU2cHPVv6evsE2EglynjWOTVbOJcS+AB
	 9R5pDGfIV402gMa0NEOzDvkGTAv337x78SQxwGABk9zEQVVww5I7i5WI9IGJFa8bkR
	 +nApQkGl4M25g==
Date: Wed, 19 Mar 2025 15:45:36 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 01/14] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <Z9tJEDfPK0HecSR5@x130>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-2-saeed@kernel.org>
 <20250306120545.GY3666230@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250306120545.GY3666230@kernel.org>

On 06 Mar 12:05, Simon Horman wrote:
>On Thu, Feb 27, 2025 at 06:12:14PM -0800, Saeed Mahameed wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Devlink param and health reporter fmsg use attributes with dynamic type
>> which is determined according to a different type. Currently used values
>> are NLA_*. The problem is, they are not part of UAPI. They may change
>> which would cause a break.
>>
>> To make this future safe, introduce a enum that shadows NLA_* values in
>> it and is part of UAPI.
>>
>> Also, this allows to possibly carry types that are unrelated to NLA_*
>> values.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> ---
>>  Documentation/netlink/specs/devlink.yaml | 23 ++++++++++++++++++
>>  include/uapi/linux/devlink.h             | 17 ++++++++++++++
>>  net/devlink/health.c                     | 17 ++++++++++++--
>>  net/devlink/param.c                      | 30 ++++++++++++------------
>>  4 files changed, 70 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index 09fbb4c03fc8..e99fc51856c5 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -202,6 +202,29 @@ definitions:
>>          name: exception
>>        -
>>          name: control
>> +  -
>> +    type: enum
>> +    name: dyn_attr_type
>> +    entries:
>> +      -
>> +        name: u8
>> +        value: 1
>> +      -
>> +        name: u16
>> +      -
>> +        name: u32
>> +      -
>> +        name: u64
>> +      -
>> +        name: string
>> +      -
>> +        name: flag
>> +      -
>> +        name: nul_string
>> +        value: 10
>> +      -
>> +        name: binary
>> +  -
^^^^^^^ extra empty type.. 

>
>Hi Saeed,
>
>Thanks for these patches.
>
>Unfortunately the above seems to cause ynl-regen to blow up.

Thanks Simon, good catch, there was an extra empty type added by mistake,
see above, will remove in V2.

>I don't know why, but I see:
>
>  $ ./tools/net/ynl/ynl-regen.sh
>  Traceback (most recent call last):
>    File "/home/nipa/net-next/wt-1/tools/net/ynl/pyynl/ynl_gen_c.py", line 3074, in <module>
>      main()
>      ~~~~^^
>    File "/home/nipa/net-next/wt-1/tools/net/ynl/pyynl/ynl_gen_c.py", line 2783, in main
>      parsed = Family(args.spec, exclude_ops)
>    File "/home/nipa/net-next/wt-1/tools/net/ynl/pyynl/ynl_gen_c.py", line 954, in __init__
>      super().__init__(file_name, exclude_ops=exclude_ops)
>      ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/home/nipa/net-next/wt-1/tools/net/ynl/pyynl/lib/nlspec.py", line 462, in __init__
>      jsonschema.validate(self.yaml, schema)
>      ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
>    File "/usr/lib/python3.13/site-packages/jsonschema/validators.py", line 1307, in validate
>      raise error
>  jsonschema.exceptions.ValidationError: None is not of type 'object'
>
>  ...
>
>Perhaps I need a newer version of jsonschema?
>
>
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index 9401aa343673..8cdd60eb3c43 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -385,6 +385,23 @@ enum devlink_linecard_state {
>>  	DEVLINK_LINECARD_STATE_MAX = __DEVLINK_LINECARD_STATE_MAX - 1
>>  };
>>
>> +/**
>> + * enum devlink_dyn_attr_type - Dynamic attribute type type.
>
>Perhaps this relates to auto-generation.
>But I think the Kernel doc should also document the enum values:
>DEVLINK_DYN_ATTR_TYPE_U8, ...
>
>> + */
>> +enum devlink_dyn_attr_type {
>> +	/* Following values relate to the internal NLA_* values */
>> +	DEVLINK_DYN_ATTR_TYPE_U8 = 1,
>> +	DEVLINK_DYN_ATTR_TYPE_U16,
>> +	DEVLINK_DYN_ATTR_TYPE_U32,
>> +	DEVLINK_DYN_ATTR_TYPE_U64,
>> +	DEVLINK_DYN_ATTR_TYPE_STRING,
>> +	DEVLINK_DYN_ATTR_TYPE_FLAG,
>> +	DEVLINK_DYN_ATTR_TYPE_NUL_STRING = 10,
>> +	DEVLINK_DYN_ATTR_TYPE_BINARY,
>> +	__DEVLINK_DYN_ATTR_TYPE_CUSTOM_BASE = 0x80,
>> +	/* Any possible custom types, unrelated to NLA_* values go below */
>> +};
>> +
>>  enum devlink_attr {
>>  	/* don't change the order or add anything between, this is ABI! */
>>  	DEVLINK_ATTR_UNSPEC,
>
>...

