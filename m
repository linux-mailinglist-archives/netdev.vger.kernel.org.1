Return-Path: <netdev+bounces-260492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH4IFE6RnWlKQgQAu9opvQ
	(envelope-from <netdev+bounces-260492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:53:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D946E186A1C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A6E430E50B6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349DF3803DE;
	Tue, 24 Feb 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUDBWd0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBA3806A3
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933750; cv=pass; b=dSJWcJ6WnRSmfB28wCR7rf+L+rg8/ey3Ee4zjvw1wfsKGLDpfPMkFtk1An6pPMMaYbrtj5Uu6AED7hnssNgQdRRND81R58DTYvehyKLY48rKEkrLaLBnIqX0UoKusuxDhu+wwqmawA9V9pdkBu0DCUQi4bGnXm1ncX8MeMQYbwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933750; c=relaxed/simple;
	bh=Lr15R0BmBHIHG79ofVrwIlmsPKJkDJ469UbpjnwLahE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InVbMpD55rcqJj/S+aiwQvOZ/ntIKDkh2/fCfDBtdJd6Huxm2c932TCJuCQhTlJB2o6mdi3+Fna+qxnEUNxABJP/iVsqn87gmQbl7PTV0F8mAHY2TgXtmREehF5uDcA3IN8yc36vsQNhJO3hjTj7AepsQxvXNbh8YyirKzb1V+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUDBWd0s; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59f855fd0d9so5667642e87.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771933746; cv=none;
        d=google.com; s=arc-20240605;
        b=bjj51TMpF7nbDJFG+8r17AaQF8mBmRPIS/KiHCmeOlNMyQl3s1vuW0V3MzjmteVSWd
         JTNwhiPreGmwnB6Qp0OCtWlTXDefh/chw50VEv1t8Vcr6vGosHw9sifkbAEyx59b3gMG
         tjDYWCCD5Dp1Tx5mlY6FQ1EnEYRa6p/I7wm4p4OZIwQqVmdRikfJWATtx69M3knyoS/p
         uBzHNjUh9P33u4IDMjJgDN+Sa6n72uDVDCJ6Q1FGwomLufV/zYLVhY3VUXPDFjlfJOSf
         MNOINBHbBxOCaZWn700c1spZleD8vPJOSQFZ1kYOktzRZ6dpEkn5xRzMo4Zq9VPaX+p5
         TLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h/euQxUOUQBNHH0A8e4HOjbXUtrG4J7/XHCtrK9VRHI=;
        fh=iimxS/toxw1tqakfW7lgDLfbqHnkLGiu5BceWk1v/ZM=;
        b=bNV33bKGgfqTRiTdA9/l3pCAYbFX/Rl7/8wwBdXnhX1gjRaxZ6hrTQtxaema6Vmlfc
         P8r32jiBChkJzMeQGZRrdBee80ovwkEvo40/kM3N5ojaMAkrda3QYBU0/a/S6QAZzk2E
         kLdwtoaM1wp+/y3ceuttKrmiF/GrtR/oc/LTdMVxMktZMOyN1B9IxvTMNpB78D2xgi1r
         o4EHXyRN73VZJi1Z5Kfi59Xv/H5QVmyWAxRN/2CO0gA4/eKWaedy126uGWw47NszLgRz
         gEZYY3QM9/NUxvfye6zoSMdfH9U8fPuK764KPkkDHzeih0M2xIh0vsxoUjBpjbPoO309
         UcQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771933746; x=1772538546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/euQxUOUQBNHH0A8e4HOjbXUtrG4J7/XHCtrK9VRHI=;
        b=dUDBWd0sXpEG4nZBLNd7fMrvABBNAANlkFl+tyZeOQ2IhSpFKAtiRbodIUMgHPrChb
         UyyVicYwqR6Mv4zQgjCfsb3HfSLTZgPaT5QuHvS0O5fvSArL8TwqO41tDwXg4HHUmNlF
         9rOKJAqsMMAFR9kX43pIF8mDhQ9ZOd/w0yvuaoRFT/u5XY9zlcA9koeVjWi2hkPe6vz/
         9p7LNxYO0+BiIY7cpYc6vhEuTVoM3Iv546i9gTR8o5MCtRjELRFBenx9Jg/CgKxkHI2A
         mSvkGEc1Orv01MlRq+DG4rnRmVM1QgfdY/LoskK2xlyH8XYVKGbYjtP7ZuIDoZyZjQHL
         9uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771933746; x=1772538546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/euQxUOUQBNHH0A8e4HOjbXUtrG4J7/XHCtrK9VRHI=;
        b=LwbZRDRSB/BkZ9K6ZIAhrqU866WWF5SGVemKGpqNbSlblyHSUJOHXx5l/wSooNbMOw
         5sXA9DHaEVGDuRoS3IQtVBCcRCCxwtDS/+MMy+BNUSHfqQwjPUNFLCFvsI/uuyj8Ly+t
         vLvA8el0ekZohmCni6qZ7ud/nxTjg+djzgae/B/s6z6YQBHOMXOXDfdCa+yKNFigsawf
         fXGHwc55sjvgOFn8Unq2zPesJsdyHhd8ILtPcouB5EbcDIBLZZ3wgclXcKguHFNRZCR5
         r+kCI5M+J0WLl+yMjyxOsyLflES1Nkrz4rlfASx01cREPUgfY8PNatDwIkF72uD9sUuM
         FrEg==
X-Gm-Message-State: AOJu0YzJyxfxVSKh/TSsUV5HrVAb+WOH2vVH9lc4QUsymA3ux63AFBME
	ZqPTtePSjyqsTTtILd7lkp7HOP5sjg+iHPTO0GSynMy+zus3RL+iZ3WLOZ21S+ptoPdvlWOEhv7
	Jvf+J7yLMM77VYvZZxtG1NYh828ZvWP8=
X-Gm-Gg: ATEYQzw/QL+EBrcax2cH0BPW8HLTRPT2YcOkj1vA5cYt6o+Dz0f7IIXRi2hLaatXz6J
	VtKfU394pSz4hIxcuRdqRIPwu/YWdVhZU3pYoXZvzYK1D85zOgtPdnrV9yWE1uD4nagmJMXYp8n
	gvppWAYRhmPgjmla3tTCeXEmzuVRwUbCMH1nKkznSBEkpn9bUy1o3J7mStWnAZ5v1WH9c5gzG3w
	heLByxU55j53I8pBp/Kk0+rT1hyP/YpLv+4MinRqvj/wXVK9vniWCQu+3wE+u+DvPiKOjLCOuRG
	SMfYMuaMCnK1LkASHWM=
X-Received: by 2002:a05:6512:1153:b0:59d:d799:b7a0 with SMTP id
 2adb3069b0e04-5a0ed8a6722mr4078759e87.36.1771933745576; Tue, 24 Feb 2026
 03:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
 <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com> <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
 <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com> <CAL+tcoDzik63K1aqpDTn7K6Jkta5ZtjedTQ58TB455+pwkq8Pw@mail.gmail.com>
 <3AB6E925-3A2E-439D-8432-B00F4DEFE7F1@bamaicloud.com> <CAL+tcoD+TL6xbTodAKp=w0NVeLOubxoJpk=-b_8Z0bPvFrzXCQ@mail.gmail.com>
 <4E09E708-FA5A-4523-8E75-359C3D8B43E6@bamaicloud.com> <CAL+tcoAo++zNTneOD+YM5gbAqSOyZtGT=FgRUpSZuzrE7WffHw@mail.gmail.com>
 <8BEBBF67-92EE-4E6B-9D92-863A80883429@bamaicloud.com>
In-Reply-To: <8BEBBF67-92EE-4E6B-9D92-863A80883429@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Feb 2026 19:48:27 +0800
X-Gm-Features: AaiRm50gBBHRZS3vfMHW_cKBSztFjm2bwMH3-hFRWFd4ls9HYc76160qaNwiOVg
Message-ID: <CAL+tcoA-i-aKgjBwt0MPzhFjgMQ3qELJyB+Fd+cpYzMita8v+Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,fomichev.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D946E186A1C
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 6:29=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.c=
om> wrote:
>
>
>
> > On Feb 24, 2026, at 15:23, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> > On Tue, Feb 24, 2026 at 2:54=E2=80=AFPM Tonghao Zhang <tonghao@bamaiclo=
ud.com> wrote:
> >>
> >>
> >>
> >>> On Feb 24, 2026, at 14:24, Jason Xing <kerneljasonxing@gmail.com> wro=
te:
> >>>
> >>> On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang <tonghao@bamaic=
loud.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.com> w=
rote:
> >>>>>
> >>>>> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang <tonghao@bam=
aicloud.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
> >>>>>>>
> >>>>>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang <tonghao@b=
amaicloud.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
> >>>>>>>>>
> >>>>>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <tonghao=
@bamaicloud.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Network device statistics retrieved via procfs, sysfs, and net=
link
> >>>>>>>>>> represent the combined total of core_stats + driver, hardware =
statistics.
> >>>>>>>>>>
> >>>>>>>>>> However, in some scenarios, when monitoring netdev metrics, it=
 is valuable
> >>>>>>>>>> to clearly distinguish whether the values originate from the n=
etworking
> >>>>>>>>>> stack's core statistics or from the driver, hardware layer. Th=
is helps
> >>>>>>>>>> improve debugging and addressing issues.
> >>>>>>>>>>
> >>>>>>>>>> Approaches were considered:
> >>>>>>>>>> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_=
inc()").
> >>>>>>>>>> This allows tracking increments to core_stats and helps identi=
fy specific
> >>>>>>>>>> causes of changes, but not provide the total counters.
> >>>>>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
> >>>>>>>>>> This would likely confuse or break existing userspace applicat=
ions relying
> >>>>>>>>>> on this struct.
> >>>>>>>>>> - adding a tracepoint inside dev_get_stats().
> >>>>>>>>>> This implementation is not simple or straightforward enough.
> >>>>>>>>>>
> >>>>>>>>>> The solution in this patch is therefore to introduce a new ded=
icated function
> >>>>>>>>>> for collecting core statistics and mark it noinline. This appr=
oach is simple,
> >>>>>>>>>> clean, and maintainable to obtain driver, hardware statistics =
separately when needed.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>>>>>>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>>>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>>>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
> >>>>>>>>>> Cc: Simon Horman <horms@kernel.org>
> >>>>>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >>>>>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >>>>>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
> >>>>>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> >>>>>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>>>>>>>
> >>>>>>>>> It's a simple refactor patch that only moves that logic to a ne=
w
> >>>>>>>>> helper. I don't see any new possible callers right now so could=
 you
> >>>>>>>>> provide more straightward/clear use cases and intentions behind=
 this
> >>>>>>>>> patch? For example, give us what kind of dumping stats you want=
 to
> >>>>>>>>> tweak and your next movements.
> >>>>>>>> Thanks, Jason
> >>>>>>>> This patch tries to add one helper function which marked as noin=
line for bpf tracing (this commit 5247dbf16cee also use the noinline for tr=
acing). This helper is not used other place in kernel.
> >>>>>>>>
> >>>>>>>> For example,
> >>>>>>>> sudo bpftrace -e '
> >>>>>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_lin=
k_stats64 *)arg1)->rx_dropped);}
> >>>>>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_=
link_stats64 *)retval)->rx_dropped);}
> >>>>>>>> '
> >>>>>>>
> >>>>>>> Can't we use the global symbol dev_get_stats() instead? It should=
 be the same.
