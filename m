Return-Path: <netdev+bounces-300937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Gv7KrqPOGr8dgcAu9opvQ
	(envelope-from <netdev+bounces-300937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:28:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B48046ABF0D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:28:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=W7KCNSx6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300937-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300937-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0569C300B45F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9C24677B;
	Mon, 22 Jun 2026 01:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AD2441A6
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 01:28:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091703; cv=pass; b=HtysjPLxwDCck2XUTuVE75HnPPqtNLfvjFp+qi2iaSufw91+7/dFPVPbRzSvhJct/8m0Gq39QTsPCRh+sOB5nDTzsI8qKWEYyM8DvGGJNr6dxdKA07+B1+CVRkuAtnN3UNankh6twhhhf6vikiklThXJmTOOjfcnKjrwb45jOzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091703; c=relaxed/simple;
	bh=tgh+VzXXlhm0LYKlwIeBR1BDOYHFLT8CHRa+H/14YHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fah8ANNxe825OACvTOV9t3/g4nXOULqYYJ1eH2MKalrkA/E1Zd1dlnNY4RqTzlRu7ucSWkMZ5ZzkM2YO3oS9OojrH/a7YNuN211W1JKvOQnjHtlL7fp1KXnLnUTylH+ZUqinEivNk5iroGJRh69dVTuUfS+sp5a+JzezpqM4/Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W7KCNSx6; arc=pass smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso1406300a12.0
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 18:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782091701; cv=none;
        d=google.com; s=arc-20240605;
        b=CW4gvPhJEmnbi4BSjSMv9NrPXBVi+/ytNJgPx8hfLrF8CWAQMTssWjH8W/YUM8Bx7A
         Wj/erzm0bEddUGrZeKnOZ/Yc+Mq2LfNPJTaxGXTWCR3GqyhmkC/Kd+6FurKhtCAjI12w
         5vp3Pz6Qs6q0SUWg8PZKD0frVdHrPZL+CHFD7swIRw5wopTwMyZtyyPrtgm6dK8qNOd8
         rfG1k+b9iy+CATtDIlcLKE/Emoe2/9BW7vQh+d8Ncm4zS1QFZ5E34AiU1ZvZZrKRKlQp
         0s4WKQahc91ViCCzgnnIPaKdmHF/DSpJooahdsEVH8KgKfteQFh4BBXULj9Nk4o67e2a
         El2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=beBTWQSBCFVdWZZAOBgHCAquwbN4DDYp/feIkLNumIo=;
        fh=5NNnjsAJJoTHflGo8o7SVCFk/PWXKC/hvqgAaiuqJn0=;
        b=I+AuhExj2i3tZZeQ8t7ryhwyxpxDfJwg+fQUffwAcR7qM0qb52s7J7jn1Uugi8SSNg
         qM5CKnnSQCXLFcNvvyrpeXsHTPtBTn4wxV0YqNg1NnihSmeGGqJ2TDluB603Jt1izqWv
         92Z/Ii91d9cxyjiYBMg4EvU4nune6Ua7WMaJgPZwEnUtVf6wlIwgdwdUPPQ5l3+tKYhR
         kLL/xxuXm/d3IiLDh2DatybgMAkUQ+OezNSUaEoHSOe92yWmwUbNdn4dvcUf9OQ26SH6
         O/X5Pp/ohvFFt2W7cV8jyL0XpQ9WLcm3sIVfFlj3cG/GQaaKdSQ663P6p8HYgV07fw/6
         gLtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782091701; x=1782696501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beBTWQSBCFVdWZZAOBgHCAquwbN4DDYp/feIkLNumIo=;
        b=W7KCNSx6kgrPOHUEJjHc8N8Uf26ixl0I55qMY+1NBbtmy1w6oKsaeCy3bnawKTDTHl
         GsRsLZW1sqwF9e9dbo/oNLM8m9FY7cm5+4OldVdBSPOHcBsWl/BSmtfApvKRrLfULvRZ
         f6ptXltI3OkvwA1VRs408NykxaK6yTHxqVp6S8ztGwv/J00H/0lL2tBglDwiostVv1ca
         LXLjvoGYv7G9NiXRySdA7tlCZOys03Gr3Tnpn8H4Fs1XLENFoQLkVP4WDnqSacRg1rsZ
         1vvBguwIkcEqjLFw/pnpiNw0/mIJXnQx3V8zIebZqywK7QOoI+qnHNjVBVuXBNeFgOaK
         tzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782091701; x=1782696501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beBTWQSBCFVdWZZAOBgHCAquwbN4DDYp/feIkLNumIo=;
        b=APlf+rH+3lnl3Xs0uzjPA+2bRIq4Eg1F+1F3PLJR20F3+owu11tN0G1eTbiVWz/m2h
         +FIROvHNOnQNqWnSB1eUTCaF0Reo+rmvlou+pU7GQQpikhXxkpqOybc1l51stOOuKCwN
         WRUw1OkriHpb2pjEvta5klPLg74GDkOBy1uYviJTOCWVgHc/lsQ5JBruPGNRhkfVh3np
         QatOYqJIQR17mIJI0StkGGYmkXXzRIYL0Gj2dfZ1ASruqRtZJqkpzpe18aJLbUd9lfVe
         3mj46GZwMWaOqNBqQwnrOVVsU/NGj2XfXD+esYWIJDCb48SGhSDAlWvsz0NhTemgHz41
         gANA==
X-Forwarded-Encrypted: i=1; AFNElJ8ILgN5+h+CuHk3QwiiRRYaneOqkYnZ3VipO8sU96AliUvz6grhvKfAatwUF4nfM2olVBlE8f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXaRor6AMX/XM/6GknzTmDyDfCL3U2LmwHBzdZCnncjs5VGFxl
	R4QvvDhYFqNCpDtJ8nTz77OMrLVN+rsB1jhvJeKDQhVrT4nMf94fVccHK4zxWzzzyO4JypBcw06
	DHaeWUAjgS22g4ftw3LtlqowD8ov49rMcduokcI4D
X-Gm-Gg: AfdE7ck8pA0AvDqQNSSCysSkwA9bdoNJTnxqLPuek6UwaS1b1FDPgFmY1ktVCm+VijX
	byHzMKaBlBI8UjXP/XofudJVbLxy004nh0ufM4fiAppqZTf/9YdHWqqYF1TCswyIH6jPP2+L9YN
	kDIfYoAZfoF13FOy29nU9X/ILg2aoIevVBxIw34smhXLy+FAuQGDKX/GFGzc7lZ5WE/EJfunp/2
	2ULMvX1CDicjBaDyLCH1sLF9ddjOt71QwmxdnsWk+MBFxXTQLmcmwxpiSbUnfVmugCoX7uGQ1cw
	5AzJU3Da3il8FVW/hU6qkDEMcGU=
X-Received: by 2002:a05:6a20:3d22:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3bc5420cd6bmr8405125637.46.1782091701250; Sun, 21 Jun 2026
 18:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620201531.180123-1-xmei5@asu.edu> <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
In-Reply-To: <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 21 Jun 2026 18:28:09 -0700
X-Gm-Features: AVVi8CdHEGHw1ieyaPQJyikAla7flQIZKU8leUwwTjiuGepgTdWlPi30tiNX8kY
Message-ID: <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in xdp_master_redirect()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Jussi Maki <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-300937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,kernel.org,vger.kernel.org,gmail.com,fomichev.me,redhat.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,asu.edu:from_mime,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,usenix.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B48046ABF0D

On Sun, Jun 21, 2026 at 6:21=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 6/21/26 4:15 AM, Xiang Mei wrote:
> > xdp_master_redirect() dereferences the result of
> > netdev_master_upper_dev_get_rcu() without a NULL check, but that helper
> > returns NULL when the receiving device has no upper-master adjacency.
> >
> > The reach guard only checks netif_is_bond_slave(). On bond slave releas=
e
> > bond_upper_dev_unlink() drops the upper-master adjacency before clearin=
g
> > IFF_SLAVE, so an XDP_TX reaching xdp_master_redirect() in that window
> > still passes netif_is_bond_slave() while master is already NULL, and
> > faults on master->flags at offset 0xb0:
> >
> >    BUG: kernel NULL pointer dereference, address: 00000000000000b0
> >    RIP: 0010:xdp_master_redirect (net/core/filter.c:4432)
> >    Call Trace:
> >     xdp_master_redirect (net/core/filter.c:4432)
> >     bpf_prog_run_generic_xdp (include/net/xdp.h:700)
> >     do_xdp_generic (net/core/dev.c:5608)
> >     __netif_receive_skb_one_core (net/core/dev.c:6204)
> >     process_backlog (net/core/dev.c:6319)
> >     __napi_poll (net/core/dev.c:7729)
> >     net_rx_action (net/core/dev.c:7792)
> >     handle_softirqs (kernel/softirq.c:622)
> >     __dev_queue_xmit (include/linux/bottom_half.h:33)
> >     packet_sendmsg (net/packet/af_packet.c:3082)
> >     __sys_sendto (net/socket.c:2252)
> >    Kernel panic - not syncing: Fatal exception in interrupt
> >
> > The missing check dates back to the original code; commit 1921f91298d1
> > ("net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master=
")
> > later added the master->flags read where the fault now lands but kept t=
he
> > unconditional deref. Check master for NULL before use; a NULL master is
> > treated the same as one that is not up.
> >
> > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to sla=
ve device")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >   net/core/filter.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 40037413dd4e..6037860d5283 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> >       struct net_device *master, *slave;
> >
> >       master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> > -     if (unlikely(!(master->flags & IFF_UP)))
> > +     if (unlikely(!master || !(master->flags & IFF_UP)))
> >               return XDP_ABORTED;
>
>
> I recall that when I previously modified this code, I removed the
> !master check
>
> because this is on the fastpath. However, since this is a triggerable bug=
,
> I think adding it here is fine.
>
Thanks for the review. It's difficult to hit under normal statue, but
the bug is real.
We have triggered this bug with a PoC plus GDB to pause one thread (no
other `cheating').

(Theoretically) Race condition exploitation techniques such as expRace
[1] or CardShark [2] may help trigger it.

Xiang

[1]: https://www.usenix.org/conference/usenixsecurity21/presentation/lee-yo=
ochan
[2]: https://www.usenix.org/conference/usenixsecurity24/presentation/han-ti=
anshuo

> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>

