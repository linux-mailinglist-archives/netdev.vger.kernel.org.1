Return-Path: <netdev+bounces-254948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHcuO6Hwe2keJgIAu9opvQ
	(envelope-from <netdev+bounces-254948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:43:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C60B5C1C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35DE73014406
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E731376BF9;
	Thu, 29 Jan 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsYU7oWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2D33F37A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769730205; cv=pass; b=AhWo8A60DGnYYuJxkoIONzru2QNsb7jF7hhhYjwWWXxf4gVtonXciHH6gM6KrA2beTztN5HZjp0l6X6eR+dakVwPiaPjo6Nq9LdaXj5BWJZpMTS3tQOVT616aXA7YOa+x1EfBhJ5VfYD5qho47YuM6M+mWIsmT52rTQLIqEzN2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769730205; c=relaxed/simple;
	bh=L4HL397AVHjongdVJo4Vv655S3Ufci0oOOuvVYxzWew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoM1Vaa0MJZNUpclFTHAdAPQRssuPEw5tV8qgYxxIU++yIKqfEcsw259x49l5dbbOOASmh2zFYWHZjm5t+wjt/xBfGkPnvtPr65Kkoi6pYTDKk3chkxEZcaXjUk6SeR96aGeT8Dcd19YqxM1KoQdgGFNFMlTrhkfBzF3yKtc9T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsYU7oWt; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a8980c848eso66025ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769730204; cv=none;
        d=google.com; s=arc-20240605;
        b=LUsSzI4Je/fY44++rqCgru+jYc4ra7Zse8hxP/ozCgw4PsxftrLn8flvVKRQ9M2t+E
         3ahuEAqMmA/vG/cKo+PrSaoaiZXppPuwUehFJlZINnxNw3qZphuZX9X7XwVadILopbtp
         jMVdb82f4HxxXy8qtGOen/kQnZXiZ/W6ZmOcWUJqqI83eTvLJ1VOKoyjoIvz2HbiWl2T
         AM3NQNeE3q0iMkldon/MpVf00IgI/Mf+Rc6aOCm24FhMJx5VNx+PBeIWhv/oyCg48fiW
         UKz4sJsATKk9AvwYRDOw0ou3qxG9RAPxG04qUOeuUJazY3y7lZhDdiMPVZkwE5ZUb/6B
         WHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XNiv8+cPV5xgrNpv3secrlFlV2DFA9c3kWcShOlsePM=;
        fh=2CGEYFvK1CqUaAMKo4bIxu77RAyyAKtyu5tyq/CBTes=;
        b=QjEq48lsTZFl/RE9paZu8JEKrkYpNP46xMecu5YVtETNaZtvRtPMWRDLD/vZ94EPBb
         CZloBWecOvOrvDr+rbn9EK6wH9DP9mRfK2xIVPeq9xytQTzk1n2IYZvPSN7y37A9sIcg
         /oQkbSMboaGMlBpwaDxVb5dTmfr3yKfjhNBxHyn/4X/pB/PxpKtVeOw6RIDQdIeizf+Y
         Nd8aNx6RCBHE/g/ijR5uNNxZq/55nknzWl1oizdzpAaY5cGhSDxBXtSgsjKYgLDknQx3
         uCJzZ5e8n5EYUqE78IPGF2oM4FK0Q/jghnpSZC+Bg3DjJvnhXIrHk5+FI4V1M1Pe7ADq
         t50Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769730204; x=1770335004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNiv8+cPV5xgrNpv3secrlFlV2DFA9c3kWcShOlsePM=;
        b=dsYU7oWtCJsR7ugkkQ6KDBQoT4kKkRJ0+7Xq3tMsiJDt8dLisK8RvhQaRdw8+E8UvK
         G8TwEcoAm8Jq/8ZIsLBtYxEzQRvq+Rkou1TT1nJUZh7pC1rnBpdGnpckbO0y4hPvcSBc
         kPAdVWU6BWBzJce73qWhNPGCul2RJBmtSHI+Ob47RNP0XfSSaj0NQYOUF8wJpETYMmVo
         hBPELiLETArqZWE0DoftMIhxm/8QuNl3qoHC6nrxcXKx2TvQETwkR5IuuFdPZiPi2/Wc
         P13+oxiRuR68CR6t/wCrVpEp5P/ZvwPnCWqTe9PIkDVyiph00/kDgOBVZax1WkCFb/HQ
         5OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769730204; x=1770335004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XNiv8+cPV5xgrNpv3secrlFlV2DFA9c3kWcShOlsePM=;
        b=TLT550bEBNHLkhJLVfouIO/1dHDw/gsaIqV6Hb91Bl4QiBOJ7OMbo3sagsfxlSV0Sq
         WEMzjlrZgKxLWdEInXQhPrDKV9H9WkGuhSpQF6sol0xgBuwY7sCyntYmRJwAHjjWWYJX
         RT0wGveCpAAU/PoJV4ZXYr8vgqGxgl2gISius8c57hUvTpvyUZ6qdV51gFz/n+CaB+tO
         O6HXAIttY/s+Uo0lIMNxz49wU78KUrKeXjpMtvuxYO0c7MemsFL3pvfjie1rhgM7Xrus
         iXZTsZOB7yxDZrgDiWXA0HdPOsmrOuOE9WTB39+XM6eCuOEL/NKCRVenAxt+KBCDtZLa
         dzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV5hmbdrxbCGxsWajR88uM4nsAcVAlcQlj7pwMzCwwj3Yn/S+J2ptKBDG97CTJbNTworpoy2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXYdHbRsu54D0jJPtznozV/NFSlf/dqdXptInMNfhCp6gp5Id
	jJmb2qc/rX8MHkdxM1oLMo6mk8KS1LkGlxcyPUemxh0fli3/5kps1nK4w0pnoveA1NOv1lPXjgQ
	0fKOTKYFzjZ/eI+bi7+4hdwXSFJRMK7Y=
X-Gm-Gg: AZuq6aLTM4VgwPDIVc2wcbVGSEsMqzcWesi65Ek+YiwiNyNnOksERWPeHtkLFuWVLPZ
	qACOM4kWm2gnGTlrAqfMPK7CXbaZOfJFDkIEwujhLe2bvp//fjJnYx1WxgtQx3GV6eNg2LBvzzO
	9l9DFwBFqCU83Oho4k93s+VT/ngEC11skwEdidqfl7sGWXyeQXZtRD9dw726yD5aSKouoVbtGGW
	Sh7ZUfk8xyEkCrnxVaDDbOBJHrn5NUBnj0q5VR59W3xJRhSShsxcrCFOMNmwrxyQm/rv/DjkrpM
	qHmHPu//vAAWK1hpC9/MNqveqY0=
X-Received: by 2002:a17:90a:d60e:b0:343:66e2:5f8c with SMTP id
 98e67ed59e1d1-3543b3d3a87mr699248a91.3.1769730204178; Thu, 29 Jan 2026
 15:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirffTyUrB=MkXjw8N-gEA0Qvr42mbUndybG0+6wyFdGiajw@mail.gmail.com>
 <CAM0EoMmVchdXPrmnFObON4kf3FOz2SbjFptRmqTev3GtkxWGvQ@mail.gmail.com> <CAM0EoM=aO=giqVWOFD8A57Zw91wcC5N0arT9PNPjnq_MA43tsw@mail.gmail.com>
In-Reply-To: <CAM0EoM=aO=giqVWOFD8A57Zw91wcC5N0arT9PNPjnq_MA43tsw@mail.gmail.com>
From: GangMin Kim <km.kim1503@gmail.com>
Date: Fri, 30 Jan 2026 08:43:13 +0900
X-Gm-Features: AZwV_QjrfZ8dL00Wi4xN7JOmNAFYIMdEVPllYDa0Z0pNXhfgYpDQF5NVbChhyNI
Message-ID: <CAGfirfcMgA3h5StBMcfBz9sWnBO3=uOnir-=LfXd4EzYURBmRA@mail.gmail.com>
Subject: Re: [BUG] divide error in tabledist
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stephen@networkplumber.org, Cong Wang <xiyou.wangcong@gmail.com>, horms@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254948-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,networkplumber.org,gmail.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmkim1503@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66C60B5C1C
X-Rspamd-Action: no action

Thanks for the information.I verified that the patch fixes the bug.

regards, Gangmin Kim

2026=EB=85=84 1=EC=9B=94 30=EC=9D=BC (=EA=B8=88) AM 6:26, Jamal Hadi Salim =
<jhs@mojatatu.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Jan 29, 2026 at 8:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Jan 28, 2026 at 11:20=E2=80=AFPM GangMin Kim <km.kim1503@gmail.=
com> wrote:
> > >
> > > Dear Linux kernel developers and maintainers,
> > > Using a modified version of syzkaller, I identified a new bug and
> > > refined the PoC, and the bug-related information is attached
> > > below.Please let me know if you need any further information.
> > >
> >
> > Thanks for the report. I will take a closer look later today.
> >
>
> Ah, this seems to be a known issue ;->
> See:  https://lore.kernel.org/netdev/20251222061306.28902-1-ghandatmanas@=
gmail.com/
> We are still discussing what to do with that. The patch on that link
> should work - try it out.
>
> cheers,
> jamal

