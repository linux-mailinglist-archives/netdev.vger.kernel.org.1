Return-Path: <netdev+bounces-272340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGdyGZXuxWlTDQUAu9opvQ
	(envelope-from <netdev+bounces-272340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:42:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F92133E73B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C1593081BE9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE026F2AD;
	Fri, 27 Mar 2026 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcRmhyy5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704E24503F
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579181; cv=pass; b=VX+rXUtPlDRtb2oE4qzvGq2WMPzPcIGdM6hldC5gZKZPuCaqmp5HiYP8dVyExqZX8RaRb0d7SJGGtIKVxsEK7yOcEyRJMBdO5wOlb/IHizeMuaxSYQDNfp5m7FqKb/578ro91oaEiBiVVoMwdBEJzDV7ceBf4QDujSwh4JyO4Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579181; c=relaxed/simple;
	bh=fFnLdx80Lwgt+BNY1Dx1jqYlDMZ++tOi6mJEx2z902I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/mB40bRip3L69ygk6WcxNS4nup/6ti+qEK/IFKCWnEj1fUhOm8Yohwf/6b7wrVtAYQjM/MUwOzU83MpHqTs9nmu53WTOfaYDlRVnszGjlA51q8s4X4qLl4bKmgNmE85xFjVlAJ9dyYlC29VV7foZEbYxKazWmMScG8tGfojUiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcRmhyy5; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66b1019bb55so1036411a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774579178; cv=none;
        d=google.com; s=arc-20240605;
        b=cmtaLY0uYQDUT6RXBmWJfpXh72bNXR+sjVKzcgMfXC+fC3YSWLyAi7cbEbMD7yapZC
         c6y/3NzcX4qJaE1qr2rg5jqy8GhL9gwXJYfp0rRZ4b+iciudF2iVZL3GUh1AZ4Y6Fgkl
         c8CmvHxGpeKRh9DCWbZN5MNEhoNcuHa0RBURa8RaXuL7F/hDSVs4Z59tBopFQxVvBQlQ
         QyjbV7w/AgMBpd+5glscfsRj+u1yJ+4wdfgRnLLC40Y369Yt5VhPxMcbJaVcEc3Y/RJD
         eXeMhaA9X0PuzRKXSGtQH8bnF9w+jtL9RIjXxhQu8FPdTR1Fyq9DjoFUvJkKHOnMzC7N
         DlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UJ2njBuNaj0VaWfPhX2usnjUYhb68jMwXCP3GoFIvQE=;
        fh=ZETVI6zHfe2A/6P1ovF9PRe6oZ+9Tg6vq3dq04vqpCs=;
        b=W4XN1PveU7GU9k4z78vLg3DPS2gMLiaGK8BoTWG6nUamOl4DQ2Q3IqhuLE0bqdmDik
         Jk9UINynCfcWn6uqkpeuea1hNKFa+PiyKKSVPbOqjrwXyf1SkHMbQV5Q3b5KuRz2fxlk
         OPHh8bPDb+GzToxe9FlGvBQI3wn+ZJONLCcYwIzuAkEi2WmqcqZiTu3LcJ3I/g4+V5Kj
         36m5Nzzhz80UacPr6j/cZtF1ybHsBOkcdf8WSlODgJPqAnMGXboygmp2s46CiYFJHfBM
         WDksaDDHVZi1aG3+XH6PgmlFhj58bEwioER7garhadtCvFi8SB9MhIQYxjzqyFBby6zB
         bwGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579178; x=1775183978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ2njBuNaj0VaWfPhX2usnjUYhb68jMwXCP3GoFIvQE=;
        b=mcRmhyy5u5uJ9TUYMqHA5vykFUfV95SCoirQlMSXutXtkrVRQYV3P4eqBHmXvauwFO
         PxhmPjFHqdKK2RKekWE0EN9gasO4gK2a6fAD6Aq/pfSjTHxrUud+Hk4wjamCccbAfxSu
         tf2l/2eXGdq1I8KRm6MHzmK7qsiI7Zz6Ww6Ut8Fs/MGh43+rFREbaIqnhwFJ2ZFPwUyy
         iNMmt6UYPRttIctTxCiw4mBJCq8KqDdNzRV4cl7e9wTQ4oc2HjlBQ15861wQLisnXUHu
         lbaYe0aGFT/7qgmjNKZhoHagZDI3nKEnLsCiUvhkZBNPA8admw+KxYe8GwTQJ0+eYLor
         2GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579178; x=1775183978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ2njBuNaj0VaWfPhX2usnjUYhb68jMwXCP3GoFIvQE=;
        b=frjQ+XFDe6szXtBE0K4m77B/n/7EGPh3Ygf5jNyf7SlalRSQXvr4t2sWgS1+InlF5u
         V58nT1PSS5+o+TWKHCYctQDYjOiLSb9+/8AF5YXhrP1RA2hGpO/jQrLowUt4myD/9mgY
         KUV7XHcJCvk3KBqx4Y36h14OREtNAt9Aa5GgQ5hq0Kb034XtGK83A489e+11T8f3xQSO
         SimPxksOmYRwh/WNEzntJEiIZX8iSphHSI+Z3e0oSMYIlghEPfIRY0EeKFYRypENdaAx
         fIXi1exlCml15tN/socWpHCRybm/SiOPrb4xXSDVNGUwiv2yRMr2RQ5bCciElHTCfHzq
         McCA==
X-Forwarded-Encrypted: i=1; AJvYcCXHn4AXEaXd4+snN+7OrRLo5naP7Eo5pZ0UFr2D8ek5KXkNlnW1Qpx5bfkaSR2XwtRQI//jiYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSGfLpz3Ohl8Q2x/ncWDq9XZiDuhZWC5Mc/o8vKax6fUZpT/2
	Jp4cyofN1oNxWuwZ0K3OJoCIus9yCi9Ew2XGn6DsEoR/G/1fOzHFBmqqNrX1P3KVd3TTBPOUV3T
	/OEoPo5N00SWvTYJQ+thC7IRSZi8brCs=
X-Gm-Gg: ATEYQzx7pZjf9f/9RiOspD/8a7pnI57JvJqpSKBSaK1D6s1MAwOJrWaxWeIzzNdxQ9q
	ldof0wz8i26VNyAMenxKil18hdz5GVuVpV8Xoj4IkJcCYjAKzIaD7mRDUVEXAYIvcGlxSP8R2K6
	KB0nA7s1fqo6VUnVy3VxznbHW1EOamOM3HlPrlH96feK+7F+eyinS+58/G7lX5JDTXIr2YPGqFr
	Ne2PDJU0wjxwH2L+1eUhJthaIi6CzSgy867evzwZpvOTNoPm4jy6iS5GtcB3BXNArkKxZ5xCQcl
	beeA
X-Received: by 2002:a05:6402:4618:b0:665:e9f:9021 with SMTP id
 4fb4d7f45d1cf-66b2855f8d5mr335186a12.9.1774579178032; Thu, 26 Mar 2026
 19:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <20260323182823.5813-3-teknoraver@meta.com>
 <IA3PR11MB8986307A14724905DE2FDFF6E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986307A14724905DE2FDFF6E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 27 Mar 2026 03:39:01 +0100
X-Gm-Features: AQROBzBiAPRhsRa45Vggn9i03leNAE9sOWPbFipz0NnppklDg7IYO0SsDmOrUoA
Message-ID: <CAFnufp16d3BtZ_A6Zp-yV80CUruTo32EPE7pqCXKYnmzpnacxQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 2/2] e1000e: add
 XDP_REDIRECT support
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272340-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F92133E73B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno mar 24 mar 2026 alle ore 09:48 Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> ha scritto:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Matteo Croce
> > Sent: Monday, March 23, 2026 7:28 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> > Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> > <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Mohsin
> > Bashir <mohsin.bashr@gmail.com>
> > Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v4 2/2] e1000e: add
> > XDP_REDIRECT support
> >
> > Add the ability to redirect packets to other devices via XDP_REDIRECT
> > and to receive redirected frames from other devices via ndo_xdp_xmit.
> >
> > New functionality:
> > - XDP_REDIRECT case in e1000_run_xdp() using xdp_do_redirect()
> > - e1000_xdp_xmit() as the ndo_xdp_xmit callback for receiving
> >   redirected frames from other devices
> > - xdp_do_flush() in e1000_finalize_xdp() for REDIR completions
> > - xdp_features_set/clear_redirect_target() in e1000_xdp_setup()
> > - NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT advertised
> >
> > Assisted-by: claude-opus-4-6
> > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > ---
> >  drivers/net/ethernet/intel/e1000e/netdev.c | 85
> > +++++++++++++++++++++-
> >  1 file changed, 81 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> > b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index d77f208f00cc..01661e1a74e5 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -41,6 +41,7 @@ char e1000e_driver_name[] = "e1000e";
> >  #define E1000_XDP_PASS               0
> >  #define E1000_XDP_CONSUMED   BIT(0)
> >  #define E1000_XDP_TX         BIT(1)
>
> ...
>
> >
> > +/**
> > + * e1000_xdp_xmit - transmit XDP frames from another device
> > + * @netdev: network interface device structure
> > + * @n: number of frames to transmit
> > + * @frames: array of XDP frame pointers
> > + * @flags: XDP transmit flags
> > + *
> > + * This is the ndo_xdp_xmit callback, called when other devices
> > +redirect
> > + * frames to this device.
> > + **/
> > +static int e1000_xdp_xmit(struct net_device *netdev, int n,
> > +                       struct xdp_frame **frames, u32 flags) {
> > +     struct e1000_adapter *adapter = netdev_priv(netdev);
> > +     struct e1000_ring *tx_ring = adapter->tx_ring;
> > +     struct netdev_queue *nq = netdev_get_tx_queue(netdev, 0);
> > +     int cpu = smp_processor_id();
> > +     int nxmit = 0;
> > +     int i;
> > +
> > +     if (unlikely(test_bit(__E1000_DOWN, &adapter->state)))
> > +             return -ENETDOWN;
> > +
> > +     if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> > +             return -EINVAL;
> > +
> > +     if (!adapter->xdp_prog)
> > +             return -ENXIO;
> > +
> > +     __netif_tx_lock(nq, cpu);
> > +     txq_trans_cond_update(nq);
> > +
> > +     for (i = 0; i < n; i++) {
> > +             int err;
> > +
> > +             err = e1000_xdp_xmit_ring(adapter, tx_ring, frames[i]);
> > +             if (err != E1000_XDP_TX)
> > +                     break;
> On first failure, we break out of the loop. frames[i] through frames[n-1] are silently abandoned.
> It should be no memleaks I hope, but silent packets drop is nasty!
>

I wanted to be consistent with other similar drivers, this i what igb
does in igb_main.c:

for (i = 0; i < n; i++) {
        struct xdp_frame *xdpf = frames[i];
        int err;

        err = igb_xmit_xdp_ring(adapter, tx_ring, xdpf);
        if (err != IGB_XDP_TX)
                break;
        nxmit++;
}

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

