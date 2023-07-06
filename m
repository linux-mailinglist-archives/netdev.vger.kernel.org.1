Return-Path: <netdev+bounces-15794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68EC749CC0
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617AC2812FB
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109918F6A;
	Thu,  6 Jul 2023 12:54:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA68F59
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 12:54:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8005C19B
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688648060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUtADlzUZGu81Oa+Ye5waGO2aAmoswfeUKSTt52w/60=;
	b=Gu9EXfeSdOXeYjzAFgc9GBLBIL/1Pn0EzU6jPrrX5pOCA3X9eRXSdJRK8n5N4EVhMTCrLj
	MTKcy0XPfH+21z9fC8tog/M1ixie6+FsF9ZbIvmUR9Y9VyCJyjg1sW4jmktXLr+dlC3NTY
	4xdlTmEH9ai0cdVkG7hc2/KMF7CULP0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-qr4UCYMFNSWIs6zfXpxCVQ-1; Thu, 06 Jul 2023 08:54:17 -0400
X-MC-Unique: qr4UCYMFNSWIs6zfXpxCVQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37DC38022EF;
	Thu,  6 Jul 2023 12:54:17 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.32.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D98CA4CD0CA;
	Thu,  6 Jul 2023 12:54:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eric Garver <eric@garver.life>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
References: <20230629203005.2137107-1-eric@garver.life>
	<20230629203005.2137107-3-eric@garver.life>
Date: Thu, 06 Jul 2023 08:54:16 -0400
In-Reply-To: <20230629203005.2137107-3-eric@garver.life> (Eric Garver's
	message of "Thu, 29 Jun 2023 16:30:05 -0400")
Message-ID: <f7tr0plgpzb.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Garver <eric@garver.life> writes:

> This adds an explicit drop action. This is used by OVS to drop packets
> for which it cannot determine what to do. An explicit action in the
> kernel allows passing the reason _why_ the packet is being dropped. We
> can then use perf tracing to match on the drop reason.
>
> e.g. trace all OVS dropped skbs
>
>  # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
>  [..]
>  106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
>   location:0xffffffffc0d9b462, protocol: 2048, reason: 196610)
>
> reason: 196610 --> 0x30002 (OVS_XLATE_RECURSION_TOO_DEEP)
>
> Signed-off-by: Eric Garver <eric@garver.life>
> ---
>  include/uapi/linux/openvswitch.h                    |  2 ++
>  net/openvswitch/actions.c                           | 13 +++++++++++++
>  net/openvswitch/flow_netlink.c                      | 12 +++++++++++-
>  .../testing/selftests/net/openvswitch/ovs-dpctl.py  |  3 +++
>  4 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index e94870e77ee9..a967dbca3574 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -965,6 +965,7 @@ struct check_pkt_len_arg {
>   * start of the packet or at the start of the l3 header depending on the value
>   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
>   * argument.
> + * @OVS_ACTION_ATTR_DROP: Explicit drop action.
>   *
>   * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
>   * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
> @@ -1002,6 +1003,7 @@ enum ovs_action_attr {
>  	OVS_ACTION_ATTR_CHECK_PKT_LEN, /* Nested OVS_CHECK_PKT_LEN_ATTR_*. */
>  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> +	OVS_ACTION_ATTR_DROP,         /* u32 xlate_error. */
>  
>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>  				       * from userspace. */
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index cab1e02b63e0..4ad9a45dc042 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -32,6 +32,7 @@
>  #include "vport.h"
>  #include "flow_netlink.h"
>  #include "openvswitch_trace.h"
> +#include "drop.h"
>  
>  struct deferred_action {
>  	struct sk_buff *skb;
> @@ -1477,6 +1478,18 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  				return dec_ttl_exception_handler(dp, skb,
>  								 key, a);
>  			break;
> +
> +		case OVS_ACTION_ATTR_DROP:
> +			u32 reason = nla_get_u32(a);
> +
> +			reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
> +					SKB_DROP_REASON_SUBSYS_SHIFT;
> +
> +			if (reason == OVS_XLATE_OK)
> +				break;
> +
> +			kfree_skb_reason(skb, reason);
> +			return 0;
>  		}
>  
>  		if (unlikely(err)) {
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index 41116361433d..23d39eae9a0d 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -39,6 +39,7 @@
>  #include <net/erspan.h>
>  
>  #include "flow_netlink.h"
> +#include "drop.h"
>  
>  struct ovs_len_tbl {
>  	int len;
> @@ -61,6 +62,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
>  		case OVS_ACTION_ATTR_RECIRC:
>  		case OVS_ACTION_ATTR_TRUNC:
>  		case OVS_ACTION_ATTR_USERSPACE:
> +		case OVS_ACTION_ATTR_DROP:
>  			break;
>  
>  		case OVS_ACTION_ATTR_CT:
> @@ -2394,7 +2396,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
>  	/* Whenever new actions are added, the need to update this
>  	 * function should be considered.
>  	 */
> -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 23);
> +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
>  
>  	if (!actions)
>  		return;
> @@ -3182,6 +3184,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>  			[OVS_ACTION_ATTR_CHECK_PKT_LEN] = (u32)-1,
>  			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
>  			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
> +			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
>  		};
>  		const struct ovs_action_push_vlan *vlan;
>  		int type = nla_type(a);
> @@ -3453,6 +3456,13 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>  			skip_copy = true;
>  			break;
>  
> +		case OVS_ACTION_ATTR_DROP:
> +			if (nla_get_u32(a) >=
> +			    u32_get_bits(OVS_XLATE_MAX,
> +					 ~SKB_DROP_REASON_SUBSYS_MASK))
> +				return -EINVAL;
> +			break;
> +

If there's a case where the userspace sends a drop reason that isn't
known to the kernel, we will reject the flow, and the only "close" drop
will be OVS_XLATE_OK, which would be wrong.  Is there a reason to do
this?  For example, userspace might get new support for some kind of
flows and during that time might have a new xlate drop reason.  Maybe we
can have a reason code that OVS knows will exist, so that if this fails,
it can at least fall back to that?

>  		default:
>  			OVS_NLERR(log, "Unknown Action type %d", type);
>  			return -EINVAL;
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 1c8b36bc15d4..526ebad7d514 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -115,6 +115,7 @@ class ovsactions(nla):
>          ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
>          ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
>          ("OVS_ACTION_ATTR_DEC_TTL", "none"),
> +        ("OVS_ACTION_ATTR_DROP", "uint32"),
>      )
>  
>      class ctact(nla):
> @@ -261,6 +262,8 @@ class ovsactions(nla):
>                      print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
>                  elif field[0] == "OVS_ACTION_ATTR_TRUNC":
>                      print_str += "trunc(%d)" % int(self.get_attr(field[0]))
> +                elif field[0] == "OVS_ACTION_ATTR_DROP":
> +                    print_str += "drop"

Can we also include the reason here?

>              elif field[1] == "flag":
>                  if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
>                      print_str += "ct_clear"


