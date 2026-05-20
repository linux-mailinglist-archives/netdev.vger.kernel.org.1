Return-Path: <netdev+bounces-289995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCVNNHfTDWpP3gUAu9opvQ
	(envelope-from <netdev+bounces-289995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:29:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CD590E16
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03B9F3009F59
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844233EE1C0;
	Wed, 20 May 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTJOwU5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC135200B
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290641; cv=pass; b=KvxWNiqULOQBrUX9rJf6c1SFcr3DziFLB3fql1LCdzmst9g9M/Wlq/DotMt2DPjKRC35MfeG7t6spaLjLNGWdi4PhR2MV7+TNyuaB8cM523/ZkRK46mIO1/BlVMJNHbfZ0l3bQsX8zfVx1ggmuXjcGK0HayjWdX/KHzVZ3n6/Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290641; c=relaxed/simple;
	bh=nhJVaTSldyj4EE0+Nc297Wmb3CYpNc63fxJzjQnT2yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnXs5liqQ9yDNNvEtagrDp6Rb2JRgXptuvRN+1tfXwyxEtrAqJeQX9bBk714QjruLWVoJpGolNTCUIy6N/mt5AiNynkrZiELHoQeS+Voj9jy2vkejnCuu9PTfQ+/jvTq6BaWBpTnTSq+15HumUYThKz6VEPgGDdYiPy84fEVnwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTJOwU5A; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7c2fa14795aso37284247b3.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290639; cv=none;
        d=google.com; s=arc-20240605;
        b=dq17ciD813uPJVKdxkQ0c2qr48pFZxWreDhZZjMNavibxMz6M4eiBya00yJUwFPPdz
         XsB61/W+/ifAAPQj5WDk9cXWVcrm5cm36h7LEXs3bt5vNZP154tiryNkBTNWV+oL6jtm
         fIfq9SYOPq/gSbVlTuXRKD67L1JWzeI9JsFkBlpuGnSBXXr2ATmspDrTdgOaF3MuB6Xc
         nSvILDJIxf621UowTaE2mKW4n31sEBoMOLrE+Vr7euqZSiiswcWvauJOm20tf9vCJiFf
         oSETl8T68kIjZXu1FNAVgws8VfB6VrXhyULwyfvtOUM4eP//60rMtl+nBCwXIUVTbL3Z
         tHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        fh=IoHy6CHjzmW7UaXb4Ny4xwz42LOgtBJm7lXBYb0N62s=;
        b=i3IZ8jtCKOf9PFVDrE0Pw7jiVOx5wBF1Of/NLqQyKdasTbW7RIyHAZwjMS9cdL2MbG
         MxZPkPmZwp2hwgj2kuLKLdsjChkTTWcAiYwDLHRbFrAGLU/ysKKCbp+1GEl46EoXT0Fd
         mkmHpyThpAcl2nlRJqnt3rvxy73z3Z9GHDsvwwyanZsDSB3tmUDDNVbLlYDT4QbrgQ9N
         GeTSVNPkiAXcqyfKiSeP6xk1QAuu2Ur/CrWfDF6yWXnYi+AKcFMFEB3WXeYOb1m+cpoH
         Dh1XkS0JAuMfFu4vn34WbbrgcuNDFG5VdI6pCoRLtHbz4pMqrtfV/ibI4E354nzjtXMq
         bKkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779290639; x=1779895439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        b=FTJOwU5A5aFXGnZxjaBSE9HvcqwFUBXOmY0yi69GJe9N+VZUCmwwR3E7hBvW3MpGZp
         6qNpD/C0rZDRwPpJoeyIQP5znrZ+m5nUInBh9ywRIO4F9S1XVJaUMKdzBpqJIds0Bwye
         NZlXEi1PQl3yk+c8aFezB+4jLYIm0YDCocz6RKRWeMzDaP+v7WmXtCBmTWOJFjOgivNh
         ibg9tPh1ZavFmDZLl+R7gzj4QLqiBSWz6OeSW5INrcJE2RsAdCIsTlscWEAdqPhVeZ5v
         qpqph2ScaSicUqQvqhywPKeyTM+GYXCEW0lShPb/CdCAo+ChGoHvKTDB16MuuYNJTOFN
         hvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290639; x=1779895439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Euxc0H4BAZhBGnIdmaTMWo+RLwIiq4MS6lUzgVBLZco=;
        b=h+SryYdEYLdy59ei0g6rWIHK97dTYCNJYmHKKHZ9KC7XNfQKSjilY350iv/miXA4gy
         LNqlKTO9Jp4Y7nrrhJ5kqKgtZG58Bylis4SwURlM9trqFwEPYc9WQ/C+s2np/sofpdI/
         cbMW6qpqp7yxK24A1FymOlZxjKcBrbNdrPOqL2nK947lOkLwTrCLataLdmZCa6FNXQpa
         mYGEaaX1CCX0JJb5Yt79t+eq/8VOgfq8PxOcPDyDbEJNrNhE6gmjdeaU1eTm7/PCSHbY
         nmnaccCp3T4wXWL1LyBnUIzXgN7vtYiDW8KDCiZndEiAF5Az3P9r+2MAWmyKvbLBSGvR
         5nNw==
X-Forwarded-Encrypted: i=1; AFNElJ9PgjSQGn5k2li38QLRLPbeJWvicfcEzLM2ZhCZVcZWHjhajAOhr1Dm8aI3UXiO6bivCOg8O7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yyA7uf/+5kfh4X8OvEeYFlH72VjmzAumglBVyYuOEUzDikN/
	X5Vo/KwfZ8oegeosNJn7Uoou5Vp6Cnhjm2OTMkJRZCiPAqCiixFmIwmF09dX9yI7eXde365rRNH
	fO0UE9m3xLuxwc/4sJ4v4WsxlVlmsx7U=
X-Gm-Gg: Acq92OEF7Mf9SRORQXBLmjaBx/4keg+LzTedJC8jR1l0ivl6MhI6UCbw0N/STJHFSZM
	XubIXK3zd+Y9yudmYOsha5zDIRDsuC78b7ZaedTa89ci1rkrHR9/84AzPO25VTbzBP5z100f8qR
	Sr01u5O1cl71k/EDcpC52z7Mdbb+wJjzqQ9R1oXU/GY8sZb22nlYfuuji+yDZkfKfhlUi8tf4zt
	OxUrwWeCQkrJAjVj9ULBB3USGitTyLQomEHH6sc7esk/MzFnS5Zy0oKfBoFpJqcQRrflWErj3wK
	aMqYXur7fEwZ7uvI2slKputoqYrvyAMBsMqB
X-Received: by 2002:a05:690c:5c07:b0:7b3:edc7:9b8f with SMTP id
 00721157ae682-7c9561735f4mr253587467b3.0.1779290638916; Wed, 20 May 2026
 08:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
 <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com> <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
In-Reply-To: <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 11:23:47 -0400
X-Gm-Features: AVHnY4Ly9EYVafSVpHEUZjoh9JHHvcwwAHH-2CuJLkG1smBNZ9aE0PeIcKBo8bo
Message-ID: <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-289995-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B0CD590E16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 11:19=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> This coming from the spec is priceless because silently discarding the
> packets means the remote stack won't know the responses were
> discarded, causing the stacks to go out of sync. We also shouldn't
> process packets beyond the allowed MTU. Therefore, I strongly disagree
> with the spec requiring an identifier on the reject, as this implies
> that even if a custom MTU is set, the packet must still be processed
> if it exceeds that MTU to find the first request command within it.

Should I keep a verbose comment string about this rationale in the
next version?  This seems like something that might trigger questions
in the future if there are issues between Linux <-> noisy/buggy
stacks.

Thanks,
Mike

