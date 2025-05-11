Return-Path: <netdev+bounces-189527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E8AB28E7
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43438174601
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186C1D8A10;
	Sun, 11 May 2025 14:10:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48ABA3F
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746972605; cv=none; b=ab525N/bHs5m8znba+QAS/Ol9AS3qgH+Bu7kICWiboaMOyHHMF7ubhqC0LNu0W/YG1HA2WVQ6kstBaocDzdIL3kOz3QozcPsQGR1+ly8Ca4S02fL3X2DHzs+ihodJCsKMJQeVH0SgyiDbm5cNxwA+ph5rE+TZlLzN0gj8ANkJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746972605; c=relaxed/simple;
	bh=57Wq5Q/MaphD4CoyYjK53bx0YRyO0bMbyXTUJXmSFNc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fnqOPyf6YYolyMMynnL5TGt2i5wQz7JTX1Trq9LVkKd4LketEfsmwE/fpb5cWn5um++19gIVizr4t45FIbbmclkmBuvQr2YYYcgGn0FkU018jDy63Vw/ZiQvQImcoycNeg1gDOOIUbzZqjQc/byeEgd9jnAUjsGG3uTRPZ+WqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1746972470t1de22e62
X-QQ-Originating-IP: Atf9j+Pzl7Qv3DwrErK1QidWUYcklRlyHbwZzHBdkIE=
Received: from smtpclient.apple ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 11 May 2025 22:07:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2016835239637834369
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <1133230.1746881077@vermin>
Date: Sun, 11 May 2025 22:07:46 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE4DB782-91EB-4DBD-9C26-CA4C4612D58C@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-2-tonghao@bamaicloud.com> <1133230.1746881077@vermin>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ObFHHlrAm440XmAumHahiN4fwmKBRsu9K380095GVjXiZ68RrPunzCn+
	cn+baBEXMyGI997G4CC0DVraF62TBjTEEOfJz5AFdSaHCdTtFQKtegUhFO/1CpUgwbgwZi2
	xI+5kvOvwZOAnZq14FIzMHnztnucK2F9we24BBxGXU+v6zDJXLhya/hsOoaeIrUAtx5d9Au
	OCcsvGFVFF6XbtPi3HHI4EKQMjegQxG9xZCpWI5UKAgyf2SU3iJn2uHpt5zo834WUuS5mj5
	UeqyDP8RVACZ9giRW1JS5Gp4KQVzo4IqHHR4bjsuhdiRG7Qe9EkipAROv8mtq8gpXFr6VHc
	E/c/ngpQa8ihi1nmlY1UdB97KqVHinyKvsyOgNFg57nz3o9en2I2yQiOHKpIbE60+uwzmAe
	3wr49eF+wMrZf9EuKDg9yqYg0gyE7mwbnocMeqHTqv708JLE45EG6Ay//fsGoFXUb4p5IpK
	C8zfNfnEyLXM+i+uPKZ0jX9NP3TBNEFB0ihv0zQWqXKhINYsM4UM7a3Dab6wQ1axcIyVHJS
	9E+MYhXa4t6dHjBW4NcJGSFe0DDvlA1WmdVQ7gZiIJ+SIQu2Fyxhqtd2VWQXSf5Xzv1Lh5F
	DwrbJgfpP/cWiW+XfdtqEvblqvrgam3vGFsZhKI29CVZwT9NfYv3TShtze6p9Kbx/7wzwDL
	osFSRll4ttQEmqdyO88pQ142yRpCUvvaJkJxI5tmJsv3WgTnkhFKXNLQrC49qJovElYEuBB
	EB7wIw8NMZdk05hD4fIYboEXsWcbTMMhyBEei7r0xK6FegiYwHORJvrYch1XU+JiF+m+Lt+
	0sIs+vZedL70rnexgstDcp/XsR/CXg65iAMH7jxC9x1BWvWrGqn7Cri1MEqY+i8SeTkBX7f
	9EgwDzhX0NgH+MuIxaUwnOGj2ubVDgeyX2eHoruNQunFTADQWiiozt1MUQzLCjOK9voG5SX
	51fsTe7V/xe20JFsBfM1GYvYC5fYsUw24kJlDKPePA9kcuL71l3s3urOZSqYPsdvDA9OTaR
	7GHbyfyhl0E/SeCYORSSEuVoUCPHCdk0eSE3BJflntDBk3HjVE
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8810=E6=97=A5 =E4=B8=8B=E5=8D=888:44=EF=BC=8CJay =
Vosburgh <jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> tonghao@bamaicloud.com wrote:
>=20
>> From: Tonghao Zhang <tonghao@bamaicloud.com>
>>=20
>> Stacking technology provides technical benefits but has inherent =
drawbacks.
>> For instance, switch software or system upgrades require simultaneous =
reboots
>> of all stacked switches. Additionally, stacking link failures may =
cause
>> stack splitting.
>>=20
>> To improve network stability, non-stacking solutions have been =
increasingly
>> adopted, particularly by public cloud providers and technology =
companies
>> like Alibaba, Tencent, and Didi. The server still uses dual network =
cards and
>> dual uplinks to two switches, and the network card mode is set to
>> bond mode 4 (IEEE 802.3ad). As aggregation ports transmit ARP/ND data
>> exclusively through one physical port, both switches in non-stacking
>> deployments must receive server ARP/ND requests. This requires =
bonding driver
>> modifications to broadcast ARP/ND packets through all active slave =
links.
>>=20
>> - =
https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-net=
work-architecture/
>=20
> 	I didn't really follow the explanation here without reading the
> linked article.  I think it would be better to explain the basics of
> what this "non-stacking" architecture is, then describe the change to
> bonding necessary to support it.  This description need not go into
> great detail; assuming I understand correctly, perhaps something along
> the lines of:
>=20
> 	"non-stacking" is a method of mimicing switch stacking that
> convinces a LACP peer, bonding in this case, connected to a set of
> "non-stacked" switches that all of its ports are connected to a single
> switch (i.e., LACP aggregator), as if those switches were stacked.  =
This
> enables the LACP peer's ports to aggregate together, and requires (a)
> special switch configuration, described in the linked article, and (b)
> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
> packets across all ports of the active aggregator.
>=20
> 	Is that a fair summary?
Yes, pretty good. I will add more info of =E2=80=9Cno-stacking=E2=80=9D =
arch and your summary.
> 	Regardless, the commit message should stand on its own, even if
> the linked article is gone at some point in the future.
Yes
>=20
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> ---
>> Documentation/networking/bonding.rst |  5 +++
>> drivers/net/bonding/bond_main.c      | 58 =
+++++++++++++++++++++-------
>> drivers/net/bonding/bond_options.c   | 25 ++++++++++++
>> drivers/net/bonding/bond_sysfs.c     | 18 +++++++++
>> include/net/bond_options.h           |  1 +
>> include/net/bonding.h                |  1 +
>> 6 files changed, 94 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
>> index a4c1291d2561..0aca6e7599db 100644
>> --- a/Documentation/networking/bonding.rst
>> +++ b/Documentation/networking/bonding.rst
>> @@ -562,6 +562,11 @@ lacp_rate
>>=20
>> 	The default is slow.
>>=20
>> +broadcast_neighbor
>> +
>> +    Option specifying whether to broadcast ARP/ND packets to all
>> +    active slaves. The default is off (0).
>> +
>=20
> 	I'm happy to see documentation updates; however, please add the
> caveat that this option has no effect in modes other than 802.3ad =
mode.
> Also, the text is not formatted consistently with the options around =
it
> (block indented one tab).
Ok, update it in next patch version.
>> max_bonds
>>=20
>> 	Specifies the number of bonding devices to create for this
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index d05226484c64..c54bfba10688 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5316,23 +5316,31 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>> 	return slaves->arr[hash % count];
>> }
>>=20
>> -/* Use this Xmit function for 3AD as well as XOR modes. The current
>> - * usable slave array is formed in the control path. The xmit =
function
>> - * just calculates hash and sends the packet out.
>> - */
>> -static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>> -				     struct net_device *dev)
>> +static bool bond_should_broadcast_neighbor(struct bonding *bond,
>> +					   struct sk_buff *skb)
>> {
>> -	struct bonding *bond =3D netdev_priv(dev);
>> -	struct bond_up_slave *slaves;
>> -	struct slave *slave;
>> +	if (BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>> +		return false;
>>=20
>> -	slaves =3D rcu_dereference(bond->usable_slaves);
>> -	slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>> -	if (likely(slave))
>> -		return bond_dev_queue_xmit(bond, skb, slave->dev);
>> +	if (!bond->params.broadcast_neighbor)
>> +		return false;
>>=20
>> -	return bond_tx_drop(dev, skb);
>> +	if (skb->protocol =3D=3D htons(ETH_P_ARP))
>> +		return true;
>> +
>> +        if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>> +            pskb_may_pull(skb,
>> +                          sizeof(struct ipv6hdr) + sizeof(struct =
icmp6hdr))) {
>> +                if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>> +                        struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>> +
>> +                        if ((icmph->icmp6_type =3D=3D =
NDISC_NEIGHBOUR_SOLICITATION) ||
>> +                            (icmph->icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
>> +                                return true;
>> +                }
>> +        }
>> +
>> +        return false;
>> }
>>=20
>> /* in broadcast mode, we send everything to all usable interfaces. */
>> @@ -5377,6 +5385,28 @@ static netdev_tx_t bond_xmit_broadcast(struct =
sk_buff *skb,
>> 	return NET_XMIT_DROP;
>> }
>>=20
>> +/* Use this Xmit function for 3AD as well as XOR modes. The current
>> + * usable slave array is formed in the control path. The xmit =
function
>> + * just calculates hash and sends the packet out.
>> + */
>> +static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>> +				     struct net_device *dev)
>> +{
>> +	struct bonding *bond =3D netdev_priv(dev);
>> +	struct bond_up_slave *slaves;
>> +	struct slave *slave;
>> +
>> +	if (bond_should_broadcast_neighbor(bond, skb))
>> +		return bond_xmit_broadcast(skb, dev);
>=20
> 	I feel like there has to be a way to implement this that won't
> add two or three branches to the transmit fast path for every packet
> when this option is not enabled (which will be the vast majority of
> cases).  I'm not sure what that would look like, needs some thought.
The patch should check the .broadcast_neighbor and bond mode firstly, =
and ipv4 packets quickly, and then ipv6. Parsing network packets is =
unavoidable, especially for IPv6 packets.

static inline bool bond_should_broadcast_neighbor(struct bonding *bond,
                                                  struct sk_buff *skb)
{
        if (!bond->params.broadcast_neighbor ||
            BOND_MODE(bond) !=3D BOND_MODE_8023AD)
                return false;

        if (skb->protocol =3D=3D htons(ETH_P_ARP))
                return true;

        if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
            pskb_may_pull(skb,
                          sizeof(struct ipv6hdr) + sizeof(struct =
icmp6hdr))) {
                if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
                        struct icmp6hdr *icmph =3D icmp6_hdr(skb);

                        if ((icmph->icmp6_type =3D=3D =
NDISC_NEIGHBOUR_SOLICITATION) ||
                            (icmph->icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
                                return true;
                }
        }

        return false;
}

>=20
>> max_bonds
>>=20
>> 	Specifies the number of bonding devices to create for this
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index d05226484c64..c54bfba10688 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5316,23 +5316,31 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>> 	return slaves->arr[hash % count];
>> }
>>=20
>> -/* Use this Xmit function for 3AD as well as XOR modes. The current
>> - * usable slave array is formed in the control path. The xmit =
function
>> - * just calculates hash and sends the packet out.
>> - */
>> -static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>> -				     struct net_device *dev)
>> +static bool bond_should_broadcast_neighbor(struct bonding *bond,
>> +					   struct sk_buff *skb)
>> {
>> -	struct bonding *bond =3D netdev_priv(dev);
>> -	struct bond_up_slave *slaves;
>> -	struct slave *slave;
>> +	if (BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>> +		return false;
>>=20
>> -	slaves =3D rcu_dereference(bond->usable_slaves);
>> -	slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>> -	if (likely(slave))
>> -		return bond_dev_queue_xmit(bond, skb, slave->dev);
>> +	if (!bond->params.broadcast_neighbor)
>> +		return false;
>>=20
>> -	return bond_tx_drop(dev, skb);
>> +	if (skb->protocol =3D=3D htons(ETH_P_ARP))
>> +		return true;
>> +
>> +        if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>> +            pskb_may_pull(skb,
>> +                          sizeof(struct ipv6hdr) + sizeof(struct =
icmp6hdr))) {
>> +                if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>> +                        struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>> +
>> +                        if ((icmph->icmp6_type =3D=3D =
NDISC_NEIGHBOUR_SOLICITATION) ||
>> +                            (icmph->icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
>> +                                return true;
>> +                }
>> +        }
>> +
>> +        return false;
>> }
>>=20
>> /* in broadcast mode, we send everything to all usable interfaces. */
>> @@ -5377,6 +5385,28 @@ static netdev_tx_t bond_xmit_broadcast(struct =
sk_buff *skb,
>> 	return NET_XMIT_DROP;
>> }
>>=20
>> +/* Use this Xmit function for 3AD as well as XOR modes. The current
>> + * usable slave array is formed in the control path. The xmit =
function
>> + * just calculates hash and sends the packet out.
>> + */
>> +static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>> +				     struct net_device *dev)
>> +{
>> +	struct bonding *bond =3D netdev_priv(dev);
>> +	struct bond_up_slave *slaves;
>> +	struct slave *slave;
>> +
>> +	if (bond_should_broadcast_neighbor(bond, skb))
>> +		return bond_xmit_broadcast(skb, dev);
>=20
> 	I feel like there has to be a way to implement this that won't
> add two or three branches to the transmit fast path for every packet
> when this option is not enabled (which will be the vast majority of
> cases).  I'm not sure what that would look like, needs some thought.
>=20
> 	Is the call to bond_should_broadcast_neighbor inlined at compile
> time?
>=20
> 	-J
>=20
>> +
>> +	slaves =3D rcu_dereference(bond->usable_slaves);
>> +	slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>> +	if (likely(slave))
>> +		return bond_dev_queue_xmit(bond, skb, slave->dev);
>> +
>> +	return bond_tx_drop(dev, skb);
>> +}
>> +
>> /*------------------------- Device initialization =
---------------------------*/
>>=20
>> /* Lookup the slave that corresponds to a qid */
>> diff --git a/drivers/net/bonding/bond_options.c =
b/drivers/net/bonding/bond_options.c
>> index 91893c29b899..38e8f03d1707 100644
>> --- a/drivers/net/bonding/bond_options.c
>> +++ b/drivers/net/bonding/bond_options.c
>> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct =
bonding *bond,
>> 				      const struct bond_opt_value =
*newval);
>> static int bond_option_coupled_control_set(struct bonding *bond,
>> 					   const struct bond_opt_value =
*newval);
>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>> +					   const struct bond_opt_value =
*newval);
>>=20
>> static const struct bond_opt_value bond_mode_tbl[] =3D {
>> 	{ "balance-rr",    BOND_MODE_ROUNDROBIN,   =
BOND_VALFLAG_DEFAULT},
>> @@ -240,6 +242,12 @@ static const struct bond_opt_value =
bond_coupled_control_tbl[] =3D {
>> 	{ NULL,  -1, 0},
>> };
>>=20
>> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] =3D {
>> +	{ "on",	 1, 0},
>> +	{ "off", 0, BOND_VALFLAG_DEFAULT},
>> +	{ NULL,  -1, 0}
>> +};
>> +
>> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
>> 	[BOND_OPT_MODE] =3D {
>> 		.id =3D BOND_OPT_MODE,
>> @@ -513,6 +521,14 @@ static const struct bond_option =
bond_opts[BOND_OPT_LAST] =3D {
>> 		.flags =3D BOND_OPTFLAG_IFDOWN,
>> 		.values =3D bond_coupled_control_tbl,
>> 		.set =3D bond_option_coupled_control_set,
>> +	},
>> +	[BOND_OPT_BROADCAST_NEIGH] =3D {
>> +		.id =3D BOND_OPT_BROADCAST_NEIGH,
>> +		.name =3D "broadcast_neighbor",
>> +		.desc =3D "Broadcast neighbor packets to all slaves",
>> +		.unsuppmodes =3D =
BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>> +		.values =3D bond_broadcast_neigh_tbl,
>> +		.set =3D bond_option_broadcast_neigh_set,
>> 	}
>> };
>>=20
>> @@ -1840,3 +1856,12 @@ static int =
bond_option_coupled_control_set(struct bonding *bond,
>> 	bond->params.coupled_control =3D newval->value;
>> 	return 0;
>> }
>> +
>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>> +					   const struct bond_opt_value =
*newval)
>> +{
>> +	netdev_dbg(bond->dev, "Setting broadcast_neighbor to %llu\n",
>> +		   newval->value);
>> +	bond->params.broadcast_neighbor =3D newval->value;
>> +	return 0;
>> +}
>> diff --git a/drivers/net/bonding/bond_sysfs.c =
b/drivers/net/bonding/bond_sysfs.c
>> index 1e13bb170515..76f2a1bf57c2 100644
>> --- a/drivers/net/bonding/bond_sysfs.c
>> +++ b/drivers/net/bonding/bond_sysfs.c
>> @@ -752,6 +752,23 @@ static ssize_t =
bonding_show_ad_user_port_key(struct device *d,
>> static DEVICE_ATTR(ad_user_port_key, 0644,
>> 		   bonding_show_ad_user_port_key, =
bonding_sysfs_store_option);
>>=20
>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>> +					       struct device_attribute =
*attr,
>> +					       char *buf)
>> +{
>> +	struct bonding *bond =3D to_bond(d);
>> +	const struct bond_opt_value *val;
>> +
>> +	val =3D bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
>> +			bond->params.broadcast_neighbor);
>> +
>> +	return sysfs_emit(buf, "%s %d\n", val->string,
>> +			bond->params.broadcast_neighbor);
>> +}
>> +
>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>> +		   bonding_show_broadcast_neighbor, =
bonding_sysfs_store_option);
>> +
>> static struct attribute *per_bond_attrs[] =3D {
>> 	&dev_attr_slaves.attr,
>> 	&dev_attr_mode.attr,
>> @@ -791,6 +808,7 @@ static struct attribute *per_bond_attrs[] =3D {
>> 	&dev_attr_ad_actor_system.attr,
>> 	&dev_attr_ad_user_port_key.attr,
>> 	&dev_attr_arp_missed_max.attr,
>> +	&dev_attr_broadcast_neighbor.attr,
>> 	NULL,
>> };
>>=20
>> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>> index 18687ccf0638..022b122a9fb6 100644
>> --- a/include/net/bond_options.h
>> +++ b/include/net/bond_options.h
>> @@ -77,6 +77,7 @@ enum {
>> 	BOND_OPT_NS_TARGETS,
>> 	BOND_OPT_PRIO,
>> 	BOND_OPT_COUPLED_CONTROL,
>> +	BOND_OPT_BROADCAST_NEIGH,
>> 	BOND_OPT_LAST
>> };
>>=20
>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>> index 95f67b308c19..1eafd15eaad9 100644
>> --- a/include/net/bonding.h
>> +++ b/include/net/bonding.h
>> @@ -149,6 +149,7 @@ struct bond_params {
>> 	struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>> #endif
>> 	int coupled_control;
>> +	int broadcast_neighbor;
>>=20
>> 	/* 2 bytes of padding : see ether_addr_equal_64bits() */
>> 	u8 ad_actor_system[ETH_ALEN + 2];
>> --=20
>> 2.34.1
>>=20
>=20
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net


