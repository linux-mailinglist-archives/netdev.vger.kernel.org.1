Return-Path: <netdev+bounces-284842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAyiAPhE+2lPYgMAu9opvQ
	(envelope-from <netdev+bounces-284842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:41:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD864DB1AA
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E69E3009885
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5C478841;
	Wed,  6 May 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="1I6j6w/V"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7AC4266A3
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074410; cv=none; b=Y/VcqtZr1Wfdp1VsVlCPh+XuvsWH/QX26rl/YtNn1084Y7twHalqZcyup0dIwPLBdZ82klwXTWX7n45K2bCIgLoVn/h2FTxBN+YubnPwe7PlVW0QYmGYIyHzlLTUNW+8N+dROZj5bGQScwAHmP9i7FUDP0K0Ke24OVc77wMiB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074410; c=relaxed/simple;
	bh=eGoddD7Ne//pYiqQNVkdPKKNPyDqzHyNkhrE2zFFt9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=fWD02t54Es+tAIWCnRepnfdBvVWg51i6XDub7wRKvsCw3EMbi1P345UPeszx/Mrb79ENbZlhASVTxRVUNpmhn2U8CMqCQ3GsctwOUg4cCEy5O7F6uuopwULIIPLPjujRGlDoJxu/mAMyqAISJ6A4IC7V9u3ClPLinl5pGL+qTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=1I6j6w/V reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:References:From:Cc:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=aIOtrJmA2
	CN1KdM+lHmKadgq3mPKZCxXcgN222FbeYs=; b=1I6j6w/VWNfPa1bs0BT3lcWxZ
	4it1LFiReKsGp4dPpr5DVHzwwNraBnmrRdAid9XZKfVUjY5/zNE9nhegdUBZjH/P
	9ndJXoxlWOdH58guizG4ga64EePcVQZNm7QdaxQTb4E7tW0wADXmfKi/+xOfwPSI
	+JKe/j2egTHTLs19Os=
Received: from [IPV6:240c:c983:9:b680:c938:8a96:7535:a11e] (unknown [240c:c983:9:b680:c938:8a96:7535:a11e])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkAmDLwVQ_tpwmnvAQ--.28994S3;
	Wed, 06 May 2026 21:33:11 +0800 (CST)
Message-ID: <869d7c57-bfbb-46eb-98b7-64e7feb4a383@std.uestc.edu.cn>
Date: Wed, 6 May 2026 21:33:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethtool: fix NULL pointer dereference in
 phy_reply_size
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, andrew@lunn.ch
References: <20260506120131.767679-1-2022090917019@std.uestc.edu.cn>
 <08d60afc-56ee-49d1-b124-4d8f6191afcd@bootlin.com>
From: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
In-Reply-To: <08d60afc-56ee-49d1-b124-4d8f6191afcd@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BLQMCkAmDLwVQ_tpwmnvAQ--.28994S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDCF17AFy8JFy7Kr1Dtrb_yoW5JFW5pr
	W5CayYvF97JrnrJa12qw15CryFyF4fGF15ta1jkw1rZrnxWFZ2qrWUKr1Fgay8Zrs5ua4j
	vF4FgasIv3ZrAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU8Q6pDUUUUU==
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/
X-Rspamd-Queue-Id: 8BD864DB1AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	DMARC_POLICY_QUARANTINE(1.50)[uestc.edu.cn : SPF not aligned (relaxed),quarantine];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284842-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[std.uestc.edu.cn:s=dkim];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[std.uestc.edu.cn:~];
	NEURAL_SPAM(0.00)[0.581];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2022090917019@std.uestc.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uestc.edu.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,std.uestc.edu.cn:mid]

On 2026/5/6 20:23, Maxime Chevallier wrote:
> Hi,
> 
> On 06/05/2026 14:01, Quan Sun wrote:
>> In phy_prepare_data(), the strings rep_data->name and rep_data->drvname
>> are allocated using kstrdup(). However, the return values of these
>> allocations are not checked.
>>
>> If kstrdup() fails to allocate memory, it returns NULL. The function
>> phy_prepare_data() will still return 0 (success). Subsequently, the
>> handler ethnl_default_doit() continues the execution flow and calls
>> phy_reply_size() to calculate the size of the reply message. This
>> unconditionally executes strlen(rep_data->name), leading to a kernel
>> NULL pointer dereference and panic.
>>
>> Fix this by properly checking the return values of kstrdup() for both
>> `name` and `drvname`, and returning -ENOMEM if the allocation fails.
>>
>> Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> 
> Thanks for the fix :)
> 
> You're missing the Fixes: tag however.
> 
> Can you please add it ?
> 
>> ---
>>   net/ethtool/phy.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
>> index d4e6887055ab1..6cf3df1df8659 100644
>> --- a/net/ethtool/phy.c
>> +++ b/net/ethtool/phy.c
>> @@ -88,8 +88,17 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
>>   		return -EOPNOTSUPP;
>>   
>>   	rep_data->phyindex = phydev->phyindex;
>> +
>>   	rep_data->name = kstrdup(dev_name(&phydev->mdio.dev), GFP_KERNEL);
>> +	if (!rep_data->name)
>> +		return -ENOMEM;
>> +
>>   	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
>> +	if (!rep_data->drvname) {
>> +		kfree(rep_data->name);
>> +		return -ENOMEM;
>> +	}
>> +
>>   	rep_data->upstream_type = pdn->upstream_type;
>>   
>>   	if (pdn->upstream_type == PHY_UPSTREAM_PHY) {
> 
> There's a similar problem a few lines below with :
> 
>    rep_data->upstream_sfp_name
> 
> and
> 
>    rep_data->downstream_sfp_name
> 
> The only problematic case really is rep_data->name, as all the other
> strings are checked for being NULL upon accessing them.
> 
> So either we only fix the rep_data->name allocation checks, or all the
> string allocations :)
> 
> Can you address this in V2 ?
> 
> Thanks,
> 
> Maxime

Hi,

Thanks for your review and the detailed suggestions!

I'll find the missing Fixes tag and address the other string allocation 
checks as you suggested.

I will send the V2 patch shortly after further testing and ensuring it 
follows the 24-hour rule since V1.

Best regards,

Quan Sun


