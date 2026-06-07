Return-Path: <netdev+bounces-296251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q67NEPuGJWr0IwIAu9opvQ
	(envelope-from <netdev+bounces-296251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E2650CE3
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NVze6Ieu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296251-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296251-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 520083018437
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8939C019;
	Sun,  7 Jun 2026 14:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF33859CE
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 14:57:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780844254; cv=pass; b=Lpw0/SZApkCTSVGjuDGEs9m14Hti7IIJGVb4z9YnrrwEbTOyzNvIpR6xQedr46wV+kVO90UOW5KARzpxB6tXsIE1sQyVC/g7lMWcN8CmfJ6MkIXHP3n3+MdTLv0OAauw/zzYV4WCBqJd3qLqPBZz2PtmayH8vou3G6X08SAioLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780844254; c=relaxed/simple;
	bh=J7FO8rNeBHhd738iYmLPaOFFhde7lx+0DYImZHcOwRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh7ITpoKSfLd5ZjGvtoXXdTrbNnQ1HXz5Z3S2bpiExVZ/MaGZBxqu7I+oNKBIGUv3fjFSpHvB5otl4pEXHN8QnObbVFF2q2N5xNb+TtDv41Y6X47ZhOChNxN8LUCrH3+xQh8t8TIRE4zAKZgV7pTwLlKD9GITSaxKH/uKth0nmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVze6Ieu; arc=pass smtp.client-ip=74.125.224.46
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-660456349d9so3461510d50.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 07:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780844251; cv=none;
        d=google.com; s=arc-20240605;
        b=Dyuds6eLauPf502SWdbI5xnVU/fsU/Hj66ryq0TutkSPNkV1iQcaLXLtPjpx5kV/0D
         V4l7qGo8E5hpqfmHjgc7bCDVfGyxl4BstwY7TlNdt24YnHMdfenWFU6Sw4mxNDxj/BkP
         hIVjoGxZQcOtwfOX+ipNcurXho2pkvPb6dINP1CQRE2KcRgtq3D+95zUbRZHRUjuv8UZ
         lP2XyCGGEhQTE6NKYJb2jMNvHOxiH8LoXKprp8IWixRTodCoMbOpSSSn3c0v3NNF8NFs
         Hd1JuAOb2L2s8urGecz5N3DDanjQIKy0k9ho5xUcFvUSlF8CHoUOANw2UupnmpL9SzQt
         zo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MyUoD5DSJ9qV4GIFVl+nQMb0ZRsjixd3Li9Iu7KWuyg=;
        fh=mf/Qmw3ufC5N7tULX/I1MJgudfWaZ1DF/MI9al+1AHI=;
        b=cRSwLzoPUqaXpFbt5y/t4PH+O6LvcDtA48MxNo3bj4CpBZFVwv/qRMbTquO2Btymca
         tWgoa4HVbx2tgniyFq0jubxRWcSuwkhVku9Fy+JdpNTLfVjUNMvx0YTbjlLcBEt0Acy6
         CUcUzJdHoCIkLoFVKjnuCPdCaDxTCC6fdCEZsAupwGDgV+zej6pRioJAxktlcjkFUr5T
         4ApAvJ+HKMnRrOgZzMxvewUe78qybBjAtqGWrJWtMyNmMgtfuScW+fvBs9Wh8tsAgHT/
         nIHgdmB38uddRNnu5iwsY+LzflnZSEN3CLOcEVp6D/L+trFmvE8ud2awHAOQZve/G8yF
         nSew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780844251; x=1781449051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyUoD5DSJ9qV4GIFVl+nQMb0ZRsjixd3Li9Iu7KWuyg=;
        b=NVze6Ieugqf1wP3ObzpNVB/n1gaCpu3HMliaGubW6b8BpSnyZ4waJqKMrY/cnMZjcn
         nfA0QJC6u/obK+N1ORm75e7bFSHuzYnA6UJBfGQsqhmP5J4dx1ntKVQLykz3h/ROmJLX
         yf9jwmBwi37JGsIIJvZKH5rNxTpGSHSJV4G0mKeQnXyssPGmYnt1Rc7uZmaRJDBaQYDf
         r32r7jdPB33x78YUBXD4n3KNXapveQnTvDbS9e7FsH6Ree/xGteF4PqBjqITW7PL6cEn
         G9R624fbOOqcdOFD6KfLEqvAOCuCBud8j6aX0hQin2vRqEXl2HBFzigpOSDVFLvqtnOo
         Mokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780844251; x=1781449051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MyUoD5DSJ9qV4GIFVl+nQMb0ZRsjixd3Li9Iu7KWuyg=;
        b=Ra5/fATmYzP+MK7fO+EDqI+f5gMW1MFbO5J9yXn3xe00tj0QFl3ZmBizfk0WYKpoDO
         dmHQntM9Qkca7Y3tNpHOr7r4RWy0HjZj7L3lTHAQpABozvworDRORjTafJRT+inE95/o
         oRLs3aH4P/LA6Yqoudz8V+lYv45VlZKeTiV2GypkSM6eB29EICZkMxTS9RLtS4GKUmIj
         aXWp80Y46JdFUCQycwSPEL2oYKCtruZsQTs7dO9CuUWnpARsDVElTOuEQOXFrz9URw6R
         Wny5uCRTIyMOmciHKd0BLd61PnfB98tkq9z5zuOws+U/AB1Pkrd5tt3EMn9rl8tDBDLV
         wapg==
X-Forwarded-Encrypted: i=1; AFNElJ8hEjoQDaa3xI3+gg2uOC07CwLQF405kd+SUPj6ph7zq02qUEoingyYq3jl9TLUi/GH5/URP/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cN0CSj3mWoeADCIn1pG7RWPNMQqDxxwUIIRvarhy5DS0ZeP8
	h1ZO2WLVpGH152c1uUXHWgVhxadMnDHHmjuAnXRDXlanRj4/sI2Yht3Kmq2CRyZNUY4MhuExMyP
	Gjgzbvv12IHM7R+stIYUxG/3aiJ1QsF4=
X-Gm-Gg: Acq92OGffLFIZoDlA8y2cKFNNk4DkgvCqVfqNMxl348b9wRdrb9+l3TTSipb1S21dPg
	VP1lwVqPuhakrtyo01g2Exx+7+zN9EjfYx+RlGW2fTA68aaUfDSiupi0bMYEoKIsFQxj1ZsvhVX
	OFaxgc3fm8XLK1LK41aqNh2A/baFlyFBzs67UgFCVMCODBOCea+//NUQ4noN1ZorBOzDmOLAYfK
	PBFz8SA+4AjsqkUxSbqt6yGOjbVc3kWuDguTyNT2XsyZnaTsdXLEoL6zN0VKJ+5iQTsU9wlwmFN
	bz5YmvUZdpRyhHhL/no=
X-Received: by 2002:a05:690e:c49:b0:660:5c10:df11 with SMTP id
 956f58d0204a3-661070c04f7mr11777501d50.60.1780844251472; Sun, 07 Jun 2026
 07:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604112846.1420908-1-lgs201920130244@gmail.com> <CA+XhMqyzy9B_UFeSC80XG-1ZMh4ckhZiXHT9anNsVutmZdmk0Q@mail.gmail.com>
In-Reply-To: <CA+XhMqyzy9B_UFeSC80XG-1ZMh4ckhZiXHT9anNsVutmZdmk0Q@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sun, 7 Jun 2026 22:57:22 +0800
X-Gm-Features: AVVi8CcCrEj5XAdK4dp0xOE1JuG6b--Uue7KTDDPEIa-P51dPasYkE16aY9HmBs
Message-ID: <CANUHTR8oByARnm-2REh8QaDznwj3Z1rGdzKKJ5-+sTZPL2poEw@mail.gmail.com>
Subject: Re: [PATCH] net: lan966x: restore XDP RXQ page pool on reload failure
To: David CARLIER <devnexen@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnexen@gmail.com,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296251-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A95E2650CE3

Hi David,

Thank you for the review.

On Thu, 4 Jun 2026 at 21:46, David CARLIER <devnexen@gmail.com> wrote:
>
> On Thu, 4 Jun 2026 at 12:31, Guangshuo Li <lgs201920130244@gmail.com> wro=
te:
> >
> > lan966x_fdma_rx_alloc_page_pool() registers the newly allocated page po=
ol
> > with each port's XDP RXQ. During an FDMA reload, this registration is
> > performed before fdma_alloc_coherent() is called.
> >
> > If fdma_alloc_coherent() fails, lan966x_fdma_rx_alloc() destroys the ne=
w
> > page pool and returns an error. The reload rollback path restores
> > rx->page_pool and rx->fdma to their old values, but it does not restore
> > the per-port XDP RXQ mem model registration. As a result, the XDP RXQ
> > state can remain associated with the page pool from the failed allocati=
on
> > attempt while the RX state has been rolled back to the old page pool.
> >
> > Restore the old page pool registration for each port's XDP RXQ in the
> > reload rollback path before RX is started again, so the XDP RXQ state
> > matches the restored RX state.
> >
> > Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan9=
66x_fdma_reload()")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  .../net/ethernet/microchip/lan966x/lan966x_fdma.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > index f8ce735a7fc0..76654b44baf2 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > @@ -855,6 +855,21 @@ static int lan966x_fdma_reload(struct lan966x *lan=
966x, int new_mtu)
> >  restore:
> >         lan966x->rx.page_pool =3D page_pool;
> >         memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
> > +       /*
> > +        * lan966x_fdma_rx_alloc_page_pool() registered the new pool wi=
th
> > +        * each port's XDP RXQ before the allocation failed. The new po=
ol is
> > +        * destroyed by lan966x_fdma_rx_alloc(), so restore the old poo=
l's
> > +        * registration before restarting RX.
> > +        */
> > +       for (int i =3D 0; i < lan966x->num_phys_ports; i++) {
> > +               if (!lan966x->ports[i])
> > +                       continue;
> > +
> > +               xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rx=
q);
> > +               xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> > +                                          MEM_TYPE_PAGE_POOL, page_poo=
l);
> > +       }
> > +
> >         lan966x_fdma_rx_start(&lan966x->rx);
> >
> >         lan966x_fdma_wakeup_netdev(lan966x);
> > --
> > 2.43.0
> >
>
> Hi Guangshuo,
>
> Just one remark. The re-registration fix looks right, but the same
> restore path has a related gap.
>
>   Just above the failing alloc we set:
>
>   lan966x->rx.page_order =3D round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1=
;
>   lan966x->rx.max_mtu =3D new_mtu;
>
>   These aren't rolled back in restore:, so after a failed reload
> page_order/max_mtu are new while pages/fdma/page_pool are old.
> lan966x_xdp_run() then calls
>   xdp_init_buff() with PAGE_SIZE << page_order, advertising a
> too-large frame_sz =E2=80=94 for a jumbo MTU that bumps page_order,
> bpf_xdp_adjust_tail() could grow past the real
>   page.
>
>   Could you save and restore the old page_order/max_mtu too, so the
> restored RX state is fully consistent?
>
> Cheers.

Yes, that makes sense. I missed that page_order and max_mtu are also
updated before the failing allocation and need to be restored together
with the old RX state.

I will save and restore the old page_order/max_mtu in the reload rollback
path, and send a v2 with that fixed.

Thanks,
Guangshuo

