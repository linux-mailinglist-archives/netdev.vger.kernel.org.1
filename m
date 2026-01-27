Return-Path: <netdev+bounces-253698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HYb7GDI9eGkYpAEAu9opvQ
	(envelope-from <netdev+bounces-253698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:21:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61FE8FD77
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C1D4301992E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91193310777;
	Tue, 27 Jan 2026 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwao6kVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237B2745C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769487663; cv=pass; b=ECraE9NPCGBzEGrVUCJO87biRWc3G5Vtm0Dss6mbikOoLg1cggo/aoepXi9l6PkDQa5iqMu75hm1Oi0U15X4VObaR/NMfNSyl5LbvIXaIR0d/ckvUK4utk/Kohac4cp61uuvNjBSlom0ruZmS8mhDRXXUv66oe8RI+J0ONj6gdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769487663; c=relaxed/simple;
	bh=QGuLNgKUVWwgE6vVNwL0mPDyimDYATLC4PF38VkBCZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwcGX4XCY660NGE6TWAtFwVKkp59Virk7HedmuBunwCEjJ93rB1h168cfzSfa5fwFCj0jOobsW37I+WvSgVH8rA+Wb9YaaFGpWWgSlskmJ9+qX+LGc4mN1QCv+1mH2KLo67HfPb0Yo1WHbcApwmMIZrErIFVJe5Hru/s6YtpaO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwao6kVA; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c531473fdcso707404885a.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769487661; cv=none;
        d=google.com; s=arc-20240605;
        b=EEET5bejpyTEDs+QceH1FI0t1eqqRarGiH24LGM3fx/2oDYYx3TQcGSYI180GLJ72k
         aL3OJBEzMRauILWGG3sb0doISUevCPtLXEorj5ePcneNCYFSBBqucEGKvKyk3Ap7X2kI
         u/ZWEfFzqY1JbBMJSVlXoGyiQ4xA73oxXRlqLGYMuAFI82Sz63MF4aSCbv7Nc5gyGn35
         Hx02z9Peb2xOXncjG4doV2yEUQTihDAlw2OSjmjDzBMGrZ8yxlMF0gAssrhMrRXYmUue
         PjFKsw0fKCGLwlkSEdGqJ3tb94TYuuSmubnKCrQDWLXpjzuAQTWSgdjlwniBIuNZ7Q5v
         NM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIhnDe1MXsaKo5y6+UQRQMKim72X07VZpodVq29siKU=;
        fh=1/f04J0uhm6O22R9GYFo4iIPNzEehJ9gr+ZoV6ZmpHk=;
        b=NNzpApr44yH5ZIXIRIJDxA2qdrwDHLKzsaFbvGT9S9YZtQY9R2lF4XpjmNORjswHoG
         AlzAHCL0y1UXwVWJoTBMq0w/6+8ete7Z3oLpuylstGiwCqyTdOotwmzU81xEp3vcDSYo
         MdkVMVLixNujptRf5JVPOUk1yWs51UFuqdV0IT1lPNd/s95vXRSDd5B1qHtLvRGqh2Fl
         iIK8K82Ta+fBPXNER+iILCpZzdIj652cSrs9kKvBWVzZuDaO4U/4Ih/9oHlJV6pNk4ge
         rHuU67Pwq/Sr8d/QayYn8QQAkYeK+eM8c/G4Alfn7JZC13MrHPbVohIqw/Y95WK+21mr
         3zWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769487661; x=1770092461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIhnDe1MXsaKo5y6+UQRQMKim72X07VZpodVq29siKU=;
        b=Lwao6kVA5kNOcwigz5l2IBTRwv1mhLIwhvDoykQYfEErXtSQWElHx7DwXnRT1XFnEV
         CQNahqeFAhJF3i8pDpCut1E6/nmi9GEmKJjg2yus42qi029l5IgMZDPT8PbuUCMCMd4c
         LgdieR61O8l37xSY3OBvxQFBIAwMjsltn5U3LxWEABJBGn8XL5L8Ywq1JCv0bpjUm8hz
         JGSJ3yZAbyYHWbJ8ZgEUGWsA04fGJJxq96zTpEgg0JXSKT5gZcQPlMppWQFr5FOdUpgy
         t7Kvk2IV8BhTKr4+GCBVaQnG1cMmadsR8pcArt3FFtSiirqqe9P7zYAqeBDd0LRCtYIa
         7Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769487661; x=1770092461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIhnDe1MXsaKo5y6+UQRQMKim72X07VZpodVq29siKU=;
        b=aLuR7mDMqQyiIUZMiBMeM1bs6DD/nMQuAsCW3o2ZWkfiblhP3oD9iMvyL7yBYGK3zT
         mz4D3Uv1YZBwF40GVwEOnskJOyTPf39p/MXLKFVJMCIJXbbJSEDpbeFQx9bKEErkhjWB
         wg4xPSFbSzuDwTHyOKajwkD6zi8rmKNSwNcp+8L0MJSO+iPWYNRQjigaI6e4Vmdq0YGO
         afNIpsUaH+9/7Q7cP7hpX7UF2jTO3A0tXYncJmmlYmzE8h27xfIpqJyoxf3IzOcZu8EK
         BwQgJRh9jngr84IJq74uBqxUZeRS0FTdNJ2p7vs2gJJ64QMM0M5U+vMB8UU5BScPeug3
         c7Dw==
X-Gm-Message-State: AOJu0YxyINYxyFl7Ky3hD6+dOtZ8S1oak56Q05XZeb4ci8AG85Wy+5Sk
	zNkASx5op94KJu8btbRYxm/Qnw+7CqvVyHF3Wc9X1cXbu4SpyIi8kwtCdjxcSIubWIMFlop2Q8n
	ieTBYo93h4kqUecfv+gsmN3jxKJGHI8Q=
X-Gm-Gg: AZuq6aIpwnKTxvmfBJUDgP6ATa9HKlgavgI6tYn/FOqMhxFzQnsyc9ZAPDg3pHde4sF
	l3uqy3QGW+QVQObpuFZuYob40Hx2lx2ZMa2w/EJBg+tjjwhyqkUwvWCQK3Z5b6RVFiAtv8uj9dH
	ykg5kqv8Aq/daQQwbArKW+0i5+wu9CgLOvM5yQ0QqEIVD8/jb1y072+/FDJAxJCkdPsYbexg58k
	eVpC0iePlcFn5lQXSQ9BI5Nl5IL+BcGa5mxzbxlbLXiD3+YioP6hAXt9YbAro0SOLBslMYtSgcZ
	GbOJ1F9zFbPAluo0gNFf181XXZSZY9qD8yfzfFbWen1Qgstkov+nPyWQpOqp
X-Received: by 2002:a05:620a:2585:b0:8c6:a034:9231 with SMTP id
 af79cd13be357-8c70b8776a3mr58218985a.32.1769487661122; Mon, 26 Jan 2026
 20:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124040226.34390-1-enelsonmoore@gmail.com> <aXdxY81-bXBF2sRR@horms.kernel.org>
In-Reply-To: <aXdxY81-bXBF2sRR@horms.kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 26 Jan 2026 20:20:50 -0800
X-Gm-Features: AZwV_Qi2Ktx2ayGcgSUWZGIj6qsUhXatp4rlJGgFB3wZBisQBK2jC6wPL6_Gm-g
Message-ID: <CADkSEUh3mOq0CJmMbKMt_qVj6552y7r0HsE=D3sW3YiH2gnErg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: clarify code using BIT and
 GENMASK macros
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253698-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B61FE8FD77
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 5:51=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
> My advice is to wait for all your outstanding sr9700 to settle.  And then
> collect up those that are left into a patchset, addressing review of them=
.
> And include, in that patchset, this patch, in it's full form.

Hi, Simon,
That makes sense to me. I've adjusted this patch to be part of a new
patch series I'm working on, and to adjust all bitmasks, even ones
that are removed later in the series.
Ethan

