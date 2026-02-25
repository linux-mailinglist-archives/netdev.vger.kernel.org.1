Return-Path: <netdev+bounces-261038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMnhCYYzn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:38:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46319BA85
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 343F93013482
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F83ECBD5;
	Wed, 25 Feb 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YYrIfhQh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C593E8C40
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041090; cv=pass; b=i91lU6lYueyLRQb1z1DwlWYTC6E4UphcK4oTlsr6KsW/ysnl5OkgaZ1cxw6HNd+e+ghucm0Qa37To6qXFos/0TXuEgjr/L8B/v/n/XDh1TXj0QoDdoEZW0cLl4AVNO8CNAcRlERPlxPrz+9HWKfpEiVux7NBUKhYFvXF84eIXSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041090; c=relaxed/simple;
	bh=yuOaUuTSzZFOjUBqFQdY1QHGRhizyHL5QbDLFKXfq+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMGMToWM6xWvauXUiASecwv+tJ7c/xhC0pyuAQb+Muxjum2YfXLD4DCHYGTSp9l5Y24Rd7VMOJElasYDCFYFrPckr/6WHYfTBRV1y5IBo7zdAz6f8Vvq+fSsmwvyoVugSEADxB4BURHFTjUwrzoePKNH7gtTy0Fg55Vg3X73G+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YYrIfhQh; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab077e3f32so27903565ad.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:38:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772041088; cv=none;
        d=google.com; s=arc-20240605;
        b=RwtirJeIfOwoczubbXqdJ2J43ltO93hCVizTvR0lUM4v+Fnwi2ZJn8e8PUR+7dAQyp
         RvyT6OtAjJmqlK2vJKFIDN8YMJEIgRdRxwOpC7RkLy2MMwiNkWJQowC2DREg1ikQrvNZ
         V6ry2iobhYjot87olNdSO8WYrC9SMyeJkBEKnCqSr+rVAp6bNgSYee6PIglzZ7N7QQP3
         zUoSRwFZ1+FS/NmepgA3BlwqrwpMwJobiWBHQ4MDUkHAU7UslnmjsnjqcpeXs9muPpa7
         On7ZEZneY7Skc67DF2Egaqv7xOq0KE583lfCOhZAyaDhkiwb42tTEAjNs6lXrafrmW1L
         bw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1CwVaDdHCwfU0y09jyt6yHXT8oefNJ0gVIZzDvYt7U=;
        fh=RM6gGUIy+ZZn83+CxxDPUZsKyqjbPKsEXgOTVfvDzZk=;
        b=ltlxXno1drCrkvmMUwTYr1nZQIo3Nb8YEFFWsx02dS38WEioZOPRvZur/Fx27JtSiX
         axhnisrA++b0yf2fZN05wZbsx9VLJvidX06LOeik04O/skn268UlHujKutQ8kIqxACXh
         mQlddF2cJitVBXVo0Y2Ddud4WmZYLyuxKQVmTm1pfuS89l8F9mLgzweYWwkVeleOvYNq
         Of0HxNj6FgYqEviY4LMZIL9LR0B6YmnCSBwce7l5pY15aGb6sID2EvC1L+yyB4tPtiSn
         SfjaTiL2Xp9RQVxuKfhA7dEOLZ06O7La+PELAYiT9UfWSf1uANnm2AQ8NrUKt0h2Z1oc
         No8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772041088; x=1772645888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1CwVaDdHCwfU0y09jyt6yHXT8oefNJ0gVIZzDvYt7U=;
        b=YYrIfhQhaJfXY28EWlfHc6KgysRZ0VjRIoHuu6wPu9XYoaGrOoA1UxTW1AuKWpclQQ
         mzQiLaVFD85nx4JZVVBZLd7PmRUzEli7RQ3tgTaNbYMnQjJO6QMJZ4nEncj4k5P7WKDQ
         f6L2F0HZR//srQNlPxCPR7aWRZ+md5812PD7uq0FZ6corVwA+ORfIMvCcrFGATo1u/p0
         hZY/Xkm9TrCBPHWk3BfHOp+qbDzdF2WwDxjGGCJzgLZ7KhfnbUDWXB2oLbU2Jw7cNg/f
         wru9XfCO36Ew1Gru3EsCclygwjg8tbsaR0L7qPySsDmowxlHQyIlWZV5BS4s5iJCjN5P
         w40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772041088; x=1772645888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1CwVaDdHCwfU0y09jyt6yHXT8oefNJ0gVIZzDvYt7U=;
        b=lLQuLmNt8Wp4veERp+h3Tzxytwy1aP3ECJNlTL6LuM/b5faAxKKaGnPa0/hg4TUuuv
         gah4NPgaCqoyDe8V74CjCGv2jlOax5rS2XMEFWSOBQj4SgHEzwhU6kzifWlQPXUgPULT
         mg/NwLP22hOL5fB18BOlhSTF0W/7Sq9I+I1zXbavPgT76Lmu/Ftdsi2gXgvZBQXHAKQV
         WBSIR2MZUZ/mEpmCXCnosS7Nvl4cEMr9CfmtVCPuh/1fFqTFA56Tl5A8dKBwdA81GCCS
         ObNzbL+eEGRUX7aYEXEWNk7SwhZWVnlsjBp5u7aTWN4711qSN267UmvYaQhyph0+zkzV
         ptBg==
