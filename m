Return-Path: <netdev+bounces-302564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kDbFG4ZOQmoK4gkAu9opvQ
	(envelope-from <netdev+bounces-302564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:52:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19C6D9120
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:52:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HHPbbuv7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302564-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F493016520
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E576352C52;
	Mon, 29 Jun 2026 10:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A136215E
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:52:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730322; cv=pass; b=Q+wOBmVAbp37/es3oNSgDrY/NMpTXNi1xdTCFE0W1a8OpiYDdXisqxmNCbFhauto7ZvrZ1VDe16Z2zVHWuC+qtYAXBNohNpXCsqA5Y5xBVPNNizoYcMikFylRg8AcyerdLY4IXAjw8AINM0xB5VeRdu6a4WLS94GqhQJFUV2AgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730322; c=relaxed/simple;
	bh=a+9Ci904vYVDmRk5KhmJjWn1Uo6x512DECDzE+yXLeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJfi6yeO79iwcxUMy5zOlfqIhksvoTWfApja7bUILBBXNPSH+7zPW51g0g7lc1T4hLZ20tm+RAeGTsEcNhW9ayRkkzTNU2w7F5QaJtUWVbi8J+a/somRY2WMvvvu6fbbwoXZQ9viv4HBvmBiydlbMQd1iY9yJfpQtec+37nZ23U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHPbbuv7; arc=pass smtp.client-ip=209.85.218.66
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-c127813835aso47213366b.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 03:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782730319; cv=none;
        d=google.com; s=arc-20260327;
        b=HkVdGHtZ/f08T7fCKpAJKZRV2s/4uSb7yW0V4SEQgFieHj9eLpJ1p0/Ys4UmAROMNi
         hck/0oF39+cEJG5vw/0MF32DFw3kK37bOFJ44jkP1WqjO6Z/D8jCIgA3urTjEyfj8vhu
         DlMpOBESeN/G35ks7gWJt6RBTuZompM2kqI/7jwhMeCoAanIVRxjL8hcJyuwsfh5V99e
         OM7ITN334iwYC0xsHZem5YsfcgN9ZvVrEAOd0+ZVVltQ61rQncSAvHczbZpKclxhZCbz
         XrHxtO/hXw0Aixz/f0gQCQg7/QPwbCWw5DDBQI7QXa/U+nOHu+l1LugbaTiAcdn1lTyG
         yXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Mg8UEegHbEdTu+VPB2awrbgQQKUf5awSgB2yQxFIug=;
        fh=WfG9W83XX7nQKa+URLI+J9aVA+X2JnggliphQZQt7GA=;
        b=ijuuIjljPWo4ojw7vo6nsdSur2PYU4tPDMCiYjktCkBfXXBnNqlRGASRd3yvArr6k0
         vHnee+OcFGvpCvKd5FIMOx5T6d/kTc0To1jmeAlQgJzkH6Lv7fgMKaxE4ks96WUWOze/
         7KmQTnm3LToiYinzFIhgEq27agUxQ7TrPVBhtuZEU5TYwJvNB4pYSZRsD21KZrzyzJtt
         jY0gZr3vGFSTuNhXBM8O9T8/9x4vHlh1FEqmLrQcxXVRZk5giuNJ4bFhH2dOUzcjCmgJ
         zMyFJCziWTjgnloTv/np5Zi57fJsDa74sT7XUPbwlVKoNVxLf6Y8WUwA2MrJE12saLRe
         O/mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782730319; x=1783335119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mg8UEegHbEdTu+VPB2awrbgQQKUf5awSgB2yQxFIug=;
        b=HHPbbuv7jmzRK/Bb+pwFyjf6DnJFfk4gO8zRoK5saN21dulIJViCmGsaxjfm9k+iP7
         6/+mDUOnrEVsrRVyHkYs+ntdpjiSyj1x/HG/+JonHO36pYfjjIOu5/lU1lif718g3hgr
         oRakP5XJ3LM3HKlj61pfM6s4XYrof7l0daeaGf0bF+XdrLl1wmPBw14OcreBsEpBiahK
         lEeDWLp/dEjin7lXCizh+urrzY9QRnHw+6yIAYEweFz9oqkb+MymZHRdxOcXyVnJlZSq
         BO1XfmUaSDP2sovLPln1M58a+Nakwy52ij1iaQNiuK9yRy8YXgFY26wN4t6lKSLwgVZK
         botA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730319; x=1783335119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Mg8UEegHbEdTu+VPB2awrbgQQKUf5awSgB2yQxFIug=;
        b=jj3DRD26O2giHIRouWygTSZ1p2+972THI2dYcIhZE4K59XhZte5/HK9ji0l19/Yrb/
         caQQql0RFdyHOff644NvVCDtAiPwE84e1ZZbdFMde9t+mmrk6Bi29g3XQLSs8xTbxtkq
         V9kc8+zPfeKyFxZQZDMZUdHbJGpTgA7Dqk4SULWarvGASLGnSXWr2J+2SBz3DrnYZsQ2
         G8HJDxoyfuY7ZV59iL25v5A5vOyJ8Mn/qq0RuN6PNrrIuAtItI7L1tnSrba/GeaGULcf
         EH52msAsLH8EG2sFDuoZNSzd4KH6BPaKJ43SR3/EDKQqM0O/F6EQ60m0LKfGszVCGOUW
         Wf2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZA1S3RVuJxIMViMXbl9tns9yFiT8p076rkUDb21Pm5HF4A0aemm78/vPcZQ4n0/rmFiAEcgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPF+e4hDCKp21/PIrj0FGE5XkjTX7PcvPjVvT4S1pG7UiZcAFk
	VFguma6k3vQBhZo9/cf2MerAnQq54uty1+kBVnok8Khal9/A97+63UiW/ei4+EtyZJGPnuOotDx
	mOr+KKFm+W/d/a1MDVMB8EVt5ydyGic4=
X-Gm-Gg: AfdE7clUfJ4ILdPzAPVHN6g8437PCSXLyYhjae9y3P8Fegqm2bGZzPr/aMdbnbbsVJt
	ZTjmuYV/Hqjw+d0gPkmtpCCNABd5pgrJmxgDczJrKG2Tu2qai0j6v1SsqXCAxzSlbtSDqnK/DF1
	Affo1GlSR8718lXXoTmMPWbeWM4GRzpiTbl+VbichXwKykMJHhnFYvEg1+nxqWzde/ZwTTKp53/
	hRf8Vgj5oE5VwLjkD0dSvqwp7TQnxPoI+FRWYDZbnFz6UcQtQdlhAaUe+xvvTcbxtZRCC10
X-Received: by 2002:a17:906:4788:b0:c12:7e29:4ed0 with SMTP id
 a640c23a62f3a-c127e295153mr32135566b.39.1782730319038; Mon, 29 Jun 2026
 03:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782641525.git.roxy520tt@gmail.com> <012fba43272abc560acfc0fa37ae22182a60b457.1782641525.git.roxy520tt@gmail.com>
 <CANn89i+sq29-PbxDrCdUJk405Bs0759wXLBNhpGqE7TNTEPraQ@mail.gmail.com>
In-Reply-To: <CANn89i+sq29-PbxDrCdUJk405Bs0759wXLBNhpGqE7TNTEPraQ@mail.gmail.com>
From: tt roxy <roxy520tt@gmail.com>
Date: Mon, 29 Jun 2026 18:51:47 +0800
X-Gm-Features: AVVi8CdNXTCShujoi4xIJpHSDgy83pJPS0h44PHymowFqFsiM_fviE6jYC4AQEY
Message-ID: <CALMqdkTaQKMdoVP079PBsGb=Mb2RQsjKqnL9NH=qpPW1zu088w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: Require init_net CAP_NET_ADMIN for tcp_child_ehash_entries
To: Eric Dumazet <edumazet@google.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, chia-yu.chang@nokia-bell-labs.com, 
	ij@kernel.org, idosch@nvidia.com, fmancera@suse.de, 
	bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, kuniyu@google.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302564-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:bronzed_45_vested@icloud.com,m:yuuchihsu@gmail.com,m:kuniyu@google.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[roxy520tt@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,davemloft.net,redhat.com,kernel.org,nokia-bell-labs.com,nvidia.com,suse.de,icloud.com,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roxy520tt@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD19C6D9120

On Mon, Jun 29, 2026 at 6:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Jun 28, 2026 at 4:38=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Zhiling Zou <roxy520tt@gmail.com>
> >
> > tcp_child_ehash_entries controls the size of the private TCP establishe=
d
> > hash table allocated for subsequently created child network namespaces.
> > The value is consumed during child netns creation by tcp_set_hashinfo()
> > and passed to inet_pernet_hashinfo_alloc(), which can allocate a large
> > per-netns ehash.
> >
> > The sysctl is writable in each network namespace, and net sysctl
> > permissions allow a task with CAP_NET_ADMIN in the namespace's owning
> > user namespace to write it.  An unprivileged user can therefore create =
a
> > user and network namespace, set tcp_child_ehash_entries to its maximum
> > value, and repeatedly create nested network namespaces to force large
> > kernel allocations and exhaust host memory.
> >
> > Require CAP_NET_ADMIN in the initial user namespace before accepting
> > writes to tcp_child_ehash_entries.  This keeps the tuning knob availabl=
e
> > to the host administrator while preventing unprivileged user namespaces
> > from using it to drive host-wide memory consumption.
>
> I do not think this patch is desirable.
> It breaks nested container use cases.
> A container runtime running inside a container (with namespace-local
> CAP_NET_ADMIN but not global)
> would no longer be able to tune tcp_child_ehash_entries for its own
> nested child namespaces.
>
> inet_pernet_hashinfo_alloc() uses GFP_KERNEL_ACCOUNT for a reason, I
> suggest you start using memcg :)
>
> Keep in mind the sysctl could be set (by root) in init_net for some
> reason, so only memcg will protect against OOM.

Thanks for the review.

Agreed, restricting writes to init_user_ns CAP_NET_ADMIN is too broad and
would break nested container use cases. We will drop this approach.

We will re-check the memcg accounting/fallback behavior for the per-netns
ehash allocation and prepare a different fix if there is still a path to
host-wide OOM outside the intended memcg limits.

