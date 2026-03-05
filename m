Return-Path: <netdev+bounces-264373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNNCHl96qWl77wAAu9opvQ
	(envelope-from <netdev+bounces-264373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:43:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB0D211E2C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B734302BEAB
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43739A7FD;
	Thu,  5 Mar 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JremhocD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED52366DAE
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714560; cv=none; b=OHirnfCr5gMrKWJQ+bAQdbrXSDvHFPTPI2/4olwjbieYSemlxVYMPXt7tQLcRm9LSC6zrtOMuybVi/3s2QLBunTSz9f/BBHUGgqLYS7DSEhFP8tJp0ATsVDZkfQaQL3DmcyzW+HRUmOnCKA5rj6LIMMm2x2H3GOtGtrKYicKqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714560; c=relaxed/simple;
	bh=F8woh9js9XcHNLC38nopuCN1xsLDX1k03bkw/YemlEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=UOmYP0NYJwyAAkbACVnus8pUgAta8jALoHFGCwphd7xhhHbojc9TDwEJTHDHECJpSVeBfgdJB5AAm3ZvhyVQ1vErBtMkxkKvY2QGiIXed3YmgRNhDpI/aI04CBC6tyTtzQuhK2CWJdfvPnTODdNrNpLz7NIGRjssBMmX8Xo961o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JremhocD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48336a6e932so49962225e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772714557; x=1773319357; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8woh9js9XcHNLC38nopuCN1xsLDX1k03bkw/YemlEE=;
        b=JremhocDidVGA9xi2y+kd6lN4USCRKAt0hsXie3N2VYF2p1DLBtH7vn7irPYWhPMog
         7QjQ2vXbfAd9z+OtIB/domBtDenOuqYmQe1aGy308qoGHQB8I9Bdey/PEVBt75OimgVm
         ZNMPd1mGcYQMqRtHqK0ayTcs0Cuxy875aP/iLp1xPfg1n2vQz+lUVUMXxxe1NFPSYAkP
         oJ+uTJl82NqRfS3q0x0dXxcnHrCTvwhLtj//S+P+66Tp03+VQu6cYwlWQLnZLgsPAlSX
         KvizdPU2C89TD9h0Tgk2zWLfUlg5zB7LPHN9+hmZRRUzk6HoH8zPP5U7gTqFLNrs57oC
         lytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714557; x=1773319357;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8woh9js9XcHNLC38nopuCN1xsLDX1k03bkw/YemlEE=;
        b=XH7FEgJvAgU5Lpr/0FUC+Fy7cV2aeaBXhXsZgVUCVQSTl/qdniMDL1usiGve7pyZAA
         K64qrBn0uhANvFO9pgsUR2ragsuWPVfz1c9rSYq6EMG/f4K3mr2irnqO9wK8x9gtKtIb
         8tFGDy+C19pbQrc+/UFBXMw7UUaHIUI7muu8L22roXv0/WQHfs51OVwDcl3FZEy0ZGl3
         bPwKNqSOrxYUKwPtppBAjlFr9ZGk4dePlPAOiqI1bZcrDwHTpRXDgjBa+ND3Gz9OeS0Y
         OEqMqDLo8aZfifRZAo0MTbeI/kCjbMCFZJIoN4lqmRKHb1qyVqsnDQvGTD1VfOxUqMac
         8E9w==
X-Forwarded-Encrypted: i=1; AJvYcCUEUeGnv3c0jdlkKQ8Q5luO/elBpQP4qWqhmUwh2j3KWmvszmVj3zdA0guhEM+m9sHA15nd3Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBM//ixY9CZMQbYjXgcxicAWt/2NKAEga+juBgJS/mGQm9ltww
	V/GfMLKn9RMn3ef36MO6+HqYdYFu1Pex8Z3OK4OFudKwvsYg0tK6FugfzK65j2HhPa0=
X-Gm-Gg: ATEYQzxFjk27pefoQCwFRpNdsMUHHUByy/LmXfPfKcdt+6SBme7IzX/6HNKqszxbhqB
	Bqe4kHamOns5mZLiOzRmVY+s+Wzi3+gDmFTUaXjZ/scxazGAtPHs2qdw4yLbTC/kb6IJUT+d9eZ
	T56O6SZkD/KM4aWDb1CqrNnE/HTuqTvfJvb/TlgIjETNy1OXSO1TzcCiVY/EfhXbkIWAnJ/c23I
	oCNGzX2nmjwouE27o6EFkC3+eLzlYwnG9tifGF5EWgT/tvRbfOcDMSnoGMoE10FauwRPDP5f3Mj
	ui8vv6My1zSqaoW+Tez4uzFEJzJH9u0QO3bv1fMMoFewbielOgMqVaubOfSU7ykxgFC5/1KnQuf
	4ZddzGHo0sP0Lk7FEPuT/e+JRwncCSePVUpEL97ebo7m4hrLdQQ58yg3b0TofWJvBnK5LqjQA6d
	gzmSdgRYv9uA==
X-Received: by 2002:a05:600c:470d:b0:47e:e87f:4bba with SMTP id 5b1f17b1804b1-485198a2b1emr99378065e9.29.1772714557221;
        Thu, 05 Mar 2026 04:42:37 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffaa208aeesm5252381137.12.2026.03.05.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 09:42:33 -0300
Message-Id: <DGUUV390XWEL.3BNFHCZL5RJJ@suse.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Cc: "Fernando Fernandez Mancera" <fmancera@suse.de>, "David Ahern"
 <dsahern@kernel.org>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Hangbin Liu" <liuhangbin@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc 0.21.0-120-g50bad16c3d41-dirty
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
 <20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
 <0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
 <20260302171131.28373ccb@kernel.org>
 <0d7bb5c5-4122-4dc9-b52b-c305591207d1@suse.de>
 <bbee1ce1-0615-4be2-b7b1-a14eaf2afe26@iogearbox.net>
 <ba665193-bb6f-4293-b8ca-bbb267e92eb3@kernel.org>
 <ba35fa2c-0085-43c9-afe0-3b2e0351ca3c@suse.de>
 <525dab04-4e64-49cf-94d9-12084e146b80@iogearbox.net>
 <20260304174327.0a48ff45@kernel.org>
 <ec1fdead-8a2b-475b-a786-846b81234b74@iogearbox.net>
 <20260304185056.4ef945d4@kernel.org>
In-Reply-To: <20260304185056.4ef945d4@kernel.org>
X-Rspamd-Queue-Id: CBB0D211E2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,suse.com,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action

On Wed Mar 4, 2026 at 11:50 PM -03, Jakub Kicinski wrote:
> On Thu, 5 Mar 2026 02:59:27 +0100 Daniel Borkmann wrote:
>> >> I presume you mean disable_ipv6_mod which then bails out during the m=
odule
>> >> load process without error, right? It could be deprecated with a warn=
ing so
>> >> that it turns into a no-op: =20
>> >=20
>> > I believe disabling ipv6 may be legit. Some admins on ipv4 networks ma=
y
>> > be paranoid and not want to allow any ipv6 traffic if their "firewalls=
"
>> > can only understand IPv6? This is just a guess on my side, but I'm les=
s
>> > confident of deprecating the disable knob than =3Dm. I'd be happy if I=
'm
>> > wrong.
>> >=20
>> > To answer the earlier question -- I would prefer to take the fixes now
>> > and make IPv6 bool in net-next, feels like too big of a change for rc3
>> > :( =20
>>=20
>> Makes sense, I think starting this process via net-next is fine and can =
be
>> better justified. Fernando, maybe in that case resend with the unlikely(=
)
>> added.
>
> I think Fernando was chiming in because he sent similar patches.
> Ricardo, please respin checking ipv6_mod_disabled() ?

Will do, thank you all for reviewing.

