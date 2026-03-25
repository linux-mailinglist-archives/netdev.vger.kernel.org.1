Return-Path: <netdev+bounces-271640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMVUIvEMxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:27:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0292328F8D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8A043175699
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2823EE1DF;
	Wed, 25 Mar 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8jl6zl2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A513EDAA4
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455090; cv=pass; b=Kp7+NzsHfc4SD/YVnem2PHh0J1LMw+XnrfRVz1IM5P0FXBwsIhSD0/XCPZ2jJa+8QLKtJy/D+cSLOFUqrqcFl59YSnpdqlDrbmEv7kNCaaxeETQzLxlEmE67qj5LgT/Kv2ZKIb9nqnvdiigjEoVFdKDT2e6L2oH5RLjFjCSjedw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455090; c=relaxed/simple;
	bh=YMUAIb6+tjHByjVsb9gE6RyJC7u95BxISweEekHtmA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ+XoaBUYFyLJjUFHuUVsP3VEujefAiu05SBSMyQz0fwuBkBGmR0AUiR5WNZzZxCMS5L7264QzXdF3EGb53sTmjeLBdPR+xw5KVTHOb/IL7HTrZHlQ6ckW6iPWxdyoYU8FqBuCzr17FsHCMugLEXqowRm1WdXvxyGH2cEyGjanM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8jl6zl2; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-604d52b65f2so23330137.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774455087; cv=none;
        d=google.com; s=arc-20240605;
        b=iojh+fogbioQqCVWT4IOvTD4LEb6NH+TnnszKB6u3Unk0MBnsUDlubVPAscdi7XPUg
         OArenMR5k3f/0FGESmCs5d4GlofDaytVlne4P39Vgdxm0MFynVo3tiAtQfvw6gVHo1eO
         TeUKVL3OeII2GexsR8X2yYHBATY1Wu7bIiBQzzLgm/V97eFjzgBCMf7Z/F3B5v1I87k7
         26p2g1lAo60xHDpT2P5hRN4tdRZDvPsXTVEIyHVEeJHXjKoby5uTh13TGsP462oe9djf
         7N4+2S9VKh0t5nunmvGHVd6WkizuprHwTvsVNbQ6WqMv/TNNx20wiK3mGIAOjWFYbXBF
         rfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ob/tioij4RGgCuGhzry9vdMuXjlPnMpr07oWMA9ttyM=;
        fh=D7OZJIWoBHk/0YDWPtzojzTYg1hOAy0c42IDQbtT0Js=;
        b=PtQ/NhH54HOodam8HyDwOXBXQWLzJKMguq4CszduJoDpkytVRkyLBqYUHmdkl46bu7
         SLSyks7SnoS9AclhJZ0ajQa5h3ZbO8Ul5B5O5NGTVWhmc/B8ZAS1IIGtq4NITnlqBzIk
         uN8AtKhAeWmGL1w4BL69wRyQtscHMNocWza+UIcVHAjTGQhHmKaZ1JGnCsLYW5841rXI
         GiQCiVgSCVv3OzjC0ueC/fiJIU8gOI3699cDKs9B1AxqAt21TlePl05KgUxT5e7/wnr9
         BquPJYcyU6AY3MywKlmL8SOwgY/KdbBFnYWDfYxj8CZKMiK4OLrSqN+hJ0dJDCoNtlCC
         Q1Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455087; x=1775059887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob/tioij4RGgCuGhzry9vdMuXjlPnMpr07oWMA9ttyM=;
        b=M8jl6zl2/+oV9eEvPatvk6iLC5oCRgnymcfrzHlDiLt867zb0/CO3UGjRZ4nBKA97S
         qQARg5ZU3I9sC81wUFiiKNaCW5eMeTcNjpGI9uWzmXxFXUEMS3NyRP/4mD/9++LIOQnM
         vPg22G7mtDnm+3GHMV1MPqAro6qydsPEEulmTwYkx6/La8DUbHvnpzrHAdXqUjxVbRPb
         oQ7voWlpEb9tVuGECzf2N/dmoeAzbgHVcawwoFD9KI6OW/A0bjoFXP3W9Phpezyf3sNG
         1682QQjl77eJ34mXEvCvPBTPCOOqbxrId/a5+cFyvbAAZwp2v8ZF+tOzsV+SF1WgIERI
         51vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455087; x=1775059887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ob/tioij4RGgCuGhzry9vdMuXjlPnMpr07oWMA9ttyM=;
        b=IeIK+ScuzSrcHWvUABRI+l3FIgcwkZAyFEOBotH0Qvp+FIV33F12B+FCLPtya9xjP9
         eNTJRm2U7eBEBtg20NqVr2c9qcMjNkrWruJ687b2oylVFBw6qPFEl6kATZM70CjER5XC
         0aiy9WHuch582oIHPH8JGFFKWcUwnDdWn3p8AZvIHl/WbL9bP3ls9AQ135Bf1IBCUvab
         aGNHWNI9ObvCUPjviNH9lZrJv/oa9qgAFB+QvfRl76mdd3AvpuaxfoR7w/3ncuJBBX8M
         agt0lXzXjzg+rUPPbFAtZu1Ap5rNUANJbsRQLwfi0mDAXY5ZmnRvK88TTx+VQtRlnYaD
         IiAw==
