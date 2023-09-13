Return-Path: <netdev+bounces-33528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2000A79E5CD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD257280A4E
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602181E528;
	Wed, 13 Sep 2023 11:04:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF5210D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:04:57 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5488419A6
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:04:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b85eso72489835e9.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694603095; x=1695207895; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tnu5IidHjjqv1VobjTTgjZWTEl6tsxw73y2R8jLEqMA=;
        b=J8Ru3oMxrQNjUbkgBSneTSYSeCzXaCzbaDSyMXqwNUcDdNXBBOq5sofysX01ch0OP6
         PiAI/a9QVOIEsyG4nlaLxlC9YASLtrspuKhCoCFXg0rvOwA3qREPqig5fGOarGx8nFql
         Y61zrZKbLGyDve/19ZayLKpoE9Q9Tj5v64S+FRYvjo0eHwwltPGRwgXfSNZ7rSzHTcd3
         HlHmpZUjo1w12kDKdC1sAJ02AN4NQhVW9cq3ygSvlCfqyHnNCQU+WsE1gojfbP7Ha5Qg
         qpuvVv/5XokNJ4UD9Us8LSXae4+1kZyby72Cc2BbsUchWXHVoHKvp3jj8hgMNer/dfll
         EpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603095; x=1695207895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnu5IidHjjqv1VobjTTgjZWTEl6tsxw73y2R8jLEqMA=;
        b=jUa1uFbMOtvUP+P2MwvDNwDCoqEsTSLa0gY7TUDyfyrKuHeeLLmHZZDApOONVjixdS
         1Stc8dm+uLdCrKhE1DW0ixgj7cbYCinsC7uEzRaEasljtKpi33phwuj6KpajSZ+HqVmt
         o/feU7ofE8zPa8WmUUM/zzX6McJ+5ziyz1GKOC9YGwRQ4mIQq0ZIK4P6L3u7+DFxL8IH
         Tv019gGqDNimGba8Jy1Mtq9JQfcrCb1m/pAxumbkx0hd6mSRL89/7kcJRMZuEO0oHA5P
         YY+lkTgLFLvj+HCjfwdE0Bl38QDIQWLxu+qhN8iobFx2pY0TR42abt42QJsCsZwCjAm5
         RuSA==
X-Gm-Message-State: AOJu0YxP4/Rl1gqVEhfLbQH4nWtFZB3uuTC/eYtS2vEatAf6w5u/4EfI
	Fvus6OdnkfEPeObITVR59tecNw==
X-Google-Smtp-Source: AGHT+IEGhiaLCwkAeW+drA2/U2i92cBb9q0h6wQsIUr/HwSzKpBvqc3DhTdsLR9yKrQouYfDfT+roA==
X-Received: by 2002:a05:600c:2147:b0:3f9:c82e:9d87 with SMTP id v7-20020a05600c214700b003f9c82e9d87mr1789996wml.13.1694603094658;
        Wed, 13 Sep 2023 04:04:54 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y14-20020a7bcd8e000000b004030e8ff964sm1711103wmj.34.2023.09.13.04.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:04:54 -0700 (PDT)
Date: Wed, 13 Sep 2023 13:04:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, leon@kernel.org, ye.xingchen@zte.com.cn,
	liuhangbin@gmail.com
Subject: Re: [PATCH net v4] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <ZQGXVQZ/koVlo4jj@nanopsycho>
References: <20230911094636.3256542-1-william.xuanziyang@huawei.com>
 <2910908aeafc8ff133168045ee19f290a7bb35e0.camel@redhat.com>
 <2cad19f1-552b-792f-f074-daadd8753a59@huawei.com>
 <06082c443dbaf83495dde16c33884adc30872ec8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06082c443dbaf83495dde16c33884adc30872ec8.camel@redhat.com>

