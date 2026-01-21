Return-Path: <netdev+bounces-251961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKCHAzwTcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-251961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:56:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 830645AD2E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA7EDAA6F00
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FA44B681;
	Wed, 21 Jan 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7QS4Ry9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B34279E3
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010378; cv=pass; b=YMf8gDISVpd5dFQPGya+01imVCIu8TxlbAMvt3f15C2kMVyTUGkugjJ+06vXFgECus+XGDyeG9yZrg5iTLU1rRhHxKwtrVH06O5+ciD9O9KaV8MN7iO1VeW9RJVp4WLQp/j0sxKcePfHn7OXZQCXiVcoracUDgecdPuw1dnsSjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010378; c=relaxed/simple;
	bh=F76WQcEbTi0hFR9Kp7bb0bNOcyvTQNB4ZDIxqiHVc3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc8qUR8QX0eOTgIxaEslF/qxPEGt7NQwGNo0opgWPXSyeMlFeVXbUYz7f9c6ErPPgc70Rr3+ZzVOA0AtmLkRHYXFFfzcPlpw8dGG6Gzh5TAYMXsYUa0+q2crupWCZM9rrPpOOsZSUQsyasWEoUgurBM4MKROBbBMpYvZL8Sraos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7QS4Ry9; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501c6665144so67472511cf.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769010375; cv=none;
        d=google.com; s=arc-20240605;
        b=ecsP+Tw+7XZkl2nxNoLrAvTZGvzB6VOQvb6P8+eUQgOl2mcZBXx6c5DvSV0e3uVlc8
         T9oC8lT5OIzhbTqf52uBl485iRA6ZlM81rQMVwJesv/TJk9vrwaVEOmCBWgBSQbP3nHA
         NDpVXz7YqcwV1JhRrTNdNDF3QLfQaqeCob7Xl6EnjQBkSvMYWr1ZjVBUrBFxWBwuYHGS
         eU0Uxbtbf7qufZJ7phVQCm5Sh5y2WmFYnC1YjNyvzrMK93t7wDkp3hHiw1hRsBsnoQGe
         etGMcrsW7fssNZfpxUkGaD1NlFg9c+4/p4RNjpWo2XUSCppSN5X+1vhmfDMAYsQi1QSB
         rI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vhc0v3X23UZN/O3bEf6Jea0gd4odiHJo/Sm51lqUpPU=;
        fh=IpzcrSmtkeKabWHPYZDrW9m2DQN4Y9K54CPvV9TpZ90=;
        b=Srm1kKF+QiALvSARgDvUZx+2A0nrjGI0L/he8AIlkkQU6+BqebJOAyiIbJNbWObB35
         bRkgHf0IbALaPWQpbSMZTMGMReb23o9RMbhHRDXchy4NKVIkRLZBbpU8UjDypZxMBjDx
         IxZHVsFscR/IJACrnXyCARLkm/yaKgpZ+f1bL2iUU7eX6zYqNpqdNXDnUDxZ/Dl2xiFs
         /86coxfNIqxDzt9ORoSvu1ah9Mbxnph1cHcpmZzE8KKBzZykcmztfX5FyV+tjc+p7MF6
         1aWtAZFYXuMO6Ct+HvcO0aLhuuvZDYLcBf1AjdHgHiFu6/STLaWhZ600s2+EDN3WCrnW
         jMbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769010375; x=1769615175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhc0v3X23UZN/O3bEf6Jea0gd4odiHJo/Sm51lqUpPU=;
        b=S7QS4Ry9G9tttdhIMMbZ9D9J1X7izg28LTajCUwExz5FGHANlJP/f64SNctYV7dCL4
         S0qp9xaComsjghR9tQaCnY6bzt3a5EYsMJLzVVEqoPqsuOyYmDviSlFzFcffxWnmSfg5
         ZgnzN5sDDSareWYoab7gjZ8z2DOSL2FQ2g2CVT7Vxn7o+Yv6wwrHfYAymjpYpGu+1fxL
         BjgxEfvuSOIocu4HPeF+Vjz0blDfSYVW/kHHO4yApzZ23AB5IkDhoXcBL7ADlB5h2mQE
         54IBNRz29ZS0rGmU6gcCkoO4Hk6F+/HT3lnF6r5sa+RzsUk/bY36nCDAZzTsSwYZTdFG
         N1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010375; x=1769615175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhc0v3X23UZN/O3bEf6Jea0gd4odiHJo/Sm51lqUpPU=;
        b=xGUeRJNRk+2nztKub6ZpuvD6otGeTWWlCVxCcSc7Iym89lnb6BDw5yIIh3fmZ03xhK
         6vq+ZQTXGZu54mW25Jh19x7L4OFgXkiP1RKpO9Cww1wfBZBCJKfB2Tve16JVFU/jr2rW
         IlZMTHP3rb/cU1t946j4XIgcT0brDhAFDP+K+D0m3c51heBpe28dngMdTAyoWeHXPPRX
         HTrBVcGtqAeme0SEyyJ4lfbCTmBxjweKpKMcUq5+0PZGKQE/yz7oigiqoCWY/HUKB+lM
         h7g2PYjg8/Us6QdQcrXQdIfQll84BFcCJ6y+idJEWpABVlBOSnZP06auSURTde1zCS31
         71jg==
