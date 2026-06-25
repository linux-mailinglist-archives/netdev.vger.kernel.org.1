Return-Path: <netdev+bounces-301870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u6hkGjHKPGqhsAgAu9opvQ
	(envelope-from <netdev+bounces-301870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:26:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D77586C3052
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:26:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wg+qyOGo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301870-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301870-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8D56302ACCC
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA123BE147;
	Thu, 25 Jun 2026 06:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAC6BB5B
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:26:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368813; cv=pass; b=dnEhtrmZPGspIXF1XbUIPSFlPLoMagdIWMJSa+0SjXXB26Stjr8W55oX7mkVzstu3PH+5VeXD94qNXkSI5os+OOTUDcELmy5J8+poefMJbtD2AjwMVYfri3f0cjg75qqwzws747C0YonTCappZmBEebhsTI17Q9hwEgUiFaNlWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368813; c=relaxed/simple;
	bh=4NVkWBUYlhNsfPOQpTcToy49QEVxH8RgprpZ/ztRv6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJEcLe+wTQ+DRw12HAqqbX7wMGa+dw70xxHVMtmJYe0551HCaAeX1ESQJNRboYAUN0UP+pRy7JGSQFg1rPIpv09kqckwxPfOoe1W1bCQiba81BZLEt6NpE21gXCWbXi3QCSeKOtNUXykbzA7AMS3Q13esXkva3dN4ZsRWZPcU7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wg+qyOGo; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-519e7faecf1so22153261cf.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 23:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782368811; cv=none;
        d=google.com; s=arc-20260327;
        b=KPWouUwMIxFEwtxAXwYZ1pQMPfC/iHxyQKuv5iT9dOvy2Csv1FOHqWUHIEYHPdIyZ1
         5+LgLjWNC4VuQdX+tXnNpR/WQ17KYsNNQSQDOlON80iYjQPRlr3NJhCXCFcZHuHqNV2w
         OsDjtY9/A7hFX2IdAhnALS0iCBIOXcbu93EJUIwiu9AFiZjc/AwM/GUe7Q2zluENtUWf
         SkXrEpI6m5gWz+Q79lO+1vWLnh6T5zU0FBIX3RZmkJSaVcGy8Ojmxz/o8VVyljQOvpAw
         IhUa1JYzSCFGMpJ6srqIn0DDrhiYBDlAv7NbACRZo69Esebc79m1ApRgLTwF2vsI0OZu
         Z5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GbYxvfOT8XBJThfC7sQQtWK6/QNhGfY5zbYS7EcsU6c=;
        fh=T36oebHQKIGiSniszO/oCJTrG9hECuGaH0MCiPkDnHU=;
        b=V7ct3nRyT91aJlC0rB7AKxKmX59oPFXq9cgXzb3N53fG3m7BCjuXlmNRIYew9LbMTF
         Jk/39HUIYCcSenMSgnHkwysq8+jJXe3OGNYmuiG/49aeKCZwPRXfBwT/jXEWp7Qm0pH5
         Lq7ly5j5JT4+viyQOWdVTWN5ophvZTYLzFSVX8rAl08iLoq2s0Rb3FsVT58veFYBYfbu
         hqY4eGQSgSlce0ovXbwHNFzQY7eYaPCAExGxTCBx1oJ9hwEJq+OezGJ8YXx4UU1v/h3D
         Ij9MgQOsHc2bVvktohLZSdjUcEOZGhH/9C+CYDJukQqycSYxYSgaHCw6UNK0/oC8wfgb
         DzGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782368811; x=1782973611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbYxvfOT8XBJThfC7sQQtWK6/QNhGfY5zbYS7EcsU6c=;
        b=wg+qyOGouqauP8p0H+6E5TGiMbhG939oXY4QPJnMs4jdUu3t45eQBl2rI/1BIwwIwz
         ry+PJvzylbOSJ1RQyGUQ6Skdvq29buP3QLIF/ba3Vz+hwnv39XDtRaASz7RqOzSLsHEk
         qtdmMO3Gf8MWdob+47y7RLU4I7Dlqz+HL+TrUrcmQCTRXSDccgEK+hAAx+w4BEqEkz4I
         WoMpgru0kg5NMo3agDu9shgq5PZI0X+tmubSP9ki+jDuVDlYQ5H8elfjxQordvFDu9uL
         oJKg4Bs9PPA/afSt3OjgDxq3nlfgZ7+WFnmLLA+IXLMNsFoP6kIoVKTWpLI92YsHAN7T
         3/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782368811; x=1782973611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GbYxvfOT8XBJThfC7sQQtWK6/QNhGfY5zbYS7EcsU6c=;
        b=KXmutmgG54slk8LIxQ5mIsRblcsrOL3QH4W5VmvMOQEG48bhnR0e0TdfX4Ld8gVW7I
         ks94b1su/tpYdqB8vfismenW9cEhNrYPKxkDR8odvKrjjcphUFRL1bKMVWBgOBJrCH9n
         aFtticyp9JfULNsPaZ306i/JKInamOjUx4AAQm7U7zHskgjle+4FMVBKiD47p4T+3RNd
         JvOQlZs/7XlWfFnUxZJFA3VxYwx7z4VVKoeLKY9/D+6DwJG8cNe7JiZHZ2Aoip6SAxXy
         r3LV5A+O3V/Ur7W/PZ+QeWwBOD/IEthweTM2r6+nvM865wG5V3WLBLCafg/ouPzXIqRq
         1LOg==
X-Forwarded-Encrypted: i=1; AFNElJ/5eZXAuY/6SA8PmHwpMkPmZitK7EYWSYB6Of1OnADqDnl4bt/T9zLpTsAs7muBs+uJdjdWMbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsEiOoE0R2rStvIRVpMHyNCqyM5fv9JAEt/0egFFK1xoFtKBl
	wyzaVVyqXzRyFVDKmqZVi+haiLeRV4Lq4UyoBJMEXplQiq7A2OsjXmXRdRlRLVkdoCOozdCu+3s
	+S84HFVOAcIkPbhvipxe1yiKaujpUqJwyN21tKt0d
X-Gm-Gg: AfdE7ckOB8hWjs6NUSydGW+wQIyrjawr9Zg6EF4x9DY9JPbmUZ2bvEPPbJJbUzaNzBM
	qMa9igCkbjTxKZT5wv4d6JVfeC1KGvhM16RYrNnn7FofA0tm1PRiPdoNF6tGFpNSl0i4rHKBpJ/
	FpTtkiILcDJ+3z5A0GQDkGwutxo9QTtHP83AtIoxUe8r5izHIjpIOj+GZPnVvpQTS7xJ8g3l/Vs
	kJGvcErQmKypXuJ14WRafXKNvqHr45EkYdWP4zPu1xHOKAorKwxI7/gM1SbU0lj19hw5MZ7LJg6
	u/LE5v2PVT98BWVKWl9QKKICmqdethQVz3DAdPOXl3aRN6HKPrr69ggIwSVY4rnVAUQLEuTQxJQ
	csst/XA==
X-Received: by 2002:a05:622a:1c0f:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-51a726ffb5dmr14550661cf.19.1782368810622; Wed, 24 Jun 2026
 23:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624171034.4117423-1-edumazet@google.com> <20260624145722.083632b6@kernel.org>
 <04d09dea-baa2-4c43-ada1-cd71579aad53@linux.dev> <20260624195521.5972a5a8@kernel.org>
In-Reply-To: <20260624195521.5972a5a8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 23:26:38 -0700
X-Gm-Features: AVVi8CflKmO8audpPAgnTXEN2Gh0lXsgq8GaE8hHSZhIy7A9c2SJ6u1ZYHxTKNE
Message-ID: <CANn89iL7sNdc300WQniGuqDQLYCb1r48MgddLk-v7mF2pep7Lw@mail.gmail.com>
Subject: Re: [PATCH net] net: udp_tunnel: fix use-after-free by refcounting udp_tunnel_nic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Yue Sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301870-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,redhat.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:samsun1006219@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D77586C3052

On Wed, Jun 24, 2026 at 7:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Jun 2026 10:47:09 +0800 Jiayuan Chen wrote:
> > On 6/25/26 5:57 AM, Jakub Kicinski wrote:
> > > On Wed, 24 Jun 2026 17:10:34 +0000 Eric Dumazet wrote:
> > >> Yue Sun reported a use-after-free and debugobjects warning in
> > >> udp_tunnel_nic_device_sync_work() during concurrent device operation=
s.
> > >>
> > >> The state flags of struct udp_tunnel_nic were originally bitfields
> > >> sharing a byte, modified concurrently without locking (RCU vs worker=
).
> > > Can you clarify the path where the bits are modified without locks??
> > > My mental model is that this is basically all under rtnl_lock, and
> > > Stan added _another_ lock so that drivers can call "sync" / reply
> > > without needing rtnl lock, but any changes are still under rtnl_lock.
> > >
> > > The gap seems to be that we don't check pending under Stan's new lock=
,
> > > since commit 1ead7501094c6 ("udp_tunnel: remove rtnl_lock dependency"=
)
> > > did:
> >
> >
> > I think the real problem is that a single work_pending flag can't track
> > the work being queued twice:
> >
> > 1. Thread A calls queue_work() -> work_pending =3D 1.
> > 2. The worker gets picked up; workqueue clears the PENDING(internal wor=
k
> > queue flag) bit before running the work function.
> >     The worker then blocks on rtnl/utn->lock.
> > 3. Thread B calls queue_work() again. Since PENDING was already cleared=
,
> > it enqueues a second
> >     instance and sets work_pending =3D 1.
> > 4. A's worker finally gets the lock and does work_pending =3D 0, runs,
> > returns.
> > 5. Now work_pending =3D=3D 0 but B's instance is still queued. unregist=
er
> > sees 0, frees utn.
>
> Ah, thanks, now I get it. Claude told me the same thing but in 10,000
> words and I lost the thread before reading 'til the end...
>
> In that case:
>
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 9944ed923ddf..3b32a0afa979 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -301,7 +301,7 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, =
struct udp_tunnel_nic *utn)
>  static void
>  udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic=
 *utn)
>  {
> -       if (!utn->need_sync)
> +       if (!utn->need_sync || utn->work_pending)
>                 return;
>
>         queue_work(udp_tunnel_nic_workqueue, &utn->work);

Yep, this should do it. I will send a V2 with your suggestion.

I will also send a separate patch for the ->missed part, since the bug
came after  Stan commit.

