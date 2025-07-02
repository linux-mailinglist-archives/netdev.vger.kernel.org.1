Return-Path: <netdev+bounces-203566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC3AF65F8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7ED87A28F5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC22E03F5;
	Wed,  2 Jul 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b="RhH7sFsL"
X-Original-To: netdev@vger.kernel.org
Received: from sysclose.org (smtp.sysclose.org [69.164.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CE255F5F;
	Wed,  2 Jul 2025 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497709; cv=none; b=FWqnVSZTof0hc8ZQ3qI+11uiU1zhgByzExKKQMeoijOJoHF1U69//JXQBYLqwQNTvupip5zc+vWLPfnAQKoie5t7FwtmZynJe19fsbyOdlaxyfonCVgmF8ght5NPPinJE9hCkdys2sn16Frh83cZaHJRXQGekead/b8p6B10nRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497709; c=relaxed/simple;
	bh=5WGzoCY1/7zkGsmx8jEqA0ocGXXN4TXYPPWayhTFd7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B08abFotAxZeCE5yAMcEjJvr+oPiScQcJF1e9OFGZShL8MSl7MEQr7IMbcCPloGjsUxnBhThe+nndZhjwJ1VTby1ZiHw2o3dYCXNU9OzSMONaYuc5fbwd3DCGkhgIAHbvwOEF3lBsNBFgVeaVawy5Mq/jHTlwWHkNIsMuhip068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysclose.org; spf=pass smtp.mailfrom=sysclose.org; dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b=RhH7sFsL; arc=none smtp.client-ip=69.164.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysclose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysclose.org
Received: from uranium (unknown [131.100.62.92])
	by sysclose.org (Postfix) with ESMTPSA id 942C439674;
	Wed,  2 Jul 2025 23:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sysclose.org 942C439674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysclose.org;
	s=201903; t=1751497706;
	bh=d4Kvlqe7LxxrdwUxrWK9LUa7sqwAnfL3PtsEteMIoDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RhH7sFsLzsOpgrj8eiwgmkG3SnPr3f9PU7BhFBYYD93g1sbmg1rMXpHgdYWYMezBV
	 ueCxVhdh+dmlCmdqx165x5exBfiYxX5FdFBFI4Kgd4mPvZoY0nS0YfrccP2+jr+wiC
	 voxFyH7E1Xe9ExOOWQCHTVqHXQe7DrlW673Rky+8CbMJSXZmmhBs1M7scy8Wngea8b
	 ftWJyGAudQjwJDXR95q39h7jfFUb78B4Uc/9MtQPbAk0BSWgB9mkWTBuDSS+OscfFO
	 8if2eDhmAKeMnYcGwTBb2IfDbaS1GFXI2MJHX3VWhZNENYS3nkEZxa60q9bE43n2Ml
	 YPbe4vAXrOMHg==
Date: Wed, 2 Jul 2025 20:08:21 -0300
From: Flavio Leitner <fbl@sysclose.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: allow providing
 upcall pid for the 'execute' command
Message-ID: <20250702200821.3119cb6c@uranium>
In-Reply-To: <00067667-0329-4d8c-9c9a-a6660806b137@ovn.org>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
	<20250702105316.43017482@uranium>
	<00067667-0329-4d8c-9c9a-a6660806b137@ovn.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 16:41:19 +0200
Ilya Maximets <i.maximets@ovn.org> wrote:

> On 7/2/25 3:53 PM, Flavio Leitner wrote:
> > On Sat, 28 Jun 2025 00:01:33 +0200
> > Ilya Maximets <i.maximets@ovn.org> wrote:
> >   
> >> When a packet enters OVS datapath and there is no flow to handle it,
> >> packet goes to userspace through a MISS upcall.  With per-CPU upcall
> >> dispatch mechanism, we're using the current CPU id to select the
> >> Netlink PID on which to send this packet.  This allows us to send
> >> packets from the same traffic flow through the same handler.
> >>
> >> The handler will process the packet, install required flow into the
> >> kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.
> >>
> >> While handling OVS_PACKET_CMD_EXECUTE, however, we may hit a
> >> recirculation action that will pass the (likely modified) packet
> >> through the flow lookup again.  And if the flow is not found, the
> >> packet will be sent to userspace again through another MISS upcall.
> >>
> >> However, the handler thread in userspace is likely running on a
> >> different CPU core, and the OVS_PACKET_CMD_EXECUTE request is handled
> >> in the syscall context of that thread.  So, when the time comes to
> >> send the packet through another upcall, the per-CPU dispatch will
> >> choose a different Netlink PID, and this packet will end up processed
> >> by a different handler thread on a different CPU.  
> > 
> > 
> > The per-CPU dispatch mode is supposed to rely on the CPU context, 
> > which according with what you said above, it is working okay on 
> > the first MISS. However, when we hit a recirculation action and 
> > there is another MISS, another thread from another CPU context 
> > is selected, why?  
> 
> Because the second miss is happening while processing
> OVS_PACKET_CMD_EXECUTE, which is happening in a syscall context of a
> userspace handler thread, which is running on a different CPU.

Got it, thanks, see below.



> >   
> >>
> >> The process continues as long as there are new recirculations, each
> >> time the packet goes to a different handler thread before it is sent
> >> out of the OVS datapath to the destination port.  In real setups the
> >> number of recirculations can go up to 4 or 5, sometimes more.
> >>
> >> There is always a chance to re-order packets while processing upcalls,
> >> because userspace will first install the flow and then re-inject the
> >> original packet.  So, there is a race window when the flow is already
> >> installed and the second packet can match it and be forwarded to the
> >> destination before the first packet is re-injected.  But the fact that
> >> packets are going through multiple upcalls handled by different
> >> userspace threads makes the reordering noticeably more likely, because
> >> we not only have a race between the kernel and a userspace handler
> >> (which is hard to avoid), but also between multiple userspace
> >> handlers.
> >>
> >> For example, let's assume that 10 packets got enqueued through a MISS
> >> upcall for handler-1, it will start processing them, will install the
> >> flow into the kernel and start re-injecting packets back, from where
> >> they will go through another MISS to handler-2.  Handler-2 will
> >> install the flow into the kernel and start re-injecting the packets,
> >> while handler-1 continues to re-inject the last of the 10 packets,
> >> they will hit the flow installed by handler-2 and be forwarded
> >> without going to the handler-2, while handler-2 still re-injects the
> >> first of these 10 packets.  Given multiple recirculations and misses,
> >> these 10 packets may end up completely mixed up on the output from
> >> the datapath.
> >>
> >> Let's allow userspace to specify on which Netlink PID the packets
> >> should be upcalled while processing OVS_PACKET_CMD_EXECUTE.
> >> This makes it possible to ensure that all the packets are processed
> >> by the same handler thread in the userspace even with them being
> >> upcalled multiple times in the process.  Packets will remain in order
> >> since they will be enqueued to the same socket and re-injected in the
> >> same order.  This doesn't eliminate re-ordering as stated above, since
> >> we still have a race between kernel and the userspace thread, but it
> >> allows to eliminate races between multiple userspace threads.
> >>
> >> Userspace knows the PID of the socket on which the original upcall is
> >> received, so there is no need to send it up from the kernel.
> >>
> >> Solution requires storing the value somewhere for the duration of the
> >> packet processing.  There are two potential places for this: our skb
> >> extension or the per-CPU storage.  It's not clear which is better,
> >> so just following currently used scheme of storing this kind of things
> >> along the skb.
> >>
> >> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >> ---
> >>  include/uapi/linux/openvswitch.h |  6 ++++++
> >>  net/openvswitch/actions.c        |  6 ++++--
> >>  net/openvswitch/datapath.c       | 10 +++++++++-
> >>  net/openvswitch/datapath.h       |  3 +++
> >>  net/openvswitch/vport.c          |  1 +
> >>  5 files changed, 23 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/openvswitch.h
> >> b/include/uapi/linux/openvswitch.h index 3a701bd1f31b..3092c2c6f1d2
> >> 100644 --- a/include/uapi/linux/openvswitch.h
> >> +++ b/include/uapi/linux/openvswitch.h
> >> @@ -186,6 +186,11 @@ enum ovs_packet_cmd {
> >>   * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received
> >> fragment
> >>   * size.
> >>   * @OVS_PACKET_ATTR_HASH: Packet hash info (e.g. hash, sw_hash and
> >> l4_hash in skb).
> >> + * @OVS_PACKET_ATTR_UPCALL_PID: Netlink PID to use for upcalls while
> >> + * processing %OVS_PACKET_CMD_EXECUTE.  Takes precedence over all
> >> other ways
> >> + * to determine the Netlink PID including %OVS_USERSPACE_ATTR_PID,
> >> + * %OVS_DP_ATTR_UPCALL_PID, %OVS_DP_ATTR_PER_CPU_PIDS and the
> >> + * %OVS_VPORT_ATTR_UPCALL_PID.
> >>   *
> >>   * These attributes follow the &struct ovs_header within the Generic
> >> Netlink
> >>   * payload for %OVS_PACKET_* commands.
> >> @@ -205,6 +210,7 @@ enum ovs_packet_attr {
> >>  	OVS_PACKET_ATTR_MRU,	    /* Maximum received IP
> >> fragment size. */ OVS_PACKET_ATTR_LEN,	    /* Packet size
> >> before truncation. */ OVS_PACKET_ATTR_HASH,	    /* Packet
> >> hash. */
> >> +	OVS_PACKET_ATTR_UPCALL_PID, /* u32 Netlink PID. */
> >>  	__OVS_PACKET_ATTR_MAX
> >>  };
> >>  
> >> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> >> index 3add108340bf..2832e0794197 100644
> >> --- a/net/openvswitch/actions.c
> >> +++ b/net/openvswitch/actions.c
> >> @@ -941,8 +941,10 @@ static int output_userspace(struct datapath *dp,
> >> struct sk_buff *skb, break;
> >>  
> >>  		case OVS_USERSPACE_ATTR_PID:
> >> -			if (dp->user_features &
> >> -			    OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
> >> +			if (OVS_CB(skb)->upcall_pid)
> >> +				upcall.portid =
> >> OVS_CB(skb)->upcall_pid;
> >> +			else if (dp->user_features &
> >> +				 OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
> >>  				upcall.portid =
> >>  				  ovs_dp_get_upcall_portid(dp,
> >>  							   smp_processor_id());
> >> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> >> index b990dc83504f..ec08ce72f439 100644
> >> --- a/net/openvswitch/datapath.c
> >> +++ b/net/openvswitch/datapath.c
> >> @@ -267,7 +267,9 @@ void ovs_dp_process_packet(struct sk_buff *skb,
> >> struct sw_flow_key *key) memset(&upcall, 0, sizeof(upcall));
> >>  		upcall.cmd = OVS_PACKET_CMD_MISS;
> >>  
> >> -		if (dp->user_features &
> >> OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
> >> +		if (OVS_CB(skb)->upcall_pid)
> >> +			upcall.portid = OVS_CB(skb)->upcall_pid;
> >> +		else if (dp->user_features &
> >> OVS_DP_F_DISPATCH_UPCALL_PER_CPU) upcall.portid =
> >>  			    ovs_dp_get_upcall_portid(dp,
> >> smp_processor_id()); else
> >> @@ -616,6 +618,7 @@ static int ovs_packet_cmd_execute(struct sk_buff
> >> *skb, struct genl_info *info) struct sw_flow_actions *sf_acts;
> >>  	struct datapath *dp;
> >>  	struct vport *input_vport;
> >> +	u32 upcall_pid = 0;
> >>  	u16 mru = 0;
> >>  	u64 hash;
> >>  	int len;
> >> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff
> >> *skb, struct genl_info *info) !!(hash & OVS_PACKET_HASH_L4_BIT));
> >>  	}
> >>  
> >> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
> >> +		upcall_pid =
> >> nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
> >> +	OVS_CB(packet)->upcall_pid = upcall_pid;

Since this is coming from userspace, does it make sense to check if the
upcall_pid is one of the pids in the dp->upcall_portids array?

Otherwise the approach and patch looks good to me.
Thanks!


> >> +
> >>  	/* Build an sw_flow for sending this packet. */
> >>  	flow = ovs_flow_alloc();
> >>  	err = PTR_ERR(flow);
> >> @@ -719,6 +726,7 @@ static const struct nla_policy
> >> packet_policy[OVS_PACKET_ATTR_MAX + 1] = { [OVS_PACKET_ATTR_PROBE] =
> >> { .type = NLA_FLAG }, [OVS_PACKET_ATTR_MRU] = { .type = NLA_U16 },
> >>  	[OVS_PACKET_ATTR_HASH] = { .type = NLA_U64 },
> >> +	[OVS_PACKET_ATTR_UPCALL_PID] = { .type = NLA_U32 },
> >>  };
> >>  
> >>  static const struct genl_small_ops dp_packet_genl_ops[] = {
> >> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> >> index cfeb817a1889..db0c3e69d66c 100644
> >> --- a/net/openvswitch/datapath.h
> >> +++ b/net/openvswitch/datapath.h
> >> @@ -121,6 +121,8 @@ struct datapath {
> >>   * @cutlen: The number of bytes from the packet end to be removed.
> >>   * @probability: The sampling probability that was applied to this
> >> skb; 0 means
> >>   * no sampling has occurred; U32_MAX means 100% probability.
> >> + * @upcall_pid: Netlink socket PID to use for sending this packet to
> >> userspace;
> >> + * 0 means "not set" and default per-CPU or per-vport dispatch
> >> should be used. */
> >>  struct ovs_skb_cb {
> >>  	struct vport		*input_vport;
> >> @@ -128,6 +130,7 @@ struct ovs_skb_cb {
> >>  	u16			acts_origlen;
> >>  	u32			cutlen;
> >>  	u32			probability;
> >> +	u32			upcall_pid;
> >>  };
> >>  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
> >>  
> >> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> >> index 8732f6e51ae5..6bbbc16ab778 100644
> >> --- a/net/openvswitch/vport.c
> >> +++ b/net/openvswitch/vport.c
> >> @@ -501,6 +501,7 @@ int ovs_vport_receive(struct vport *vport, struct
> >> sk_buff *skb, OVS_CB(skb)->mru = 0;
> >>  	OVS_CB(skb)->cutlen = 0;
> >>  	OVS_CB(skb)->probability = 0;
> >> +	OVS_CB(skb)->upcall_pid = 0;
> >>  	if (unlikely(dev_net(skb->dev) !=
> >> ovs_dp_get_net(vport->dp))) { u32 mark;
> >>    
> >   
> 
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev


