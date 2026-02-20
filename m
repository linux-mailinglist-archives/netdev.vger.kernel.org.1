Return-Path: <netdev+bounces-259766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIiVL+7HmGngMAMAu9opvQ
	(envelope-from <netdev+bounces-259766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:45:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B3A16AB9F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 732643034E25
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345182EA480;
	Fri, 20 Feb 2026 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Y8Bku9BM"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4C2D7DEF
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620331; cv=none; b=ZLuHIDD8jHSNLoLsl0xSwQmWSqaALQs/hsk3V40C14/IwH3pngimn6q2FfDFjugHLu/ObOwKIQv1cpGStMWVyzEzAr0A2kcz1fg1IH2fFUG2oo7XtvBJ1QEatfJyxwCx/pe7Fqv/nFFuVYn9o21CfPrTzroOXQBEQtAuoUJJXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620331; c=relaxed/simple;
	bh=+MpAdX04z71/DriT7F3atRs8SgTe+Kc43ytE6V82v5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIZXCI3ok0gSuaASeA+UwwzCDvG/DsMSn+97855bj5IetsiO7cZZkHmByUkGmBLY5U4TZNJfRQX/QhcCesjl9hNkvh5ULSUEL1VmCuDLROYtN2l4E9q4CuYdueMlXsOLpTnAnm8JF/HZjqE32B26yDSF5zWyII+IUGx0+4HBPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Y8Bku9BM; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (54.52.30.125.dy.iij4u.or.jp [125.30.52.54])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61KKjR4u048125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Feb 2026 05:45:27 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=g4QW/rxYMrWC1qtUxlhgMr6Uho9KgR9xRA8MZbs0IJ8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771620327; v=1;
        b=Y8Bku9BMzVuXdD6cj9XlchnAU0Q0reYEjpYi2tb054JZVWQzUbA54mqUDtSonRox
         8irIg6zH2TpqEBu2JFG4QZn68dh5GFYK/Ck4Qbbvvtu7QmPuJVkJ7cGaE3s5Iuun
         g5bYiGUw+pcJsxkuQMEj6Q7cnBtoivB4FCDoZGiKvBDj7p+4JloN/nNN8zEQGkus
         qaN0RoZ1+3j0q8ZyaE5QSxNUSAcoLgAYoc5zS2bRMH/XGZemmmJxLarQ+XANNKg9
         eggkjT1PHcHotuLu9ZDIufnYF+zSKPBZZYfmgZU85d4WWgitJW1Zeiscgon6hUGa
         HoMRorv0srS0LpUjEqoCjQ==
From: Kohei Enju <kohei@enjuk.jp>
To: aleksandr.loktionov@intel.com
Cc: alice.michael@intel.com, andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com,
        intel-wired-lan@lists.osuosl.org, kohei.enju@gmail.com, kohei@enjuk.jp,
        kuba@kernel.org, maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
        pabeni@redhat.com, paul.greenwalt@intel.com,
        przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in error path of ice_set_ringparam()
Date: Fri, 20 Feb 2026 20:44:14 +0000
Message-ID: <20260220204526.7514-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <IA3PR11MB89864DB144A3D8990E6512D5E568A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89864DB144A3D8990E6512D5E568A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,lists.osuosl.org,gmail.com,enjuk.jp,kernel.org,vger.kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259766-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9B3A16AB9F
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 20:04:52 +0000, "Loktionov, Aleksandr" wrote:

> > -----Original Message-----
> > From: Kohei Enju <kohei@enjuk.jp>
> > Sent: Friday, February 20, 2026 7:40 PM
> > To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; Alice Michael
> > <alice.michael@intel.com>; Greenwalt, Paul <paul.greenwalt@intel.com>;
> > Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> > kohei.enju@gmail.com; Kohei Enju <kohei@enjuk.jp>
> > Subject: [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in
> > error path of ice_set_ringparam()
> >=20
> > ice_set_ringparam nullifies tstamp_ring of temporary tx_rings, without
> > clearing ICE_TX_RING_FLAGS_TXTIME bit.
> > When ICE_TX_RING_FLAGS_TXTIME is set and the subsequent
> > ice_setup_tx_ring() call fails, a NULL pointer dereference could
> > happen in the unwinding sequence:
> >=20
> > ice_clean_tx_ring()
> > -> ice_is_txtime_cfg() =3D=3D true (ICE_TX_RING_FLAGS_TXTIME is set)
> > -> ice_free_tx_tstamp_ring()
> >   -> ice_free_tstamp_ring()
> >     -> tstamp_ring->desc (NULL deref)
> >=20
> > Clear ICE_TX_RING_FLAGS_TXTIME bit to avoid the potential issue.
> >=20
> > Note that this potential issue is found by manual code review.
> > Compile test only since unfortunately I don't have E830 devices.
> >=20
> > Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload
> > support")
> If it's a fix, shouldn't it go to net?

This fix relies on a commit 8a4e78094945 ("ice: fix race condition in TX
timestamp ring cleanup"), which changed type of flags from u8 to
BITMAP, as you advised in [1].
Since the commit only exists in Tony's tree, I chose iwl-net, not net.

[1] https://lore.kernel.org/intel-wired-lan/IA3PR11MB8986EB459D2FD1697644CF98E598A@IA3PR11MB8986.namprd11.prod.outlook.com/

> 
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > index 7f769a90dde1..5ed86648d0d6 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -3290,6 +3290,7 @@ ice_set_ringparam(struct net_device *netdev,
> > struct ethtool_ringparam *ring,
> >  		tx_rings[i].desc =3D NULL;
> >  		tx_rings[i].tx_buf =3D NULL;
> >  		tx_rings[i].tstamp_ring =3D NULL;
> > +		clear_bit(ICE_TX_RING_FLAGS_TXTIME, tx_rings[i].flags);
> >  		tx_rings[i].tx_tstamps =3D &pf->ptp.port.tx;
> >  		err =3D ice_setup_tx_ring(&tx_rings[i]);
> If ice_setup_tx_ring() internally reads ICE_TX_RING_FLAGS_TXTIME to decide =
> whether to allocate the tstamp_ring, then clearing the bit first means ice_=
> setup_tx_ring() skips TxTime setup even on success - leaving TxTime silentl=
> y broken after ice_set_ringparam() completes normally. The crash is fixed o=
> n the error path, but I'm afraid a functional regression is introduced on t=
> he success path.
> Please correct me if I'm wrong.

I believe, in the successful path, tx_tstamps and the flag
ICE_TX_RING_FLAGS_TXTIME are restored in ice_up().

ice_up()
 ice_vsi_cfg_lan()
  ice_vsi_cfg_lan_txqs()
   ice_vsi_cfg_txqs()
    ice_vsi_cfg_txq()
     ice_is_txtime_ena() ( == test_bit(ring->q_index,  pf->txtime_txqs))
     ice_alloc_setup_tstamp_ring()
      ice_alloc_tstamp_ring()
       - allocate tx_tstamps
       - set_bit(ICE_TX_RING_FLAGS_TXTIME, tx_ring->flags);

Enablement of TxTime feature is managed by pf->txtime_txqs, and
ring->flags represents only a 'result' of the enablement.

Therefore I think it's not a problem, but please let me know if my
understanding is wrong.
Thank you for reviewing, Alex!

> 
> Thank you
> Alex
> 
> >  		if (err) {
> > --
> > 2.51.0

