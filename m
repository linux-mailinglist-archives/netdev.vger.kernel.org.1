Return-Path: <netdev+bounces-269962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP+cLsZqvWnL9gIAu9opvQ
	(envelope-from <netdev+bounces-269962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:41:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8A2DCCAA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22E3B308DBA7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18193CB2DC;
	Fri, 20 Mar 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEVWGRrS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79163CD8B0
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021279; cv=none; b=Aw+C4oh7iuJYv8eSWOdSxt00iXE8Bt4ClQVPklmVSMFgogLlDHSwRFFFEiQtp4B+hWF1oJe45erFO6mFxqjupFoA0lEOc3F9wnsCViSmgTkiGnf1NWrgN3jynlDbFnq2/d4++YgDMKOh6c65FNpniHshOaQHWcoqNU8VNLSqhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021279; c=relaxed/simple;
	bh=7W8Zh+eJcNEP6cSAx/szdWUQ7Euc/dI9gMu3jX8uY4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcw/x1v76TGdE2mxB8Y+1SW80DYsdS3+D55nZdPKJfsMMC1HFh+xOO2wkQpwIZH8fOuz72IOD488U30GtN2951hKRSTuXOgX+IfEYD3KZaUA5M/Lt7OEYsjauOtDpq6u4B/ErendbIefNFrJ6Ee0RUerZK3hNicD2gFF7OkWe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEVWGRrS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adff872068so3646805ad.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774021272; x=1774626072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNUDTw6UmasFeJqzydufaazuaNtX8ofv0HS08KI6BZg=;
        b=QEVWGRrSmxHnKPGQYHSTm35KrVIkNuhUhtVZqtFWsblmKA7DHQKR2rIT2cnJuBmZOG
         YO+zMiPVsPKIBu8sCHK8QHu4gA3Z2uQD1Joiuah3re1W9fzTkbI0sP/vmhTOABCwfXrc
         j57B59ZbeaMcOsHpdQ3Yi9z6ovLhQaRZoS+2YyRd5LfJKFXPobwUkRXoRxpwYNFJSuYc
         iuvXchq3Zl+QqRbQJ7vDLWQbZ5SGVxCnYcpua6E+sa1P78S83QRFjbOWJ+WepF6HmYD6
         9DE0jI1Y/JRlhlqdhguZhOkSn64nL6NkhfjyOxAr2KPnnlWBebT+jg24b42YsoY2eNbu
         qdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021272; x=1774626072;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNUDTw6UmasFeJqzydufaazuaNtX8ofv0HS08KI6BZg=;
        b=HrFasoj64VBq5pgCBrdzNIRgOUMPMnzW0vAn5tCH9RwcD0EQC5ZtL2l3qCfhJGYfRP
         XHzkh/LGNA0rtR49sx6MPAYgaXL8iKKM9vsY0oQPHRyNKfL8mw/Zj23VLXr+NwgQ3KmR
         fnBPFwB553c6XYXWdfywvWmXkUPzhWVHu6NQilA1tqjpKVKJnCOMPm2/X65JWOqgfhjJ
         lYWZs20rS7qFKdFUNeEudF5PnZPVWfknPT5bxQqHvX5SiZ2G/oQe9S5TXNQI2RlhZe8/
         O6tdC7KJU05EVUC6NtfwB7ktaxxjEThVmSciPbhiXDZX+3LvY3/iBtKvl9wehAjH8rQY
         SyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi1o1sVLT4YiCJnvvu6BD7n3DJ/9LpMaTbWr06KA0qZpucQ6fpfhfBTf7dMDhI0TVnL53f4Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsaenVHuxzySBtN+XGOt8aBJ4Cwb54Cz2VNT36vbe18NUIT/8
	YUMXjAELxGAV+/dVHV96dpHzyvRKjX8CM15J1siksyZmeXV5XCAoEjU=
X-Gm-Gg: ATEYQzyaIDMZHRtc38y9NUPiIeuqd/iJFlrUiIJ68m+1H58A0zNvuxNZhSWMPom1BnG
	k0zx1hJES1Ixe8C4+VjtmmWENCmQnjZUMoJC+hnJgGYurpKNNyPDph/xQ56br0Go8fztutDYK8O
	5w4IusxOybTNimKKP4yvPtl02GdJG04IixpfxYbP/H91xRTv+5W1OvMd8nzOhSNvzulZYbFy36l
	QWSVM3YXzOMWIXNyt8d7xjDMCNJp9MBEf8QIJ3FZoVmsQ4XStghM1mDKH8jUhyQWMRhF8+YMUWK
	aBMMb61o/CqIQ+hUVEY9nzh3HRLSe+OExe07bgrzsG9awM/YuQbCwd9jHcdqfB2k/Vjx0oLE7gb
	z1CAIF2k2QgpAxCNQv+tM60BJV3wp8NML5FqQihiDavgy0Dy+yg8b3EFGBcLg0z6uG5qnrOM2bz
	Bjr1v/lb7HLIlotOUG44p7nKHEf8cz1tlVydZZ4GEQC9OcIiOIYLtT3jqFdkVECMp1vwi4je0Pi
	Xnh50zMig5WnIPyeg==
X-Received: by 2002:a17:903:38cf:b0:2ae:47c9:68c4 with SMTP id d9443c01a7336-2b0827f7629mr35987865ad.50.1774021271829;
        Fri, 20 Mar 2026 08:41:11 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm26089295ad.26.2026.03.20.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:41:11 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:41:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>,
	"dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH net-next v3 04/13] net: move promiscuity handling into
 dev_rx_mode_work
Message-ID: <ab1qllbwt2zCnQhI@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>,
	"dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-5-sdf@fomichev.me>
 <IA3PR11MB89866C27B28AE7D7D807F37EE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89866C27B28AE7D7D807F37EE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269962-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.889];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BD8A2DCCAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/20, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Stanislav Fomichev <sdf@fomichev.me>
