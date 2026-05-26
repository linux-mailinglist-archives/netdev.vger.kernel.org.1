Return-Path: <netdev+bounces-291958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEPsOc8aFmqEhgcAu9opvQ
	(envelope-from <netdev+bounces-291958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:12:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818C5DD1DB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEF223025C16
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97A3C5539;
	Tue, 26 May 2026 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEEY0EGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0353C457F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833549; cv=none; b=hP9DR7OCQHncwcOSHnzibZ+u56kSYWXOiUMsSoxg+FHnNUsuCJMbzfw7d307NxYxr5V8y+dWtO+zwZKL1sSVlYvLHf0IQC9887ObQxQ5i/dygie+Nl8bcLdaUzyU/TF7fNryqWAca/LBLZKm53QaPmWVcEqdgPU9pPfEK93A7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833549; c=relaxed/simple;
	bh=ivCtf1OcPHtXKU2jG0fg20Rv9Wm920Y6xaPkBBeWvlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfyQ2ktKCVQokJmjVbylxJ15PS4L8cLNiolCoQnXKBVQ5aTWZOgWHmZXO91pLUjVE811YvTOztm5qgidHB4mt4eoEkDo1Qe90+/eLklICNV4iiySIllg9+O9wsu3ZGqB69DHGz8n/J9X3R9fSNFOPeDlI+1TYaJfIm0yqN5BA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEEY0EGS; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-824c9da9928so5288674b3a.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833545; x=1780438345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LS3JCSk6VUroBWMnTAalYS0P2J+lAQ2b0ipt6XKuTHs=;
        b=WEEY0EGSOe8v+VgZr5NRy6ZrfKnMfdq7syzP3KaqI6dI+/8iamvhutwu/XYUDdnaqf
         hhkbW2RjxX+m2entZZblANKTw/++0aZldO1pBqCTjDL3Jrjdbo0A7P6sb9upktwuNQ/n
         eDyVButPGLQun+aOPqEEWidG9oNu2NV3FHJrYUiSUAL+2IKFl+ZU0+r2SAAh14sYmUgZ
         XlM4piAjsHaWLU+ylmyNCydHqUcHT1KfdDK2doVYpv2KW2MpaUQYD24fSGnTWFjhyajG
         n8gDmZu8YYLPPVRtjVVUSl0P1B2p0BxpEbj1K4/XP5W1FTpJ/QFExcgu2F4k1DARBF6A
         6Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833545; x=1780438345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS3JCSk6VUroBWMnTAalYS0P2J+lAQ2b0ipt6XKuTHs=;
        b=VcDg3Riiyfa0MsevIqiCti0ISdRVesZN+PSDDsWoP5ArlkZ/aC4qPQXKOvjbrrHrnz
         hcsh5Z8tH+yJPRM9ueHduMpDZLcAHas9kxIN6zyvQPF/BX2UWAoaOWcDVoSHmQNR/f7o
         c9kriDuqzOIUBtx4DFwXoh109zKmH6NDU6cYvlhjg+l/P8ROL/+WzLtCbnGxZzaCnV78
         UJds2vI/OIqNbzx44HXcEp8T8LS5yzYU3ltP+wJlxkypid+i0ZP9Y/8kyqglXjBVTuhJ
         MxT8Ezbm9t0G4OXkHjZI8T8o8r3w4zgevghSOM/YVcUMGDrs8Wz6IsYzRZZ7vantySC+
         ourw==
X-Forwarded-Encrypted: i=1; AFNElJ8d68FvhR37IEGRFxfY8ehnkASmHrMN2bGiRdDKwYOtYnevbYXz7Gv7fdI/1zVv78Fy1RboUuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3+vaNZArSrayivH3YZqKGWi9x+8ZVPp5D8AIwYo3z/WVscj7
	QRt5cUFLQqrRaxlP4gAJiP233+i0V882LSgs+bn/m4geaKcQ8mBq0wqe
X-Gm-Gg: Acq92OFDr1aKDa0DNRNFgF5CXs+zvWZmzAz6af1gcTu2u2TheK40SoKR/0pFt9LSKGv
	1Azcx08KlFesGvhHZelkGumW3Ng6I1P+mMBUjHU6JCJIYE1dzyXY2TFCi3sMp5qYT4ucCfEk9un
	NBkHWjtBX4re9FDourh8PJWtM9D1AosMkDNzAToY7BiXl+wu4ltonpRdHtvTAVkzehzEYT9huzn
	kHqr1tDyA9hM9SiCPtDO3G37U3U/Sf2995N4l+/DO7v3UfAoljZ8I/LLboquxFV2qo/XsqOf8Mo
	/Sr6fhNYtMGSnn9N2zyE476qlyUPg52RkG/7NPxVzXQWUBVX45i6mpFMD3h49o8w1+b6ch68zsT
	VsgrFBnfkgEMXAHeDwEXSSDN96cFo8/FYVGkagXDM/uJOzB9kXLNZld/+yNxrlrVYHurlboQoA+
	i38EPO4iniAbeRhZ3T
X-Received: by 2002:a05:6a00:2295:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-8415f15a680mr18903223b3a.16.1779833545023;
        Tue, 26 May 2026 15:12:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6e80254sm289657b3a.3.2026.05.26.15.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:12:24 -0700 (PDT)
Date: Tue, 26 May 2026 15:12:23 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	vladimir.oltean@nxp.com, willemb@google.com, ecree.xilinx@gmail.com, 
	jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 01/10] docs: net: netdevices: small fixes and
 clarifications
