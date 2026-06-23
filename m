Return-Path: <netdev+bounces-301480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j+p+FzPuOmqvLwgAu9opvQ
	(envelope-from <netdev+bounces-301480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE776BA0C9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:36:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WsFyaCZ5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301480-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BF793001FBE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A03A6417;
	Tue, 23 Jun 2026 20:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B903A6B9C
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:35:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246949; cv=pass; b=n9vmOUPVfFiX4FIJYzd0JkPWiieO+fv33zFveuVLglxxYc8GMmQlsmnUmmzY/uW1Cx9kQb0SPqP3blgh0d9sdnHmPLyvBJMY4UpQjPR89Jnc4REdIYbBMFV/DvPkPsT/kyvis+UKT8gMCR99Pv2ISFLq5qzXOAN3dBO8BWr3UCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246949; c=relaxed/simple;
	bh=fChRvqUXSdrnnUYyDKdYwnA/1xCOK+cmyFDdFCfRBVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ9HtseuRUMCYEWiWavjoknBdTlpD3oh42Ii3AMeY+Rqzxtmp1huEIDXBBnu6Mh6DiEmVB3qhybePqR0C/AyCs67dJJJGqwX4PyY43kwQOg7MxJGaPygXd3bpUoPGblSzhnPR4RU89c/41DRkwdoYPPELZhxe62C3HiPKyUq38c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsFyaCZ5; arc=pass smtp.client-ip=74.125.82.172
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30b6dad2382so506728eec.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782246947; cv=none;
        d=google.com; s=arc-20240605;
        b=h/ZRLRASPB6yr9Jfsjho78EsCxVeN5vgwmwA5/3541HruP2PkAairNnfwck6YA4UP4
         9VOsrumsQN0FOvW8bFvN+awdaG5uMhymptKsh+bHUVG71sBT/hcmnf6WGUacRS/znS/F
         MZFmpWozxO96P7O/GZituJvIlPHnIKtxzkOQW8xJfpDzq/oNSOR2z0F8lonVq+xbXChg
         u4nxT3DLDDxvK2+uWYPvdrA0YmqCDbr4J7CUGScUhhSfF/3JLK1SiBrYST2YCFi7sV7z
         9w2H4XAHHFrf4EgTAGFawrHuyJr/3tc96ueRGEqAmfsJpHAx/wH2mp4jJfuchSyErRMu
         vqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yKSrX60yPZ/UJYHBsPnK+VY11CRo9DVNo1zZHyDIDzA=;
        fh=59hglCpyN6tWy+rFyEGj2sHQhLMm24WCWZwB2ny7mzY=;
        b=dsDfkAk1wgquGRxebPmTw85oTxclIpjaLVcBZJaRoHGn7ybD9+5yxVvFQdeb2gUcBF
         9cBnMY8yPD8ywikEUDosSmliq2+yjNs2SYR1AD+qvV3ibUtjAP71E2aCV+6YlEYJssP1
         w3/i6KevZbXkzH1Akvs37+VeQWef2DJoyme6dWtMDOgTWDl/ouAb0msnVZY6p7Ulw5Ek
         t5IClJjAnMChMs5ox7c3+YwWo8LiyJMHaXv4AalhxIdhvjmE+24YylwkelZoVGg3kRwV
         vWKMSOBYRq6MqX6dnNhP9oF8glBXGQpLOR2B8DRhJrIQdiUjqMdf9hqZZcaqYCqJyUPN
         6Edw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246947; x=1782851747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKSrX60yPZ/UJYHBsPnK+VY11CRo9DVNo1zZHyDIDzA=;
        b=WsFyaCZ5JjEh/RKO9QiYSO6NSIA/vmEyst9Z50sU48UU5RVRMC35L48HbIcyWDSwHh
         YTOEDPqtkpbBxVSPuKCY7wevvl7RDxd8F+5MywiW/RWLkS97FQEY9PzO55qN9IvLK/wR
         ZAypZNds1K/aHclbg+w8my+bnmoPHcThm4r8qOpTbfkPzKNvFOIMRQTMxMQcyVrXmU+k
         2+QI384YErQqeXGUnItgjtCT9PTwgX9GJv2kkjQdJk0XZDYC93f+2lmnWhdh9jCt8l4C
         L1JF2Dx7wEUibBizJNdjG8RTDyMVs/JN60qdw0EGv6Esrn9t8tk4YvxjHAxbREjXbqjM
         a7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246947; x=1782851747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKSrX60yPZ/UJYHBsPnK+VY11CRo9DVNo1zZHyDIDzA=;
        b=jftwDaO98v7IbVVt23iEKEPMMvhAoZHLOxTge14jIPBSaT7Yhxz2hnqOjjinnLDCjF
         hsN6Ddt5zbiGPUTNsUzG3rGEBdcjL/8eJ8kqoYnNfwF8yNpSRdPQR7dOTofN1AGqWZcI
         rO9lz2c92KM3hc/Z4p++B/2d24knE2iKi4bq+/U6+PGK8d52YcU2HxU5yPxmg0qlpK2V
         xFkx57n+u9Q2wjOOI0DAYROBcPuA24PgAFb6Sa5iM087f3bMCjmbFM5SodntmuOTOTMT
         myhUV+jGWQ0Fx4d1JLsOCQpD94YVlWJL8J7xB40nu5DBp8YM8uF8I+zekv9YBzVmCnK8
         aDgg==
X-Forwarded-Encrypted: i=1; AHgh+RpQhqb5pkMY0WbrhJAr60HzI+0NlSAQbm7WWq/qvhZ6JG42458i0XqvxnnL/SDTy8K+PbQeGDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNv/2kEChQPBvszwgjrEAEcwEt0gqXtAn2GvSzITE4kyu5x9Fb
	cBIWxjFoDMgotXA7HnjWHBLazJ8ukX5i9sHPBhwESncPjMGIXN9rcZOevn+XbrXUCdzbk1W4tal
	kPPoeu6RMSt6saLeuWhNnJyU8nMkAQ0g=
X-Gm-Gg: AfdE7ckIpR1mGePWwor2wF4b0Ed5+uqMKNAu/WwZZtywu36MtzGICkhKnMbYEEH+FsC
	4Z5PuGOwXRgz7bGVhMOlAct6AOlDJi8sh+Vk2Sif27Dm4azM7Jnt+doEkqsJBbXvoCDrqRrnZ26
	XlTElqlhoV5dsRfI/dRLCtoW5Qp9SJsWJNfMbI2mFc+ncQ2zez7G2gsZW5OgfjABcC7WdfLPGlv
	JH1Pf82uYh6xt8sZ3H7lm9Z9/xQ95I+7qywqEw+tI94AsrnM9LbsoLrFFitRYvlyTsIUp3x2knb
	wx+cWNcK5drgGoYfJZS7sIHVu49nznUpql1LjiAGo6z0jhErbfL6Yo8vfmGt8ne8SVqgsKPnLZf
	LPbagGhKuCjIVbVIveX5qzjPOQT4/Gul7O2WYsJx1kW4qdBLoPLnmdg9xkV9/rdyUArpuB/nL
X-Received: by 2002:a05:7300:fd07:b0:2ed:27a3:eae3 with SMTP id
 5a478bee46e88-30c58ca4a4fmr4275018eec.26.1782246947369; Tue, 23 Jun 2026
 13:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622185248.1717846-1-edumazet@google.com> <CAJwJo6Zc7Raz9HkKEARouSnz+FgTi9C5kAA+sa=-5Cg-CLe=MQ@mail.gmail.com>
 <CANn89iJL1sx4Jmb3P4cKiEqP_FmWQ3N1BwfH15LHwhFjUoCYsA@mail.gmail.com>
In-Reply-To: <CANn89iJL1sx4Jmb3P4cKiEqP_FmWQ3N1BwfH15LHwhFjUoCYsA@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 23 Jun 2026 21:35:35 +0100
X-Gm-Features: AVVi8CclQ5CyIh_R2zNZCF02R3yEpJvQ-i57Wm2mlzOtquCnvWXdTcIPNaRtQvA
Message-ID: <CAJwJo6aN9AEUSK2xh=hKhwvgKupaMMPJxjMnVAxOoXYR4GDEJg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: make TCP-AO lookups more predictable
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301480-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FE776BA0C9

On Tue, 23 Jun 2026 at 06:25, Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Jun 22, 2026 at 6:13=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.=
com> wrote:
[..]
> > What do you think?
>
> If intersecting keys are not yet allowed, I think we must return an
> error code at the insertion stage,
> instead of hoping the user will do "the right thing".

That is happenning already: in the new selftest you used different
keyids, so that adds distinct keys and they both may be used/rotated
on the connection (and have to be copied to the established socket).
If you try adding two keys with different prefixes, but matching the
same peer ip (same keyids; available in the same VRFs) =E2=80=93  second
setsockopt() will fail. There are tests for this in
setsockopt-closed.c under duplicate_tests().

Thanks,
             Dmitry

