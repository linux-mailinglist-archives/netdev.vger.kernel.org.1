Return-Path: <netdev+bounces-17596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE957752435
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9272281DC4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100515490;
	Thu, 13 Jul 2023 13:51:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AB747E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:51:28 +0000 (UTC)
Received: from mail2-1.quietfountain.com (mail2-1.quietfountain.com [64.111.48.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0991BF4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:51:25 -0700 (PDT)
Received: from mail2-1.quietfountain.com (localhost [127.0.0.1])
	by mail2-1.quietfountain.com (Postfix) with ESMTP id 4R1wxl56xhzshQy
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:51:23 -0500 (CDT)
Authentication-Results: mail2-1.quietfountain.com (amavisd-new);
	dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
	header.d=quietfountain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	quietfountain.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1689256276; x=1691848277; bh=t3KoUQ576nwgQDgQyh6XtUiiZCI2C4INCDa
	FAm36//8=; b=gkFQci5JzMnJYZTa4VVrEO32X+ZMlFK51nry/4fbXhRWssz41eM
	1l0DswKdHoLjU5W04x3MHHfssXAGF9iztUPPpCL3vmNHPQykc/ZKJMkYuUSqftQK
	i14lgrWvBQlvNx6ywf2eMkDIZU2FcRPHq8NrA3A9HyFvwYYYO25rTk30bHwzCeY2
	nzk8LcAe8mTBvxwYVoKkh4TzXxDY3K5Q73nJp/lblyP7X3qM+X6d0lzMjV1AmQMX
	MOeo8a7RKDltEw6sanQWN7b19bYEARl7n9dBohcXVvKADiwizkbkxT7I3mf5D7Tl
	KWGd2tcOr4fJ5UbpfgGH5Kkst7AtLl8ViVON/Gy3QG6miCQzcw+Pc6h9kH2cvhL5
	9snIlsX3iqI7CiSclU1E5x2geECUuUplhoMgpjzMmr5EOmSA+4jOuH5lut/37Ip2
	EbQCQv3FszoY1Nsi/o6uslTFwdhWKIsH7D0N3Y2akqep0L5QpcAcm36fcC3Gfcq1
	+59q8b8VOAYUcbaT5TuwM3AEcLzm1PG3/m6a+WIyEFRqHm5RvYSmo6gsOv2lS098
	LjJSouSP/TZP578p5WcNxnq3/R3ogisir+7KFWzFNaK7wEBZKQFjTBN1Rwm7XOSK
	zh2pxrJikDd+tTOKYCLBW4J67f1Am7AO7yZl0FC4dgyLOPqHe77QDK60=
X-Virus-Scanned: Debian amavisd-new at email2.1.quietfountain.com
Received: from mail2-1.quietfountain.com ([127.0.0.1])
	by mail2-1.quietfountain.com (mail2-1.quietfountain.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vwJFlvjCiYl5 for <netdev@vger.kernel.org>;
	Thu, 13 Jul 2023 08:51:16 -0500 (CDT)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from [10.12.114.193] (unknown [10.12.114.193])
	by mail2-1.quietfountain.com (Postfix) with ESMTPSA id 4R1wxC6C8lzsfvj;
	Thu, 13 Jul 2023 08:50:55 -0500 (CDT)
Message-ID: <f4f1b9b4-abc9-842a-205a-35588916115d@quietfountain.com>
Date: Thu, 13 Jul 2023 08:50:44 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 net] bridge: Return an error when enabling STP in
 netns.
Content-Language: en-US
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20230711235415.92166-1-kuniyu@amazon.com>
 <ZK69NDM60+N0TTFh@shredder>
 <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
From: Harry Coin <hcoin@quietfountain.com>
Organization: Quiet Fountain LLC / Rock Stable Systems
In-Reply-To: <caf5bc87-0b5f-cd44-3c1c-5842549c8c6e@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/12/23 09:52, Nikolay Aleksandrov wrote:
> On 12/07/2023 17:48, Ido Schimmel wrote:
>> On Tue, Jul 11, 2023 at 04:54:15PM -0700, Kuniyuki Iwashima wrote:
>>> When we create an L2 loop on a bridge in netns, we will see packets s=
torm
>>> even if STP is enabled.
>>>
>>>    # unshare -n
>>>    # ip link add br0 type bridge
>>>    # ip link add veth0 type veth peer name veth1
>>>    # ip link set veth0 master br0 up
>>>    # ip link set veth1 master br0 up
>>>    # ip link set br0 type bridge stp_state 1
>>>    # ip link set br0 up
>>>    # sleep 30
>>>    # ip -s link show br0
>>>    2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue s=
tate UP mode DEFAULT group default qlen 1000
>>>        link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>>>        RX: bytes  packets  errors  dropped missed  mcast
>>>        956553768  12861249 0       0       0       12861249  <-. Keep
>>>        TX: bytes  packets  errors  dropped carrier collsns     |  inc=
reasing
>>>        1027834    11951    0       0       0       0         <-'   ra=
pidly
>>>
>>> This is because llc_rcv() drops all packets in non-root netns and BPD=
U
>>> is dropped.
>>>
>>> Let's show an error when enabling STP in netns.
>>>
>>>    # unshare -n
>>>    # ip link add br0 type bridge
>>>    # ip link set br0 type bridge stp_state 1
>>>    Error: bridge: STP can't be enabled in non-root netns.
>>>
>>> Note this commit will be reverted later when we namespacify the whole=
 LLC
>>> infra.
>>>
>>> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace =
safe")
>>> Suggested-by: Harry Coin <hcoin@quietfountain.com>
>> I'm not sure that's accurate. I read his response in the link below an=
d
>> he says "I'd rather be warned than blocked" and "But better warned and
>> awaiting a fix than blocked", which I agree with. The patch has the
>> potential to cause a lot of regressions, but without actually fixing t=
he
>> problem.
>>
>> How about simply removing the error [1]? Since iproute2 commit
>> 844c37b42373 ("libnetlink: Handle extack messages for non-error case")=
,
>> it can print extack warnings and not only errors. With the diff below:
>>
>>   # unshare -n
>>   # ip link add name br0 type bridge
>>   # ip link set dev br0 type bridge stp_state 1
>>   Warning: bridge: STP can't be enabled in non-root netns.
>>   # echo $?
>>   0
>>
>> [1]
>> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
>> index a807996ac56b..b5143de37938 100644
>> --- a/net/bridge/br_stp_if.c
>> +++ b/net/bridge/br_stp_if.c
>> @@ -201,10 +201,8 @@ int br_stp_set_enabled(struct net_bridge *br, uns=
igned long val,
>>   {
>>          ASSERT_RTNL();
>>  =20
>> -       if (!net_eq(dev_net(br->dev), &init_net)) {
>> +       if (!net_eq(dev_net(br->dev), &init_net))
>>                  NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in n=
on-root netns");
>> -               return -EINVAL;
>> -       }
>>  =20
>>          if (br_mrp_enabled(br)) {
>>                  NL_SET_ERR_MSG_MOD(extack,
>>
> I'd prefer this approach to changing user-visible behaviour and potenti=
al regressions.
> Just change the warning message.
>
> Thanks,
>   Nik

Remember, the only way it's honest to 'warn but not block' STP in netns=20
is trust in the Kuniyuki's assertion that the llc will be=20
'namespacified' in a near term frame.=C2=A0=C2=A0 As STP is not only=20
non-functional in a netns, but will in fact bring down every connected=20
system in a packet storm should a L2 loop exist the situation is much=20
worse than a merely inaccessible extra feature. This as the only reason=20
STP exists is to avoid crashing sites owing to packet storms arising=20
from L2 loops.=C2=A0=C2=A0=C2=A0 I think as this bug is a potential 'site=
 killer'=20
(which in fact happened to me!) The Linux dev community has an=20
obligation to either hard block this or commit to a fix time frame and=20
merely warn.

Thanks

Harry Coin



