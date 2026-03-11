Return-Path: <netdev+bounces-266455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIcpK+bpsGkyogIAu9opvQ
	(envelope-from <netdev+bounces-266455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:04:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC825BCDB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5173062FB5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B9F2D060B;
	Wed, 11 Mar 2026 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EErMNO/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951521D5ADE
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773201891; cv=pass; b=MTNFjaVCBHIQeBgGthL1omAiSCNYSFuTj4BH/kPTaZTZ1/cn1R8BaIbpxOr61kAdvIIp5aDCDFfSl3DUjLnGxtfCPRpsziELQFtIiR/AC8s+qHRppvmgtwzQFygyzhm61cpj2Iv458+CkN4kaVenbRKQFHk6ABV/5w3bIdnSiYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773201891; c=relaxed/simple;
	bh=raN7z/WacOW323jrWKR5YdlHiwx4qA950Qjw8NO1n08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha5hi3/kZhdUhrMcpY6pD3vOzMQlvv1SvCPed7ZRBMmIMmOwhw0f+tk98/06ivf13DzhDDBUMCeUIhCp7HSaoRRoaJUUdOJPxcsTOjOz3cq4JbsuwBp6cLGcVyMTxfCyU8a33QGraQcj2YV+aI1OJ7j5z/pC4k+Fuek99pseypA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EErMNO/N; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-127380532eeso847807c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773201889; cv=none;
        d=google.com; s=arc-20240605;
        b=Ig8jQj0ie5mBnN96mT6YxkV7DGXO5uh5ZDREMcWK4CE4uG6g9f3WJyNhsZtusvLOd6
         ACDgzjX6z6T/XDBz3P4b0UFDOeexm9lM0X7xYiPSKNB0fwGSwCtm1ZvJJBpNjwveXx1/
         XZr330kFSztD0W4NDif72OheUXUw/eSRLNUnd1bhsVe2ai4xNkq9VUUb7jxmnRrgZFwA
         M50E95KdvlWHUvyEABdm48h6wtm/xTVuOSfHLDmXYOiQ/UvJdDvTvjZ9sAFunif/zmRy
         0HsVPnDZR4HYoOTl3jUpnVrmU9C9cyJGtxUIXff8Ml7rMFOsFz93Nf9fwh8MJOwIKAw+
         4L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=raN7z/WacOW323jrWKR5YdlHiwx4qA950Qjw8NO1n08=;
        fh=TE2PS4Jixbohp/BM72hCjfO3EjlemLDzonMJ5GaDawc=;
        b=FQELW0PrB9V8MnUEPacOMoxYlWAJcE9QOhtgwVtVNBj84uBG+/ry5ilBvKTXIqfkGo
         i7SPiNrwanM06JYoVIl4Tz/Q7MHhQrGI6LIUI4Asd5VF3IeUIPNdu6Mczj0fuRH+FNwy
         cLxT9Voz9RILUXlnQDjABtC4qoFOOxwUkiaQsp2eBW0dK/PtOjOQsi0J/dmzriIc1WE9
         pZh+FqEei6Q8oRFuN7UsbTCqdfRPchAEKH6MeJfOK0SAf9feH8ToYSo+b5xvsiKYBjnN
         WibXWNF75JmxiShbGj+tJNN8xS1wJ/vRSKKxxHbfXYL8pvFgOXRQaohit/qVXPzRCXeN
         Jy+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773201889; x=1773806689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raN7z/WacOW323jrWKR5YdlHiwx4qA950Qjw8NO1n08=;
        b=EErMNO/N6xUfo+zJXei4uTZLtdm2RU/+D5YHzlOF9XG6zIc23LrawnH4mNNKhxupEk
         J6AVJv2Zy0j3aSGH1QaFFwrJGaLTr6KxuzDv3Gkn0QjB9fn7s/vT3B539/wj9uumJtoV
         n7sK4TM71lRX8IZ6fgi/ehNjEgnTwld92gJktoFBtZErWCzw0R36uqtqWAdVdC4gCSc9
         B5r+8b3LLcio40tRRc14ObfwTiPWVLle+6qSqtFLsZQYIJ7w14B1xgK2CI54dxSl7gNz
         C9f0IqMrmP5Q8VGgLw5b9dWApzxTu2WjcqmvezJn6hR5+ZGTfWQ+7ru6s+RPj/w9Vs7K
         kUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773201889; x=1773806689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raN7z/WacOW323jrWKR5YdlHiwx4qA950Qjw8NO1n08=;
        b=D+KyRMiNgbJzyOG3wvM8NuD/WKunTXazoQ6C2uk6mzF47tIGkdYJJSvz2tlVGLu5/B
         bZEv1lg7jwAAhwivIqcjm7GNWJW2qKoF/THYSQBBcQ4BBWSl1dTgWubKb1cq7OeFziis
         LUP50N24vjWHRL0B4ZPPu8IEuSPL0wDXdc2sSXabXBcmjqTgj+ZQVP4EorytTqCAq5R5
         XMYQvjbAKl+x4Fe9H9nQmqFaAbY5ZzflVDfomT7vrphFvr9OazxUciMzJMmSpd02bzgX
         9u9rJV2ds3AzQ8s0joSXA8flL0dDteAraojrRYgG8Mddx9+r9QokEL7nWhOdKH0j0MMc
         10DA==
X-Gm-Message-State: AOJu0YxhcxyiJtTm+rgjWJDAYJ01fr353izkC8zkQ6scUsu1qba7ZdmX
	mRR3tbu7W5tAu8I6zSppL7edMNfpD2UcpxeZbJh4X6zH2mPv+w4rXX+KE2jTIUzD/b3jBXN82I3
	VRzUXQzfCMhwv2FF8uIZ9SvtHpp7uO+16by92eDowIAgBvGUIsO67b5R9
X-Gm-Gg: ATEYQzx1ARx/a2KcHrNEf798QdAQqFqjPTat62vbhCWQ+8iYwS0BT5VLd5ICug56fjV
	v8TSLSRZLyFSDyA5iQ4ulzdfP2BxivB/LfOjPnTnPtR7+DATV5RqvAaizsZx+nvbwAZNk40RIG2
	fSBZPxnR2ea2FJReXHpLRPED4CXwjYyfs+IpA74KXem79zYsf88i2CQaVKtrBWA9k1N/KCGtEMH
	TXw93ykGNXkMkWXcEY1cuu0TtZsgKQw5qi5P1nTUbPEjVQiYM4t9RMWDuaXl0if7lIse7B33pdO
	Ad1s3UliMK+uK7U4dixwfQO9nxzRXzZaQMnMlcrGf7C+1o728NwyPZuAY4AWEeLR/Ew2Tv8=
X-Received: by 2002:a05:7022:6b9c:b0:119:e56b:c75b with SMTP id
 a92af1059eb24-128e783c67cmr525727c88.32.1773201888915; Tue, 10 Mar 2026
 21:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772894876.git.sd@queasysnail.net> <38c61de1bb032871a886aff9b9b52fe1cdd4cada.1772894876.git.sd@queasysnail.net>
In-Reply-To: <38c61de1bb032871a886aff9b9b52fe1cdd4cada.1772894876.git.sd@queasysnail.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:04:38 -0700
X-Gm-Features: AaiRm5004dlD7TWA4NNnNaVV5jkNeMlCjbszkXyqPWY9NssWbgrn0RnmmNcwBIg
Message-ID: <CAAVpQUCZjH6mDou-9zuurODT9oONUVDjtgiVdvF59eoG5v5czw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] neighbour: restore protocol != 0 check in pneigh update
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 15FC825BCDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266455-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,queasysnail.net:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 2:59=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> Prior to commit dc2a27e524ac ("neighbour: Update pneigh_entry in
> pneigh_create()."), a pneigh's protocol was updated only when the
> value of the NDA_PROTOCOL attribute was non-0. While moving the code,
> that check was removed. This is a small change of user-visible
> behavior, and inconsistent with the (non-proxy) neighbour behavior.
>
> Fixes: dc2a27e524ac ("neighbour: Update pneigh_entry in pneigh_create()."=
)
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks for catching this !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

