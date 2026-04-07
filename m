Return-Path: <netdev+bounces-275811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A+fHwhf1Gm6tQcAu9opvQ
	(envelope-from <netdev+bounces-275811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:34:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C83A8B91
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE86230137BA
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D47321C173;
	Tue,  7 Apr 2026 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrivtFnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C51E832A
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525635; cv=pass; b=nf1x4PStKWJHwDykAiA4DGkdHNpgQGooUiFRjIushuBRficg2QVrQy1o3vwDSTpYnK45iw7o5cwfvbarPqxHe0klia2jmi5bT/Ox+F+mQ81jYcnlOZQbaF3K08Gd2M4t8vxw8riwU845AUrwWoPW2LWdBCFCjTh/+1YBbi3yscI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525635; c=relaxed/simple;
	bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyhtLqZtsrqVUwS3IXSCONJDBf6wSJgyidFxmIC6e+szyNIaUQm2jQE+76LsQ6w9O1yh7rzOtenGt6v1LO86mCq3ERBuWtYM2s5QIlxOcYTna3d2Xy/S0PmOagrdmFlFLUxdgL0ihn9re+1fELVtREA5/UAZQrVizowRHcHkyXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrivtFnP; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89cc71f4311so62221106d6.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 18:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775525633; cv=none;
        d=google.com; s=arc-20240605;
        b=OBXMtdPs9DU0MiGaAglZbSJNMkfasSo0uuL80BV143SyzqiDLk8N0DL9T15ZPXHh9L
         vm55ppfLhXvslecojGqb86MRWhWb/VPdB1ecd4YHOhdaTZsvsBpULHalhCM4g2OLFL9X
         MsgpZS/piRIesTCjmcdxmrqYhi4v0hR6Q69G5JTJTZB7T5EjHhwXp9ZetKgER3uA3KUF
         CXMq0Nb7jyJecvezKzdMDHOeUBWxKxCRXs32Wr8I3qwriahDOrRJzUt8AetK6Fzcutdv
         7v2nlSSY3TbwxVvyt+rPbkrzbFJFY0KeuEteqO5pulQmW6GclHvASAAq6+FcUqduInbY
         ZOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        fh=JETGcnr7sJOGloZzoZUVan+uS9xzbEMm+bocSC2XAI4=;
        b=j8WWJhlyYZv+7qE6LYkqn2AUfteriim/xPWFJ3krDAqIEPbvOh9SUMtBeGDBR8ooBa
         vT607D7nn9QDeGwheOTNAbFvPLv5bh25PK3PL9bLWDgc4yVJMO+cWZwpY1E95Sjeq6Ed
         Gqy9phS1bd844Zdc9KGNeiKFAnz1lMF77Juseu0JswtPryxAlkvHoauaPhmj/I9v/eXu
         Zf6uoZD/ZTtW7V2x1WgZRisaPIo6r5jo7U5q1WhhUazcmXcZHgkI3sGBucT8MoMbF2aB
         IsX8V6RnJYcy6p/8Co44LiqZGewveH+4hzFB7N7efhvqoyxMD2RPBUqlVSXhGGU8EcYe
         lS0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775525633; x=1776130433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=DrivtFnPofV28Y8uVHc6FGfKTp1x+purr/50UFYwENXewNmec1Z4OYqybhhaf/QVUR
         X5g8gqWVR1s1AYcRi8tPqoKps9gO+vKhthgUkVYEemH7wA9icjwWUw5nJj9EwRvucGP3
         8DJHJcBGHlYp8vGH6kqj7/oJVWGU0IeH6L5IJxIsCc77UddIvpMVYlsUMVNo72VZjLHH
         G9TxVO61pkUVYMZx2Q26gyJI5hjMb1/n/8y64XGNTRccZDmGvoc41f/nAZrj6iHlOvt3
         3Tk0gw8WAKcUy+zsmEyqZPxc7kwczAe+IxlS3UcloyDoa6BnoD3Okla4ApbIzzYK78r8
         ZiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525633; x=1776130433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=R7v+t/7/diDU2//h/LCYiocjFCotJ5D9uUo+WxumgGJ0v8AmhUW5gmT6wMVk2vX6Dt
         AuwKEaRKBj+hiALf5ssulHJEH+3vokZ8admw6O02XmAXdwIqT2p5q5bySJrp3eXQa6hg
         T9N8u1f+kn9ifMwjgJqV91Yb7Hhl02BC/hYSJpPqWE9zbxXbUb5B42Tb+0cfiUyz+0nL
         IjfExvbUKPiBqtp7n+AVAItgi7uCNJWv4dMUr08Ou6hTJZPQ7qFTdBoSBuNDszo6+Tuo
         eaz8HKoSZu/kYsh1rDnCSjQ6J8LhYV3ic4yZXrSNoBFapCWIWksJ+w2jYv3DlgJeR3Os
         G7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVIlu7yniGE6hzjHUsqslPDdclrbpSSLa1OX+zQfTmWgNEYGi31KkajflDpt2fG9ictfEE6B8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gZ1W/VgV6h+ED7G5Skyl1TBUtd4XDD2rhmqeo2WXHGfLPxnX
	UwOELFsQbbvW2hqmWz4LHw5D6JbOWQ0GBhOGR+89n3MXrzT/BLmi+Bvw52ezgbaKA/4/ygFLeeq
	UeVyNmGH28iQfLHQM6Xqdko37n4IUUZU=
X-Gm-Gg: AeBDieuxQDCEcJFDmc0U4jjJ0C2fqgWVcbMF0Ev36fX+vWAqWCKgprqhwphnKueOr7l
	PP/6wPFbQp8PMl8cHHdYwNWbXjHrOjVYx9/7avEzpmDE+MkjoXhKc7erlghf43NAgKj5cEczS5P
	/22k7KNEMCWnmO6Dn8m9ik5Pz+5QMpzQpW4mVRMoOS9JJ0PBolM/vo2ceDXWG2UA/bwitlXHWZj
	9n2cvFoRdgSeVse9Kl+XrlD5Jrg082wfZJEi0Mln7Mj7g0DmjPP/a4YjnGmw4i+XRejlrtSUO73
	5/b14Ziv0HR95gakvETO
X-Received: by 2002:a05:6214:212b:b0:89c:5110:751a with SMTP id
 6a1803df08f44-8a704ac00f3mr250748606d6.44.1775525633467; Mon, 06 Apr 2026
 18:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com>
In-Reply-To: <20260405154816.4774-1-devnexen@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 7 Apr 2026 11:33:40 +1000
X-Gm-Features: AQROBzCkX2gE2vUcwz9Vh41Dy86vV6V6vedD5cjTTBBq9Q2y1TRb7sq-3zFQtYQ
Message-ID: <CAGRGNgUpknQi6PzBWQXeAP0Vh7XjntD_-O4QyjU5tAn8_71=eQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275811-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juliancalaby@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B0C83A8B91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Mon, Apr 6, 2026 at 1:50=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 fields (netdevsim) where
> a direct assignment would trigger sparse endianness warnings.

I don't believe that endian swapping significantly affects the
randomness of the data returned, so either:

1. Do something to silence sparse (casts?)
2. Live with the endian swap overhead if they're not in the hot path.

Other than that,

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

