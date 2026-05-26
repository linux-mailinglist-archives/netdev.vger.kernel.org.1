Return-Path: <netdev+bounces-291665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DApLNd+FWqtWAcAu9opvQ
	(envelope-from <netdev+bounces-291665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:07:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9015D4A95
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A9D130128F3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22293DD876;
	Tue, 26 May 2026 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu/6hwDT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1A3DA7E4
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793618; cv=pass; b=Ozd+i1ffbomPUDgqhoFHiXvgssleda06x+vyfkaPw8hnTZ+p0tduvgz+AUlxDoEFCiSDiHQapDfc/IyG1vPv7NjxYfrDiQJnI6bYu+ZX4JVAxOI7kN4MUm70nHGnTh6FULma5u59A3qe4CSVwIXPwv0acNuZOH56oMZsXFKsNXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793618; c=relaxed/simple;
	bh=+vHm3N4x66CY0fSj0UCJRTudFjf5A+hlqoTRcjRm6TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMOTaplVQFQKuNUTan9hKjiH1LzRlqdYaRwssx4UtM3a6fjV8Vte5noKclvzmLKuMez72aryig0GlyjBYI39qzcGqBfYc7tO4mmMtroHbEpbw+Ky8jB/jNjHqYzmozzugssC3p0uNHox4xB55c9qdYVjmBYetDfySeo5XYdftcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu/6hwDT; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91066394ef8so808235285a.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 04:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779793616; cv=none;
        d=google.com; s=arc-20240605;
        b=Xq0MGcYBXlhbOsIVjfB/20jAFTtgFfZUrn/QsIGQWZBJKwH+wFj+hUKg0dHv4qKmfZ
         VG8d2gzRSfr65E1eSl9g93OB3q9o2kV8Tq/mzEODZcn5QJ0dvxbKwydQ5r8iFphXWTVY
         ertEszVCXQz588CkXvF417K/RQDo/PU6EX5i4EJSFXkaZSU6dtaTn52lSAddsO/xXD/4
         Bvi49nbodMgA5zl31UcFrU88Ty15GP9Z2XL1/wjYwF424nEKQdcLH+rGwLnBQOrHElC6
         4RbLF+qurdRE5R2Rvkbv2CXx/ogMCtkYFc4cIsAIthhYB1HWz5OdruaV/cq2AmTEAKlj
         wNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jbCBgD3dhYL+p1i7//luIQ8iwclRrOoguZRbtcDjVPw=;
        fh=JlgJIcJ5y3C6fZBUq9f2NljYAZ/txlcK70Yw809z4N8=;
        b=A4P21Lh1hwfHZqVGHc49JkTlD5XbGQHuXKdb0VmTqqlZKZxOEizaBfgljeyg1UmNLe
         eRJ9q8qNbgyEzF43NrlrEFRWHa1HfoyRXykvCjtjeE3Udc1rzA2mrP64tos7bP03QIaZ
         nC58dVnZLmZFH/u6d1NlSM8yEyNkLi80rnFwJwMhQEJ15dcn4vIDukfDcp5AsuAvvzoe
         oWtZImhFn0zyMIHOKSQEpB0/AUkWeRs6IEqrJnvtXRp9dlnq+yVY+puaS1frUGvoc3a4
         DdcA1MoHyl/veHCft3LIUQLHzzFx2ZWXtEBokEFUD/oHjOXCfPU0XGvvRMMbQWhHRERa
         Grfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779793616; x=1780398416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbCBgD3dhYL+p1i7//luIQ8iwclRrOoguZRbtcDjVPw=;
        b=Fu/6hwDTBOaMFNTahKFbw1hopgGxXfeI7dyl0SuP03OzLvVebWl7J0KlBfGHSN+lyk
         1kPtv944IcvQhACVluV2t3Pzps20sQkiGyT3acgld8/8tA1iFdWFVL74fOVsyxMyq8wP
         FQ0FusofiJYZRmEFt8bmrfUuw4NenYU6UPDZHvfsRw5968SvQF5bNzpdjO1aGLofMQHB
         WHw9AI4wqxMqZoJ4TZx/k73QJXPQq9HaBhtXUoxIZDxarnUFjzWN2o4q2mpKPnifnidl
         ++VbhrDE9cFeqjLBb8oTucKog1rGUDs28teJj1Q5fdiAPj7zxiBYF/5ze+Yi/0R2Kukl
         GlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779793616; x=1780398416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbCBgD3dhYL+p1i7//luIQ8iwclRrOoguZRbtcDjVPw=;
        b=CCST/1hUnu/1hgfo88cpg8xWooxadOZwcCWTdNSBRTAYleGN4u+UhDfHH9Rggq97ZB
         sxwU8bKIz+2PYsEzM3IGKVy8QmQJQS26hGmGvpQNrid/85G8suHEUm/sDgFhanG657Ol
         jp7jK23Ok8iOWDCBc1nnus8bZtK1oUkSxU/QLiSf81+iNUQmKL846RNU6q8ud5RPwy6C
         LeTMEr4RuALMDvS6gvlCjgMaq3REVwrN6+SEvElLX+9MojB5nY/JtThu+uRJPnsXdYVY
         QCQzauYy9x9u1IoiJFypniojQznY+Tps7aH3DQ8fZjn77Y0wqKYjwBGVi1IBXGXf3nyp
         ldDA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ulovp7iZVGwUMS7WrHA6Fjb43uSYgYW9AKPodUt+g5CT1xcBPA/RCLDHVp3zdqs1bfpaiobo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMevRTA7Ht+M50ua5Q8sc2sc4uuPFzX8i+If1vazTgy1OCC0J6
	TBZnDEoDeyY34IrXEkMqiN1xHbScAslv3QWiqciZRc35UeYabewTRCvbhtkwbFs+Sg/rDYziE9d
	0OHKB9CeDQdXsFcRLlCjHscs2HGUcm6Q=
X-Gm-Gg: Acq92OG2hajfNXiyyG7PwvQrjNgH5cnQx4SS37kqHws5Ye5nkemXEwnVIIY8/TtL+mS
	i6Od36wozRCovs9xSa/fZ/aDHLn59GohnZB2cMSEivLhhcIlH2P8CAPbYX6BnAu4x2mDk78/1SJ
	GAY0DoLyQmt+gbGak3oNyMGUR0p4fS3kMB/OYw2i4xVVfQX4mNAen/zFu9EfueqE92nIlIOZ1WR
	tg4AlVMIv4E4I4akAPpT5iiZCfiwbaxOVVVkNyjQb5XaJO8vR/gwQf5s96urmjbp4PTt5MMytOc
	chpyuJWT
X-Received: by 2002:a05:622a:5c90:b0:516:ddad:7c68 with SMTP id
 d75a77b69052e-516ddad86b6mr231808531cf.48.1779793616180; Tue, 26 May 2026
 04:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526063650.952-1-xuewen.yan@unisoc.com> <fd98b90f-5a05-4420-a04c-bd60011e542c@linux.dev>
In-Reply-To: <fd98b90f-5a05-4420-a04c-bd60011e542c@linux.dev>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 26 May 2026 19:06:43 +0800
X-Gm-Features: AVHnY4IdU9jlaIAL6T591Aw8fwNFgjw3WQ3_ORMXmDlftRQvjXAM0VtC0feNmBA
Message-ID: <CAB8ipk9yC_8NNr0qgjohgdLb7HWL9m=a-xUxLGtcYyHhiomj7w@mail.gmail.com>
Subject: Re: [RFC PATCH] net/core: use wake_up_interruptible_poll() in sock_def_readable()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, edumazet@google.com, kuniyu@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	vincent.guittot@linaro.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, guohua.yan@unisoc.com, 
	Wade.Shu@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291665-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewenyan94@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2B9015D4A95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:08=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 5/26/26 2:36 PM, Xuewen Yan wrote:
> > sock_def_readable() currently uses wake_up_interruptible_sync_poll() to
> > wake up tasks waiting for readable data on a socket. The _sync variant
> > sets the WF_SYNC flag, which tells the scheduler that the waker will
> > schedule away soon, so the wakee should stay on the same CPU to avoid
> > needless cache bouncing.
> >
> > However, we found that the following stack:
> >   -vfs_write
> >   -sock_write_iter
> >   -unix_stream_sendmsg
> >   -sock_def_readable
> >   -__wake_up_sync_key
> >
> > In this process-context scenario, the waker does NOT go to sleep
> > after the wakeup. With WF_SYNC, the scheduler is misled into placing
> > the wakee on the waker's CPU (via wake_affine_idle()'s sync path when
> > nr_running =3D=3D 1), causing both the sender and receiver to contend f=
or
> > the same CPU. This may hurt throughput for IPC workloads on multi-core
> > systems where the sender and receiver could otherwise run in parallel
> > on different CPUs.
>
>
> WF_SYNC isn't a hard binding.
>
> What's your test environment and benchmark ?
We tested the app installation speed on Android 17 with kernel 6.18.
After removing sync, we observed a significant improvement in
installation speed.

Thanks!

