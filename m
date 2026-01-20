Return-Path: <netdev+bounces-251533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PcpI5XDb2lsMQAAu9opvQ
	(envelope-from <netdev+bounces-251533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:04:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A54908E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7BA06CE976
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904A4418C9;
	Tue, 20 Jan 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuUs6ji3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458F441059
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925269; cv=pass; b=YFkZlewObJ4jsZQiFze82+FszT9g4PZcWnfXB0xKVUEmRFxYXiQdPUAjzNYgkSGVZWCpBmCBeUq5eMEM7PlXvZeyV3okmSB3dRU37svtJxpkSiI5oE3E4UbiIEC+i5GvTjj5EdkVMY1Nllsv3M3/VaZ7eeaHeYs6wqcG+t9E1YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925269; c=relaxed/simple;
	bh=67lJ0kNh1HNTrTPswLOz4RdeuIvnZ8b8fX/uZYsptR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8gC28zLzFwYpo63/dIVO2gyFUR9xzcIUXGuxbTUz2iq8A2Y7i+VVQ/YzyDBmMaChjoaQaVTEGm4AgHksuCQPAuvQT2WfIRgHTEnHl4Cx3ke2P2OfF8lC/xWFgxvalea85DioRJnZW/mwgScC6aj6ZkLbE04Fi1y7D1rRGR5IJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuUs6ji3; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so4073181a91.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:07:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768925267; cv=none;
        d=google.com; s=arc-20240605;
        b=JEFYmbtBpaNmpbHwN1tAcKpJcDzZT8tmoKNGZ0tY813E3uTHyv2GQbOkqFFLaK30rb
         y5Ezick88IQcs4K00xdqEFyd7aLWDF+BTdr3m9aLSoaOickQ409EgpjfXQxEwG8X9F7I
         NCWi9cG8Ji7pYnJSUOJlOTNjcz/qcbco0t445ZNDTHWJ4KiiuYJQUdz8BtSIRonz1tU4
         CDz+fKcnvo9ymS4w7RcXeh30cskgGQkMj6FpMUlEePwSX7sACWWW2Iif85fgwX4RGueq
         JTNQOOLTyNpiPiIcpfX4ZbPe0+N84pTjDkxFaxpv/Mr6+be/lZ8brJ1P8q1xo53l3ybu
         Qx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upRjEeHQQRzQP6jy3c8t8EGW4Gu+OzsotYdbGrZ3w2g=;
        fh=fDbUfIcx4Ncec9AV4wxOHXS/c8ilfxJ4Jm8OWBj8/eg=;
        b=arNkga18NSNpfMeMB9LYI15K0gYX6AVk3QfDhSm7IPXn73e855OZQQGfvYDDtBuwi2
         X7sUAMLJpxEiszvcbU5ACg2/PM5hlc5O8nNkfAjd9Evq8QnuUGWhLhfVxf8W//vHDLjr
         wYRJt81kVFEopTEEBUH9O4+SDha7Z9hcQxVj72sbSzqcdiMazdfzRthPuA9nL1cCQbkp
         2PmD2I+ARBeVRQLq0GfiCiaTYyRH9uBgdbdZlCCfCPW0IoACw9Gfr4+W4r2VDP19iIGe
         UIJW2KpN2UVe/9EqPNdV/288sOt870eT8ntaNkZvO4w13Kd3HeKg8bG8hcegJDmqLp/B
         htxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768925267; x=1769530067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upRjEeHQQRzQP6jy3c8t8EGW4Gu+OzsotYdbGrZ3w2g=;
        b=WuUs6ji3I3g0/pcQt8ARHfVUHBmBXi8nSTYClIvkVb9tcp6PaP80zA7vf7tUD3gSq9
         5SuZqxOvD8z1y4htMRzxOxvPXuh+4IxBJqTEqAVEaY//osZabA24Cval9EPhh/sDb0Gv
         VzAIe8MHVrr4Y+VlJLAgjSTvsOkUwCN7PgZ/xoFxNu8dohWnrT+TPi/pmqOJL4HQco5N
         TH2g744h9cXPvUfoAWvI2gT/1hIJCcuV2XD5gZbcLfwpagYwMeoT2ttpBQ0MHN+bt51q
         Xf/GLcxLJcSeUmXZuDX8kIegf2QMbqVZi6STpakIWn+lj+8RSMEwxL6MWWSVAL8P59u9
         +M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925267; x=1769530067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=upRjEeHQQRzQP6jy3c8t8EGW4Gu+OzsotYdbGrZ3w2g=;
        b=W6wVEpb0HelXyqMiIvLEW9RKlyj4arBV/9WE2bG/gC6khy9cSP5ERJsLswfYFPGsb6
         TvbdzsoUl9ILSxoVM7FgpoeQjn6XjoB/qJtl0uzB6Pf5q6proqdAPtkNr3N0rGHDNJXK
         VCsfZjyAYI0/l2rbPIj0+JWOfTf7WHC71LZUIAUOj9JcG/buObmaYDudFVgrOz1rS2ZF
         TFh8AJMAtVm1IeSeJAU2X91oJ50RMlb9R4PHXyvgcN1opwXiWS8NvVbxACjVQHQuIsyt
         Qid5aC9Lhb35vjOQuUtrWL9vItB+5d+9D68My8l3MmxfNfzvtBQ6Y1vpY9TU+fMYNdT6
         EExg==
X-Gm-Message-State: AOJu0Yy8O11K8aO1AexRao3dYgddmcJsqvZRl9+wYLZcamv2mSc/I5cm
	e2BZUCvwcAaBBCpxEMyujZeiFMPlOspK5K7bRnkAc2E0pVubneLs1ID0SPArJSqQRmEFFc6++JA
	ltq3xf8Milqo/TOGQwbTFJLnt7m4TC/M=
X-Gm-Gg: AZuq6aIyBnbOCdBCapIHtSgFrt4pJI7PxVidSEg/UGi7mHWpyd/d816f0vrIyz68U/h
	o3OSy3raB559EcifanUrBNIoO1GHEWwPDo0D5RONFZj68zJcVV04StSv1+JIJEcJBC9ZFZFeUoc
	HCVFCUaPmxdeELOq1N/sCHJHZY2AtUWnjtA8KotLbhgb4jEV0lLWJBwi6HGxbyOafTqKikFXq3W
	JJ9YQnpFPnoAldBMALePr4v0G+vJW3SxvPMboMeExFNJvP+DUMN7KFAvvcq6CogY4Epo7BxYopN
	QbH2gNfSWZJQ3kEZYvry0Zr35iXUEb7E+R0LMXg=
X-Received: by 2002:a17:90b:240e:b0:352:c146:dc39 with SMTP id
 98e67ed59e1d1-352c146dc7amr1573652a91.30.1768925266857; Tue, 20 Jan 2026
 08:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768489876.git.lucien.xin@gmail.com> <e4753dbdd12ca45edef6815830c1bd437bd635bf.1768489876.git.lucien.xin@gmail.com>
 <001178f3-aea1-4886-92e9-1012ea6d6c76@redhat.com>
In-Reply-To: <001178f3-aea1-4886-92e9-1012ea6d6c76@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Jan 2026 11:07:35 -0500
X-Gm-Features: AZwV_Qi-fSbMUEaDUskVF2b8pxcUG-nT6lofmi0ehgNJjkJjIxLYY_l2FerCdKE
Message-ID: <CADvbK_eUfuuwMg28nxo4g4+fLjJNrRDDWro8oape3uXu6GvoQA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 15/16] quic: add packet builder base
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251533-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 210A54908E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 9:31=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/15/26 4:11 PM, Xin Long wrote:
> > +static struct sk_buff *quic_packet_handshake_create(struct sock *sk)
> > +{
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +     struct quic_frame *frame, *next;
> > +
> > +     /* Free all frames for now, and future patches will implement the=
 actual creation logic. */
> > +     list_for_each_entry_safe(frame, next, &packet->frame_list, list) =
{
> > +             list_del(&frame->list);
> > +             quic_frame_put(frame);
>
> If you leave this function body empty and do the same for
> quic_packet_app_create(), you could additionally strip patch 14 from
> this series and avoid leaving several function defined there as unused.
>
I will give it a try, to move patch 14 to patchset-2.

Thanks.

