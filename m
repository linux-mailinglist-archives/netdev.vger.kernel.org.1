Return-Path: <netdev+bounces-302250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C8IZMnG7PmqDKwkAu9opvQ
	(envelope-from <netdev+bounces-302250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:48:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC736CF782
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:48:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b="Wz/YUPbt";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302250-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302250-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3474306B665
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC335F180;
	Fri, 26 Jun 2026 17:47:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C639AD39
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:46:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496024; cv=pass; b=skr7qcKi/5rXwzDc3NR3628G9Y1SDFb2Thq9H75uQl8H+WHlpMeTzufgXYzoDPM+Kmq1Sv5qY3JrwouPb8BXTlXhG7OJmu/u9jQjmz2+mYvS3Y6wm6MuWvFizBCnZH2/G2Q3w8hZCp6BmN/AQgVa7MlzDg+bfTI69RuIvByzA9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496024; c=relaxed/simple;
	bh=x4AwvDQptVq6diWzZuTvXFdKURw6/fZbdm3DOwVB6xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9SZqjo9nPYWHGyxttogckuND1vvdszlnb6OsTrXq3pEnJgWPyicnR+loeiE7at8rOwzJ0sGdjtRH0o5us0GnaO8U4HxD4qbfEd6dFZb+UF08OoZWd0KS6OxFHohH5BBUp2V/8gU8dtjx1BviStEjKmHqhv56k4deCfcPvx/OPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Wz/YUPbt; arc=pass smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8453a67659fso712946b3a.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782496009; cv=none;
        d=google.com; s=arc-20260327;
        b=lLGIkl4OT7ifC/EYhEvu8vW/a6SZKjemSODuN/cb038PcH9AVJz4lryohTVzDZKuub
         VW+K5fmpIk/kWTbLhcqvTRD2K18e0iJqydHhrbi68sV5VuWnqu5e1MilU1FE2K2eU62l
         tCeE4/R5lbjESRjbQQaSxTFU2b7K914NLv+ZxOK8uSJrkmFAiU2lYM9lBonsY0RtNVHz
         DvVqumNMtWwYu7ESC+N8uT79XNDXccxGNrauqzUA1JgthRwDbTs+NzuALj/HJsC+B7W5
         dzXzqpaBhXb1dRuuJ4fK5BaKPf8e45VEFAt0eLQQ87/m8efXKaUD7eXxoSw0nt4wgIQC
         MmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x4AwvDQptVq6diWzZuTvXFdKURw6/fZbdm3DOwVB6xU=;
        fh=ML8JRSJ6H38D8XYhQI4ILa2a482PTOBNessAAHSC1r0=;
        b=NnPlOZ7IQcN1NonDV5LShfj2f0ZkK5dJ9jEUG0/wFHot6tDYWHxytsCsnFffrh+Q7i
         pyS6ieq8amKFxwrtdnav4XhHzYKS+JrZID/ucLguTSo8tnpsqe8jU88ozbZHt3moZfVP
         JLuJl3oKxCNnNocLUnCDSHqb72BEqdI3QjGn5ELX5x1PC4tBlISr1zX0sAyezivRqysj
         abeftrHIi1MeM6mRSNtsAzrh6yMjxooVP4CdAbiA1ZOuJ8U+Iu/Ti3N7d1ljEBJDdYVv
         9tR8D59tWPcosT0L88ee/QLrkuJN30zJsFoMlRO5FD+6QoKmV01kmc8T/YVotsU1c35h
         pX0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782496009; x=1783100809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4AwvDQptVq6diWzZuTvXFdKURw6/fZbdm3DOwVB6xU=;
        b=Wz/YUPbtKRbRl73P7vkopnJjZ74m/QR2LQ4NHH6Mb/R714OfKCD5iFER4t04fcxsMR
         /EYMAC5BgfWeQ4di77dRUF0HjdWMTwlaFCIw6c3AdvdJL1mAqW1dDu99t4nBgpuiYTZg
         FT3a52vcmiVR9MpzTL0BRWXmCoaX3iYSOt+EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782496009; x=1783100809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4AwvDQptVq6diWzZuTvXFdKURw6/fZbdm3DOwVB6xU=;
        b=XVlUcE1R3t/52gw/N6YruU/CgM8IEcDUZyhDezp1AASVTqX4FQaqe2s8QYafYPXD7A
         EDDKpPP1EMWXCt7QHjbCEzh9CE3NVgxJ/XeTch0ECRBqjUkvrr80MApJfS4LMeJir0dC
         KT4YJPSlzV0hZZTtrY5N3wr/XhBJFsHy7hWptXLPG4NUINuxva9trhfl46ezGefteNYE
         A08wVUu/ndksJCKOffsOFS8+NB8DN812u/NBWzkzkds0ThF7JmzqHbt6MoK5GiMdq7CP
         K5j7aTMyNTuNNfz6ZuQ80ny76qc95Y7My++3FWRdI93s4tKVpGSaYimtzAYLp5t8Kejx
         ZhYw==
X-Forwarded-Encrypted: i=1; AFNElJ8hkvrFuAq7ED9VsMoK466sH7HOCRoXTLRWB+Lfia3B1HulAwpX90CVhUWiwXtGfgd+G3szjxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJ9UEF36JtmOLBm5dMLZMGuUM76JtWj72irfCBzzjGGEtj8V5
	XfZsSsQnGhr0ErdGvsJJFcWICN+hDjGdbKI9UYwjNE+FXPQ6bdBBhP/pkQISdWTua6iJUQ4yeud
	NiMrZG0swz+LyUorAscsv0jOu94WNF6IIbxc/sfI/
X-Gm-Gg: AfdE7cmAKmgMf5gmYB3Ueu5LWyvevLauo3Wlt5KSWaZ/TC3qxmkfIC25LeG7YKIzHTI
	FJnTH0qZCLPcXp40gPEDE7+g7R0p9ZmnbKG/yZIYQqCpx6A1UgGMDeT1Jtyaeqq1spQWYafOC7D
	epaN7LSjlmrr4bSd4tMf/agHrlmPPQBit5yO4GwVXBTIFyXhT+XW0oqXnyAV61C4orCXdrBf24T
	Y+nXGlAk5YcZKfx5m4zkindMpWFc9Se/8oVeCX6yl405tc1TglW9sQmU6y1ZrIpatiSOg==
X-Received: by 2002:a05:6a00:1382:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-845b39a255cmr10418895b3a.7.1782496009591; Fri, 26 Jun 2026
 10:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
 <20260625-b4-disp-31bcb279-v1-1-85c40b83c529@proton.me> <5d57e4ce-0460-4ad2-9891-1bc7d24020d8@mojatatu.com>
In-Reply-To: <5d57e4ce-0460-4ad2-9891-1bc7d24020d8@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Jun 2026 13:46:38 -0400
X-Gm-Features: AVVi8Cei6xSt51UiXZ1BLZWtNoWfdbuGJGwWLQJhqn3TQ7-zZnSwGHoiGLSt7cI
Message-ID: <CAM0EoM=E484np_auBPtjoE+tXLN=y7qhi11FDRwAxBehuMGUhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/sched: sch_taprio: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
To: Victor Nogueira <victor@mojatatu.com>
Cc: hexlabsecurity@proton.me, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Jarek Poplawski <jarkao2@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:hexlabsecurity@proton.me,m:vinicius.gomes@intel.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jarkao2@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302250-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[proton.me,intel.com,redhat.com,resnulli.us,kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com,nxp.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EC736CF782

On Fri, Jun 26, 2026 at 1:16=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> On 25/06/2026 06:51, Bryam Vargas via B4 Relay wrote:
> > From: Bryam Vargas <hexlabsecurity@proton.me>
> >
> > When taprio's software path peeks a non-work-conserving child qdisc, th=
e
> > child stashes the peeked skb in its gso_skb; taprio_dequeue_from_txq()
> > then takes the packet with a direct child ->dequeue() call, which ignor=
es
> > that stash, orphans the peeked skb and desyncs the child's qlen/backlog=
.
> > With a qfq child this re-enters the child on an emptied list and
> > dereferences NULL, panicking the kernel from softirq on ordinary egress=
.
> >
> > Take the packet through qdisc_dequeue_peeked(), as sch_red and sch_sfb
> > now do. The helper returns the child's stashed skb first and is a no-op
> > when there is none, so a work-conserving child is unaffected and the
> > gated path now consumes the skb whose length was charged to the budget.
> >
> > Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio schedu=
ler")
> > Cc: stable@vger.kernel.org
> > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

