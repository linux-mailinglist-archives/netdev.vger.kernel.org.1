Return-Path: <netdev+bounces-255028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKkGJ703fGnFLQIAu9opvQ
	(envelope-from <netdev+bounces-255028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:46:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FAB7258
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA05B300D937
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B841286D4B;
	Fri, 30 Jan 2026 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO0Nge2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503019E819
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748411; cv=pass; b=rNv9JES5aCt46ltVVPzRKUd8L88sd5ERa/wHPeHDATp/APf8cbjRL4ty6lwD/BMSCKe9Tf3FKKqm60JbADvussURlGXy180E2PQxmiZvDRrYveCDE5ww/vc/wsEmIk0OVsn9eJs9qk8BUoL+5xAsOKOMDIF8+f4JEv2mHKWA3NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748411; c=relaxed/simple;
	bh=1QJyDJE8/RwVdlpn5wHmp1OKZDbqaPptfo9AX+CnuJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIpgOQGgey/g1o2m7robFRMkEjeHtFG7fewUdcfh68xOLgP+H9z/hQGGcFFuS3J6EE96QgiX6cat6CvZe45VfcKiCMHPDIL20m0D0OhqFilbBBT1VbjjYaT/VLUmTeoPW+LBVQu4gU97/NubDb2oVIdXl/T34ljTg6cOpJtTQhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO0Nge2W; arc=pass smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c52f15c5b3so167976685a.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769748408; cv=none;
        d=google.com; s=arc-20240605;
        b=U63l+3kSQzeL1dZ/uFLHUdFmEsRDHqLivJ5jfnU6Bs6UJjUQHvm5u8pJebGmkEhZ55
         OpB8IEdWgsGWar//XuOnOu3woQs948Hpp7w/8Y4QI6L+4IwD0b2VUsJebOsqtg12qYLx
         zqjX0mvsABZjQv43hCaOvgM6PW1caaRLySyy9LpMi2ZTQMDxDHzzfCmc6YBa4YvA6Xja
         RY+y+unRhRKFR9nbvI9aIsgS8/GC7nDtEIH4yD1tCtA80JbY19HKk61i4XkxbxNEPMTb
         hc+4l3qmGvKPaVRu0L3E+JTFAQ5xODcEdgNG8q469jlt0HTSD2dYY8ZEH1Cw6D3X6ACn
         DiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        fh=sJ6X2OJgzHZ5y76mEawhHtFgQ4aTUhLcnPCJKPSoJPI=;
        b=IoGMd+Zg3D+ZfCVyNUHyRWBMYhg2wBbr8ItnunroepMlcOJjTVctiPKIpH2V+1ZnKr
         Jnx2yXDifIOKtcpBlgY/6SjtA5j6U2cDk4+UJsrRqTx/d1NoFB6rKuQeVa51dPMpO1kP
         jRLU17CAH9Rtp7EXnDCsEhFtzi6uoCuAMN9qQ9Xn8Wr0f/vGkn6QfouHNhw66TE1t5ze
         jYRJ0ejCAt/sggLKSHJVdexDlYlcJAQjhtKS6ZZQffH1LANSvj4LitKp0uBmoIaXHLBN
         EHxSb8C0B1Hejl9amXWWQOHbw2tATo90AyQc9V9w7b5ETAEgx0SJY3Mm58u+DFcv7I5b
         j8MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769748408; x=1770353208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        b=TO0Nge2WHvR77HYLdbsOMvsZjLPth4rVAvBzcl5/LE/VfPhF6ZG/sDqBrTSxqDvx0P
         9f4T42NcuJnT2s+Pw8OibXAYtTHxYlK06iETTPO8jGtw3Cb2dO8z4knHTu8v2bdVctTr
         VIWzRL3sHqqo/Riw0tgALM6ztHGmwvoKzzrMd9o2ZvVfhEMhRqM+QW/L+N3bfBVw6s22
         wrNaJ4TAX5P7kcnbVBdXVN+3estYZ6qfhpvndim3eEoilf3f40sd7JTjppVk+D2Tb3JC
         aQ0ZcG4WY+gEQSiM4LfL+vcwCl4PBpq3IV8RizfKLGZIVk9Jq2H0nDajQ3oHLtiK6XX7
         wswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769748408; x=1770353208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        b=vyNb98SaWjROO4DryPYaRe2hcyp695Ai768qxPuWX3YDRCdRN74SS3i30Yo9QFYD72
         jRqjoDldCwYEDBO8KWwUceZVs4FWcer4ymwouq0ETYBDzeITDEYtfB4l3Yr/nc18ESVg
         4hkIaFvgJ3ap1bU0CXU3a/AruD5cBNIrAydrkEFq95ZYxnai3PLznY+RB4ado07wRzpi
         nQOmhq/AcEkC2x9bMF6hXPz3OzQEVhIQMbMSxrWZD3FZ7TqCF6HgyyvVcjpEAckRiiLS
         kssmnujpEB5yqA1eNbhkLVvJ233VE4SYU9CyYJIqiDbVsE83LkKnoB9+Tez40Oog46Qc
         jXAA==
X-Forwarded-Encrypted: i=1; AJvYcCUJkW60j1Ztl4HDcZMn43Z2mV7VodfhKSvOjLLCjNKbHhQ45kpxi88Ktmf8UtE/qydgJPzE72c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAaxcytHw8Rh9Ua2E5w3cqBv6xmE6NG4zb9oBm5ktkQ3sF4lY9
	MGqo4cO1vomkAgVa8XBKj0c6tY23ntDXK80JaV1PhlywUVSO8tBkmkGISF9lfPXm4N/tPvruMqK
	bezvUX6tGyKmXRo8B/hIqU5cm2uCEVZA=
X-Gm-Gg: AZuq6aLyzvjoLv5yIDxVXncFFGk4m7CU7d7ZJ4QfishIIRwPK/pWtBfKBNZk2shzSFB
	IkhPGKWJcH2l9AwReRd/WVLqxZbsVJPOBVDHZ7vFu2RQervo6e0kpjQZYyhz/1Ix6TSUNBEJOAY
	34zoLBFJwDVlbFSDK+PahdpZYKnLnLR3KzlXDFrQaWrRFfAimHpmimAT1sSSYNlCJrYKa24hxsL
	0xKGhlHIU1d04jnKsAXmGSC+X9BPd/wRm9pik56dXVn5B5VGPC+m28d8W+BqH39X6Xc2dN6R+Ap
	7m0zlZxIIDZSjyPmjVnxfDMb22vh60n9zlbkEKqu1ZLJ4rU2bCYBuevf
X-Received: by 2002:a05:620a:178b:b0:8b1:2853:673f with SMTP id
 af79cd13be357-8c9eb218b95mr231028585a.15.1769748408447; Thu, 29 Jan 2026
 20:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129075200.38060-1-enelsonmoore@gmail.com> <24935907-76b8-4369-a221-f408c9747642@kernel.org>
In-Reply-To: <24935907-76b8-4369-a221-f408c9747642@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 29 Jan 2026 20:46:37 -0800
X-Gm-Features: AZwV_QjXPANZJhFTUmAD_xs-kXsc12oeZYASoSpgH3VuFAFrYtXsvMe2H33A0d4
Message-ID: <CADkSEUiN=5X8XjmVE-SfF1GGQbfxkHPQB=BvCJdHG7jgDBiTew@mail.gmail.com>
Subject: Re: [PATCH] tty: synclink_gt: remove broken driver
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-api@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haren Myneni <haren@linux.ibm.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Simon Horman <horms@kernel.org>, 
	Eric Biggers <ebiggers@google.com>
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
	TAGGED_FROM(0.00)[bounces-255028-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 199FAB7258
X-Rspamd-Action: no action

Hi, Jiri,

Thanks for your feedback.

On Thu, Jan 29, 2026 at 3:41=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
> Have you checked this is not included in any relevant userspace? How?
> Hints: debian code search, github...
The only references in Debian Code Search outside the kernel are in
libexplain (which has a configure test for the presence of this header
and should be fine), lists of files, and lists of ioctls, e.g. in
strace, which do not include the header itself.
The only reference of note on GitHub (although I can't look past the
5th page of results) is in
https://github.com/sunfishcode/linux-raw-sys, which includes every
Linux header as part of its binding generation process, and has
already had to drop other headers as they were removed:
https://github.com/sunfishcode/linux-raw-sys/commit/a804ac01491f63c8ce879ef=
27254d27dfcf89ff2
The package ships a generated version of the bindings, so the header
is not needed by normal users.
If this commit is merged, I will send a pull request to remove
<linux/synclink.h> from the code.
It was also used in old versions of
https://github.com/jerome-pouiller/ioctl but recent versions
automatically generate the list of ioctls on every build.
Is this okay with you, or should I send a new version of the patch
with <linux/synclink.h> retained?

> I would just drop the line, removing one conflicting entry. The letter
> is not going to be dead.
>
> Or is this Dead note some ioctl-number's policy?
It was used in quite a few other entries, so I just followed their example.

> This paragraph actually talks about long removed synclink.c, removed in:
>    a1f714b44e34 tty: Remove redundant synclink driver
Good to know.

Ethan

