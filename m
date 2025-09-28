Return-Path: <netdev+bounces-226959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EBEBA653C
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 03:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1441897266
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5253C1DB125;
	Sun, 28 Sep 2025 01:06:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480034BA42
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759021571; cv=none; b=S/ssGk60fOEMU6TJ20+P7g5XkCAuFdicbKq+MzKUBRvsrIqDBDIz8vgCKYwqqtmxY9VyZ+OK+NFfAGMW79bQB2xdZjmofjDe9ZlO2wdjzTi9/2B2PrC7St/+J1c8l34Eqv7YlH76jlyNbQZ6kO/4lilx2hksFOg1DF5rDwXF3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759021571; c=relaxed/simple;
	bh=RY0MYJFQOSF7kdsghhPFyjM2aypwXecHKpLOmR6koQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iGWvuDQY1FjPQ1CvXqLtHr2mK2hRd5YfocztvhkIbOAnddcCsMasikfoSJyc8bT89QxI5759ig0L2Ti+2KECmO2OpDtxgfOjXgkA5g4mYGUCTWA2h9xpIZAi0b4qmNYTj6tkc0Uwioe15J7Nv1Ua0yg3qIk9rqE0TFKNM//1m8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58S165Ad006793;
	Sun, 28 Sep 2025 10:06:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58S165LM006787
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Sep 2025 10:06:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9f999251-8132-414e-9ea1-f83ecc41dfdd@I-love.SAKURA.ne.jp>
Date: Sun, 28 Sep 2025 10:06:05 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unregister_netdevice: waiting for batadv_slave_0 to become free.
 Usage count = 2
To: Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <marek.lindner@mailbox.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <antonio@mandelbit.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
References: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
 <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
 <2754825.KlZ2vcFHjT@sven-desktop>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2754825.KlZ2vcFHjT@sven-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

Thank you for responding quickly.

On 2025/09/28 2:21, Sven Eckelmann wrote:
> The question would now be: what is the actual problem? 

Sorry, my explanation was not clear enough.

What I thought as a problem is the difference between

	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, "batadv0", 0, 0);
	//netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);

and

	netlink_device_change(&nlmsg, sock, "batadv_slave_0", false, "batadv0", 0, 0);
	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);

. The former makes hard_iface->if_status == BATADV_IF_ACTIVE while the latter makes
hard_iface->if_status == BATADV_IF_TO_BE_ACTIVATED (because batadv_iv_ogm_schedule_buff()
is not called).

This difference makes operations that depend on hard_iface->if_status == BATADV_IF_ACTIVE
impossible to work properly. You can confirm this difference using diff show below.

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -761,6 +761,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,

        batadv_check_known_mac_addr(hard_iface);

+       pr_info("step 1: %d\n", hard_iface->if_status);
        if (batadv_hardif_is_iface_up(hard_iface))
                batadv_hardif_activate_interface(hard_iface);
        else
@@ -768,10 +769,12 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
                           "Not using interface %s (retrying later): interface not active\n",
                           hard_iface->net_dev->name);

+       pr_info("step 2: %d\n", hard_iface->if_status);
        batadv_hardif_recalc_extra_skbroom(mesh_iface);

        if (bat_priv->algo_ops->iface.enabled)
                bat_priv->algo_ops->iface.enabled(hard_iface);
+       pr_info("step 3: %d\n", hard_iface->if_status);

 out:
        return 0;
@@ -961,7 +964,9 @@ static int batadv_hard_if_event(struct notifier_block *this,

        switch (event) {
        case NETDEV_UP:
+               pr_info("step 4: %d\n", hard_iface->if_status);
                batadv_hardif_activate_interface(hard_iface);
+               pr_info("step 5: %d\n", hard_iface->if_status);
                break;
        case NETDEV_GOING_DOWN:
        case NETDEV_DOWN:

The former case:

  batman_adv: batadv0: Adding interface: batadv_slave_0
  batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
  batman_adv: step 1: 2
  batman_adv: batadv0: Interface activated: batadv_slave_0
  batman_adv: step 2: 4
  batman_adv: step 3: 3
  batman_adv: batadv0: Interface deactivated: batadv_slave_0
  batman_adv: batadv0: Removing interface: batadv_slave_0

The latter case:

  batman_adv: step 1: 2
  batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not actve
  batman_adv: step 2: 2
  batman_adv: step 3: 2
  batman_adv: step 4: 2
  batman_adv: batadv0: Interface activated: batadv_slave_0
  batman_adv: step 5: 4
  batman_adv: batadv0: Interface deactivated: batadv_slave_0
  batman_adv: batadv0: Removing interface: batadv_slave_0



> --- i/net/batman-adv/originator.c
> +++ w/net/batman-adv/originator.c
> @@ -763,7 +763,7 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
>  	bat_priv = netdev_priv(mesh_iface);
>  
>  	primary_if = batadv_primary_if_get_selected(bat_priv);
> -	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
> +	if (!primary_if) {
>  		ret = -ENOENT;
>  		goto out_put_mesh_iface;
>  	}
> 
> 
> And now we are most likely on the right path... primary_if is holding a 
> reference to an hardif and therefore also a reference to the netdev. And the 
> error handling is only taking care of releasing the reference to the meshif 
> but not the primary_if.

Ah, indeed. Since batadv_primary_if_get_selected() is calling kref_get_unless_zero(),
primary_if->if_status != BATADV_IF_ACTIVE case needs to call kref_put().
Also, this matches my what I thought as a problem (BATADV_IF_TO_BE_ACTIVATED prevents
operations that depends on BATADV_IF_ACTIVE from working as expected).

> I will later send a fix for this with you and 
> syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com as Reported-by. Is this
> okay for you?

Yes, the reproducer no longer shows the problem.

Thank you.


