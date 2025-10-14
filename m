Return-Path: <netdev+bounces-229132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D871BD86A6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 101584E9450
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1F2080C1;
	Tue, 14 Oct 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZEIFBFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A52AEF5
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433774; cv=none; b=FHS/RR+YttlI49VOLQPmvOojCZ+LfoBzp9XKF/9K9INQwHWUZ3M1+FEPpzDMVgou5weeg8S1+z45oEkCZ/i6xBZHD7KryFjq9nnJOO7EWXUhTEdX0GUggbN9tsnTMLmDrtchhR51p9GTg3rTRgqYVZLZwVbkxPOdCjGICCTV7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433774; c=relaxed/simple;
	bh=jpnCXx3KYAEKd6zZ7+G7eaWlijgHIljDxiE5POxvBys=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=HB1quvQ1U51uodTgeyzMgmujTFwiyzzdv7JPkNN3IKR62Jgu5qGyGXjb2e0q+t6dz3Z/CXs86sbn6zWv8FnQbjJj2Yp/SRcINo9faTIhw0hpHK5DY9i/w5Ju1yty1MLRmuYqA6T4wIcY1JqKGDLdrDCQdJX1e6ZZK4Fs/hngVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZEIFBFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB277C4CEFE;
	Tue, 14 Oct 2025 09:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760433773;
	bh=jpnCXx3KYAEKd6zZ7+G7eaWlijgHIljDxiE5POxvBys=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=JZEIFBFHtTS3D4Qhd3HEmWo1URM/OmMXyUqt82GU/eG8xfnYgWyWpNTvg9OJC/9NC
	 y67W0hPIET9tE/ErezqY7v4IeC6wpAS9orGV0/a9GEsEVrOEHmAA3tc99g/866MzAy
	 3I/dt2No7h1xv8hu0TMFpS92f6OmT2BkggFb9VOx0b6lcOVQZmebazEYWYGGM2G1PF
	 r/8at6/SgqfPmtJxKBaRVaFD7NQ7lzLz3g2xwJltsgYssGC3rCUnf1uxtoUKshvFKF
	 9Dzgls7JPxE05CvGtBgE0HY+xaaIG+hc5WI8rUaul3KbgiglQkZe1LslSBWnQPw+Ij
	 kN77XWmAJ0L8w==
Content-Type: multipart/mixed; boundary="------------kGOGZp0sTU8ZBDXcvHFvkJdU"
Message-ID: <2988833b-f0bd-4753-aa82-8e20fe1e7635@kernel.org>
Date: Tue, 14 Oct 2025 11:22:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v8 1/3] net: bonding: add broadcast_neighbor option for
 802.3ad
From: Jiri Slaby <jirislaby@kernel.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com>
 <a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org>