> >>>>>>
> >>>>>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage is=
 not used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped, f=
or example, is 0.
> >>>>>
> >>>>> How about computing the delta of @storage->xxx between two consecut=
ive
> >>>>> kretprobes hitting this function? And you can also identify the sou=
rce
> >>>
> >>> two consecutive __kretprobes__=E2=80=A6
> >> I got it. In fact, it is not solving the problem. For example, @storag=
e->rx_dropped is increasing, but it's impossible to determine whether the i=
ncrease comes from core_stats.rx_dropped, from the driver=E2=80=99s rx_drop=
ped, or from both.
> >
> > To be more specific, in dev_get_stats() @storage is only one memory
> > area that records the information from @core_stats. So it is
> > @core_stats that takes effect and is widely used/scattered over the
> > place (please see how one example like dev_core_stats_rx_dropped_inc()
> > gets called, it can be used by drivers like ipvlan or stack). We
> > cannot tell which one causes the increment by looking at @core_stats.
> I don=E2=80=99t take care of the virtual net device. In our production en=
vironment,
> there are many network cards from various manufacturers (mlx, intel, broa=
dcom).
>
> By the way, can we use the driver private stats instead of the core_stats=
 counters for macvlan, ipvlan, tun, bonding, and bnxt.
>
> # git grep -rin dev_core_stats_ drivers/
> drivers/net/bonding/bond_main.c:5291:   dev_core_stats_tx_dropped_inc(bon=
d_dev);
> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:    dev_core_stats_tx=
_dropped_inc(dev);
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:          dev_core_stats_tx=
_dropped_inc(dev);
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:                  dev_core_=
stats_tx_dropped_inc(dev);
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:  dev_core_stats_tx_dropped=
_inc(dev);
> drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:220:               d=
ev_core_stats_rx_nohandler_inc(skb->dev);
> drivers/net/ipvlan/ipvlan_core.c:598:           dev_core_stats_rx_dropped=
_inc(skb->dev);
> drivers/net/macvlan.c:383:      dev_core_stats_rx_dropped_inc(skb->dev);
> drivers/net/net_failover.c:92:  dev_core_stats_tx_dropped_inc(dev);
> drivers/net/netkit.c:124:               dev_core_stats_tx_dropped_inc(dev=
);
> drivers/net/tun.c:1081: dev_core_stats_tx_dropped_inc(dev);
> drivers/net/tun.c:1237:                 dev_core_stats_tx_dropped_inc(dev=
);
> drivers/net/tun.c:1567:                 dev_core_stats_rx_dropped_inc(tun=
->dev);
> drivers/net/tun.c:1575:                 dev_core_stats_rx_dropped_inc(tun=
->dev);
> drivers/net/tun.c:1589:         dev_core_stats_rx_dropped_inc(tun->dev);
> drivers/net/tun.c:1913:                 dev_core_stats_rx_dropped_inc(tun=
->dev);
> drivers/net/tun.c:1970:         dev_core_stats_rx_dropped_inc(tun->dev);
>
> >
> > Besides, another trivial thing is that, even with your patch applied,
> > it doesn't change anything since core_stats->rx_dropped can get
> > increased in between kprobe and kretprobe of the new helper you added.
> The new helper only gives a proper hook point.

