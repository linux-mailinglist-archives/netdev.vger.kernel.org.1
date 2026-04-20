Return-Path: <netdev+bounces-279895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sON1AKBv5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ADB432CD9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC0C300AC3D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30B3A7F41;
	Mon, 20 Apr 2026 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="XTQFDTIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60113A875C
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709517; cv=pass; b=lJ13gLYh3mMm0yMxnxdO8S4W/amLy/0o2T7nf7z+sQvmHYNjqNPNvZx0C22rJeu8CVQ5Si4bmMltNaj6D1rWr4EE3u0s62iDCacfbq+lydRwS+xnn1Yel3JwZYtIrnZbupZyZb7tFIjE4jj5g8DJuVivy07biyDENJ7ApPeC1lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709517; c=relaxed/simple;
	bh=oxZPjGLVDhKaoxyys+5R9s2592VJu6PeQN2sS3Vxxtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlJw42CpRyNCG4lXfM74WW6BAQhVXYxuCE+4ugLvRMYah+NoNAk4P44suRxRskI3GgYQAzK+KtELSF4yoJZ6umJQusWXCKsRpFvO5/2wgYN9dNq+9Ro8ninzkY5PZ5SeSj0QglpwrhPOpj+gYAvTZv69TCEM6o9m0Y1hRjPJNvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=XTQFDTIQ; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso4162052e87.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776709514; cv=none;
        d=google.com; s=arc-20240605;
        b=YbLHJnHdkpSOTHsOZvycKr8L5gnF26hh/v6wCMVMOzaqPhESbPKqnBvOFhwqCYm1WF
         NKRnTAzFf68Sdpo7plh8Zl/CDVkIMtkE5hXvJpz5DhrOcdE3saikj9AoOWKNSvcZoNcd
         2u0lF3wFdztipSBoZf516wLlDlPQwirxLMx4muTTtxEYswcOtxBbrEA3PyHINq+ScvTA
         8F9+WjcvHsxZenNpImUKExkdzO4ecqsJRWpo8k3P7nfI114t5OzzgcpVvTUdXaMGbgVI
         W/w3wvOjehhSEFe7aZS96uTmJm1xHBHtJvj1yv88jEQFO31JtYc19c0lvRM0KT/mfzxi
         xHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OtMRuRL7lX8YXL4zldb2SG1xf6d/lUejkE0wC1TYBmI=;
        fh=akcQenVqQyqN8dDIGKO75rBMNjbDAJOrC4OZSF+bT0M=;
        b=XseHyVPCGIOUyGAtx1OO9ytGrt3geoFwevGIk8xyvnbRiGOWRMGrfBUWRz6sd6TcFR
         k8qGEtblZTfdMGFC5UAQMMCvB1DUQqjM8Y32/AI1lPhdGCW5kbFz8wyrE4q/Ru2cNY0w
         9Gq9LBXSF2b5KeUCRuDCKD1Kb5y59MqVvX8seaQRXpYuhAF4AAwvUfaIbugn+TR8k4zh
         6DW5YX200DarK9DBjkgWV2/jOmmUxx4ShCAkx8JFVAyxN8bF5y11c49FWxA2zX2qyRHA
         iVUzQmvM3axYd2kvr/4N7lrJc591z7cQQq24F4SG3QQ2dgA/OSl0CE1pm4+3cEVRZpxP
         rjng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1776709514; x=1777314314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtMRuRL7lX8YXL4zldb2SG1xf6d/lUejkE0wC1TYBmI=;
        b=XTQFDTIQQI1aqsxcnCNt30nHUv7EEnu6aFIGE/rBDqpSiJSzEkjkBbElWHzLBr87uG
         tmnp/T9b//GamGw/+p8Gz1wXjL04jjVMLAmsJkhEDIG90KrvNoP/xswGC+iHr5Wxcxse
         dLA26KugcX70EbOd6JGcbPJWO+U1oH98bVOF9ekmTt3vlSZ58PS/M9cZy3PTxbfyo9A3
         C4M8fd4EOYJ4MBEGOx0wfBlCrfgMWvSm4ZLFyn7vcdLNT/ecUvZC/XuoVIOyYW2VgWYN
         H49vIHJJ+6KrGYe/EazfBsZFWZG5S5xRv+faew7v0Dq1ec+7ZArMCDApCxglMW5EUPbX
         axGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776709514; x=1777314314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtMRuRL7lX8YXL4zldb2SG1xf6d/lUejkE0wC1TYBmI=;
        b=HjGs0qBHZS7u7mDcEECuSceZm2KJyYqkzFv3tEagiMjVhtWeAnIS40hQwNaFhTkSL2
         QX4ATsHt4FcRFHHgowhicFsu3QX8G9XRLRipFYsYg5unk/PIhqtVT4nIGtuWp2oDwOu+
         Gk9narRPdt1pxy6fsewOZ9oAHxBHo1cfxF5yx3hsTOi8CuWqPRbV/4UV2mugjApgwFFB
         YduY41jC02X3FBHhozPekvCt82D278KIX9IiXlxLRLtB6TpVzfWAnA47kRIhe8nH995Y
         /j3iduEgzi1oSOZgZMMGd1JIAqkN4eNG+pesxp+RJNIax9mFEGXetPsmGJNwqT5eyNgw
         k9hw==
X-Gm-Message-State: AOJu0YyP3ECVzEHm31avaS+QYKs2VaD/bsyj1/WiFA/smq2MC+ZUPQY3
	KcLSsOPNgEexvMnOU/gxI25M3Olsrrr9oNOuloIGC9Ka5kwPYmO7h8uObN54KuHYG0zJ22Zjj3J
	PYi1Q4pbExICQc+hkdqiVIpCy3lHHBU2qb33dXwy7h395ZY7r5gbSow==
