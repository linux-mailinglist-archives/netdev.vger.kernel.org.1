Return-Path: <netdev+bounces-48844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B627EFAE3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F828B2113E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B345C18;
	Fri, 17 Nov 2023 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="p00leyVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F9A4EC8
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 13:22:14 -0800 (PST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E9AD93F6EA
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1700256113;
	bh=5J15n0DumILWx7SDMh94CiMvj1bFSDpJJjB4n/vDVwI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=p00leyVOL9qmYvfooS1X0MSRYGGtIAcjk4hRY76284FqH/B9Aa9sueAzGL/3f+KBt
	 5QFVvrv9k7OtkGP9P/2U6D1lc5jMIhJRWSGXzbi6S0jag4zpqZG/sdJ1E5dWAsvHK5
	 j81Ck3mGlAoweydfL8dRF+HQg+3729HnhuPryHRKy8B8W8/snp27EvJGsUUYwt7/3t
	 JkVEgXgFFdVNFyxJf/nGz3xN8HyZIQI3bO4Lt5WKY1scsGeYvmYcWTi7MCh9kC14bO
	 sj9Rnh427+Onl93W1GYcKScrHPq5Y8LwCZDRH3VBbvy6agkJDAFWNObT8tPquqOeuM
	 hfCTWknZG84cQ==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6c415e09b1bso2920155b3a.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 13:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256112; x=1700860912;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5J15n0DumILWx7SDMh94CiMvj1bFSDpJJjB4n/vDVwI=;
        b=VFNTpw9WxDh6BUvapF3ZxK8ubuPC5Eqi0eIPPgHlqHhUBds4iDNp8X2z0xe711vfCu
         dpzhU2dt3vq/Qd9NkZsVAOkJrmeZYgA4NNVia/Xd6KkNuPdbUexMtS2dC2XLcFwlagRf
         w7v1+xfhJflNA45yOKet9WsRcvfIGXspsVOlg0lBj5vb9XkiDIwNGkZH1hWVhd2sBt4e
         6wxUf06xa27qdtV+1Wzsy4eF6BuIe1YBc078LSR9K7Ic+UjQdY713zsQLcpx7nWfz1lS
         MNVx4y4ulwrRTCnan/uIYA52LF1YYxkvDlThc+mfXWjgdDpNUnKAGVUcoor4H3RpfYnH
         zLcA==
X-Gm-Message-State: AOJu0Yy8hLsvb55t052l8M0VYIYbxVpCq7/BO2uHIgnVqS9xAedfyqTp
	+SAHr7C6s9ODzoAC0PIGRLk+PiG/JHCh2/t4FvwtTF5/y/MytanjGJsYfrma/mYb9rm9ztAvPnt
	l7A1Qn6NghXVJWRF8W1ITPPOQJuCDRdP32w==
X-Received: by 2002:a05:6a20:1604:b0:185:a90d:363d with SMTP id l4-20020a056a20160400b00185a90d363dmr460044pzj.2.1700256112352;
        Fri, 17 Nov 2023 13:21:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs9NUykGmiYhWkZ0fjrTKNzsnPDQo3m7H9Ou3z9znKp8usSNZUNQciI3u4r0o9ei+gGVC6pg==
X-Received: by 2002:a05:6a20:1604:b0:185:a90d:363d with SMTP id l4-20020a056a20160400b00185a90d363dmr460019pzj.2.1700256111848;
        Fri, 17 Nov 2023 13:21:51 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id x27-20020aa793bb000000b006c33c82da66sm1820186pff.75.2023.11.17.13.21.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Nov 2023 13:21:51 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 16AED5FFF6; Fri, 17 Nov 2023 13:21:51 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 105F79F88E;
	Fri, 17 Nov 2023 13:21:51 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: "Ertman, David M" <david.m.ertman@intel.com>
cc: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
    "Nguyen,
    Anthony L" <anthony.l.nguyen@intel.com>,
    "davem@davemloft.net" <davem@davemloft.net>,
    "kuba@kernel.org" <kuba@kernel.org>,
    "pabeni@redhat.com" <pabeni@redhat.com>,
    "edumazet@google.com" <edumazet@google.com>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "Wyborny,
    Carolyn" <carolyn.wyborny@intel.com>,
    "daniel.machon@microchip.com" <daniel.machon@microchip.com>,
    "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
    "Buvaneswaran,
    Sujai" <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a failed over aggregate
In-reply-to: <MW5PR11MB5811E4210635755D5D59FE34DDB7A@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231115211242.1747810-1-anthony.l.nguyen@intel.com> <ZVYllBDzdLIB97e2@boxer> <MW5PR11MB5811FEDAF2D1E3113C3ADCD9DDB0A@MW5PR11MB5811.namprd11.prod.outlook.com> <ZVema0m2Pw6+VYTF@boxer> <MW5PR11MB5811E4210635755D5D59FE34DDB7A@MW5PR11MB5811.namprd11.prod.outlook.com>
Comments: In-reply-to "Ertman, David M" <david.m.ertman@intel.com>
   message dated "Fri, 17 Nov 2023 18:17:05 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10020.1700256111.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Nov 2023 13:21:51 -0800
Message-ID: <10021.1700256111@famine>

Ertman, David M <david.m.ertman@intel.com> wrote:

>> -----Original Message-----
>> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
>> Sent: Friday, November 17, 2023 9:44 AM
>> To: Ertman, David M <david.m.ertman@intel.com>
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
>> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
>> edumazet@google.com; netdev@vger.kernel.org; Wyborny, Carolyn
>> <carolyn.wyborny@intel.com>; daniel.machon@microchip.com; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
>> <sujai.buvaneswaran@intel.com>
>> Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a fa=
iled
>> over aggregate
>> =

>> On Thu, Nov 16, 2023 at 10:36:37PM +0100, Ertman, David M wrote:
>> > > -----Original Message-----
>> > > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
>> > > Sent: Thursday, November 16, 2023 6:22 AM
>> > > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
>> > > Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
>> > > edumazet@google.com; netdev@vger.kernel.org; Ertman, David M
>> > > <david.m.ertman@intel.com>; Wyborny, Carolyn
>> > > <carolyn.wyborny@intel.com>; daniel.machon@microchip.com; Kitszel,
>> > > Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
>> > > <sujai.buvaneswaran@intel.com>
>> > > Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in =
a failed
>> > > over aggregate
>> > >
>> > > On Wed, Nov 15, 2023 at 01:12:41PM -0800, Tony Nguyen wrote:
>> > > > From: Dave Ertman <david.m.ertman@intel.com>
>> > > >
>> > > > There is an error when an interface has the following conditions:
>> > > > - PF is in an aggregate (bond)
>> > > > - PF has VFs created on it
>> > > > - bond is in a state where it is failed-over to the secondary int=
erface
>> > > > - A VF reset is issued on one or more of those VFs
>> > > >
>> > > > The issue is generated by the originating PF trying to rebuild or
>> > > > reconfigure the VF resources.  Since the bond is failed over to t=
he
>> > > > secondary interface the queue contexts are in a modified state.
>> > > >
>> > > > To fix this issue, have the originating interface reclaim its res=
ources
>> > > > prior to the tear-down and rebuild or reconfigure.  Then after th=
e
>> process
>> > > > is complete, move the resources back to the currently active inte=
rface.
>> > > >
>> > > > There are multiple paths that can be used depending on what trigg=
ered
>> the
>> > > > event, so create a helper function to move the queues and use pai=
red
>> calls
>> > > > to the helper (back to origin, process, then move back to active
>> interface)
>> > > > under the same lag_mutex lock.
>> > > >
>> > > > Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support fo=
r
>> SRIOV
>> > > on bonded interface")
>> > > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
>> > > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> > > > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
>> > > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> > > > ---
>> > > > This is the net patch mentioned yesterday:
>> > > > https://lore.kernel.org/netdev/71058999-50d9-cc17-d940-
>> > > 3f043734e0ee@intel.com/
>> > > >
>> > > >  drivers/net/ethernet/intel/ice/ice_lag.c      | 42
>> +++++++++++++++++++
>> > > >  drivers/net/ethernet/intel/ice/ice_lag.h      |  1 +
>> > > >  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 20 +++++++++
>> > > >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 25 +++++++++++
>> > > >  4 files changed, 88 insertions(+)
>> > > >
>> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
>> > > b/drivers/net/ethernet/intel/ice/ice_lag.c
>> > > > index cd065ec48c87..9eed93baa59b 100644
>> > > > --- a/drivers/net/ethernet/intel/ice/ice_lag.c
>> > > > +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>> > > > @@ -679,6 +679,48 @@ static void ice_lag_move_vf_nodes(struct
>> ice_lag
>> > > *lag, u8 oldport, u8 newport)
>> > > >  			ice_lag_move_single_vf_nodes(lag, oldport,
>> > > newport, i);
>> > > >  }
>> > > >
>> > > > +/**
>> > > > + * ice_lag_move_vf_nodes_cfg - move VF nodes outside LAG netdev
>> > > event context
>> > > > + * @lag: local lag struct
>> > > > + * @src_prt: lport value for source port
>> > > > + * @dst_prt: lport value for destination port
>> > > > + *
>> > > > + * This function is used to move nodes during an out-of-netdev-e=
vent
>> > > situation,
>> > > > + * primarily when the driver needs to reconfigure or recreate
>> resources.
>> > > > + *
>> > > > + * Must be called while holding the lag_mutex to avoid lag event=
s from
>> > > > + * processing while out-of-sync moves are happening.  Also, pair=
ed
>> > > moves,
>> > > > + * such as used in a reset flow, should both be called under the=
 same
>> > > mutex
>> > > > + * lock to avoid changes between start of reset and end of reset=
.
>> > > > + */
>> > > > +void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, =
u8
>> > > dst_prt)
>> > > > +{
>> > > > +	struct ice_lag_netdev_list ndlist, *nl;
>> > > > +	struct list_head *tmp, *n;
>> > > > +	struct net_device *tmp_nd;
>> > > > +
>> > > > +	INIT_LIST_HEAD(&ndlist.node);
>> > > > +	rcu_read_lock();
>> > > > +	for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
>> > >
>> > > Why do you need rcu section for that?
>> > >
>> > > under mutex? lacking context here.
>> > >
>> >
>> > Mutex lock is to stop lag event thread from processing any other even=
t
>> until
>> > after the asynchronous reset is processed.  RCU lock is to stop upper=
 kernel
>> > bonding driver from changing elements while reset is building a list.
>> =

>> Can you point me to relevant piece of code for upper kernel bonding
>> driver? Is there synchronize_rcu() on updates?
>
>Here is the benning of the bonding struct from /include/net/bonding.h
>
>/*
> * Here are the locking policies for the two bonding locks:
> * Get rcu_read_lock when reading or RTNL when writing slave list.
> */
>struct bonding {
>	struct   net_device *dev; /* first - useful for panic debug */
>	struct   slave __rcu *curr_active_slave;
>	struct   slave __rcu *current_arp_slave;
>	struct   slave __rcu *primary_slave;
>	struct   bond_up_slave __rcu *usable_slaves;
>	struct   bond_up_slave __rcu *all_slaves;
>
>> >
>> > > > +		nl =3D kzalloc(sizeof(*nl), GFP_ATOMIC);
>> > >
>> > > do these have to be new allocations or could you just use list_move=
?
>> > >
>> >
>> > Building a list from scratch - nothing to move until it is created.
>> =

>> Sorry got confused.
>> =

>> Couldn't you keep the up-to-date list of netdevs instead? And avoid all
>> the building list and then deleting it after processing event?
>> =

>
>The bonding driver is generating netdev events for things changing in the=
 aggregate. The ice
>driver's event handler which takes a snapshot of the members of the bond =
and creates a work
>item which gets put on the event processing thread and then returns.  The=
 events are processed
>one at a time in sequence asynchronously to the event handler on the proc=
essing thread.  The
>contents of the member list for the work item is only valid for that work=
 item and cannot be used
>for a reset event happening asynchronously to the processing queue.

	Why is ice keeping track of the bonding state?  I see there's
also concurrently a patch [0] to block PF reinitialization if attached
to a bond, as well as some upstream discussion regarding ice issues with
bonding and SR-IOV [1], are these things related in some way?

	Whatever that reason is, should the logic apply to other drivers
that do similar things?  For example, team and openvswitch both have
functionality that is largely similar to what bonding does, so I'm
curious as to what specifically is going on that requires special
handling on the part of the device driver.

	-J

[0] =

https://lore.kernel.org/netdev/20231117164427.912563-1-sachin.bahadur@inte=
l.com/

[1]
https://lore.kernel.org/lkml/CC024511-980A-4508-8ABF-659A04367C2B@gmail.co=
m/T/#mde6cc7110fedf54771aa3c13044ae6c0936525fb

>Thanks, =

>DaveE
>
>> >
>> > > > +		if (!nl)
>> > > > +			break;
>> > > > +
>> > > > +		nl->netdev =3D tmp_nd;
>> > > > +		list_add(&nl->node, &ndlist.node);
>> > >
>> > > list_add_rcu ?
>> > >
>> >
>> > I thought list_add_rcu was for internal list manipulation when prev a=
nd
>> next
>> > Are both known and defined?
>> =

>> First time I hear this TBH but disregard the suggestion.
>> =

>> >
>> > > > +	}
>> > > > +	rcu_read_unlock();
>> > >
>> > > you have the very same chunk of code in
>> ice_lag_move_new_vf_nodes().
>> > > pull
>> > > this out to common function?
>> > >
>> > > ...and in ice_lag_rebuild().
>> > >
>> >
>> > Nice catch - for v2, pulled out code into two helper function:
>> > ice_lag_build_netdev_list()
>> > Iie_lag_destroy_netdev_list()
>> >
>> >
>> > > > +	lag->netdev_head =3D &ndlist.node;
>> > > > +	ice_lag_move_vf_nodes(lag, src_prt, dst_prt);
>> > > > +
>> > > > +	list_for_each_safe(tmp, n, &ndlist.node) {
>> > >
>> > > use list_for_each_entry_safe()
>> > >
>> >
>> > Changed in v2.
>> >
>> > > > +		nl =3D list_entry(tmp, struct ice_lag_netdev_list, node);
>> > > > +		list_del(&nl->node);
>> > > > +		kfree(nl);
>> > > > +	}
>> > > > +	lag->netdev_head =3D NULL;
>> >
>> > Thanks for the review!
>> > DaveE
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