The patch makes no difference. Please see below.

> >
> > With that said, how can you accurately know where the increment comes
> > from? Is it from the stack or driver? I dunno :S
> If considering the virtual net device, it is not easy to know where the i=
ncrement comes from. It is only useful for hardware NIC.

My whole points are 1) @storage as the first parameter of
dev_get_stats() doesn't mean anything because it's a temp memory area.
Previously you wanted to use this to know the source of counters,
which is apparently wrong; 2) reading @core_stats is the only way to
help us understand where the increment comes from, but it can't. This
member includes many different counters that can be used in either
stack or drivers. The usage should be general, IMHO.

So again how can you be sure where the increment of one counter
happens? I mean how? Could you provide us more details about _how_ to
know where the increment comes from? IIUC, by only hooking either
dev_get_stats() or the new helper it doesn't work.

Take a look at this counter, so many callers:
$ grep -nr dev_core_stats_tx_dropped_inc ./net/ drivers/net/ethernet/
./net/hsr/hsr_device.c:239:             dev_core_stats_tx_dropped_inc(dev);
./net/core/filter.c:2292:               dev_core_stats_tx_dropped_inc(dev);
./net/core/filter.c:2297:       dev_core_stats_tx_dropped_inc(dev);
./net/core/filter.c:2399:               dev_core_stats_tx_dropped_inc(dev);
./net/core/filter.c:2404:       dev_core_stats_tx_dropped_inc(dev);
./net/core/dev.c:4057:  dev_core_stats_tx_dropped_inc(dev);
./net/core/dev.c:4859:  dev_core_stats_tx_dropped_inc(dev);
./net/core/dev.c:4899:  dev_core_stats_tx_dropped_inc(dev);
./net/core/dev.c:5596:          dev_core_stats_tx_dropped_inc(dev);
./net/sched/sch_generic.c:641:  dev_core_stats_tx_dropped_inc(skb->dev);
./net/xfrm/xfrm_device.c:144:           dev_core_stats_tx_dropped_inc(dev);
./net/xfrm/xfrm_device.c:168:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:
dev_core_stats_tx_dropped_inc(dev);

Thanks,
Jason

