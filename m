Return-Path: <netdev+bounces-258497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFsIMDoojmkMAQEAu9opvQ
	(envelope-from <netdev+bounces-258497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:21:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AA130A80
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1AE130117CC
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C02527EC80;
	Thu, 12 Feb 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="H9PBnDsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACCC21FF3F
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924086; cv=pass; b=dB9ICNXHUZ5k2oSCHhU4wX6v5Zpfsy7xjDb0qjnXFb9CWwyrzMUbLvR8tqkwHBEL4Fhrth9Z47AZ6NkgWVmbNhtnkUgqTS4CWvs/bIYmrmH4MQ+vNoHaRSzXOLxUYy86GCh6L7fSKawcTVXaIY0nWRBt1GImcvnG9VVvR0w8CO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924086; c=relaxed/simple;
	bh=oYFYku8YBAPUfnfW1WI+/mn7+uSI4bArfWKjKKBzryU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGQhgHDhQCfaLhn01MmPjo6FhW59hXlGN2RiVjZ7tgPCahA9rl3zYQUSXyzQlji93rQoT9RGACdRKS9ic835TQHOTnLSfExbEQax8lCSyB2y3rHs0z9N9WFlyQAPlosFZJXEhqxchAqp1NFDJ4IjqqjWMXZvApqkidBM0V6Psps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=H9PBnDsd; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d1959ba05cso59769a34.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 11:21:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770924084; cv=none;
        d=google.com; s=arc-20240605;
        b=BuT0N2m5FBYolaaB75iWaz5EPVD7rBi4gChfm2xcKZL5Y6dhwKR9n5hPQlfG5sVKE/
         +3VcLBNvQAgOa0qIIttNLfrvkn44BZTY/k2+hLxsrvu4RqSsTAeJvp0a4Jql+ONEQL9O
         SRa/Op8ExK1aQKCwdktejlpMeNsFpOb3QhRJxHm0RBevnzkN4emO3FLXQ1vrBWMyx+Sk
         kncsOexQzRyFfnHelNN3wwWj3K4iQNMaaL9NiLKL9asO/hFq/hCUYtBCN/jWTYCHB0PH
         ipL37bjvTiFlo/PNQS54wZ+87Ki88+sXYGd1fdLFsyPP1R9bBaOmluy9iYUbZam3i0kp
         nxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYFYku8YBAPUfnfW1WI+/mn7+uSI4bArfWKjKKBzryU=;
        fh=5R1rMU9IHu/JzJRKCktMrap9qYIzO0oCd2KeiZwEfsw=;
        b=h5vMFptae9VgKPXgmI/ZkkM8z2kdmfh03PK9YDwtqZfj2tPjtRfNIC+rht+kIRVnx7
         58lSAAAzQlAvl6Q4a72Uoy5GJSue+OSqSOWeKmC7rJiadIFOn5k2s3wR6zMq+3AUYJOW
         yWpLivP3iPweJ8B4ew1JJQ6WDlmw9qVZHwCN15m8UZsF8Tw0S0hE7wWHspqY854COnzJ
         4n0VpTyFg3x6Cs4yMsVc3uZ9Gkf8zYdurGvzfBQqZzbh702GTnfg2mQZuVfz2TRAG5pX
         dpt5vREaZggcKQAo4rK2EeQWrpfLocZ7nsnkLQfceLf/DTJmA4zS6CnuuxXNs+QeneWs
         94XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770924084; x=1771528884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYFYku8YBAPUfnfW1WI+/mn7+uSI4bArfWKjKKBzryU=;
        b=H9PBnDsdNBiW27cGHX+yqTpJ62vlPCBEeUvS7/wEnPB7UMWk3oEtd5QPRGvRrovRmd
         SH6xELds6QuT3S7VjZlL2Ni1cPuHZ3eHYninb0+87s/DXw6JuR51fncVeqtR42lwuEz4
         o4BGmuELmEHNPnaUxyryqnndDEkiIkxOSM/vhXm40cvn/YO+otITBofsoLwEPQmlRReN
         LJJFPrRG45e5IRHn+WKHNor6CR618c3O/E+/S/dh/zJBX8ArxONz2ttrjFCsFWapvywM
         jnkoQj63Z31lGfs8nPovsDC2+ujnVJOfcLas64aXfkjVPe1xM+ditNXwOx8txAnESQhF
         9hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770924084; x=1771528884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYFYku8YBAPUfnfW1WI+/mn7+uSI4bArfWKjKKBzryU=;
        b=phFn9VuAnkGZdWqt1JrMyXHSdFdwDdUIQqcBzD2ZqSqgVNMAz/bfA/6ArYdGURCXFm
         2YcUgPv0+6KizHCaeGQUdcOTRCBo8EXNpd8TWNOQeT1ac9tHTePPf/3r9Vjt2qY7HKI5
         tNiBVwiY/1Jyihg/c+e4d+byjYra6GjQcf3kPXbiXNCp2Cmj91EiOHx8xPdcrrzkSDd6
         qvvcFlIxrNPoCNHUa9sxOE9VD1hPnAtuafTgXRfHe+rwlVla/UY7loCIeyBwsO/DlxmU
         jxA4dVeN8Ozgx5p2j5GYPpWw9/esULss7vu/UNVcmjCchufxPIbrgVmjCiObUme4wnkA
         Z8lg==
X-Forwarded-Encrypted: i=1; AJvYcCVZbtwlBoi2x2Hq2Q8zrXYorg+tyx1/mLr2xSh79FfMH7siEYtRbWQWCCeMh1fLhLRNehzmgYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ke9T7criSzwDVBlyr7QAMdQdoXJvevM+WkdoLaaKTA/hNmC3
	HODL72DCU3Wpf3OReCs8swpstF4weGT7Xw+PhMWw73PCPU9GRFyEXm13blB4Ly+mo8Nk8h6oqO/
	IYOvARPskA7tfbZd4O7zG/clqniCKKO+b7YmzkIdM0Q==
X-Gm-Gg: AZuq6aJZ0EGsqvfvn10jW8lXxpJKFAO5TNkUbI8TYUH/XoUbs1akLzsDIdP2qCJDhFt
	HxhHsoQz7mTU1vHqQt1y1SLkJridrXROe6tT3KseBSis+nyr19fIY3SIbT7tpXNbG9mblaL2j8/
	k5kNiMA3Rv4Z5sQw+Dr5ToOnP0DlImT5ifk0YiedIE1Ti5yCPliGgDNZJQYZPf8GlNGzmXU+NoK
	/kTPaNbr0nrwShgE0ffXatp28hrrzUQmCT4q2NJtkNlqcgwnpxQlFu8MorA1XKJxoDRAV8QqTH6
	OmVGkUxdgmHd+aHRIoGR8UnDNIGFPtugQv1yZE9HRjMfX+9Dwg==
X-Received: by 2002:a05:6830:67f8:b0:7b0:826e:4002 with SMTP id
 46e09a7af769-7d4c1f27f50mr241400a34.20.1770924083779; Thu, 12 Feb 2026
 11:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210024341.3216007-1-n7l8m4@u.northwestern.edu> <aY4JV-aEInRDHYqW@horms.kernel.org>
In-Reply-To: <aY4JV-aEInRDHYqW@horms.kernel.org>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Thu, 12 Feb 2026 13:21:12 -0600
X-Gm-Features: AZwV_QgFy1H5mqoM_Ef0_ayz7-d0tIQCTt18dsPIOyuGeMXQ_tPEbOfy_I1noGQ
Message-ID: <CAMFT1=ZAiriHoy-BBKsTSLsb0ixdi44pdQQ=REZo4m--c_tmXg@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: catc: enable basic endpoint checking
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258497-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,u-northwestern-edu.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 498AA130A80
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:09=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> I think that it would be good to use an enum instead of the magic
> numbers 1 and 2, even if documented inline.
>
> I'm suggesting something similar to what was done in the cited commit.

Hi Simon,

Thanks for your time and reply, sure, I'll revise and send a v2 version pat=
ch.

