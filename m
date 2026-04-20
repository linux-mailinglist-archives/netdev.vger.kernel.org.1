Return-Path: <netdev+bounces-279614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOW0DZl15WnIkAEAu9opvQ
	(envelope-from <netdev+bounces-279614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:38:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A17A425EF8
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E55BE3014541
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 00:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECBB2139C9;
	Mon, 20 Apr 2026 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC2OQ2bE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCA1EB1AA
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645525; cv=pass; b=mba+50hTERvFRuDv/EpMW0xvQjNxXofjJVSES3dkuEEJ7tQ8f+lQbMx8nGIA9UUvKNg6I/42dEDvM8521KlbHnt7fTM2dAoxMSGnUPj9/6uOGNnMk8CWDmSpnUDbR075pC9KtKy/zbz0yOZ1U5rN9MhNtdZXYKhqXk74xyZnKq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645525; c=relaxed/simple;
	bh=V+Xc+gnGUSlatwR6xO+m6P3xuojSJkvgpNiZT2dRtjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFTZzqZgJcFjq4ctBgei6EHpnP+v6oHeY9ENhfC5Bz8lf7ZImAI33+OK5cVZmgB+I/0H3Oh1jdSFTswfNzdBTT2dBHAav4tjiAb7NKBRnJD1L+K+zH4+5meptcm8vkHOZt/G67kPR8ldOKtLNlVTNWjOHFCBfKVCNe4Nf75hITc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC2OQ2bE; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c565dd3a7so1134772c88.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 17:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776645523; cv=none;
        d=google.com; s=arc-20240605;
        b=XsWm3AoeGEeuRQDF4qE0cYWM4+rpXmAr1yeXuiEMzsSjpuao8WouPgAhOnysIz/u6r
         wK3oNfZH5GZN9FKELReGj9F6Xd0CITJNgDrHFADuuwQocmqZZUGW+p8ab4IiR3lDp6Nk
         o+yy3Alf2vow0DlVpAkBpNXiy/eZzlRmKe+JSA+4fP+/P8HL5cveUxfGJK7ssfjV1UXe
         tDyLkeyfjcf43O7v3dZLAq24jOLHLa8umVx9Yx8wQEf9qSyujWuCTM+tbKZyDTZMFecY
         ajsT9xSv7LnRCFVopaQ6BPlsqEuLQ+yAmM53tFRO+LmoZIYQn+mIj72XsuCxJFPppM2g
         aDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v2+NAjo9ccDDaJAJPnPpHZkJNF/Ek3gXxSOX8+9kURU=;
        fh=paeiikkzxW+mX3mESrN/ZgmCMLso3K/L70dw59tAfqA=;
        b=jbqVzcgaxb+Cyr3K19nMEVMHjhK6ijCDsh8D9EQTYFCqP/VGZCTpfsuKbFQTqgVIfZ
         N8zJ5QQ9llTWpZcHa6bWwr6n+VMq/zAQNcOAWPXr6NYTo1fsG8Q0gWgq0zW8kpCREqEM
         uplI34gF7QTxLvMjHWs7UlLYGULCmbifOz3NpWwPnLphiALtDYKN8Tn3VFGqHXSanuCU
         wKU+2NtrC08iguTnfqGZE6kHTlp92zBcr2B4YAdxiCxE1waSDKLu82/w96sGLX8GOq5p
         N5F4Xs0oOUCZqBRMDfyGZ8sBlHLzTcFNlpDqF6GiWYj3QG5pgBB1amo7WImnawFzri9o
         3rSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776645523; x=1777250323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2+NAjo9ccDDaJAJPnPpHZkJNF/Ek3gXxSOX8+9kURU=;
        b=SC2OQ2bEKiP7e2J5gJMlNDxFxyArBRoEylARrBKCbgT658MNvj6rjA375HmYDgyNOs
         4qa97ve1+We6RT/G6SF9aWmoS5UBVqxCuVJepopr34Um/Q/FkjRgDXm8Vt9neMc76TPY
         mzaT1XNdgZaJSPZKuksdDEymoblulTfcl/9ZH3t2RV+uifN4mhh5TL8OiDDbDwIccTii
         a2If691rDoxTjS1UfVCOUZFBnVSuNHpVJVC4fGmVg1a7PjJyojiZptkidgWEQgx4VK8t
         KpcNbWqeNSES5qPEd3D63lVctqI4JHdlhj/1DwhGrDNJet0qqLvbqOEYkahQqT8cBFuV
         ZMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776645523; x=1777250323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2+NAjo9ccDDaJAJPnPpHZkJNF/Ek3gXxSOX8+9kURU=;
        b=jw14ooOB0dvNgW/+eFybjgFvTVY+ZoQ82jGiPEagEW6lglxrj+n5SZFAjtwRQeAOzS
         7uAXWtrrIAIq884jM4jx8pwUYoC50EJqvEx4FM8+FcWuahnvXf1+Qtr8gS4LXbeEddBC
         8QVIUbvTDhuSWTmv/OZIgv8C1DPl9X5lRgbJswYDICPM++5KDl08bm1RdIzsEd1367Rx
         yTiFU1Icaa3U93GklmmyxTrEpcBPKv1Vagr8TjHFdIAjtEix8K04PbxkHj+XTCP3c6jL
         tiYnrc/9qVLZXkq3MLiZ+/oKbIauYyUtT87IzJin2wzajtT4wSCsBta05R3KZ7HsSgEj
         N08A==
X-Gm-Message-State: AOJu0YyxX1YZC+FzkgnNfcpSZfzTs5DL06jr8rK8ki9b4jZCBE8M06Uh
	uXwuvN58/NzY5dJEcx2Q4rf3qcXyow6pYMDdm9tZQsgs9kvfauyCALYwWSLfAjJeywr85a0y8cK
	XamzcRKAeodMnE5TSpgPzUBUVL0O+3J7wn3H8XQmp
X-Gm-Gg: AeBDietGRsSPtC4RvtoEyQNgL87SFcwnmWP8BOL7NTyZIKZvrc1gIs8XQQsrUfgpFuF
	f7tMMf/cGeqPkg32vuJ27p09/yEWt9RCS0pK+vnxFBxgoZ/iyhV3ekhdq4KWSC623/uWq3x3QC8
	6BLxMFy4b10zPAKH4OMCZNZD7Kdb0QO4U/z1nPYRdSGsPVAWZJgrz9b0hDgGNyLx+LQXdasDhnW
	1lm1k7eBA2FWhsTboHIvvAq58BZbJ4way/ZBPFdvgPSzgIvoFnrL/qWX+w+XQZrlcivuj6Z5cTQ
	N0rGexLv4rcAB8Ev+Mz6FGYC/9h+aBFNFPzxgguxfn4lpihBGdupy8UcOMTlT9gn9E+rAgZa7+s
	zqIfmrQ3MYruX++F9PMKBbskECJivXfbVmgfrFvsH0sXsttgLMTDnNxM637NY4CR2YUYBIO/wzw
	==
X-Received: by 2002:a05:7022:69a2:b0:128:cedb:33ba with SMTP id
 a92af1059eb24-12c73f70ebfmr5674965c88.10.1776645522913; Sun, 19 Apr 2026
 17:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
In-Reply-To: <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 19 Apr 2026 17:38:30 -0700
X-Gm-Features: AQROBzDHytxBlqwozveGT6CDT-CRYyJYH_xWO4Xuf0Xb-n75HwRhJREtNelKaEw
Message-ID: <CAAVpQUCdXJS_VNNjtq_oiygaMJiFMoaJ2kynRR+aEu=-3aahqQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix sockets_allocated imbalance after sk_clone()
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279614-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8A17A425EF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 2:09=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> sk_clone() increments sockets_allocated and sets the socket refcount to 2=
.
> SCTP performs additional accounting in sctp_clone_sock(), so the clone-ti=
me
> increment must be undone to avoid double counting.
>
> Note we cannot simply remove the SCTP-side increment, because the SCTP
> destroy path in sctp_destroy_sock() only decrements sockets_allocated whe=
n
> sp->ep is set, which may not be true for all failure paths in
> sctp_clone_sock().
>
> Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Thanks for the fix.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

I fixed a similar one in 622e8838a298.  We may want to
perform inc/dec regardless of sp->ep and simplify the code
once net-next opens.

