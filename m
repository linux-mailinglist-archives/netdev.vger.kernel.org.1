Return-Path: <netdev+bounces-190312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E692AB62BF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4233BF1F1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C802F1F873B;
	Wed, 14 May 2025 06:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C81EFFAC
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202934; cv=none; b=l27lrHegCWZJLLOPuJHTKUv7F+xr+ylJevOJ/JfAGoR0RfLRmcP4maWfqltDdSrqNOkijrkMUKaOZOW0KJsQGi2E3QC0/a5wKgrv9ZTvabatLU0uTftnYcx4YM4ZU7aQAFQkEdttmtNbO9JzNFx9Sd9oEtXYWLhDOtV5GlPmbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202934; c=relaxed/simple;
	bh=cXCWmoPqOz+ul1ic01G2ZwbW5JMZ+N4uPkxOwwnZj8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p3x1z1IYBqF7FcVCKkyM1PM9ATDPwuDIASdtsrxd3iOo0RdfGOLQcMWrsyD/zJEV9tISpW01glOXAoLKpq/Vft0upkoa/DK/4G42eJupvNRmBsHB+zRiEDnxxCdUDkuWFytN3Knb9WsX4hNgnSIUG5xCEwHDx47wtfX9900ECfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1747202844tbab03782
X-QQ-Originating-IP: FUcXABbwcBEPcri8N786tPS3VUiQykNZ0B3z18Mm4UY=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 14:07:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3308077420364301411
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v2 1/4] net: bonding: add broadcast_neighbor
 option for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <1319073.1747143053@vermin>
