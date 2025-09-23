Return-Path: <netdev+bounces-225648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44803B966DE
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D95018A1706
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5DB25A35D;
	Tue, 23 Sep 2025 14:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6425A34B
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638758; cv=none; b=jJVGIr7U9bFcyKWer5iW7Df2O/1w5eZhkKc5zYuUlp86ktE/3Eyc+N10jhEmqnxrlSpwHwzozgk+LxPcKja6lGz1NoXq2bHSSeegHEG8GpB96SsGiNgRaJDKzrWW+jS9YHqddADM5BVvKIJEbG9daVsZT6jbSzwfzul8CNIktRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638758; c=relaxed/simple;
	bh=wOWP99KdRkbm+9gHoF5tqbSCb74YmZNssiFnOzLhlbc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ARgtZUTOVOr9UhUuqPbNsl414A2s0Fue5UtBJIclrU4vFcMmbBS1GksomQc8r90/KQYRfPJCuMXYLYnX1qxKUieLaldLEjyEu2rRHPLbMteXxdEuihx+xjIMB43kO+049hWw+nfqaWi9FNsSwy+dfD6/70hMMLrgVNfcqmfvr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58NEjmgE043278;
	Tue, 23 Sep 2025 23:45:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58NEjmPA043275
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Sep 2025 23:45:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
Date: Tue, 23 Sep 2025 23:45:48 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unregister_netdevice: waiting for batadv_slave_0 to become free.
 Usage count = 2
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Marek Lindner <marek.lindner@mailbox.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
References: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/22 23:09, Tetsuo Handa wrote:
> I suspect that batadv_hard_if_event_meshif() has something to do upon
> NETDEV_UNREGISTER event because batadv_hard_if_event_meshif() receives
> NETDEV_POST_INIT / NETDEV_REGISTER / NETDEV_UNREGISTER / NETDEV_PRE_UNINIT
> events when this reproducer is executed, but I don't know what to do...

With a change show bottom, the reproducer no longer triggers this problem.
But is this change correct?



Commit 9e6b5648bbc4 ("batman-adv: Fix duplicated OGMs on NETDEV_UP")
replaced batadv_iv_iface_activate() (which is called via iface.activate()
 from batadv_hardif_activate_interface()) with batadv_iv_iface_enabled()
(which is called via iface.enabled() from batadv_hardif_enable_interface()).
But that commit missed that batadv_hardif_activate_interface() is called from
both batadv_hardif_enable_interface() and batadv_hard_if_event().

Since batadv_iv_ogm_schedule_buff() updates if_status to BATADV_IF_ACTIVE
only when if_status was BATADV_IF_TO_BE_ACTIVATED, we need to call
batadv_iv_ogm_schedule_buff() from batadv_iv_ogm_schedule() from
batadv_iv_iface_enabled() via iface.enabled() with
if_status == BATADV_IF_TO_BE_ACTIVATED if we want iface.enabled() from
batadv_hardif_enable_interface() to update if_status to BATADV_IF_ACTIVE.

But when IFF_UP is not set upon creation, batadv_hardif_enable_interface()
does not call batadv_hardif_activate_interface(), which means that
if_status remains BATADV_IF_INACTIVE despite
batadv_iv_ogm_schedule_buff() is called via iface.enabled().

And when IFF_UP is set after creation, batadv_hard_if_event() calls
batadv_hardif_activate_interface(). But despite "Interface activated: %s\n"
message being printed, if_status remains BATADV_IF_TO_BE_ACTIVATED because
iface.activate == NULL due to above-mentioned commit.

Since we need to call iface.enabled() instead of iface.activate() so that
batadv_iv_ogm_schedule_buff() will update if_status to BATADV_IF_ACTIVE,
move iface.enabled() from batadv_hardif_enable_interface() to
batadv_hardif_activate_interface().



diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bace57e4f9a5..403785f649ff 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -673,6 +673,8 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	if (bat_priv->algo_ops->iface.activate)
 		bat_priv->algo_ops->iface.activate(hard_iface);
+	if (bat_priv->algo_ops->iface.enabled)
+		bat_priv->algo_ops->iface.enabled(hard_iface);
 
 out:
 	batadv_hardif_put(primary_if);
@@ -770,9 +772,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	batadv_hardif_recalc_extra_skbroom(mesh_iface);
 
-	if (bat_priv->algo_ops->iface.enabled)
-		bat_priv->algo_ops->iface.enabled(hard_iface);
-
 out:
 	return 0;
 



