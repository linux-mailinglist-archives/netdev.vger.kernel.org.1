Return-Path: <netdev+bounces-260834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJtgG1XAnmkDXQQAu9opvQ
	(envelope-from <netdev+bounces-260834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:26:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCF7194F2D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFCF0300D4CE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0BE313291;
	Wed, 25 Feb 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH44VtAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC25280330
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011398; cv=pass; b=dHDB+xVE2Sb2r4GxlCpYCmPHIfqFlhAgQKu1mZajgmw6urHWYmRydnNeNdgX6p65N6Z040nZaRpi3Mqf1/jfR2yXKaLCv01zX+HbCJ1lMMvrPqDJAmTkCXVF6uhIqniDvtnPGD4pUua6moyr0bN6Iedl/cbZoRxciCLdbxI3hYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011398; c=relaxed/simple;
	bh=ACjCc3fCrhHQAzFa/2XwdsgaLqYgjNxDnb426hL9mfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPanDovniglBPEm1JMnnUUSkxEU4rluk1Oq0VUf8BomohlOnVSftShe9aGPDURjvxBjGRBtMdCAjDDb9aOvE8hxEza8giCBfiqsUgh6q7lsYJsPTobBIpZ5YigUcYi3MbUWLqmgm4KVZi7am9Sn+IfPd10ec36VxR8bKoetiLC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH44VtAt; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdbe434b47so1725211eec.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:23:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772011396; cv=none;
        d=google.com; s=arc-20240605;
        b=RnnV/3AvDiUDKPUe4sybYKVErDh0N/rwB423mkO7gQaUimAw7iAmAwae2c2bbvY8ec
         TXzRkOvXVgOz20w9kaszfHJzXOOi4MeAu1llLPkRXBPLnHF4pqojrcziKyGDIZgwH8ni
         ABgxy/zGwAbCOL1nCzdbKMx+UXzc8Ub2kjBwOtiYzNM/73FMD2D3d30jktasV/OyCYDd
         woBHp5j2CZxrU8Z+rgxD+4OmmdgwhtZi8ZzGPncei96NbGDVHY2xuxqqVoclB1WcM02H
         lYbx4HhbufSjexsP1L6kqnWhgSc3lkkw0SwNpdQcMBS/41ItY4VK4WmufTf6jULKQ6Tu
         oYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ACDc3ttV6nXP7wS2EMPX9qOaV4rMMx/W5IxUWxC5T0U=;
        fh=J7RZbxma0yk+9v5jUWXKCv5eBjl/CudLaba+fRGcdhc=;
        b=eBhOTb7vvglmnsQ6PGvlUIEgG787RiUdEADtOmfieN3oKzTUiu2N/x4MKg1humH6zj
         Ak5aUH80cQaYKfPPkH4hnY1xTBfYNOPq+blnFskZyOF+Z0m15tnPmr2ntn2ovydYputQ
         cD+0p033IH/rzVamPJqvmZTyKVvDlYtdDUu3lV1/9Kltr2joW1zaZJh6TMxgGfaTERND
         GELFQ4k5NT1MKRQ6enhZUH0HBf8vmlfUrYlHS2gvtmb4DSPpZU95pVMl9P1RUgK/lYjg
         fn0RnhPDPz3szZ5ZPGuwZpjfU5U5O743FzHoVAZD7SI4OjgZzRVABLEGLx7FXGtMFGVy
         +Y5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011396; x=1772616196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACDc3ttV6nXP7wS2EMPX9qOaV4rMMx/W5IxUWxC5T0U=;
        b=NH44VtAt9Qn/n8CC3s6e1m5dBu8W4xvuN1DPE67Y+j3behOzPSEqHFmPL1I5hMrbLA
         grU2OqP6hLjXQ/TXELKeBM8eqKRqDxahIByVzxX8zzubf4anvctLC/IbVwwj93jTCiqL
         jelRXSmN8+HXek29iom9YQ0+JDp6iM2/PIE6EDP95+EbPs5i+5PqXQqWMFnIL0ngkx18
         DgpNOj1RdYYqa3ht9IBocHeOJHkvmrLNGHLbEQkY4CFXQB2x+bWlz5UdeHO3856Wmevc
         UTBjiG/2DH27f8FCyAXrfe3LUeJNxYaVjIQPdOp7MJqWOusmShx3tkuZv1Hs0hIKtvtX
         n6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011396; x=1772616196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACDc3ttV6nXP7wS2EMPX9qOaV4rMMx/W5IxUWxC5T0U=;
        b=WEMuBvj+iMRxPESikca1Om9tb9dvGuDTkN8xhR/Ch69C9sKudxg6RaxFwcbUk3nmiq
         SihREVUSBjdNzaLKJRfLD+uKt/R62puiZgbm2pv8D+8fYO2Oc6qOlHosKltEHZKKU96u
         AN0tdh3dKvnTn7ly6AWLkjhYtpDhX0uOTogvgoJMSLHpLj3OOxJ8wQsE5vy4V80hh+OI
         tD+SCtFDwDZXvISBrLXAc38kGOi+zkHcs0axxmxSzKqodLvozBW6/ndjinAyo8pKISpQ
         NS9EUAHZaZrr+RoQK4veQKC+n35SSoEvHHCtoUoVdrsAbK5eUqjqKZkcHB48yW5isXWC
         HpHA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/29CudKN3wMr8r/6NGewZegBPG6EMsJ/IDrSR3ONjlCin7me6/1XmaL7fyqVWGgGlgA0BBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcEzh4RZT3ERdklK+Uz19locj81aK3PCCb3gVWxG86nDv17te
	Rubmp7mWfiNwzh9urMfT6o2ZPquN9GqBuDs7bN5ThP0IPAf4vwt/41ahCL6pH6kVSL50pDV3XUr
	VBMluK3bQD3ukbx00OU2XsJd41O19xZY=
X-Gm-Gg: ATEYQzwOpNlY8mHDjOPVTqpxfPC7ydoII3l2DnYDGVwuz0vPygxKy1gW3PqnpmGOTng
	502HUrCr1wXf1Bu035iWD5RhbyoAi0B6xIqa9+aQZa5t624eChplOzCHDZdbtJgkUPu/XfjXanw
	54ozi5wHN+NDolyIZQUTrhNyhYu9ZrzuJqplmIjZpALbfxuXc2LM4QN7EVoXjtBa4doBJWovMN1
	7/8j6rvPrAD1G9OQg1VTdNkldijCgLtYiPpU0yCCFO5p05ITYv23FDfWM2f01AIP5hnYsFK73mu
	VtE/kB7E
X-Received: by 2002:a05:7301:2b07:b0:2ac:1a21:841d with SMTP id
 5a478bee46e88-2bdc32f905fmr607795eec.16.1772011396134; Wed, 25 Feb 2026
 01:23:16 -0800 (PST)
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
 <8BEBBF67-92EE-4E6B-9D92-863A80883429@bamaicloud.com> <CAL+tcoA-i-aKgjBwt0MPzhFjgMQ3qELJyB+Fd+cpYzMita8v+Q@mail.gmail.com>
 <A62D779D-CCED-4C30-9113-8FC803EBA191@bamaicloud.com>
In-Reply-To: <A62D779D-CCED-4C30-9113-8FC803EBA191@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Feb 2026 17:22:36 +0800
X-Gm-Features: AaiRm50He7h6JpU5qvIrMKpa6xFYLd6HzRppAcPUij3XFQ11qtFhihRCtIdOeqs
Message-ID: <CAL+tcoCT4PWrUPJ6jeRbCSG8tHATsd2QmLbMhPWdOoBngjO7yA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CCF7194F2D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 4:43=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.c=
om> wrote:
>
>
>
> > On Feb 24, 2026, at 19:48, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> > On Tue, Feb 24, 2026 at 6:29=E2=80=AFPM Tonghao Zhang <tonghao@bamaiclo=
ud.com> wrote:
> >>
> >>
> >>
> >>> On Feb 24, 2026, at 15:23, Jason Xing <kerneljasonxing@gmail.com> wro=
te:
> >>>
> >>> On Tue, Feb 24, 2026 at 2:54=E2=80=AFPM Tonghao Zhang <tonghao@bamaic=
loud.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Feb 24, 2026, at 14:24, Jason Xing <kerneljasonxing@gmail.com> w=
rote:
> >>>>>
> >>>>> On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang <tonghao@bama=
icloud.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
> >>>>>>>
> >>>>>>> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang <tonghao@b=
amaicloud.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang <tonghao=
@bamaicloud.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <tongh=
ao@bamaicloud.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Network device statistics retrieved via procfs, sysfs, and n=
etlink
> >>>>>>>>>>>> represent the combined total of core_stats + driver, hardwar=
e statistics.
> >>>>>>>>>>>>
> >>>>>>>>>>>> However, in some scenarios, when monitoring netdev metrics, =
it is valuable
> >>>>>>>>>>>> to clearly distinguish whether the values originate from the=
 networking
> >>>>>>>>>>>> stack's core statistics or from the driver, hardware layer. =
This helps
> >>>>>>>>>>>> improve debugging and addressing issues.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Approaches were considered:
> >>>>>>>>>>>> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stat=
s_inc()").
> >>>>>>>>>>>> This allows tracking increments to core_stats and helps iden=
tify specific
> >>>>>>>>>>>> causes of changes, but not provide the total counters.
> >>>>>>>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
> >>>>>>>>>>>> This would likely confuse or break existing userspace applic=
ations relying
> >>>>>>>>>>>> on this struct.
> >>>>>>>>>>>> - adding a tracepoint inside dev_get_stats().
> >>>>>>>>>>>> This implementation is not simple or straightforward enough.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The solution in this patch is therefore to introduce a new d=
edicated function
> >>>>>>>>>>>> for collecting core statistics and mark it noinline. This ap=
proach is simple,
> >>>>>>>>>>>> clean, and maintainable to obtain driver, hardware statistic=
s separately when needed.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>>>>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>>>>>>>>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>>>>>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>>>>>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
> >>>>>>>>>>>> Cc: Simon Horman <horms@kernel.org>
> >>>>>>>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >>>>>>>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >>>>>>>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
> >>>>>>>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> >>>>>>>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>>>>>>>>>
> >>>>>>>>>>> It's a simple refactor patch that only moves that logic to a =
new
> >>>>>>>>>>> helper. I don't see any new possible callers right now so cou=
ld you
> >>>>>>>>>>> provide more straightward/clear use cases and intentions behi=
nd this
> >>>>>>>>>>> patch? For example, give us what kind of dumping stats you wa=
nt to
> >>>>>>>>>>> tweak and your next movements.
> >>>>>>>>>> Thanks, Jason
> >>>>>>>>>> This patch tries to add one helper function which marked as no=
inline for bpf tracing (this commit 5247dbf16cee also use the noinline for =
tracing). This helper is not used other place in kernel.
> >>>>>>>>>>
> >>>>>>>>>> For example,
> >>>>>>>>>> sudo bpftrace -e '
> >>>>>>>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_l=
ink_stats64 *)arg1)->rx_dropped);}
> >>>>>>>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtn=
l_link_stats64 *)retval)->rx_dropped);}
> >>>>>>>>>> '
> >>>>>>>>>
> >>>>>>>>> Can't we use the global symbol dev_get_stats() instead? It shou=
ld be the same.
> >>>>>>>>
> >>>>>>>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage =
is not used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped,=
 for example, is 0.
