Return-Path: <netdev+bounces-301640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JoIEHHPSO2r9dggAu9opvQ
	(envelope-from <netdev+bounces-301640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:49:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFDE6BE462
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:49:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IwLDB3RU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301640-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301640-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E30F302633B
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EEF3AD539;
	Wed, 24 Jun 2026 12:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB82D0620
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:48:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305312; cv=pass; b=c+Rn4bs3iUUztUktxYweKUDBZCErdjZpTdna2bG2UMrV79hPOVsGeYSRoBmV0vmQwQSLzqvOFJghv5jD8xA8tntwVPyVAOSnA6n1UmIVX5uFTO5+hUZLCanOhN8VQ6E/Vnw9hLDZc71KroLirZR0CMefTaLu6yKpqp5CKQLOJhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305312; c=relaxed/simple;
	bh=JMAD6+XUSFVh5L/4MxCTaEboZBZhPIL8chJAKyXee+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTvRoklOF+N3MioyBrVQs152bGy5NTaTc6rZlHkYSIyn0OaX/dXNRnn1xjkJwKe58EdUiqAPo2v+l2cBjkkMFAv5TpEMB1SoRgYDNygT++sN0utN9IOzX/zD3rsK6Zi0XHZcPkfVzvptBNzSQhKb6SMj65kjoHwP9h68CHGG1os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwLDB3RU; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-519ff1c8b8bso9612781cf.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782305310; cv=none;
        d=google.com; s=arc-20240605;
        b=PbRvJg7DM35+Uy6PWBuj0paW2sh5qJdgZLgs9nHeKSwoHm1zQt3+Qf+V9AK/8LROqm
         b02DiUeb6hlKswBmm0hAbLq5sKi0TjcCPbeCWx40Ftq2XFZcPCF7qBx0KSNheODWos66
         8FPDgbJn5nXoBuOecFScSXU/jRfNcydACYRF/j13YFMe0bQRR4Et2ug7uF5tAyo+WkM+
         91usre0cxXJ1tQuRaQTTwEsdC1fntcUJrPJ5NkeLL+ITimonA+/ytlGl2YlS2K7xwgTC
         XZa/aRxR88hx9Rujpr2ihyGY/i8rgsaPFNEHF/zItvxMkdFaYEhnJPayqAwJqgpc8KHD
         nDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JMAD6+XUSFVh5L/4MxCTaEboZBZhPIL8chJAKyXee+U=;
        fh=bhGSj+GpkWJS+sJgFgxRmC+oXEu6iZkpW/VMBZHB7u0=;
        b=DpttwkEkDC/LyQZmTLtcC4FHl4HfYR76CUTY9r7GkiSLtw3fLOxPloNuYcobET5nGb
         YcN/Z2ljZ9dxIVVdsazRoSDoKQaeJTsxxj6ySD52vWxnddyvPmGJ/m2eYrLdwT//Fwo+
         AnqaHtHO5RlY6G2vP5ge4+mxKGBS9zFj98Pp82TryvCs8ftMIHtedo3ZtVy+Hl24RKdu
         /yas+4BFQdILoSTTu3WNur2a0zs/I6tixQlELDW9Vlbq1NzTYvOwMct8H0f9UykGTRNV
         1MjTt1kyJOnGQo2OGuiTiagnjoBM2s9KKz4u0o3rU8X8qBbbYoAcG61+2jLP/obxL4WG
         Tpuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782305310; x=1782910110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMAD6+XUSFVh5L/4MxCTaEboZBZhPIL8chJAKyXee+U=;
        b=IwLDB3RUZO5cBpWLpGkgWZxYSST5PWtskHo2i7/6akbJsOzXX3sTcIUGBB+nN5i8Hp
         gxVWg1KY5QPLgQPUl2kNboSdFVl0vv7B7Y/ID8SF6I9u1aTcTumib0uuaFsTj5oyxmfw
         z+rtJTWaBXV4SsNJG+VvGy+u8MuN1aM4o58jJqYvpt3WUjQBAqZ4qTOhhh/2hpiHAqpf
         vJFB/Jnb7DrFN3BsKUs+aJdUF8Dj72KC9ZSIcbtjcI+ABk9ZHTTZk2kDYOVhfhDYwGpD
         feIt6gwvMUv32YDwCtp2hVtn3ZW5yRZSSn3thSfz13MdISQFrGIOV6+SjZrYytO+pQUy
         Uvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305310; x=1782910110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMAD6+XUSFVh5L/4MxCTaEboZBZhPIL8chJAKyXee+U=;
        b=p74nYgHNalyUpVallnDX/POoIBhbfbSG7jyHbVgb7fZat4/n5Fz44yheEPaM8G5Kqc
         vXhr5e4QrX9eK9bOp1oKH8tJ7UgpnUDmVaiJ/tE4k9qBi3iuyaBROQUcLsD50LMh3shL
         6mMcXm4waYO93VzhGVJTyHyjVN7ENu56tR5BeY2xRtYv1GkjT8OlNN7FmDSOuemehdv7
         C/FPhLWPLeuJeEJWHZ2PoNu8rSp7WJcHgGNXx8YPoP5FzIKAzK1Xp/o4gRUOyRvVBYCm
         BwBhUuFyALUxH8lExR7CSvU2Ji4mSKMmevhapYXit5wwDqM+1Nh55AOKXwVDuP/R0KLl
         eEAA==
X-Forwarded-Encrypted: i=1; AFNElJ+Jo9iIvdsXpQBf1R1gRcUs6eAEIlh73q+8MNnHA2z5jnjhDfXwa/+HPXbhP4UOSHdo9UtmNrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfHP3ShvSjGmR+Fc3lP1bQfH2Z+Jz0IQs2tU5BcHHw2TIz0sC
	AgoIqk0qmk2giX4o/50EHHkLsHST5IuHj/lnABripvPB2oy84WraC8SX+mWxOjKElJMsXpgTwDC
	QAgswlxElRhIqVTp//y9SMxH0EMZGmjefwmaIzRZF
X-Gm-Gg: AfdE7cnJh3g/dy1Nf4O3qu0tafXT3SX9z4e1kayP7H6Y6qyPmKBITdS7vJnbwoTIuT5
	ZE6t8x8YAOCR1SUANlOvE3u8/OzsSCNb6geXFVWuRItdXp0EBqX2+DFgZf9Op/KYVjlzMk5iZGB
	tE4yVNUKL1yvD3iOdV/SQyjF72DIcF2JoNSAqVNsrm8qT4GXQSXo85KTLVf2Qbq5LsjwjyH0ohK
	dmMs+yXKF68kvGocFUeQ6qFmtm24yQXWbYg7MNXIn6YuzsqUKxzF3VLonbkLG/Ymyd/tE4NFIxY
	qBBPMactkiouPKlf9GlRlzshs/Xn8+e/x+k6feOFFysV0tHYlvex9s6BrZnHIy031Ioo86qrXX/
	NWVJqTv35JQ==
X-Received: by 2002:a05:622a:115:b0:51a:2d61:1f14 with SMTP id
 d75a77b69052e-51a61bb567bmr45938411cf.33.1782305309647; Wed, 24 Jun 2026
 05:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623173030.2925059-1-edumazet@google.com> <20260623173030.2925059-3-edumazet@google.com>
 <GV1P189MB198819360D2D4A319EB2A621C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB198819360D2D4A319EB2A621C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 05:48:17 -0700
X-Gm-Features: AVVi8Cfm6CXyh96yFPF4DMW2wKTTIAraxrjlHGJ3u5-IWetfoErZpqITxZm6es8
Message-ID: <CANn89iJ6NPW5CXGPmjKnbDsGbDb0Ep9DLU53_fji2tbY78H6HQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] tipc: avoid busy looping in tipc_exit_net()
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301640-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:horms@kernel.org,m:kuniyu@google.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,lists.sourceforge.net,vger.kernel.org,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,est.tech:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAFDE6BE462

On Wed, Jun 24, 2026 at 5:07=E2=80=AFAM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>

> It could be nicer if you change to this simple call:
> wait_var_event(&tn->wq_count, !atomic_read(&tn->wq_count));

Given the amount of work we currently have with various AI reports, I
will keep it this way to avoid unnecessary noise.

Thank you,

