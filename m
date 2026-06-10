Return-Path: <netdev+bounces-297812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mfxmAQO+KWprcgMAu9opvQ
	(envelope-from <netdev+bounces-297812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68C66C8B6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:41:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SzNG84RE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297812-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54533047428
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08C3546FC;
	Wed, 10 Jun 2026 19:41:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCA17BB21
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:41:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120495; cv=none; b=PrSAyKAgeg2Wjoo2ZF2ZddlUamx2arQu4FpNG4k1qHspbfwq42g1/rCLAkI7V35yQ76CFho7dhJvSlnlJPdiNPM9JDXH8b+Oo5/KCmjIAaZRjLdWVUJAX2qrh63tMGoiWdnHxleyOcydmDoXbCxalLCAByeNlbWhZB/FmgRC1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120495; c=relaxed/simple;
	bh=VMyksX1H8QixVprg1c0D5jdm3y8bBDuMeYDw/6mXCzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE1wyRF7mC1fhY3Si0H+RZFrYxgxAWCxMxmwEZkbZyswn25mUlN63GPwpE9BI+DRO1VIgzhaJUWc3JolpXoX3vWOiSx2Xkul83mRTNbe4wv5oe66D2dZTRAE3IN3XJJzgF2ozVr4BjmK2C3Ouu8miVaJekEeEpk/VjFxdj3wDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzNG84RE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26EC1F00893;
	Wed, 10 Jun 2026 19:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781120493;
	bh=FFwSpWo6ng/SJN4QypHCZsShvbJkSJP4HOyREWhKSJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SzNG84REjHej9KTavL06bGtaXPGmq/e8GRvDnb1DQfL/ikBeTwP3BJbepthNwT4hm
	 lCHOviRrGHWnjq7ayUqULG4dOgs6gkkYY19T/Jlf6wp3MNLLJIKr9kiDuHa5ywOsiv
	 FDesNBtmNgd4mZFbwYqbWyqnhMkd+38NoREpAxbti5gf1lhIDl76vPa9bSbOXtnZVX
	 MNtNEoO02A9aVY1qy6hu6/PcUw69MmnBDJo75Vic9AGqp5Jf5xdGms85lJlHgIkp7N
	 gfvIjJXpZSpWl29WggA8tFfJj2msCxlDNRZ/HMyme8BZVTCU3SYd4V0rHqEXjUFrOi
	 AYkAb9DxNMn4Q==
Date: Wed, 10 Jun 2026 12:41:33 -0700
From: Kees Cook <kees@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Johan Thomsen <write@ownrisk.dk>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [BUG] FORTIFY: memcpy overflow in skb_tunnel_info_unclone() from
 geneve_xmit()
Message-ID: <202606101240.85F6F74@keescook>
References: <CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com>
 <18972686-936d-4fb0-850f-7e212c48ab97@ovn.org>
 <CAKv6aAPoo98bZ-oRk34huUtD3=j7EuGcL2sOLBB_rwzf4vpj3A@mail.gmail.com>
 <6831f6a7-7321-4657-8255-28252b1a3176@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6831f6a7-7321-4657-8255-28252b1a3176@ovn.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:write@ownrisk.dk,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:dev@openvswitch.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kees@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297812-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,keescook:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E68C66C8B6

On Wed, Jun 10, 2026 at 08:00:53PM +0200, Ilya Maximets wrote:
> On 6/10/26 3:10 PM, Johan Thomsen wrote:
> > Hi Ilya,
> > 
> > Sorry for the late follow-up.
> > Your patch has now run without crashes in my setup for 36 hours and
> > I'm unable to re-trigger a panic.
> > 
> >> But the operation in the diff above is kind of pointless as the memcpy
> >> itself will copy the value again.
> > 
> > Right. So it would probably need at least a comment, if that ends up
> > becoming the final fix.
> > I'm not a kernel dev and I don't know what is the right thing to do here.
> > 
> > Happy to test alternative patches if needed.
> 
> OK.  Thanks for testing.
> 
> > 
> > BR
> > Johan
> > 
> > Den man. 8. jun. 2026 kl. 11.41 skrev Ilya Maximets <i.maximets@ovn.org>:
> >>
> >> On 6/8/26 10:25 AM, Johan Thomsen wrote:
> >>> Hello,
> >>>
> >>> I am seeing what looks like a kernel bug in the Geneve/OVS/vhost
> >>> transmit path on a Talos Linux node running Kube-ovn with Geneve
> >>> overlay and KubeVirt VM traffic.
> >>>
> >>> Environment:
> >>>
> >>> Kernel: 6.18.33-talos
> >>> Distro: Talos v1.13.3
> >>>
> >>> Compiler/config:
> >>>
> >>> CONFIG_CC_VERSION_TEXT="clang version 22.1.2"
> >>> CONFIG_CC_IS_CLANG=y
> >>> CONFIG_LTO=y
> >>> CONFIG_LTO_CLANG=y
> >>> CONFIG_LTO_CLANG_THIN=y
> >>> CONFIG_FORTIFY_SOURCE=y
> >>>
> >>> Hardware: HPE ProLiant DL325 Gen11, AMD EPYC
> >>>
> >>> NIC driver: bnxt_en
> >>>
> >>> Workload/network:
> >>>
> >>> Kube-OVN, Geneve overlay
> >>> Open vSwitch datapath
> >>> KubeVirt/QEMU VM traffic via vhost/tap
> >>>
> >>> Relevant console output:
> >>>
> >>> [  648.742603] memcpy: detected buffer overflow: 104 byte write of
> >>> buffer size 96
> >>> [  648.749907] WARNING: CPU: 61 PID: 27020 at
> >>> lib/string_helpers.c:1036 __fortify_report+0x45/0x60
> >>> [  648.758689] Modules linked in: dm_round_robin dm_multipath lpfc
> >>> nvmet_fc nvmet intel_rapl_msr intel_rapl_common ahci nvme_auth bnxt_en
> >>> nvme hpilo hkdf libahci sp5100_tco watchdog k10temp
> >>> [  648.775429] CPU: 61 UID: 107 PID: 27020 Comm: vhost-27002 Not
> >>> tainted 6.18.29-talos #1 PREEMPT(none)
> >>> [  648.784735] Hardware name: HPE ProLiant DL325 Gen11/ProLiant DL325
> >>> Gen11, BIOS 2.84 11/05/2025
> >>> [  648.890478]  skb_tunnel_info_unclone+0x179/0x190
> >>> [  648.895152]  geneve_xmit+0x7fe/0xe00
> >>> [  648.907240]  dev_hard_start_xmit+0xa7/0x1f0
> >>> [  648.911479]  __dev_queue_xmit+0x864/0xf40
> >>> [  648.919688]  do_execute_actions+0x9b9/0x1be0
> >>> [  648.927727]  ovs_execute_actions+0x58/0x170
> >>> [  648.931960]  ovs_dp_process_packet+0xb1/0x1c0
> >>> [  648.936370]  ovs_vport_receive+0x90/0x100
> >>> [  648.940428]  netdev_frame_hook+0x146/0x1a0
> >>> [  648.954093]  __netif_receive_skb+0x3f/0x160
> >>> [  648.958324]  process_backlog+0x10c/0x210
> >>> [  648.962295]  __napi_poll+0x2f/0x190
> >>> [  648.965832]  net_rx_action+0x2e3/0x500
> >>> [  648.969632]  handle_softirqs+0xe7/0x310
> >>> [  648.985387]  tun_get_user+0x137e/0x1510
> >>> [  649.005878]  handle_tx+0x41f/0xd30
> >>> [  649.029014]  vhost_run_work_list+0x52/0x90
> >>> [  649.033162]  vhost_task_fn+0xc2/0x140
> >>> [  649.064145] ---[ end trace 0000000000000000 ]---
> >>> [  649.068820] ------------[ cut here ]------------
> >>> [  649.073489] kernel BUG at lib/string_helpers.c:1043!
> >>>
> >>> I don't know whether this is a real overflow or a FORTIFY false-positive.
> >>
> >> Looks like a false-positive from the __counted_by fortification.
> >>
> >> I'd guess something like this would fit it:
> >>
> >> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> >> index 1fc2fb03ce3f9..e51c3795da474 100644
> >> --- a/include/net/dst_metadata.h
> >> +++ b/include/net/dst_metadata.h
> >> @@ -164,6 +164,7 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
> >>         if (!new_md)
> >>                 return ERR_PTR(-ENOMEM);
> >>
> >> +       new_md->u.tun_info.options_len = md_size;
> >>         memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> >>                sizeof(struct ip_tunnel_info) + md_size);
> >>  #ifdef CONFIG_DST_CACHE
> >> ---
> >>
> >> Johan, could you try this in your setup?
> >>
> >> The memory was actually allocated for the options, but the structure
> >> is zeroed out on allocation, so the __counted_by check doesn't work
> >> properly for the initial initialization copy.
> >>
> >> But the operation in the diff above is kind of pointless as the memcpy
> >> itself will copy the value again.  So, I'm not sure if that's the right
> >> solution here.
> >>
> >> Alternative might be to revert the kmalloc_flex back to the simple
> >> kmalloc in metadata_dst_alloc.
> 
> A little less icky alternative might be to just split the copy in two:
> 
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 1fc2fb03ce3f9..996ae8350360a 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -164,8 +164,12 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>  	if (!new_md)
>  		return ERR_PTR(-ENOMEM);
>  
> +	/* Copy in two stages to keep the __counted_by happy. */
>  	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> -	       sizeof(struct ip_tunnel_info) + md_size);
> +	       sizeof(struct ip_tunnel_info));
> +	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
> +	       ip_tunnel_info_opts(&md_dst->u.tun_info),
> +	       md_size);
>  #ifdef CONFIG_DST_CACHE
>  	/* Unclone the dst cache if there is one */
>  	if (new_md->u.tun_info.dst_cache.cache) {
> ---
> 
> Adding netdev maintainers for more opinions.
> 
> >>
> >> CC: Kees

Yeah, I think the split makes the most sense. This matches the proper
spans, and is what we've done in the past in several places. It'll all
get collapsed into the same binary output in most cases, so there's no
real down-side.

-Kees

-- 
Kees Cook