Wed, Sep 13, 2023 at 08:28:13AM CEST, pabeni@redhat.com wrote:
>On Wed, 2023-09-13 at 14:15 +0800, Ziyang Xuan (William) wrote:
>> > > diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>> > > index d3dc22509ea5..12fb5f4cff06 100644
>> > > --- a/drivers/net/team/team.c
>> > > +++ b/drivers/net/team/team.c
>> > > @@ -2127,7 +2127,10 @@ static const struct ethtool_ops
>> > > team_ethtool_ops = {
>> > >  static void team_setup_by_port(struct net_device *dev,
>> > >  			       struct net_device *port_dev)
>> > >  {
>> > > -	dev->header_ops	= port_dev->header_ops;
>> > > +	if (port_dev->type == ARPHRD_ETHER)
>> > > +		dev->header_ops	= &eth_header_ops;
>> > > +	else
>> > > +		dev->header_ops	= port_dev->header_ops;
>> > >  	dev->type = port_dev->type;
>> > >  	dev->hard_header_len = port_dev->hard_header_len;
>> > >  	dev->needed_headroom = port_dev->needed_headroom;
>> > 
>> > If I read correctly, for !vlan_hw_offload_capable() lower dev,
>> > egress
>> > packets going trough the team device will not contain the vlan tag.
>> > 
>> > Additionally, why is vlan special? Why others lower devices with
>> > custom
>> > header_ops do not need any care? 
>> 
>> We have also got ipvlan device problem as following:
>> 
>> BUG: KASAN: slab-out-of-bounds in ipvlan_hard_header+0xd1/0xe0
>> Read of size 8 at addr ffff888018ee1de8 by task syz-executor.1/3469
>> ...
>> Call Trace:
>>  <IRQ>
>>  dump_stack+0xbe/0xfd
>>  print_address_description.constprop.0+0x19/0x170
>>  ? ipvlan_hard_header+0xd1/0xe0
>>  __kasan_report.cold+0x6c/0x84
>>  ? ipvlan_hard_header+0xd1/0xe0
>>  kasan_report+0x3a/0x50
>>  ipvlan_hard_header+0xd1/0xe0
>>  ? ipvlan_get_iflink+0x40/0x40
>>  neigh_resolve_output+0x28f/0x410
>>  ip6_finish_output2+0x762/0xef0
>>  ? ip6_frag_init+0xf0/0xf0
>>  ? nf_nat_icmpv6_reply_translation+0x460/0x460
>>  ? do_add_counters+0x370/0x370
>>  ? do_add_counters+0x370/0x370
>>  ? ipv6_confirm+0x1ee/0x360
>>  ? nf_ct_bridge_unregister+0x50/0x50
>>  __ip6_finish_output.part.0+0x1a8/0x400
>>  ip6_finish_output+0x1a9/0x1e0
>>  ip6_output+0x146/0x2b0
>>  ? ip6_finish_output+0x1e0/0x1e0
>>  ? __ip6_finish_output+0xb0/0xb0
>>  ? __sanitizer_cov_trace_switch+0x50/0x90
>>  ? nf_hook_slow+0xa3/0x150
>>  mld_sendpack+0x3d9/0x670
>>  ? mca_alloc+0x210/0x210
>>  ? add_grhead+0xf5/0x140
>>  ? ipv6_icmp_sysctl_init+0xd0/0xd0
>>  ? add_grec+0x4e1/0xa90
>>  ? _raw_spin_lock_bh+0x85/0xe0
>>  ? _raw_read_unlock_irqrestore+0x30/0x30
>>  mld_send_cr+0x426/0x630
>>  ? migrate_swap_stop+0x400/0x400
>>  mld_ifc_timer_expire+0x22/0x240
>>  ? ipv6_mc_netdev_event+0x80/0x80
>>  call_timer_fn+0x3d/0x230
>>  ? ipv6_mc_netdev_event+0x80/0x80
>>  expire_timers+0x190/0x270
>>  run_timer_softirq+0x22c/0x560
>> 
>> ipvlan problem is slightly different from vlan.
>> 
>> // add ipvlan to team device
>> team_port_add
>>   team_dev_type_check_change
>>     team_setup_by_port // assign ipvlan_header_ops to team_dev-
>> >header_ops	
>>   netdev_rx_handler_register // fail out without restore team_dev-
>> >header_ops
>> 
>> // add other ether type device to team device
>> team_port_add
>>   team_dev_type_check_change // return directly because port_dev-
>> >type and team_dev->type are same
>> 
>> team_dev->head_ops has be assigned to ipvlan_header_ops. That will
>> trigger excption.
>
>To me both cases look the same in the end: the team driver sets and use
>header_ops of a different device that will assume dev_priv() being a
>different struct.
>
>I'm guessing a generic solution could be implementing 'trampoline'
>header_ops that just call into the lower port corresponding op, and
>assigning such ops to the team device every time the lower has non
>ethernet header_ops.
>
>team_dev_type_check_change() should then probably check both dev->type
>and dev->header_ops.
>
>> > Exporting 'eth_header_ops' for team's sake only looks a bit too
>> > much to
>> > me. I think could instead cache the header_ops ptr after the
>> > initial
>> > ether_setup().
>> 
>> Is it possible to use ether_setup() like bonding driver andmodify MTU
>> individually later?
>
>That could be another option to get the eth_header_ops.
>
>Note that in the end both are quite similar, you will have to cache
>some info (the mtu with the latter); ether_setup() possibly will have
>more side effects, as it touches many fields. I personally would use
>the thing I suggested above.

Agreed. That is why ether_setup() was not used in the first place.


>
>Cheers,
>
>Paolo
>

