Return-Path: <netdev+bounces-295714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FL+KC8GBImocZQEAu9opvQ
	(envelope-from <netdev+bounces-295714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5E564634E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:58:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Nb8dQWj5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295714-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DDFE3008D7F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7535472782;
	Fri,  5 Jun 2026 07:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22ED47B423
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:48:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645730; cv=pass; b=ri/ABMI+7iha2/Mx17AhmTsPWxYL0dcOnJnRKzS/hJchWwFl7uNAl38qytY9Vs85wUD8A26bk/MbJa55cCr95yZQtTaEeFeNXETASf+kXtcDcdKsbiyS04Dk6Wyqo/6jbBn7x+dWkduXAGJprP3uyBUndr0OgCH0FzDhagB6f1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645730; c=relaxed/simple;
	bh=8j+Icp8sb6eS4YvdbghVOKY9fl330RKRmJMN6gQjOgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H32BP5S++ET/H8Ueb6MtJzfXYy3ayVtYM6bTxT/TAR8JBDI15q5Pv/L63cFpItXTzaETkaH3bxBdDHphC/xakOXdjW+14GlrZCT01TzSMJwgdSPwuqtXbOH4xc7gds37QAbrOA0Wlo15J9o9d7gIHfsC56AMI9mkaPicXrRc0V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nb8dQWj5; arc=pass smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so1582341e87.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 00:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780645724; cv=none;
        d=google.com; s=arc-20240605;
        b=SOwvxFplWMhTT8BJ642wwn9O8VKlXAZPU26gwTX7kjnbBESG296I5fcnRcCLBqN9ZV
         aGuJrp1zGxIqrsWeK29U49xB4ux1ciQ2A23l206JumXW6O8/8AiRM9tgjQ2arTRpzLuU
         TbEnT8ktShYlNW4R/iTrJFWfyu6QicPVULPa6zLyh9ASIpK//oKbGe0w0UXUCgioD2kH
         Ek68FieKGyiAHd4VZzVqK7mpDlyHsv4gPmohKdOZtHkF/u5MZY+9jDJT7b/dOKTqaFmk
         eZCjMWzO+7ntGvk1XbI1uigC2ghigx8/lSgfwdD6gC4Rx3lTmtOKCSrKwR/+Bz9BFbpd
         kVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jQFtOrahnneD/bkyDw8wE/BTPcqYNFp6Nak0UKya9VU=;
        fh=72Vz8wFuW/r3g0l7AKf7EUgAlQxl9ZwtMfs4BnAx48A=;
        b=b0ewOeukGm6gHDBIbduOoTd/B4GgxU5xI49YPT4fMvbHGmbbZX6gqnEn7ZiNKYDK9D
         lxGaNDF84QEV8+etQuigkasmThaQt1La5sHSfYV85Q7XYht6h6oTuAyTCWwsWu2bGMgP
         hGO03rMyOX8V0ii917IPx4mTvgirvc60mz/oyso8j9KjxizNkdoe90aQL0fjS3Ph9I/J
         2kdW0jI/5Y4n5n014cEnbrOR8MNFvzdS/STZA0NRefG0LDLP8WQ80WXi4cxvQAAFxoHH
         xa0Ax1mog4fFqCB2NW20BAxcRjjfTDdQ/tvGoU/1jM4Y5LRXVQixLWrc5kFtOb77WVVO
         y0ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780645724; x=1781250524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQFtOrahnneD/bkyDw8wE/BTPcqYNFp6Nak0UKya9VU=;
        b=Nb8dQWj5398Q0qyF67qjIwwB/3cUioo7HdhoIFt2XkWfFQqpLV8bMu1ssTjxkMBrYN
         gMbQV5D4KXHmg7+flOL4OfsE7zCkyHQ37V1tA8TTorwzAqv3jQG84nwIReRfgG3Q6YRP
         UJ1rzvF4rExxEvdYio5vzqiT/88Rzmu+9u758Xlne8R0YH0SvIL8CouXwkB0m3H1hQWV
         GoDQsZ6HNoEIwkN6B7StR94IdsaYuK3KCCHeQQuYJTL+oA1Fhp6sBdL/Zp47OfDd3rZm
         9mIG/t+uaBgF3wh8nylVyUwqLfe2lO8AhdEFvvqX/jIx341ckn6aGFINtaOmt65yE43Q
         c2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645724; x=1781250524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQFtOrahnneD/bkyDw8wE/BTPcqYNFp6Nak0UKya9VU=;
        b=WXUra8AFEMh4NcBuAZy+1lG5uwCt0NoNU78FvJxd7bqKwxHdelyLJImkJFnOwRuHN8
         us0OwouFtbdTODaxb4SAvNqT8c7ae1OY6VHND8oUsOe9C6D2SMlP8zilj3NzgArYPh2A
         //7AKj+PZ9ANXLQTyVrsDLr7C7fS5Nqsh++F2kk8/jt7av7AoTpcAj3daeSws8SuktyQ
         IMtSBe3IXDNH/yayiQoXbN/bElokmPMUJqw7HpkUe3mtssRQebr45AVey8UYVjkwxsoO
         ykOdY3yQ4nH77g7CKElIagBn50JwZGFl+aRpNwZDGjRSfeK2vQSYqwnSB0aWH1fowvvE
         rfng==
X-Forwarded-Encrypted: i=1; AFNElJ8UyRnTdxS8LXzpviGTLgLGGHXihfJwyDkW/ZOYKZr9giKc9KWAlmktJ6zI286Ch5YuTUzWrRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn5TgFnQqGqxfMcH6Fp8zPInCsOeNdMBSzEQDw2Qxwq6IEgHBd
	qAepV2AvlNoE8oMbN8KRge4EcwLTFBe7iLWuUcnruW6zhJNrXX9MF7g8cvmaiqNJkTnlOoxO+1u
	u56X6cGjcV2Si2Kyro8q/ESlkM4diXDTWqHg5f0ecHg==
X-Gm-Gg: Acq92OF+O7VyZd3taU5UWs6v5W8xrjB5J2yq2IHPKtLA1Ey4auOFFxY6+vH3l4NDCof
	Dhrhlqgtcetb+JZJbhenn2vdnV+jrBRdF5p4xqKjeVBKokIA89JIuRvkQ2xIHcBJSP3EFy/pxRs
	sVBQ6iMJpblEC4+2fEBQ34ZXlOXt3yJs6fTBt42XNjPJnc7PngRA+c5grFbTJBRB2hcBOGqrHy3
	1WuB1MvnEvF4hH0oER3jtaBdwNZHTquOSdqC6A27dJO0pIdTQzGG2k+0NzSh+e23j2iCVSgTQen
	QIkNBD7mxazYH3tadW9ye9SFbXvwZJD8WYnRQlnaOcagaJ3IVOE=
X-Received: by 2002:a05:6512:2523:b0:5aa:854c:61e8 with SMTP id
 2adb3069b0e04-5aa87bd7921mr758422e87.40.1780645723936; Fri, 05 Jun 2026
 00:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511092846.120141-1-marco.crivellari@suse.com> <20260511092846.120141-2-marco.crivellari@suse.com>
In-Reply-To: <20260511092846.120141-2-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 09:48:33 +0200
X-Gm-Features: AVVi8CeCNaXxzJViaFHzMhO0fpnrVI-OJr9XPkVyccta7hRQi1pQd_D8MH43Wpg
Message-ID: <CAAofZF7xvJ4tjUPk1NeG7fhxa8vXA=KX=QNvPDhg0Yx-rTzqhg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 1/5] ibmvnic: Move long delayed work on system_dfl_long_wq
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haren Myneni <haren@linux.ibm.com>, 
	Rick Lindsley <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:nnac123@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.ibm.com,ellerman.id.au,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:email,suse.com:dkim,suse.com:from_mime,suse.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ellerman.id.au:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB5E564634E

Hi,

On Mon, May 11, 2026 at 11:28=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
>
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
>
> Recently, a new unbound workqueue specific for long running work has
> been added:
>
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound wor=
ks")
>
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
>
> Cc: Haren Myneni <haren@linux.ibm.com>
> Cc: Rick Lindsley <ricklind@linux.ibm.com>
> Cc: Nick Child <nnac123@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs

