Return-Path: <netdev+bounces-252727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJPJArU/c2mWtwAAu9opvQ
	(envelope-from <netdev+bounces-252727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:30:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308F735A8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5AA23008D13
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C432FA21;
	Fri, 23 Jan 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdDDCyMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D33217F33
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160508; cv=pass; b=iY2yX3IHD5IG8eoKdZmOz79Wv28pwfLM5cfg5gR+ejbtoisywyp4WcWzyhRcGDIImj7srrbgowW3aj1x7M6wJluqvUF/zy2HvLYrpw4wcoXY5xpRgMfEC4lBNC4r+DzmvhKwVk+Cxm2KU4wYz741jIStncWVnToSqXJeCMXwSJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160508; c=relaxed/simple;
	bh=3UywT+y5GwEarHOxcGvyAyiOa+J84PfHFrz3FeoN+6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkyAx092wJN3vmByK7AMLswYHjLnc5igu8YeoTizbxd3ZcwbmEjOHiyBo5k9aA8LcTPXxBUWTmRtOBlFAx/Xtv5Ico2+oQVAWn1y4x2tlPYM16iMOcA3azIQgEJGY+v/PD7NgcTS62xoGoHH2cBsTAgdZ/TmzlSoCFDWmOTzyVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdDDCyMq; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014d4ddb54so24795181cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769160506; cv=none;
        d=google.com; s=arc-20240605;
        b=GRH/AQqhvXWlW068MC9q8mNCDiwPXJM2PJuxneaEDigBbC/BcbINSSFxBqYR6Hh/Ey
         O8ANbCEE76TtXfjC8l3rl9hfKOhXE4Y+hppsHCJeFOe0wqbQtBK1yBF1lxZ7Z/lo6b3l
         pAhMmdLKttbZjsBogeJywHv4Wxic6BYNPAfjTKedvDt3JBP+QsR0DmH4qpyiJiV/JXdW
         r/Kp2Opirnwm8dh1YW6WA3yScRlrQQ3aBvr5bnhvG2150eYSToegFnbl3mSF3v/0BXRk
         J7garOfcmqyhC8wmZPLkQC2KEBLjDeD9xOZ7jNZ/mGYj9fg/IfR1KOC6cBEl8gcQY7Rh
         SkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gbdgG9h6CJKMGOTd9pmNvLM7A/ADx0CavKYFgPguVUE=;
        fh=KxJNtFDM3/D59k2McvG4+Uz05gazRh2/irT5j7XkScY=;
        b=Ic6t9m8ClsHkxVA3HJafnkFDcBJ23k9D1udHne8PKrY0r/3+95m0tjAmR6rhGRHEqQ
         /psKuilO6hN7Lg2No150DUhDS9sBHIGWXYwSjTWOE6KdYojXBtY3OmVtkwpp0teo/iVC
         5SKKmaFgM7Oj6Uk/7Pea7XZeTsRQ8ZL19BA7Nag3ev/M+SUXlmSgKV6YmYSsYIjis243
         0pAsNer99Y6GuPmMv2coLHc2I0jRpEwnVq7SoKfGzXC5hCCo3iiADTfMIosoEjUeaghu
         Rt45gHXZtcV1ZML1epXpigG7hHkF4qgCIWJSaiDUGlhTvP/9qAlthiiLQyPj6IfZNDhc
         o46w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769160506; x=1769765306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbdgG9h6CJKMGOTd9pmNvLM7A/ADx0CavKYFgPguVUE=;
        b=TdDDCyMqylbIp3KwwvC5si7oSTl2qMpBxL9EtxdEg7svu99fiG76/Aibz56VYEx0kS
         zVPAMBF1fzxZiFBg+3iv9PeqBU08U88tlLTWeRuMQuE+h45WYqKMKDOabRW2IdfXieg/
         cI45g3LFeOTBJ4D+BE27iHL6lREV2k78uqVsUczFVnHsZCQorley15BgqOF++5HJe10a
         AYeE0FLLxA72lSsnx6+MWXK1eD2YKmNh787hVNSrlsIR66NbXYNJuDlp6TL7voy5v/Pi
         3aeGrGsM8uQglI7aoFmPw1H8QCMtuSozabKLwJR1x3dFNUQBSlGFB3l11EMhlorrnZbP
         132g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769160506; x=1769765306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbdgG9h6CJKMGOTd9pmNvLM7A/ADx0CavKYFgPguVUE=;
        b=NwctfdKC3jvbaKU+vcDCWvNxyDWK6GXA+3e+7npOyKSsuFcuPce6kmcDRmt9VAOLO+
         3qrFxaLNAlfAtfwJxh1FzgnL3kSy9DXhL91xWHw+ojQ5OvJJsBKaIEafwDCq2qHwhSkr
         iVYqRpipFDIXWf+C/omjcfSeBJwXC1/hn1apQ39dQP2zNMSFpDwJ5cHoOB2Btn2jJVBR
         B65V00TH4+4609fL7xyd+6nCtRE5UPesvYwD8oKiKtYffu3daNn5RVp55c9OvUueHemK
         ytejpBj4Nj/kpowP/q2j7axNoDUI1MClPKZndhCzEjXIZy0e0KukoXF/EkfltbqEIdFY
         7YKw==
X-Forwarded-Encrypted: i=1; AJvYcCW/cIsa5D29y3VNfTH6zaMy75c+3pxDF+U+fU2yEY+ZhzVnYlkNkyzUXt3Iwjkcd6MiyHgL3rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7n3Aic730IBbUIpdcWQAVFc7ZPqPwwGEWrwMm4m9ZeoxkqlE
	fpJPhogxVt6WMAh3p1Zfv68MFZ0BpNPctH1sbON4JIcXgCkfksfmFii3lx5Nx3Aj1KEe2It0uJ3
	w0Td0YpskaL2QnPntGWMGQ7igH5NfRWc9OmxhVFn2
X-Gm-Gg: AZuq6aJrnqcH1mNYuuKRXUa/T7YvicZk2WQL5sSw2HMNn0EAf1UNkgOhCZqroKHLA8a
	xfW3HO3XLV274vulxilK4rzI5L6rxNe5mwSqlzl2j6KZzciST9C2tZv1k1/DLlUcZ31lbi4mKhd
	ZBpe8rLptVzdHdT2s8OOC2UcGvVqq3ytJRfdnH7dZ6JKlzBKkXKd7pfgM9epUHqZRoIt533MeUl
	pD5Yt2Zv5ywhLR11kFnF3VYqFdO8JHdJI3IPuC99KXA1QK4uXZX4r+qgFNZByb3V2+S0+E=
X-Received: by 2002:ac8:7dd3:0:b0:4eb:a192:de99 with SMTP id
 d75a77b69052e-502f780ee67mr34226601cf.76.1769160506155; Fri, 23 Jan 2026
 01:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123011444.2044-2-qikeyu2017@gmail.com>
In-Reply-To: <20260123011444.2044-2-qikeyu2017@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Jan 2026 10:28:15 +0100
X-Gm-Features: AZwV_QiplwYaaZE6hh8yS5MUPyOFn8vcLPBjKF1nlMK4i5CNqBuww5Jt_cefTbw
Message-ID: <CANn89iLdB8Tv0tuksqSmUYxivdr-zr8oC2L1BTKWBQXAgA7J+Q@mail.gmail.com>
Subject: Re: [PATCH] ipv6: ip6mr: check socket type and protocol in
 ip6mr_ioctl and ip6mr_compat_ioctl
To: Kery Qi <qikeyu2017@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4308F735A8
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 2:15=E2=80=AFAM Kery Qi <qikeyu2017@gmail.com> wrot=
e:
>
> commit 99253eb750fd ("ipv6: check sk sk_type and protocol early in
> ip_mroute_set/getsockopt") fixed the issue for ip6_mroute_setsockopt()
> and ip6_mroute_getsockopt() by checking socket type and protocol
> before accessing raw6_sk(sk)->ip6mr_table.
>
> However, ip6mr_ioctl() and ip6mr_compat_ioctl() were missed in that fix
> and have the same problem: they access raw6_sk(sk)->ip6mr_table without
> first verifying that the socket is a raw socket with IPPROTO_ICMPV6
> protocol.
>
> This allows a permission bypass where a user with CAP_NET_RAW can create
> a non-ICMPv6 raw socket (e.g., IPPROTO_UDP, IPPROTO_TCP, or any other
> protocol) and use SIOCGETMIFCNT_IN6 or SIOCGETSGCNT_IN6 ioctls to query
> IPv6 multicast routing statistics. This bypasses the access control that
> restricts mroute operations to ICMPv6 sockets only.
>
> For example, the following would succeed on a vulnerable kernel:
>
>     int fd =3D socket(AF_INET6, SOCK_RAW, IPPROTO_UDP);
>     struct sioc_mif_req6 req =3D { .mifi =3D 0 };
>     ioctl(fd, SIOCGETMIFCNT_IN6, &req);  // should fail with EOPNOTSUPP
>
> While the direct security impact is limited to information disclosure of
> multicast routing statistics, this violates the intended access control
> model where only ICMPv6 raw sockets should be able to access mroute
> functionalities.
>

Where has this been documented? An RFC perhaps ?

This change could break applications if they were unaware of such rules.

I fail to see how querying statistics could be a risk.

What about the RTNL_FAMILY_IPMR rtnetlink interface ? I am sure it is
available to any user.

