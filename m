Return-Path: <netdev+bounces-31913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF17915F9
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 13:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216D3280F80
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A12102;
	Mon,  4 Sep 2023 11:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC11FBD
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 11:00:15 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264BAAB
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 04:00:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4018af1038cso13303715e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693825210; x=1694430010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbCVRUoy/GXd5quDgH6ve49LRCuWbh+GsmOVO3eo6jg=;
        b=ZZfkzOv/4YPMOYMgawXKBSUlbW7EbdwTJ8tRNcRdNKCS/YmNfjIABkrgqg980KDCv8
         WDb2Ok8MPq4mNHaH4a7xaBjOksorb2JPp3Gt3dzP5dUTd0BwknG5SDBX20GkMJqfZnni
         zIwOB56OQRO9LlFzdS47fjln2hfk0MhQFnKYzGRgVE2Pfd2RJ12beiL3Jhnb5RQKWm0Y
         fE+8aNVfQ8fyTQomddEcsEDBw8v9QfgXoFb1VxRsneDYTOVtggOQVgG+8E9gm2pLRVLD
         nvSMEwzsOjuLoQ/lNzmvvcNtAMII5w4GgNj0vgnvI/Y0nXspmv2/JBKKCIPhvnZtuTl5
         o6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693825210; x=1694430010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbCVRUoy/GXd5quDgH6ve49LRCuWbh+GsmOVO3eo6jg=;
        b=CvtS51SWKWj3Snf+fmc2MxrD5w9SiQCStbFYuPbrbbyA0sJ/ByILXMFDs26ALzcWOi
         10MRKgDAyaXE3rLCmobOd1KFRz0DW3m/rWFKZDrl5zw4tsARiG1Hg46lIbRoEUc6PDi0
         csvWFll5LOAlaGvUl2KJfBjs7PtFI6A0+6kzUE0DDyTf0LP8WOJU1lJD/h7rkG3xiZ5X
         lifhwVagAAdnBT9/8fIiEd9EnNZ8/pPgWRbhQV2Nu4vVLcaUXOmBTbtS18yMzTKaZ6uM
         tni8f9+zUYJJq5MCeKEjjUGuqsiW1vzgYYBNzCg3fnzJsnjNiDRVwqqynq+y9hgl2fRV
         IUNA==
X-Gm-Message-State: AOJu0YyhuznjRLatKNlnzC+u4brINnXRTqYeTz8sOn5sZ1xjdrBOI4vE
	6qntxFcS+c43XmZ+P5VkhoAasw==
X-Google-Smtp-Source: AGHT+IGbJMH+4JkNPUHzeVKwhpY0iCzNIgHQjAln2FO9qryNGRK7pF8QZ/dT3kD1yxy/Y2ijHNJRfg==
X-Received: by 2002:a7b:c851:0:b0:401:2ee0:7558 with SMTP id c17-20020a7bc851000000b004012ee07558mr7388381wml.32.1693825210421;
        Mon, 04 Sep 2023 04:00:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm13874083wmc.10.2023.09.04.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 04:00:09 -0700 (PDT)
Date: Mon, 4 Sep 2023 13:00:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <ZPW4uC6XkMXl0O2O@nanopsycho>
References: <20230902092007.3038132-1-william.xuanziyang@huawei.com>
 <ZPWwE9IYArI08Zsc@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPWwE9IYArI08Zsc@Laptop-X1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Sep 04, 2023 at 12:23:15PM CEST, liuhangbin@gmail.com wrote:
>Hi Ziyang,
>
>On Sat, Sep 02, 2023 at 05:20:07PM +0800, Ziyang Xuan wrote:
>> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
>> $ ip link add name t-dummy type dummy
>> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
>> $ ip link add name t-nlmon type nlmon
>> $ ip link set t-nlmon master team0
>> $ ip link set t-nlmon nomaster
>> $ ip link set t-dummy up
>> $ ip link set team0 up
>> $ ip link set t-dummy.100 down
>> $ ip link set t-dummy.100 master team0
>> 
>> When enslave a vlan device to team device and team device type is changed
>> from non-ether to ether, header_ops of team device is changed to
>> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
>> for vlan->real_dev in vlan_dev_hard_header() because team device is not
>> a vlan device.
>> 
>> Use ether_setup() for team device when its type is changed from non-ether
>> to ether to fix the bug.
>> 
>> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>>  drivers/net/team/team.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>> index d3dc22509ea5..560e04860aa7 100644
>> --- a/drivers/net/team/team.c
>> +++ b/drivers/net/team/team.c
>> @@ -2127,14 +2127,19 @@ static const struct ethtool_ops team_ethtool_ops = {
>>  static void team_setup_by_port(struct net_device *dev,
>>  			       struct net_device *port_dev)
>>  {
>> -	dev->header_ops	= port_dev->header_ops;
>> -	dev->type = port_dev->type;
>> -	dev->hard_header_len = port_dev->hard_header_len;
>> -	dev->needed_headroom = port_dev->needed_headroom;
>> -	dev->addr_len = port_dev->addr_len;
>> -	dev->mtu = port_dev->mtu;
>> -	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>> -	eth_hw_addr_inherit(dev, port_dev);
>> +	if (port_dev->type == ARPHRD_ETHER) {
>> +		ether_setup(dev);
>> +		eth_hw_addr_random(dev);
>> +	} else {
>> +		dev->header_ops	= port_dev->header_ops;
>> +		dev->type = port_dev->type;
>> +		dev->hard_header_len = port_dev->hard_header_len;
>> +		dev->needed_headroom = port_dev->needed_headroom;
>> +		dev->addr_len = port_dev->addr_len;
>> +		dev->mtu = port_dev->mtu;
>> +		memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>> +		eth_hw_addr_inherit(dev, port_dev);
>> +	}
>>  
>>  	if (port_dev->flags & IFF_POINTOPOINT) {
>>  		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
>
>Thanks for the report. This fix is similar with what I do in my PATCHv3 [1].
>And this will go back to the discussion of MTU update. How about just update
>the header_ops for ARPHRD_ETHER? e.g.
>
>	if (port_dev->type == ARPHRD_ETHER)
>		dev->header_ops	= &eth_header_ops;
>	else
>		dev->header_ops	= port_dev->header_ops;

Yes, this sounds better.


>
>[1] https://lore.kernel.org/netdev/20230718101741.2751799-3-liuhangbin@gmail.com/
>
>Thanks
>Hangbin

