Return-Path: <netdev+bounces-286494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDqmJVOFAWoFcAEAu9opvQ
	(envelope-from <netdev+bounces-286494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:29:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7155092FB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91E53008D12
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D43806DD;
	Mon, 11 May 2026 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPML3s4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873743806CC
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484341; cv=pass; b=N19WzdkOOhGrrLgvVHvF7h/VYChd4+zflh/0+Yx8qTj9fMno4aM8zoBgyl/R3DLldXpFm78LospbY5OPzkprz1DhLCVIYM0o2hdKF0JZaDEAKXDS9h30lmMHMNJM2wDg3THkZ+GvEtOTXCrx6qHCIikAACV9aAa/rW+a535wP6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484341; c=relaxed/simple;
	bh=PQwD9dRhs58dJrRipsFaoUlSpPVF9+UKi8x1xHDFYEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSn8LmyVr2y4D1H8Lzm73M2Hz6yayzYljrgJJfrjAtvdoNlO2xsgO5/RWhqQHbgdSRyphMk5mqxJCaigJ6ZdttI7M270zQ8iT7Py5BDUSl3k8Q3oc2GcStUHjEjf6iZoJQFLjrzvSZ0Hcl0iPCGxoEI3UY1SDCoRijzNG9+31bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPML3s4s; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d75312379so3129171f8f.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778484339; cv=none;
        d=google.com; s=arc-20240605;
        b=SjIZWW7e/a0ENGU/XDgdLmO9m59qBCMMjrf75D79dEOwP3clC0NwW3gs2dizgLm1zA
         P7odP7Vq+GUj+4oOBsUZ8JUQ8xckFutEsuoMATfUbEBD57Zau09yoh5tNd1G35dQ58AG
         cItgn1QQvA9L/XYT2VoQcS4AqFrrIjkTTXmZFoTj/beM7a94rBE/W6lXAESXFCABd4eP
         7smetXdz/yDUQPpkmQP6p7zpP0QPdba66P5SQ3qv+6Kpmdw2fvQeKOybFH8sFjckTJ/c
         CbmhtCBgzmtmvvloL82SV9JuNCAe8YEgYaNNF/kHUawEwYvu5SbpspvocyG755hehIGZ
         Kbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PQwD9dRhs58dJrRipsFaoUlSpPVF9+UKi8x1xHDFYEM=;
        fh=h6TBNQFSVTtNe0l5bQu4r4qk4rnrsBS0WdIcCplDnxg=;
        b=hoQL2UZRSO+QSmxeExPNNmskEfubmo2YXg5+moMgJrbPOmFxIlLCiMMszXMJcY6YCO
         44QDGJVlDeHh4cKHrQyf67mQzM+7tBuJqbZoF7QY9rOW0RAKn4uW0CC7iTYJsOCwRgAQ
         /FhRsuxglI7XrJItL3JI3QNutmYVcMcHITiptXuCu4mYu76qhWbGwHNzYLrigZeGIqMi
         76T+Yp6G9ooZrqYIl/hdvSIySQN0XPnZ5nG8DgRW4Psx6r9FBaPMpO2dLaGOp/6EiKSi
         BCnGrgz3ZmX4C+xcpdHtofhiipGmVtsbUkWvdrPTDgMp5MBpzP+vCOYbcNAKkfvNKSD5
         zPaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778484339; x=1779089139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQwD9dRhs58dJrRipsFaoUlSpPVF9+UKi8x1xHDFYEM=;
        b=NPML3s4sRJNRRu3fYQ72m1lLadw/GQ6bD9dSoXhR6OMwPnfhNXctC/SpYy/lhN0Ik5
         /0VBcY8iH264vz/IsKgG8o7ObDJTPEctcT3lnkSRthytbTog/l3u8bsaKimlPRxgg7Kj
         3YhwnLQcVdkjOulTHUshT+gSBdeD0+Jzw2z6eDwrPyVZc8ZNqUqoR+DNYaGWR5RxMPYD
         0fIgQmvQ3t9QSSU76crg+kip+X1R7NWUpQ6s7xddwIqKJbmFuaXjuaXZV5+ePJQLD9+6
         5xqiMQnij6SFr3F6YIgiM8NSqkpSNk9g+rT9B/fl+h8RhBFNcvyMCgkDky+BGkPSpSYS
         Y9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484339; x=1779089139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQwD9dRhs58dJrRipsFaoUlSpPVF9+UKi8x1xHDFYEM=;
        b=cyUBlumJ00b3KE4xWFA6yW/2nm578iwRKsyQpz7v4hpHf+z3mb4cdXBkjFRZ4Psg0S
         18tcv3P/57r/2w0yS2G+GkKURYwgEqDHB1XE6Xk6Ff/VPQ/GJW33BkdrUVMGDJc1l7tI
         SPp2uHaqBtk1iomXBfF33jEif9tcBx2NrOEw1XkYAMPBfuVRHhXyJWtOgmxaB/uNpoOC
         5sTEvMLFB4bUD1e1heo5jpKCJQUvrg62bamr86oNU7sJzr/MzeYNV/3R52fkhGQdCzox
         hP154lP/W2FHokId9ekv2Iyk+Ielpr0MUp7QQvWrRBjVS7Q369p2W6sZmD5xWZzaD07u
         PR3Q==
X-Gm-Message-State: AOJu0Yw5dEiDjQICANqC1qBtPkwDp0jKjS/C23o4WNbMVaDE6+hINTOX
	gHN/NEcHc+Q5k6EX7jucZt0kViGtVd2/5CJ6fXXacwN9G3a+8NHwxfVeJF7xvUnsVSdfiCP3YTD
	O0smZgHz0UvmhxwZ/mvj4jyZu00YxpgE=
X-Gm-Gg: Acq92OF/fbZyHhQEK1SOvC3Redk6CDhd5QY2tuVQTy//1qSwCQuvVUG11tlFIkZu9WH
	jxWaeeZ5sNumjOtpyuTczU0Y38DFMC7ikPigNgbta8XKqQLoc6E8oiqOJDTz0c0mqBqe59g2nVX
	QlbcJai4IcS7RpUMdQ4vFzuoijJbeYqOOMDHUY68ZPmar5qkDlFRKzanYX69KUoOBv7C5axdqAi
	hOIdngxlC5nWVl5c7yJQKzJQsiNe6BMBk4ZYf9UAWcrmrxeS8FKeYn9OWKrZQ0xymuLC0CXCMMA
	nPdzxySQRiRkq7Y4zA==
X-Received: by 2002:a05:6000:440b:b0:454:454a:4cd5 with SMTP id
 ffacd0b85a97d-454455992dbmr12988733f8f.6.1778484338651; Mon, 11 May 2026
 00:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-2-maoyixie.tju@gmail.com>
 <20260430011847.2344915-1-kuba@kernel.org> <CAHPEe=HG6k9mr5iggK52NRgozWYBpo1F_wQEys1=mMpFGumWRQ@mail.gmail.com>
In-Reply-To: <CAHPEe=HG6k9mr5iggK52NRgozWYBpo1F_wQEys1=mMpFGumWRQ@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 11 May 2026 15:25:27 +0800
X-Gm-Features: AVHnY4In82RJGgKW0uqty_Of68MhEZ7XWtCzihq1jE-ZkgV2sNBGhfRgOw10zJg
Message-ID: <CAHPEe=GQAWhGa2TqAhbxD4shmtO8M-+6FAwZfUiubqf1dhfvcw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0C7155092FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,redhat.com,kernel.org,ms2.inr.ac.ru];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Jakub, Kuniyuki,

A short ping on the vti6_siocdevprivate site I described below.
Would you prefer me to send a separate follow-up patch for that
path, or will it be folded into v2 of the series? Either is fine.

Thanks,
Maoyi

