Return-Path: <netdev+bounces-256726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H/PK4Bcg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:49:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FF2E769B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46E9C3014139
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A52BF006;
	Wed,  4 Feb 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFXxzn0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D6264614
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216574; cv=pass; b=s5VsTI2HHvla9xZW8ios/pJrcH4jvR1/FtvwttbeoXXSBNbST7rs/FVl3jScD3pnM102MxfggRijLDvi/zBDuH4RYVUuwIuG5StPxi6UBGkE8mvG7QxlPH/po5bLX8YxT8LpM7+Oi1RX6S9qqv7CWWq4OFOlCB5Lb1SnJl+XwYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216574; c=relaxed/simple;
	bh=8nCEmx9pGZawXqW4rJLwzwVeu7OiTlh9QZywlzs2leo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBP4eoX1WoB3iDhLgYYX76awN9Jkx2J12Hye6nvkfucNTsx2o9trzJSvnqUY+qOPWRwCz+LRoT1F6mRfjlVT1GmUgc/0KSg3qIFXIORQkTFEJJiXQNg2+ULwvixy5XfogMkw3FYZEmUAhWdCrxcD1EJzlgh9o1wVzE4MIaOpMbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFXxzn0s; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649ba412cd4so3782275d50.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 06:49:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770216573; cv=none;
        d=google.com; s=arc-20240605;
        b=An+C9JJBfnAaWS/TleBNNSatinC0B4PZW/KkkHSDXic98YBtbZC9ZMo6R7+s542AZg
         +qpyccF1JEcn6AnIXRMbr0CIqgjO3QvwitDyRwNpgZ9adaNLTiqLzV7Z3v5DJ5B2qgAC
         7zlDhazKDkLBzgky2IKTEzgE86zP4SHHaf0wgb7/m/wluR6icAh5kZNXi87GwSnL2pLS
         OooKLW9oKIcofM3btun9oRGErfv+hSZ4RchZVF7rUvEmtWD+Oz6nszuh6uHbQEKho1/l
         Kl4ySMlQHLFLR3ijjLFDLl3ThfNmyJNiirHw7l4kD3IGE7j1UgpiEMrfHAn388RR4xC/
         QENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rRQJ8kmIh95B7cAXr3f9hZfMeO1OlXge14Yx9BKK9U0=;
        fh=Dp+t+4kBuCuJjW2QpjyvXd3S1HkGvLCCcTf1Db8p2Gg=;
        b=TqcXEzB975QRVENiKM/rzI/37qOa5se1ZSsW59b6WdIGe4B41lAB/6eOdOP/TNVSBD
         G3IdRZi0Ax0IChybctUFC46bXf/Nakkc5U0dEAA9dVUM1SNBe111hh9u+vEZQdaFGxGK
         jCgOBGIYS0D0GLZ+H1s/kHXeL5528/b9rjSwBZX0KdVDVek+yPOjuSEb99A5S48UA3Py
         5nIj/YE1ePBuLB9whuuLvGiH1Ii8SC68fTVzMboGniwr1opyAhA8jcr1U6Rrb5hFiAVv
         QDFf0yRuL2W1QMa6+hHWnG7BrF/UvABdZZ4nY2hGLwr1KXSmlDY8iIZNbP/o4GawJFUJ
         Kmzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770216573; x=1770821373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRQJ8kmIh95B7cAXr3f9hZfMeO1OlXge14Yx9BKK9U0=;
        b=IFXxzn0siJr/IDQgx5bREyPAw3Jaip/uiLI0MSz76ckGiYhclMN5worsdl/jJJ9EhK
         IlJl6T6ZjcLHOlNcFBGqGVTAXFX645PCwsiXlljvxjpyNAI0j0TkgMroQsqZhs7DzlBB
         vzHzOrbBLAzR/9pYRIdoCHdblT6U5PYzXheK54410R9nN19vjUxlHEwPsGKCxm3homon
         NGkRZ2/fDImqpZPqtCBC6XVvKQQNj37dWk0vEZ66cc7xLcDXybfPz8lpdeECF9Pc5w+Y
         WQ4Z8g2uPI5ecvMwHsknjrLu0xdf4oNgW8mnqLAv7SXdtFndBXxEfazZHKlSzxKVuBo1
         a7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770216573; x=1770821373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rRQJ8kmIh95B7cAXr3f9hZfMeO1OlXge14Yx9BKK9U0=;
        b=XrD5/A8lONvDFs4iafh1e3isjArXzYwvIqex2kwK53KC/By4qlFfCPdJasE5ovSMD1
         HMx0NK6z23ju7j6aj3Bd9oOcw2XTfU4rMq/1GrOJBlxYp6YQ+FrP4cZq/49ujBdjmtET
         Bu/kmvYjtEGt7EP7ls39Cy2O9hqGV1ypCGwwOLP7Vu2diScATVL+5+DvK7OI5Wmaa9X8
         URdrFUJlEGpBSY4i7wfY1DGiEcfU+BdiQfuEFWIj896Hhy6GBnrpeH3P5VYtMZxQ7PId
         DJ3hSGk4q/nJlVy/6uPv4u5B725uZB+ntsxStqZOYMW2paBCa4AUDe+Djp4bXFNhSyVf
         zFEw==
