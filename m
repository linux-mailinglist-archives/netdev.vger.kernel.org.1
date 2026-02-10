Return-Path: <netdev+bounces-258082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN+zJAAri2kvQgAAu9opvQ
	(envelope-from <netdev+bounces-258082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:56:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D348411B0E2
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C580630088B1
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC630F531;
	Tue, 10 Feb 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI1Lf+aH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772B1DC198
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728188; cv=pass; b=mnXBoYBIV4Ke+slbByEp4x7J9rXLwtkgZttDoHqgp8LChyZ2dZstgDV2rRBmYWrz3787Brsi+tArTDIrOTNJf3Y9pmSdXcK0KTKyLd3r5EEgeyl6LDSQHTe87eAxenynDwnst45XNonYZGHBCtr8EaBPXz2ibNDw7kIuhz6Zb/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728188; c=relaxed/simple;
	bh=hh5xVkGydwstmC1veO31AyEY6Mi6Tw7Xzn1joLiuffI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6D0+fNAPeyid/QaUfimPjfL4eiH9jJ0F5NJmnCi6d+wuclNeitcGF1z7GwPCkYF7lbsagVCJrmxza9GTjSd5DPCbqrJztno9A3HjATc2Nk9+pLqA5bz6wwLc4259IAM8hKMPAqvJQ96QaAkCdodgifu4YVM/E91ajwozoJKS0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI1Lf+aH; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-502a4e3e611so51451391cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770728186; cv=none;
        d=google.com; s=arc-20240605;
        b=N1TwYPtg9ZvxQl+krAuw5jlgzU9ordGBbixHhfl2ZvOlBiamffhJGdH+w7JVwZg5w6
         eB3LXR6rjMdNfx5cEZapZcyE/g7Xc9o7nDPLp8D0dBNoI0VsL+iukQFsM2G6ePdpdME1
         t5JJptafT88PGUOMb9ljvDy+iLO4AU1PvfLKPPZ9Rzfo1ntJNg5np06rhnoKsV3Aw8xo
         seODSTpbjAPUc5NxCz3TR0VoifMBC1vWccelY23QifVODIS0bxg/KgFTvNTp0yfourGQ
         TCklfEK9QrFld5FfLrc9HXn1b/lcAnU7l9PEY3V7SKNI2643EcEm9Fw2TMyhMMlezdkU
         RTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLIgydjr2XFvH1ZygulOY9irj+U+FlL+aofI8jLNAuQ=;
        fh=PYKJ7mSLcUvjgbLk0qKuG7FLxjamAhOtCf4NcFIbC4o=;
        b=BW5XMxXBq1y1Pf/Ulb0iq9R+rs3LnI40rrptBnmbWrxfvuqF/VzPu9IrUcCnp1dVkf
         AQIEsDxb+2IHlW3NULei64KBPOSumJrV5Ohycy8O5LAD/OoM+vU/sZl2onJCnNU8YKz0
         FlYt5BsFivPdgn0UdagF3t7Xb5uB6O+uuZgvD6nwO69zXCMKLXu0zCFYHvQ3OlCqe74b
         j2fmHi8z39sYUzG6H9D1e53ve9N7x13E3cnK4M2t8CxlQ6uT1tF61Iexfi/+3lfyTpIS
         I4B0ohYghJEi4zJ4gjbafdeufec4fuLumL6EOw7maTVmiPwv9MPXemZT/X7XKrXmkjYj
         bg8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770728186; x=1771332986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLIgydjr2XFvH1ZygulOY9irj+U+FlL+aofI8jLNAuQ=;
        b=XI1Lf+aHYu4GI0AUej20OaZDDnnWGRF/5Pe0PfU0/i4p16iOV3YjUyajKO8sKqhvw5
         RxYx/Yv0ihR6qRJpv+uFbFVf9oJ9OAbRgbZCAccUH3DHOKlTpr3VpAzicX+FdUNTq+wg
         gkinK1g7zgJHY54HZAtwAEJqqo2SKJl3fHvYYm4t64z28TCoOCHGCApwrMUQ6dduCJou
         ItIwh+nwxTerPtaA5q+KTmx06tCz8W1L5NygdbZ4m5s7q0WCHmXfDHviB37JMcjtowxw
         uzZvr6NEbgNf98WLahfSm06JHp084xvmfRYmZlD973kqB8GbJlQtcLogerBgVvx/hpRB
         AjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728186; x=1771332986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLIgydjr2XFvH1ZygulOY9irj+U+FlL+aofI8jLNAuQ=;
        b=p+Qq05jcefHiHg39R827BQhE/u84E1Nc92I+FAguTNtDRHg1b8xCnhKI+dOjJDwJnF
         MqqIoWBOSDfkqDON9B4F8L9Tp2fdsnQ61ThRPR9mz5QyLpzz+W8U4bQbJiwOeF5u67ei
         d0/nqsRi7FJQDekCGWm3lV7cy2RA9d/6YqZ8rr0a9xSNI1ZZGfA1EFSrerQs/Z+hLHHJ
         8Ogu/Xsy57ohcKnRc0kehxmp5v70aN/KGjKZ9WJopvpGhOtihpvZEDeRDKsZgzstHwus
         bRZhsJ9S/n7SAlUChJVi0MRVqP4EG2jD3Tt+Mj+Mq07P9ZCUWvoObEmDtG7Pd8/lxjIQ
         VQqw==
X-Forwarded-Encrypted: i=1; AJvYcCU0SSqkB4gwfls5KJGclEaCUJFF7eRd4lLurE8cSrAnnI2/qZKYnryLwPbuFCxsPTzaJQ3o3ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiL/W/FyAKS7cxupbHxXxUjRw7H6c6hPdr9zHkHmAajQ+AV0ET
	VOhRpsMVXkpJUtoEURuqOdcUr6uTF4sPH5kpJq2JDdYIoz1yyrR3lVSw880nzesUbLgjM81DZdG
	9i2zYpGI84yU+xbQqxLkeDfv9/ifFDag12sZwxE9X
X-Gm-Gg: AZuq6aKcxnTZghDIReOgeVkqhczbVbAhpx9fO33ASL6w7GqqoASN7E/VhihuSRe3YnH
	D4q+bvFhfKrWZCa4J2LAd5uB97y+ubYU1sTK2VaTMnBIfWbHj9alvSb9gF2dDhxzRIVPQRbGhwj
	3QnOK0Q/44wieRZkvAL/bkuc0ez24WbLlJ48Sj01NU25AEa2rg0ozLXmMGJ0+gBMylhTePVLuGa
	/k45WwJBXYRePLN+N/CO1ZtgAxCWjdGcLYywI0dYdoB4DsqpNkDHe9t/6IgsApogJ8Ydew+LTtk
	YTlCxQ==
X-Received: by 2002:a05:622a:150:b0:4ff:52fe:be3f with SMTP id
 d75a77b69052e-50672e3a65amr24880541cf.29.1770728185542; Tue, 10 Feb 2026
 04:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com>
 <CANn89iJxmiqryxLAXiV9z4uTaCzR7XZns32MGSLOykC2zocW_Q@mail.gmail.com> <DGBAG46Q9YLJ.PX4A4EM1U4DF@suse.com>
In-Reply-To: <DGBAG46Q9YLJ.PX4A4EM1U4DF@suse.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Feb 2026 13:56:14 +0100
X-Gm-Features: AZwV_Qh6-wsipdnOMHVyNRUtU-lVx-ePgKR7HVXuJhyHIz_h9y48UJQDXDdDhQQ
Message-ID: <CANn89iL5ksZZCJr7SK9=4Sw6EejdOzr5_m6pBMM8RVtbLy_ACA@mail.gmail.com>
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hirokazu MORIKAWA <morikw2@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>, davem@davemloft.net, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258082-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,davemloft.net,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,l2_tos_ttl_inherit.sh:url,chinatelecom.cn:email]
X-Rspamd-Queue-Id: D348411B0E2
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 1:42=E2=80=AFPM Ricardo B. Marli=C3=A8re <rbm@suse.=
com> wrote:
>
> On Fri Jan 30, 2026 at 9:00 AM -03, Eric Dumazet wrote:
> > On Fri, Jan 30, 2026 at 5:15=E2=80=AFAM Hirokazu MORIKAWA <morikw2@gmai=
l.com> wrote:
> >>
> >> [REGRESSION] ip6_tunnel: IPv4 traffic broken in MAP-E/DS-Lite since
> >> commit df5ffde96693
> >>
> >> Hi,
> >> I am reporting a regression in the IPv6 tunneling stack (MAP-E and
> >> DS-Lite) introduced in kernel 6.12.67.
> >>
> >> [Description] After upgrading the kernel from 6.12.66 to 6.12.67 in
> >> the OpenWrt snapshot, IPv4 packets can no longer be sent to the
> >> external network via MAP-E or DS-Lite interfaces.
> >> [Environment]
> >> * Hardware: FriendlyElec NanoPi R6C
> >> * OS: OpenWrt snapshot
> >> * Kernel version: 6.12.67 (Broken), 6.12.66 (Working)
> >> * Protocol: MAP-E and DS-Lite
> >> [Culprit] By bisecting/reverting individual commits, I have identified
> >> that the following commit is responsible for this issue:
> >> "ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()" (Link to
> >> the patch: https://lore.kernel.org/netdev/20260107163109.4188620-1-edu=
mazet@google.com/)
> >> Reverting this specific commit on top of kernel 6.12.67 restores
> >> normal connectivity for both MAP-E and DS-Lite.
> >> [Steps to reproduce]
> >> 1. Set up a MAP-E or DS-Lite connection on kernel 6.12.67.
> >> 2. Attempt to send IPv4 traffic (e.g., ping 8.8.8.8).
> >> 3. The packets fail to reach the destination.
> >
> > Thanks for the report.
> >
> > Can you provide detailed instructions ?
> >
> > Apparently none of our selftests caught the issue, it would be great to=
 add one.
