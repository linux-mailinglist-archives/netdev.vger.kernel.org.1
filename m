Return-Path: <netdev+bounces-287916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFJ4GimoBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:47:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CA9540902
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57DEB3014810
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF9E3A542A;
	Thu, 14 May 2026 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+f0IMmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9175393DC8
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755622; cv=none; b=DmvAOeAs6mtqdVj0SZyai7UJmjjJ00QTcjbyQfKe+8S3dlTeFXZb00r96c9lFgJMwb5F87uScMKRhMnXNcJw4znjm3GceIt+LH+S3NfW04cCo40OrJgdNZsjiI4YaS2ZXNXzrDyYd4h7GR6hXv5Sho1RwQ5FpPPZCIji+/ZB/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755622; c=relaxed/simple;
	bh=VjJB+5iOOJP3SAKXGmaotXWVhFremMDJrcpxrrBYpNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgewfBdZAQQ+b3mV1ifTZfGU05pVtmtW3CIKBgHKimIjbiAOsZZf6RNcZ3B30BSdBMQkcpvBgXkGCMcVgkImzjhmAPsVPcc1XE8vmF3G9xVum2aZ151Qzn5SJkuhhw/v5RB3DMy2PJ9jJL+Rc0MLs6PQFMXhCsCIsLcky+GTL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+f0IMmY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-449cdc12a8aso876976f8f.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778755619; x=1779360419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTRAacPeCv79DDFoj5X1K+ApxFmhfqhFS3OgT40ZYiQ=;
        b=A+f0IMmYHF5r6HOcZWeLRmla/+f2vI+f3dZ/+/5vFfK69cf7nitL0M6siGVFf+l4xp
         x3jrFmXQ5+zQb9wmSfOdYtJEgwcPeNT1AzxXOxKVJE/VNMpwFOv0ICnrnjWMqYjXp2eo
         E7S3xE4rOfDXXHVBpuP/xt/mRi1PCLbCp9KrVfg1mMBHHbD2CuAw2kpOO/AhBy6Z5deU
         qxnoV6Qediy4rRvkSCYP9ZRoMgV+6qV5dUis//IIKQfcFlWqqkRwVlA16eNmPAApL+Rc
         bFbBvNcM4W3EGyf8d1CQ6kYRBp27xpNrOu82GSeBvh+qQv0enOwA4iZN1LAAADCdFbAD
         FzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755619; x=1779360419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTRAacPeCv79DDFoj5X1K+ApxFmhfqhFS3OgT40ZYiQ=;
        b=mSnRWdk2pDaEvTjVzBL5DJ5ONnpfwAGnJGuFzzs6uKgqBCCJR6Eg59Su6U37PBmuDp
         1dCp4Bk9etJq5YRgIckJ7mlO87AdH2Zsu3AYzSo67TneUTVg/dsp+G4ZyqucLwbuo946
         DhmsE8jlGjde7stwMb0fse7pAGL6AyqUi4wyaQkt6FbZO/vdvJZleamSE/ZFdeLBVqbk
         IaQkwgmdsCHHTWuEEelA25iPslr8pS5IPJO5dxqRJde1IsBe+j0hUOO/O1Nr6lOt2xAO
         uildLDFjgFEYCIUNkA22UVCRAT0mfv0d2Bj1IHUfj5eyy8AQXSggeah9FTfr1OFz3D9t
         wwOg==
X-Forwarded-Encrypted: i=1; AFNElJ9/eyyKMzjnjbOycrvfVjZvsa1hLDjKxY53s/F13RJIjpON2i1FhBaiSXdKiyER9s1Hn8xF1qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6ODqRBGLkRQfQ1oZaewLLW6zd9BaQ/hNDYLzjuKUSNSWWVFB
	UNW0nIvWKiIA4CI4HT1uSb+UcubKyu7S6OKDC1No2PXykbEc6/vxzVYrotrRI8xQ
