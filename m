Return-Path: <netdev+bounces-289411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BwAMbJHDGprdAUAu9opvQ
	(envelope-from <netdev+bounces-289411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:21:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6FA57D726
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A69316327D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168703F4DD3;
	Tue, 19 May 2026 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70461480DF4
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188883; cv=pass; b=bS0DQP30onil3Wz+Mx4bJzBNd0HJOuZw+An5cVclEug348iCImxSUWkCQhKz8fQ1h02XDEZ3NrRMV4R+UT8EOG9kTa2ahVvCdbgm9pKhrPnV0CysfEH1iyt1AXV4SIe0EY/gwHOPqfX5mCq7mv0vOukP3VC/d52QrvnUcroZgyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188883; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n++nOzoGyz+X77yBHlW8Ed338LnseXCMAaKHIDD3Ar2Rf/kDWCxGP15hVx78K/3ILEGm13LNC8nGXJGyOyoDcvLwC50rZf7KR8v+UitmbJxadxArYcuNtspn5KSc0QE3Q99H7I2mhiMtvwWHEvr/CBjIY9N+0SVhsKLor/U2qm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bda3b4318dso271294eec.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=fyzST1m778dmtP42xU5rL17CgtkpS+IWqrFshpLBhaCa5tm+KSUSKEfBAZxvzWMPNv
         usEm8T2aPzcEHzD8uKaPAwvd4T4Yv48YbcuHRDrhQW7lhZBFVR1t9Cwg1MSoa981uBsG
         BeC18WrIA85QXQJl/hgkn9INL92l2+7aXCVpNGXYaS4xGsb76DCrzt4EBxDjkdZVi6wb
         vPXzwMOVIby3ybn1aAkhaYJ2SRpEr3G8WJtVVe/8FOSS0CM3+FD+ez4xZWjOuCZ2qkjF
         4K0MXGa2XeQxeysVmqoAT90rNuzHwnCVKQv2ynPwSiH8xf9mg0OkF3mpK8oqhh08MdFB
         ioTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=GJKUbcKZBOwE0Z8OIG+dgcssoiZz63RrA4g53SPCgKs=;
        b=XXUOeSglRHqoZ96n+yt1PcOwKXZ0SeiXvn2dc5XMnhV5sqfVifnLJm6TzAQBxSxINg
         JCtJoeS9mfdT8eZGmGwJ9tWSs9XSke4kMs9t4rA5hYDVlBtOWmZU5q9N8ypSRSTRb23I
         3Uu950PJt1ojMwr5trk/FUJ392oYyPCuLPuf7m0DOM/m62xZW/Sfu6WA0stUEqUkiWS6
         bX0SM44ao/dT/6CoPANVWKraOzDoAfBOhM5Cm9rD8VAZTDTvm0qwv1OggKI0Sg+CNwlq
         rYvCg0Wdlp6eAb8ZFGKmtlpPVmT8nknYcnjSRR4lqFLIy9sNLj7bEbn6GSr6opULmWPr
         JhdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=qI0T6b6XQyVxfEYd/r2SObZYzkVBq41PiHpVtmX9ebA8M+Due3C9LGCx3/g4C+rwrd
         BJuyI4g7f2lVGQLS0vUexpEKRW0lRFsIU78Aqp7ttAzj9oEcvPwry477T5z1UskmxKCa
         0HH+w/nC+P96rBMmuREtlLJtludetig8GZrXtw5kcywX9p9bJm1Ncfs7NJbElSeUW0sD
         hPJ0cq2jrPdA9mt2qb9ZP/4YvQTsQOljvpX2T3ekfpfQL/BElI/3MQFBDUZ9CtH/bLuK
         Y4fYAc3+EqWqwjrhAJ6ylXNvsRl6EGzwFohvtv17LCOClHVLcjOBzqrLKdHbi6B0o2vM
         5MYg==
X-Forwarded-Encrypted: i=1; AFNElJ99cYVFjB6HATEcq59bW3uMmDDI30dY1FxHtDhMpYtvAe1TewrxVLWDAD1Bie82Oj0/vqc4izk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySPpMrfN9bametxhxow4HF859hrVBvCh0HgI+ynnjlnXtsTU+8
	tbsxlJDMBpyHzz6oskaW4pWYXly8BJq5cFjVMrvnHfGLagJE85UyoWLE7Ya+owfhBAnzRBiZa7A
	uChlE0MqOJKBcYWZI67RJzRb0SMqQO58=
X-Gm-Gg: Acq92OGh0UgPpbtiUy6aQazwpLCucFZKuwOq6sKfxaBU1BBYo7efEla+wg/nlNUDnE2
	N2OF6xSwn4y2/tKeUV0Wu49JpbPuJcaaak1i4lkCYz9UQ95IDT00IiVTI33kt3FTt2a/fgfeYBP
	XKO/+MTkwQqsMxHTMOglfn7qyIAVocCn8WBnPiwUOT4GVp23i4LDkz/yTBDfwN0QkVa2y1z75Bj
	3SBwZWRWEjJcioCKb3v3YeoRhBzj47gJ7psEm5aUgbYLqmcPX2qzEhKGQR84D1N3LIvOE7fTNhv
	OB5BtRMQuY0ttRSmvymPLImeGZgQPvNXySWPpl8uunj9+ugYmBPf+z9XlcSGIaR44ea+0fXX7yW
	kulFtTCYJkYFXJkUw+1R9RR8=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sang-engineering.com,infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens-energy.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6E6FA57D726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel

