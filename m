Return-Path: <netdev+bounces-274326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEIGG+TTzWmWiAYAu9opvQ
	(envelope-from <netdev+bounces-274326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:26:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B3382A74
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1223230293F4
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9331332EC8;
	Thu,  2 Apr 2026 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4aFogyf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D22566D3
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096784; cv=pass; b=S2SbPRU/PQBhwUjFR15IlfYUPAKC1QpYT1eh7nXbcB6SnkfQBYVwd2PxTuLKEJm8UdaxIPamB7kEZ+x0tUaW5/SYoPpaIiX66RxyPP43fV/FNWHHwOf2V7/37BEyIoEf0oWDpjBWggeCY6H66LVZPZe6J2qEL+7GwBlH0Xj3RMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096784; c=relaxed/simple;
	bh=tWl3PMbY8WSVMBe70id0QojUsUjc22+YUzk3cAiXrqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyvY8a0BzsTpnQvWow4x+fINC9dkg6pcMNQbjXd2e0V74drnV3PWNVT3HEiqWi+HjT+WMHQjmvtBLFR+lY4YfnLAg/rjL9hjkkThmhJBnd4EYYL//6j7nrgtLqEpaKNWK1GT93VdTcIDJnRpJiI3f8DO4qIIDp2A6QNurVVUsiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4aFogyf; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7a17bc5745eso3583237b3.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 19:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775096782; cv=none;
        d=google.com; s=arc-20240605;
        b=WXEzn4uXtwjH8l0hPQ7i7x+puQdL0OSaZBcwA2acmlG2NOW56bLTVQXkLdgYCN7U3i
         chJaFqlkje6Bt4soOtWchWhqsAbFcR21zaEIsh0v78QyoYceDXoKglGjVX0mUrBgu4dY
         hooN2KutnaYXrudwtGaK/BBPBH0mX8/ggaQCvj7fzW2f4sPitkxYqRqmMAzb89T6bgPj
         pjwcRg+fp71BtZYWQ0NA9YOf208rE2gq4ecEOtKEVNXPcyz8T09+Z8td/bKjZTalQSg/
         4BCq3hW+KiGJ120xndPsEncmp12b8qf5F03dP0zSbzmHDdozxINnBLQ+wr6/Epqld7oU
         3S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jbcLxyNKssJ/qsojKtaGf1w4cEtkGVy5OnWNXj+J5+I=;
        fh=1aHYbChdmOM77gSPLyXOzG/RGQl3uo+CneOz4GH9s3I=;
        b=k0PKNQGg0W+itPKE4sGHbDPMU+qpwBFYDoV4NnaFXmNYpJ9z+4Pj419jsGo779Gkqc
         QcMMWXblRvAOers9+n+PblkcLXbC32QBx3lf5KBiGjMQ+gjveD47r+koxQxxWCzpESMP
         N0zp232zZIXu9puZIuufbEHUL9hMqghgwOnqL7oMz5O1uNLAPmSyBDWYSb0j4GfyvqUy
         TCXeG1zPtVpJd5DGP+bA0jqGXJoBmHhodXLI1NXxlfV8Orzt+yIO5D+4A1oM0fpcngvb
         Xgdmq+GqRXP9zccesAqrpnT7KTXdNSfNwZ+3GoHY7dJ61zHKgh3+OKikLKHhl4OM2eHt
         Fmrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775096782; x=1775701582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbcLxyNKssJ/qsojKtaGf1w4cEtkGVy5OnWNXj+J5+I=;
        b=p4aFogyfFr6le/lnlniUfRCoP7kFoelYDJjViX9zSJow1SN/7nRdsyh16+zn6tyTBC
         c3FnPv0hxAJkGyded0hKEK9fJ24TmzC2jSFUYpto2nLTOkvgodS2mJCYi/rjfDFHz1xT
         y2c/mrdkAI5qYvyOZM4/xvrnRnUH8otrnRrXAh4B3qMIeAIPDCFgD4WbhXDf5dB7VS1q
         4ZWmln7A4Ljxu5QGzYecl0r48R+ntnmblYHyFvdjgOocsRqrSJNYvzGJJYH4FaL13A81
         V8Tl6OY+vIPjrnjJuQGOeZWF5VmEcGrkleWaB9wtA0ix9Gr9sio7VQworo+nctlvWrFL
         jFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775096782; x=1775701582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbcLxyNKssJ/qsojKtaGf1w4cEtkGVy5OnWNXj+J5+I=;
        b=lgz0U+uAKYZhHwHuQmntH1IOLNyVb3H4OnA+GJVrcZH0ztRvo5K9lWV2gcksf5Th9L
         x370S4aaP1CcJDcT/2vVAc7g8iWvElnegYPXEY0ydXjAsi3bqNAIWVdoExuNWMKVKWp8
         hIbWlhN0NmNtspApRjm1x7CyZ//40/GhXSzFTYrtLpjU8v5oqyILqcR0MgKrpwon91St
         Whntr8ZMAg+ohVhL8wN5CDNW9xO4nfLlcO6XZ3tuNDg5rGyQcDcmMvstN7q6thx82Ik4
         ry4TXSdFQz6Wh0DjeZ/DqV8YApfBg0iiHrwYoZRd20czj/4e6mn5rhaGF2o03Wew9mzq
         sk0A==
X-Forwarded-Encrypted: i=1; AJvYcCVkPVM+nFmYKxj+ZUji7H9mAXS4+qgCvFCiqkzQdAHLe+N/ayQL5gSO5aWLgM9b2GI3Sn50BhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LxlnqrP/QiARpEl4BiflDM5jsLN6rIIEysPLTPWy+20gyESz
	lw1fkZApT7yVQK0gdwGr6RFBP4ry/HG/9yyNo76XclUkjG+yb38kgGdqHu2XNeRj9kHDrbTdL9K
	gwvFkH6kz7STUDpqla+E93mIzY28iBT0=
X-Gm-Gg: AeBDievGNRL4ZYe50RpOqPbgFNUHHrlb5ufji0ua+X+Ue9NHOUNo27b8HJpLUtOWvA/
	hRFHtsVJrN7eFw1RgQYt9IBC5CTHzpWWZB8Z4wP6Ya7+9tg81cFA62TwKRKzKKXHpRWNxvqVZqB
	xS0z7F8gciE7L7V07al8rCu4hCAFLi0PB4vTm0r3lPhSepSzHwzN5c6HR0rSmZOkegFrum1wjim
	AInIPffSAFw6MA22Vt3GR7nSkiqcxP9FOtMKTSgGLgG/n/tu8oduPkrTOiDunETBdej0AI4wdmB
	zveLeJ0CbXy/TchS7ptTuyIK13ILSALrQCZo6MoZ
X-Received: by 2002:a05:690c:13:b0:79a:5164:bb2b with SMTP id
 00721157ae682-7a20f6eec2bmr61155537b3.7.1775096782537; Wed, 01 Apr 2026
 19:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035604.133073-1-dqfext@gmail.com> <20260401081030.29b050d5@kernel.org>
 <CALW65jahWApDnVmFReW+Y3HDxBEmCwzsT1oyh03SW7X5ry6PzA@mail.gmail.com> <20260401175621.549c492e@kernel.org>
In-Reply-To: <20260401175621.549c492e@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 2 Apr 2026 10:26:11 +0800
X-Gm-Features: AQROBzCtPXGaDqROF8pKtII2foTv_tDo-gjdvN7lGgVfBU6XpEEcgXimHm6lXKs
Message-ID: <CALW65jaTbaosbO8ypKZ6G37HxuxXabeTaP_Fhq72xTovmDj+8g@mail.gmail.com>
Subject: Re: [PATCH net-next v7] selftests: net: add tests for PPP
To: Jakub Kicinski <kuba@kernel.org>, Dianne Skoll <dianne@skoll.ca>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Felix Maurer <fmaurer@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274326-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0A4B3382A74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Apr 2, 2026 at 8:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 1 Apr 2026 23:45:38 +0800 Qingfang Deng wrote:
> > > # iperf3: error - unable to connect to server - server may have stopp=
ed running or use a different port, firewall issue, etc.: Network is unreac=
hable
> > > # TEST: PPPoE                                                        =
 [FAIL]
> > > not ok 1 selftests: net/ppp: pppoe.sh # exit=3D1
> >
> > It looks like pppoe-server fails to start. You may check the syslog to
> > see what's going on.
>
> Hm, we don't capture syslog automatically :S We capture stdout and
> stderr
>
> I'm not even sure there's something listening on syslog in virtme-ng
> Is it possible to make the daemon log to stdout or a file and dump
> that file to stdout on failure? Even if we fix the current issue
> it will be quite inconvenient if we have to go into syslog every time
> the test is failing. The test output should provide enough info to
> debug failures.

Add Cc: Dianne

I checked the man page of pppoe-server and did not find such option.
We can instead start our own listener and redirect the syslog to a
file or stdout:

socat -u UNIX-RECV:/dev/log,ignoreeof STDOUT &

Regards,
Qingfang

