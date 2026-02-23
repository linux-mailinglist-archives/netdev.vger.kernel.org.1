Return-Path: <netdev+bounces-259998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODivDWownGkKAgQAu9opvQ
	(envelope-from <netdev+bounces-259998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:48:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C314B1751B0
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2A6B3016EE0
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6C35C1AC;
	Mon, 23 Feb 2026 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uEYmNzuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553A2BEC43
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843686; cv=pass; b=cFRWjaweETChmlb6QOIwF0WT7m9XPiK0gEns+jxMxdx/un2yiebCgqnIund8OOkYY+/CWeK4zc7WwmITe7POpYHlukfX/jdmfdbkhzdAAEklYoP3RBwimgRnT0NwrGbDog8vY2Yp2mtQUsey5h4ABCfOBqKJrWvqFPfa8InzmHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843686; c=relaxed/simple;
	bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOCilfWLO6qKF05Z5WnvyoS3kaxhkKK5mWoenGNzhcgcTj/rBPPo2qf0hwjkgC+YwleXMUrMiderJbGZxC9xXP2auFEyjNhqZBwKulqyUvP0P3YRp1GxZ8FfC2Z26UElBuftVxIccXxwr7SbwAuC5nRgsT+OdPFSk8Xty7dbcIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=uEYmNzuJ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649b1ca87ddso3589463d50.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 02:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771843684; cv=none;
        d=google.com; s=arc-20240605;
        b=N3OiPYY1nfDBnTzqJyqdw24fhLiLdaQM+NFXdFnjU7Ov1mGjR9bcigrwEUi7cuVqfM
         E8G6ulh/IjDNVvN+UrvJSvdwwEM9oX3y/tPg2dIPE+vvxs6Swtb1iBYYCD959X+ysesY
         7v7L14bkt6sOqnV+E04jgrXYCjd/c50cg7T6FfAWhpFGhn7LNaYWpXx8NSrEiJf0Q8v8
         Rfw99fCOalkfWcIlEr4+2e/z4rKlI9HzMg19vAT0bfKXjjCGupRVDDe0VsCyTUnzG0gD
         Z21de+K/n6DOgJTCdxOG6T9LLWRg9lIKautE9oLj4Zk5hYGjIB4FcjCxfHe7QSPQuPni
         RhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
        fh=CkhlC/wlTyrD0HT9xJALK+obuDNxJPpf1mC5ZudDDnE=;
        b=CU//NiEoquzvCDZC/LBn+QnBVAIEJ0KJSZgy0MmQAiyqQPfb86whzl5iCfKpH9M8iE
         QETicgxR7uYgT83hU/k2qCV5wLvFPI1+Henti7s8FM9PPsO8X+ysMjQIiXVjgJJU+9p1
         jifNQ00dCrX4X2gwJPddsYKy0X2TfqurvRk8EqsUk1cjztui+LPI0I1j8MfEVIE+XfNF
         hUjzXyEOv7S6ri0LmWWpFRIIG7mVOOcbgKroCFya0kVgk6diES3JlrHMzzX2cFdR3Rxt
         2A/CjjRUkgxlsOJ40FPeWzcjJbDdRtBxDWnMcdKa2jBvyvCKqWzUhmXkMpoF76xU9R5l
         JIpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771843684; x=1772448484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
        b=uEYmNzuJY4E+XG0xNDwub7CZrdrz5mdQdGFj34mvZciM20yomwImwvSEvREaXl/dvF
         MV539F98fR12mVfG9nAUq0i3SdziKJ3sXYX/pNCuXgruLrP7lDMInwpDcXSLtdb/KkNj
         o1l90GPlEoc+ixPNF9BYHiR/ZvFCXqIVcG72MjAwqHLKPpHOAsl6Umsn1hlBMBwGp2PW
         GcgkmS0DgycEUZARJ3WZCczfDvWNMcMIgL56Lkln5avhdmJ0ALJg6Xa5jcVOBPZ2X3tY
         7sKFpJMc1XhOqn30q3mUE0YL3TAMzpw6aNmRWypNR1KXo7Ds4guYJJm98Ar/hmB5TmVx
         57yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771843684; x=1772448484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeOEsVeZ9klcyMYyvytk/qdh3OHqWAZ7aYcxi8/K3XE=;
        b=mxeddz3sDsBMPrl8lz9qgEMqG77bGFhZQ+v/rCOhtY0+oK6QJF1nF9+JRlUEN+c9i1
         84U1wXKPVQ8/k2kSwClXlkNeTOaCPL+ddo2XZ4ZwN0YREcsWkt66m4ziSnqmbbzRhqqB
         uBNPZmMcNnjWR05B9EXpvgt+38QdopnLqrFIG0yPahtM9hh6lC6lnvuAwWl5K/FRSPFP
         pZUtji08NycnE80xsytK61eG1NtnzgBSHctVux9CniQYm4Yt9+sKHNICoIhFIP1HaW1f
         QZ1j1Ic4c5tQ4usDejAILR6mwrp7fL1W2dHdhEhUppz7dTanGrDLedUOXdXXQf1AKFD4
         00pg==
X-Forwarded-Encrypted: i=1; AJvYcCXt/hNgLvivX5xB/rnjxUynxFmG3hp3F+3rjIC3vBrub8WBCR7dP0iViRb7Rrk1O+eBfVmTBKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVq0tbzXOnBsTDdzxSSolufGyiuyxDfMKBYhv5GLn5F6scWk/4
	bjP1wqQrVyY2c89wsnK4VLVdzTiEqkkALtzvckp0dC3jN3Gac6xCFSohWpqDsMztGxF5LlISOUg
	NB7js7l0NtGvX439x5h4+2POYeWOqmr5e1uJg6pHN
X-Gm-Gg: ATEYQzyOZTk5V0YEW/keKap/279DYSvu7gYHotpSWvDIW7xvkkenCP/Q7hs1NTRR36W
	hIANRQfhIaQ4LQqFIQyXMXWzymXRfy+c4WFFaI1pTO7Ye1W7ES4qpLYl9xrXtAvnV4zrHTnhTE5
	YLZJdkKaINcazCZfG9JmyzGNhMfTtk9hS80RwWzPyTWYMgKpqkmkDD92hWEpLMQHGCEbFvVfVw6
	ffVW4O0+o83nVloLSyRv01+YHx/ubYYbY4QCHoKa1AMBrs9+aVqKMAd+fFeKi8lCsulCHffRj7s
	Iu3ShQELdN3sodVJaIkh0Q==
X-Received: by 2002:a05:690e:1384:b0:64a:e89b:d7de with SMTP id
 956f58d0204a3-64c78e58eaemr6997011d50.81.1771843684150; Mon, 23 Feb 2026
 02:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219023151.171753-1-p@1g4.org> <20260219023151.171753-2-p@1g4.org>
 <CA+NMeC-WmxL48X5dSqGx5+2T_dR8B_g5C2BL2Hre_HG1-UkXDg@mail.gmail.com> <TtHh0X2fAHdo4Gs6voxOjI5iFT3kt9qJkutxcHLc3nSpal0RiOTy6cXeZ4FSJMRcD2qVJy__ER-pvJhgBhbj9qucVu5yNecJfCeD44HmtBE=@1g4.org>
In-Reply-To: <TtHh0X2fAHdo4Gs6voxOjI5iFT3kt9qJkutxcHLc3nSpal0RiOTy6cXeZ4FSJMRcD2qVJy__ER-pvJhgBhbj9qucVu5yNecJfCeD44HmtBE=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 23 Feb 2026 07:47:53 -0300
X-Gm-Features: AaiRm51lJFg7e79JKgjG7OsGqAzPtwaoRLqJDtGC59XuuJVeJI19kMnYrJ4iZt8
Message-ID: <CA+NMeC9mYweb=uPTugHhmjK26zSgA8qmKM0OJ22jsJZHak8SwA@mail.gmail.com>
Subject: Re: [PATCH net v7 1/1] net/sched: act_gate: snapshot parameters with
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259998-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,1g4.org:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C314B1751B0
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 11:13=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> Yes, I only see it as unreachable code cleanup.
>
> While looking at cycletime, should I move that block before
> spin_lock_bh()?

I think it would be best to leave it as is and just do the
unreachable code cleanup.

cheers,
Victor

