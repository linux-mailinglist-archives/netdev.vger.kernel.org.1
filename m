Return-Path: <netdev+bounces-272884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJyBJOYXyWkFugUAu9opvQ
	(envelope-from <netdev+bounces-272884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:15:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0974351E58
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABE9B301301B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F023603E7;
	Sun, 29 Mar 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tf9bDJRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C83446AB
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774786530; cv=pass; b=BQZ27Igaw5xTmZP0Sb78l2vw/p/bp9PfjhskxCtS8H1oDpnVt6oWslKMvyZ99I6mZ0ndWPBmzVY48wFDmkG3BqM29Mf5gsT4ZjJVcjhvpFrYduIpFKiH0MddTHt/omb3FUXCl1+sHJPS7Oh4rM0lSKiVeiHqydyw74lDkv+nKbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774786530; c=relaxed/simple;
	bh=aGUSXWhm+JoDXr6K679Ou4D8GdN9hAVsT9C3QTs8kNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu4/Xc3uyrC2c4cLqZ6tfms5jqEnCzKuCzVsW3LRRiUeWJ0tPldaAVWqOSGc7E6xJNoeNw6b2F8YaJYipnVoz+wdkLXBxt7Mu1W6Sy/2kh2yw67vHtmwZ/O3viFK9mjRx8wdAWMuf7CkSjA2KKEcAyftIv1WRsyKIEE6wNJbO3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tf9bDJRY; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82bae83318bso1655018b3a.2
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 05:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774786528; cv=none;
        d=google.com; s=arc-20240605;
        b=J9T5pUOvveI/IjIytLblUokiQ0mZJPorehEhehE4QBKbOotj46xsInysLouk5bUgfe
         ho1RX/WjGNKnykK0EHFm4MsHQSpc3jybI3gGm6+Jx4OhMTMT/9UzlSfVcAYiscKipg0T
         UYkApY34p1n7Wc1ugH5srxWhjgiwv4rMLgWgeF+nx79THNXv16hAE1niMLsooNBzth4o
         dnr6Nw4O/EWID86IedsLCigevFpUfTkH6h/Jk55Ckg6QIpqBBQQyTickNhDhafg7+lp8
         Oa4SWYLhLbJsJD+78zkPq/NrRtzLCqYq1becCGqH8CV+fxtfGhBzS9gI5hp3vB0NdR/B
         ZZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1bkIX8hkRMa3/SMIoe10mwAwuMyepgF8Mu7WOEyDrs=;
        fh=nYVvRJn7C0FHwv+zL8foIgb8fRUFEmEj4NkKRgmpwPk=;
        b=cFPCWM15b9InkyXqasTy1u2s1F6u5ZQtWLJHCA0/RltRTfN3vFeX+jsoQ140Vr8eud
         MWFdGMPWcdHNY4sifTeXVSDlY/Qo0yjQC3Cdbfg0ehGv04ZvOn3EgqCezRwZ3biRCY9a
         GeEcc18EdqETB27wrFLdj8ENzdMIz32a3qwLJBnfcgS8myFMECfPi0g6+GHyuoM1UACe
         uO4e1z7iKT41elGa6Qo5w9UVZypQgN3SFNoBVTIfyON/teemV+8VnRenpZ7ljm6/HEIi
         6ALsm0xvD/2qqc4Tmwct3TkImGxIiGRoptaTIxpvNViQZzqIPgtzfPZdvo8czTgPIBj/
         UYtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774786528; x=1775391328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1bkIX8hkRMa3/SMIoe10mwAwuMyepgF8Mu7WOEyDrs=;
        b=tf9bDJRYl0anmhOjA97tX+MmWbmJHVKMmrporCYuiMSjwYwFVPclAycOAb0/8y561g
         UoCaeNL28jGVvA/i+I5643vQ1NVgbjneYbOApnIbxMrbv74JlRZ4t6ceO9D3k51Btl0b
         li+lTyvslYnwecuNSSk8oBhwKTc6LubQnEt5P0KfBnA5jHtPaK5AX2gTTvGYt9v34yQw
         VaplfV276wvTve8NnT2XQe+BqFb+SMEmLUBL3jiU0pIhvSfOQxvxKhAF9CAU6Um1z+4p
         +G0k+pgT3ih+3vaciqJT1G3BUwBVPEq1SMuvHSVTs9zhT7Mofq4DZ7wLFrcm0F+BVfEd
         eXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774786528; x=1775391328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1bkIX8hkRMa3/SMIoe10mwAwuMyepgF8Mu7WOEyDrs=;
        b=nyefQOdI1PZGcF65V5QR7/pGsaVh8oi4HPHSJ0Y55tzOyw1FTa+BB4zokCi9ImB/2E
         44QAmuHgLvH8WpZpPBDhtBpYaB/hRmO2Z8Om459iwykYLcxhc2JVPDNA2e0GHLWFnPkH
         jXVngWEn0ygrQKkZk8Fpo7aADsjBiMQB9IhNYzKoaXQTok2ohCjo7q1jKLAQu8na0MDe
         FlCyQo0dNsN/E3OF9aNtuDDuI+wVLy0BB5if8fKoaXZPWtGpAfm7Z/Feu/Ni1g5sl+7v
         AI7tOUQpqXD2dCu4AXStiAUc1SEISMtPlYteqaXsY33QEfRcWReR0ldvYUostjOVcLvo
         tZUQ==
X-Gm-Message-State: AOJu0YzyYXF9BpMi9ZPe2gQZkiNwx5rZE5IEFfhLRiTs3lF//Rphy8OV
	WmbaExof6VVRiVya+sf6zaAsK0wR3TDdf+Jyojv+5IJv7KpqUgcOnv2cDOR79m8LyTTyezt3aSi
	Gf8eMXg5y0tY8+S0vF9Sgv+3jSZypyECG74/cIITr+AHXzkNd261vkw==
X-Gm-Gg: ATEYQzyvB1ypESkE0ehD5kVm89WuQk2SqP5k7WHxOPeu7l2DmMSf4kuUFsw1B4wY7DP
	vvAYZvFqgqBiaQfPhnHuC8I+jY8TVQ5nQHdPHhrV2jhL+y7uqfcqPwXOD291vzVxiaZTHKI8OvU
	suonmjiythjAvLOw7RJaEzv8DITyKoplPduA5uGTPGZAu9kvhiYSQdCnWaxMEIH33xQew2iQNAY
	pe+3DqExHZg7RTL7kbuTmTfqihiPRIoRdJzqlpXGOtnyz2sERJXe2qQSdN7ChjlsL9L13DtXLov
	WV9t/PQ0bQAtEDycph0=
X-Received: by 2002:a05:6a00:a113:b0:7e8:4471:ae55 with SMTP id
 d2e1a72fcca58-82c96025e7amr7739376b3a.33.1774786528595; Sun, 29 Mar 2026
 05:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327061300.3066844-1-xmei5@asu.edu> <CAM0EoMkspiNjXpdwnG2HaPK3n+BJkjTRbA8k4TsV4fcVk7g_Zg@mail.gmail.com>
In-Reply-To: <CAM0EoMkspiNjXpdwnG2HaPK3n+BJkjTRbA8k4TsV4fcVk7g_Zg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 29 Mar 2026 08:15:17 -0400
X-Gm-Features: AQROBzCZdaTy7dGEaWscHfEJG9hoD6B4SzbDG_dCsc6onIiJoUb1LKRQwZz8sLk
Message-ID: <CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: cls_fw: fix NULL pointer dereference
 on shared blocks
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: D0974351E58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 10:11=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Fri, Mar 27, 2026 at 2:13=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > The old-method path in fw_classify() calls tcf_block_q() and
> > dereferences q->handle. Shared blocks leave block->q NULL, causing a
> > NULL deref when an empty cls_fw filter is attached to a shared block
> > and a packet with a nonzero major skb mark is classified.
> >
> > Check tcf_block_shared() before accessing block->q and return -1 (no
> > match) for shared blocks, consistent with cls_u32's tc_u_common_ptr().
> >
> > The fixed null-ptr-deref calling stack:
> >  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
> >  RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
> >  Call Trace:
> >   tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764=
 net/sched/cls_api.c:1860)
> >   tc_run (net/core/dev.c:4401)
> >   __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)
> >
> > Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q he=
lper to get struct Qdisc")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Thanks for also providing the tdc tests. Looks like a bizarre bug=E2=80=
=94and
> in my mind the question is does fw or flow even factor into tc blocks?
> Please give me time to review if the approach makes sense - perhaps
> this weekend.
>
Since the fix is exactly as what u32 does - why not move
tc_u_common_ptr() to a header file (pkt_cls.h)? then reuse it in u32,
fw, and flow.

I am still questioning the value of using blocks with these two
classifiers and unfortunately the commit message of  1abf272022cf was
not helpful.
The testcases look good. Please add a letter head, perhaps quote the
comment in tc_u_common_ptr() since it gives a good description of this
whole dance.

cheers,
jamal

