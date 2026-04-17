Return-Path: <netdev+bounces-279201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPmeB8qU4WkVvAAAu9opvQ
	(envelope-from <netdev+bounces-279201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:02:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DE14161BB
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D610301AA72
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 01:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE62857EE;
	Fri, 17 Apr 2026 01:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umbNioIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F3274641
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391116; cv=pass; b=LQwIsjC+g6COI8MRSJ0dbhLOXAPsAN19Zvj6DU2ux/3D/B9yGgz/2fnteoeIJMi7LkIB3xIVpa/WPzB18hGtB9tCHzJmhZ5i8PPgy94bbfpdB2x6J4sJahjPSZJYg/3g/ZsgSGoejohIgLJn8JIUxkfUCmWPsCGzC7bdVdQDfgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391116; c=relaxed/simple;
	bh=5XZg4lF8dt68vaCTN/Ad4qe3TP1/cSd8GLGcwL6ceYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7kPAeuUiv/KM6q4FTQrWTb0+iStEaIwEmsih/EdFg/OUdKukHTxz2h1FY80LRpkRb7VY4w3wevvQpWr0srDLKiGLPcGCHcucbec/U+QB4y45BOqGSFUMAewQwCvBBodZqpbj5EDT6z7OjGJhacupcTjy0yDkTz6ueZ3xgAOhoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umbNioIU; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c19d23b19so233960c88.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776391113; cv=none;
        d=google.com; s=arc-20240605;
        b=DonUoTyrbEaS0I2x6vXQHxabtJOpc2YYMe7w7X0ltIVB12uZqctrIDrjebT19K+yst
         vOKXJS7MSZ2vzail06Drfudjaq9T2VUHNOvBrX3094HdtgaG/iirYYszbhS0ezVOhwV/
         c9mZfDMPwTbFTDCmrYk0C0i3aDd/8Xq2NUPR3BHaNpKf72R1nzYcQ8WdfnN2xJai7KKh
         rIDblkGpKmfXtzrJrGGZtPxOUul9jAowWowsoYSik6bCw//kFmYy/zx2ssOg1w/QMdmj
         d2guQ7HLTjgjfa3tV+uWWqEWaDHBbddeCfkFzuEJ4ZfNeqjLnPSY7E1P/v++b11JjLSt
         zSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNY/LLTr6TIgoWo2qCLWE3FAOMBrGLPg8li787GxQcw=;
        fh=WeZi7GXd2BDRCepbmanB7Qd8F4rwjfe8sfzQjsMUmu4=;
        b=Dkcqu/UrUB854eGC4KJcqsOZf0hnRQR+6qPWnXgq8A1ZU/Ta3PLUZOt+TBI4PPp1Iu
         AhwUvpCOcHoW+zyyUYVoKSQ1cEHecrkukk4Ius/wJOYSqWHeuCOCiaSXPXNX0mktJSpO
         PretmI93DIl9PzSISyL+/3vKvkYyO27Fc2gDcSXoFMbhfmRfjXodtHN3JJbBx0DkWo/V
         LBHg1095fQqAXzgPbeTg173FLhUShIVRkPy/RiDBZeK6AFWPHQoZN2kW8agwt3+rVMq7
         oWFnuKnpMIyGSLltjbouTkVm054WdBuIhens4abDoSM9iube03RGtiNEDCbh3NQ5O/m6
         qqag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776391113; x=1776995913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNY/LLTr6TIgoWo2qCLWE3FAOMBrGLPg8li787GxQcw=;
        b=umbNioIUep/O7C1cuoEQnpVOgw/QjCOC9hCOEi2urWzNXeJoLzqf52tb2a63ab2+mg
         UCC5SMBmY94ImqfrMlNMakf9DGqnPBahNHEHrAXScUKGOkqyxALqohS5otbqjxTinvLV
         rwY35PxtM9C/Iypf6bb+YtCiA30nfSv+ZGpIKHJE9rRX++U2jEvp2kWxDaSJIhL7sQzk
         NnZZ4pUyHSLiJtCFkygABv3caJCbX8Pvr3dkAbKTJIQdSKC5G5xMLY8/pHRv0o/O30/V
         J0PhoVcvyJa0l4IXHthIIoT6OxPPXZRF10Q4Piy6ErBhdNS7OcYlyr3sTPiN0/86QKkL
         S5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391113; x=1776995913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNY/LLTr6TIgoWo2qCLWE3FAOMBrGLPg8li787GxQcw=;
        b=qhhnYS86DRnlYF2wyUYtRx/1fLkyFnzqJ+6tf92o8NaNGkmiMWKUcy7eH/0JcWENr6
         DT41j+NjGCBQq1er0U2L31kvLyAvgRZ72ZBHoEl8Npf7P2RkGwSHPycDBR4//0OOlLvp
         P1sEEsvWQneEC00Ol2sPBSqCDWxvn2dkCW78TmaLYEhB/Mr0Pj2BZMj9NUef6v+X9uFf
         OBWU1sWX14fJMsBLLLkJRG4xPrS9f5xdI+b+b/ZVnCup5wes06xXkf2CIcVNapAutHGK
         Tpwoh7T3PU2n2hZL9Pk3asMh5Ko2EzD1D9kBy+jGg8BVZLjsnaa3W3sxtvysY/vO2FaS
         44eg==
X-Forwarded-Encrypted: i=1; AFNElJ/NWboLDNmGJsyndzoilL+Rt1bBJYN4BF8n9Lqm3FbMaCG9jMitb9zqs095mkGS22K/gzLzEdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPuXgDKe0x+ins1Ss9J4K1a9FWvy+IUUmqO+j7qw1uMly9k42
	XNVaSnI48SHjaXC+N63gKwk3zXfz+Q+gVLhaS6pgyRolKOjsrMLIBEKJEwrQznUsLyR8rjbZxIm
	eHFwZqXB6CpLO2LFS6g6HX4iekUvpC1B8q+H5PvcT
X-Gm-Gg: AeBDieuAB/sNo0HSunjxrob6Qwo5APa7m+JZHTXTigmITJVDoYUnjbGIYWrVOeySKns
	scGOtnnZVnfNek4WreFiuVtmO8HjJhZa36rmJK3kV1CLjocQSYfShOSqAm6gwvtM7HYHx5IU9uG
	Mo5PgLOXP1WTzeK6gkzl6mwR8Waav5gzlz5GhIFabR+BL1YU8XxurXSF1KD2C+H8e/50a4Grijk
	XowurQ/LDWBvwXAOHNL+otVCf16rxe6PpYudsBDS1fWweybMhsM+N+CcrgH5Dm+6TmKE8tudjnB
	wOnw6U2MF3oQusz93d6qs7sExIRRJarQy3TzDfp36g8Yd6tWFWLOFB5DkXXQPxWa/QmgydnJzRh
	tZPybkjgvw490o756hiaWRINCCzIZwt5JdDB303XjSPfFhyneG4NN953l6zXfdIOryOBFv3xf
X-Received: by 2002:a05:7022:6988:b0:128:ceac:6da6 with SMTP id
 a92af1059eb24-12c73fad1e2mr303679c88.30.1776391112480; Thu, 16 Apr 2026
 18:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776149210.git.caoruide123@gmail.com> <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org> <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
 <cb1c7e8e-2d64-4a2d-9862-e5c4f544144e@kernel.org>
In-Reply-To: <cb1c7e8e-2d64-4a2d-9862-e5c4f544144e@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Apr 2026 18:58:21 -0700
X-Gm-Features: AQROBzAYgFWJ3xRcd4Gv0g-veHcRvkUl3VrGsUNeeEHwRZTHTLJJFvD_eCjW47A
Message-ID: <CAAVpQUAe=-F00FrLKDanO_aR7EavbfjpsDsyd==4BDqM5_6rQg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning reqsk
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ncardwell@google.com, dsahern@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, daniel@iogearbox.net, kafai@fb.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279201-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fb.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 73DE14161BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 2:18=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> Thank you for your reply!
>
> 16 Apr 2026 20:48:58 Kuniyuki Iwashima <kuniyu@google.com>:
>
> > On Thu, Apr 16, 2026 at 10:45=E2=80=AFAM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >>
> >> Hi Ren,
> >>
> >> On 15/04/2026 11:31, Ren Wei wrote:
> >>> From: Ruide Cao <caoruide123@gmail.com>
> >>>
> >>> TCP request migration clones pending request sockets with
> >>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
> >>> subflow_req->msk, but the cloned request does not take a new referenc=
e.
> >>>
> >>> Both the original and the cloned request can later drop the same msk =
in
> >>> subflow_req_destructor(), and a migrated request may keep a dangling =
msk
> >>> pointer after the original owner has already been released.
> >>>
> >>> Add a request_sock clone callback and let MPTCP grab a reference for =
cloned
> >>> subflow requests that carry an msk. This keeps ownership balanced acr=
oss
> >>> both successful migrations and failed clone/insert paths without chan=
ging
> >>> other protocols.
>
> (...)
>
> >>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connecti=
on_sock.c
> >>> index e961936b6be7..140a9e96ad58 100644
> >>> --- a/net/ipv4/inet_connection_sock.c
> >>> +++ b/net/ipv4/inet_connection_sock.c
> >>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(stru=
ct request_sock *req,
> >>>       if (sk->sk_protocol =3D=3D IPPROTO_TCP && tcp_rsk(nreq)->tfo_li=
stener)
> >>>               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq=
);
> >>
> >> (Maybe TCP with fastopen could be this other user to call
> >> rcu_assign_pointer()? (net-next material))
> >>
> >>> +     if (req->rsk_ops->init_clone)
> >>> +             req->rsk_ops->init_clone(req, nreq);
> >
> > I think a simple direct call is better.
> >
> > #ifdef CONFIG_MPTCP
> >     if (tcp_rsk(req)->is_mptcp)
> >         mptcp_reqsk_clone(nreq);
> > #endif
>
> Fine by me!
>
> I guess it is needed to check the protocol, similar to what is fine with
> TFO above:
>
>   if (sk->sk_protocol =3D=3D IPPROTO_TCP) {

I don't remember why I added this check for TFO,
but I think this is not needed.  The migration feature was
not supported by DCCP and it's already removed anyway.
I'll remove the check once net-next opens.


>       if TFO
>           ...
>       if MPTCP (+ifdef)
>           ...
>   }
>
> Cheers,
> Matt