Date: Wed, 14 May 2025 14:07:11 +0800
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <84F74587-5EEB-4D02-B49E-CDE65D963E3F@bamaicloud.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
 <4270C010E5516F3B+20250513094750.23387-2-tonghao@bamaicloud.com>
 <f690dc4a-fde8-411d-84d8-67980555f479@blackwall.org>
 <191F1618-E561-4B82-84E3-1E19E22197F3@bamaicloud.com>
 <d0e0379e-79fb-4a95-b160-6c1ca4276081@blackwall.org>
 <1319073.1747143053@vermin>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M0wYV6TTeeWi2qbzpw6ZTI0gTcJmhYcRT+AW1sGyUJYyJdvXTbx3AWTb
	x12XMcTj16qasX/tF0LCF1/06Uw0liVv0QGD6boUmmFwuWjiiuZWyZl3Xj8H7AUOm4H7v/a
	ecWYCr3CiToGXOxdge+C5KnrCZFoM+K5b8SFv3oQSSMkaXglbsGZGzhNsnRGbwWiSsh2wzb
	OJNd9ft0UOWja0jp1+pJWVAnuYjbraPje9h/yiLS5ppWoPMo62/q5derWoT0Rl3S8cZjfi0
	jhrolEl+u+HuDX9scGnVBFFgY1UeHhXA8S4/Hvkm55abweZXHPFynzLISnCR5F/Gq12GudJ
	HjX93oMq+E/1+w1+XQ5GUkJWBzVBf5XUGxk2Gat+28mFpM6oXX0BwV+mfAP+coUt2tiMrQr
	43eUSxO9k2lQO00RwEn0yQPBCnn0EsUAXdUJQ9MbUtqR2R6532vXZlPYMtiCgOMvNMWHbeS
	iP5mb0Yc9j27d7CRjGBoz8WbdnKdcELSt8a2lkhRWDXuWD/Mx42n60SUo11QP6mV3tPutFg
	+QAHTQuPIww2wqzyobekkExaOyw+xthAZkyPzNsdLXIf/dYTU4cANaJu9xRH9W0YJ83Kn0N
	GMEOyVQyIw7k1cUFbQfjcgQeM1qiia++/4UpedgsLFVYQ4fo3M0CBkY39MvQrmpkWXeEuPt
	f+fSDNOTt/XeHV/HXoyeJBURLxcYp2vy9rNxZ7PpeCLwspruoxP64wuLnMvXL34Vk6bus6h
	sXwGLPqUOwEeqC3RxoucD4oKBzXbgAlyxJuwY0WkJmJ+MClcxeodBwIap6Q0WKqdSVq0oWd
	TeCmiiIUm4tgzf2J3v0bulg8uiemu+EVkZnMom3kxnCJz5vPhNUcAj56q1xCQg0Y6V+wnOm
	S0YzE1gi1N70BtwGzw1lHTmd2zLP44/kDoK94/R1uPJq0Axu+wBDIlVR/TfhkDq8QUMAAp+
	QC7tzPgxVT7ImvzcLwBqR5qoVY46MlgGL1iFsRGCj/KoB8d0gHfeUI/lv
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8813=E6=97=A5 21:30=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Nikolay Aleksandrov <razor@blackwall.org> wrote:
>=20
>> On 5/13/25 15:13, Tonghao Zhang wrote:
>>>=20
>>>=20
>>>> 2025=E5=B9=B45=E6=9C=8813=E6=97=A5 18:18=EF=BC=8CNikolay =
Aleksandrov <razor@blackwall.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>> On 5/13/25 12:47, Tonghao Zhang wrote:
>>>>> Stacking technology is a type of technology used to expand ports =
on
>>>>> Ethernet switches. It is widely used as a common access method in
>>>>> large-scale Internet data center architectures. Years of practice
>>>>> have proved that stacking technology has advantages and =
disadvantages
>>>>> in high-reliability network architecture scenarios. For instance,
>>>>> in stacking networking arch, conventional switch system upgrades
>>>>> require multiple stacked devices to restart at the same time.
>>>>> Therefore, it is inevitable that the business will be interrupted
>>>>> for a while. It is for this reason that "no-stacking" in data =
centers
>>>>> has become a trend. Additionally, when the stacking link =
connecting
>>>>> the switches fails or is abnormal, the stack will split. Although =
it is
>>>>> not common, it still happens in actual operation. The problem is =
that
>>>>> after the split, it is equivalent to two switches with the same =
configuration
>>>>> appearing in the network, causing network configuration conflicts =
and
>>>>> ultimately interrupting the services carried by the stacking =
system.
>>>>>=20
>>>>> To improve network stability, "non-stacking" solutions have been =
increasingly
>>>>> adopted, particularly by public cloud providers and tech companies
>>>>> like Alibaba, Tencent, and Didi. "non-stacking" is a method of =
mimicing switch
>>>>> stacking that convinces a LACP peer, bonding in this case, =
connected to a set of
>>>>> "non-stacked" switches that all of its ports are connected to a =
single
>>>>> switch (i.e., LACP aggregator), as if those switches were stacked. =
This
>>>>> enables the LACP peer's ports to aggregate together, and requires =
(a)
>>>>> special switch configuration, described in the linked article, and =
(b)
>>>>> modifications to the bonding 802.3ad (LACP) mode to send all ARP / =
ND
>>>>> packets across all ports of the active aggregator.
>>>>>=20
>>>>> -----------     -----------
>>>>> |  switch1  |   |  switch2  |
>>>>> -----------     -----------
>>>>>        ^           ^
>>>>>        |           |
>>>>>       ---------------
>>>>>      |   bond4 lacp  |
>>>>>       ---------------
>>>>>        | NIC1      | NIC2
>>>>>    ---------------------
>>>>>   |       server        |
>>>>>    ---------------------
>>>>>=20
>>>>> - =
https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-net=
work-architecture/
>>>>>=20
>>>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>> Cc: Simon Horman <horms@kernel.org>
>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>>>> ---
>>>>> Documentation/networking/bonding.rst |  6 +++++
>>>>> drivers/net/bonding/bond_main.c      | 39 =
++++++++++++++++++++++++++++
>>>>> drivers/net/bonding/bond_options.c   | 34 ++++++++++++++++++++++++
>>>>> drivers/net/bonding/bond_sysfs.c     | 18 +++++++++++++
>>>>> include/net/bond_options.h           |  1 +
>>>>> include/net/bonding.h                |  3 +++
>>>>> 6 files changed, 101 insertions(+)
>>>>>=20
>>>>> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
>>>>> index a4c1291d2561..14f7593d888d 100644
>>>>> --- a/Documentation/networking/bonding.rst
>>>>> +++ b/Documentation/networking/bonding.rst
>>>>> @@ -562,6 +562,12 @@ lacp_rate
>>>>>=20
>>>>> The default is slow.
>>>>>=20
>>>>> +broadcast_neighbor
>>>>> +
>>>>> + Option specifying whether to broadcast ARP/ND packets to all
>>>>> + active slaves.  This option has no effect in modes other than
>>>>> + 802.3ad mode.  The default is off (0).
>>>>> +
>>>>> max_bonds
>>>>>=20
>>>>> Specifies the number of bonding devices to create for this
>>>>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>>>>> index d05226484c64..8ee26ddddbc8 100644
>>>>> --- a/drivers/net/bonding/bond_main.c
>>>>> +++ b/drivers/net/bonding/bond_main.c
>>>>> @@ -212,6 +212,9 @@ atomic_t netpoll_block_tx =3D ATOMIC_INIT(0);
>>>>>=20
>>>>> unsigned int bond_net_id __read_mostly;
>>>>>=20
>>>>> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>>>> +EXPORT_SYMBOL_GPL(bond_bcast_neigh_enabled);
>>>>=20
>>>> No need to export the symbol, you can add bond helpers to inc/dec =
it.
>=20
> Agreed.
>=20
>>>>> +
>>>>> static const struct flow_dissector_key flow_keys_bonding_keys[] =3D =
{
>>>>> {
>>>>> .key_id =3D FLOW_DISSECTOR_KEY_CONTROL,
>>>>> @@ -4480,6 +4483,9 @@ static int bond_close(struct net_device =
*bond_dev)
>>>>> bond_alb_deinitialize(bond);
>>>>> bond->recv_probe =3D NULL;
>>>>>=20
>>>>> + if (bond->params.broadcast_neighbor)
>>>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>>>> +
>>>>=20
>>>> This branch doesn't get re-enabled if the bond is brought up =
afterwards.
>>> This is not right place to dec bond_bcast_neigh_enabled, I should =
dec this value in bond_uninit(). Because we can destroy a bond net =
device which broadcast_neighbor enabled.
>>> If we don=E2=80=99t check broadcast_neighbor in destroy path. =
bond_bcast_neigh_enabled always is enabled. For example:
>>> ip link add bondx type bond mode 802.3ad ... broadcast_neighbor on
>>> ip link add bondy type bond mode 802.3ad ... broadcast_neighbor off
>>>=20
>>> ip li del dev bondx
>>> In this case, bond_bcast_neigh_enabled is enabled for bondy while =
broadcast_neighbor is off.
>=20
> So it sounds like the flow should be:
>=20
> - increment the static key when:
> - option enabled on IFF_UP bond (transition from off to on)
> - bond set to up with option enabled (bond_open)
>=20
> - decrement the static key when:
> - option disabled on IFF_UP bond (transition from on to off)
> - bond with option enabled is set to down (bond_close)
>=20
> The unregister path in unregister_netdevice_many_notify that
> calls bond_uninit will call dev_close before the ndo_uninit, so I =
don't
> think we need to handle the static key in bond_uninit separately.
Thanks Jay,  updated in v3
>=20
>=20
>>>>>>> if (bond_uses_primary(bond)) {
>>>>> rcu_read_lock();
>>>>> slave =3D rcu_dereference(bond->curr_active_slave);
>>>>> @@ -5316,6 +5322,35 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>>>>> return slaves->arr[hash % count];
>>>>> }
>>>>>=20
>>>>> +static inline bool bond_should_broadcast_neighbor(struct sk_buff =
*skb,
>>>>=20
>>>> don't use inline in .c files
>>> As suggested by Jay, inline the codes for performance. I think it is =
better to keep inline. By the way, there are many inline function in =
bond_main.c and other *.c
>>=20
>> This is a general rule, the compiler knows what to do. The inlines in =
bond_main are old
>> and can be removed. Do not add new ones.
>=20
> To clarify, the intent of my question was to ask whether or not
> the compiler was inlining the existing code in Tonghao's earlier =
patch.
> I did not intend to suggest that an explicit inline should be added.
>=20
> That said, I agree with Nikolay in that inline should not be
> added explicitly.
Ok
>=20
>>>>> +  struct net_device *dev)
>>>>> +{
>>>>> + struct bonding *bond =3D netdev_priv(dev);
>>>>> +
>>>>> + if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>>>>> + return false;
>>>>> +
>>>>> + if (!bond->params.broadcast_neighbor)
>>>>> + return false;
>>>>> +
>>>>> + if (skb->protocol =3D=3D htons(ETH_P_ARP))
>>>>> + return true;
>>>>> +
>>>>> + if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>>>>> +    pskb_may_pull(skb,
>>>>> +  sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
>>>>> + if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>>>>> + struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>>>>> +
>>>>> + if ((icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION) ||
>>>>> +    (icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT))
>>>>> + return true;
>>>>> + }
>>>>> + }
>>>>> +
>>>>> + return false;
>>>>> +}
>>>>> +
>>>>> /* Use this Xmit function for 3AD as well as XOR modes. The =
current
>>>>> * usable slave array is formed in the control path. The xmit =
function
>>>>> * just calculates hash and sends the packet out.
>>>>> @@ -5583,6 +5618,9 @@ static netdev_tx_t __bond_start_xmit(struct =
sk_buff *skb, struct net_device *dev
>>>>> case BOND_MODE_ACTIVEBACKUP:
>>>>> return bond_xmit_activebackup(skb, dev);
>>>>> case BOND_MODE_8023AD:
>>>>> + if (bond_should_broadcast_neighbor(skb, dev))
>>>>> + return bond_xmit_broadcast(skb, dev);
>>>>> + fallthrough;
>>>>> case BOND_MODE_XOR:
>>>>> return bond_3ad_xor_xmit(skb, dev);
>>>>> case BOND_MODE_BROADCAST:
>>>>> @@ -6462,6 +6500,7 @@ static int __init bond_check_params(struct =
bond_params *params)
>>>>> eth_zero_addr(params->ad_actor_system);
>>>>> params->ad_user_port_key =3D ad_user_port_key;
>>>>> params->coupled_control =3D 1;
>>>>> + params->broadcast_neighbor =3D 0;
>>>>> if (packets_per_slave > 0) {
>>>>> params->reciprocal_packets_per_slave =3D
>>>>> reciprocal_value(packets_per_slave);
>>>>> diff --git a/drivers/net/bonding/bond_options.c =
b/drivers/net/bonding/bond_options.c
>>>>> index 91893c29b899..dca52d93f513 100644
>>>>> --- a/drivers/net/bonding/bond_options.c
>>>>> +++ b/drivers/net/bonding/bond_options.c
>>>>> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct =
bonding *bond,
>>>>>     const struct bond_opt_value *newval);
>>>>> static int bond_option_coupled_control_set(struct bonding *bond,
>>>>>  const struct bond_opt_value *newval);
>>>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>>>> +   const struct bond_opt_value *newval);
>>>>>=20
>>>>> static const struct bond_opt_value bond_mode_tbl[] =3D {
>>>>> { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>>>>> @@ -240,6 +242,12 @@ static const struct bond_opt_value =
bond_coupled_control_tbl[] =3D {
>>>>> { NULL,  -1, 0},
>>>>> };
>>>>>=20
>>>>> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] =3D =
{
>>>>> + { "on", 1, 0},
>>>>> + { "off", 0, BOND_VALFLAG_DEFAULT},
>>>>=20
>>>> I know the option above is using this order, but it is a bit =
counter-intuitive to
>>>> have their places reversed wrt their values, could you please =
re-order these as
>>>> the other bond on/off options? This is a small nit, I don't have a =
strong preference
>>>> but it is more intuitive to have them in their value order. :)
>>> Ok
>>>>=20
>>>>> + { NULL,  -1, 0}> +};
>>>>> +
>>>>> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
>>>>> [BOND_OPT_MODE] =3D {
>>>>> .id =3D BOND_OPT_MODE,
>>>>> @@ -513,6 +521,14 @@ static const struct bond_option =
bond_opts[BOND_OPT_LAST] =3D {
>>>>> .flags =3D BOND_OPTFLAG_IFDOWN,
>>>>> .values =3D bond_coupled_control_tbl,
>>>>> .set =3D bond_option_coupled_control_set,
>>>>> + },
>>>>> + [BOND_OPT_BROADCAST_NEIGH] =3D {
>>>>> + .id =3D BOND_OPT_BROADCAST_NEIGH,
>>>>> + .name =3D "broadcast_neighbor",
>>>>> + .desc =3D "Broadcast neighbor packets to all slaves",
>>>>> + .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>>>>> + .values =3D bond_broadcast_neigh_tbl,
>>>>> + .set =3D bond_option_broadcast_neigh_set,
>>>>> }
>>>>> };
>>>>>=20
>>>>> @@ -1840,3 +1856,21 @@ static int =
bond_option_coupled_control_set(struct bonding *bond,
>>>>> bond->params.coupled_control =3D newval->value;
>>>>> return 0;
>>>>> }
>>>>> +
>>>>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>>>>> +   const struct bond_opt_value *newval)
>>>>> +{
>>>>> + netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
>>>>> +   newval->value);
>>>>> +
>>>>> + if (bond->params.broadcast_neighbor =3D=3D newval->value)
>>>>> + return 0;
>>>>> +
>>>>> + bond->params.broadcast_neighbor =3D newval->value;
>>>>> + if (bond->params.broadcast_neighbor)
>>>>> + static_branch_inc(&bond_bcast_neigh_enabled);
>>>>> + else
>>>>> + static_branch_dec(&bond_bcast_neigh_enabled);
>>>>=20
>>>> If the bond has been brought down then the branch has been already =
decremented.
>>>> You'll have to synchronize this with bond open/close or =
alternatively mark the option
>>>> as being able to be changed only when the bond is up (there is an =
option flag for that).
>>> I will check bond_bcast_neigh_enabled in bond_unint() instead of in =
bond_close().
>>>>>>=20
>>>>> +
>>>>> + return 0;
>>>>> +}
>>>>> diff --git a/drivers/net/bonding/bond_sysfs.c =
b/drivers/net/bonding/bond_sysfs.c
>>>>> index 1e13bb170515..4a53850b2c68 100644
>>>>> --- a/drivers/net/bonding/bond_sysfs.c
>>>>> +++ b/drivers/net/bonding/bond_sysfs.c
>>>>> @@ -752,6 +752,23 @@ static ssize_t =
bonding_show_ad_user_port_key(struct device *d,
>>>>> static DEVICE_ATTR(ad_user_port_key, 0644,
>>>>>  bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>>>>>=20
>>>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>>>>> +       struct device_attribute *attr,
>>>>> +       char *buf)
>>>>> +{
>>>>> + struct bonding *bond =3D to_bond(d);
>>>>> + const struct bond_opt_value *val;
>>>>> +
>>>>> + val =3D bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
>>>>> +       bond->params.broadcast_neighbor);
>>>>> +
>>>>> + return sysfs_emit(buf, "%s %d\n", val->string,
>>>>> +  bond->params.broadcast_neighbor);
>>>>> +}
>>>>> +
>>>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>>>>> +   bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
>>>>> +
>>>>=20
>>>> sysfs options are deprecated, please don't extend sysfs
>>>> netlink is the preferred way for new options
>>> I think it is still useful to config option via sysfs, and I find =
other new option still use the sysfs.
>>=20
>> This is wrong, there are no new options that have been added to sysfs =
recently,
>> the latest option being "coupled_control". As I already said - sysfs =
has been deprecated
>> for quite some time, don't add new options to it.
>=20
> Agreed, no new options in bonding's sysfs.  We are intentionally
> encouraging the use of netlink / iproute for bonding configuration
> instead of sysfs.
sysfs option of this patch, will be removed in v3.
>=20
> -J
>=20
>>>>> static struct attribute *per_bond_attrs[] =3D {
>>>>> &dev_attr_slaves.attr,
>>>>> &dev_attr_mode.attr,
>>>>> @@ -791,6 +808,7 @@ static struct attribute *per_bond_attrs[] =3D =
{
>>>>> &dev_attr_ad_actor_system.attr,
>>>>> &dev_attr_ad_user_port_key.attr,
>>>>> &dev_attr_arp_missed_max.attr,
>>>>> + &dev_attr_broadcast_neighbor.attr,
>>>>> NULL,
>>>>> };
>>>>>=20
>>>>> diff --git a/include/net/bond_options.h =
b/include/net/bond_options.h
>>>>> index 18687ccf0638..022b122a9fb6 100644
>>>>> --- a/include/net/bond_options.h
>>>>> +++ b/include/net/bond_options.h
>>>>> @@ -77,6 +77,7 @@ enum {
>>>>> BOND_OPT_NS_TARGETS,
>>>>> BOND_OPT_PRIO,
>>>>> BOND_OPT_COUPLED_CONTROL,
>>>>> + BOND_OPT_BROADCAST_NEIGH,
>>>>> BOND_OPT_LAST
>>>>> };
>>>>>=20
>>>>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>>>>> index 95f67b308c19..e06f0d63b2c1 100644
>>>>> --- a/include/net/bonding.h
>>>>> +++ b/include/net/bonding.h
>>>>> @@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct =
net_device *dev)
>>>>> #define is_netpoll_tx_blocked(dev) (0)
>>>>> #endif
>>>>>=20
>>>>> +DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>>>>> +
>>>>> struct bond_params {
>>>>> int mode;
>>>>> int xmit_policy;
>>>>> @@ -149,6 +151,7 @@ struct bond_params {
>>>>> struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>>>>> #endif
>>>>> int coupled_control;
>>>>> + int broadcast_neighbor;
>>>>>=20
>>>>> /* 2 bytes of padding : see ether_addr_equal_64bits() */
>>>>> u8 ad_actor_system[ETH_ALEN + 2];
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>=20
>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



