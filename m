Return-Path: <netdev+bounces-229594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC6ABDEC39
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25C544E1F49
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5220E00B;
	Wed, 15 Oct 2025 13:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F2200110
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535022; cv=none; b=RZp4CL0IekXk/LrKKSNQSiccgwux56/QBc6Eoa6Mo1N4TJJbqZlR1rCut1jusrK1gd/ktl1iBc3BiBg5yjYpUGlioGo57iGTV1lwKYyEiKQSZwQueikQ5mFswIGE0ht8l1nGhqxTU484IJaaIzGod2m/Wo8TWNpKAtpM9nyprbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535022; c=relaxed/simple;
	bh=5kr4CynRWs8NnUlJaLPnv24HH1xj837lJx6KhFVhzmM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jHEO9e+MKhfMamllC7oAHeVm/uZxD2VHLyHQVVDpcqbqG3v/FrdpEhZXY0OF/bzqoknAIYPdvT0etp//SiOMYR4W/8Js3InYVHdTNoo8ClnWUVFPyHu1sZQKdR4eeYaRzzQpLE26eSoBNjDASDzWpa1wehztp76duJCwVGXknCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz18t1760534958t943b810c
X-QQ-Originating-IP: tOkafuf8a5Rpz5FsvzFavqN0RPcOTLTIoVfamWtGpMM=
Received: from smtpclient.apple ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 21:29:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17336877705939878109
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [net-next v8 3/3] net: bonding: send peer notify when failure
 recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aO8WsjvT_kY_rL2v@fedora>
Date: Wed, 15 Oct 2025 21:29:03 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>,
 Antoine Tenart <atenart@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3BB6FFF9-7987-4FB0-B98F-B423C1A77B09@bamaicloud.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <3993652dc093fffa9504ce1c2448fb9dea31d2d2.1751031306.git.tonghao@bamaicloud.com>
 <aO8WsjvT_kY_rL2v@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OH2bKVRJtexUrVWDchlr7xv87Qhgy5Ui0F33ECsVkGMwfTIiua0V7j/s
	W/UHbWkQo2z5E14j8Opsxp6JJhbnWQ9tvqW02nnUy+T3ycKXlTdZviIgI8lXuMUD19cI7VL
	5eSNVYEH436sGt/CHDCQnSl1JgvUvE52W+m1f2alIP0X2SQG1m20sKWeepP/rQV/ISscVb5
	fcI6yJXY12jdB9e3wD5jdu59AWbHnDmFDdcbadVco/SpytliGJJUZlt+47X5zF2ZYNeX7R4
	pcpndGRdEmMr3gSDgb3UFP2ipeyBWvJjamvJ+yYzdegqN+qDEpk9pGUaMySLhPMzOR8atR8
	f0UIh4CwyC2CgVB6KmdYtRB3w6+PzpyhR513EywjaYXhokhBiQkCxspI6AlDMU35axvNkYJ
	7iVIEU7sMuFll06AsGjDOQ9Z93OVyt4Vchh6BtnrZRwuj1N1t2ovkDs79wZV0NSY86POo28
	fiJ+DP+hPSvFBDzaVYTs2taI8YvICSFHtVcYB6xFc/M7vxoz0vuiWa2DES4wCOwbEwALzDb
	8fdVMLzzjWC5cSmkYmUX7X17c81obcV0un4Ejjjp1G3N4jPJ4bnsIFhlpwRLHaHzdnlZec5
	6NXT60kKt4VFLiViVzw0Ho/RC+fvWVJSZ2Obq6fL6RmPnRMs6C510sjcfbdn216EOh6q2Bd
	HK8TNzGErjToTCiJzHItyd3KiCpebE1i1trPxj6iG2Bo/7KYeFKFDCQYClEDlst4D2cdep9
	CTrm50MDJdM6/dFUR0gpxWqQZtbsDknU1YkpoiUH0IX0PGg/CvTwrrfGoqOk0jvs89LGvMV
	oPyADVtquUdT+PJk6nCkOoVBN5pw7V+tjksvf2fx4FFLV2xjoU/VoYGyTBmje0Pdg6lf55b
	i2t2Zl7SQFfXXohdove7z/+P2o8O6UONd5Ht0NRRlIUvPQiVT1/ujMfqMHoJw7wXNQwlxtu
	yp/DvSbnQGuu2ZuQlRcMsgV2k8LpkRc05/wVyzsZbigM5GIen95afgIn6oEMjeRnCmNk=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0



> On Oct 15, 2025, at 11:36, Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> On Fri, Jun 27, 2025 at 09:49:30PM +0800, Tonghao Zhang wrote:
>> +static void ad_cond_set_peer_notif(struct port *port)
>> +{
>> + struct bonding *bond = port->slave->bond;
>> +
>> + if (bond->params.broadcast_neighbor && rtnl_trylock()) {
> 
> Hi Tonghao,
> 
> When do our internal review, Antoine pointed that this rtnl_trylock() may
> fail and cause the notify not send. The other places of bonding using
> workqueues to reschedule when the rtnl_trylock() failed. Do you think
> if we should also do some similar thing to avoid notify failed?
This is indeed a good optimization. I will submit the patch later.
> 
> Thanks
> Hangbin
>> + bond->send_peer_notif = bond->params.num_peer_notif *
>> + max(1, bond->params.peer_notif_delay);
>> + rtnl_unlock();
>> + }
>> +}
> 
> 


