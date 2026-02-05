Return-Path: <netdev+bounces-257299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GwFEJ7xhGne6wMAu9opvQ
	(envelope-from <netdev+bounces-257299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8EF6E61
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50C2A302256D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F2327C1C;
	Thu,  5 Feb 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngjppiUe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CF288AD
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320279; cv=pass; b=Dnqw/WrIJR1kgAsqes1NRj9ZNHEZStSK8kViTiGPK8d4pmufRuTYNuEL1YzE/iSZ96SYzTxQBn/2hOuwtrkjnMB7ewq0KMBpon1RtrW6c2kzgXjbDqJj7rdFSk8H6gQPzGZ7Vay/lLe5GX7y/kfsAAmXXxDIXUp0C6kaxLRq4/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320279; c=relaxed/simple;
	bh=sKPzMs6ZiMMSTfcnvFTaywQRGHtQmYcHtLPKvcXf5PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwVPuckJiJ4xLI2zmQIWzO9+8HfM3ch95jv3D7vyAbf4TMp79NdAOCGQEONsUiCpxVdRTSSQTWGTWNA+ZBOJq/xAIKqLrIYIzQAos5IevBFI+GGYLR33v+NJTOXZbjPhbd8/RlL52jeg5bSOsQlj8sjQFsuGMWOivNiBAM7EREY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngjppiUe; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a09d981507so10966145ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 11:37:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770320279; cv=none;
        d=google.com; s=arc-20240605;
        b=Pd5OucvhjgqeuQzuH290gNIuGQoI1iAcsrXrWQggfeUZLeT3q4Xr7tkPsQmWDwstEX
         3gwObTf0Pxm0/k6ePYa534LEcjWwH0zWuv1d0aWU/2+kMFt/cA6vNEWh5cHk3c9soBCB
         ujB4MDeCPuzkRvAm2Wy20GqBTp0ro1GBMn2Pw+4XQSN4abKmz5Igju288OYzMoLTrfnW
         +ymJDdhPuuKe+5QabwSXhLlc6D9vnD5HUcQZgfBTvkuYdy+lAndnWHOY38Q67oPybKgH
         M8Y5mshNsphkPB/pwTcVe7a56juywUr58TBjamxFtMcXE4ZjxHaGZY8DEVVDtt27MBhn
         ww1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dfrsfyhAmd8GwoduMxGfN4+1FY51xPnUMNNk+QbL/6k=;
        fh=b/AoZj8b4K6/lHGvuxMqkOrWnVlGvojjzLYdQXeb2ZA=;
        b=Nx7J2Zf8QWUpbjP2J+Du7+nhGOeOdDu7Ph6/fIJSriwMFuaom6r1vADnUKfW4abbUp
         p9pvnTeId5HlQ70kuP+m6duJyRg1SUV1tSLdqwuMJ3WYPK3yjVORbvr2tFfxpcPglGRT
         O1XggcmK6CPvzr7vlMW13QOXG+3+mhWwKtLW+BQiEqAjrkyK5VR2MP03ukbYsoXd59+N
         Op83aducFNZVsDq910Id/geUJBP7e4by8ruVFlbYXyzrgyBFk0BE6LMFv43Xu7V3QAvO
         L0g2paAk2CU9n1ruGZijqF0vQ2iHoqI7A04pl9nQUfNEMhkWI6QRaGIG4ooND/fMuBxn
         FFfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770320279; x=1770925079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfrsfyhAmd8GwoduMxGfN4+1FY51xPnUMNNk+QbL/6k=;
        b=ngjppiUetb7dvnAURd4dglInQP2ezE7u4purLgANHge+xgPNHEpfakEPQd6isWduED
         1iTvzoudHvqiOipqvHbjkNgelPvVbuBdaknwdcYMuHhw8LoXa6DdSx8V0eeLv+Ag6XN/
         ujcC8alodbswtPqRDyhNNAgjU+Q3XE2koGmiztXUUnlgnyPSwpt9LXUIep0P5wP2EVex
         PTG/SLn+Ov1+559ww0n6UfLjgahoySTY7gNbhyn3mRqmhcVS4Cn7c1u5JBEBhBZMLYhv
         4uceXj6ksYCRnyceWack/n2CSoutSpGX5onx11Eryr9aj0wIhFBoX9ZFpKIHFLVva1w1
         k7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770320279; x=1770925079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfrsfyhAmd8GwoduMxGfN4+1FY51xPnUMNNk+QbL/6k=;
        b=EOF8r1bP/EEnO8wcuoMYfqi8b2CrgNKgv5AD24yZyuAlMRXPr+cD0CRL3Xm9kBNU61
         tw6cynHqsD5NUfyyKEMmyVMa3jV+OiqEuW6M1dP+UsMbC60U7tmK0NwHy7eKN/vu6PRJ
         A9W9fyTrCWNrU4iYWzqhpa2KkFK+qUcxjDlkiZ9VtBKT1an9kHmWg6d9iO0kKnAhGilR
         me8+lA5oTsFZ3pBtazvDEWlbrS5YtmnC4jVFWrgbiF92AEq33Vih7KVEoKg7iaYm8cib
         Mi5Q83aCuY00QuZZm0bCVu2S4MkNwyCjLUw87vY8tpRoxO6mwQdInbdANPItA3bOY06v
         TP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrm9nFUIbvcdyYSjbmuHvJCILc21MhdoqUdPuJJTXGh1qS6vdcBmr7oZKZQ45xpelJKURSZZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYUuosAubmWrR2sv4gO5gquiKYQYzlQsIvwuGi2iEFak73P85
	ZWwqgJPGcybTg4TwJAQSLG+VZMorEvJ8ajdCrALrYFcqpK8vxloqaZ92x85aoBf9y8xZETBguYV
	6C0FGfhSZHjpbJchIBOV6cAFcqUG6f2c=
X-Gm-Gg: AZuq6aLf2StLa8KCh2amjpuAtq6lvPyfDYbEgqyhFhQ7jqnzASmhHu3r5/8tsKI1vSs
	UTugPOv1O1Z7BwIxVBUPoMT7bn8SXMs0+Tc2Q27rTUUc9BQghwtyC8vqZmx4lSsGvehEPwH1W2T
	rrZkPNoyMbQDw7z11aWmn2gK4a6lx5Ww4CflVBGrgR/ezGZsOk7UV0DkcLy3BB3oser+IIu76fw
	UAPpwZpHYOFRt28UsPPOOy5hLbTjxPPN+qni5rO1E4saU39BzTY39ETbT0vlkQ1wqs5ZIvn0dPv
	IVJyyCd7vv74Q+x02mMbQy4V8/Ll
X-Received: by 2002:a17:903:3d0c:b0:2a0:b432:4a6 with SMTP id
 d9443c01a7336-2a951948829mr3889045ad.15.1770320278896; Thu, 05 Feb 2026
 11:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3e81a27cc3e4c03fa8357c2c77b238997e48610.1770042461.git.lucien.xin@gmail.com>
 <20260205115506.2195311-1-horms@kernel.org>
In-Reply-To: <20260205115506.2195311-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 5 Feb 2026 14:37:47 -0500
X-Gm-Features: AZwV_QgKmhAvyahpdZdywI3F6DO1BC_0r2LG19n44OMuBxjTNkYftoQ43Qsj1cY
Message-ID: <CADvbK_eTE-eRDpUQ0bLcJOTyveEYusBSqGZTYBYuujuABvm6jw@mail.gmail.com>
Subject: Re: [net-next,v9,05/15] quic: provide quic.h header files for kernel
 and userspace
To: Simon Horman <horms@kernel.org>
Cc: steved@redhat.com, marcelo.leitner@gmail.com, aahringo@redhat.com, 
	alibuda@linux.alibaba.com, jbaron@akamai.com, hare@suse.de, kuba@kernel.org, 
	tom@talpey.com, linux-cifs@vger.kernel.org, daniel@haxx.se, 
	quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com, 
	dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com, 
	pc@manguebit.com, kernel-tls-handshake@lists.linux.dev, 
	illiliti@protonmail.com, xiyou.wangcong@gmail.com, 
	andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com, 
	pabeni@redhat.com, matttbe@kernel.org, netdev@vger.kernel.org, 
	smfrench@gmail.com, metze@samba.org, mbuhl@openbsd.org, 
	chuck.lever@oracle.com, dreibh@simula.no, davem@davemloft.net, 
	sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257299-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,kernel.org,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E5F8EF6E61
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 6:55=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: provide quic.h header files for kernel and userspace
>
> This commit adds quic.h header files in include/uapi/linux and
> include/linux to provide the necessary definitions for the QUIC
> socket API.
>
> > diff --git a/include/uapi/linux/quic.h b/include/uapi/linux/quic.h
> > --- /dev/null
> > +++ b/include/uapi/linux/quic.h
>
> [ ... ]
>
> > +enum quic_msg_flags {
> > +     /* flags for stream_flags */
> > +     MSG_QUIC_STREAM_NEW             =3D MSG_SYN,
> > +     MSG_QUIC_STREAM_FIN             =3D MSG_FIN,
> > +     MSG_QUIC_STREAM_UNI             =3D MSG_CONFIRM,
> > +     MSG_QUIC_STREAM_DONTWAIT        =3D MSG_WAITFORONE,
> > +     MSG_QUIC_STREAM_SNDBLOCK        =3D MSG_ERRQUEUE,
> > +
> > +     /* extented flags for msg_flags */
>
> This isn't a bug, but there's a typo: "extented" should be "extended".
Cool, I actually asked my local AI to find all typos but got nothing.

Thanks.

