Return-Path: <netdev+bounces-269172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FV9AJL8umlHeAIAu9opvQ
	(envelope-from <netdev+bounces-269172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:27:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC02C2015
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AC23029AD8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341DA345751;
	Wed, 18 Mar 2026 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GLdvVFs1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA3331218
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862002; cv=pass; b=pGFhBbd/pGj1AWt9KegE8GmTft5+YH+3vIRd7nFZvnoWJ3E/K3RQOlXzXfDB4t70YaP+R5vsIaus7HnLCwPqxMb0gW8lHitm8J7fFmAfsoe6xywrtPcWV1l92uEEZpb0WhVUnF61n36ugLGagkCXgRT5NhgAEEUsAdrTixodjfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862002; c=relaxed/simple;
	bh=fHH5h0Kf9IX+4w1Ud8s1WpfbbrZoo/wNnat1/jRjPVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrOB7pDAsT0oxfsLBh+4oxShcZi8gNr1Tf2JZi4gL+QDdamxZ/taCt9s1yObGJ0MoPfFBQF90lwTjMh6UNqY2yTDSaYUkxbnFIwdFJa4DYCGcZg63Kdv5ae73vAKvuAYjEblaXLC47BuRNLzj4U4d2vSQGYoi6yyif9t7n0hCSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GLdvVFs1; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso528665d50.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773861999; cv=none;
        d=google.com; s=arc-20240605;
        b=IDK5+WTRBSThKV3EeMDTO32W0ElSPa13vZquKOp7rUtb29gq6ghHfrv9lJtx2Js6jF
         c5OeM87NvVLfdAjTt//AnRVqxDjaapKCQDcZJ/HR4NZhjIpZz0oaMjZMQAGUTIyZYIw8
         15UqsxWiCDnuT9dYu0UJpLTZTwzu9Nl1WccS4FOE6XrhuYFXetlraCjukZg1MN2BjiiC
         Tv4j6zhgUjaKpLUNrYYb6T6fxNaib+JaeBDu9nAQo9L4UhffHhBuCWLb2+B63e8W/Flj
         Zi9ZJQwmr1IkivPPyru7R1yau8Oy69/AFgNZRtrGzm3DqUcaQZaAOzq6e+h9/QGz/Ed0
         9jzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHH5h0Kf9IX+4w1Ud8s1WpfbbrZoo/wNnat1/jRjPVs=;
        fh=4hPQTJ6zwbT5WvXzPx7ld1OsCByUjuabpDnIsXMyt4s=;
        b=KBzyo/Uymr1ddheJDwwQYbk/hHyr0gR8xYm985QiCTcfPbeMcvg0mx524IxF4AWkbR
         CkjzeO8eggHMROCnAgqNWQCIkC34e/mJm7rBA25IGLzwzIv4Rmr26gYytX4IDODirbrW
         R0MWGh2bJ9+9sBKD/J5zQkTvcVLXVNLBB38lwzmVkmu1EoJB8KvuBaJOqpeGcIKiT6re
         U7o0Rt1YZBgKFYVua4NWkRiBrMUSqhwgyQj+UMzDRrfSDczYid79+B6NJzcosbFpV9B6
         ukGqfrL8QLL5D2s1of4WjBB9VUpjE90k2DZtKkURFJxNGjWdMXV96ZHV53L1WHKm4IaU
         a1rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773861999; x=1774466799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHH5h0Kf9IX+4w1Ud8s1WpfbbrZoo/wNnat1/jRjPVs=;
        b=GLdvVFs1rcE+bc3g6gkOsAlxreZ2LCe6KUoHRWqYd4C/1rrVpklMOBu9It09Ftlkw0
         MaqPYzSPCiIHV2TpEsHsGdMsOExtkhTCEzlF1YTIIWMNlltvfgAP7kOaproBg71jq/8L
         ucCO7OVo1f+pLUflfaE+2A79ZM0l5Ev+GQrQGiZNJOHwJX2qB+I4J4BX+Prvewbsvql7
         reBZQwTUHOuBNXhMrjK5u2tKO7ZWPtbYvzgl9HwPTMZPvfvEEO1/TBy1IbkZvkX+Vuhj
         Xlz6HQG46Kx+2ZZsBe3EuoomJkNF+090W9FQpPdu9kULXx1fhyWpmmb7soDdCINFeIzV
         topg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861999; x=1774466799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHH5h0Kf9IX+4w1Ud8s1WpfbbrZoo/wNnat1/jRjPVs=;
        b=UsIxYGoWYy/efb5cebAO8OiEfhnkNot09pFvqpnoK2dHEJYvrX9nKN9/f2sLDJkw4H
         90vwynxVTkl2zma5awNI6fe3UOUOOy453T9BXuYAU0TNNDl1FQomCwvRs/o6ZRA4SMeI
         Mi0q+mINKFpWlEvy88i+bW3fSFFeXPbhahTMXt6Txd+OTFLggvQ/nWYSv/FxC+WgxJCb
         f7K6WpPCi1nm7nK4hOw0SKXi6ozbTbmfuNz965/b33clXfuFn0jYFxijTTsaA0Aw7Sn2
         wlDKd+Z2j/+9GGelIXqs7VMh75qvHqglirjP0lKpCiZmjxBuSBsZQx93aGMS+yLxHYcj
         SHbA==
X-Gm-Message-State: AOJu0YxnQo8qafgbwwI2AcqopqQd+uye3FxC7FqnYwdympkG++zc+Yk3
	Um1l/JLXFa1vLawZLctuO2kDOwISafs6Iy9fSf+6VTwDsCOSAhKubtsH3h/JtV/8pp1UsrCjMdY
	l8hIrCb52DHQgZSrAjYJKFrzu9aTEVo2/whePomVU
X-Gm-Gg: ATEYQzyFSsHHHuAlGizMiZqrY4TEEaO3o2B4XFMlGkRzQJRf2UZw3Z4hGzQQp7OVm9/
	AhYroqiMFuBU1ssQ5NA2aTYTHsTUA8Ubvt9wxtLu/bAUy3qfQcSy2h6US2TXY2jC5EpQqrwA6kR
	dCJkBGFsh+LPVuZByuolCt4FnglgKga/+rRYu0i9/YSBoD9mEJftvGghc4UrjSfGKfU92fw5rDN
	wsjD6V0xYLr+C5+vXfL2GKcajOSTaF2TZMkzN0p5WLvGlWb/4h5QJhbHTTXmBCniJKHScMOtU0z
	z2w/VejnTp8OInA=
X-Received: by 2002:a05:690e:e11:b0:64a:d720:f247 with SMTP id
 956f58d0204a3-64e91332c3fmr3651409d50.26.1773861999484; Wed, 18 Mar 2026
 12:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316211052.332383-1-jhs@mojatatu.com> <20260316211052.332383-5-jhs@mojatatu.com>
 <20260316175525.4f455ca5@stephen-xps.local>
In-Reply-To: <20260316175525.4f455ca5@stephen-xps.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Mar 2026 15:26:25 -0400
X-Gm-Features: AaiRm53AEMx-65qq816XtKhMSKKIUtFqZpKsz_Wjap9gI0JsqoTh7LGJUqQejuk
Message-ID: <CAM0EoMkUKpiLyhHBJKF6iUUnpxA=4ZteBXtMD76AtoSET093Dw@mail.gmail.com>
Subject: Re: [PATCH net v2 4/6] Revert "selftests/tc-testing: Add tests for
 restrictions on netem duplication"
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu, pctammela@mojatatu.com, 
	savy@syst3mfailure.io, kuniyu@google.com, toke@toke.dk, 
	willemdebruijnkernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269172-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: 3AEC02C2015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 8:55=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 16 Mar 2026 17:10:50 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.
> >
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Are the tests being replaced in a later patch.
> Want more tests so that this is covered.

Not sure i followed - are you suggesting this patch should come later?
Patch 6 covers the tests. Do you feel we need more than what we have there?

cheers,
jamal