>
> Perhaps l2_tos_ttl_inherit.sh [1]? I've seen a timeout in this test that
> went away after testing commit 9990ddf47d41 ("net: tunnel: make
> skb_vlan_inet_prepare() return drop reasons") like mentioned here:
>
> https://lore.kernel.org/netdev/DGAR3PO1D33S.1TI7W7U4SPTOG@suse.com/
>
> It seems that that commit 81c734dae203 ("ip6_tunnel: use
> skb_vlan_inet_prepare() in __ip6_tnl_rcv()") uses the new
> skb_vlan_inet_prepare added in v6.13, which broke 6.12.

Greg Kroah-Hartman backported my patch to 6.12 LTS, but forgot that a
prior patch
from Menglong Dong inverted the skb_vlan_inet_prepare() return code.

Greg, can you backport the following to 6.12 LTS ?

Thanks.

commit 9990ddf47d4168088e2246c3d418bf526e40830d
Author: Menglong Dong <menglong8.dong@gmail.com>
Date:   Wed Oct 9 10:28:21 2024 +0800

    net: tunnel: make skb_vlan_inet_prepare() return drop reasons

    Make skb_vlan_inet_prepare return the skb drop reasons, which is just
    what pskb_may_pull_reason() returns. Meanwhile, adjust all the call of
    it.

    Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
    Reviewed-by: Simon Horman <horms@kernel.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