X-Gm-Message-State: AOJu0Yyz5iAW1YL2y9HTvobZFlFLE7LkpatP1o49szrPmmlAH9pu9a9P
	+N9bgJ+m9OUbN2iPNp8OSvHZi9LKFu2UT7RGVj5qQ3BVbxcrFgTSlgHplq+l1mPyJxIq2f5VvG+
	+fumdAbDkV/tP+ftkdTYTWcok1EcRQtiW4S2bHh55
X-Gm-Gg: AZuq6aIOfDsDLvJTr5sYk13BikOocUyurtAEh6gbw2iVsHJNRm7igy3aXBrBMlHYxrx
	G/8NxQY7T06pNpoZMqYSC3OXxG5DZV0m2BWxuv5Hti8LItaEXSgaCYhLkr4ztwK1vGISKAR35bG
	+zWLRwc/ovoM8+K8FGGD3fggsXjtzOLAkaMcoYD4MvpAj39K7gUXDphOC7qjb4aesASuH3Y1rbO
	I9NdNefdJaYAe8KnEu0FtKb3bXX+ocgi5mkYlOvA14DFp82O+L4XJ/bML5r7tMmX/Sq97U=
X-Received: by 2002:ac8:7d96:0:b0:4ee:4128:beb7 with SMTP id
 d75a77b69052e-502a1f99513mr236249041cf.69.1769010374538; Wed, 21 Jan 2026
 07:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
 <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
 <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
 <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
 <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
 <CANn89i+zuXMZ1Jx226rPG0nHKmRjL1s-m56xk-KD6nWLdrY1Gg@mail.gmail.com> <iSkQcHVqeUy7WNAqfrY9xUAibm1YtrTUPIhZ_yjoHmyDissbQj04N2-quW8BURs4cddEB6bDp0BfXh0LfdYwUYKQudEaHv-4TjEOTI_rCic=@1g4.org>
In-Reply-To: <iSkQcHVqeUy7WNAqfrY9xUAibm1YtrTUPIhZ_yjoHmyDissbQj04N2-quW8BURs4cddEB6bDp0BfXh0LfdYwUYKQudEaHv-4TjEOTI_rCic=@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 16:46:02 +0100
X-Gm-Features: AZwV_QgeFGxLSKDrCfTC2_WdRJPmAZnyXy9FuDtyjRvMi3SE1BesfQq0PTs87k0
Message-ID: <CANn89iL7_c9FRFUjwacSGHS7K0psFiLKeD9-NcP6Aau14_i4GA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink
 dump struct
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251961-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 830645AD2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 4:26=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Was looking at tcfg_gate_entry and tcf_gate along with this instance of n=
la_put, but I can't find my notes and I don't see the path currently. Like =
I said, remove it, I don't care.
>
>     if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
>         goto nla_put_failure;

To be clear : we have the same pattern in a dozen of net/sched/act_*c files=
.
syzbot already found the problematic ones :

- net/sched/act_ife.c
- net/sched/act_connmark.c
- net/sched/act_ct.c
- net/sched/act_skbmod.c

We already checked all other files.

Unless another maintainer proves me wrong, let's remove this patch
from your series.

>
>
> I have months invested into the UAF though and only just in the past 24 h=
ours was able to stabilize into user space, so no effort whatsoever has bee=
n put into defeating kaslr or anything requiring infoleak.
>
> Look forward to more input on the much larger issue at hand.

Sure, thanks for working on this.

