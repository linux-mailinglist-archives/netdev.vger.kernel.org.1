Return-Path: <netdev+bounces-280994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qED0Nix362kQNAAAu9opvQ
	(envelope-from <netdev+bounces-280994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:59:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB745FE67
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 515DC3058328
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BE3DA7D9;
	Fri, 24 Apr 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtZEhiRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A263DA5CF
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038922; cv=none; b=DJDI7p24nrqEGJecBELAc53ja0JZACxuVEQ9RPWCLJqPzR4e0jBRtcHfGwFBWo0ksg/S1pNGITIr9ulp7YikVvyJTXC1idjWvFxSarz6NCWtBoolWl3kMyvCcqosZocQ34l4SgDaa2Rlm6ff7ee/nYSOJy+nuZzdTTaQOkY9Aho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038922; c=relaxed/simple;
	bh=wgagBRLyH8qIXtovF5EORtrU1tolXN7HaHIjxp4hZQs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cySWIG7XfE00u5bW0qzRAe1aBtvUeWyK1TcTqZDaMoV0OEhD95FlbNlZrhsCuutFG2sSoA1sxpI07GcEZZTHeStQYfqg9y5/1aroBaQ71Pssw001vap86zi6gbEx8Qfn7VhA94cw2Sd1baGPfcB4xomHTcUgh28euoO7z/6cSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtZEhiRy; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-409de4132b5so5050022fac.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777038915; x=1777643715; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQvhd5LemKsDut8MhDcz3CF4XZzc0FmAPAe5hBLKUsA=;
        b=HtZEhiRyiCTXLPoJBaYOLq0gzp37SzJNBkBiGbL0SAophDvy/Bl0d2RFNhtvC88h3d
         8ayEIlKwEyv2KCDUmr1RUVWdxQh5hLn2LJmPFoUXBtBRk1zWIDnuhou8CZjfPWtkm8wY
         xKqJIuieyX0H3fTnSzxSEIan83L4L7RPqpWP8DL3O3goh+MKZ96BBjBIhVRHqeSV4eyv
         xP2J2Rtk3/fAn/Uv/4J8gd+ffwslluSfCZ413o1Cs3baJcuyLwhXqm4Sk5wDMkfDks89
         iu6rq9BWX5ItgXSGS63e+0OazMcqA4EUMzyG4zOw6lIhtcWh3vkjjsyeAl2Qwhgl7VdN
         hBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038915; x=1777643715;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQvhd5LemKsDut8MhDcz3CF4XZzc0FmAPAe5hBLKUsA=;
        b=suwzh+TnIeSZDSqgnSoEEtIrzrBSVSH+UTcxdlJ9V6kExxf818OPo36Mx5o3oUXfjM
         ORO8GiIjC/eB1m45a6jOswmxAKgJwK9Ji4dvr1PA0sH25lzzSeL6Ef5I68hfa7Az2aJF
         MmmPjKKb8PTejHsxaI/vfpdIvRTYGhZ7Q1521kC5u+P9Bs3WfeDVSEPcNxAl6sBeScL5
         cWu5CEkg4n7BUg9xpoYPXQFbJbHfwUUgs9/YrWxPnH8NbayIG2y+hQAemcHOKosgdh8+
         IOgSggvzgPzxhX2abJXTaFMTNoIj+pgNbUQvUdrhWrPLE3bZ4MtnXigwrxvboKyfmeYz
         2s/A==
X-Forwarded-Encrypted: i=1; AFNElJ/K6fK4wW+Z71LN4Aq/ctD5aDksD7Yw6VzrB5J5P6flYO5bwaY9gLpXZP6vp1kLpe7s7eMV/dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YrFwxQ/XunrNcZ+JpCxqqSyx5Ww6lBBi0+te3IkgcBGhbAC/
	+wqYQNo7fLk4nZ+wSRbbpL/3N/Jg3VpVjfEq7dpT0gfd9jwrsHHXUaut
X-Gm-Gg: AeBDiesJ/qvVCVXeLNm+W9y3SAEv7C2v1gMUq5c937n8MFuscdNouT2Vhenuk8joDZY
	2Rn0m89sMySiVOaZQ6YcJz88Rxc74u5lgNEPI5PwgIifm6DnyrKctsdbi7AJMAt1oeTsHtxP/Sa
	77bdaoRGTsvBuYZRngwtIuYPdSP9EuzuwXR3/7Ml0sMkgr/v9Fn2qHGXbqlYgHpm7hULsUfipD0
	/IoXVcvAKs/PEA/iOloCQInMgWvrxRQT0TpfnCGkaZOC4g68nTo7gW9ia8npYZPGdLCXWlUeYze
	ruSZj+mEt5Pzf8wmeH9U1crtBNR9oWx9FIufGtW1YQUmDUN+wInovn0+usDo5j6y78AhRX0B0fO
	bIWxhFB3/dSiuse2SSwmHRGZ1xk4OewQYtlfegLU2Aub/I1wSkuaDJwkpHBl7Xx0LjzYZnCNw6I
	MnSY3fK3sd3+sz5eGjG3Pb0czO7j5/DvUBk/66fFC56ve3voARvoBbx4g0U5+w2U7X2RmmiG2gP
	4TUtLTeA24Ph0bKW9LjS9BEzIFD
X-Received: by 2002:a05:6870:ac27:b0:42f:d9f8:ab33 with SMTP id 586e51a60fabf-42fd9f8e971mr5827984fac.28.1777038914827;
        Fri, 24 Apr 2026 06:55:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2e8esm21854589fac.10.2026.04.24.06.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 06:55:09 -0700
Message-Id: <DI1FPX3685EI.3QPD29NY965FO@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@kernel.org>, <mykyta.yatsenko5@gmail.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship
 tracking
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260421221016.2967924-1-ameryhung@gmail.com>
 <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
 <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com>
In-Reply-To: <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com>
X-Rspamd-Queue-Id: 4BEB745FE67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280994-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu Apr 23, 2026 at 10:44 PM PDT, Amery Hung wrote:
> On Thu, Apr 23, 2026 at 5:55=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
>> >
>> > (3) Referenced dynptr with referenced parent:
>> >
>> >                      file (1,1,0)
>> >                            ^ ^
>> >      bpf_dynptr_from_file  | +-------------------------------+
>> >                            |       bpf_dynptr_clone(A, C)    |
>> >              dynptr A (2,3,1)                  dynptr C (4,3,1)
>> >                          ^                                 ^
>> >                          |                                 |
>> >                          dynptr A and C have the same lifetime
>>
>> If I understand the proposal correctly above should be:
>>
>>                      file (1,0,0)
>>                            ^
>>      bpf_dynptr_from_file  +-------------------------------+
>>
>> ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
>> but original file->ref_obj_id will be zero.
>>
>> ?
>
> This is the existing behavior. bpf_get_task_exe_file() is tagged with
> (KF_ACQUIRE | KF_RET_NULL). Therefore, file will have id and
> ref_obj_id both initialized to the same value. Here is the
> corresponding verifier code:
>
> if (is_kfunc_acquire(&meta)) {
>         int id =3D acquire_reference(env, insn_idx);
>
>         if (id < 0)
>                 return id;
>         if (is_kfunc_ret_null(&meta))
>                 regs[BPF_REG_0].id =3D id;
>         regs[BPF_REG_0].ref_obj_id =3D id;

ok, but the arrow should still point to first '1', since that's
what parent_id inherits?

