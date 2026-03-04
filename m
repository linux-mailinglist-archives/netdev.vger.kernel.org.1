Return-Path: <netdev+bounces-263630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNpwM2Xip2mrlAAAu9opvQ
	(envelope-from <netdev+bounces-263630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:42:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E41FBC01
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4C843005145
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904C372B41;
	Wed,  4 Mar 2026 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJhRg7dD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E5382290
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610119; cv=pass; b=uvSSXxSNuzRUtFM7vS/Nm2mrBArcBHMpcFMtkSo4B2EQOlCPNO5a3MYt47gSkhYX2mq2zxRdD5OY2oyZmWE6VtDSIgmCvtb8L8+MsEDmgWQiLN5nXRkxDegt7YjVTNHn5ItxWnBWPiEQlpp94ydVjj08In1abwSV6THR+VTjwds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610119; c=relaxed/simple;
	bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quxAS3+rjc+fuXhHWQ5QD3YzBU0GS5l6aY1IS1YMTOP1H8HtiyAtS7PqkAAvYmj7lsmBrGbXwl+mvqnyTrxs7IdgFi6hwMcAJ40ino0MFGPOogoJZVgbaWzDQczLllxKzdRdJdp463Dy73IywDrlBBhA7zNQkxm6geQENyNMWYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJhRg7dD; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-386fb2c31e2so118848101fa.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772610114; cv=none;
        d=google.com; s=arc-20240605;
        b=CQGcMcaqIGB0OV93zSw7Xodhx2rsyJgW5jBtLtJRqge1KnD13owIAKNFXY9COkq9i5
         Me77ZIaGStd4ai4s9qNxU441sZE2dAgWm8sYzTr9wBT/5/2s6SX6ElOzj5Ds5ufcn+lz
         6fcVTDaHgYX7wD6cfXbNbV/2KXsYeejwmuNymutUDyiCZ39+6BH9Bf8pv4+9Jm5rbPTy
         TbGAbJYSHd90vOQyhEREbH3I1v89GkO2ncVAJdxWfKniG1L2edifm8PYy4wWcefZJMU6
         TI1PaFFY6RXhwuyD7hY75SdRXMsWUK4/B7WON7hmVUv58jBeg/56Xp9HDgm17+4ifn/2
         0wLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
        fh=eWq335HgoE9wufq8cJAqTeKde+wizbm17azVCD5tdSc=;
        b=WdsWOVmWya+Ss8J5kSQ8Hg7ZgA9nJljt/76PV+67B6Da3UGXsgxUwnvEKUMXqLGtif
         v89s/hK8q4wYaMPBDZf6Z+mFAG2PfUkcScrghKjPa/ZK2WIGb4jhXqz3O94y1c7fShZE
         oEjFob6izIa1jZIg8c/x4klZJ5SYimkQ93RymgfZl4A6nua/FkbLM+T4jsRhP1N9pQHH
         BBv9bDuLNSN/UoWkbNtqJR22GFeoomnGRE9L+sVbfslexhDuMFHKDqshNKViEXs7qPhx
         2xJGWIUdRWd/3bnA6ZT8EEssZtuTdCriZ6c4ueTPp5Zl97f1WJmaahOlBJGaOfvIHNH2
         B8ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610114; x=1773214914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
        b=iJhRg7dDg8nKTBaphuwQiEU3LU6r1Nm852JMQ3kD6c2HdOx7VXCP8LbEUgh+uWbZjG
         2vI7Mps6LTkCfEvC8yq623MZDIwkKZ7H8BX3yKac+G0oeoxNGttM8S8aVy0GAw8E/p3S
         AIIiAkf/lpTgb4qtJUlrdss9bwpM+tLRuL4uI9BRaohDRXcUiz6IbZ0KDNqpPH9X6uN0
         bdZ7FLZDzle+7QZvQ2kmIWu4Yzi+9uaRWc0d8pY4J7eafdZqCp33hfvEvjwcarHT5ud+
         rKRvSNm8QJ+ZLm6un1TJUQcSLiSK/7PlIPmBHDzfCnmwFztfkWz5JH1fXfzHeCNV7yya
         ajPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610114; x=1773214914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlUnuSDjsJk4CS2+9S9es8EW3SmkE/njFl/U6Z2OlLs=;
        b=omm9ruj/KHteg/eoH/Fr0BxZ/lJ4LizRFdZptFjiBtk6HiTNbGxo8XDAI27XjKfFH0
         tvW+av+oauW2wEBup4zxqsFQRXZit02KpZ+bT2NgU+IxDUpvsMQKBXhQ7kBR6/xddHB0
         LOdiHQ3eo+YzTvx7fRUOOd6hsEj7kdD9dbRGFZQntbVIiToo0P+KEnDWj6EkJZGC9lFQ
         NeLx2VXFTt7xYOY+YoSFZGTL7Yzxk/UzOdidVLmaardZ0QTVOGeBKL4UXylvC2r847Zs
         ZIhOz3d/hntpWKAvNUAyFJNJQTt3fxS+7pVqMB7FskUNFtmcTTPNlu6dOQdzxooXk4E1
         yEDg==
X-Gm-Message-State: AOJu0YzacXhJexUl3E7E9Y6CNF0ORdqfIhzGKHzC+ubgLR3nZ1EnNg79
	wQlEBt/zJmuU7cmXOLY8mo35r9WcmHNquYINXRKyXc3avkgc6++HWAG4QyODRGYkXm7C6N8MmaF
	6GBWXVcCRRGrrkrfcx6jkV57Pd+vlN0k=
X-Gm-Gg: ATEYQzyqWH77w+Smo4O0PC83/rEdhZFfkTHbJGPQAU113t0+xmlX40DfsxAJ2D+JYXh
	OstUSq/WK930NIe5lr5D2Opv/cz/mcOcNZhrSJJvs/MtRrYGfL+rJS1L68p9XWmtGAetpkg1qxd
	zccZbKoIKIBGSA1krV6aInFHFVC2Qud+mzNpzGQysprwnCy2QjhmNkh6zf2uEy7qsvMs46bjol6
	FXH4HuXnJQRG5aMmxFWk88kM1AMBps+Mz0XkhOJWYTqawKPXcQIDsRFrZV5lCBEdQtDOjqXtzpM
	QDr84WeH
X-Received: by 2002:a2e:8e79:0:b0:38a:26ab:700c with SMTP id
 38308e7fff4ca-38a2c7d3c60mr7461441fa.31.1772610114211; Tue, 03 Mar 2026
 23:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
In-Reply-To: <20260302164158.4394-1-minhquangbui99@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 4 Mar 2026 15:41:16 +0800
X-Gm-Features: AaiRm53kjsodLbYCGuUlv_RazlGLZcLSlUxqsUZ1o3B6kF53z5rIZZK8GKmcp50
Message-ID: <CAL+tcoAm8wBEes9unXrssHHsnPP28b0XcOdqQN-TVtet5O2sAA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CE7E41FBC01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263630-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 1:03=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmail=
.com> wrote:
>
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Thanks for handling that problem. Please carry my tag in the next version:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

You seem to have forgotten to add Xuan Zhuo's tag...

Thanks,
Jason

