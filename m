Return-Path: <netdev+bounces-290794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHuMJwZEEGrpVQYAu9opvQ
	(envelope-from <netdev+bounces-290794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:54:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D05B34CF
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF4130557F6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AFC3EDE62;
	Fri, 22 May 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="qRA2owQE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97753BB106
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450470; cv=pass; b=hwib9WcvCsb2L/8ERBb50fmjknGb6EBNlthMv+kR7VSadSjm2VCsQvp6upbSblHHNL3jar2nAsotzAiSAKwbrqJRaflwRdIVDoNL4rziadIs5L1ee0Q/fB+eurkaoyQ8gQkU3qWZpFoBWNnzYn34mNCmZid8DhII9C2zZbg8eHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450470; c=relaxed/simple;
	bh=DtP/eVOYRs3T8YSkm53eLvweRsIOUgAQV1RjxbgdAVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK16NsQjpGdBT2ALQfJECSsQ9IpTgf5cclYYzOChGxWoA7lFl3C20EkoMkDvYs184HKxcKiI6is3pW8U7YiFcXXvzORtktVK3Pc1EGkEoQsvIQ+lxebxnovNySsbNuSxbdrbzqztxI2SHolLLIwIS9QeJMkVqME2/R2Yz6YwnRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=qRA2owQE; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3314702b3a.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779450466; cv=none;
        d=google.com; s=arc-20240605;
        b=iFdzoyi33+mruZrBho12wp79m/JQt1uR9rZ8a+swy3H7DwGO6/doSoCPgd6A31CSHs
         9VXRauRD8NM8JyPBBBAjqOwO3e9v+9KMtxn45EavGcxjZ8is47PQRolXeXKmDbaZSb+P
         DA7e6Ba5nWRjayWX/E9/ng3hoIzY6/S9BYDsd1tHgqqQpUmxuZyNV6pPZcByW1Oq3oYG
         lgtvj3PcXV10USRDIYHmiAXk3fh08jK0OPtU7Ok5JCQMWUhBKFGqmMIGi7WiJyYBTwcK
         Eyq9tPyL3HiBwLSY/EvmOwH6gLFM6BujwNNJUOn6rOeNHfcmRdpQAAu3Mkk8fSSbAUBv
         fEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DtP/eVOYRs3T8YSkm53eLvweRsIOUgAQV1RjxbgdAVU=;
        fh=eSNXtOUuQJaQwksT3m7zj+cIKPrAP/ZV2HQfNTeTwmY=;
        b=UaT4i16+xf3vzBEN2b4Nj2TbBSHIazn1h5afVKzUh6NFBofEfv7tHt/GpEiZb2Qoqw
         FSbTJVFSaT8TEBkc7udZ7Zh04ITx5bkpm/cDlMnAo+lqQBxdHjPPryBkIAPCBNTXxG+q
         D4X6VHSUcXp2PkVsNSBh4hDvGdOxAoLCqPNqPIFUn411Nh2RWJpd90qfUT765G9VASgA
         VlG+OX81c43wdUpylwx+E/fW5gO9O8rq/1fLSKjOIbspAT1TOwfAkgMsxAAN7Gts9RYe
         X8ZfPmvnE0Y802pt/yNQcnBfuAj6PkJxDxgtpARm5Ud2xa9gYkXacnEG/c4Ihv9KFOQ6
         Up0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779450466; x=1780055266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtP/eVOYRs3T8YSkm53eLvweRsIOUgAQV1RjxbgdAVU=;
        b=qRA2owQEdXA0NRBqUiYV1TiGjZg+mMpy9rsGfaxQMZytRcrwLATGhNGh9v/eaixvu2
         4bkMdfxrdEdSbRSaljUmO3S/BloguEbV4Hb5zN1/1CIph42Ti0XOqrHYVEh6kZEOgTm4
         u9TdHFBskXexXqvORu22vyrMkjp49V6HxJ3HC4FDd8ZZGyMeUjE0crhy2aA4NVoVUZZf
         rSq6K41qHdvgRqWHFgE0Up9GFlYTGHcRWIf32weiiXEblhpQHaXk4JvlnVsMISMG0EJp
         9Q5w5Zisaz7nTOHasOFtuDN9rv2bPDo5ROA6nwPrzDsRUytJ7oG+3HSVr0H+CIfz+6Ct
         Iqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779450466; x=1780055266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DtP/eVOYRs3T8YSkm53eLvweRsIOUgAQV1RjxbgdAVU=;
        b=hhqY02Xmq86qk+5siX8vX5nS9Jmq6oYPC7nymRMNqh9Qwwk/JmDlg7ex3/+u2UmiSp
         AbQ9PKkLpQi5QrgNPJbqFFM1jRS6Gr+WUI4HJx5zEWLhznLpL00KyJsQx+QFd2LmfKrS
         n11upe7RPwODrQB5aAxWZCPRwAH34mb77UICqNyDM9ffLEZnNAWy7ve4zjbBI41/h6tB
         Q1JFBBD473sIgcmN3gRpQbJbkMB7Yt21e7QRo8Hx78ypOxWr2TK6q8D9V2ndsumSPm8h
         rEpoyhnb69SA72efAk8TAwRvCtUa4AHu2bAdcOFOCJMwmyLgwk3wf80sN6s/RmH8ROmB
         k5Iw==
X-Forwarded-Encrypted: i=1; AFNElJ//vZkArlmD7qodKZ5SMyykKCvSUzfz3swrWvOKk4oaxpgw8Gk2f+eWcVySAF9y51ciRPyg8ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtw6SrfkSZhCq+W3ob0LEbJX1TAR5NTm7arr4OxJ3UooF5DgE
	oALAadjtdIGX3LnY/YoGnyvWzc07Bb8r4ow2mF1g7/MlzGrCRfYoL+Mk7gXMN4+SMMM3BNUYl9y
	BoYzXAIcnkQ+2eBj7oYSKsuKoE+zCMaIqiYT1tzie
X-Gm-Gg: Acq92OHXvfMJap6gJ7xFKSRqJtL+zZEInBFK8cPJnuV/7VHNJ0lLVCWuJQNRXZpXHMr
	vSmcRsysUIV4n1cNXJ4p2IDHVlDzU8Iq4N7K7JJBK2LGvc7msNTyFeHsK6Gw9QVVim4WhtDRc2m
	Br4fjmbk79V7Ibr1gbheKLA9p66KBZ3amfy1GYOG+yaD6JffNASzsH+xRZM7UcPj4Xt2A5r8iq/
	U58riiNpQlhVQkhGv5H2Gj7JjR2yqtixXMoxogzyxLaGw5ttySXABCfZlqpb5SdSV2vqhX6Gq9Z
	zlLQIVOt4nooA0gf/Vo=
X-Received: by 2002:a05:6a00:908b:b0:83d:446c:2a8c with SMTP id
 d2e1a72fcca58-8415f406c9amr3421713b3a.25.1779450465990; Fri, 22 May 2026
 04:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org>
In-Reply-To: <20260521084640.683c1ee6@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 22 May 2026 07:47:32 -0400
X-Gm-Features: AVHnY4LU0ZbBpGkUm06N5maS2FO14JX25-hjKB8tLiWM7YD9IkHkDYESxs_1eTY
Message-ID: <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290794-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 026D05B34CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 21 May 2026 11:16:35 -0400 Jamal Hadi Salim wrote:
> > On Thu, May 21, 2026 at 10:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > > To be precise, something like attached (untested, uncompiled)
> > >
> > > Can we not pull the headers? Do you know of anyone modifying payloads
> > > with pedit?
> >
> > not sure - but it is not unreasonable if someone used it for such a cas=
e.
>
> Ack, we'd still support modifying any offset in the packet.
> But not optimize for modifying frags until we know user exists.
>
> > > The concept of "shared frags" is silly IMHO, if I'm checking right on=
ly
> > > rxrpc and xfrm think that it's a thing. I'm hoping to delete that and
> > > reclaim the flag id in net-next...
> >
> > All these issues stem from the shared frags point, but the patchlet i
> > showed is unrelated to SKBFL_SHARED_FRAG, it is more related to
> > cloned+frags.
>
> Right, right. Just pointing it out cause Rajat's patch adds another
> skb_has_shared_frag(). Which we'll then have to delete in net-next :\
>

With a note that the exploits currently take advantage of that
specific cache issue. How about we allow it for net now and then
schedule a follow-up phase to remove it when you get rid of "shared
frags"?

cheers,
jamal

> > If you remove it in net-next - does that necessitate removing all
> > "fixes" that tried to address that issue? It seems like that would be
> > sensible, but it makes me wonder why the shared frags concept exists
> > in the first place.
>
> IDK. We have in the tree plenty of "good ideas that went nowhere"..
> As I said elsewhere IMO having the maintain this flag correctly
> 100% of the time will only create more CVEs, and there's no practical
> reason to optimize for frags not being shared.