This is a multi-part message in MIME format.
--------------kGOGZp0sTU8ZBDXcvHFvkJdU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14. 10. 25, 11:12, Jiri Slaby wrote:
> On 27. 06. 25, 15:49, Tonghao Zhang wrote:
>> Stacking technology is a type of technology used to expand ports on
>> Ethernet switches. It is widely used as a common access method in
>> large-scale Internet data center architectures. Years of practice
>> have proved that stacking technology has advantages and disadvantages
>> in high-reliability network architecture scenarios. For instance,
>> in stacking networking arch, conventional switch system upgrades
>> require multiple stacked devices to restart at the same time.
>> Therefore, it is inevitable that the business will be interrupted
>> for a while. It is for this reason that "no-stacking" in data centers
>> has become a trend. Additionally, when the stacking link connecting
>> the switches fails or is abnormal, the stack will split. Although it is
>> not common, it still happens in actual operation. The problem is that
>> after the split, it is equivalent to two switches with the same
>> configuration appearing in the network, causing network configuration
>> conflicts and ultimately interrupting the services carried by the
>> stacking system.
>>
>> To improve network stability, "non-stacking" solutions have been
>> increasingly adopted, particularly by public cloud providers and
>> tech companies like Alibaba, Tencent, and Didi. "non-stacking" is
>> a method of mimicing switch stacking that convinces a LACP peer,
>> bonding in this case, connected to a set of "non-stacked" switches
>> that all of its ports are connected to a single switch
>> (i.e., LACP aggregator), as if those switches were stacked. This
>> enables the LACP peer's ports to aggregate together, and requires
>> (a) special switch configuration, described in the linked article,
>> and (b) modifications to the bonding 802.3ad (LACP) mode to send
>> all ARP/ND packets across all ports of the active aggregator.
>>
>> Note that, with multiple aggregators, the current broadcast mode
>> logic will send only packets to the selected aggregator(s).
>>
>>   +-----------+   +-----------+
>>   |  switch1  |   |  switch2  |
>>   +-----------+   +-----------+
>>           ^           ^
>>           |           |
>>        +-----------------+
>>        |   bond4 lacp    |
>>        +-----------------+
>>           |           |
>>           | NIC1      | NIC2
>>        +-----------------+
>>        |     server      |
>>        +-----------------+
> 
> Hi,
> 
> this breaks broadcast bonding in 6.17. Reverting these three (the two 
> depend on this one) makes 6.17 work again:
> 2f9afffc399d net: bonding: send peer notify when failure recovery
> 3d98ee52659c net: bonding: add broadcast_neighbor netlink option
> ce7a381697cb net: bonding: add broadcast_neighbor option for 802.3ad
> 
> This was reported downstream as an error in our openQA:
> https://bugzilla.suse.com/show_bug.cgi?id=1250894
> 
> I bisected using this in qemu:
> systemctl stop network
> ip link del bond0 || true
> ip link set dev eth0 down
> ip addr flush eth0
> ip link add bond0 type bond mode broadcast
> ip link set dev eth0 master bond0
> ip addr add 10.0.2.15/24 dev bond0
> ip link set bond0 up
> sleep 1
> exec nmap -sS 10.0.2.2/32
> 
> Any ideas?
> 
>> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data- 
>> center-network-architecture/
>>
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>> ---
>> v8: add comments info in bond_option_mode_set, explain why we only
>> clear broadcast_neighbor to 0.
>> Note that selftest will be post after I post the iproute2 patch about
>> this option.
>> ---
>>   Documentation/networking/bonding.rst |  6 +++
>>   drivers/net/bonding/bond_main.c      | 66 +++++++++++++++++++++++++---
>>   drivers/net/bonding/bond_options.c   | 42 ++++++++++++++++++
>>   include/net/bond_options.h           |  1 +
>>   include/net/bonding.h                |  3 ++
>>   5 files changed, 112 insertions(+), 6 deletions(-)
>>
> ...
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
> ...
>> @@ -5329,17 +5369,27 @@ static netdev_tx_t bond_3ad_xor_xmit(struct 
>> sk_buff *skb,
>>       return bond_tx_drop(dev, skb);
>>   }
>> -/* in broadcast mode, we send everything to all usable interfaces. */
>> +/* in broadcast mode, we send everything to all or usable slave 
>> interfaces.
>> + * under rcu_read_lock when this function is called.
>> + */
>>   static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>> -                       struct net_device *bond_dev)
>> +                       struct net_device *bond_dev,
>> +                       bool all_slaves)
>>   {
>>       struct bonding *bond = netdev_priv(bond_dev);
>> -    struct slave *slave = NULL;
>> -    struct list_head *iter;
>> +    struct bond_up_slave *slaves;
>>       bool xmit_suc = false;
>>       bool skb_used = false;
>> +    int slaves_count, i;
>> -    bond_for_each_slave_rcu(bond, slave, iter) {
>> +    if (all_slaves)
>> +        slaves = rcu_dereference(bond->all_slaves);
>> +    else
>> +        slaves = rcu_dereference(bond->usable_slaves);
>> +
>> +    slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
> 
> OK, slaves_count is now 0 (slaves and bond->all_slaves are NULL), but 
> bond_for_each_slave_rcu() used to yield 1 iface.
> 
> Well, bond_update_slave_arr() is not called for broadcast AFAICS.

The attached patch fixes it for me. But I have no idea if it is correct...

thanks,
-- 
js
suse labs

--------------kGOGZp0sTU8ZBDXcvHFvkJdU
Content-Type: text/x-patch; charset=UTF-8; name="0001-fix.patch"
Content-Disposition: attachment; filename="0001-fix.patch"
Content-Transfer-Encoding: base64

RnJvbSBiMTc1OTQ2MjkyMjQ1MGFhZDUwZTRjY2RiYjA0NTBmNGMzNjc0MjA0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KRGF0
ZTogVHVlLCAxNCBPY3QgMjAyNSAxMToyMToyMSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGZp
eAoKLS0tCiBkcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jIHwgNjIgKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9u
cygrKSwgMjcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvYm9uZGlu
Zy9ib25kX21haW4uYyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMKaW5kZXgg
NTdiZTA0ZjZjYjExLi5lOTBhYjVkMGI3MTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2Jv
bmRpbmcvYm9uZF9tYWluLmMKKysrIGIvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4u
YwpAQCAtNTM4NCw2ICs1Mzg0LDMxIEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBib25kXzNhZF94
b3JfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAogCXJldHVybiBib25kX3R4X2Ryb3AoZGV2
LCBza2IpOwogfQogCitzdGF0aWMgdm9pZCBsb29wKHN0cnVjdCBuZXRfZGV2aWNlICpib25k
X2Rldiwgc3RydWN0IHNsYXZlICpzbGF2ZSwgc3RydWN0IHNrX2J1ZmYgKnNrYiwKKwkJIGJv
b2wgKnNrYl91c2VkLCBib29sICp4bWl0X3N1YykKK3sKKwlzdHJ1Y3QgYm9uZGluZyAqYm9u
ZCA9IG5ldGRldl9wcml2KGJvbmRfZGV2KTsKKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiMjsKKwor
CWlmICghKGJvbmRfc2xhdmVfaXNfdXAoc2xhdmUpICYmIHNsYXZlLT5saW5rID09IEJPTkRf
TElOS19VUCkpCisJCXJldHVybjsKKworCWlmIChib25kX2lzX2xhc3Rfc2xhdmUoYm9uZCwg
c2xhdmUpKSB7CisJCXNrYjIgPSBza2I7CisJCSpza2JfdXNlZCA9IHRydWU7CisJfSBlbHNl
IHsKKwkJc2tiMiA9IHNrYl9jbG9uZShza2IsIEdGUF9BVE9NSUMpOworCQlpZiAoIXNrYjIp
IHsKKwkJCW5ldF9lcnJfcmF0ZWxpbWl0ZWQoIiVzOiBFcnJvcjogJXM6IHNrYl9jbG9uZSgp
IGZhaWxlZFxuIiwKKwkJCQkJICAgIGJvbmRfZGV2LT5uYW1lLCBfX2Z1bmNfXyk7CisJCQly
ZXR1cm47CisJCX0KKwl9CisKKwlpZiAoYm9uZF9kZXZfcXVldWVfeG1pdChib25kLCBza2Iy
LCBzbGF2ZS0+ZGV2KSA9PSBORVRERVZfVFhfT0spCisJCSp4bWl0X3N1YyA9IHRydWU7Cit9
CisKIC8qIGluIGJyb2FkY2FzdCBtb2RlLCB3ZSBzZW5kIGV2ZXJ5dGhpbmcgdG8gYWxsIG9y
IHVzYWJsZSBzbGF2ZSBpbnRlcmZhY2VzLgogICogdW5kZXIgcmN1X3JlYWRfbG9jayB3aGVu
IHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkLgogICovCkBAIC01Mzk1LDM1ICs1NDIwLDE4IEBA
IHN0YXRpYyBuZXRkZXZfdHhfdCBib25kX3htaXRfYnJvYWRjYXN0KHN0cnVjdCBza19idWZm
ICpza2IsCiAJc3RydWN0IGJvbmRfdXBfc2xhdmUgKnNsYXZlczsKIAlib29sIHhtaXRfc3Vj
ID0gZmFsc2U7CiAJYm9vbCBza2JfdXNlZCA9IGZhbHNlOwotCWludCBzbGF2ZXNfY291bnQs
IGk7Ci0KLQlpZiAoYWxsX3NsYXZlcykKLQkJc2xhdmVzID0gcmN1X2RlcmVmZXJlbmNlKGJv
bmQtPmFsbF9zbGF2ZXMpOwotCWVsc2UKLQkJc2xhdmVzID0gcmN1X2RlcmVmZXJlbmNlKGJv
bmQtPnVzYWJsZV9zbGF2ZXMpOwogCi0Jc2xhdmVzX2NvdW50ID0gc2xhdmVzID8gUkVBRF9P
TkNFKHNsYXZlcy0+Y291bnQpIDogMDsKLQlmb3IgKGkgPSAwOyBpIDwgc2xhdmVzX2NvdW50
OyBpKyspIHsKLQkJc3RydWN0IHNsYXZlICpzbGF2ZSA9IHNsYXZlcy0+YXJyW2ldOwotCQlz
dHJ1Y3Qgc2tfYnVmZiAqc2tiMjsKLQotCQlpZiAoIShib25kX3NsYXZlX2lzX3VwKHNsYXZl
KSAmJiBzbGF2ZS0+bGluayA9PSBCT05EX0xJTktfVVApKQotCQkJY29udGludWU7Ci0KLQkJ
aWYgKGJvbmRfaXNfbGFzdF9zbGF2ZShib25kLCBzbGF2ZSkpIHsKLQkJCXNrYjIgPSBza2I7
Ci0JCQlza2JfdXNlZCA9IHRydWU7Ci0JCX0gZWxzZSB7Ci0JCQlza2IyID0gc2tiX2Nsb25l
KHNrYiwgR0ZQX0FUT01JQyk7Ci0JCQlpZiAoIXNrYjIpIHsKLQkJCQluZXRfZXJyX3JhdGVs
aW1pdGVkKCIlczogRXJyb3I6ICVzOiBza2JfY2xvbmUoKSBmYWlsZWRcbiIsCi0JCQkJCQkg
ICAgYm9uZF9kZXYtPm5hbWUsIF9fZnVuY19fKTsKLQkJCQljb250aW51ZTsKLQkJCX0KKwlp
ZiAoYWxsX3NsYXZlcykgeworCQlzdHJ1Y3Qgc2xhdmUgKnNsYXZlID0gTlVMTDsKKwkJc3Ry
dWN0IGxpc3RfaGVhZCAqaXRlcjsKKwkJYm9uZF9mb3JfZWFjaF9zbGF2ZV9yY3UoYm9uZCwg
c2xhdmUsIGl0ZXIpIHsKKwkJCWxvb3AoYm9uZF9kZXYsIHNsYXZlLCBza2IsICZza2JfdXNl
ZCwgJnhtaXRfc3VjKTsKIAkJfQotCi0JCWlmIChib25kX2Rldl9xdWV1ZV94bWl0KGJvbmQs
IHNrYjIsIHNsYXZlLT5kZXYpID09IE5FVERFVl9UWF9PSykKLQkJCXhtaXRfc3VjID0gdHJ1
ZTsKKwl9IGVsc2UgeworCQlzbGF2ZXMgPSByY3VfZGVyZWZlcmVuY2UoYm9uZC0+dXNhYmxl
X3NsYXZlcyk7CisJCWludCBzbGF2ZXNfY291bnQgPSBzbGF2ZXMgPyBSRUFEX09OQ0Uoc2xh
dmVzLT5jb3VudCkgOiAwOworCQlmb3IgKGludCBpID0gMDsgaSA8IHNsYXZlc19jb3VudDsg
aSsrKQorCQkJbG9vcChib25kX2Rldiwgc2xhdmVzLT5hcnJbaV0sIHNrYiwgJnNrYl91c2Vk
LCAmeG1pdF9zdWMpOwogCX0KIAogCWlmICghc2tiX3VzZWQpCi0tIAoyLjUxLjAKCg==

--------------kGOGZp0sTU8ZBDXcvHFvkJdU--