X-Gm-Gg: Acq92OGYajBpmqIZT2pNN1Q+VOHkyElB64+I9kTO3xIlVxudyehV+PRjSkVDtUNehH8
	qFjUcwcLmY1+vMMJH2rp+t1xv9lJoTqFonDabZVMHVjk8RVo/hWMZ83UWGOdnot3ozAClh3yUeB
	kOnONWAJLaoSN1CEhLMNCTL9Y88g50rHIcCOvY1OEfrt6EMgKo8V68uf3qXgARqr7HjreNZ2EKn
	gGerCBI54b1CKQOBUPwfbrNrpP8PxL5pn+jwtq33pv5JO/2xvd6oLKSFGmRcqcgHPdWG3LXXlXj
	8ldk93UB5lxETTTaDekx9Ev0GkKlBtE+Y9rH9YTzMhrKo24mWshPBFtTyQyu78dN8S6sWicJqL9
	cvd3yHROJL0dt9DOzeqNcTG3BMW66J356QLkvKZ6EKN09ol/YXMLt8F3Zhtg8CZs3sF5VJfe0B5
	JSvYsiYfPd2Kbq
X-Received: by 2002:a05:6000:21c7:b0:44f:ef6a:cd74 with SMTP id ffacd0b85a97d-45c5ad497f9mr3096352f8f.7.1778755619116;
        Thu, 14 May 2026 03:46:59 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d003:300:6c81:7110:517:9a7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767ee0sm5564456f8f.1.2026.05.14.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:46:58 -0700 (PDT)
Date: Thu, 14 May 2026 13:46:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/13] dpaa2-switch: offload FDBs added on an
 upper bond device
Message-ID: <20260514104655.vrn4bkrahimqpcgv@skbuf>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
 <20260512131554.952971-1-ioana.ciornei@nxp.com>
 <20260512131554.952971-10-ioana.ciornei@nxp.com>
 <20260512131554.952971-10-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512131554.952971-10-ioana.ciornei@nxp.com>
 <20260512131554.952971-10-ioana.ciornei@nxp.com>
X-Rspamd-Queue-Id: F3CA9540902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287916-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,info.dev:url]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:15:50PM +0300, Ioana Ciornei wrote:
> +static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
> +					   const struct net_device *foreign_dev)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct ethsw_port_priv *other_port;
> +	int i;
> +
> +	if (netif_is_bridge_master(foreign_dev))
> +		if (port_priv->fdb->bridge_dev == foreign_dev)
> +			return false;
> +
> +	if (netif_is_bridge_port(foreign_dev)) {
> +		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> +			other_port = ethsw->ports[i];
> +
> +			if (!other_port || !other_port->lag)
> +				continue;
> +			if (other_port->lag->bond_dev == foreign_dev)
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}

I noticed Sashiko says:

 Does this misclassify a non-LAG dpaa2 switch port as foreign?  For a
 plain "bridge fdb add aa:bb:cc:dd:ee:ff dev sw0p0 master static",
 br_switchdev_fdb_populate() sets info.dev = sw0p0 and
 __switchdev_handle_fdb_event_to_device() calls
 dpaa2_switch_port_fdb_event() with dev == orig_dev == sw0p0.
 Inside dpaa2_switch_foreign_dev_check(sw0p0, sw0p0):
   netif_is_bridge_master(sw0p0) is false
   netif_is_bridge_port(sw0p0)   is true
   the loop only matches when other_port->lag->bond_dev == foreign_dev,
   but sw0p0 is not a bond_dev, so no entry matches
 so the function falls through to "return true" and the FDB event is
 dropped without ever calling dpaa2_switch_port_fdb_add().  Pre-patch the
 equivalent path only required dpaa2_switch_port_dev_check(dev) to be
 true and would have installed the entry.
 The new dpaa2_switch_port_offloads_bridge_port() helper added in
 dpaa2-switch.h covers both the LAG bond_dev case and the direct port
 netdev case:
   static inline bool
   dpaa2_switch_port_offloads_bridge_port(struct ethsw_port_priv *port_priv,
                                          const struct net_device *dev)
   {
           if (port_priv->lag && port_priv->lag->bond_dev == dev)
                   return true;
           if (port_priv->netdev == dev)
                   return true;
           return false;
   }
 Should dpaa2_switch_foreign_dev_check() also consult the per-port netdev
 match (e.g. via this helper) so non-LAG bridge ports aren't classified
 as foreign?


I think that the foreign_dev_check_cb() expectations are poorly defined/
documented, so I'll try to make some notes in the hope it may be improved:

At a high level, it is supposed to determine whether an offloaded
forwarding data path exists between %dev and %foreign_dev, and return
the negation of that.

The %dev is an interface that always passes the %check_cb.
The %foreign_dev may be:
(1) a bridge port with lowers (team, bond) - in that case
    __switchdev_handle_fdb_event_to_device() walks over those lowers to
    determine whether to fan out the FDB event to them or not. Here,
    %dev is one of those lowers. If you say the LAG is foreign to you,
    %you are not interested in processing FDB events from it.
(2) a bridge device - in case the FDB event was emitted on a bridge port
    that didn't pass %check_cb, we search for a neighbour port that
    offloads that bridge, that can trap the FDB entry to the CPU for
    software forwarding. If you say the bridge is foreign to you, you are
    not interested at all in FDB entries from foreign neighbour ports
(3) a neighbour bridge port - which is actually the port that triggered
    the call (2) so we know it is under a bridge not foreign to us.
    Here, if you say the neighbour port is foreign to you, you are
    actually saying that you _are_ interested in FDB entries on this
    device (will trap them to the CPU for software forwarding)

But switchdev_handle_fdb_event_to_device() has a major limitation which
makes things very confusing.

If you have this topology:

     br0
    /   \
sw0p0   sw1p0

where sw0p0 and sw1p0 are different switch instances handled by the same
driver, which have no offloaded data path to each other, and you run
like Sashiko says:

$ bridge fdb add aa:bb:cc:dd:ee:ff dev sw0p0 master static

then switchdev_handle_fdb_event_to_device() is supposed to also ask
sw1p0 whether sw0p0 is foreign to it, in order to trap the FDB entry to
the CPU.

But it doesn't. Instead, it just stops here, i.e. it assumes that if it
could notify the FDB event to sw0p0, there's nothing more to do:

	if (check_cb(dev))
		return mod_cb(dev, orig_dev, event, info->ctx, fdb_info);

So, yes, currently the bug has no consequences for 2 reasons:
- %foreign_dev is never an interface that passes check_cb()
- dpaa2_switch_port_fdb_event() has this:
	/* For the moment, do nothing with entries towards foreign devices */
	if (dpaa2_switch_foreign_dev_check(dev, orig_dev))
		return 0;

but I need to think of an improved recursion algorithm where that case
is handled as well.

Looking at the other implementations, I see dsa_foreign_dev_check() is
prepared to respond correctly to the switch port <-> switch port
question, and lan966x_foreign_dev_check() isn't.

It would be good, however, to do what the LLM says and fix this by
saying that if netif_is_bridge_port(foreign_dev), the dpaa2-switch
port %dev is foreign to it if there is no other_port under ethsw which
has either a lag_dev _or_ a netdev equal to the foreign_dev. This way,
the driver will be prepared when the switchdev_handle_fdb_event_to_device()
algorithm changes.

 dpaa2_switch_port_event() is documented as called under rcu_read_lock().
 This loop reads other_port->lag and other_port->lag->bond_dev with no
 synchronization, while those fields are mutated under rtnl by
 dpaa2_switch_port_set_lag_group() and the bond-leave path
 (port_priv->lag = NULL; lag->bond_dev = NULL).  Pointer reads are
 atomic, but the compound (other_port->lag) && (lag->bond_dev) is not.
 Is the foreign/native classification stable under concurrent bond
 join/leave, or should this rely on RTNL / netdev adjacency RCU lists
 instead?

I think this is valid. DSA has closed this race with the dsa_flush_workqueue()
call placed after switchdev_bridge_port_unoffload(). It ensures that
pending FDB events are all processed while the netdev adjacency
relationships have not yet been destroyed (running in prechangeupper
context).

