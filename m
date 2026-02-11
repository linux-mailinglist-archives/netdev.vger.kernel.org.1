Return-Path: <netdev+bounces-258349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNTfOL3VjGm+tgAAu9opvQ
	(envelope-from <netdev+bounces-258349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:17:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8E1271B0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93272300DDC2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0A34575A;
	Wed, 11 Feb 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9HjkMUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9141F09A5
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837419; cv=pass; b=Ter3RC448AIZrfsA7YnWC/AVE+bs0In9UBbg/QHJdTLp6S5nJRrqvYuYTZ9PpwfKzrn7sVOKYUupRWjj38r7CPxNDcMgcl3L3jiv8BJYqC8ZBIWSBjD5b48dfFE1bPwLbpyqJSMJIr6TRGhSGdfYJUVtnMeXRVb/7vlaYYtYIXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837419; c=relaxed/simple;
	bh=45mez5hlDUAKBwVS6c2aHGC1do6mEeb6KoumVjeqviE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax8ZPFaJB4eVNp0afIC6NjOAVx1zgwx4Fm0CRIBmQkmhhZp3Zg+hzn/0sEgPSMmGPzxXxy7MR0CaSIgH7nuMYb1aaodbgKpuzhiDDdMTORyvbNyGKk/c+ZGzc+dwDlcS5zegWk+nis50VPSqQpCh5XumHwhJFsBz25jntuYt8ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9HjkMUv; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65a18bc4b1dso307617a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 11:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770837417; cv=none;
        d=google.com; s=arc-20240605;
        b=On8vpwhJY3sK0YrC1DmcntJZr/4+Qm2TBg+PbnuMpWzwMq5ny9kzE5GdF3yeioOhJp
         Yw9qz/K6Ervh5toB9gUgUp8ADHe1U2/GxSB78xqReb5WpPoCEZe3jixLUrO2c+RGqetO
         A4+0W+GOIlw2FF/9siFXo90BerqhiuJEUrh4DX/2ZViD/P1zfl6Y9PPgkvLdnh1PbUOP
         cFn/Pak2a8IbqqJR6Sp7QWeK5CShHCvwj9v6upAWe/QrZ1i0+vFJNlT5e+3uEzoZLDmP
         AA+tndCwEmj7voLTg1jmeS+9QJBUWslgk9Lw+vht4ferfrZAe0K+Pfu44yju9DOo+bdx
         2+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUxupB6JouDWitR1jYbu+aHsudwoJXpga/GOXIMicFg=;
        fh=b6NWOIZ9MR8tLfKJi2DYTK2a/kKb4tLID3A90pRJX8U=;
        b=LSMrP0fGkLaMeBg7KG7MMvo0d1iByiKELFALskva9AWpoTvcaFndtD79TYyGGjqrMR
         fANxsy7jr5STVvsB+Eh0rbjQY/A2bSNVBB1qmA9b0XOgbM42aHDjuBm6WNgHRKr3bwbt
         64BQ7HAPw9cHej3qgAe7xmabvrDJTAGCX5gT0Dza5gDIp6f4HyoiHB/RlC8Rc68NoANm
         U3uNoFL/AHa6wiSnNw8CF+asPBripu6N1+biYMtzB4wzH6V4vAEqID+tuB41+FFSdXN6
         TkBxPncojj/u7Rtl2eEijWfOoayj4RM+v9NlYRzDCsr6SDS6Lmn78bgFD5J46pzVLVH/
         Acmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770837417; x=1771442217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUxupB6JouDWitR1jYbu+aHsudwoJXpga/GOXIMicFg=;
        b=i9HjkMUv/GNo6Yv5bFSQ341AvD153Sl/ovFZuHxVwTsiBQXYvRDAT0JdDDWw31e4QH
         /KVlXgsl+PiBS9zJw0GLr/74ioF2utZUnLLBGzqu2M7g5QEOI0iboavH4iEuc9AOi9NZ
         luj/fiD4wcQmn/fXebVioFRK6PP+ELHO3/+uSx9Nx14nI4CjPD98wYuo4CKVLla1anUc
         4g3QeOgjOk6//uJUGJ6aAJ/l3oC0CginF49tVHsGuvLBtxGI2kEZRIO1EQY3zJ6sZD+e
         3OeQCbonG+846oMj3eqoq9uVMD67NHvZecNpXrJ6Ub06EZP5jFbjZkjSwOPh9aMDfK8q
         SytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770837417; x=1771442217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUxupB6JouDWitR1jYbu+aHsudwoJXpga/GOXIMicFg=;
        b=PCx3Isvtak/GqNrf6IYlvPFavVz8p7phLueQap3wHxTlAMNEWgw3nk1tOFRNxPZji7
         OMk+kGwGnjDB13IVhzsjyCqwpnOgANmeasrk30bGGfrdOP3i106SqWF17KJz8/J0RAm9
         Fo+oo6KFd3o5TBI2RDVn5Ik8SLxQLazw5dY3FW7hds7jz8QjIWoM9Jq+izcoEmOncYd8
         orj7bdmqebquDeAbtx5eSaCKIOSeblbVA0kcECwuSIK8FqBMkkxg18DmBXeXF8U4mUpa
         ZT//+WNJWVTzMZuthoFLRsd4eT6138OuDYBjRU80GwMZxjLq1RGxKpiuLNNk5LiYiinW
         RRDA==
X-Forwarded-Encrypted: i=1; AJvYcCVDqvj8BoyftiM3zYVKUoBiNIBCX/7awOfR6FSTf1EKpaa5N9YkXf31yepZpVx/QiOPMA+8qug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+B80ZB/jdlQtbm5Nc+CApKFiLsBTxv+sMvr4h8vNepDKOwoEX
	ov0sQguvz/4v7oEosLnwMoQz+rxSYazSPCjX8e++HSB9eD60QAO2A0HYuk5+d8o+s2LwmDjQtdl
	4JSqV65YGK0JBpCO7Kc61Y6E59RYPnJo=
X-Gm-Gg: AZuq6aLcCA+yjtWAcXdsBTrotkOqAy5cah/r+71BpiB+TYWn/HIoRi5FaE/qTAtTNhx
	Xv3TA/Cn4VZTOG6NxxGDJ2kpVbqRn8yUkzB0BS+IJerLHhHKPeBlRxv8mdA1JJ+w6HehMBDohPR
	lpOLFBO9yFlEliqK85T1AyMGSihTLbb+ozhfutVOVVr3lR+RnG/gsGUiaLBKQvRmue2ZGnF4MN4
	E8uaL+8XPpPcd8Wsf8U3+03z90oZgz+PdF6MvWmwlEXcr7sbamS2fbDZZrh8DS+rHSeHqUIsB3a
	dzAP894=
X-Received: by 2002:a05:6402:268b:b0:64d:4623:8475 with SMTP id
 4fb4d7f45d1cf-65b96dabc28mr114495a12.2.1770837416656; Wed, 11 Feb 2026
 11:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211150022.527956-1-dg573847474@gmail.com> <20260211104600.5fbc5369@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260211104600.5fbc5369@kicinski-fedora-PF5CM1Y0>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Thu, 12 Feb 2026 03:16:44 +0800
X-Gm-Features: AZwV_QiFBoyhEDy-jxaFGdIViqlNh10oId3TYXXst-EGfqO4zRgSAHn8Qy_K-Xc
Message-ID: <CAAo+4rX=7+V+3eyact7n-G0ypU+g1BqjLaS8pmD_FGfMfK8Kfw@mail.gmail.com>
Subject: Re: [PATCH v2] fbnic: close fw_log race between users and teardown
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel-team@meta.com, alexander.duyck@gmail.com, lee@trager.us, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jacob.e.keller@intel.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258349-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[meta.com,gmail.com,trager.us,davemloft.net,google.com,redhat.com,intel.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 48A8E1271B0
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 2:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Feb 2026 15:00:22 +0000 Chengfeng Ye wrote:
> > Fixes a theoretical race on fw_log between the teardown path and fw_log
> > write functions.
> >
> > fw_log is written inside fbnic_fw_log_write() and can be reached from
> > the mailbox handler fbnic_fw_msix_intr(), but fw_log is freed before
> > IRQ/MBX teardown during cleanup, resulting in a potential data race of
> > dereferencing a freed/null variable.
> >
> > Possible Interleaving scenario:
> >   CPU0: fbnic_fw_log_write()
> >           if (fbnic_fw_log_ready())   // true
> >           ... preempt ...
> >   CPU1: fbnic_fw_log_free()
> >           vfree(log->data_start);
> >           log->data_start =3D NULL;
> >   CPU0: continues, walks log->entries or writes to log->data_start
>
> Could you be more specific about the entry points for CPU0 and CPU1?
>
> > The initialization also has an incorrect order problem, as the fw_log
> > is currently allocated after MBX setup during initialization.
> > Fix the problems by adjusting the synchronization order to put
> > initialization in place before the mailbox is enabled, and not cleared
> > until after the mailbox has been disabled.
>
> Since this is a fix please add a Fixes tag pointing to where the buggy
> code was added.
> --
> pw-bot: cr

No problem, with issues resolved in the v3 patch just sent.

Thanks,
Chengfeng

