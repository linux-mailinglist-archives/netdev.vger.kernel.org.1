Return-Path: <netdev+bounces-258064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBPnNPYai2nSPwAAu9opvQ
	(envelope-from <netdev+bounces-258064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:48:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3311A60E
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F8853013A4A
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED82318ED7;
	Tue, 10 Feb 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfGfLXUL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fkzdv587"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F81221FCD
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724082; cv=none; b=esuCOLL3nEZMdeE52z+6Go14IJ8FSoL+IV20C6XJKIIL9DRDMQw/0A1SWZcelQ7kZd/urIB8u29q0kDy6kq2jaqHezPFqVX81NMdJLSmrG2iyIppuCp+IelK9YhqmZUyLGQNdl//l8WnqjR2kjHfuBN377lJn0U0wSxDJ5B6oZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724082; c=relaxed/simple;
	bh=eHQC/1uXNqG8Cq4bOsObpnrSbfAgHkc+3G/800mPjiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ub9eVFeUNJRx82+5CAc0/nvQf1/19wZc9p3qltB2K1SgzCitq6CHUfzoSpc4HKNyR1pIsrKbrep0vNyu7zIIoBKn8JiMKz8xw+Ayp346snk9LeH85neQiBazXxvp7BnjiAvbFFYSDerUW8pHHQhzceu/yR5Jr0GJRqzdHoPdE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfGfLXUL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fkzdv587; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EN/yPGhkQUnfeD5ks5Tmc7VGBgpgQUKl1WzPpgUbvpA=;
	b=KfGfLXULk/vmtgZII3gxuHZh0XQhkzmp3M9PUVGLuXqihpPQaSry9kVc/gm1urN9r/Y50V
	y8wLuDSqZ0izRIvwRgarsfBqWGPP5DpwVi4zC9xzMmR8jiujwMIxd0EKEffD48Mn0voLpY
	MTmmarqdOau37j8p95VFaXsWmRQV3Dk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-J3BvUPbdOy-zRnv39NWThQ-1; Tue, 10 Feb 2026 06:47:58 -0500
X-MC-Unique: J3BvUPbdOy-zRnv39NWThQ-1
X-Mimecast-MFC-AGG-ID: J3BvUPbdOy-zRnv39NWThQ_1770724078
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee432070aso38587925e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724077; x=1771328877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN/yPGhkQUnfeD5ks5Tmc7VGBgpgQUKl1WzPpgUbvpA=;
        b=Fkzdv587cKgupKnrT/veRzfUsxtVPY54O/2lSgHGXu8odgyQxm10Mi+xD6AlCRpF4n
         WTvOQIXHnADCLVqAsofIQfyKdTDvJCf/wfugR1QK5Pv7iaEeJsXa6yjIKKFssrguhbmU
         htOL7PDIidANjHG3taPmnrJOu2zIaQ3KvNpHG21xsgRAqlkGpYaO8vhNtzqIOVf8Eob1
         iB3n+cIzfHMJmJ9Y5dIVTH2ieqo1BzR6FZEicw4nIQRapGnPg/VLfBCoxfRe1TVvtM4b
         KSw2CG/NA98v7LwyTcpz3cB1Ly6evwDjnYvnG+etQPZmJTrQYZWWMhsx2sTJGIoEJB3A
         hF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724077; x=1771328877;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EN/yPGhkQUnfeD5ks5Tmc7VGBgpgQUKl1WzPpgUbvpA=;
        b=l75o0XipxO170oVUbLtt2BwW7Jyrv8hZVpiJMuLqnTmC4ob0CSSAxVRX+R7jMV2hjJ
         hw5gkMKycjjcB7UWRsvmrKt9IICDihsmZKa4dTnS+NS8vuD4NjIiyHc8xTaYy0d2eZXf
         7Ev/LtRcA8/02Z8JxT1Mu108Gn9VdaUcP3ZQHoStYjCIL+EcOfwNNAahfPc89KT9m+/X
         WdvxlKDx3BezXmjYMDIfvuaQrT+0Vd2ggWgnaWreNU+rXwuh3gMCxrd4M7m5pwF58nYN
         O5BIIrXA07BWZb3J2/OzI+AY192esLO3X+Ab8X+SK+YmFc7Bi6mcXKUZKd6yrfp2136n
         +aeg==
X-Forwarded-Encrypted: i=1; AJvYcCWceL5lnMoVfEdj4vT8kfPe3oLThs9WkoJqxtHBRdkCgDXuXxQt9j87KpzrgQbQLV+lDvuZ6bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUtW64rNek1cIxSQ37be1TXFgQcRWz1qS3Dz6OAs1GDdTu3iu
	pD6/hSJVKDWX2Cicgbz11BTqjLxD2nGY+sIV4XBY9I6G9u3+up+7006qmC48EAabPGzzOK+WDQv
	L8tfMINWWe9xElD01xrU1pV1CAGbHUhYbi2gjBsa/lUcpBvtDdQ74XyRLrw==
X-Gm-Gg: AZuq6aKjWJ+o8xxN9p3ovFJVe4KsJjPjFlkOGwauylnG+7EZXlP70wV31jmlXF+EpK2
	VD0616RFLNeNcpU20g7vK6tWJIRF3C2R4Az6B3RPBTBXie6Sao7coP8pyJjCJLPthwCQKXMVEdP
	w3+sb625Dr+pdlZA28bYewAgyEDS0duojoHWzIiIVfUH/IPoHAlmK9xJAcI1ZqMoFgUswuHXql2
	AC61A9vHCducNvOcdTmmqEGEzg+xZje8BQMlxKBXaaNwumI27WKdenTPXBJcHk34UtZIEMPUDlQ
	SJBJIoLFFHaI3qx24XjLjfrBo1mMy6ndJhZh7EE+rwRURjLskc4Xbx28czn/ErsPX1hNbnbmiyh
	9dSLiHOP3bLhTuuNPBd1u2jtR4uYmegSZJNsTqM6UOK7+IA==
X-Received: by 2002:a05:600c:630f:b0:482:dbd7:a1c1 with SMTP id 5b1f17b1804b1-48320226287mr213039475e9.34.1770724077574;
        Tue, 10 Feb 2026 03:47:57 -0800 (PST)
X-Received: by 2002:a05:600c:630f:b0:482:dbd7:a1c1 with SMTP id 5b1f17b1804b1-48320226287mr213039065e9.34.1770724077144;
        Tue, 10 Feb 2026 03:47:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm31436401f8f.30.2026.02.10.03.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:47:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7BC834FE897; Tue, 10 Feb 2026 12:47:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific
 drop reason tracing
In-Reply-To: <177039506239.2258217.7863252279149995024.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:47:54 +0100
Message-ID: <874inozuol.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258064-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:mid,appspotmail.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 47E3311A60E
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
>
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
>
> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
> infrastructure.
>
> Reported-by: syzbot+ci335f183b8446659a@syzkaller.appspotmail.com
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

One small nit, see below. With that:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

[...]
> @@ -37,6 +37,31 @@
>  const struct Qdisc_ops *default_qdisc_ops =3D &pfifo_fast_ops;
>  EXPORT_SYMBOL(default_qdisc_ops);
>=20=20
> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
> +			struct netdev_queue *txq, struct net_device *dev)
> +{
> +	while (unlikely(skb)) {

Seems a bit odd to have the unlikely() here. I guess it was originally
there because it was an inlined function, but since it isn't anymore
(presumably?), does it really do anything?

-Toke