> >>>>>>>
> >>>>>>> How about computing the delta of @storage->xxx between two consec=
utive
> >>>>>>> kretprobes hitting this function? And you can also identify the s=
ource
> >>>>>
> >>>>> two consecutive __kretprobes__=E2=80=A6
> >>>> I got it. In fact, it is not solving the problem. For example, @stor=
age->rx_dropped is increasing, but it's impossible to determine whether the=
 increase comes from core_stats.rx_dropped, from the driver=E2=80=99s rx_dr=
opped, or from both.
> >>>
> >>> To be more specific, in dev_get_stats() @storage is only one memory
> >>> area that records the information from @core_stats. So it is
> >>> @core_stats that takes effect and is widely used/scattered over the
> >>> place (please see how one example like dev_core_stats_rx_dropped_inc(=
)
> >>> gets called, it can be used by drivers like ipvlan or stack). We
> >>> cannot tell which one causes the increment by looking at @core_stats.
> >> I don=E2=80=99t take care of the virtual net device. In our production=
 environment,
> >> there are many network cards from various manufacturers (mlx, intel, b=
roadcom).
> >>
> >> By the way, can we use the driver private stats instead of the core_st=
ats counters for macvlan, ipvlan, tun, bonding, and bnxt.
> >>
> >> # git grep -rin dev_core_stats_ drivers/
> >> drivers/net/bonding/bond_main.c:5291:   dev_core_stats_tx_dropped_inc(=
bond_dev);
> >> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:    dev_core_stats=
_tx_dropped_inc(dev);
> >> drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:          dev_core_stats=
_tx_dropped_inc(dev);
> >> drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:                  dev_co=
re_stats_tx_dropped_inc(dev);
> >> drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:  dev_core_stats_tx_drop=
ped_inc(dev);
> >> drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:220:             =
  dev_core_stats_rx_nohandler_inc(skb->dev);