X-Forwarded-Encrypted: i=1; AJvYcCU1xWReVCmGCDk4ZTDuwC9RBNqKp4cAS1MvzhqfnOUiQ2tKA9ftg+7gGxBJluGFyW4NJZekzZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4rbLJFHE7vJJ0WL/DPpJ6+8GO8EN6wRXVOJ4nkC4SgIqrwJZ
	tZLvoXQ6KH4FfHJzDw8h7cASwVx3xbvQgui0coKDyXk8Zflcq6n7CnQQPMZzR+LiPWvj9Rlxkh1
	aAgkDjWfXCTyrNzpTxFV6+t2/WnMLntM=
X-Gm-Gg: ATEYQzztuiIKbN4QnbQTEm/b3CvVqqBzVX/nlrCjl6g3q5W4jogD7Fm9SCYTCwX2jqv
	sPvw8TmhmyclDU0k9lG6yfm8D1yrQO9e/jrKKzvjxZfnOg7mA5YkIGmcWpvULY9CZwqq+8fbzsa
	NxZT3bCQcGDLVfGN/3v8P93W2eTN6XmLqkY9WTGrobrck6j6OWRuPG2Na4Vxn5LGfp3tPy7SnHA
	NqSYNSaXiXrxrDnYZ6sg3fzOj34g0mniqormf9fZAEbnW6jPEHDFlMYGHU2Ac1NelgQ5GnpgXV/
	GNDuBnI=
X-Received: by 2002:a05:6102:809e:b0:602:d52:a32b with SMTP id
 ada2fe7eead31-603162bd00emr3341319137.21.1774455087102; Wed, 25 Mar 2026
 09:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-5-seanwascoding@gmail.com> <15f31b98-aa14-4f58-a685-d034aab61d73@oracle.com>
In-Reply-To: <15f31b98-aa14-4f58-a685-d034aab61d73@oracle.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 26 Mar 2026 00:11:16 +0800
X-Gm-Features: AQROBzAcweL5KZbzaZMpRagT77JFccHYGYrKwnui_hP3RMItd0lsAGF-3oSU0wA
Message-ID: <CAAb=EJWNU5DMhOZLifbPe5DCgQaWnXBBwRw81ttxLpFGKOtiMA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] nfs: Refactor nfs_errorf macros and remove unused ones
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Andrew Lunn <andrew@lunn.ch>, 
	David Laight <david.laight.linux@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271640-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,lunn.ch,gmail.com,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: E0292328F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 3/21/26 10:15 AM, Sean Chang wrote:
> > Refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
> > pattern for safer macro expansion and kernel style compliance.
> >
> > Additionally, remove nfs_warnf() and nfs_fwarnf() as `git grep`
> > confirms they have no callers in the current tree. Furthermore,
> > these functions have remained unused since the introduction in
> > commit ce8866f0913f ("NFS: Attach supplementary error information
> > to fs_context.").
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp=
@intel.com/
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> > ---
> >  fs/nfs/internal.h | 28 +++++++++++++---------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
>
> I need an Acked-by: from the NFS client maintainers on this one.
>

Hi Trond, Anna,

Could you please take a look at this refactoring patch for fs/nfs/internal.=
h?

This patch addresses a Sparse warning reported by the kernel test robot
where a ternary operation in the macros resulted in inconsistent types
(void vs int).
I have refactored the macros to use the standard do-while(0) pattern.

Andy Shevchenko has already reviewed and tested this, and Chuck is
looking for an Acked-by from the NFS client side to proceed with merging.

I'd appreciate your feedback or an Acked-by if this looks good to you.

Best Regards,
Sean