X-Gm-Gg: AeBDievYXjGZpfohg06auyHoHkpMHLonly3/bqYyKajW9OBrvXSwecY/F1bZkv7OuS9
	YPQGXi9ntPIfWV5e0VbRkxHS0L88E+Vt1FzAAnBDEQL6lB3YAnfEZPNS9BgwPwsGgUqxGAvywpT
	U09xcSMF82RkNSfOCEfTX8zzDEaml1ZY31QV5hSS099RTJQKhz6yFOTDi9Dg+ZM02ZI9jUDQet0
	Jtm4DJ/YXH0og7ekPs6C8arQvGo+ZwbFBohjh0PggdMduFeW/mMtz6ozGst0jmTTsGzTwdTLnUQ
	4kPz/4A1b/Mws0WDtzdoohbg0RhR89JgC3YP8BW3VP3vVNPqLI+i8PndoqZZgeGe//ut0YylDIL
	9ECXfc/I=
X-Received: by 2002:a05:6512:3b2b:b0:5a2:bc5d:c675 with SMTP id
 2adb3069b0e04-5a4172dcd63mr4332615e87.28.1776709513935; Mon, 20 Apr 2026
 11:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314175124.47010-10-tom@herbertland.com> <20260317152456.1742468-3-horms@kernel.org>
In-Reply-To: <20260317152456.1742468-3-horms@kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Mon, 20 Apr 2026 11:25:02 -0700
X-Gm-Features: AQROBzB3pjeE-Rs5d8EZeie30Y3l4tSm-cYStdgGKX0TNInIbdlYEH3A7O7z4AE
Message-ID: <CALx6S36TUctuC_oftBV3nUPMXkCdsBHjpJC+gtx+iuQ0R93CDw@mail.gmail.com>
Subject: Re: [net-next,v9,09/10] test: Add ext_hdr.py in networking selftests
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, justin.iurman@uliege.be, 
	willemdebruijn.kernel@gmail.com, pabeni@redhat.com, willemb@google.com, 
	davem@davemloft.net, kuba@kernel.org, justin.iurman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,uliege.be,gmail.com,redhat.com,google.com,davemloft.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-279895-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,mail.gmail.com:mid,herbertland.com:dkim,ext_hdr.py:url,shlex.split:url]
X-Rspamd-Queue-Id: 66ADB432CD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 8:26=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
>
> Simon says: pylint also has quite a lot to say about this patch. I'm
> assuming it is all minor stuff. But could you look into addressing the
> issues it flags?

Yes, it's all minor and score is good.

>
> ---
> test: Add ext_hdr.py in networking selftests
>
> This commit adds a new Python helper file that contains Extension Header
> format definitions and related functions for building IPv6 extension
> header chains in networking selftests.
>
> > diff --git a/tools/testing/selftests/net/ext_hdr.py b/tools/testing/sel=
ftests/net/ext_hdr.py
> > new file mode 100755
> > index 000000000000..bfb7da4a7c88
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/ext_hdr.py
> > @@ -0,0 +1,385 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Helper functions for creating extension headers using scapy
> > +
> > +import ctypes
> > +import shlex
> > +import socket
> > +import sys
> > +import subprocess
> > +import scapy
> > +import proto_nums
> > +
> > +
> > +# Read a sysctl
> > +def sysctl_read(name):
> > +    try:
> > +        # shlex.split helps handle arguments correctly
> > +        command =3D shlex.split(f"sysctl -n {name}")
> > +        # Use check=3DTrue to raise an exception if the command fails
> > +        result =3D subprocess.run(command, check=3DTrue,
> > +                    capture_output=3DTrue, text=3DTrue)
> > +        value =3D result.stdout.strip()
> > +    except subprocess.CalledProcessError as ex:
> > +        print(f"Error reading sysctl: {ex.stderr}")
> > +    except FileNotFoundError:
> > +        print("The 'sysctl' command was not found. "
> > +              "Check your system's PATH.")
> > +
> > +    return int(value)
>
> What happens when an exception is caught here? When either
> subprocess.CalledProcessError or FileNotFoundError occurs, the exception
> handlers print an error message but don't set 'value'. The function then
> reaches the 'return int(value)' statement, which will raise
> UnboundLocalError.
>
> This will crash the test in several places:
>
> tools/testing/selftests/net/ext_hdr.py:check_eh_order() uses the return:
>     do_check =3D sysctl_read("net.ipv6.enforce_ext_hdr_order")
>
> tools/testing/selftests/net/ext_hdr.py:make_eh_chain() uses the return:
>     pair =3D make_full_hbh_dst_options_list(nnext_hdr, args,
>         sysctl_read("net.ipv6.max_hbh_opts_number"),
>         sysctl_read("net.ipv6.max_hbh_length"))
>
> and:
>     pair =3D make_full_hbh_dst_options_list(nnext_hdr, args,
>         sysctl_read("net.ipv6.max_dst_opts_number"),
>         sysctl_read("net.ipv6.max_dst_opts_length"))
>
> Should the exception handlers return a default value or re-raise to let
> callers handle it?
>
> > +
> > +# Common definitions for Destination and Hop-by-Hop options
>
> [ ... ]
>
> Should ext_hdr.py be added to TEST_FILES in the Makefile? The selftests
> build system documentation requires that any file imported by test script=
s
> must be added to TEST_FILES. Without this, tests will work in the source
> tree but fail after 'make install' with ModuleNotFoundError.

Yes, I will add missing files

>
> The file is imported at line 12 ('import proto_nums'), and appears to be
> a library meant for import rather than direct execution. Both ext_hdr.py
> and proto_nums.py need to be added to TEST_FILES in
> tools/testing/selftests/net/Makefile.

Yes, will do

