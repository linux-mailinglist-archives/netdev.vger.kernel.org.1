Return-Path: <netdev+bounces-267633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOFbJxyUtGmBqgAAu9opvQ
	(envelope-from <netdev+bounces-267633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:47:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECD28A872
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29A4130067A0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E56390983;
	Fri, 13 Mar 2026 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="00cfoATj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022837EFF5
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442071; cv=pass; b=fLyPjSVsOeHb3lbzz7Bt1iZtFs3H91s/D8LGbkMH5y18beasJtsP2Ef7JD7q8fKllsgvv1W12LYGqiXLvPSfMnQt8W0ve1RQPRnlDXWKXlNRQckSKsuMikM4Cez7RSa7alygbhYeJqdp0tV8qIB4ubA+rBuckXZfcatRKDYJcCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442071; c=relaxed/simple;
	bh=iCSBklJLNRBEAxK9/vsLLfhJTZgqFE0l3yVrFv6SorE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlvTmfVc2SVsxZ9rU/aRhwXHwTa4H0+SoQPd3XfHUypxjhmAGOxyJyYPboYCyRvPpUMmeGhMQBetVoIaTo6lxbo+Ui/brqs057RfoiUBJXV8B8D2l/UdDEDKAI+0Imeen1wUCQ4XwQTQClRVmIQk4Q0NtyiXoYi/qoO0dLvijGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=00cfoATj; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7982c3b7dfcso28670087b3.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773442069; cv=none;
        d=google.com; s=arc-20240605;
        b=Esf0EmohW/L0z7aRiyrqmJWQPBIDszMbfaYr6rIEYbm8zu5dVNtDxRttyzeWVRMz6s
         TEhj4WcpgzDE1qJNQlas/s3p/g+NrZQ7Hre1D/rqicknUJxXxzxzwmkcTVCNlgf73NJn
         xThKkiS2tiEpTQVUCP9WKdSjyhVEq3pSH4J356FfQ7E54sh+s5XK/jh1+uGRG7seIheJ
         Vl51pLQgSCp/V83GWNjwQDEjbcQtSFdTuem4QNh+OYsfHyQWImFjjzhmGFgM754zbqwf
         uq9mC40mkCrKoYi2mzWziXdakWxfVa7rF9YljnpG1s+N8QbTWyuHGg/GQV8hxOul4C5r
         Rhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eZQsQJ+6V+rDM7pSao3xpm8qiuhPrxT8s015C5LvlZ8=;
        fh=ujS00s+787Xh6e7zsBA7MQAOeUcpBVpSnXtdyfI4QOU=;
        b=k9DokTUxwYb6NU+SOFSpTys2giGHIZVTvTua/r6Wyx3fBNbeOnusE2nG0Kbe9xyYlK
         rC8LnoBSJb2AUF+SqENZDfUthkE7C0p2jhtRt5+Hn9mwNYx6SBKDIuUbruuhEhK2WgQO
         h1M1y4LW7J94Xs9uTk/k0KUDdYHlY8ysaBuxJpYZ/PPrA7usTdi9bXToe88egsWPxR6d
         9W5u8OM7buQy0dY+8sUes6F1jmCZlcAnLN8d3mB+RFeRMmsnhjN6JxYqNfNguNjoHbEj
         H8RcGsf/ZIpIpjw+AmDyNmHRRpALWh+HjneN7WTlm0nzVqSRzCEsVF+ySo7N1V1eWhVi
         5fPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773442069; x=1774046869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZQsQJ+6V+rDM7pSao3xpm8qiuhPrxT8s015C5LvlZ8=;
        b=00cfoATjvwWRTahsySPEuKQw+qVHmT6BssPgiN8eJT55Dr8ge6JhFgj50vnX4GMxt+
         XeXkOHbmXrA9yIA9oqjC8YzDUzaktdROMa/AaJo/2fmW5mjKlZYxPIZjfsjJqHtJPlVd
         oeWbQaUURpGUYw6ac1O7P2nV/YW3QrhNKik9raOYYEBGzpNJHViKZ5vVcUS0U047Fe0S
         ymwpxw1tk1bf2+TS0FDdQ2yXUlmVTtbAa3xT3YnNsNkjipuYKl5OHWSnydV8hfC+FhxL
         hzgEVrU9T0HVHu4G4oep+oIYbF2xQhA35uUgsbAbk1Luk7i2J1+E8WyjX5GDz5ZKnguH
         vwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442069; x=1774046869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eZQsQJ+6V+rDM7pSao3xpm8qiuhPrxT8s015C5LvlZ8=;
        b=RhwqmqjLDuezEP9zLvqM7XlTO2o8cJFr6qgoJVbMbVHYAPFy5GOXezF0arcW53ex/u
         1hbK+/NoKndntsKvfxoQO2trSM6xUUC/NRzzA75xxLpcmpksKulAXivV2EbtWVQjWuzq
         YZGb8srdkHz1YhcgB5QATYbm1NFjOxv/aRf+/4a37C1zcwVCd/d32h230kAICWjWPMlY
         L2ycF+CeQiyl89z5pJ7+A647a4Czb1TNCbHmN+XZr0avSTt9sYx+CkEk3v3eurnc+eil
         ngURG/A+iHgYWcckT98aAaLjFojPMDgkQLJRfscr9oJarNtRMtDojRlNJuo1xWv3fj9C
         R66g==
X-Forwarded-Encrypted: i=1; AJvYcCVuwQ9GTir7JiAEKT+HaPWvh42i5x5IeW7Sef+oPafPE4f1+aPnvBOIXmwRe06u1n9f8fjEdn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsyfdn59hD78O05fXd/saxmTt4z5ZFQRAIFmY2qM6SRnPEbiS
	e75RolozT6QqrAXXAr6qAYbqOmLsAb4rTh93y8/15QPNhjkU67gL5LkvWVpig/gGQuZGd1diWss
	K7bGVel7Dz/C72YKUEFrGMhCuKmZkdmsSNvBP89l4
X-Gm-Gg: ATEYQzxot9l4qf7+UnB4VF7grLq1Sl3FGuQyekCe8Gv21ewVofLKSoEXj1U7xJZJlC5
	EsgeUMFYuZEXE3d5SJfVs6m/hTZBWACpWDgABTXHX6rCHqGLGC7aNODh3823FGNNXO2JebP4wSd
	y/zX7aaljHN9T3c7C2Bi0crBSB7/1yVR6r5M0Na+adXpLFIs4FighfXzaSvpAVY0N4ndenFw2R0
	m76lyZHKYrV1nYXrFT4znPFAT3oS2x8k8xisX0xtNWZjoU67iCdx9+CZZVEQu5t6kxVysAUkDeK
	c7fcosXyNfkCamXrCFVUOYKcI5t3giXc
X-Received: by 2002:a05:690c:c4fa:b0:798:cf7a:4ac8 with SMTP id
 00721157ae682-79a1c20be80mr57725537b3.58.1773442069054; Fri, 13 Mar 2026
 15:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773411667.git.dcaratti@redhat.com> <20260313151113.4b405c8f@kernel.org>
In-Reply-To: <20260313151113.4b405c8f@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 13 Mar 2026 19:47:38 -0300
X-Gm-Features: AaiRm52s-PpLnxs8gi0p2ExmLW11cthnthkoOU-vk_zFSOLwhENfL4qhvBWffqU
Message-ID: <CA+NMeC_UfwGxSH8kVsQ2GGHEWOmUjMCG9wR_czk3NYs732jC_g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] netdevsim: support ETS offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Davide Caratti <dcaratti@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23ECD28A872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 7:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Mar 2026 18:23:55 +0100 Davide Caratti wrote:
> >  - patch 1 moves netdevsim tc offloads to a dedicated file
> >  - patch 2 enables ETS offload on netdevsim
> >  - patch 3 is a tdc test for ets offload on netdevsim
>
> Looks like this is failing in TC CI
> Is it possible that the system / container doesn't have ethtool
> installed?  Adding Victor
>
> I'll drop this from PW for now LMK if it's a TDC thing I'll restore
> it once fixed.

Yes, sorry - I sent an email earlier, but just realised I forgot to cc
the list. It seems to be a TDC issue, not just the lack of ethtool,
but possibly other problems as well. I will ping you once this is
resolved.

cheers,
Victor

