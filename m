Return-Path: <netdev+bounces-267104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJa0OBrQsmnrPwAAu9opvQ
	(envelope-from <netdev+bounces-267104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:39:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E839273824
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77AB931A58D4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B23750B5;
	Thu, 12 Mar 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGcLWzmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC8372EC6
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326097; cv=none; b=TEOCoYHwphpSLHMJr8wu+mW8IPyNWZw0/IeF00kmoyPc+LIFyxkRRTlmZRzUz491S04+3vAolvjqrwP3L3Z0B44valqhjwGfz2taoDnBMiEJ/l4UDqHrx17O9LDEU0WUD+YTvbtOxId+ts32rfNKkU3E9KlbO82tb2ARVhwtn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326097; c=relaxed/simple;
	bh=6JtGac83PpZLOkb7JoNXF61Pp3hiImbveoEHI06tr0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfnkGqzXLKIlT6Dq52Bu66eFTz/isC9fQF3ps2u3fFnjgv5vFgoiAMOPMCyNpN3DnT1rFOlSjFIg55BJ5NU9XQYOIgeAhXP+MIRq2xkvc5RavPyPr8dpgGod4nu2+i3Ve+SToYCnkUCdhz6vk/DKY9/27zy5oZWzbEk1+VEsK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGcLWzmh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae41544dcfso12733485ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773326095; x=1773930895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xo4CEzPoRnsxcWTwpZVwHi/yVVw3KlTALyiUcwtez0=;
        b=gGcLWzmhjNkOfhHvBaRbz8YddxP+DsGGEzkF6sekwpxt4JuMeYEdsl7jlh0+LxOOc5
         ODzyv3kzL1mbg1xFszh9tlrbwgUTLNILNqO2AbvUwCrrmYAXQCOC3n39/CaRl5fD+53s
         aFczAZRqWlcnU5HxF9ou726UjZJqijEQbOCV4JXugbJrhJK8Ag2AeHnhftYSJ8Oaqy5c
         yf0DDQgpvnhhBgZMwD10r054EVZQZpczX75DRVb7clA09LZ2eIIlKQQoTdgN8tA2gAb+
         6UOv/wbpm9+HVsg4TfBqnYvUq3mpmV1emrrZtOiXVJ9LmByN4OYkeS8Kua8tIMwue0Mq
         FOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773326095; x=1773930895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xo4CEzPoRnsxcWTwpZVwHi/yVVw3KlTALyiUcwtez0=;
        b=mT6ZTacmEh1cajZKhjztrBts0gzAFzmsII7lSOhvxz5EJVXWQcBbxc335DVD+FsR8F
         EI1QjfVzeIcRTLyRkzPjD2sF2scl7ZEDdjmOX8fB9UPf1ABw1ql/Ydf3qM8XTHgxGnxc
         mEI6b40RDlD/ywyU+DgBrQT8JGGWMmQ+BuM7kuQnjImikeBNUW7ZKXmQfDtJuCLBcHBp
         Jm0R+Z2j/GujgNxjJm6A6zyAlPNOMUv7Bm3E1i+Aa4jgxIpSyKpLNp3XgLgGoB+V/BXi
         3wQhfc/o5A2vIjeFDPSIIiwxH+WSBzf4QXNq4Xrd/7VWkMsZv3tV7ZDNyxYT4c1hyvoj
         ZDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAQTvCxDK0Zq/I6jvTFh40cBCODhuIk9hgcHqznDENy4CIMPiPx9072ZH4FK8r/rETMdeXTvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7iJHELsOTOLuoYSmH6ch2W/dSUEXkcVgONeFtOSHTUhwni5V
	eGlTfGVJz4bRgJnT76ESGqlNHI3tZ7pWA/zrOrUW19qURGOxkPEdqa3w
X-Gm-Gg: ATEYQzzbA5hGi01VbrFv8vuJDnoJWodDZNKowCMjOlkA4sFv//Y3ZKyUHlrk9MOeheW
	3KNGPdS+05TzAzJH8ctoRIASwUnIHwXJDJdkd86/nE6LypfYU/jxDMHOLDMT4/VCliBGMkF3KvD
	XYfWFF7GwD6fdWkZ7Lcw3ORe8BEsMZlXXbDDUMVgaW+MA1N37FKB0vjZmulxJwfqCVrt3avK300
	vKAWuLbfA5GpMEXTWQEeM8m+tW+svyWk3TvhlaNL9VvenKWe1bLXWQJtrdfcolZTE4pKRkG29fk
	hq+JgA4BvKu4m+5eJlhApjCkz5MAKMy+YkOi6n+++2EVvOP5yfrl6aQzp5TlLppKTJi7Sz+1P7a
	6zgTmNBlBvRxYBYb5JXXh1oGMspTl+0wujWcOq/GA2DizWETLT4iXYDn0j1Qo9ytyWpYrHpL3zz
	ClEny1g04HMoMjBVfrRfDIaQ+9q+0=
X-Received: by 2002:a17:902:ffd0:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2aeae7640d3mr64159275ad.10.1773326095542;
        Thu, 12 Mar 2026 07:34:55 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378980sm58269035ad.84.2026.03.12.07.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:34:54 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:34:44 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>,
	syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
	andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
	jiri@resnulli.us, jv@jvosburgh.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	razor@blackwall.org, sridhar.samudrala@intel.com,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features
 to ndo_set_features
Message-ID: <abLPBEg_-j5rp4IM@fedora>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com>
 <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora>
 <abHcP3GTO29rfKML@krikkit>
 <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com>
 <abKf8Fg865Fhipwk@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abKf8Fg865Fhipwk@krikkit>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267104-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci098fa7c1795eceac];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 4E839273824
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:13:52PM +0100, Sabrina Dubroca wrote:
> > >> This patch calls netdev_change_features() after __netdev_upper_dev_link(),
> > >> Which trigger a NETDEV_FEAT_CHANGE notify and calls rtmsg_ifinfo_event()
> > >> to fill the new link info. Maybe the event is a bit early and macsec has
> > >> data not ready?
> > > 
> > > But this would still mean that there's a mismatch between
> > > if_nlmsg_size() and rtnl_fill_ifinfo(), and your patch is only
> > > revealing it.
> > > 
> > > I'll send fixes for the stuff I mentioned, no idea if that's what
> > > syzbot saw since we don't have a repro.
> > 
> > It looks like even the nipa CI is reproducing the issue, i.e.:
> > 
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/554921/17-rtnetlink-sh/
> > 
> > more failures here:
> > 
> > https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-12--06-00&pw-n=0&pass=0
> > 
> > the fail in mascsec-offload looks quite deterministic, could you please
> > have a look?
> 
> Ah crap, sorry Hangbin, you were right.  macsec_fill_info() returns
> -EMSGSIZE when the key length is unexpected, and at this point we
> haven't set it to its proper value yet.
> 
> Bandaid solution would be:
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index f6cad0746a02..0f7ef7bfbdde 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -4337,7 +4337,7 @@ static int macsec_fill_info(struct sk_buff *skb,
>                 csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 : MACSEC_CIPHER_ID_GCM_AES_256;
>                 break;
>         default:
> -               goto nla_put_failure;
> +               return 0;
>         }
>  
>         if (nla_put_sci(skb, IFLA_MACSEC_SCI, secy->sci,
> 
> 
> Proper fix (so that the notification we're sending during
> upper_dev_link has full linkinfo) would be to move
> netdev_upper_dev_link() to after macsec_changelink_common() and fix up
> the error handling. I don't see anything in macsec_add_dev or
> macsec_changelink_common that needs the device to be linked. But

If we move the netdev_upper_dev_link() after macsec_changelink_common(),
we will not goto nla_put_failure via default, right?

> anyway it doesn't make sense for macsec_fill_info to return -EMSGSIZE
> on invalid data, so the "bandaid" should be included as well.
> 
> Should this be part of this series (either just the "bandaid" or the
> "proper fix"+bandaid), since we never saw a problem before?

Since macsec need the "bandaid" fix either way. How about you post the
"bandaid" fix to net. And I include the "proper fix" in this series for
net-next?

BTW, here is my draft patch, would you like to review it first?

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..1f8da4c291c6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4161,10 +4161,6 @@ static int macsec_newlink(struct net_device *dev,
 	lockdep_set_class(&dev->addr_list_lock,
 			  &macsec_netdev_addr_lock_key);
 
-	err = netdev_upper_dev_link(real_dev, dev, extack);
-	if (err < 0)
-		goto unregister;
-
 	/* need to be already registered so that ->init has run and
 	 * the MAC addr is set
 	 */
@@ -4177,12 +4173,12 @@ static int macsec_newlink(struct net_device *dev,
 
 	if (rx_handler && sci_exists(real_dev, sci)) {
 		err = -EBUSY;
-		goto unlink;
+		goto unregister;
 	}
 
 	err = macsec_add_dev(dev, sci, icv_len);
 	if (err)
-		goto unlink;
+		goto unregister;
 
 	if (data) {
 		err = macsec_changelink_common(dev, data);
@@ -4190,6 +4186,10 @@ static int macsec_newlink(struct net_device *dev,
 			goto del_dev;
 	}
 
+	err = netdev_upper_dev_link(real_dev, dev, extack);
+	if (err < 0)
+		goto unlink;
+
 	/* If h/w offloading is available, propagate to the device */
 	if (macsec_is_offloaded(macsec)) {
 		const struct macsec_ops *ops;
@@ -4200,7 +4200,7 @@ static int macsec_newlink(struct net_device *dev,
 			ctx.secy = &macsec->secy;
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
-				goto del_dev;
+				goto unlink;
 
 			macsec->insert_tx_tag =
 				macsec_needs_tx_tag(macsec, ops);
@@ -4209,7 +4209,7 @@ static int macsec_newlink(struct net_device *dev,
 
 	err = register_macsec_dev(real_dev, dev);
 	if (err < 0)
-		goto del_dev;
+		goto unlink;
 
 	netdev_update_features(dev);
 	netif_stacked_transfer_operstate(real_dev, dev);
@@ -4219,10 +4219,10 @@ static int macsec_newlink(struct net_device *dev,
 
 	return 0;
 
-del_dev:
-	macsec_del_dev(macsec);
 unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
+del_dev:
+	macsec_del_dev(macsec);
 unregister:
 	unregister_netdevice(dev);
 	return err;

Thanks
Hangbin

