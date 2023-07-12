Return-Path: <netdev+bounces-17020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB174FD6B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8998E1C20EF1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D9393;
	Wed, 12 Jul 2023 03:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A276819
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:06:56 +0000 (UTC)
Received: from mail2-1.quietfountain.com (mail2-1.quietfountain.com [64.111.48.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4BD171F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:06:55 -0700 (PDT)
Received: from mail2-1.quietfountain.com (localhost [127.0.0.1])
	by mail2-1.quietfountain.com (Postfix) with ESMTP id 4R12hZ2XKzzshQm
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:06:54 -0500 (CDT)
Authentication-Results: mail2-1.quietfountain.com (amavisd-new);
	dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
	header.d=quietfountain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	quietfountain.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:content-language:references:to:subject
	:from:user-agent:mime-version:date:message-id; s=dkim; t=
	1689131207; x=1691723208; bh=7+nTT8Nu27id2b+7loXoVaxJI+AUEv242+w
	/aMMjcKc=; b=WPVZpjfrw4xWq2w/lm1wsOJugTxZ7obLLKtSAOkgiovAk1MAbnv
	kgVMpmJ/s6aOs8LR+kWWl5teO3tx/c/aKaZVkN3Pt6suOccZ/DZGHFRrw0JLJmoO
	or2aziFcIPzJ4qCeBCKAV157LFLODzbjhaVaVpuVFpPLN71YImVS0ev4QPmXEwmo
	lumd/cgftL3kFA1CB5F+Kb5939+8KvEi4wFvGlv9Wt9Aplv5b41HUylphBhvXGTm
	sucUbWn5+57xmR64rDotQO3wV6kxyUTlY2ALaTQpHAVHVGpVh+Bj4l+KXHadHQKo
	4y2uCFgLKLfN+K3F7NpXmK+Z2geWeqyQaKjoqeL/5md9Ut0Xef1z0mmXvNrchnaz
	OXWiZLRsdX4c1nQPuvYu7u1RgwRC8yciKKKfK3KK2C4jKNLHRXwvuFKIqES7jkSV
	/WahcEeCzKj9R+ZN+HMb8io1TEu/3HeG/83N9iCBknfZxVZ+pTgpUGXd4nWC7gwu
	KovW3wjVlxifkp3dOO5/14799Pf1oSP3PusuTbqP1iAIie86ihsSYBVTyoOhbb/f
	4HSusD184MbYoXAMpzPTsMmVuwSkw1kK6cuRUq+u+na3T8FAz51LXB+te7CXnHpV
	HMkfcrNjMJbA4yrYKA70gShy4WDVjtUKojDf0dqJZ2C3/9gb0rfr8gqU=
X-Virus-Scanned: Debian amavisd-new at email2.1.quietfountain.com
Received: from mail2-1.quietfountain.com ([127.0.0.1])
	by mail2-1.quietfountain.com (mail2-1.quietfountain.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FmyN5PL8LtY8 for <netdev@vger.kernel.org>;
	Tue, 11 Jul 2023 22:06:47 -0500 (CDT)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from [10.12.114.193] (unknown [10.12.114.193])
	by mail2-1.quietfountain.com (Postfix) with ESMTPSA id 4R12hQ6DsVzsfvj;
	Tue, 11 Jul 2023 22:06:46 -0500 (CDT)
Message-ID: <83efdb0a-559e-edbd-a833-3891f04638ac@quietfountain.com>
Date: Tue, 11 Jul 2023 22:06:45 -0500
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
References: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
 <20230711215132.77594-1-kuniyu@amazon.com>
 <b01e5af6-e397-486d-3428-6fa30a919042@quietfountain.com>
 <de5a9b44-fd6d-466a-822b-334343713b9b@lunn.ch>
Content-Language: en-US
Organization: Quiet Fountain LLC / Rock Stable Systems
In-Reply-To: <de5a9b44-fd6d-466a-822b-334343713b9b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/11/23 19:55, Andrew Lunn wrote:
>> Something like that, but to your point about regression -- It a
>> statistically good bet there are many bridges with STP enabled in
>> non-default name spaces that simply have no loops in L2 BUT these are
>> 'buried'=C2=A0 inside docker images or prepackaged setups that work 'j=
ust fine
>> standalone' and also 'in lab namespaces (that just don't have L2 loops=
...)
>> and so that don't hit the bug.=C2=A0 These users are one "cable click =
to an open
>> port already connected somewhere they can't see" away from bringing do=
wn
>> every computer on their entire link (like me, been there, it's not a h=
appy
>> week for anyone...), they just don't know it.=C2=A0 And their vendors =
'trust STP,
>> so that can't be it' --- but it is.
>>
>> If the patch above gets installed-- then packagers downstream will hav=
e to
>> respond with effort to add code to turn off STP if finding themselves =
in a
>> namespace, and not if not.=C2=A0=C2=A0 They will be displeased at havi=
ng to
>> accommodate then de-accommodate when the fix lands.=C2=A0=C2=A0 As a '=
usually
>> downstream of the kernel' developer, I'd rather be warned than blocked=
.
> I don't know this code at all, so maybe a dumb question. What about
> user space STP and RSTP? Do they get to see BPDUs? If that works, we
> need to ensure any checking you add does not break that use case.
>
> 	Andrew

Andrew, the only RTSP / STP provider I know of is open-vswitch and their=20
docs (last I read them) provide the caution to use veth pairs to=20
namespaces, but not run their daemon there--- and fair enough as no=20
multicast llc would make it to that code in a namespace as currently=20
kernel implemented.

Like STP and namespaces in bridge code quite happily accepting commands=20
it fails to deliver (though it's properly a subject for another related=20
thread, you really have to read lots of fine print to notice the kernel=20
bridge code has both STP and vlan capability, but they do *not* play=20
well robustly though the system happily accepts configs like they do=20
(STP BPDUs appropriate to one vlan can go out untagged..)

Anyhow, to your point:=C2=A0 As zero multicast L2 packets make it to the=20
kernel protocols stacks, much less user space if they aren't in the=20
default net name space, this fix at most would allow packets they=20
presently expect, are documented to get, but somehow magically never=20
arrive -- to arrive.

Put more 'mathematically':=C2=A0 Neither the bug nor its fix will change=20
anything in the primary namespace, neither the bug nor its fix will=20
change packets that presently arrive in the non-default namespace to=20
behave other than as now they do.=C2=A0 The only change should be to caus=
e=20
multicast packets that ought to be delivered to listeners in the=20
non-default namespace to get them.

HTH

Harry Coin

Bettendorf, Iowa




--=20