> > Sent: Friday, March 20, 2026 2:25 AM
> > To: netdev@vger.kernel.org
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> > skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> > michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> > L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> > mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> > johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> > dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> > Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> > skhawaja@google.com; bestswngs@gmail.com; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; kees@kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-rdma@vger.kernel.org; linux-
> > wireless@vger.kernel.org; linux-kselftest@vger.kernel.org;
> > leon@kernel.org
> > Subject: [PATCH net-next v3 04/13] net: move promiscuity handling into
> > dev_rx_mode_work
> > 
> > Move unicast promiscuity tracking into dev_rx_mode_work so it runs
> > under netdev_ops_lock instead of under the addr_lock spinlock. This is
> > required because __dev_set_promiscuity calls dev_change_rx_flags and
> > __dev_notify_flags, both of which may need to sleep.
> > 
> > Change ASSERT_RTNL() to netdev_ops_assert_locked() in
> > __dev_set_promiscuity, netif_set_allmulti and __dev_change_flags since
> > these are now called from the work queue under the ops lock.
> > 
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  Documentation/networking/netdevices.rst |  4 ++
> >  net/core/dev.c                          | 79 +++++++++++++++++-------
> > -
> >  2 files changed, 57 insertions(+), 26 deletions(-)
> > 
> > diff --git a/Documentation/networking/netdevices.rst
> > b/Documentation/networking/netdevices.rst
> > index dc83d78d3b27..5cdaa1a3dcc8 100644
> > --- a/Documentation/networking/netdevices.rst
> > +++ b/Documentation/networking/netdevices.rst
> > @@ -298,6 +298,10 @@ struct net_device synchronization rules
> >  	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
> >  	of the unicast and multicast address lists.
> > 
> > +ndo_change_rx_flags:
> > +	Synchronization: rtnl_lock() semaphore. In addition, netdev
> > instance
> > +	lock if the driver implements queue management or shaper API.
> > +
> >  ndo_setup_tc:
> >  	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT
> > locks
> >  	(i.e. no ``rtnl_lock`` and no device instance lock). The rest
> > of diff --git a/net/core/dev.c b/net/core/dev.c index
> > fedc423306fc..fc5c9b14faa0 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -9574,7 +9574,7 @@ static int __dev_set_promiscuity(struct
> > net_device *dev, int inc, bool notify)
> >  	kuid_t uid;
> >  	kgid_t gid;
> > 
> > -	ASSERT_RTNL();
> > +	netdev_ops_assert_locked(dev);
> Can you explain why do you add new hard precondition of ops lock must be held?

The context is that in f792709e0baa ("selftests: net: validate team flags
propagation") I had to add locking around NETDEV_CHANGE notifiers and
add that ugly `if (notify) netdev_ops_assert_locked` check. After this
patch I believe we are consistently calling __dev_set_promiscuity
with the ops lock (for ops locked netdev), so we can cleanup this enforcement
part. 

> >  	promiscuity = dev->promiscuity + inc;
> >  	if (promiscuity == 0) {
> > @@ -9610,16 +9610,8 @@ static int __dev_set_promiscuity(struct
> > net_device *dev, int inc, bool notify)
> > 
> >  		dev_change_rx_flags(dev, IFF_PROMISC);
> >  	}
> 
> ...
> 
> >  	__hw_addr_init(&uc_snap);
> > @@ -9704,16 +9720,29 @@ static void dev_rx_mode_work(struct
> > work_struct *work)
> >  		if (!err)
> >  			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
> >  						      dev->addr_len);
> > -		netif_addr_unlock_bh(dev);
> > 
> >  		if (err) {
> >  			netdev_WARN(dev, "failed to sync uc/mc
> > addresses\n");
> >  			__hw_addr_flush(&uc_snap);
> >  			__hw_addr_flush(&uc_ref);
> >  			__hw_addr_flush(&mc_snap);
> > +			netif_addr_unlock_bh(dev);
> >  			goto out;
> >  		}
> > 
> > +		promisc_inc = dev_uc_promisc_update(dev);
> > +
> > +		netif_addr_unlock_bh(dev);
> > +	} else {
> > +		netif_addr_lock_bh(dev);
> > +		promisc_inc = dev_uc_promisc_update(dev);
> > +		netif_addr_unlock_bh(dev);
> > +	}
> > +
> > +	if (promisc_inc)
> > +		__dev_set_promiscuity(dev, promisc_inc, false);
> But it's being called here without any netdev_lock_ops(dev) ?

We have the following at the start of dev_rx_mode_work:
  rtnl_lock();
  netdev_lock_ops(dev);

Or am I looking at something else?