> >> drivers/net/ipvlan/ipvlan_core.c:598:           dev_core_stats_rx_drop=
ped_inc(skb->dev);
> >> drivers/net/macvlan.c:383:      dev_core_stats_rx_dropped_inc(skb->dev=
);
> >> drivers/net/net_failover.c:92:  dev_core_stats_tx_dropped_inc(dev);
> >> drivers/net/netkit.c:124:               dev_core_stats_tx_dropped_inc(=
dev);
> >> drivers/net/tun.c:1081: dev_core_stats_tx_dropped_inc(dev);
> >> drivers/net/tun.c:1237:                 dev_core_stats_tx_dropped_inc(=
dev);
> >> drivers/net/tun.c:1567:                 dev_core_stats_rx_dropped_inc(=
tun->dev);
> >> drivers/net/tun.c:1575:                 dev_core_stats_rx_dropped_inc(=
tun->dev);
> >> drivers/net/tun.c:1589:         dev_core_stats_rx_dropped_inc(tun->dev=
);
> >> drivers/net/tun.c:1913:                 dev_core_stats_rx_dropped_inc(=
tun->dev);
> >> drivers/net/tun.c:1970:         dev_core_stats_rx_dropped_inc(tun->dev=
);
> >>
> >>>
> >>> Besides, another trivial thing is that, even with your patch applied,
> >>> it doesn't change anything since core_stats->rx_dropped can get
> >>> increased in between kprobe and kretprobe of the new helper you added=
.
> >> The new helper only gives a proper hook point.
> >
> > The patch makes no difference. Please see below.
> >
> >>>
> >>> With that said, how can you accurately know where the increment comes
> >>> from? Is it from the stack or driver? I dunno :S
> >> If considering the virtual net device, it is not easy to know where th=
e increment comes from. It is only useful for hardware NIC.
> >
> > My whole points are 1) @storage as the first parameter of
> > dev_get_stats() doesn't mean anything because it's a temp memory area.
> > Previously you wanted to use this to know the source of counters,
> > which is apparently wrong; 2) reading @core_stats is the only way to
> No, I don=E2=80=99t use the dev_get_stats(). I introduce the new helper a=
nd use the netdev_core_stats_fetch() to get counters of drivers (especially=
, hardware NIC).
> > help us understand where the increment comes from, but it can't. This
> > member includes many different counters that can be used in either
> > stack or drivers. The usage should be general, IMHO.
> I agree that this is not general, but this helper is useful for hardware =
nic.
> >
> >
> > So again how can you be sure where the increment of one counter
> > happens? I mean how? Could you provide us more details about _how_ to
> > know where the increment comes from? IIUC, by only hooking either
> > dev_get_stats() or the new helper it doesn't work.
> For tracing **hardware NIC**, for example, ixgbe which does=E2=80=99t use=
 the core_stats