Message-ID: <ahYap4kJ8q96Qs11@devvm7509.cco0.facebook.com>
References: <20260526160151.2793354-1-kuba@kernel.org>
 <20260526160151.2793354-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526160151.2793354-2-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291958-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fomichev.me:email]
X-Rspamd-Queue-Id: 7818C5DD1DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/26, Jakub Kicinski wrote:
> A handful of unrelated nits:
> 
>  - free_netdevice() does not exist; replace two stray references
>    with free_netdev().
>  - The simple-driver probe example fell through into err_undo after
>    register_netdev() success; add return 0 for clarity.
>  - Clarify the netdev_priv() paragraph: "(netdev_priv())" was easy
>    to misread as the thing that needs explicit freeing; spell out
>    that it refers to extra pointers stored in the device private
>    struct.
>  - ndo_setup_tc synchronization note: TC_SETUP_BLOCK / TC_SETUP_FT
>    actually run under block->cb_lock, not "NFT locks", and rtnl_lock
>    may or may not be held depending on path.
>  - ->lltx guidance reads as very outdated, it's not really deprecated.
>    I suspect people may have been trying to use it for HW drivers
>    in the past but I can't think of such a case in the last decade.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/netdevices.rst | 31 ++++++++++++++-----------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index 93e06e8d51a9..60492d4df2ee 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -21,13 +21,14 @@ by free_netdev(). This is required to handle the pathological case cleanly
>  alloc_netdev_mqs() / alloc_netdev() reserve extra space for driver
>  private data which gets freed when the network device is freed. If
>  separately allocated data is attached to the network device
> -(netdev_priv()) then it is up to the module exit handler to free that.
> +(extra pointers stored in the device private struct) then it is up
> +to the module exit handler to free that.
>  
>  There are two groups of APIs for registering struct net_device.
>  First group can be used in normal contexts where ``rtnl_lock`` is not already
>  held: register_netdev(), unregister_netdev().
>  Second group can be used when ``rtnl_lock`` is already held:
> -register_netdevice(), unregister_netdevice(), free_netdevice().
> +register_netdevice(), unregister_netdevice(), free_netdev().
>  
>  Simple drivers
>  --------------
> @@ -58,6 +59,7 @@ In that case the struct net_device registration is done using
>        goto err_undo;
>  
>      /* net_device is visible to the user! */
> +    return 0;
>  
>    err_undo:
>      /* ... undo the device setup ... */
> @@ -73,7 +75,7 @@ In that case the struct net_device registration is done using
>  
>  Note that after calling register_netdev() the device is visible in the system.
>  Users can open it and start sending / receiving traffic immediately,
> -or run any other callback, so all initialization must be done prior to
> +or run any other callback, so all initialization must be **complete** prior to
>  registration.
>  
>  unregister_netdev() closes the device and waits for all users to be done
> @@ -157,7 +159,7 @@ register_netdevice() fails. The callback may be invoked with or without
>  There is no explicit constructor callback, driver "constructs" the private
>  netdev state after allocating it and before registration.
>  
> -Setting struct net_device.needs_free_netdev makes core call free_netdevice()
> +Setting struct net_device.needs_free_netdev makes core call free_netdev()
>  automatically after unregister_netdevice() when all references to the device
>  are gone. It only takes effect after a successful call to register_netdevice()
>  so if register_netdevice() fails driver is responsible for calling
> @@ -256,7 +258,7 @@ struct net_device synchronization rules
>  	lock if the driver implements queue management or shaper API.
>  	Context: process
>  
> -ndo_get_stats:
> +ndo_get_stats / ndo_get_stats64:
>  	Synchronization: RCU (can be called concurrently with the stats
>  	update path).
>  	Context: atomic (can't sleep under RCU)
> @@ -264,12 +266,9 @@ struct net_device synchronization rules
>  ndo_start_xmit:
>  	Synchronization: __netif_tx_lock spinlock.
>  
> -	When the driver sets dev->lltx this will be
> -	called without holding netif_tx_lock. In this case the driver
> -	has to lock by itself when needed.
> -	The locking there should also properly protect against
> -	set_rx_mode. WARNING: use of dev->lltx is deprecated.
> -	Don't use it for new drivers.
> +	When the driver sets dev->lltx this will be called without holding
> +	netif_tx_lock. dev->lltx is meant for software drivers only, since
> +	they often have no per-queue state.
>  
>  	Context: Process with BHs disabled or BH (timer),
>  		 will be called with interrupts disabled by netconsole.
> @@ -304,11 +303,15 @@ struct net_device synchronization rules
>  	lock if the driver implements queue management or shaper API.
>  

[..]

>  ndo_setup_tc:
> -	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
> -	(i.e. no ``rtnl_lock`` and no device instance lock). The rest of
> -	``tc_setup_type`` types run under netdev instance lock if the driver
> +	Locking depends on ``tc_setup_type``. For most types the callback
> +	is invoked under ``rtnl_lock`` and netdev instance lock if the driver
>  	implements queue management or shaper API.
>  
> +	For ``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` ``rtnl_lock`` may or
> +	may not be held, and the netdev instance lock is not held.
> +	``TC_SETUP_BLOCK`` runs under ``block->cb_lock`` and ``TC_SETUP_FT``
> +	runs under ``flowtable->flow_block_lock``.
> +
>  Most ndo callbacks not specified in the list above are running
>  under ``rtnl_lock``. In addition, netdev instance lock is taken as well if
>  the driver implements queue management or shaper API.

LGTM!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

