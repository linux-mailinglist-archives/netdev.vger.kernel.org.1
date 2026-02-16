Return-Path: <netdev+bounces-258863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNejMXEDk2nF0wEAu9opvQ
	(envelope-from <netdev+bounces-258863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:45:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B0143185
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C318C300599E
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD47027A462;
	Mon, 16 Feb 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="f7+v8udj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C603EBF02
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242351; cv=pass; b=W+pnc1pHRnxDQocdn1ZxkpjQran+rVls5PKFj9bpRI5pd1NcvxywG7Xw8ICHPlAei23LH/XaeUjbyNRgOodAzToTYf/iIP3ILDwdHDT/W1CMBn8bF/JZhEu9e+zPvBdcn1K/XTdL5O3Yfeu4gfQqrMD6OpgWgfH2Df4mPQ/mDSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242351; c=relaxed/simple;
	bh=L1i0pqAOTmK84ICQU4tMLp9dmOgIYZyfXd9LDT4RKBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgT35uBlg7HC0/RI/JNh9WgZ5OpmJgsKfUj9T5lUJIPEPlLZYejN6dkVfIRFFpzByNIOz71B9MFcMY9qcwbwwyl/JsucnWgPvlGwAuZuRMDgzy7r9Ho+dBcbY/mYwlvQlnz4h45EMXKa6mE2IkvBu/z9ZqYiXW+I0TqF2It9I5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=f7+v8udj; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad79df972so2687781d50.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 03:45:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771242349; cv=none;
        d=google.com; s=arc-20240605;
        b=JHcF34Rs9ZJAoX/PswGrwxvd1iJST8ivLMMxj03xaUECQ/NKEAatlH0o5XENS5EcVl
         Q7njxicEMPZ6w/EqbccD9uJ0/ALyKYva/cvAHa8dFk3KbBWNKpMEzLYlg1gGs94dbtdm
         ngF7xHjnHQ9o5ORJIhAIsjOnmW0JRAYoPBAaG5b6BjRDRBWbQg5pvc1yGjG39iKIY/6h
         fGKDedIy/46Brz2kitZ6tiTX0XGF3ehJjjPtMhiZCVK8Gi/4SHwUax55aEQqXeJrpHez
         QpMQ/T0T4DS6ALMpl8raz06PEVC3Vm5LRg2TxJ2WFsaxsjKIN3jloA/qqPwkBuLWww25
         Do4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xhsuGIW4ZtSYQsgEyVOeXslH17GG7BnwNp6dUGahy9k=;
        fh=JEEmQsKkxEbiDjSyMoLUUK4mX5BwE/G9ZEkbNln/2mo=;
        b=OaD7wrin+BvuURN0jKLVePCxNBsf75nm7G0fEJ7VFDmdxUxvmxHFYNvQd8s0Tl0wSp
         MYM9bS6+ZWIc/1sQBH/h1CAYRTQXwGDgPq3mJyYz7Ovha/MSzB4hc4b4CF+WlfN/t3iy
         M0USotQ8Yift/LOR4fUGsVRHICh5UbxCJUyxkNChJ9+FvZZnx1PXjDVymOyx0dXSw8Na
         1E+iNBTR69Z9EzYnaImyhvnwKYLUXgMce5dIdwa0m/ZyXkJ55jgM8eFZwAjYd3tAgpLU
         /Tehfo2ZwnzOjNpYHMVmi88BELYfePR6L0v9FkjGy4MGeHNDW2HrXnBPmOkTdp0DnYgh
         xwzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771242349; x=1771847149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhsuGIW4ZtSYQsgEyVOeXslH17GG7BnwNp6dUGahy9k=;
        b=f7+v8udjfTWXt+JQZZvQvwRbcMDQwvWfwHr3zyq5LkNYmx7JQzk634Mtx7XJRxmjPn
         Qp2WpC70K75PQL3XaMbXBuU3kbLD6sgJN6pYhrmATovdnfAxZ9He1gwfSrDvfz1y52oJ
         CfE4/x5UEbT0KlNxh09rDowKejiSRzFzLTVbJkLaNfkgvdZbkMlN1WhHlki1Mdpenn99
         FliUyJnpsXIhmcH7XyO916GG9FwzWRrwKoq4HDmvvev/94IYpDe8M2HUZDp1T9A37kvX
         un4i5mY8HXOqhNx9LG71aITJfFGcn81cCpHjANqBukvEcT3JrMP8iigzZFNjdf47c8rg
         5KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771242349; x=1771847149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xhsuGIW4ZtSYQsgEyVOeXslH17GG7BnwNp6dUGahy9k=;
        b=oW+GQzJGWuYZfoiuyijPGY202HblKjpRHr50tXHmPFvheAqJBK+pDQhBQItFKYO5dQ
         PelaLu/0VD/Tix2vuoK8DuXQHLJSMUquqahn9ZrK1rLN21TPN3j14eCOgt20EEn6gPyu
         iFtJDWLbfrp2fDZY0NaHk9GVSFPRSHLmn+Zaj6EQQKH2nx9HE3ZILlSSb6a5Mbf133l1
         rNjRay2tKohFwbCzLNhrnO+YuX4xQMygPGGJyGHkRfrfxh3LtSnN2WqcM4KFh0jXOHq+
         1NQj4GmFvY4+cUx9FDIL85HQq7g5fj57gLBYJnXuBK5Y0EMSiGP+/0P5HbWdV8Uk3Vwb
         YGIw==
X-Forwarded-Encrypted: i=1; AJvYcCWWwsLVUTjEOLtUQGQrof30crvrUB+1KHv1bj4zryk6KgV+VTGBmI8Pd5X2ex1uo8gEnwkEf14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTVyNER/TY1E5m243/iUDFFQmH+Px44v9H0dolOMff8vWn47q
	YcyZcxCtf6lYsYiBLLVsSfL7XpOhX/2BVzSk5L3G1DjV8PSuy7rSgkvC2WUkf+oenUbeDlxwWuZ
	mAIn/h9I1UDOvHE1nltw2XUfadmrR/pCWGCmX3ytl
X-Gm-Gg: AZuq6aJfbo/yUW5JXnJu3YU2sFEmQ1LsfUEktqkrwtirEl/uQirQrYUsU3k34zBspvt
	1zlasGEI7tJxUZGUrKbZVdF4JWhxRjpuJXHP3DZG4wDsY373LOr+2/1DCMMCZO14ZlRbQndiy2I
	gMGF7EHlGq7lFNtQVuF5MqyW/DmXvog3uxnDr0S2vQF8Lr3lTJs9dzBcwNPGzbDWXw3iZ7moOvM
	4ffIJ27NqnmQVsxiR3iNf7rvoUZPeoQdSRB36/Wc/t19A4fd2RLJyb4fLaIdhUPfFB/denzX5lX
	vaO8155WIY2nBuMnn+Ywtg==
X-Received: by 2002:a05:690e:1346:b0:64a:da7b:9f65 with SMTP id
 956f58d0204a3-64c21a9909cmr5013464d50.26.1771242349416; Mon, 16 Feb 2026
 03:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213113849.136695-1-p@1g4.org> <20260213113849.136695-2-p@1g4.org>
 <CA+NMeC805yf4CECdjJh4EmP0RK1AgxAN25V7n+qvOqNMrhVyNA@mail.gmail.com> <6KeZDQIaJkCfZ-04S-pj5o5agVs4F_vy9xt4MfPb_6XS7MKcW-iX-9Av0O0bcURgoTn3T5bcHqRdM4FfSt8BWfjgHmbuHIUG80UYa7Ag-s4=@1g4.org>
In-Reply-To: <6KeZDQIaJkCfZ-04S-pj5o5agVs4F_vy9xt4MfPb_6XS7MKcW-iX-9Av0O0bcURgoTn3T5bcHqRdM4FfSt8BWfjgHmbuHIUG80UYa7Ag-s4=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 16 Feb 2026 08:45:38 -0300
X-Gm-Features: AZwV_QgG3XlpzFmRNpEA0I9A9uLW7JIeF5RBvvVjOd_VFMhWbXpYJyHZTtpVv88
Message-ID: <CA+NMeC_0by0k+b0wMN39m1uMGt6FbJyn89ocKRnnr51tg3sOqA@mail.gmail.com>
Subject: Re: [PATCH net v6 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-258863-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,1g4.org:email]
X-Rspamd-Queue-Id: 5C1B0143185
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 8:59=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
> 1. hrtimer_get_expires() just returns the stored node.expires and
>    hrtimer_cancel() doesn=E2=80=99t clear it, so expires=3D=3D0 is not a =
reliable
>    inactivity test. Logic was that although I detected no observable
>    behavior difference, relying on stale expires could theoretically
>    cause infrequent subtle intermittent misses of intended behavior.
>    It's maybe more appropriate to leave it alone for stable or at
>    least not in this patch/series?

Yes, even if it is an issue, we should leave it for another patchset.

> [...]
> 3. It's the same pattern used in sch_taprio and it's documented in
>    Documentation/memory-barriers.txt: the compiler may merge/discard/
>    invent/reorder plain accesses and READ_ONCE()/WRITE_ONCE() exist to
>    make intentional lockless shared variable accesses well defined.
>    Since tk_offset is read with READ_ONCE() outside tcf_lock, the writer
>    uses WRITE_ONCE() to pair with that lockless read.

Ok.

cheers,
Victor

