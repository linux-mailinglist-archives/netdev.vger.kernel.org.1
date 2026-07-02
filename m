Return-Path: <netdev+bounces-303957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rKjcIn7bRWqLGAsAu9opvQ
	(envelope-from <netdev+bounces-303957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 048866F342C
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:31:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="s/dRdVA2";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303957-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303957-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBB73035A9E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81131353C;
	Thu,  2 Jul 2026 03:28:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020B311C38
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 03:28:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962889; cv=pass; b=DrSPseoY5wfVSEmtR227NWS2qcSa8Zwzxt2Qcjc83gBUMYuFe3GzPPtjRP8FNGPNpVNuMrX08PQUy8KI0RauiGztrhcqrjrEDZsTKwhi3vVfN+VixlcaPm4szWFy6/LsLvDQL8VWkUEoSsgBzm90Cf92V31Dwte3ewe1igZBCZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962889; c=relaxed/simple;
	bh=6twbAqzHSDVib4XGA6tF0E43wBC2SfvJwJvAtu/WDJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRiV4xx9cboNANWSGetYr7MrRZZDjrmCl7v7nMqzigaVGCWltWRcbzOhWMs6oYv4zuEgBrLRf8PBqnvinPPO+KNuntM56gsi28+DSxUdKPgb61iJxRQojcZP+LUAr6p/syJoqbG69o9Ultae2Ea2dfGFXNJpXS6zD9Txdip5Ouc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/dRdVA2; arc=pass smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ca15944645so11396255ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 20:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782962887; cv=none;
        d=google.com; s=arc-20260327;
        b=Cx6ZRSfwyD6/t+6Do/RnH0AzICx1ujH6i8E1NxDfI/ZOnvCm2IXI/ywcLM4mD8bM5f
         61+Tl0KhsxoIyBuL7baGhuaVyI1K0PF0mcfgKg4AkFAJBC1VXastTHbDYdzSrNv491yM
         tthzCPUOIjVtvz9B4qLRBjEqaYXaY2i9+MV19svMTdO8OxFOYkkZr76s0SofsAUNFpKF
         rNWmcMFuuyW0gDTr4Fwr/od4yfVOl/E5fMGrCAO0dIj9yFDXbYvhwrJyQu7qK/+rr6VO
         j4+2w7LkRzye5ei2BosraAI6jQOhoC+51GX7hZcdA6W8b/AUUm8ArG6A0k0NDe/39j9f
         WbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLmcQCP0CBFMMPDNg/zDhtk9PAcOKILSNB3reqJwEiU=;
        fh=VTeJSuSAufryFAFMqAmK5OyfLnEHN44VDGEnHx8OEfU=;
        b=bR5dxX+1kLqwIlmo4s15XAgZdFtWPpZ5pmfcgvrbPXtzbuN4WhWlDQOkHSHM/Vs8ji
         tAR/yiWcgTuCwuZlKZA8iBpKppQATN0loJ+vRGS3F5Hh43lssXyedlnsj2Go8WWNdkH3
         adgxB2VjNMcZbmER3Fv2zwA1b5XYVWeWodaxsJwpcjV5elNd+xL0sCxVSvdg1c9Xnz9S
         bD2Illo6qg2aut9UUuSpTiDFoyK40/XcdYtDyfq16jQauK2sFOQ4mUx7VZ1imwVl0IMR
         jjCb/N1YDC3us6DL5WhEZtddmbp5tK8SHpGiyAPDAyJ4+8nN0+D3KfEcBNDj8XDomi8W
         M4EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782962887; x=1783567687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLmcQCP0CBFMMPDNg/zDhtk9PAcOKILSNB3reqJwEiU=;
        b=s/dRdVA25jYqnZL9KlNPEPpxFGdAn1KmOLqUd05OHUBYsZwz7pIFLSVVztIaUx6gom
         l58Goh/9SduQCCS8JA5QO/L2cxz/G49iiG8KwFyDQWXdyDR6nHx/CyCP6kv/Tzj8nlNp
         oXOuGqRTwZq+vOLmu3i+uHdQabd6HQTiRMouzKOc0DGcGihNvzMcXXI0eLLUIg/bjtWv
         oeiOQaLfrOwGo9VoBSUZUzIm+PgdbBN9fhJanB5C6+NHbYPY6gaTRKzH49mXZtIrWMex
         Bw3Et5hUtFQHZLrNZELb8HuHhSS4zbZfQmpC2HWYTnDBxPxPGSXGAmjQr2xn7aB+vebM
         Qwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782962887; x=1783567687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLmcQCP0CBFMMPDNg/zDhtk9PAcOKILSNB3reqJwEiU=;
        b=JooY2Wk2IBCOu5OOj3gWbFDY+Ee1ZRomCg3Kb4cmwLtocSedfwAIK3efDn4BxB1Amd
         pTrLQwHOviiCdckoyMhCjRvMVAO3sZ9PoWku5xPrnpXuD5iLWfjGY6EPpgeUe0UogKqa
         yGYB5lype6FAegWyokABiHIgGUv8lmXinsunxYfxNawsQUXiGV0V8lLOLUNeQ7nAp7X8
         DvdrMezht2470vW8SXHiyvyMKKMNYOSpbcHu4MUdruJmEyNDgLY14XWyJU64R2xwm7mi
         b0mhD/ZjcxlbPhPfs/G9nswRNzvPngLj8Pn16ColDJu8RcgM6q2pwwHHWTvTnSGZh8Hd
         aB4Q==
X-Forwarded-Encrypted: i=1; AHgh+RoQbLkLTEj8JLmCu2p0h4FtrkFH3H92iIIoJvC7E44T1Hn1ZFNjx6uaCg/0J5v87J/Bkh8rXfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2ifhp4tCP1/bDZFrAjoUDhmFVptvjIVC7Yofy9wosv1xAIsa
	InYtNXJd/s9/KQ37qItnrvdgkNtJDvy/dP0I/7om7bJh0WxXovZ+RST3i1loM3cxUlRkVnRVU0W
	3mIJvpTezQjJljHFcPsfdC46JF4gqG4i6TzLfI0mg
X-Gm-Gg: AfdE7ckAtS1Ta+MIjgRTFLAsRgMGFSPkP3NjMPP/3w2X3C9BQQFdIlU69N1URsxeQ55
	oKAjfAR4LJyr2Fz+bZE1so84MvQL4X1rU/BA8LPL8C5WhOc0spu9OUZqRao0WQfUzDp9dsNXTDO
	cLakqJ64d2TRl9SR5wluzXYXK5Flwz9rxemdR+Rxl+TXs8JVd3EvCLv9bkWpT3udyJD8n1+1etT
	zHgd94FYAS/qvPiFJY2B6GAJzUNAhZZzYckDnHdJV3hPRv0dAeTbECzaBbkyMFzI6kgnLiAVV95
	sLB9yc6HddjjbAenxsZYPkm8HpqLAGCmX34mprWQpoExBxdGS04OBZ+kQi/oqdnDNYyfuVn57qs
	coP2Lory0OnoMenT1N2+1rFZ8WuKEUSrOCQFxA8AyOw==
X-Received: by 2002:a17:903:2c0f:b0:2ca:12aa:a395 with SMTP id
 d9443c01a7336-2ca7e6a62bamr52821975ad.17.1782962885989; Wed, 01 Jul 2026
 20:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782922354.git.namcao@linutronix.de> <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
In-Reply-To: <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 20:27:54 -0700
X-Gm-Features: AVVi8Cc0CdVhsx__5HGrso2HoD3JAKnt5KjxP05QA2kzwt5BhmMX2QVBhxsy3SY
Message-ID: <CAAVpQUAKESwPnzZAJSsSgR_perYn+S3PbnDAexnWdeGAeGcekw@mail.gmail.com>
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in sendmsg()
To: Nam Cao <namcao@linutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:namcao@linutronix.de,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 048866F342C

On Wed, Jul 1, 2026 at 9:36=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrote=
:
>
> AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collector =
if
> user has too many inflight unix sockets

AND there is a cyclic reference

>. This causes real-time issues, as
> high priority processes who do need to send lots of unix sockets get
> blocked by the garbage collector which runs as workqueue, causing a
> priority inversion scenario.

So the real problem is the process creating cyclic references.

>
> The reason for blocking on garbage collector goes back to 2008, when
> it was reported that "Local/unprivileged users can cause soft lockups
> and take out system processes by triggering the OOM killer":
> https://bugzilla.redhat.com/show_bug.cgi?id=3D470201
>
> The soft lockup was because a process can keep queueing AF_UNIX sockets t=
o
> another process that is exiting. Back in 2008, the garbage collector was
> run synchronously by the exiting process, therefore keep queueing AF_UNIX
> sockets blocks that process from exiting.
>
> The solution to that issue was forcing sendmsg() to wait for ongoing
> garbage collector.
>
> The OOM killer issue was brought up again in 2010:
> https://lore.kernel.org/lkml/AANLkTi=3DQ967xpX0KLMwX-=3D_4_1AKO5wjHEuJ1Tr=
NjCj9@mail.gmail.com/
>
> To resolve that report, beside blocking on the garbage collector, sendmsg=
()
> also schedules the garbage collector if the number of inflight AF_UNIX
> sockets in the system is too high.
>
> Then in 2015, once again, the OOM killer problem was brought up:
> https://lore.kernel.org/lkml/20151228141435.GA13351@1wt.eu/
>
> That time, the issue was resolved by disallowing a user from having more
> inflight AF_UNIX sockets than their RLIMIT_NOFILE. That was done by commi=
t
> 712f4aad406b ("unix: properly account for FDs passed over unix sockets")
> and commit 415e3d3e90ce ("unix: correctly track in-flight fds in sending
> process user_struct").
>
> Now, sendmsg() does not have to block on the garbage collector anymore,
> because:
>
>   - The OOM killer issue has already been addressed by checking
>     RLIMIT_NOFILE.
>
>   - The soft lockup issue is no longer relevant, because the garbage
>     collector now runs asynchronously since commit d9f21b361333 ("af_unix=
:
>     Try to run GC async.")

I don't think the latter is resolved.  Without blocking insane
users, they can keep pushing sockets to the kernel work,
which could be soft-lockup'd.


>
> Therefore, remove that to prevent priority inversion. Running all the
> reproducers from the mentioned bug reports after this patch, no problem i=
s
> observed.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  net/unix/garbage.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e2526..f180c59b3da9 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>         if (!fpl->edges)
>                 goto err;
>
> -       unix_schedule_gc(fpl->user);
> -
>         return 0;
>
>  err:
> --
> 2.47.3
>