X-Forwarded-Encrypted: i=1; AJvYcCU8uUuz57x+I3QLJXGVEiS1PkgqLazMkCLKQzX05GULHh6rOsmGh6b329FmMEnSuy8KJ2huifM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYQMboKxNGfjhSxrVoG4eqyVDelpbAL9D5OhEcvaA8p5Aj1tF
	KRgNRtsuy6xwGsB63v2xKC1W1l8BDYkaPK97noVti8J41fzVtjfEmmZWG+C+acWO6PWfq3eYDe9
	Ti+/dHeoHhrRDoWvS7K2LkVadmVJR8ZQ=
X-Gm-Gg: AZuq6aJkZ9++mUX7ByjqZZ/IBHTkyhZH91YwRBXnntHb/IBhSulU92Ccq8zI5DnCAo8
	h0JBXVaJEwLQIIpJ1HuW9e8LXSmBpiYy2v6mj8xVoez6QsILXdoS1hFUpDZQznX8eeYT33M1CMv
	dbP2hXcOQgu1gpbvf0DVlMN6dHjOkKyLzm/0v1o4IKwYJR35bQkw083e4iigzhnSLCnE+xo+j3J
	sc8ot1bGA7hJKD5o+NKmJRxQUrSuhLtULYCoWbgXZQKMYwNc/wG+ddqDTmkXOYo4D2AOJYdPwu7
	n+92
X-Received: by 2002:a05:690e:483:b0:649:da7e:9967 with SMTP id
 956f58d0204a3-649db332f32mr2176272d50.16.1770216572926; Wed, 04 Feb 2026
 06:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
 <20260203145511.164485-1-sun.jian.kdev@gmail.com> <aYIOXk55_DRFKCqo@strlen.de>
 <CABFUUZG9LnhXc+nsQA28WHiiT33_5wQ82E1bBSBncWkxkXaKZA@mail.gmail.com>
 <aYIpcHBufnxrcv5O@strlen.de> <CABFUUZELXbEKyjMxOBfoL246dmtBSS_oe0zeWwnkmrXXpyv3Yg@mail.gmail.com>
 <CABFUUZFgXooeCgKGypByzePBsHpcPWqnY-Ea0qv4Vd7=yMOk+A@mail.gmail.com> <aYM6Wr7D4-7VvbX6@strlen.de>
In-Reply-To: <aYM6Wr7D4-7VvbX6@strlen.de>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 4 Feb 2026 22:49:20 +0800
X-Gm-Features: AZwV_Qgma9lT1f5fzgI2lPJjnVCSuuPAdp_7-Dop1oaLa1xobYf7wXabtSJ7WJE
Message-ID: <CABFUUZG2uPmCo=wiPe-p0YmhjwEpubmVOHUd6wJ3QtArh=pOJA@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: amanda: fix RCU pointer typing for nf_nat_amanda_hook
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56FF2E769B
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 8:24=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> sun jian <sun.jian.kdev@gmail.com> wrote:
> > To keep the code concise while stripping the RCU attribute, I'll use
> > the typeof(*hook) * pattern
>
> No, please leave this alone, the code is fine as-is, all sparse warnings
> are due to missing annotations only.
Ack. You are right: I've double-checked  my environment and confirmed
that adding the __rcu is sufficient to resolve those warnings.

I will just annotate them and leave other code as-is. V4 is on the way.

Regards,
sun jian

