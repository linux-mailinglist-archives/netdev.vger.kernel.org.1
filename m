Return-Path: <netdev+bounces-291114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBsVH5q8EWo5pQYAu9opvQ
	(envelope-from <netdev+bounces-291114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:41:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B655BF70B
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C044F3015854
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E02ED870;
	Sat, 23 May 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="FnwB/+nz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E92EA171
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779547283; cv=pass; b=XNQwziy6poOhnl6qtBIFEsyWV5iiCNIwokX0LcC9P59T3FhlnqlscncfGn4av6jk/373dYvJ6m0DoeL8rnQaMNMbWPqD0ez9BdhzZIgtY5ieQQK7XmcCs5SvawIF58aVFuiZHTEhPAETFBF2g8eVXOpNkH2dHrhdY10Vb+z5uGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779547283; c=relaxed/simple;
	bh=bZLSF+ScA8q5GWI1Cif0OMmmjOtioPvnhuOch4uXXYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrx5VfNY2Juqb1JEKWadsI1IpAwewmezGgXPVR42dZZQRbNoqEXVLLO8J/h8zQakh1dUQV3tchAryw0Ouv0GcRoIztKnLDzb0o9roQOQ9FU3V4gyRcxizUtX+p66j7oR/x5lS+LrLw1RsOaU95j8Bk1/3CqnZxBdcZibrqgP2SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=FnwB/+nz; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so7994865d50.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 07:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779547281; cv=none;
        d=google.com; s=arc-20240605;
        b=g0Ht9eyBLTAFprCZQT+qIEBI97+o+ajgW8welXuANkejtXAhMHDviCjHsiGqFqZ4Wd
         J6p9JFWA6w7puUKhgDrvtHVizVqrPcrhQKyq1DuA74MJDdVI9LhLQXOU1GF5aed+q36o
         W0vP5GcLMlPsl+TaSgunerRAncGfExjKpVJEuWQU2+uB+t4bqtyxe4Q8I0h0rw/7UC+I
         +gVoMlq4LumJ2MeT0oR3C7VmhYdjIOmWkNeKAs0nwBaDQJc8wrWImNMXKY63U4PDWOxM
         YpvLoGVcnITBabY6t3wM45SOqeCzlcFczP8i/ZtA9myuaQD4ix51jOFB88M8KkV/cEhd
         tM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZLSF+ScA8q5GWI1Cif0OMmmjOtioPvnhuOch4uXXYE=;
        fh=ZkkImlZV6CzROXDJy44ohYU6d6WGlHi/0557IVngsL4=;
        b=epQuZss+Z3gImDcRa6sxRrfX+mN5JOOx/xx66aCKrcsIIJ+lqKJ6+smlvAreelLQUj
         o20KBnE7QYLkgNsi83ziTSbgfCqKzk/Wqjz/nJ2aL7UQBUKxaFaEcNRlNo6gl20dIIKq
         L493mZCKaKnfNZZyRbyzP0haioF71in5LkSZuGhu2RZLvzIdpdbCFvahzZHScaWCinrR
         SgMsji/OyxqcLJUtSGJAaU2gq0AvZoI79bew8EKZas0ZcqZpiSVkbZEe1iBaBXoozLoG
         3LM8BQjodBg88P7ZvoHqIoMJitFaQXWE5rRBr8nd3PMwqnXcZ6oZJwdIUzWkBx5HmbKA
         jkzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779547281; x=1780152081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZLSF+ScA8q5GWI1Cif0OMmmjOtioPvnhuOch4uXXYE=;
        b=FnwB/+nzEoa1YPkktnRpsVB9ipGd+nHsivB6dDJeCn+eWba1J7UHVA4vGkDIlX0/qc
         8oLtK+RsIsdHW4aX83aq2EeiQstqvUhnldUg0ITflMkOopfWSk/l6GUiHFUnq7mu6OoI
         62D28xTz4rVqFxpQqKDvvoV/s84w1cOE1cR6ihydhUwC1Ya4/vk79CyuG6APJEWCEmKS
         33XxnWsv8OwRrkJqnqPZsdAQkgo/MWYT9FX1sntXwwWRiaGdqlfUtggpGrdwKMFJXxwR
         xzQFIYT2sHOZiWkCChgo+3T02G2wUso2gSVGOspBiAPRAu96gPRLHRgKKHrWYvGS1pOA
         PtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779547281; x=1780152081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZLSF+ScA8q5GWI1Cif0OMmmjOtioPvnhuOch4uXXYE=;
        b=WZj381lJXy/nWQuVjWDJCPRTCoE+e9IQGworbTV7kQca/IXhYQs4hJEFwbgNaJXAAa
         iSpW7CyyN6gWWlZ37G4OZJXmuuaEiER94d6jSnrbQLtWi/p5ZLqr941mCqEH+6V4WrWk
         3VYSI4cR4wH+yNYuAF4q/qasL+/w9awhbEKSJ1dtQhPIICKBa5CYOnTx2A9HqX/UY+Bf
         OZtbW8TApPNLi1+27Pa5Ndh6w8SoHqVtfN/QCHHROqf1Qr5G5R5xcNyjRlyQf3Xz5DOA
         /hrCoASJakSjcxYDSipCV9gptldh4+tg6IUklhd3+ctgWBP0PrY94qqFl29Sy7F43Zgj
         z7rw==
X-Forwarded-Encrypted: i=1; AFNElJ+WSAiskSX6kSvRcuj1Wc82gs4B8/tF8sBVE7s7zUjZqOoXllz4CY6QlG9fhWFxnow2Njd66FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfP4RuqdQtQ3IaWyjhL2NF6KWNWMjzsTKMQOyiqoatlHOxriDS
	PNRSpWLaOxE31eSk4NNxxewJ+VEUQn2iPyqwRyMNJ7P7+N/30BvUtLaZnR4+sAop1+lTT3l9fgV
	ZNrC8tR89djvpxo4cWUJBZMZSLIn79Ezy8AUMyoDJFoJz/Co1tVD6fHADHq4=
X-Gm-Gg: Acq92OFc409AWvE/m8VsB06qjw7p6/uJcXYxJRmwCyWZj/NEcx/3k1TZYvKH+EXeeGT
	KR52rCrIjeO/I8fW2r+b2y7l6IKo3+KIruoXWZkBL++MGnti855aSpCJpvxTeXJrOKXDxPPsebO
	XL2A7SX+4A4WoYfUmWlPt84wO3azf7jdHqPGw0wK0IGajqgjt6XSwqo6n6abSVkocne9OGx097n
	wbvEc6sq5PNx/YeYjzIyvr+Tiem8EwY8HNOybqP++riNl+cpWKOr9nKWTofrvD6toC4a8cvCPee
	5a6HFw6ssRE9HEDbbTF8F5nXzAWF6d+3qfpBZA==
X-Received: by 2002:a05:690c:b01:b0:7bd:7c16:170e with SMTP id
 00721157ae682-7d334ad4e47mr96399357b3.22.1779547281170; Sat, 23 May 2026
 07:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522110356.1403343-1-edumazet@google.com>
In-Reply-To: <20260522110356.1403343-1-edumazet@google.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sat, 23 May 2026 11:41:09 -0300
X-Gm-Features: AVHnY4IDFeGOhsukpSer7jvIMsQqex8TqV18rBQ07zumaZOiEnRBc3P8S3XmxUc
Message-ID: <CA+NMeC_7OxAHnKno9d02=t72DWeB-oR4z5Swx-T1s=LLvhZP3g@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: sch_ets: make cl->quantum lockless
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291114-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E4B655BF70B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 8:03=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> cl->quantum does not need to be protected by RTNL or qdisc spinlock.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

