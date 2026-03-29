Return-Path: <netdev+bounces-272947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BFs+DjZfyWkpxwUAu9opvQ
	(envelope-from <netdev+bounces-272947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:19:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94578353419
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8DBD3003625
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E827FB1F;
	Sun, 29 Mar 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aWSgJcfZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA97238C1A
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804787; cv=none; b=LYj43cH+1g6ZBdhFbAaMSRNRmOF0nAuixWt3xr+8VmOUpSH9QsT0U7IPi4VjUE4Sc0QFoQJJhFwsBf1+Ipb4AeoaDU3YRWZN5kZSj0USFWgF5FVMJtgUhdzEgVafj26SDT9CKxhv5q8c/qHQi8WFtfU1XUr2U6ycBbb6sv6IQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804787; c=relaxed/simple;
	bh=THew2I/6lgdrWoFEhwPDc5LP+Qze6bEKsylxfoJbGbw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ivo4Zb5PaIj5uH/6EMYN+PijdEtQWyzJRTm9aFqg3JBK/QKxpQmiPPQPoJ2xufMlcO9mRbE4qJ/7ZgN/85OsS+RDZVxtv6vvvovUTQJAe/KbGU1mMSNoYDBrALqmtsDkwdwx33oGMa78Y8+p9eYox7nuwJ0nWF2onc+8iMQXp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aWSgJcfZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 29 Mar 2026 19:19:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774804783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzSyZqQJrUWbYFsucrshqRDh2sE68IPmRQSsos5xhLE=;
	b=aWSgJcfZzwDBq+lPTLsE0vhRXKr0j6FrNSLL4kl2X1FwFTga60yUuLnxhv42i4OrMvcAdb
	iw6W9+0QXC7uD389Jin0ncItopabB3L1QkU08L0yf9DLxfFe8iXVL42AKMnf0lKT1Yi02d
	7Q3LcizCs6RxNnBYeQe78FsTN2cW07E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Fernando Fernandez Mancera <ffmancera@riseup.net>, netdev@vger.kernel.org
CC: edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com,
 horms@kernel.org, lukma@denx.de, kuba@kernel.org, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_net-next=5D_net=3A_hsr=3A_sync_hw_add?=
 =?US-ASCII?Q?r_of_slave2_according_to_slave1_hw_addr_on_PRP?=
In-Reply-To: <856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
References: <20250409101911.3120-1-ffmancera@riseup.net> <DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev> <856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
Message-ID: <8FD7E7D2-A280-4105-AF25-EF82D3F3DD83@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272947-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,riseup.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94578353419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On March 29, 2026 6:58:38 PM GMT+02:00, Fernando Fernandez Mancera <fmancer=
a@suse=2Ede> wrote:
>On 3/29/26 5:07 PM, Luka Gejak wrote:
>> On Wed Apr 9, 2025 at 12:19 PM CEST, Fernando Fernandez Mancera wrote:
>>> In order to work properly PRP requires slave1 and slave2 to share the
>>> same MAC address=2E To ease the configuration process on userspace too=
ls,
>>> sync the slave2 MAC address with slave1=2E In addition, when deleting =
the
>>> port from the list, restore the original MAC address=2E
>>>=20
>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup=2Enet>
>>> ---
>>> v3: restore the original MAC address on slave removal=2E
>>> ---
>>>   net/hsr/hsr_device=2Ec | 5 +++++
>>>   net/hsr/hsr_main=2Ec   | 9 +++++++++
>>>   net/hsr/hsr_main=2Eh   | 1 +
>>>   net/hsr/hsr_slave=2Ec  | 2 ++
>>>   4 files changed, 17 insertions(+)
>>>=20
>>> diff --git a/net/hsr/hsr_device=2Ec b/net/hsr/hsr_device=2Ec
>>> index 439cfb7ad5d1=2E=2Ee8922e8d9398 100644
>>> --- a/net/hsr/hsr_device=2Ec
>>> +++ b/net/hsr/hsr_device=2Ec
>>> @@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, =
struct net_device *slave[2],
>>>   	if (res)
>>>   		goto err_unregister;
>>>   +	if (protocol_version =3D=3D PRP_V1) {
>>> +		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
>>> +		call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>>> +	}
>>> +
>>>   	if (interlink) {
>>>   		res =3D hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
>>>   		if (res)
>>> diff --git a/net/hsr/hsr_main=2Ec b/net/hsr/hsr_main=2Ec
>>> index d7ae32473c41=2E=2E192893c3f2ec 100644
>>> --- a/net/hsr/hsr_main=2Ec
>>> +++ b/net/hsr/hsr_main=2Ec
>>> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block =
*nb, unsigned long event,
>>>   			eth_hw_addr_set(master->dev, dev->dev_addr);
>>>   			call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>>   						 master->dev);
>>> +
>>> +			if (hsr->prot_version =3D=3D PRP_V1) {
>>> +				port =3D hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
>>> +				if (port) {
>>> +					eth_hw_addr_set(port->dev, dev->dev_addr);
>>> +					call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>> +								 port->dev);
>>> +				}
>>> +			}
>>>   		}
>>>     		/* Make sure we recognize frames from ourselves in hsr_rcv() */
>>> diff --git a/net/hsr/hsr_main=2Eh b/net/hsr/hsr_main=2Eh
>>> index 1bc47b17a296=2E=2E135ec5fce019 100644
>>> --- a/net/hsr/hsr_main=2Eh
>>> +++ b/net/hsr/hsr_main=2Eh
>>> @@ -155,6 +155,7 @@ struct hsr_port {
>>>   	struct hsr_priv		*hsr;
>>>   	enum hsr_port_type	type;
>>>   	struct rcu_head		rcu;
>>> +	unsigned char		original_macaddress[ETH_ALEN];
>>>   };
>>>     struct hsr_frame_info;
>>> diff --git a/net/hsr/hsr_slave=2Ec b/net/hsr/hsr_slave=2Ec
>>> index 2a802a5de2ac=2E=2Eb87b6a6fe070 100644
>>> --- a/net/hsr/hsr_slave=2Ec
>>> +++ b/net/hsr/hsr_slave=2Ec
>>> @@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_=
device *dev,
>>>   	port->hsr =3D hsr;
>>>   	port->dev =3D dev;
>>>   	port->type =3D type;
>>> +	ether_addr_copy(port->original_macaddress, dev->dev_addr);
>>>     	if (type !=3D HSR_PT_MASTER) {
>>>   		res =3D hsr_portdev_setup(hsr, dev, port, extack);
>>> @@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
>>>   		if (!port->hsr->fwd_offloaded)
>>>   			dev_set_promiscuity(port->dev, -1);
>>>   		netdev_upper_dev_unlink(port->dev, master->dev);
>>> +		eth_hw_addr_set(port->dev, port->original_macaddress);
>>>   	}
>>>     	kfree_rcu(port, rcu);
>>=20
>> Hi Fernando,
>>=20
>> Thanks for the patch=2E The logic to sync the slave2 MAC address with
>> slave1 for PRP is sound, but there are a few implementation issues here
>> that will cause hardware filtering problems and style violations=2E
>>=20
>> 1=2E Hardware MAC Filtering
>> In your current implementation:
>>=20
>>    if (protocol_version =3D=3D PRP_V1) {
>>=20
>>        eth_hw_addr_set(slave[1], slave[0]->dev_addr);
>>=20
>>        call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>>=20
>>    }
>>=20
>> eth_hw_addr_set() is appropriate for virtual devices (like the hsr_dev
>> itself), but slave[1] is a physical net_device=2E By using this helper,
>> you are bypassing dev->netdev_ops->ndo_set_mac_address=2E This means th=
e
>> physical NIC's hardware MAC filter will not be programmed, and it will
>> silently drop unicast traffic destined for the new PRP MAC address
>> unless the interface happens to be in promiscuous mode=2E You should us=
e
>> dev_set_mac_address() here instead=2E Note that unlike eth_hw_addr_set(=
),
>> dev_set_mac_address() can fail and returns an error code, so you will
>> need to check its return value and handle the error path accordingly=2E
>>=20
>> 2=2E Teardown Notifiers
>> In hsr_del_port():
>>=20
>>    netdev_upper_dev_unlink(port->dev, master->dev);
>>    eth_hw_addr_set(port->dev, port->original_macaddress);
>>=20
>> You have the same issue with eth_hw_addr_set() here=2E Additionally,
>> unlike the setup paths, this version omits call_netdevice_notifiers
>> (NETDEV_CHANGEADDR, port->dev)=2E Switching to dev_set_mac_address() fo=
r
>> the restoration will handle both the hardware programming and the
>> notifier chain automatically=2E
>>=20
>
>These points makes sense=2E I guess I didn't notice the that eth_hw_addr_=
set() due to my interface being set to promiscuous mode at hsr_slave=2Ec=2E
>
>Let me research a bit more about the impact here and will get back to you=
 either with a new patch or an reply here=2E
>
>> 3=2E Coding Style
>> In hsr_main=2Eh:
>>=20
>>    unsigned char original_macaddress[ETH_ALEN];
>>=20
>> Please use u8 instead of unsigned char for byte arrays to align with
>> standard netdev coding styles=2E
>>=20
>
>I used `unsigned char` because it was already used around HSR code alread=
y, so I chose consistency=2E If there is a preference for u8 over unsigned =
char I could change it=2E
>
>> Please address these points and submit a v4=2E
>>=20
>
>Well, this is almost a year old so I am sending a fix instead=2E Is this =
some kind of automated bot going through all the patches in netdev mailing =
list? I am a bit confused about receiving a patch review a year later=2E
>
>> Best regards,
>> Luka Gejak
>>=20
>

Hi Fernando,
I was setting up lei for the mailing list and because I didn't set it=20
up correctly, patches that were filtered and downloaded by lei were=20
older and I noticed it only later after carefully checking why patch=20
count was low=2E
Best regards,
Luka Gejak

