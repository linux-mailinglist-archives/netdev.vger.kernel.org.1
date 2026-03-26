Return-Path: <netdev+bounces-271892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AATIJBXdxGlf4gQAu9opvQ
	(envelope-from <netdev+bounces-271892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:15:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C233053B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58658300BCBB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275C34EF15;
	Thu, 26 Mar 2026 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="jDIfeIp1"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458634D394
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509007; cv=none; b=ldLAU1wotVbIxLcVkDC74pbmVYRM0q1BUGMPLUoYoHNQz0U1e4mB40anbnZ5+ZLKf0kqd6iwGEIJNNIry8iev0xnZ8gkr0kGUeJS/htKujvRNkRZwPVPW080Faw+z1X2Pt3+KvKzY++ODQhDoTvZHHkqhI/TLaY/+cpCWqjwRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509007; c=relaxed/simple;
	bh=ZHj2bYW+3iuU4m8AykGTIX2zkjBShApIA84aPz+DW4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+8DIRaOt7Jyipf+LeuL01fyhA48Yc8wFHIrsLxQlcqMO/AP2Y0jeYPL7o8PLVmsO+RnjiGVqOgM4HiCfs5Xuc09+c8hiwNQDlRLTG3d4opL3FCHbzwlaieeka0Pfp47bn3IjsgxQyXNSonj9B5xxruXvsVuU07EtPjSf/7IIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=jDIfeIp1; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62Q7A2nV082388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Mar 2026 16:10:03 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=8umtFd6Ur3YrE/ozmw1yW90cnv5VFGVsJSjl6l19isU=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1774509004; v=1;
        b=jDIfeIp15deFap2yz2++rd7BkthM2arhKVLU+TuFzzU8YsFFpVopN1fx6PFOktS5
         vq+Zr9adaqUM1TCQk/ZBBlp8nbiq6Mn9LCXBZt0QscZZC9AtS6hziFHJpa2VKRkP
         vWskLgUOUH2C6AprFBRkwxQ4kNbiDMbAJsr7+eJGY5ga43GUmOy29Ha9Xqt13Reh
         I1SfoKKlKnmpUkYRVLyesHcWy0avzFsd/eqZeM6ly5JsrOd80QbyIZ+MJe3ruE3x
         10xGEq2KwOC1MDQ1AB0C0uizOdIYsbDniJbWguCeSJKfFBUmILTa5R8HoM/I26jl
         PP8N0x1EHzalffCXbhNuRQ==
Date: Thu, 26 Mar 2026 16:10:02 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shannon Nelson <sln@onemain.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>, kohei.enju@gmail.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
 IFF_SUPP_NOFCS
Message-ID: <acTUtLuuoNfnRSpT@x1>
References: <20260325205054.109822-1-kohei@enjuk.jp>
 <d59fc665-3400-4513-844e-a9529b7498ce@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d59fc665-3400-4513-844e-a9529b7498ce@molgen.mpg.de>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,onemain.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: E87C233053B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/26 07:05, Paul Menzel wrote:
> Dear Kohei,
> 
> 
> Thank you for your patch.
> 
> Am 25.03.26 um 21:50 schrieb Kohei Enju:
> > i40e advertises IFF_SUPP_NOFCS, allowing users to use the SO_NOFCS
> > socket option. However, this option is silently ignored, as the driver
> > does not check skb->no_fcs, and always enables FCS insertion offload.
> > 
> > Fix this by removing the advertisement of IFF_SUPP_NOFCS.
> > 
> > This behavior can be reproduced with a simple AF_PACKET socket:
> > 
> >    import socket
> >    s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
> >    s.setsockopt(socket.SOL_SOCKET, 43, 1) # SO_NOFCS
> >    s.bind(("eth0", 0))
> >    s.send(b'\xff' * 64)
> > 
> > Previously, send() succeeds but the driver ignores SO_NOFCS.
> 
> Would I check that with tcpdump?

On the RX side, it can be possible to observe such frames using tcpdump,
if the RX device supports:
  - rx-all (accepting all frames including bad frames)
  - keeping the FCS (not stripping it)

On the TX side, however, the hardware-generated FCS is not visible to
tcpdump.

In my setup, I verified that the CRC error stats didn't increase on the
RX side when using the script above. If SO_NOFCS were actually honored,
we would expect frames with invalid/custom CRC to be transmitted, and
the RX side device should report CRC errors.

> 
> > With this change, send() fails with -EPROTONOSUPPORT, as expected.
> 
> Great commit message! Thank you.
> 
> One question, did you look into, what is needed to implement working SO_NOFC
> support?

From the driver implementation, it looks like clearing
I40E_TX_DESC_CMD_ICRC when skb->no_fcs is set could enable the expected
behavior.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/i40e/i40e_txrx.c#n3936

However, implementing proper support would require careful validation,
and also may impact the TX fast path slightly. So this patch focuses on
just correcting netdev->priv_flags.

> 
> > Fixes: 41c445ff0f48 ("i40e: main driver core")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 3749f32ef95a..a3c52aa6255b 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -13831,7 +13831,6 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
> >   	netdev->neigh_priv_len = sizeof(u32) * 4;
> >   	netdev->priv_flags |= IFF_UNICAST_FLT;
> > -	netdev->priv_flags |= IFF_SUPP_NOFCS;
> >   	/* Setup netdev TC information */
> >   	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
> 
> Nice catch.
> 
> 
> Kind regards,
> 
> Paul

