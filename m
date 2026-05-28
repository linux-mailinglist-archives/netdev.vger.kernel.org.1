Return-Path: <netdev+bounces-292741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEPHCpdbGGrVjQgAu9opvQ
	(envelope-from <netdev+bounces-292741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454635F43B9
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E2A5302FAB8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E363F4DE5;
	Thu, 28 May 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waiMAjKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165883F9A13
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980918; cv=pass; b=siLASfr457bbw1bD7Vqse/eklaHtUberM7lUN4Yk4Qvfgigwj3atHY2kBovz6RGRySvpMyzVzlhRImqiDcGWY8xLfjtEJqkNBE5+UDLYYsrTaEHUvW2JyfFpkXY9rXeDYek0vB9u5e1BNQH1FHmKRkXsVewNYjBFSPw4RhBF/Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980918; c=relaxed/simple;
	bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0fAdqGVclhWq0qSfDyiD4RmoA8DhGDpBbApWXQhKr5ev+sqN6A0cfYQtxaMswPpJG3b03eFUfPm/tZNRmwKAJPMlIJ3IdGRzLd2JnDz5LFDbfJQtmVdJqUa2uZWtubtTXbEopINBjsqB4sFMNvB9bkyWNvkDe3Vr2g0XkeQ5nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waiMAjKM; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-963849a4611so553357241.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779980910; cv=none;
        d=google.com; s=arc-20240605;
        b=iL6fDSALIN1v8H3K5ie7UmPzscLYxzis04HWn0lVAb9sx2lPQkpsOTeL5kYRWYh2YK
         RHGjyAEof6f5D39RSBxhJG+T4pRK5raqtPubvCJS2LQCVtoW9F8cOoaZF3+88DZ7zUu9
         nV/pNbaYb7mC5u6fu+n6KCZVupRRgrps3bYeM+a4PtMYJ7a4Qh0S0LH976rQHCmKiCy3
         yW3iuYcmtc7r0vfVAnkq3WlzKI4jXCwsa2bK5whfs5//FVK3Nz0egAk4cqSFCek5VCh4
         DOkePXoHlAzs4aSqBYtRRaVvg2YrHZxZZf9l26gfasmB8nll1g0Lrwrt+j9dzZHOtDAu
         3FeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
        fh=+pGoEC8v5ON2P+MLpO+1MdDqumv6Dc+DaDoH6RBv6G8=;
        b=Y3A2raDR8bSPt1sqsQZiv0SG2Z4Xjmde0+tQN58yzGwtHTWO5ps6cMu0/k0JZE3flT
         5pcNellaKzgSGKs1HVw6ZiLbeySg2S+eROUTE4ZHk/YGiv+F3LFys8hlW7DpR1OAbVWz
         O6byu5dBnOFPqAzbFDbbhx39Egb/l0GR/WMV4I/RBkKVebTukOKVnJlua9FfJ5PWtzyi
         Qj4wD6Buzn03wjAEPR2wTHQLnC0Qgvx6enUOuuwtvydQR+Of3s0qxJjePFylZzv6xt2K
         gJmT7ADZfaUp3wLknJfo2FYdDNV2HdVw+luvDFpxoAcGxRCkiQdJHDxatgwtrs9RgC+a
         QSkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779980910; x=1780585710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
        b=waiMAjKMyMQ/F0gq/JN3nYu8tMGRuRr2b2omRFKXVPVlZOV+k27aBAO3KDzxkW8GlI
         1X14PJjsWyBR89t95KvIr9gQeWtgfvecUZxFDrsHDnJTSH73ZN8XuMcy47nwygk8vKHA
         gvxxJn/9DKWCbbdk5dFYw7I/o5azwQtBdbtm8unAgOEon42OYez3fgyN2/aQTpJJk3eM
         IfO7nD8z9ytSM5z+Dv4FmDdOwekmrwksMGS49DIyC9vJ8496+SNA1QrxRAhrWpL4TNEG
         1JrqrTw7lZnrWa39U3vXcUW49+WXT4+tUURREVVyvsBW6nSY71TYu/oMkiXWfjDBNtLB
         19dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779980910; x=1780585710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WZ4iIUPajl4NJp75JywruKIPXJf+O+1EbtTSz98TYI=;
        b=s3DdagdwkmWiazPQvnUuB7YS3sMG9UFKSST0D0trdN8er9fysEJGb3G4DAtuhocf3A
         9Q6hww607RSCTYbgKHDDBajihUTAgodYvVpQmlMrRzjAyH4U/m3s1Esh3Ep/e31gyV/Z
         etzQ+zPoo7fLXWXMBmSB5RV0RDwd/odUvUexpY+zdQoJb6reJA1zWrxDoSIjENIKbMq5
         81DvM30RXMLpW3uVEadosX/gBlMlsC6CApIPTAfSPgg+nxfi1mpNuEg0RH2FuTXdL+Dh
         WVQiuD7mqfBSb7WJbKZJarC0ig4+b2phlKgAs5JCb/5+EmKsuMZX0ZI/I9zJeI6uhlTu
         EcSw==
X-Forwarded-Encrypted: i=1; AFNElJ84grHuu1cYd/JOqjwneg1rO141W3KPLIv+bkNZLjSxBUEPH1PqhRfqVgrOhXZ9/KpiZeQGbBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqnFmsVLNUHQ/jucZdVmMOseOVcMy7IjQprPutb5JDZ1W8uiKx
	UohdlUXtLlqxW0ACzF7ZvUOVnL8fN+9ib1FhMG9XTqmaaHbLUX7BVukXwU9MBcG8bBBZ+qkjTPT
	r1InBKjdm+yW4ybQDMxZ/jT+tMZoE9FfIf2+SDHO/
X-Gm-Gg: Acq92OHho4b6STjKEfeI6r7fKcido2jaLlUnTI+3gE1v/Rq2e4hBcbF/y7u8Qjdkttr
	1OEKAUBzxGxtwngMAZnusKtTHcpyMvGQ7gnvgilO7O+Bp78b1jM5pGd2UIvYXuH4si+qGBbkAWc
	oeg+bZrp0l/lEOAZPnrUBcwJZMZoEsek0khbEcqRw1kXMrefg/AE/OsufYoIKQvhfx7zzgcsUaU
	NsKldirTkm9tPlKogCOIJSqBP35D5PO95VSzov3yyyc47PcyhmcsQEMI4ZdOVt1/gkNTHv3RPYx
	58Cudj2/Unr2yUte5JkAiZl/eWfNGS5UMnBX0RSIn7mGBUjllEFZ
X-Received: by 2002:a05:6122:4d89:b0:572:36f3:e792 with SMTP id
 71dfb90a1353d-5866403bae1mr13660976e0c.14.1779980909356; Thu, 28 May 2026
 08:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
 <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev> <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
 <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev>
In-Reply-To: <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Fri, 29 May 2026 00:08:18 +0900
X-Gm-Features: AVHnY4LmMjMha3LiIe968snQ7eRPeJFvP-knCBaHuX3iqopfu6QUUqbxOHtspnA
Message-ID: <CAKD1Yr32VMefwq7Bo6_hmhFrDVsttNFwZJZcaXS4P-ACOwWobw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Yuyang Huang <yuyanghuang@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292741-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[google.com,gmail.com,iogearbox.net,kernel.org,lunn.ch,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 454635F43B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:37=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
> To avoid such stack corruption, you should reserve enough space for the
> query, e.g., by extracting union bpf_attr from kernel BTF vmlinux.

That seems unreasonable. There's already a size in the bpf syscall,
why can't the kernel respect that?

Also, the length of bpf_attr has increased over time as the kernel
adds more elements. Doesn't that mean that even if the userspace
program passes a sufficient size, a future kernel could start writing
more bytes and start overwriting memory? Breaking userspace on kernel
upgrades should never happen.

