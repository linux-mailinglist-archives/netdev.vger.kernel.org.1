Return-Path: <netdev+bounces-280893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIXGEeuz6mnACgAAu9opvQ
	(envelope-from <netdev+bounces-280893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B58134587D3
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E89C301BC16
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE906625;
	Fri, 24 Apr 2026 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQTd6Oay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A640DFB8
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989060; cv=pass; b=VCioZTj5JA2wgleD8O1TYwFX3Da8vcSrFAjhikvn+GTwg+m46m3U1/BHmR+sjn2B8FU5Rl7pofCnRHlS9JcvXgrLJavH2O6mwpq5WhJg2El2lbMZzFM8LPEdoyYr5LHNhbivNFfw+l+/vucT18h0pS64gO+EfgyijB3Z0s/VFOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989060; c=relaxed/simple;
	bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOb+N/MBi0sqK9ZtT7p3piahQWGbKGwTprIGZ02rWAd4Om1qt30+aWPXrdjQBgds7PLzz0YwBpuJ0nyLLrSEuPg6qhUvjw9Uc2Fn/lZdK3g9ac4u/2aBf7LluUFGp/G+HyK8+Si9PKl90Ko66t60tNvP7hIFN2AOQ22MPW8Rh5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQTd6Oay; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so4258152a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989059; cv=none;
        d=google.com; s=arc-20240605;
        b=Lc6Cr+Jj+2AVXKXponVYze2LkDYvDGS6Pz5rEPy6qq3Sal109lDc3eQq68opAyg7W6
         Xg7JZHS+aqObdQOKMHxxKBQlHwKkCQHaH6ORGK8KpSapu6Wb6Iy1qcUlPvTs8iPnn0k4
         MTSzZWRG3moxBUwKbCtgnswi5ma6kIDi0kpP/8mVEDps7SLhI/yMZoLoI3lzsS4qk6rZ
         m1+H4yPJBtkH8Vd6ivQKIVyPEB9gsUrDFZVs7mmteyd+1eVomxcX7m10LeDIIi5bOoEc
         WcuMQCEIC9UwALCdpqo0RVcBxST8pI5EdpMPGgiFnsa2bMn61zimmQ9v4SQw6CUuus9+
         +w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
        fh=/3BlAw0kdJI+oxr/524Qy1w8V+jQc0/9iYpJlOKuF+Q=;
        b=CQoS/b45rMRG7QNeeXycP6J1YK8Q5rvOGGrfDm2UClq9DXMmtg2PWLUVltzZu5kvzQ
         ZBLyLO7KvUHHJKTz9HM6Ja1Dz6jhraH0ij4Tju9YkzC6QPGknKIaklfpODOEcCgrlCCX
         cWLtizELD0MH8Urca+1CxQRqfCp60v4jdl8ckVf907XFgZVjjOXRnc2X8A7jwk37EDgZ
         ZLaZ7hJ65VLNOZV/GBV8gPg/diFhvOfFCIfEET5DSp6BOQ/1aj0k/cbBl8cyy7iGQL2H
         /QrDVmkU5agTN4pMbQ8KAyAGM/dYL2skDSKpTap3P3yDhH5TAGUuHx2r2HuNVo0FTOFF
         ecmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989059; x=1777593859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
        b=jQTd6OaydKPjLazAEMVEqGPFYC8m9dw+0N2AiCuBoPoBbFHONF+4H8jPWCiNUJNv/8
         KscQoSpBIRn19O6ALO7yBHb5XzE8zn3bPecFKVqAstWOAqjpLw9kiZMV7A+5z47zbPdb
         cYnE1oWrxuR/QrjOV5Pn7Q5lXcKnExo9Wj24vptkZC7IKBCn9rVUoAMCVQS5MK4LOf60
         IoEx/h4g47f2C9bj680pir8L4W9BcG4QA68q/6CHh16cckAPIR18i+ZWBkND+2QnlqDX
         8qghM2my7gllhhLvYbpm2Bb1OlncXP+nnzQpaNVFDXfItQydSz+pId3XvDfeeGEUqzQm
         8DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989059; x=1777593859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0xK6tYxs6xHgM73UL+O+BarcRKEYLje82iXuY8DgkY=;
        b=DtrEZGtaCEWH2x3qh5EZ7xrtFy0Fkhmz05WHAWPhFNEzSbH8xMoDqV9022ecKR3pgH
         93vJJy/9zhCl1w5F3v18tGmm1SakGF/wiTAyFlURO+TFeiRYViQd8s4iHBEtzfiVN/Nx
         rGmMHukq22cfqTzZmqOHHu2J4tKSh9MhvL4biPd+ucvgRPCW7o1lJDwjaxNj7NMSzldK
         szq8EmxYIriIMBY1QGBMOTQMR2a+YcReEQP3miDpQXgHZQijGcYWEBJsXIyFhCGpdZmH
         +FwC75Y5b6iPZcEm5HKLUHMuxlgzTwCHI+fZmRQdwhPKwolDAry2ySHlKIC85dllB8U6
         PSQw==
X-Forwarded-Encrypted: i=1; AFNElJ/DmR+GdeULznc/nwfVFsZ66K/YGFIiKumv+oobWm/F3nDyxaFHN6+JRoS+QAoopqNxvLPFNw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdFUM7o56nqkaD8/vu1XZCa7vc30XanFn2P3X2QH/trLnpdKLm
	xoolvRHap8FnY+/fDZuOHTkdkOVAlPW4YsSlTPsnscarHR6c+d85cdQaM3igkEyj7Gz4PX4xwYT
	TCqSxF0SxGbUWviGM2WsoHjJN/2UKw2o=
X-Gm-Gg: AeBDietYAcZh965cDSWLUPO350fF+5eFzSsl1Q71TysIFPg6ryeUdhsZgg7NF5YAMaP
	1DKN6oQnTq5+Jay71kdDumsX+OurWOt2oDEo2EVAMMMJ6wo2g13IMgfDbJIyCfw30prTQOpxxPg
	jF5ENN5E2B93ZF+M0fVOlzVBZ8Uvg3UpbGiB1LSm8TpDoV499mHRRr7KREBmnadT7l9AFR68+k2
	Vj2mT+30VJtyDU0eNx8xDDvgeXxG5FsyFQ/MF+WXqedmuvLJ1lcx71+YJVgZDY6980HHx9tWI3a
	YF5PJRQwu4JD7DGAf7WeqX6nYHZ+lArS5Q==
X-Received: by 2002:a17:90b:524c:b0:354:a57c:65db with SMTP id
 98e67ed59e1d1-3614047a5d4mr30952884a91.20.1776989058743; Thu, 23 Apr 2026
 17:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:03 -0700
X-Gm-Features: AQROBzAzWb8jjj3asOdXVai0jSu2V1BCVstpKnZgbcFIf2Ptc1J8ZRzl2HlK34A
Message-ID: <CAEf4BzZASC15LwVTTA+A7xkp94BQLZjxQa0GUnsXr8T9w-bAgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship tracking
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B58134587D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280893-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Hi all,
>
> This patchset cleans up dynptr handling, refactors object relationship
> tracking in the verifier by introducing parent_id, and fixes dynptr
> use-after-free bugs where file/skb dynptrs are not invalidated when
> the parent referenced object is freed.
>
>
> * Motivation *
>

Very nice and approachable cover letter, thanks for improving it!

> In BPF qdisc programs, an skb can be freed through kfuncs. However,
> since dynptr does not track the parent referenced object (e.g., skb),
> the verifier does not invalidate the dynptr after the skb is freed,
> resulting in use-after-free. The same issue also affects file dynptr.
>

[...]

