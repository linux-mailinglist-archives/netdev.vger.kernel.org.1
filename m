Return-Path: <netdev+bounces-280948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGVfIT4D62lsHQAAu9opvQ
	(envelope-from <netdev+bounces-280948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:44:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A145A039
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DB7A3003D2E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D8D3451AA;
	Fri, 24 Apr 2026 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA7NYMxA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D961D0DEE
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009467; cv=pass; b=Lko+mmFc8phicQVQNE5qgyaf7ift8T7ImG3mzL8KkHMHgIi7eWpstPuoUFrOHBc2kzDiNvAgBOCpbbmruhsXxmlHDS0pQ1xAGZe9rYTJitIgibv7kItfTDtABeo5E2PRNtAUpWKMaN86vRVPJgr72aL45fRCz0DmuIWP0XAswFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009467; c=relaxed/simple;
	bh=Me7PVnkzRUpuaMgGPE1fIikIY9kc5geMAE1gyIQR3no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmEGoSbEqeoCFPirN5Z3ec0lBYdmQ5Lqj2rCC2Cyua9aDADe7sw6lMlFxi6aTfMpZWpE31K9cZdVKAoOElV0US/o5z6mqfL/mHVvHkZ4p0yz5lB1SubODxAHBMYwtryWYDZmpQonn/G0ZD6e0kKgk6iErenjuPBoNsfrrV4yzBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA7NYMxA; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7982c3b7dfcso70036757b3.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777009465; cv=none;
        d=google.com; s=arc-20240605;
        b=HK0AieUxRMBXw++eyhqEWwUZlQuMcfZiS4WDSmoyb2ywjt7iY0kumlBSxJ2xYLr5K2
         AwooOeM4hkcYvYMaEGNI773wiogFxUZYH5idmaOMh+W9Msy/vgSgTvnSO/fTvr27LHrZ
         eoAROdrbrZ2FTL+94j+zkrIxYe0UplCKrYByVsFWTR36ipas46Ar+9CF9GaT+HJmDSwC
         ykL67JQE7JQ+FRClw/Jfnaz6HBtY+VqPmN5ar2NkIdRM8NE0L6mpfRuhcjWdrV2+d1ml
         XMX4fCXPFDp4ovSr3NJT/TeScOu+KQTkUIXDAnSSxic6Ovdi8liTlHXJKLXKrf5Nzc9t
         V2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ceqdbW/Ut0IoYJeEG5SB9dp/Q2HqRJQ/cXBZaU3ZGNY=;
        fh=Uk66vtNJq7teY5orj956puKgAYrtWupbg4LJtvvnMdQ=;
        b=EDxwDWvu6JJWiZ/c/WzofKW5g4Ea8YNzTuDyZVqDhTJCJXeQjyRNAEBMVk/XWneapx
         Q/Y6UL6Zin3IzEFGBh4a29jFU6BkwJspwaqPD/afGv1fQ6x/F9xGz7g7xKF7Bem8Oxyd
         +VbluAtDkiEArVqwwW41/rtH6NhWPvuYCCS8tCn6l6ITXnsjFGQyKgADxUiMv2+3blj3
         WavbWZOU5Y0920FYQdt09e7rlrIKp9ergt0pa70wtLPx1GuQLyBGj1nh6hRKkxiqNvKV
         pyHowtV73+jsK9nWlG0m84LgcG50Fy0f24IkRYSLv/1Pok34kt9T1KG8HVvJXoZIsFfg
         5aJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009465; x=1777614265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceqdbW/Ut0IoYJeEG5SB9dp/Q2HqRJQ/cXBZaU3ZGNY=;
        b=PA7NYMxAWUww/37eepXNDGa2uE7SJolndXF3DUgWaKV1BjeZWx1KyzLdIfGDCH6LbF
         d8HeZcBx/wMQVSw8cs2epGgioSPMYABWxuK2LjyfD6e7oq0ChmbNZAeUrAspIsgii3dD
         NOsQ/egCS7B01DnWUorYUdfXZAd2jQLLkJeh4Co1hCX1gsfz2QEWeo0L0K8bnk46K+qr
         VFi17+PQfwZ79kciRY6VS43VXX35Yqf6iKTlrR0FPxoyW78Ns0pM+tfRX3p2hd8YfdcJ
         v+D5tj057e2X/RdF0ivaPqb20DcxNs+KSqMhNknnZEFJuSwmPu/MKOs9v2DXt37ufRjD
         ATUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009465; x=1777614265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ceqdbW/Ut0IoYJeEG5SB9dp/Q2HqRJQ/cXBZaU3ZGNY=;
        b=YH/R1osdJDTi47bpJnwkLxuWv5JzIA/rFxLcOehhkA2C9Xlml0wP96RRMzkkVDpYfe
         TgvESR4hX6K3Cou5k58CRm2YMon3JyVN8lQf6KQ2ADl+MaMwUBHB/1Qc1Fl54n7PCBq/
         6es8a2hJ4zE4DFComh28bNd02++4gCvd8ywEgk8BZQ2so5szftf/nBf5vAY22DWVMiX/
         QAe3NnBCuiPieTXb9xt5b7N09RX88ZWj4YVeFZuZazmocvosWxPqEjMoqeJNiX/Jm75q
         ohadRSSpi8cDFtmIHrRXUhlQtkCmgTFCz8jF+u8P6CDLrrh1Bbw1uFHe7j4Ura7JKRei
         3QUA==
X-Forwarded-Encrypted: i=1; AFNElJ9Uae45vRrg7pzT9sY90a3TNH6UXVFWsqG0XKfIO3y6WbBQByZ/JISCGpsMoeRqVwqC6WXmePo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPwjWALxaov1yr+zmP++L0rU1kf/ppoK38VnxBhOxRVhwVohE
	gbN+RQ1SVRF6LZukrdIMGNRUpe5H0imP1zHvLaLK78bhkdTd+apRbMTErwCwo1qN7VDWAjDsFuy
	UjI1+9te384Dfqo3TIvq682FlBo9Xu9nT26Ke
X-Gm-Gg: AeBDieuaHnkD3i/DFOynsxyiGZ2Utf2HGAmY3DU4DtqdP4h4A/UxHes9Lg03hpUBaZd
	zghK4J+VM9v6ECIR4TrnnwFyiNcEW8DPtOEKm3Lj3JePi2rcdntxj/EUPCEJg5uvlXrgxP1NgN2
	YYxeDZovc+jq8yHVTh9hLzrCc7q7udAzqvFBU63xgdCUNCdOeZ9jLoba0hKuLLj1dTQqCjRY94w
	28j4k0YOcxveUoxdHM059yCum8C2Zw69Z7EilFp9vNSWMdoBOfXXI0YWtZV/6r8QoROMUA6xxaT
	oEOn1QGXxRE9Jt9iRA==
X-Received: by 2002:a05:690c:3482:b0:7ba:ded4:df58 with SMTP id
 00721157ae682-7baded4e83cmr256598867b3.49.1777009464910; Thu, 23 Apr 2026
 22:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
In-Reply-To: <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 22:44:14 -0700
X-Gm-Features: AQROBzDvPO80brxTqh36WjUyhCJaCY53u6TVux_Thos3y4ABLNBHhCXV1MZzfE8
Message-ID: <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship tracking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 162A145A039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280948-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 5:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
> >
> > (3) Referenced dynptr with referenced parent:
> >
> >                      file (1,1,0)
> >                            ^ ^
> >      bpf_dynptr_from_file  | +-------------------------------+
> >                            |       bpf_dynptr_clone(A, C)    |
> >              dynptr A (2,3,1)                  dynptr C (4,3,1)
> >                          ^                                 ^
> >                          |                                 |
> >                          dynptr A and C have the same lifetime
>
> If I understand the proposal correctly above should be:
>
>                      file (1,0,0)
>                            ^
>      bpf_dynptr_from_file  +-------------------------------+
>
> ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
> but original file->ref_obj_id will be zero.
>
> ?

This is the existing behavior. bpf_get_task_exe_file() is tagged with
(KF_ACQUIRE | KF_RET_NULL). Therefore, file will have id and
ref_obj_id both initialized to the same value. Here is the
corresponding verifier code:

if (is_kfunc_acquire(&meta)) {
        int id =3D acquire_reference(env, insn_idx);

        if (id < 0)
                return id;
        if (is_kfunc_ret_null(&meta))
                regs[BPF_REG_0].id =3D id;
        regs[BPF_REG_0].ref_obj_id =3D id;

