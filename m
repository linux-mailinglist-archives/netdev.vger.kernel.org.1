Return-Path: <netdev+bounces-287013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFGaLQPxAmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE551D8CD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89C33140A27
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC68397E6D;
	Tue, 12 May 2026 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0A/UsWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C539C635
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576273; cv=pass; b=dz2020chb9S4CZEK9O5vujp2pJV5Z7cIxUdlDIy1BHl1HKA05VF5pHP7Xlwm5NCsAo3ud2PA/r6Xwd+KbekbloFehYvmcZ/7+GBvomVkjiKYSoKouf4Cd/9i0sHDEnpRftTLJTS3M5Vi8cbcF0oZGYYT2UNoGCrgB3Ie4PfMvzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576273; c=relaxed/simple;
	bh=fHCwkUcAZqA/suQImg18ULhJSx0PMGzQUjdBOUI1Yfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4unXk56M88tVkYB4BbHAe+R9I8aBBcMjDSYBFI82rSqy+KNpqGdd8MmLEI+zAZlnpFDjlmvHPeZSmFP8q74hDs3A/bSfJx0l07GzSEV0SHmi/LBY3fdeoM1AYdM4imn4kEyyxUVe1pNYn+9glEDBSgxN9++PjYY+Hg3FTTPdko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0A/UsWv; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-90caad2e944so92725585a.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778576264; cv=none;
        d=google.com; s=arc-20240605;
        b=XmbYVeUMcP1sqSZrVP/0j8dOLA/cRbucAb9DZMelmMOJ1wgiv1LATKCt3d7E8lRvT3
         QAeroHIV21r0YK+Wa2w4EfVwhxfDCUesq/xhToMNEwhW55oVMz5UDjkbJzRTi8Vge8bg
         62UbhIUtzbaEkqKAGQ8JpZ7AesaXpRUkOUOOfKbNUiWKg/xPoIlSncArtWnxIOPjUZc8
         hn1ik5KURcQYLgF7RIQDqRg/hjSbDUYVH6ZV+DSRdimcGi2zjIFDFS0i/q5qHeh3cRJA
         EXMhBp7EQCfo5YuAio8sJMuWdpFY9HDuDg4yIcwd7b53QmE/zG/H/FjDg+54GNgRf/2E
         vLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=55ODQSegitzmMbbfgjBwlX6/XYm1XcpZ4+xgA+8OEP8=;
        fh=inG1DcqwCfRKEjR/o3qXFV2Y49qSlydEhCTjhUoCr24=;
        b=Is5kxeL9eN3RA8UlMIP0M4sKsa+vP3B5jNCU9dt35DSZmcqpqgtD+WiX686Yc6bA4d
         X21UHqsgFBDZ9SDE0Iq0GKRYmf7KLnONU37CvGGN2XYZz2DyOWcdManNbxY1knHvuW/y
         lfPWiSdfzJJBFVX5VhLYxUaEj1eanbQHFuknSIBWsvOs3g4ytNyvDvLmpLIV74KDMDhx
         +uv58j8Y2t0+KZ0xMyoqCi+oR859G8GgfIbUCso9KsZERzXZtvPwRwztZdEFRlJ8G40H
         bP7e1Hy/FWf1bz2Cid4nejjBwxInyCREKqoprUCmyYCTJqCpRNbUprCIATD4+NICwK0j
         RAJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778576264; x=1779181064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55ODQSegitzmMbbfgjBwlX6/XYm1XcpZ4+xgA+8OEP8=;
        b=g0A/UsWv+rRz+2n1j4fchi2hiYmyBL7kOGgPH0Xg1MPZjUerf9+Bg3ePjIh8dqiAwt
         Sgv0SODrXC9TUMbhZgCED9EVLsVFqTp0OzzRJkjvhr1z+R42UIvyhBo9bfJlZVnfr6D9
         b3PfusjdA0g1Y+OG1JjYoQnWf4zFCasd5a/MjEn80m7IfI+3chqnvCMb5qFa8N30v0+l
         GnAZFh5N2WZNIOYaD876lZfuX9XidGzXItSIUBXCoZ2xjCz5pwsAjS21V/cOh1MasfRH
         KhOTAwlLItu1DKNQGPtVK/mkFYEZCpsXLQVELHMiYiegC36DFpZl6i+YhGGX1g4P9Uen
         uzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576264; x=1779181064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55ODQSegitzmMbbfgjBwlX6/XYm1XcpZ4+xgA+8OEP8=;
        b=tPm7skI7e2TMHdzd752kDEkfYj/oB7SZezYikmx/3f48AI+DPV+nChvlq/qxjJzZkY
         z57a9rmO/n4rIrV+i8KmDLYZQekp2PwYpWkNK/JuxYJMSfAv5OtlX85+BeVI8Z/TGLMC
         4Ciw8jUHYEcxGIcgGZlBbDZxBeUOzWAjktnCOVsxY3W1Ug1QMTJ5qcwx8IhkMDGkmwWt
         sndf3AQSOHYxZ7XWrlVuioh4eZARGCV7DfovBldsXp1azMczepUk7Y0o+HU5DX7YnkzR
         mbPNXHNwKV9L9ZZKDXkMm7zdx/dl3xE92YTAiZv6m3MVa6gzxPBFUwr2KYXwXWqf+xM8
         1dtg==
