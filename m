Return-Path: <netdev+bounces-25939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD1776399
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB31C20F93
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC551AA77;
	Wed,  9 Aug 2023 15:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F83612D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:18:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E62210A
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691594318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgCro2OAfbG3nbrKBOPm8+U3n9MbCFv94T338ZpfTbU=;
	b=MmK6t9BeYbjWEmnY2EKXQJ2IrmxXV58QQYBPwGpuIt/5teVlPhOuZAt9fX0rjHT9V8wBC5
	tW6O/OTvkrhw6KClDA9wTQEpI82p7XMK+Ek8RX00e2UqAkZKNN5h5QOYY3lGppy2nsVlaj
	YX36Xbn+NwTxvq782ooNNNvWCTKXYwA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-xxtvOQNFPQGcopih0xz6og-1; Wed, 09 Aug 2023 11:18:33 -0400
X-MC-Unique: xxtvOQNFPQGcopih0xz6og-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BD651C0513B;
	Wed,  9 Aug 2023 15:18:33 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.8.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ADF1492C13;
	Wed,  9 Aug 2023 15:18:32 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  i.maximets@ovn.org,  eric@garver.life,
  dev@openvswitch.org
Subject: Re: [net-next v3 7/7] selftests: openvswitch: add explicit drop
 testcase
References: <20230807164551.553365-1-amorenoz@redhat.com>
	<20230807164551.553365-8-amorenoz@redhat.com>
	<f7t1qgd4lxk.fsf@redhat.com>
	<9b6b05e7-ff29-b8cd-66e1-fb931778bee5@redhat.com>
Date: Wed, 09 Aug 2023 11:18:32 -0400
In-Reply-To: <9b6b05e7-ff29-b8cd-66e1-fb931778bee5@redhat.com> (Adrian
	Moreno's message of "Wed, 9 Aug 2023 09:02:12 +0200")
Message-ID: <f7t5y5o2qif.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adrian Moreno <amorenoz@redhat.com> writes:

> On 8/8/23 17:02, Aaron Conole wrote:
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>=20
>>> Make ovs-dpctl.py support explicit drops as:
>>> "drop" -> implicit empty-action drop
>>> "drop(0)" -> explicit non-error action drop
>> I also suggest a test in netlink_checks to make sure drop can't be
>> followed by additional actions.  Something like:
>>    3,drop(0),2
>> which should generate a NL message that has the drop attribute with
>> additional action data following it.
>
> Ack, will do.
>
> The check I've added in flow_netlink.c does not include any custom
> message. Just returning -EINVAL in __ovs_nla_copy_actions() ends up
> printing "Flow actions may not be safe on all matching packets" to
> dmesg. Maybe it's too generic or even misleading in some cases but I
> saw other action verifications do the same so I thought it might be
> kind of expected at this point.
>
> Do you think a custom message (in addition to the generic one) is needed?

I think the message is fine.  There could be a bigger effort at some
point to try and do per-attribute rejection messages.

> Thanks.
> --
> Adri=C3=A1n
>
>>=20
>>> "drop(42)" -> explicit error action drop
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>   .../selftests/net/openvswitch/openvswitch.sh  | 25 +++++++++++++++++++
>>>   .../selftests/net/openvswitch/ovs-dpctl.py    | 21 ++++++++++++----
>>>   2 files changed, 41 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/t=
ools/testing/selftests/net/openvswitch/openvswitch.sh
>>> index a10c345f40ef..c568ba1b7900 100755
>>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>>> @@ -217,6 +217,31 @@ test_drop_reason() {
>>>   		return 1
>>>   	fi
>>>   +	# Drop UDP 6000 traffic with an explicit action and an error
>>> code.
>>> +	ovs_add_flow "test_drop_reason" dropreason \
>>> +		"in_port(1),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.10,proto=3D=
17),udp(dst=3D6000)" \
>>> +                'drop(42)'
>>> +	# Drop UDP 7000 traffic with an explicit action with no error code.
>>> +	ovs_add_flow "test_drop_reason" dropreason \
>>> +		"in_port(1),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.10,proto=3D=
17),udp(dst=3D7000)" \
>>> +                'drop(0)'
>>> +
>>> +	ovs_drop_record_and_run \
>>> +            "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.3=
1.110.20 6000
>>> +	ovs_drop_reason_count 0x30004 # OVS_DROP_EXPLICIT_ACTION_ERROR
>>> +	if [[ "$?" -ne "1" ]]; then
>>> +		info "Did not detect expected explicit error drops: $?"
>>> +		return 1
>>> +	fi
>>> +
>>> +	ovs_drop_record_and_run \
>>> +            "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.3=
1.110.20 7000
>>> +	ovs_drop_reason_count 0x30003 # OVS_DROP_EXPLICIT_ACTION
>>> +	if [[ "$?" -ne "1" ]]; then
>>> +		info "Did not detect expected explicit drops: $?"
>>> +		return 1
>>> +	fi
>>> +
>>>   	return 0
>>>   }
>>>   diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>>> b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>>> index 5fee330050c2..912dc8c49085 100644
>>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>>> @@ -449,7 +449,7 @@ class ovsactions(nla):
>>>                   elif field[0] =3D=3D "OVS_ACTION_ATTR_TRUNC":
>>>                       print_str +=3D "trunc(%d)" % int(self.get_attr(fi=
eld[0]))
>>>                   elif field[0] =3D=3D "OVS_ACTION_ATTR_DROP":
>>> -                    print_str +=3D "drop"
>>> +                    print_str +=3D "drop(%d)" % int(self.get_attr(fiel=
d[0]))
>>>               elif field[1] =3D=3D "flag":
>>>                   if field[0] =3D=3D "OVS_ACTION_ATTR_CT_CLEAR":
>>>                       print_str +=3D "ct_clear"
>>> @@ -471,10 +471,21 @@ class ovsactions(nla):
>>>           while len(actstr) !=3D 0:
>>>               parsed =3D False
>>>               if actstr.startswith("drop"):
>>> -                # for now, drops have no explicit action, so we
>>> -                # don't need to set any attributes.  The final
>>> -                # act of the processing chain will just drop the packet
>>> -                return
>>> +                # If no reason is provided, the implicit drop is used =
(i.e no
>>> +                # action). If some reason is given, an explicit action=
 is used.
>>> +                actstr, reason =3D parse_extract_field(
>>> +                    actstr,
>>> +                    "drop(",
>>> +                    "([0-9]+)",
>>> +                    lambda x: int(x, 0),
>>> +                    False,
>>> +                    None,
>>> +                )
>>> +                if reason is not None:
>>> +                    self["attrs"].append(["OVS_ACTION_ATTR_DROP", reas=
on])
>>> +                    parsed =3D True
>>> +                else:
>>> +                    return
>>>                 elif parse_starts_block(actstr, "^(\d+)", False,
>>> True):
>>>                   actstr, output =3D parse_extract_field(
>>=20


