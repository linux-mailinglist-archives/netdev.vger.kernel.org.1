Return-Path: <netdev+bounces-166664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD7A36E32
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 13:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C31894E1A
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5431953BD;
	Sat, 15 Feb 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lQpfr/ZE"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04830748D;
	Sat, 15 Feb 2025 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739623420; cv=pass; b=dKfmkwjHxe0GQuM0mAfJIHSQqO3CwqUMJPyBdPZImaqialHwQQ8/69QaxZFQcjaLaJwfGbiiZ6bMvM33m7Qmv89J5Gn+MwDHQP/x6gF7yQcYIdmRvwkO3JmY9H9RipiiOvFDgpq9SgBIRNJBhiQB/HH1ZRMpf6vEIqOvIEDQHJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739623420; c=relaxed/simple;
	bh=oYPAi3Kwk97t3EEA/i2GqvyzWWzph+euif2RhtWjBWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ds+jK0Gr0BKFynhx65q6Rseg3UbdzKFL4ufurTLqfE0apZEJx9wnwP5LoSvbv7cugZvpY8cSNY9Ira/HQk2BfdTovgZUd+SLfLXUE9gPhT0l3Iy/90lIq2QxdZV4VcrduUE/4jvSi+/V4NUP+OUEBTXWS3pv1+o1PRyUL9RwC8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lQpfr/ZE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Yw7rJ5J5yz49Pxd;
	Sat, 15 Feb 2025 14:43:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739623409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EFj5ITCd7ff05NUk3Nn0NJIth66Vm6F/LFAV2LFucQU=;
	b=lQpfr/ZEOnvWVMv2fLwNlbTbcMxx3VPcotGdADO/PTTJ5OfgnSTuDro9mSTj8wnc+ww1ht
	XcfK9bDNWxMELqN/9ADv4v0E6bjZIp4TVz5cjNIwOsYetUxfNS/zfbbdjCkna9GXdCgzWg
	l7Rg8/572GQ82TBemnJyibY0c1vkGmODARS1yn3HhZ6JRkM9J3AV0ygi18s1XyddhqCpnY
	cdcY67sQf6zv4Wa7Jmpin9dU/rgvY4mhNCxGBluswYjT6YfPPO2809KoGvJ3QmUw1lkq0l
	DmOS+XW+7roSy+haI7Yzt4qe8200VapbOiYJ7nz/U6lJrWgHfbTW8su8kSInrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739623409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EFj5ITCd7ff05NUk3Nn0NJIth66Vm6F/LFAV2LFucQU=;
	b=ATAErwsjWcF9YuGQujTtzQy2H11AlDWXtddI92gIUha6XHB9YOz2nJeyUI6+4Wk47cbaKF
	3Oxe+o0orbV0YXlN/CTEcwXgCi5TwRY3vf6m8OE5DWRZH/h8Q98xv4tf00QWuRPISA6gzD
	qBi6SGTKYEeVak7DjZ2jhly6xHSaITcNvwhUbNKu5ezvZLSHHfxEZlr5hYtzddkepeCRE2
	wj1EiArZ0OTvjZBgXTb5o5zH5uXQ1UIRzjjSXJVHJ33EbeUXSwVRH4teTqH+ibxdZPNoTp
	5oeKDXlxJgeefBaCHhax/IVfjSnBttop+Y5IkUI8fhCCRIvKAMzF9yE2GQO9rw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739623409; a=rsa-sha256;
	cv=none;
	b=ZIoZGRXAzadTGM6XxMalmmUH8X2Du98gRZ1SImKa+Il89eu8J8tjd0xnsNbIgvA1rJlhJK
	2hV3VF8xvTs0a7zmcRFhOnlyvxkfRE7ERlFBBkcWN40ANDkE7At5uYiV//TNe6LwuJoqnQ
	rKxfiR3OjMFgfSKc+U7FuThSzzzLmxu+GbETXAbQ4NSwnmDouXjhM1sFD9uB29hz/MDjR1
	9GH806TU1udRh3oOhVgsGUvCWuyQg90Y36uxdKcvT9zJLLqM2nI0Yth36E/D2OG5tYpeRc
	NINXk4VO59alN5B3j8f8/e1QhMahGgLtsGdss7jYV/qKzFAyW2fzBTSLBmeB+A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <aef858a717b1547d35fbda78c0e928e57394329d.camel@iki.fi>
Subject: Re: [PATCH v3 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
From: Pauli Virtanen <pav@iki.fi>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org
Date: Sat, 15 Feb 2025 14:43:27 +0200
In-Reply-To: <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch>
References: <cover.1739097311.git.pav@iki.fi>
	 <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
	 <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

su, 2025-02-09 kello 22:29 -0500, Willem de Bruijn kirjoitti:
> Pauli Virtanen wrote:
>=20
> >  1.3.2 Timestamp Reporting
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index bb2b751d274a..3707c9075ae9 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -489,10 +489,14 @@ enum {
> > =20
> >  	/* generate software time stamp when entering packet scheduling */
> >  	SKBTX_SCHED_TSTAMP =3D 1 << 6,
> > +
> > +	/* generate software time stamp on packet tx completion */
> > +	SKBTX_COMPLETION_TSTAMP =3D 1 << 7,
> >  };
> > =20
> >  #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
> > -				 SKBTX_SCHED_TSTAMP)
> > +				 SKBTX_SCHED_TSTAMP | \
> > +				 SKBTX_COMPLETION_TSTAMP)
>=20
> These fields are used in the skb_shared_info tx_flags field.
> Which is a very scarce resource. This takes the last available bit.
> That is my only possible concern: the opportunity cost.

One alternative here could be:

Make SOF_TIMESTAMPING_TX_COMPLETION available only as a socket option,
and make it emit COMPLETION tstamp exactly for those packets that also
have SOF_TIMESTAMPING_TX_SOFTWARE enabled. User apps can then still
timestamp only selected packets via CMSG, however the choice between
SND and SND+COMPLETION is socket-wide. The API is then less uniform,
but probably usable in practice, although some use cases may not be
interested in the extra SND tstamps.

IIUC, sizeof skb_shared_info cannot be easily changed and I'm not sure
if there is room left there. So if the option of putting it into
protocol-specific skb cb is also out, then I'm not sure what the plan
here should be.

--=20
Pauli Virtanen

