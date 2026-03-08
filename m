Return-Path: <netdev+bounces-265328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGglGcnGrWkr7QEAu9opvQ
	(envelope-from <netdev+bounces-265328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 19:58:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F4C231CEA
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D04300D46E
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC953395265;
	Sun,  8 Mar 2026 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlGgG8Ir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151D389E1F
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772996294; cv=pass; b=U69EI/KmkAbTRAM3tMIx68TFVMsg3rVkK66uoI0P3zQhw6Mrdd0Vymy9W3nhgjC+yGfQk3FU2wsws/uCr02Nxt5uxgVfgXbHZeKVOJr3wWT30W0Wqygbjc0oXxJWT9gcSbzmwH+qOB7QkRsU5nSVyH2c+I3c4ZAL6uBHhxlxUlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772996294; c=relaxed/simple;
	bh=J+okUNsU4n0XXov13CjFPOR5tCpWRrmV8oBT26GKEfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A375QY7wyiIOKdBrqlb9jfaSHohHvI+FYxQ2YskdYnhbHHoprKbOMyFlnwIfP3Id6Ejj+pNJ9TjUYWyXFpAf0hpG7M6f/9w6KRrImo/Sq9jM7shdrWhpteAQ6b6T/WUKMfSBAPm+eL9q9YnkmJvFtkwHq5ee5Xm40LUf0b0tP0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlGgG8Ir; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128d2e3082eso1582245c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 11:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772996292; cv=none;
        d=google.com; s=arc-20240605;
        b=CEFQ4yOINI7Xe/BKrewKMQwoOAzyalw6j9B9uZOaiPPicP7V9xir0WzX8MmT/9y4Us
         OBncGrKfXEVB8j9GLwLid52o0VulYLA1bvflnDxixiyS67YuMnWhECRicRODArUJkxGD
         b21C2elS9YfUlJ3Q9TKYECbxpLX1k4LBfHc0rCQWbPvJEapN9bODPqcWZoJ9pHBxBpLS
         00GeB7DclNsisiK5fHL4KqDHoFGZGXM77LWz1IkCcX6FSfqd+uC3TjQOZAjvOKHOeh1N
         wqaohZ4uxAte6WIrpWeEzMpJB+5BQEvW/7twYNNhkrL6CKYINxBwb1Pwl7fCAhW4Hsy7
         XIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oFOMMYzs+cDnMVZz6rJ8vj6DqKrcVUiqEcJmPl3Msys=;
        fh=kYvE7Vl9/FLIMRmT0rXUTm8C8XwElZjO+zp/+h98+2E=;
        b=ApSzHyvj91ZrJhalZzIZ5R9S+7Yhay1ylNUtWPZtGdTWSuLSeElus2WV/EQuxWPhWV
         Z0J6RnKl9MUfFYvCYYxnFwXa+U8ntWq+4/qZeO/WbDhAL/zteE55BwcIM+h2BqKVedEN
         fpRIAa8RUpP3fRLLVfZ6DGM071qVX8zY6jmr2oBLRGoT56IxjcBhtYdI3Bq2x8uOoEmM
         aPvCdfhEIpQSoRdICfXSn2nz5URTzC+3elOco69EAaJCovCDKauGrsCj3dLsXDcp8/UX
         ThMGD17oXElHGb2jarhYY5O+duNn3qTnA3w4GyTQQ3AWf/AlqOqLFGY4JCP5G0P0DZH6
         +OkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772996292; x=1773601092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFOMMYzs+cDnMVZz6rJ8vj6DqKrcVUiqEcJmPl3Msys=;
        b=mlGgG8IrofaKJSmYrKPwtPKKieYKgaiwjqv70tERks70Lg5vPLE+XU0PvYcpX/Sr0w
         pWfQd62eiIssLabP5sr93CU7d1tSAIi6e1Yt/SWq09jzoRnTO1znTomJ72HeHBtESizA
         9GwkZjTeaz0Y6xJeKh6703b69Vr3mtOONt+BJ7LxUUIupOnHJ7VAg1xM2BNJB2deoyH6
         gFpRqFsSSWnmfjrU95fAAnjN2K85yY4WuXE9h6rUdhKMu6HQS/LtX+7uAfmioTgWPRB0
         rF+fldpbKW38jqQYK0jzQUPWZ/Jj64gRl0UaCrZcRy1SUNjIX2qEHKVo//v9agyftGGV
         EQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772996292; x=1773601092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oFOMMYzs+cDnMVZz6rJ8vj6DqKrcVUiqEcJmPl3Msys=;
        b=QgNSJr0q2SRCey7Z6zNFnWIzDMpRXWJRyGoX+tlnxPDKfmJ+QnTEeXIXCFXuSt+OJg
         lSo9BScbTsBpNYtDdEdmCJZ//l3KJ7ukulHaw895xKMiL/klmSjexnt+HAOKibrulDcL
         JfNBsEsfs3K+BYtx8MQDk6jmko6WvWIzJyvVrL+WUor1u3MIJYYHh1t0jE7Bys3y95P7
         nwAOjMQZMXfry0ilor6DyaLRA7yE17JxRjwBfo3dsMkQH0qEIunSF59vEPJxKgXBgGVN
         M8SiHP2xSzr5TC65f4s6ekSAWrsLmJeh0W/vk0hI9IfAEpGGrULjqLoX7Bs12xmYRSC0
         pIEA==
X-Forwarded-Encrypted: i=1; AJvYcCVtCgTjTnom0WX0UkVF+zbOjMo4g4z16fx2U2BsW73dAzp+Uzv6BDUtQvmGY2vwU4K3itX3/6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1otwZRjSEtSZpVBztGETK5kl/OwUX5kDSJAvCdsMTVlg0ITyV
	m94NPCvE2+kiIkJl2ZrYleuD5CMorCcSML7yclSsyPlwhE719Zn9ql0/G3Enu0XlO7h3i76NUB0
	d5V3eV50WhRHlCXv1INXOsdj+u1u6CRRRQ+pRmWIc
X-Gm-Gg: ATEYQzwoFfSuVd4jKqFbxTg4rtSpohDyB7OlBZlc6mkw6bz8wcD1mUu2N2RJeawmEMz
	+9fsXiV3fFEnpdyjLPB1Od3HPeyKcF7kAFbQI3liF2rUqv3U3c1SSm7JhOyEpHmT8a3rd6d6/5Q
	8P/bdAsHG+iP5v+3a5HfVqsXNb8bfYDoIJprchDXyQ7nO8Bm/JLVDYMGCrFnknzLmpFWFpRvGt1
	Q+Wy+3KNQCeSXTVDjuUheRbPvkMZ2Ko3eFYn5ugkvujUmC5pE27wllf+3qKUYHMbVRwWnQwiIyL
	ybPru8iCf026Cb9lWVXoCJTkwNmcGxX6ngV1+FUjRDCzjYKZZCwCVVbf4gbGYPoLX+kpE9yC
X-Received: by 2002:a05:7022:6714:b0:122:153:d161 with SMTP id
 a92af1059eb24-128c2dff0b4mr4373551c88.17.1772996291360; Sun, 08 Mar 2026
 11:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308032304.1841198-3-kuniyu@google.com> <202603082250.0lR88YW6-lkp@intel.com>
In-Reply-To: <202603082250.0lR88YW6-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 8 Mar 2026 11:58:00 -0700
X-Gm-Features: AaiRm50gvdwjwEaFZ30chmoDyx4QO3rQoJKA6k3uOdzy-9ih5FaZdPvPg0Wecpk
Message-ID: <CAAVpQUC3q-m_RR4qvkN_tNt6CKA-8tmQttMaxVy+HjQpXf==hQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
To: kernel test robot <lkp@intel.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B9F4C231CEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265328-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lists.linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 7:50=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/2=
0260308-113030
> base:   net/main
> patch link:    https://lore.kernel.org/r/20260308032304.1841198-3-kuniyu%=
40google.com
> patch subject: [PATCH v2 net 2/2] ipv6: Don't remove permanent routes wit=
h exceptions from tb6_gc_hlist.
> config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/202=
60308/202603082250.0lR88YW6-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c=
32caeec8158d634bb71ab8911a6031248b9fc47)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260308/202603082250.0lR88YW6-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603082250.0lR88YW6-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> net/ipv6/addrconf.c:1282:5: error: call to undeclared function 'fib6_a=
dd_gc_list'; ISO C99 and later do not support implicit function declaration=
s [-Wimplicit-function-declaration]
>     1282 |                                 fib6_add_gc_list(f6i);

Ugh, apparently I should've used IS_ENABLE()...
Will fix it.

Sorry for noise !

