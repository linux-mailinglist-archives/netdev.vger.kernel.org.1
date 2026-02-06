Return-Path: <netdev+bounces-257453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFSjF8BfhWmfAgQAu9opvQ
	(envelope-from <netdev+bounces-257453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:28:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A30F9BBB
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4439B3013A4A
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9C330B31;
	Fri,  6 Feb 2026 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXWJZ27z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500733067A
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348374; cv=pass; b=sN4WBCiQoa5itL0iZ8XcH3u5Kr4fQCB9w6ULnPuIjkk8jRt2m4bDAsqKoLy9EBJVbRUruOUNQl+7TpHQNvVLCm/9+kr1Vxfhp6SWoxoUWhpWbj8EOsd0wirzgKRxEKp851Sddtzzd365IX01bQhAO56V1enYwH7fM4rTDlkVTUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348374; c=relaxed/simple;
	bh=nzyi1NcjbBGTxpUVC/DDARbbFTgX86MBUEkykiCwkzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amt7ci8iD1oHsZoM8RAwoDRLnOo8xQZ/9AqrMq1IteNEiaTSTxvm2TZMZCtC6CekW+BOizcTRIOvZ65Ei+2CApQ3IC1exibkik9m8RHpjp9YBOtbrQQc8g+KjfsW5l58PIHtDXfkXyl0xghvDrtE0zXyotgmgevU+I7WWhRRiz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXWJZ27z; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7961e04355cso911047b3.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 19:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770348373; cv=none;
        d=google.com; s=arc-20240605;
        b=Pe/2Doa+yiB/WEKawM3uO56y+rQrJ4TdL4auSqj0x+vq7jJ2nmNC3GES3+GovIkKKC
         5sAuznh5z0dR8fxjacaoqlSujFcjYVR6REuTOzXurXg8l1KugbsxRhF/rHxZuSk1A4qh
         thm2wK0dh7jlvJq+VyI1LM3SPD35rW/p4JqZWnHDURsIbPWm3YMH2ldvZeUu7xktGlPL
         6LbYhSwjcmNWbCI7COZ8ncrxw7tl043zrORl+TNqsOQ93qtK9Q2CHsXDy/SCRd4yFCOQ
         hmfBq/qRoSnH0k0ieHOIrx+1R9XhUgtRvzdogliyskia5VhBNcQyM/luXAQT1tROGlmU
         rB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nzyi1NcjbBGTxpUVC/DDARbbFTgX86MBUEkykiCwkzk=;
        fh=J9NVjkytd0ZNMG6PO/1UsTgRbEjrNn552HdknnGLMZ0=;
        b=Wp5bWq2ONT95o+8dj6HSERoFH3gVJMtJE90D7LHz6SBOIP9AsnB8sNLL54t/WjQi4d
         q+cr7MrOv1wyMaN/VsityOf85fob26zmK9gbEiGiXgk772f55CcIcvO7VmjVQL3tuV2h
         w4uLgNwhuh9oUMtBkdwbHTuqNxkvSVt0qJyxRqxJetTejlO2lJaH4OGjla6KfomgB2EF
         Arfkq8XJdcIf60CO9TzBzkSqG7NeWHvq2iWuhNeDz+2gF0IPplMuPtMy1TIO/cqkC0g9
         TbZF+jMfliSp+9Jln0X139zZakx4WpKiEYYMmAGEiIRF6OhS8Nu4tibcC4v1zTzy1ywQ
         /zCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770348373; x=1770953173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzyi1NcjbBGTxpUVC/DDARbbFTgX86MBUEkykiCwkzk=;
        b=XXWJZ27zGi17WBr1VqxvCrCxMngEkT5d2fk/+ZafNggDzBsG+zpL3uimJN6ye2YUG1
         Q28ONGTnlbMTRXfBKimO9xUKC+qM+1upSpGOe9tvY+I6Li9p9zsRnzpKX154eKRr4BKK
         re3XXe0wxnvBM9KfJlbys0Ds3y08pJM8BuRinqWgLxnaiLLxtPPM62v3s7/5ifaMJ7Sg
         vjv6fLxEbfi4rY+8S7sFHllKWVoJWEL5j7HMze3SsgSttSE2LyCaO6nHf7gKIZMK+Di3
         sfNNUx5hwshkD+o3/pPhUu1MfxHGdGEgUhEPzJtQtDaMYgGT8R9ogXhXXYPPj1nPrdqf
         +kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770348373; x=1770953173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzyi1NcjbBGTxpUVC/DDARbbFTgX86MBUEkykiCwkzk=;
        b=bh84J4B9ZkKayMTFxx4YDNcEg9s+m7XODwucqIrNHt0psxPtcWhny8oS8G5XylDcIo
         F/wUTqEqzvUbAYTAp2TOHf8w9jDGVIJdIcuuG3Exk6tt09T6CvLJifveLOl0sH7ek117
         cn0Keq7rh5kCbzoMrHzkoyLtim2jbaadxigwFTF20BCew2G+u3EKo7kiVxFNiBeprt5Q
         b6/D4zWgy/vaxnuN8h4RizPIfbazqyZg3tLDm1EqYJ2W4vZsF2ESxwdpnLURsxH3fhiU
         l1dzd7GLcRv6D2LF1GVhgXtCtL1CYNif6PRZerJbaUlBv4inZCyS/CDgsKHbXSIEzDFb
         MKyw==
X-Forwarded-Encrypted: i=1; AJvYcCU/06GN6X+FSRrUv946pI5P+QLdlnYAzg3YipJqiNo576Q0gTahODaZCu3Pb31YsS7Az/cYvqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JV5QEI/4nRvjX1MXwG1j+22Etbvzc6HEtA4lED/zHuVbpSG8
	RmidhyD5pRRnm5rZhglZEuza78FqZJlwmyWCDcrwolYua2CvzzyH4PgGoCR/L3rIxPG6Qk8whI5
	08fq9hbP2G90qL7cLjAnB5Ph7hXqA/+U=
X-Gm-Gg: AZuq6aIWnQNN8uwH3Sswaol+P/paxeylWmln+8iMcShInIF7IgdPFi3gv/JDW0waYsV
	34dXUIW42VXGFznXos661FvINz/BRfL7Zx2H6GF8y/vFyUx8VAse8NN2CsWLFHQNCd0F6lCNs2m
	D7IEjKlvbooVUx1VScFAcg0yMxUFEZgHw9vrHtJaSRwWJSsyYMjXRFUN8BYbBfP/m2bd/10yAII
	wcIrYOFeGI5t0gdRJsiSUpsg95jUttyDz9h6HLlihVRupsSj2l0qvkYT+cihts9DZLco+B3/Ilh
	rDosS9NNXfJ6LZ2zRZ91xcPdeFZeByarlonHuZo=
X-Received: by 2002:a81:b813:0:b0:792:7828:b709 with SMTP id
 00721157ae682-7952aaa0022mr11939057b3.22.1770348373142; Thu, 05 Feb 2026
 19:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202092116.266568-1-dqfext@gmail.com> <b8083480-b34c-4066-99c2-1bf1ebac7004@redhat.com>
In-Reply-To: <b8083480-b34c-4066-99c2-1bf1ebac7004@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 6 Feb 2026 11:26:02 +0800
X-Gm-Features: AZwV_Qj-fFrhjGxKJB2ciWFuDaM_bWlFVc0z83YZxZ3qBWUPXeppadCCcq7a9Sk
Message-ID: <CALW65jab4ViEU_g1nMOwO90dtEEkpQrKE-ypZz8tu9ShNjahtg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ppp: remove ppp->closing check
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257453-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 05A30F9BBB
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 7:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/2/26 10:21 AM, Qingfang Deng wrote:
> > The ppp->closing flag is used to test if an interface is closing down.
> > However, when .ndo_uninit() is called (where ppp->closing is set to 1),
> > dev_close() has already brought down the interface, and
> > synchronize_net() guarantees that no pending TX/RX in the network path
> > can take place. Thus, the check in the network path is unnecessary.
> >
> > For file operations - ppp_read(), ppp_write(), and ppp_poll(), can
> > normally still send or receive skbs. ppp_read() and ppp_poll() are safe
> > because ppp_dev_uninit() sets pf->dead before waking them up, causing
> > both to exit cleanly.
>
> Please report the accurate call sequence that would lead to such syscall
> complete cleanly. Also what if ndo_uninit() happens just after the
> user-space has been woken-up?

ppp_read() and ppp_poll() do not care about ppp->closing so their
behaviours remain unchanged. And since ppp_file is refcounted there
isn't a UAF issue.

>
> > ppp_write() does not check pf->dead, but
> > ppp_push() verifies that ppp->channels list is not empty before sending=
.
> >
> > Remove the ppp->closing check.
>
> This still feel risky to me and it's not clear which would be the
> goal/gain. It this change performance oriented? If so please included
> actual figures.

For both performance and size, but I don't have the figures yet.

>
> Thanks,
>
> Paolo
>

