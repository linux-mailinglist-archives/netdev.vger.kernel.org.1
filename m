Return-Path: <netdev+bounces-290781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNS5MDg9EGrzVAYAu9opvQ
	(envelope-from <netdev+bounces-290781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6665B2F62
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C7E430399F3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384739281D;
	Fri, 22 May 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oG9az23n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAA2D0C89
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448062; cv=pass; b=nnek0LAiRXWEoWlNrQvK7LRw7gbdOZmz6oG009dimE2uFwtcL65ZrIEEuLxhT62b4jJ1kOaassyl0Y6XJXi4viuZIHJsxHl3i+wjiDvIXA5dbiBRnPIuHSD3jp6vgdn3A+BPNYag5xTphglulsZqpxzX3w087GX6g9yZACem1+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448062; c=relaxed/simple;
	bh=ISccELyN+CiIBt2yocH4S+u8ufQSuPb7kHdv1IxZwCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAHRKQlbqRqD+4wvg5M30IpyM7m2LyolosYZN0nKpX/fdHRaIiIRUFRmq3U4gnmNVlRouW06belgO4zov88/cRpT29184FtcTRW+HJbQQsZleMQaKLPi535DI/IebxHqtA+UPmHWQ7fx4G7Qr65+p9pVWhdE8/BxVC3RNwkVgis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oG9az23n; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516de78c4dcso479271cf.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779448060; cv=none;
        d=google.com; s=arc-20240605;
        b=gchhuHVKydbzs8HwwpVu+7NAw0Pg12TmkDiR0J3UQl2+2Dc1lp/pX+BzdtS9f969V8
         TtWqu7Cq81bQ0sE9SzgDcBE0VQM0DL5ZsokgA469hJLl5nGhgF/yVH5Cl2351O3Z9PIH
         JzpNn9mG0bEMSY4R5nXRAj9m+WjubmVqdFirtthl10fkR3q/qsLvpY8MaAFeW+Zpn7Qo
         5elA3tAI/j5PrBZhRZfAEQyuOIAOWH7gSjj+lJTC0q0kG/1gPUgozRwH+swZo0dygMRj
         3DlIZWj77H81s5G0kPG67qF7VLV/STgkhCJBsE2edaIIKaNwLBxlQcZ5xXOPAvC5mqSt
         edpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ISccELyN+CiIBt2yocH4S+u8ufQSuPb7kHdv1IxZwCs=;
        fh=atb46cutFRHtWdvhfIC1sP8xrrRj8CuXVolt3fS4riI=;
        b=OqsePZ57a/Lh4tFuFqjcnPdt76vun37qB+SBYDOXPKeD0FcZL07YDbwt+eAQkk/Z97
         GwBpjOntwFBg1Z2c3uSjy0INJwmn1xFUWYc1admAFiAbTmA2VmvnwZohgDP+23/PCkFw
         DKm8lJ/OENRUo4aJocuF0nI1AGu5HjpJm/AWCh4d44H8yu8HXtTUCevgSmAih5eCPNX9
         3GqNQ0/CAWAnqyDCFnBvCnDw+AkXRrKeFV8oN4EfEnqYga4ejk+NaJzsFYg6k8yaWqyy
         S7oe5SZ6QoiVmhU68YO0SR6IbFc9Iuvj+kMlC4X6SeRlsoEcNd9YcS0WStv/cxzY0qY9
         dsmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779448060; x=1780052860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISccELyN+CiIBt2yocH4S+u8ufQSuPb7kHdv1IxZwCs=;
        b=oG9az23nCRbdr6htf2pGPtu5WwNd7Fs8/SvjLYKkiuinADBoz1PxIk4wWJPn5ryTcO
         0CWPK8sSsLHCOGF8rXDoXP/LubPH7tGDgxglA9sN38DeqJBf/H4AGwCYZE0xWuy/4Ymv
         AOVR5XMHkUHMENULnKTr2f48b8AX5agHIFgHdS08XYiK0wAvyyyM8zBpJQO//LXu2sAD
         6l9JW/KJ0058xWrA7CZ8h3fH0dn85fT9SGzGo6wtzAoyWWOXN/rpxU5Ks9u8u66S+Z55
         K+PojyXrx9NOfyjhXSmD8/Hry5TMpLYekYdZGn0u95uB/n0MTZ6MhUIyebOS/4XpHqR5
         za4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779448060; x=1780052860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISccELyN+CiIBt2yocH4S+u8ufQSuPb7kHdv1IxZwCs=;
        b=sByUqtfPRXyif+sDXg7C8JY4eXjNdgb8sIGQdA9UY3+0Gkr1DDOyMhiVYXpvKe+jDY
         dM03bl88xI7m26/v9s5w54ISmqag6zbcwgngigFpTRQABJhVzUxVsi8QB4cVqmzRN2vQ
         N1cAc7rdnl7pTZAG3Tnioi813vPl6mYxDVU0uWn8B9r0La21Fkf0x0ZYSK6nrSmsWikI
         EL/ySkPmV2IhULnj/mP1+Ad2AML1PF+he0u+EnQa2nj/bCWHNWw5XH0zZyRy4n8QtPJQ
         Q8ZmfgdyMsvUZs5SbhBt3DAKICXivQHbVjE3vQBJKxL1o6x5GZv+dMBSyLS/HCk1f544
         esKA==
X-Forwarded-Encrypted: i=1; AFNElJ/iQoYJbcKmt91qRecNuHPlKvYNeGS/GaT+xQ5THmSYB5/gwehtv/NLKLJDo+gQ0k0L05RCLeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztaOr/84FyCocHLxGjZT8HtujUO11nN9Erz1aZ9HmFcWnYw2D0
	5ZUoxjgI/+x43inpSZAOXAS9KZdVQtpnwHT1/qk/KHe1V8h+niSWSbHAlh/HZOkzzLL8uoOyMYp
	qfclRCCdE2ZOvfVNP3azSg6IXQtcDFgxIYqubrhY+yDetzHqTJ3FipbTH
X-Gm-Gg: Acq92OEdCfiLCMoyI8RNyVIKB/HVkGEZsp1M21TJda/KQGLoqkcA/6+THFDzRrOAVpV
	mkbtFyzMEf3xaGgLKXeqLocOhR3yT5WVJgViLF/iqTDXR4xExLiJ6Uy9P3ihE7eNprvJqXsUiT7
	4r61ktTeXsu+wGpT3G71fndDnTB598Z15fIfowoPQt5XRgj2kNTckbxm3uFDoZ2WUi2vDSjhZWw
	UP/P/FwFlajpCb5wKtyF06BjfQnuWldoK9SlZgO2XLUwzczEkt4KNbGsNbUeYSuXUqR0WelIvw1
	vaqHF9J4w2PT7ARKhQsM9LYPwrTisE6ScJWfz6gYIXRcEo6Zp6BNF+ZwgMmcrF4PsyjrEt0xag0
	4RqLC+NsJTIV5e17wlnrZdh8IjbtBvLcvhbI2VmNNLoSByAI52Mw6ng9kO3UyhY9zJbZ5SzDtak
	s=
X-Received: by 2002:a05:622a:8588:b0:50f:de06:45e2 with SMTP id
 d75a77b69052e-516d436f402mr36243591cf.31.1779448059667; Fri, 22 May 2026
 04:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522093906.39764-1-sigefriedhyy@gmail.com> <186b4a77-3e34-4a87-9910-a9c5a756c766@linux.dev>
In-Reply-To: <186b4a77-3e34-4a87-9910-a9c5a756c766@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 May 2026 04:07:26 -0700
X-Gm-Features: AVHnY4K8PL99xLMtfgT-J9gu9m15nU14_N7nAPqr4LEUpCMyV_u979BU9rzQUz8
Message-ID: <CANn89iLbO0Dg_n2EZmg_+8xOveKeg5dtH_Dn8M3=1LGQLjV3cw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv4: igmp: annotate data-races around im->users
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Yuyang Huang <sigefriedhyy@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,nvidia.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290781-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: CD6665B2F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 3:38=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 5/22/26 5:39 PM, Yuyang Huang wrote:
> > /proc/net/igmp walks IPv4 multicast memberships under RCU and
> > prints im->users without holding RTNL, while multicast join and leave
> > paths update the field while holding RTNL. Annotate this intentional
> > lockless snapshot with READ_ONCE() and the matching writers with
> > WRITE_ONCE().
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