X-Forwarded-Encrypted: i=1; AFNElJ+Vu35sEUBkT2wlBy6sSwvmR4PcW7gsFUhW8M6YTx9U0ITJ2e61jk7MhT2crPXR2NbPukruYrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/8hpWudrE0aThmeDlPEwypFwBGYID4bCfsSAnWUyaI9D3b5l
	fMzQtbIrvVP9V7jKi+P2B2BY/h/betZsNMjDYTo7hmvVEMJFKkBrMx+imPSjKgYgGda3g2vzdZC
	OaLvYMGkPYVcDpFihVT0w9/yBfAuZtB0=
X-Gm-Gg: Acq92OHqiRMB6Ly5pZOxXzF8E14KpZgLIqd7fKfYNjAwHDDcELHzAsxvoYNNC05D2sN
	t+qFoPcTEy1WcPHnO9DXpqqmakb1+YZHX8kexHC5cQksDKPKy0WXhQHvQamj9RI+Hx7oieuCkDi
	71Ao4hIbjmHu0n8ftvcI+zEroQJ/EyiSnb7Yzz81G1P7R4WO8sZDj/4k2aElhFfqxMwzJzovQDJ
	FoEZioBIbwFk47XvRcVhOIYMO/rlXVtTHPvfmUtCV/E+KVwq8zx11xXIOJHeHDecQUonxUq3VPi
	Phh1ELDfche//svqxQ==
X-Received: by 2002:a05:620a:4555:b0:8ea:addd:894c with SMTP id
 af79cd13be357-904d67e6875mr4166900185a.53.1778576263834; Tue, 12 May 2026
 01:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778504155.git.tonanli66@gmail.com> <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
In-Reply-To: <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Tue, 12 May 2026 01:57:32 -0700
X-Gm-Features: AVHnY4LW_n3589IrfOW3lcWYMgL_KBweVteUL_iimXamiTRstgHN-Rc9pBaQ1LA
Message-ID: <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing port
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	idosch@nvidia.com, fw@strlen.de, davem@davemloft.net, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, tonanli66@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0EDE551D8CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287013-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lzu.edu.cn,lists.linux.dev,vger.kernel.org,nvidia.com,strlen.de,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,blackwall.org:email,lzu.edu.cn:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 1:29=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 12/05/2026 07:31, Ren Wei wrote:
> > From: Nan Li <tonanli66@gmail.com>
> >
> > The bridge local receive path may be deferred by netfilter and resumed
> > later. By the time br_handle_local_finish() runs, skb->dev may still be
> > valid while its bridge port association has already been removed.
> >
> > br_handle_local_finish() unconditionally looks up the bridge port from
> > skb->dev and dereferences it for source learning. If the port is no
> > longer attached to the bridge, the lookup returns NULL and the deferred
> > local receive path can no longer rely on the port state being present.
> >
> > Skip the learning step when the bridge port lookup fails. In that case
> > there is no port state left to learn on, so returning early preserves
> > the normal behavior for existing ports while avoiding access to stale
> > state.
> >
> > Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook re=
turns QUEUE or STOLEN verdict")
>
> I don't think that is the correct commit, it seems to me this bug
> has existed for a very long time. From a quick search I think (Florian
> please correct me if I'm wrong, but I think NF_QUEUE existed back then)
> it was introduced in 2010 by:
>   f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_=
port
> pointer")


After checking the history, I believe f350a0a87374 is indeed the
commit that introduced the underlying root cause.

The 8626c56c8279 commit in the patch is the one that actually made the
bug reachable in practice. I am a bit unsure which commit should be
used in the Fixes: tag. We have run into this situation several times
already, where the commit that introduced the root cause is different
from the commit that actually made the bug triggerable/reachable.

What do you think would be best?

Also, if the Fixes: tag should be changed, would you prefer that we
resend the patch, or would you rather have the committer adjust the
Fixes: tag when applying it in order to reduce traffic on netdev?


>
> because that commit removed the same check for a NULL port.
> The patch itself is ok, it restores the check that was there before the c=
ommit
> I mentioned.
>
> > Cc: stable@kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Signed-off-by: Nan Li <tonanli66@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >   net/bridge/br_input.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index 2cbae0f9ae1f..5b0d7450de5f 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_buff=
 *skb)
> >       struct net_bridge_port *p =3D br_port_get_rcu(skb->dev);
> >       u16 vid =3D 0;
> >
> > +     if (unlikely(!p))
> > +             return;
> > +
> >       /* check if vlan is allowed, to avoid spoofing */
> >       if ((p->flags & BR_LEARNING) &&
> >           nbp_state_should_learn(p) &&
>
>