X-Forwarded-Encrypted: i=1; AJvYcCVXsePQbRJ/ExyVGWlRy8hM9n8UijW8SM77/UqqavheUCfgVWRL6wg9EDIztAdZ2HYhDii8aAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbiVdxxasfZ+oO+PlMDbWn5Ah1qSvZJTF5/m1RulOPaDMg5YF
	xaVV33y859sgW1sxjAZWmvXjRFTipXfjivY9vrnim5aW2nTBzW7R5mrkj1F93kar56YGmr2Uwn3
	8zUIwDcpZISwQhdhLtI6Wb+QUa3qZuEH/SjussXQx
X-Gm-Gg: ATEYQzyoM5nAjcHlxBe+y1w8wjNZSfSh7CLXUwxgo7GLpzpSQjB7ERPO+VN5DyrizC9
	dqOwnB/qzH3LFAp8sO3VgF4/byXj3riwH1S1CzIt9Znrul6m1h9ddBCL3hGMQdB0mS2atfisH51
	6frcpUckT1G3FplIetJGIZ5PHVDymVyaoxPQG55kPna/qPmplSO8lL5gdu71olWvFLZ2cKqof/6
	jmWto9BV3j+xeFT81gwukOaAIwR0npnkybwzY62Fnjbt3zN3nwbtoDppPGqLBwHKIDVGpwm3saI
	U+2bGYoLzU8E8CI=
X-Received: by 2002:a17:902:e846:b0:2a9:5e25:46f6 with SMTP id
 d9443c01a7336-2ade99906b9mr9212675ad.17.1772041088343; Wed, 25 Feb 2026
 09:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
 <CAM0EoMkBsSn_xpdtutUozEQyEjSnhFyf94MHQ6oVLmgGLNyoCA@mail.gmail.com> <aZ8BVHcOc1xkx8Nd@dcaratti.users.ipa.redhat.com>
In-Reply-To: <aZ8BVHcOc1xkx8Nd@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Feb 2026 12:37:56 -0500
X-Gm-Features: AaiRm53ftapwVTT8fl20gohamZE80tEI0gChwuSrGJrAjDhJHPubl7AH6oPOOPQ
Message-ID: <CAM0EoMm17wsYZmdFLshH3_-GrZtzd=i0xnoO2yiVB=-N4761mw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: ets: fix divide by zero in the offload path
To: Davide Caratti <dcaratti@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Machata <petrm@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7C46319BA85
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 9:04=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> On Wed, Feb 25, 2026 at 08:45:10AM -0500, Jamal Hadi Salim wrote:
> > Hi Davide,
> >
> > On Tue, Feb 24, 2026 at 3:30=E2=80=AFPM Davide Caratti <dcaratti@redhat=
.com> wrote:
> > >
> > > Offloading ETS requires computing each class' WRR weight: this is don=
e by
> > > averaging over the sums of quanta as 'q_sum' and 'q_psum'. Using unsi=
gned
> > > int, the same integer size as the individual DRR quanta, can overflow=
 and
> > > even cause division by zero, like it happened in the following splat:
> > >
> >
> > Was there a setup/test that resulted in the splat? It would be nice if
> > you could document it.
> > The fix looks good, so:
> >
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> hi Jamal, thanks for reviewing!
>
> the test is a single line :
>
> # tc qdisc add dev eth0 root ets bands 3 quanta 4294967294 1 1
>

If you have to resend then add it to the commit - otherwise a tdc test
should cover it fine (when you get to the netdevsim change perhaps)

cheers,
jamal

> but to see p_sum =3D 0 as divisor, eth0 must support offload for TC_SETUP=
_QDISC_ETS.
> I see that netdevsim only supports TAPRIO offload, and I plan to follow-u=
p on
> net-next adding support for ETS offload on netdevsim (maybe also other qd=
iscs
> deserve this, just to let syzkaller explore some  "new" areas).
>
> This way, I can write a TDC test-case similar to those we have for taprio
> or cake-mq.
>
> --
> davide
>

