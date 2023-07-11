Return-Path: <netdev+bounces-16976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8F774FB26
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5932814A4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963019BD3;
	Tue, 11 Jul 2023 22:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D81426B
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:44:31 +0000 (UTC)
Received: from mail1-1.quietfountain.com (mail1-1.quietfountain.com [192.190.136.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E739E5F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 15:44:29 -0700 (PDT)
Received: from mail1-1.quietfountain.com (localhost [127.0.0.1])
	by mail1-1.quietfountain.com (Postfix) with ESMTP id 4R0wsl5CFtz5FLVJ
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:44:27 -0500 (CDT)
Authentication-Results: mail1-1.quietfountain.com (amavisd-new);
	dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
	header.d=quietfountain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	quietfountain.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:content-language:references:to:subject
	:from:user-agent:mime-version:date:message-id; s=dkim; t=
	1689115465; x=1691707466; bh=GO796Ee63G0NMnPgtogogiR0WdHhf9k4Vfl
	cbO760mI=; b=Tjn0taUXAyk+QeticWou5efIHwNmmtq7yoV5Zb/K4kmp4HNunrc
	OIAmXUPUuOQvbND9qB744wU4jYQpq0/bS1aPdgMOO4DS2PiafUQDYpzOKFfl3WOo
	6lg4Ab8sVQ11GR1aNEjpwsE/3xlAR//f9KlQHNwj+ebnmjEzyDUUOHc0IVeX+ksV
	eurd+XieyGeh8tchPNhCIOsMvf1gHnOoUYr/XUhoEnHkRaQg3U2VO/RHQcQgFwrj
	MxOeyajAl/Sl4AKMzt5s9M0ifFm2VB8NPnENgULBQcoCSTEP9Hd3bZFEGc27cPwX
	eXXc8hmusWZl1icAPZxXYROyh23nr1vhgAvvGD1zhRPDKoe1MHQYLiXm9dT7mBpG
	BJKNvgJq3DVxVgKBn+ZQl8NexW0E6hQC2RhNHHHzuxq1II2LFIZEh9uUNWa2VF7x
	MuLr7oTN5AMleZjOHwLF8D+zgaAqkqAty9ikppae+khZC2rUsMOiGMOBHFgZr081
	zIUob4A9b+1PzCt8rUrageBZXrMNnRzu3DaYKFkob87e2j9nhFWJX3sWHjFtMWCc
	rU3JpsJXxqPhMp/Mth9F5VUmpbNQ9RkxQOEUmwUtFmiEVIXs+Kb0cYFs9Lfk8B5n
	cq24qkXBZiTrmGVZZdDGBcKhYIGL+U1HsGNVeW5NBY6cZkSX5pSnygu4=
X-Virus-Scanned: Debian amavisd-new at email1.1.quietfountain.com
Received: from mail1-1.quietfountain.com ([127.0.0.1])
	by mail1-1.quietfountain.com (mail1-1.quietfountain.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nfOYIFBcDidk for <netdev@vger.kernel.org>;
	Tue, 11 Jul 2023 17:44:25 -0500 (CDT)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from [10.12.114.193] (versa.1.quietfountain.com [10.12.114.193])
	by mail1-1.quietfountain.com (Postfix) with ESMTPSA id 4R0wsh6b6Bz5Ddtf;
	Tue, 11 Jul 2023 17:44:24 -0500 (CDT)
Message-ID: <0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com>
Date: Tue, 11 Jul 2023 17:44:20 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Harry Coin <hcoin@quietfountain.com>
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if
 bridge in non-default namespace.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org
References: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
 <20230711215132.77594-1-kuniyu@amazon.com>
Content-Language: en-US
Organization: Quiet Fountain LLC / Rock Stable Systems
In-Reply-To: <20230711215132.77594-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/11/23 16:51, Kuniyuki Iwashima wrote:
> From: Harry Coin<hcoin@quietfountain.com>
> Date: Tue, 11 Jul 2023 16:40:03 -0500
>> On 7/11/23 15:44, Andrew Lunn wrote:
>>>>>>>> The current llc_rcv.c around line 166 in net/llc/llc_input.c  ha=
s
>>>>>>>>
>>>>>>>>             if (!net_eq(dev_net(dev), &init_net))
>>>>>>>>                     goto drop;
>>>>>>>>
>>>> Thank you!  When you offer your patches, and you hear worries about =
being
>>>> 'invasive', it's worth asking 'compared to what' -- since the 'statu=
s quo'
>>>> is every bridge with STP in a non default namespace with a loop in i=
t
>>>> somewhere will freeze every connected system more solid than ice in
>>>> Antarctica.
>>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
>>>
>>> say:
>>>
>>> o It must be obviously correct and tested.
>>> o It cannot be bigger than 100 lines, with context.
>>> o It must fix only one thing.
>>> o It must fix a real bug that bothers people (not a, "This could be a=
 problem..." type thing).
>>>
>>> git blame shows:
>>>
>>> commit 721499e8931c5732202481ae24f2dfbf9910f129
>>> Author: YOSHIFUJI Hideaki<yoshfuji@linux-ipv6.org>
>>> Date:   Sat Jul 19 22:34:43 2008 -0700
>>>
>>>       netns: Use net_eq() to compare net-namespaces for optimization.
>>>
>>> diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
>>> index 1c45f172991e..57ad974e4d94 100644
>>> --- a/net/llc/llc_input.c
>>> +++ b/net/llc/llc_input.c
>>> @@ -150,7 +150,7 @@ int llc_rcv(struct sk_buff *skb, struct net_devic=
e *dev,
>>>           int (*rcv)(struct sk_buff *, struct net_device *,
>>>                      struct packet_type *, struct net_device *);
>>>   =20
>>> -       if (dev_net(dev) !=3D &init_net)
>>> +       if (!net_eq(dev_net(dev), &init_net))
>>>                   goto drop;
>>>   =20
>>>           /*
>>>
>>> So this is just an optimization.
>>>
>>> The test itself was added in
>>>
>>> ommit e730c15519d09ea528b4d2f1103681fa5937c0e6
>>> Author: Eric W. Biederman<ebiederm@xmission.com>
>>> Date:   Mon Sep 17 11:53:39 2007 -0700
>>>
>>>       [NET]: Make packet reception network namespace safe
>>>      =20
>>>       This patch modifies every packet receive function
>>>       registered with dev_add_pack() to drop packets if they
>>>       are not from the initial network namespace.
>>>      =20
>>>       This should ensure that the various network stacks do
>>>       not receive packets in a anything but the initial network
>>>       namespace until the code has been converted and is ready
>>>       for them.
>>>      =20
>>>       Signed-off-by: Eric W. Biederman<ebiederm@xmission.com>
>>>       Signed-off-by: David S. Miller<davem@davemloft.net>
>>>
>>> So that was over 15 years ago.
>>>
>>> It appears it has not bothered people for over 15 years.
>>>
>>> Lets wait until we get to see the actual fix. We can then decide how
>>> simple/hard it is to back port to stable, if it fulfils the stable
>>> rules or not.
>>>
>>>         Andrew
>> Andrew, fair enough.  In the time until it's fixed, the kernel folks
>> should publish an advisory and block any attempt to set bridge stp sta=
te
>> to other than 0 if in a non-default namespace. The alternative is a
>> packet flood at whatever the top line speed is should there be a loop
>> somewhere in even one connected link.
> Like this ?  Someone who didn't notice the issue might complain about
> it as regression.
>
> ---8<---
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..a807996ac56b 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsi=
gned long val,
>   {
>   	ASSERT_RTNL();
>  =20
> +	if (!net_eq(dev_net(br->dev), &init_net)) {
> +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns")=
;
> +		return -EINVAL;
> +	}
> +
>   	if (br_mrp_enabled(br)) {
>   		NL_SET_ERR_MSG_MOD(extack,
>   				   "STP can't be enabled if MRP is already enabled");
> ---8<---

Something like that, but to your point about regression -- It a=20
statistically good bet there are many bridges with STP enabled in=20
non-default name spaces that simply have no loops in L2 BUT these are=20
'buried'=C2=A0 inside docker images or prepackaged setups that work 'just=
=20
fine standalone' and also 'in lab namespaces (that just don't have L2=20
loops...) and so that don't hit the bug.=C2=A0 These users are one "cable=
=20
click to an open port already connected somewhere they can't see" away=20
from bringing down every computer on their entire link (like me, been=20
there, it's not a happy week for anyone...), they just don't know it.=C2=A0=
=20
And their vendors 'trust STP, so that can't be it' --- but it is.

If the patch above gets installed-- then packagers downstream will have=20
to respond with effort to add code to turn off STP if finding themselves=20
in a namespace, and not if not.=C2=A0=C2=A0 They will be displeased at ha=
ving to=20
accommodate then de-accommodate when the fix lands.=C2=A0=C2=A0 As a 'usu=
ally=20
downstream of the kernel' developer, I'd rather be warned than blocked.

Looking at those dates... wow!=C2=A0 I expect other os kernels and standa=
lone=20
switch vendors would see fixing this one as a removing a reliability=20
advantage they've had for a long time.

Perhaps a broadcast advisory "Until this is fixed, your site will have a=20
packet flood worse than an internal DDOS attack if there's a loop in a=20
link layer and if even one docker image or prepackaged project uses a=20
net bridge with STP enabled and is deployed in a non-default netns / net=20
namespace.=C2=A0=C2=A0 Check with your package vendors if you're not sure=
.=C2=A0 You'll=20
avoid this problem if your link layer layout chart is tree-and-branch=20
without even one crosslink."=C2=A0=C2=A0 Yup, that'll be somewhat less th=
an=20
popular.=C2=A0 But better warned and awaiting a fix than blocked.

How hard can the fix be?=C2=A0 Instead of dropping the packet if in the=20
non-default namespace, as each device is in a namespace it should be=20
fine to pass the packet only to listeners in the same namespace as the=20
device that received the packet.=C2=A0 Back in the day this code was writ=
ten,=20
it was probably 'hard to know' among the multicast subscribers what=20
namespace they were in.

 =C2=A0I suspect the impact of this fix on existing code will be minor si=
nce=20
the only effect will be packets appearing where they were expected=20
before but not received.

Harry



--=20