>
> struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
>                                         struct rtnl_link_stats64 *storage=
)
> {
>         const struct net_device_ops *ops =3D dev->netdev_ops;
>         ...
>         if (ops->ndo_get_stats64) {
>                 memset(storage, 0, sizeof(*storage));
>                 ops->ndo_get_stats64(dev, storage); // 1. @storage is ini=
tialized by ixgbe driver
>         } else if (ops->ndo_get_stats) {
>               ...
>         }
>
>         return netdev_core_stats_fetch(dev, storage); // 2. kprobe this f=
unction to fetch the @storage returned by ixgbe driver, counters are from d=
rivers 3. kretprobe this function to fetch the @storage which add the core_=
stats. So counters =3D=3D @storage of kretprobe - @storage of kprobes, are =
from core_stats.
> }
>
> >
> > Take a look at this counter, so many callers:
> > $ grep -nr dev_core_stats_tx_dropped_inc ./net/ drivers/net/ethernet/
> > ./net/hsr/hsr_device.c:239:             dev_core_stats_tx_dropped_inc(d=
ev);
> > ./net/core/filter.c:2292:               dev_core_stats_tx_dropped_inc(d=
ev);
> > ./net/core/filter.c:2297:       dev_core_stats_tx_dropped_inc(dev);
> > ./net/core/filter.c:2399:               dev_core_stats_tx_dropped_inc(d=
ev);
> > ./net/core/filter.c:2404:       dev_core_stats_tx_dropped_inc(dev);
> > ./net/core/dev.c:4057:  dev_core_stats_tx_dropped_inc(dev);
> > ./net/core/dev.c:4859:  dev_core_stats_tx_dropped_inc(dev);
> > ./net/core/dev.c:4899:  dev_core_stats_tx_dropped_inc(dev);
> > ./net/core/dev.c:5596:          dev_core_stats_tx_dropped_inc(dev);
> > ./net/sched/sch_generic.c:641:  dev_core_stats_tx_dropped_inc(skb->dev)=
;
> The above is the core code of the net stack.
> > ./net/xfrm/xfrm_device.c:144:           dev_core_stats_tx_dropped_inc(d=
ev);
> > ./net/xfrm/xfrm_device.c:168:
> > dev_core_stats_tx_dropped_inc(dev);
> > drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:
> > dev_core_stats_tx_dropped_inc(dev);
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:
> > dev_core_stats_tx_dropped_inc(dev);
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:
> > dev_core_stats_tx_dropped_inc(dev);
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:
> > dev_core_stats_tx_dropped_inc(dev);
>
> For macvlan, ipvlan, tun, and bonding, I think I will change them to use =
the private the stats of these drivers in v2.
>
> caf586e5f23c ("net: add a core netdev->rx_dropped counter=E2=80=9D)
> =E2=80=9C=E2=80=9D=E2=80=9D
>     net: add a core netdev->rx_dropped counter
>
>     In various situations, a device provides a packet to our stack and we
>     drop it before it enters protocol stack :
>     - softnet backlog full (accounted in /proc/net/softnet_stat)
>     - bad vlan tag (not accounted)
>     - unknown/unregistered protocol (not accounted)
>
>     We can handle a per-device counter of such dropped frames at core lev=
el,
>     and automatically adds it to the device provided stats (rx_dropped), =
so
>     that standard tools can be used (ifconfig, ip link, cat /proc/net/dev=
)
>
>     This is a generalization of commit 8990f468a (net: rx_dropped
>     accounting), thus reverting it.
> =E2=80=9C=E2=80=9D=E2=80=9C
>
> For macvlan, the commit 412ca1550cbe ("macvlan: Move broadcasts into a wo=
rk queue=E2=80=9D) added the dev->rx_dropped. The macvlan supported the  @p=
cpu_stats.
> For ipvlan, the commit  ba35f8588f47 ("ipvlan: Defer multicast / broadcas=
t processing to a work-queue=E2=80=9D) added the dev->rx_dropped. The ipvla=
n supported the  @ ipvl_pcpu_stats.
> For bonding, the commit 31aa860e0aaf ("bonding: add bond_tx_drop() helper=
=E2=80=9D) added the dev->rx_dropped.
>
> None of the patches strongly indicate that @core_stats must be used.

As to the example you just provided, since ixgbe doesn't use
@core_stats, directly hooking the original dev_get_stats() with
kretprobe achieves the same goal as you want. Why do you need to add
this patch? Besides, if you want to know more about specific drivers,
why not try/develop 'ethtool -S' instead? Honestly the example is
really not convincing...

I understand your motivation, but the description and examples you
provided are only to meet your particular requirement. A more general
plan would be more welcome!

Thanks,
Jason

