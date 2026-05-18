Return-Path: <netdev+bounces-289130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJzmFjZFC2qsFAUAu9opvQ
	(envelope-from <netdev+bounces-289130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:58:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8850571557
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07FA430C5965
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6024963A8;
	Mon, 18 May 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hei56Fxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F3495508
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123222; cv=pass; b=KFL430R3X55ueG8a8+AOs/+fbO///vBEXnGegO4mZlSm6KHftGiNFnqhX3s8PcWXjSux74qKxHIu+d0A6C4FFcqHNo0DdMEYePE00D3POmZeY5K0FtFcX+4C+RjWlOPvSW7vcKLvlRCbvbfnEAFY9eYQ2kC/cOOF5HG7D/+CoD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123222; c=relaxed/simple;
	bh=x+r14v4NcgfqM+BoLOUWBvhLtJ/fJvWtGOg0SdTAeC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U91Tp3CNUHrlfoPCO7S2+QrZjMBW+S9SX17bHU5Psn4n1OuK5FWjTcOU9cVLWFELRPluiGHk1qKbR/xnkoUmrgczTtq6iqjpCd09vH+XMDvzxmjqFBxS1LkObhYXJX94sbmORN3jHFeeTaJW3k+xI1MFlwaebwbFbkGf6g6mBrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hei56Fxs; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50faf8ed9c5so12738721cf.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779123219; cv=none;
        d=google.com; s=arc-20240605;
        b=RPPfWbZQq7NyxNVGd1xtnPUTrJZ3E23I90F+nHag7TRE8nJqfekvSIvwHBS/G+jJzU
         92OF6YraAtrPnhl8UZzAymW3wQ+hwPs9MvXTB38r0iKpq7PdQ3usSMZfUUGLeFudSiGS
         VnrLCIGkbE4Y+TGb1GPuk3mDLtAqlgKJTU+ITNGBkUB3LxqQk3tDNkLWU1bOX4+lTJNK
         LMvea6MFVX2QsOlaHRHhryTTrpsQUDuHCInR2bkVd7wjeL8XN73g1oGhW76mMldFs+JY
         D23JxOdhAWykzTuR1vnLR4ptoCcbjhsZzCs8N9wEgdcKXBhptpsL25AC8MKa4CnGV64Z
         ztpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lZU5aZ2FB26+Pbl9hgcLSa+cp+VkctUsnWHJjJyyE0s=;
        fh=lCXjS9QRKGhGKo9ZxJLQRuDdHsXUxjv73HW+cVhYzmQ=;
        b=c1Rh+FmIwNj3L5iCKWraRtfsQSmSrOThcMQyti5u4/BEN2boKid4DoarKJfQNnIezM
         PAUo8i6iH1/ObxmeRlxlGXxEoWMd0AbZOKJStQRoWufE4qnjgjH1hWq9kC0pKiX2qDKH
         Y+HRPgfU9V+Mv8dxHqoI3h5B9yn74juDWiwH9uREf9ToQBlLhBx44PCHUPqAH48SjGjj
         OKqibYK7Y1pruxG7o/8Nzwvc4Wtjy0N7XAsdM/B4WCHRZ6L5y60KJzCcyi3k3TGywTUn
         fMdLDc540iToJEyiy3gFSFQM1ZjYGxrg++izBss6c2XnY8loBOk+2MvTJS3jSFrUNKPR
         JkoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779123219; x=1779728019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZU5aZ2FB26+Pbl9hgcLSa+cp+VkctUsnWHJjJyyE0s=;
        b=Hei56FxsWld+7+1IQTRuYXDHqHaBXKIlGdkXhsfLIAZ0iT9m15C4kbsjTA9C5hkOfg
         EIUyauE7YC+ZklGm6AMex4prNaMSjswp7unyS9cYOj26z1qlntepAQ6erbeinQ2cPCtT
         ZpJ+HHieriHXV+Wdalyj/2S7i1MQg4OMYao7Pnw3bV46sLAKT4/SaQ5K0Nsb5a5yhEWK
         TVuTIIH7cbA0nHj/JZ0lQgPZ14FD2tzfte/UZc6GL7yHNN3setUf5A0NNwLEyPjEGEKW
         N3OJL880SSv6ad0xk8rEIqVtE8XNvQnRg0BSpkE5KpaZCDC8CT2Tw+QLqJAr0Levf/XJ
         PWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123219; x=1779728019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZU5aZ2FB26+Pbl9hgcLSa+cp+VkctUsnWHJjJyyE0s=;
        b=oeNxxFdKQkTpLqKBGAz9aPNhDdiqipO3d6s6XOhYxO4liwmhnlMr59PCQntmFiWgxL
         5En/NNiAJhM8R13m/qm5hi3nzllFvzvzRFzsLw/7c5XJfb0uqM5/rEdy70HMyMwiqKT0
         IFXbx4xMzfWwtlIEUcBWAoH93/wROkYdMgJtLX7Qw/f0gUsrZNVHVCjNvQUfObY6cGc+
         EbwmC602rr4y/a2+hRyKJIH9QM3NQPia7WTl+YnEqP9TAKRxGg/6FLRSepGNPJbLyi6d
         VZVtyjpaQTD2XZTba2GcypewvsC0CptYq9vk215javQU+s10AI+CfgsALzZVA7TH5r+w
         7JRw==
X-Forwarded-Encrypted: i=1; AFNElJ8/HaqpUuJneHONQ+W5hyNmfKEpGbiIh4NIcGUJfk96hTIfo+J2SHAAGHwgvz14HCM2cAKXgLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/17aX2mJmilSIyD3zcjSTHVBMEHWUaZI/99TAykCrsex7Dz/
	8uF0A19f6jeSJSfntRxjItGYKvPd/mweBTyM9V5f/J53VZR2dP1yKZMJ5gjKV85oMiAqxv8I5Uc
	r/G8zxQ6dQX3ht22wus/GFEZ673oK+q5hNo1tJOL2
X-Gm-Gg: Acq92OFKnv8BHhIrorz4C3ZIfIc/ghYQsFdvFGfxG4d3jID+Ry7c3vHkubStk+sxQne
	sx3cFnaXTQrR9Uq+MkgIDICv/52ek7kvfjt/vAHYD/SRD8u+qP9Mn/Zi3IKuk8KU+sA+GgfJygP
	hV03xcJt2/A87uS1QDCxDUbg9aWV5otLPIyYrHNM3n5midC13u5fVQoPiso7KibxVjER1Jtrq0Q
	mM9+I6rKlFaNrefmQYHkMJ0lAATZ7NwYQFtgI4ahqQrIoRzYgwjR6uzUpBvyqk3pnD8CeZ+E00d
	1XxQRA7zRWkpQKIfUG+vsOwPlCfXZF9NrmdmKRav6+lM1eBAOJSOwKx7A5JXeYzkdVObiP7Z/cP
	frhn1P35w4Rd06ocIkI0HPjwO/tyL6JAAdMwq64Lko2KNdqBRku6kPWBKQjEc9ur8
X-Received: by 2002:a05:622a:1aa1:b0:50f:b2e6:c033 with SMTP id
 d75a77b69052e-5165a29e0a5mr222360331cf.58.1779123218561; Mon, 18 May 2026
 09:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518100134.809042-1-edumazet@google.com> <6a0b409a.a70a0220.202581.0005.GAE@google.com>
In-Reply-To: <6a0b409a.a70a0220.202581.0005.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 May 2026 09:53:27 -0700
X-Gm-Features: AVHnY4IywEJqZc78JgSJNP5UAI8nXBFQDchsRYDpjiLSabtzqOaMRwZOorrTfFY
Message-ID: <CANn89iJH0Ofh_+Aza7kCvnHwU_PuaNby+9JyzG+5g-eo3bQL=Q@mail.gmail.com>
Subject: Re: [syzbot ci] Re: rtnetlink: RTNL avoidance in rtnl_getlink()
To: syzbot ci <syzbot+ci0e37b1eaa858ac77@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289130-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,google.com,vger.kernel.org,redhat.com,lists.linux.dev,googlegroups.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,ci0e37b1eaa858ac77];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzbot.org:url,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B8850571557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 9:38=E2=80=AFAM syzbot ci
<syzbot+ci0e37b1eaa858ac77@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v1] rtnetlink: RTNL avoidance in rtnl_getlink()
> https://lore.kernel.org/all/20260518100134.809042-1-edumazet@google.com
> * [PATCH net-next 1/2] rtnetlink: use nla_nest_end_safe() in rtnl_fill_pr=
op_list()
> * [PATCH net-next 2/2] rtnetlink: do not acquire RTNL for RTM_GETLINK wit=
h RTEXT_FILTER_NAME_ONLY
>
> and found the following issue:
> WARNING in rtnl_fill_ifinfo
>
> Full report is available here:
> https://ci.syzbot.org/series/c0efec5e-90ce-4ba2-8383-16d7bc172521
>
> ***
>

Hmmm.  I thought I moved the ASSERT_RTNL(), but apparently this part was lo=
st.

