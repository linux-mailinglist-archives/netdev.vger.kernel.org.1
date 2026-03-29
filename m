Return-Path: <netdev+bounces-272949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK2tLsBhyWlXxwUAu9opvQ
	(envelope-from <netdev+bounces-272949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559335353B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58323304740C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C8385520;
	Sun, 29 Mar 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHdMV1L8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B537FF44
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805053; cv=pass; b=fXCF8tU3080L5vhUSNBIg9p4kwO4oQCHWlkGpxrO3dAItjEXL74FAlItOgSuX25k29YO3EAkhKA8Vp3b2Rsa5EmK9lkYDcapQioiNjKPIZQgPmZGAC1CdW1AojIrHweRlL3W3KEiNtgWjNl2kXZ/1eLijMmZ1sCbN7LYQ75WrHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805053; c=relaxed/simple;
	bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBzghZSO7prIpxGuBQyrQ7/SE3U1Uox+RQ3sE1RiAsDlAqco4IarWLJsucx/wK+EXr/kSoGUOFqPCl9bZq+s0VFI+J++lJTYghKQP8eDMAOkTH8NXEJZpo0KNOoRVJNshsByu8ywS9otqRDvxYz62PmLgpYSQjoWu3xaa3EU1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHdMV1L8; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so2465035f8f.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 10:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774805050; cv=none;
        d=google.com; s=arc-20240605;
        b=ZmRBHh/qB1jEiqfgSJz490rp6PS46kNWC1rATUA7sO96RYLpDpbZqg62xk6aUx2Cya
         8UUNZTXWJCiq6ZbWFzgN/EU1ebAb0OJewyUoQElSRYHV0l1znkwOES0GTn3+7/BRqbZ6
         Vmfc8VVhg4ODHP5xSR9tXJKKt7b98GHVI8YRwyzmBjau2lganb0YomKbCx/9glk5cPY7
         n4uAJ6MHlYgsG64LUuvo9/AZ4jxAjPcBlXgzl6CVArfTj2p4TjNPQz1p3faSjw9UyffS
         q6FUxaTiQW1r5i02z9qW6Nh+ANujua29xQZT4vEsWRvEUL1iHii47Tx/jVUr99ETAZXW
         fY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
        fh=mF3j40RKzH5T3mimgHY1w6hn5l6NWfScASyHqUt59gc=;
        b=f5SkRIOiw7JoZtoCfsDhZHHcp5S1oyRPVCWkx9jLN54+Vis8sdyCbBUVI0qa+0uU8D
         wS/TFNXngPEDrLPYv82UfQaMlMNr+PPlb9XlsMtyvIhaf36wPVSpWB9TJIesHFJR6Us7
         fug1J6B9+8LcM77Hvc1bgx5XIFeRzFQc75zRnAVCA9Qi34PhEGOB5JuglrKKDUsiutTd
         XlzJuTK12/qptb8S5+uBpAgv9E82WqY5hr93rYuPnfoi75StFGzDmmHvcyjYhnNp+HVX
         RaeXdYRkhXsvIaeCi4RRECcPz6Z5Q7Gr/ULL0/rN36Cpr8sPLUlMUsWBsyeStfRSkAl/
         uR+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774805050; x=1775409850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
        b=lHdMV1L8RxLwEyQqw/PorgKiM/BJGLuDJf6RYkuUfMsz8VXhIUJnW5fj//csD5Jlx7
         LDygBNgaT9cWmm7otcsWPDAX5YBUCDiPr4na/V74owZKAuTFwhabIWM5EWVQndw5bBKY
         yKTEbma8Shbt8csZVfIFXtFwYS7vM/fPLFJc4sVdZzTUimq/8BAmr9nCduQD/bho6HKu
         JKNajYjM/JqSCXXAgA78bOjPbNelS5tuI0HY6Qn5e4fbGWGRNz8LE4QTm96hnGq2Se+y
         fSaxL7kz4wR0yKuzD9s7PeY+vZzE1k3tWKVgz1xP6ONvMiipeQnIC6EqRPzmnCLut0Z2
         XWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774805050; x=1775409850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
        b=fENGIM5AvsFfccB/6J55WkW/xUKPnk8aFihuEnAnSI0tH2gSxw9aHO/p8eFcxVz2Hz
         Y4yrXc4pAUajQxmlsXSu+JdgUjHSSOtL7Ny5JG7OSaAM/bdbh176aU4r6J3wC0HgcJOF
         xsU8onuFcWwcJVwHcOAWQTq/0IxvRA/KERghj3otk1BTm10Ovgk4F27a8a6dI7X3kGD2
         KGyqF6GvlaDMHTASsQWDoHizGgPEefZd/yN7ZAQRlewHQgIkaf17QERhA8izAIdbY0kf
         nvXP5aJ5wG36rOjvemt39m5EZkPRMp+Jf9phvADK9/L9SH0gT3RNkLxqYJzL3m/fBHEU
         9xeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE1Wjc94FHpIoJ6QHQk/hG7S7GR1x3lx7eoIntzSoLf3O5ulUnZyDT3Cj2elbZJclHZSqGSOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBE5K5BTu9xBU52bsFzPvBC9UlvcxoKaa5/WS/JcKnVoCTf5q
	87B3qgC5V7suAxCDpb73hRyP45S/0WoKKyySlt9UOdwls2Ik2YA7TyYGrAUlZOK4tdU9TzlzoOU
	UOQJS6bnmUkDRrDFmhDVW5TiPirv7Py4=
X-Gm-Gg: ATEYQzxxtkobL+vdhh98pIgSnF6Kk7vpvPYG/uvTq1RQk9dXp8tyE20YR5j29zrqt5S
	T6mwXXMVWbnSHG4xLLXRRHZUoCtwmonUmT2iETTCMB4Ircd0sU5BWTgOV8OAQjxncJuTC254fwY
	MQUDZyhVyHu5bj02+CWU63jzWW9Joq5Sqr+m/HfwDUkm0cmWJVTjjyKid2KXwuVBWe7829Fi2a0
	/ZMZFdqh9bu7/NcByqmdKTwfdYOlvz34uQNvRvWZZBrhF/jFyARNbGMe86jYhHsTJAz7Kb/O4X/
	lFApbLhSEHm6TL/5johrSjwDMSCaXF6ewIFCKQ16jYZbVvFEuOUS7Pn7mWA/NDkfEQkOEYbseUy
	220mwzVC3x6jRtThcp/Y/PqOyqQ==
X-Received: by 2002:a5d:5f90:0:b0:43c:fdd9:1890 with SMTP id
 ffacd0b85a97d-43cfdd91a7cmr2742839f8f.51.1774805050213; Sun, 29 Mar 2026
 10:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324122703.641-1-hechushiguitu666@gmail.com>
In-Reply-To: <20260324122703.641-1-hechushiguitu666@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Mar 2026 10:23:59 -0700
X-Gm-Features: AQROBzBTRgi-yNiUamK3PL6ZySeng2gSnp7g-HgSIPKYBlYukOHbRkVG543ZXJA
Message-ID: <CAADnVQJF70sBuaJsXW+=1cR3wTQEq9zRLG3jrvg7A5+Xqiw74Q@mail.gmail.com>
Subject: Re: [PATCH] arch/arc: bpf_jit: fix missing newline in pr_err messages
To: Haoyu Lu <hechushiguitu666@gmail.com>
Cc: arc@lists.infradead.org, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272949-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,haoyu.lu:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6559335353B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 5:28=E2=80=AFAM Haoyu Lu <hechushiguitu666@gmail.co=
m> wrote:
>
> From: haoyu.lu <hechushiguitu666@gmail.com>
>
> Add missing newline to pr_err messages in arch/arc/net/bpf_jit_arcv2.c.
>
> Fixes: f122668ddcce ("ARC: Add eBPF JIT support")
> Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>

Applied to bpf-next

