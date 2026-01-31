Return-Path: <netdev+bounces-255493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH48J19OfmkJXAIAu9opvQ
	(envelope-from <netdev+bounces-255493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:47:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9EC3919
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B014730078C3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD2366DC9;
	Sat, 31 Jan 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MICfNkkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2EA340DB1
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885276; cv=pass; b=dCtrhGhJLKwWYzIgw22GszJ2+7sFqBAO9xSfrRFVSnhua/gwWORwsKCSxbEZYJlpgxjI/DbubfJYV0ed+XvgFj7bWV5694lu5ToZ+nqvosCw3vwBMLU8/FBGf1MIfCefBjoABRR3PkOrBxAiw8Abbj8LrsExuPPBeOlsRgqFEvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885276; c=relaxed/simple;
	bh=01NcniRWk73RX7UWSG45TL3VMgsq2VHUVlBj2/LT2S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSSepf5Ny6HSuqrCVuyF6M3uuFniMGF6HFpDetMI9ugUM6JIRNRqG6ihF4UUPPrEmrsZ0QZ/3z9HccVp1CoXvo7HA97ilHHHYkzFx1bh3sa5kI24CNLB1Ddw1k6YzCzvruJho6F1fmngX2SqY4z6Y1a/cABWQ6O/rGHlO3sJc/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MICfNkkz; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64997a5c93bso3470999d50.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885274; cv=none;
        d=google.com; s=arc-20240605;
        b=dnlKiiQf0WIjuZnAu0/TEf2eJpSn0WcNSDMZpGCiCNAGQ8y3+IfvHCRXaPgQT+8RYI
         jX2WD46u642gtyMOJWUnaV02j5unXZxrsmxRcVaBMzpL8zhcB8LsTeDupysVsX2OZmdm
         5xEzdq6Dktn3QDMXxJCArXLtRjW459zlOhmDuIeu3NGeidgdvzONFCmdjmJMzu9+4gL1
         OjMJlmAXrYRij9Ubz7Qnf9KFP0bilJ9PF9bBG2q92t+5hfnURwEQ1oj7MR/XtlIT9sLc
         yzzOvMhl6irI4C4X0eYyDBfkdDWRc9Bdid+t3Wx9Ao3kvuFErgRQeSMnHxv0Hb+YeGwS
         OMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hq6gglAydMNz6LDEt0GsAhlm/k2RMlxREitLZ+elzRc=;
        fh=fmN6jYPHf6qysz3jcBeLOIeoMcmbVvmbsmJDSjmmYEY=;
        b=Frp7pY8QWc56b/46S8PtslUsDn2c3p/U0gUv0owdKv+kGvutmATA4VW6iM9ve9pAc/
         5TPxOUqYal3inr8Xet748trb38qb4PUt0HCFsvE2syBc8CSt/snqVn+3ow8AWpHryy90
         Aj3hM39WiOhEbtqmr7fdm1u0Ie3w6dT2B1JUcLuI/qymzxZzI5AAgJil+fLNS35UbyYD
         uAMxGg1tG9HNQYn1Sq/199n4Y+nyOwywOkT+VL956ag1rtb5Ob3Ra5ACRx/vOjGuFdhw
         inOwMFXckMSCbQG79lPQJnv95Wbsx4vvDJeAczE8J/k9XHba41hchPJGXvKCj9rZSIPl
         6eyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885274; x=1770490074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq6gglAydMNz6LDEt0GsAhlm/k2RMlxREitLZ+elzRc=;
        b=MICfNkkzfJIRUG4hLQVjE8eTBQdCBdXQU6oNsvSaG0O1OWPgC2T9/N2c3YCb1GzYSL
         50mJSfaKRHjT1xrbuhF89RqzzuNPMMfG6/kqApiUB/uDp14uWd15UhL6besBs0dkq6Qj
         Vb4QrMKsvKSy+lXqn8msrcdwwp7L5Cw6WThAGI//G0vK5bF/sI+tHuVGDk/BqCgWQ7Rd
         IYM24ikCSwqgxDzELiP6fgLpRpgklByGGNPFEegxBIkeXsN+Irbr9OjcoxEvcMowM2un
         43jTk0KtRDRUd56bqG6x1zYX8CGPCzg0Mel0PM54QF1ZGJYXPXI/F299Ow6TNInxgbhG
         ELzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885274; x=1770490074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hq6gglAydMNz6LDEt0GsAhlm/k2RMlxREitLZ+elzRc=;
        b=mrbxyFSez1IfEZe3HPE4cZufg19zxFVLprCZOtWJbLJJqfxQf3iJVRrHtzsvDp6sFE
         QszO110kSKQtfr/yezpC2U1vtqtWdXpEXbNgEgLaJqYDVe4EI4beRdPY+EgFMyZDTwnK
         L5aYtyK2xDuICzR7Hd3ACVW5iWzeZv/lt8uPI37PEK76CrMx3ne3Hr3NEMbBteHnkHgN
         uGUYhUW4OSerAx5qldUuCzY1/3OvIgfrvAdJqnG7hak0586FKaFHEKkxgKjnV4iqc/0E
         mgmhu7phVPK2Txy1oLr9LzEsRGLlw2WJ3GhabiRgZvNtB5w9QgPr2qzhZ/xVUUAjDFyB
         zPAg==
X-Forwarded-Encrypted: i=1; AJvYcCX1mkINYgCm37cPbPlP3aP0ID0nau5NEpwr8q6RHnBqVeMLntPPEE0fwS+DAlBvgpsZ3hW7hzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1slm1iIwBrqzE1ElMz8H/qCC8AIFWUho10AOS0H14JYq7mdet
	l/dlQN297vLn7F+2a7igWJ6MTLHbplc3NLBOhdBP2OqO9AT5yV79tUPEqqPcEZNtkkM/XD7NOI3
	7uJS5bCfcHN7v9Rff368AA3XAhN4tNR4=
X-Gm-Gg: AZuq6aJBmU0S3SRmzo8A/v1/2Rjv4ZQueW80zQXVGEYYaP9xq5X/rMeRdQCNVbsPrS/
	YHlGj+qyjwNGvelm7NSdqoEGm2mFRT+s3Tv6onmwnDmCsi35tpttuQW8aMlbOga2gtUa22v47Vj
	vfSh1gFZK5/PG3OYIcifbftU/QeIaus04lLoYyQaXkGpWqgoLveRHxfNZ/4ewRIJMReNqMABdQw
	oP0q4D37RbA2FXIgY55AFdFlh7lnmTC2l+Qs4fES3G+NgcukK3be5tbILKsBREVEs1ZBw8=
X-Received: by 2002:a05:690e:d07:b0:641:f5bc:698b with SMTP id
 956f58d0204a3-649a84ef9c4mr5293993d50.71.1769885274122; Sat, 31 Jan 2026
 10:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-15-ameryhung@gmail.com> <bc860132eed39c90ac3599a9db86e80c781cce157f7edf455826d46260905a7f@mail.kernel.org>
In-Reply-To: <bc860132eed39c90ac3599a9db86e80c781cce157f7edf455826d46260905a7f@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:47:43 -0800
X-Gm-Features: AZwV_QjeI9z4V6kjV9l0CrQHNZtAvmOJlSNJxtI-nJ5LEEqpQRjioTMUKxnFaBo
Message-ID: <CAMB2axMmbZWgY96miTwmvOL_a4pGMdHUOR81ofeQCCq7iqmAHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 14/16] selftests/bpf: Update
 task_local_storage/task_storage_nodeadlock test
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255493-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07F9EC3919
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> commit d58597062a783f7c4b2997c007bb7178b268dd14
> Author: Amery Hung <ameryhung@gmail.com>
>
> selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
>
> This commit updates the task_storage_nodeadlock test to check for the new
> error codes (-EDEADLK or -ETIMEDOUT) that bpf_task_storage_delete() retur=
ns
> after the rqspinlock conversion, replacing the previous -EBUSY check.
>
> > Adjsut the error code we are checking against as bpf_task_storage_get()
>   ^^^^^^
>
> There's a typo here: "Adjsut" should be "Adjust".
>
> > Adjsut the error code we are checking against as bpf_task_storage_get()
> >                                                  ^^^^^^^^^^^^^^^^^^^^^^
> > now returns -EDEADLK or -ETIMEDOUT when deadlock happens.
>
> Should this say bpf_task_storage_delete() instead of bpf_task_storage_get=
()?

Yes. I will change the commit message.

>
> The test code checks the return value of bpf_task_storage_delete():
>
>     ret =3D bpf_task_storage_delete(&task_storage,
>                                   bpf_get_current_task_btf());
>     if (ret =3D=3D -EDEADLK || ret =3D=3D -ETIMEDOUT)
>
> Looking at the kernel implementation, bpf_task_storage_get() returns NULL=
 on
> failure (not error codes), while bpf_task_storage_delete() propagates int=
eger
> error codes from bpf_selem_unlink() which can return -EDEADLK or -ETIMEDO=
UT
> from the rqspinlock.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The typo 'Adjsut' and incorrect function name =
reference suggest human error rather than AI generation, which typically pr=
oduces more precise but sometimes generic content.
> issues-found: 2
> issue-severity-score: low
> issue-severity-explanation: Both issues are commit message errors (typo a=
nd wrong function name) that do not affect functionality of the selftest co=
de.

