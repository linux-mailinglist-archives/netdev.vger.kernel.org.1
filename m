Return-Path: <netdev+bounces-150126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7649E9049
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081201634F6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8A217F47;
	Mon,  9 Dec 2024 10:34:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A6217721;
	Mon,  9 Dec 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740448; cv=none; b=mEoiwFRYLw66O7Aix5gTyhSqiml2fl5WpY759eWu5Tm5maLBB9eFOfrvk/K308rxR3fCvnkic+WjlYQbXL0+DWWCTwlI5P586gmQBlddpQn8PXFjY6EttQBp+5X9h1mC9nEF0xnYAj/EHz9JaVCXeBtiAK8rSbHoXfxoUtmRANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740448; c=relaxed/simple;
	bh=rhF6enybLiMYwpi3g6iEZpO8kL4r36agNjh4P74iV4g=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uS7bLR/SlP/7n/Q+L382nVcVapK26laaaX3h/ChDdFj6/HibAdhOclzsmD0Ta+kxb9jXr1gZ9I9TkA5RvouaJ/5V1PqeWbD+ekaW2ViYdblVOuD/BWJ6OSJhIkGBlBD4M0XnG7diqCOgejnM1/JPhB5IDxPEErPFz8F6ebEVpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y6JBY0dbjz20lYq;
	Mon,  9 Dec 2024 18:34:13 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E9DF1400F4;
	Mon,  9 Dec 2024 18:33:56 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 18:33:55 +0800
Message-ID: <bb464691-06c0-4842-8e4f-27cf368b363f@huawei.com>
Date: Mon, 9 Dec 2024 18:33:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V5 net-next 1/8] debugfs: Add debugfs_create_devm_dir()
 helper
To: Greg KH <gregkh@linuxfoundation.org>
References: <20241206111629.3521865-1-shaojijie@huawei.com>
 <20241206111629.3521865-2-shaojijie@huawei.com>
 <2024120627-smudge-obsolete-efb6@gregkh>
 <6274cc5a-375f-4009-bc3e-1b1063f298bb@huawei.com>
 <2024120925-dreamt-immorally-f9f8@gregkh>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <2024120925-dreamt-immorally-f9f8@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/9 14:31, Greg KH wrote:
> On Mon, Dec 09, 2024 at 09:02:10AM +0800, Jijie Shao wrote:
>> on 2024/12/6 19:40, Greg KH wrote:
>>> On Fri, Dec 06, 2024 at 07:16:22PM +0800, Jijie Shao wrote:
>>>> Add debugfs_create_devm_dir() helper
>>>>
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>>> ---
>>>>    fs/debugfs/inode.c      | 36 ++++++++++++++++++++++++++++++++++++
>>>>    include/linux/debugfs.h | 10 ++++++++++
>>>>    2 files changed, 46 insertions(+)
>>>>
>>>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>>>> index 38a9c7eb97e6..f682c4952a27 100644
>>>> --- a/fs/debugfs/inode.c
>>>> +++ b/fs/debugfs/inode.c
>>>> @@ -610,6 +610,42 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(debugfs_create_dir);
>>>> +static void debugfs_remove_devm(void *dentry_rwa)
>>>> +{
>>>> +	struct dentry *dentry = dentry_rwa;
>>>> +
>>>> +	debugfs_remove(dentry);
>>>> +}
>>>> +
>>>> +/**
>>>> + * debugfs_create_devm_dir - Managed debugfs_create_dir()
>>>> + * @dev: Device that owns the action
>>>> + * @name: a pointer to a string containing the name of the directory to
>>>> + *        create.
>>>> + * @parent: a pointer to the parent dentry for this file.  This should be a
>>>> + *          directory dentry if set.  If this parameter is NULL, then the
>>>> + *          directory will be created in the root of the debugfs filesystem.
>>>> + * Managed debugfs_create_dir(). dentry will automatically be remove on
>>>> + * driver detach.
>>>> + */
>>>> +struct dentry *debugfs_create_devm_dir(struct device *dev, const char *name,
>>>> +				       struct dentry *parent)
>>>> +{
>>>> +	struct dentry *dentry;
>>>> +	int ret;
>>>> +
>>>> +	dentry = debugfs_create_dir(name, parent);
>>>> +	if (IS_ERR(dentry))
>>>> +		return dentry;
>>>> +
>>>> +	ret = devm_add_action_or_reset(dev, debugfs_remove_devm, dentry);
>>>> +	if (ret)
>>>> +		ERR_PTR(ret);
>>> You don't clean up the directory you created if this failed?  Why not?
>> Don't need to clean up.
>> in devm_add_action_or_reset(), if failed, will call action: debugfs_remove_devm(),
>> So, not clean up again.
>>
>> #define devm_add_action_or_reset(dev, action, data) \
>> 	__devm_add_action_or_reset(dev, action, data, #action)
>>
>> static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
>> 					     void *data, const char *name)
>> {
>> 	int ret;
>>
>> 	ret = __devm_add_action(dev, action, data, name);
>> 	if (ret)
>> 		action(data);
>>
>> 	return ret;
>> }
>>
>> But there's a problem with this, I missed return.
>> I will add return in v6.
> As this did not even compile, how did you test any of this?
>
> I'm now loath to add this at all, please let's just keep this "open
> coded" in your driver for now until there are multiple users that need
> this and then convert them all to use the function when you add it.
>
> thanks,
>
> greg k-h

I've tested and it's ok,

But, there is a warning(warn_unused_result)..
My test command does not check warning other than the hibmcge driver.
This was caused by my carelessness. I'm very sorry.

I've looked at other driver codes, and quite a few others have similar codes.
As you suggest, this patchset still uses open code in next version.
In the future, I will try to send a new independent patchset to introduce it.

Thanks,
Jijie Shao


