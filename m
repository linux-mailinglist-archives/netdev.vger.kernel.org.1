Return-Path: <netdev+bounces-297419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qElvK7bVKGqmKgMAu9opvQ
	(envelope-from <netdev+bounces-297419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:10:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E59665910
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:10:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=AKnuLn+B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297419-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297419-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3BA3014DB6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45C33F5AC;
	Wed, 10 Jun 2026 03:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53893346B4
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:10:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061023; cv=pass; b=T57vMNp/Sh/3n22r54sX6ARkadA1hGuped2o14vrOPcUoZssjfV+GsZrzGJ7AXpfyJDIwErwikHQucT5ve+05OJqfTr1P8HrA1yfMBDDhe3pJjFS3P0l8qSTS1WOc8h0pRunl4fiF+r3FWEhY30y4soDaK3aIEZ1dpCnD8mp1u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061023; c=relaxed/simple;
	bh=EKPnmXGBjDma1T5FRzXRZUBcKhNeQ5P9T9gFuZsrRHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j67eRYZWJ/EnhUsXfab5+gRZjxsxQmbbFzQ0VcbS4kOPpHIffuI5dOE0YQTx9NFA1oPkI4k9j3oruL/QbCzQTPuAYx5m3A/QVBeGlCOuw9byqrsf2vQC9ZK4QqqQ67TaPjLxoUG250jRScOn7BZtfa5dCARoGGYo3yDx0EnxYBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AKnuLn+B; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177ad0cc67so50235191cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 20:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781061021; cv=none;
        d=google.com; s=arc-20240605;
        b=dQNKZb8aAB2BGRQoiKYS5FWhUFlXZXZ/ooQU/+dIuRIU+2Av6Sipwl34z17/rRdpmA
         n1i9sEhjbCf9+xAw1evdiS79EEz3AaC/6UD4mjHJCYN7nNu+GndCkvCM/kRYh+vjZrFH
         T7SFfasr/NA6Ov/jqkCU13N/jcdaxBz1EWJ4lzEBtFkJSGuLj+30IJ1Mv/BbNhu436EH
         PkjhGhaSZ6qwz0vS2wTvNvIkUyAmpL0Se+CVstdkXiSACSJnaY2ZNZWdQsnapZHgRBFz
         N6M635Ef/ymFWkErs75wJOB+7+2SEvdwX75ubYMm4WsPgtfwn5MUwND6xy4Myp44wX+0
         kdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PifhG99fccvxQapBGqpYPpBgDLFtQcpVhM2a9xzimwA=;
        fh=Qe/zkZxTaYGaurv9ek2V1RR73phTqpRGKcg5gvHllU8=;
        b=gCNSNgb5nWI5DxNWRstbHIkp7S8+hLu5ZTeph4+ji5jIpSZgW1NtivDmBDt9bsJaJv
         W7YSegZ9DpPlmrij/xvDBiZGeaWoRMKpl/xuHn4JQLsNl4BRoHEHXSs8YzhxvbZ+I4FQ
         jpI9YrJ6kdwzDk/y0J4VT6XncTWEm+fVALLtluoTb9ozmxMIKCpLZjfv1qzv/pTsxSoN
         r+e4u3OacEvbnGKuNIUfBZiJMM28CBlVO5NuCsKNE1EgtszQz/pOJHl2u5a4IyLKZGEG
         AZtEmZiz/6L59eMlgC+Z/moXxcWe/nA4PntuIM8albDR3UZ1M0DrIWAgOv2T0I9nu+ao
         MKiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781061021; x=1781665821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PifhG99fccvxQapBGqpYPpBgDLFtQcpVhM2a9xzimwA=;
        b=AKnuLn+ByL/iT56f4JalotUqZ7spT5IU/hEBo0VkDpXL7Ts+lic7YMwh+qs+0+ChVJ
         a4DeLubHUtN5H/fq0WZZ0DPJBefoUDe05Wjr7j52jjbJfJKcQ+IoN7FvEUxK6IqTYfCN
         z7xSgHKX61lEmXO0QKpVjcpUrAdhCtKlhWSVwXslf0NHchPzaxU9kICpWjI/maZe0ZkZ
         910i/e1VhgvWURgUbhFKyFyn9GlaURxTGi04xveu27EFs7vrddIz6F/7ksnANc+/jrn8
         Uk8MN8UAggQ4MqiF23YnZ5UQ4d0c6/39+98TxOUtIca8bXRaBQn4rAmDTiEhA6m2TasW
         detw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781061021; x=1781665821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PifhG99fccvxQapBGqpYPpBgDLFtQcpVhM2a9xzimwA=;
        b=nu52og0AGkWOa3Ib76FvXQtpYOA/XbBdvcKNI4GrCRu85w5qWWNHEiwqwuC2QsVDoJ
         tzOtDug3nEgTs5XDBF5q5n2GhfTTO0ZwhXMYNFVi/sKQl7zhYwDwvyqED4htSrocKv7l
         3p5ASVFltUBcWTvjTDrwFM61EZtc6EqxqlBcB3iGxSm7yN/64/HgR8gFxKHPY76ffjgu
         f0ZntUFBaP41QS1DjU0MqudXdB5sGwlNXpVirkpMyNqs5+/PfYzZL9CUKLQxBMYvrFh3
         Rv8XF/VUeQ9lsJzbx0Znw6Xc6brrqgvUxwh/h3940VUVhw3S3sB0vOnNmsHHYbzFN/Xu
         FIgA==
X-Forwarded-Encrypted: i=1; AFNElJ9LAMy8Aq1Rk2oLHmLlNgFz1Aafjsmc7U0EJkScDm20FtVDx037e7WcNJDZ6IxKdQAmxScbyYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QbK0WFDBdTjtvN0cBVDKtRgNuNDdeiscgqK0P6ggxQaMPADW
	UV2BWv8WPhsAVSzhRofXxveHw2ihtQ/AZrFAaVn3NPrqwJVGrMrMH37Wo3mnaRo8r3OVBEHoUJ7
	H8RcaaECN31b3yfuHV9w0PdS2uUeKgfB9YHS71kiV
X-Gm-Gg: Acq92OF4U6Wez3ObFgEqJ3BT/YuvwAHr8huW47YHVo6OxZJc8nRgG2BVG4FVxUe9kTr
	UqiIHkq2en3ALkMB7ZbjH4+S6AfNicM97LYWnsy+qxsWUCOzp+NBIlOGK3RwVtRfem/CtUpK3Ry
	scSh2lIqeNNn49cpmDBKovoSh+xe4Hf7s8yy2ZsbqB2Pkqv2v4whuluc1Gdjm7hiPR8t41u0uOd
	5z2ztrxMmfGna6ftZ+ktEiObi6upEGy+ceR7n2MkGWaYG5hzJcRJwTUH4KGpjB+F4UQSE4OeGJa
	nyH3k2nye2excXVTpN4oWgdOLjMuXxLQ5OeVTepvDwMTc4bR50e6WSFEOsaJA/x1/HP7Y5fzcFS
	bxa+kWbQIpprXQENd1a0lo387TedblA==
X-Received: by 2002:a05:622a:98e:b0:509:23ee:b9a5 with SMTP id
 d75a77b69052e-51795a090a8mr323096991cf.5.1781061020340; Tue, 09 Jun 2026
 20:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608135051.637439-1-edumazet@google.com> <20260609185723.6c5352ac@kernel.org>
In-Reply-To: <20260609185723.6c5352ac@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 20:10:08 -0700
X-Gm-Features: AVVi8Cd1Cj4whMx6ePDcZ1OWZKeR1VaIrEqEOXs3ozMkTky_Z0CqVlEG2uYNf4w
Message-ID: <CANn89i+82c7MPykFB9W4Ef=gwPQszE3JofGRvx_N1bmzW5-CTA@mail.gmail.com>
Subject: Re: [PATCH v2 net] bonding: no longer rely on RTNL in bond_fill_info()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com,jvosburgh.net,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08E59665910

On Tue, Jun 9, 2026 at 6:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  8 Jun 2026 13:50:51 +0000 Eric Dumazet wrote:
> > Subject: [PATCH v2 net] bonding: no longer rely on RTNL in bond_fill_in=
fo()
>
> This one does not apply
> --
> pw-bot: cr

Wrong prefix, this should have been net-next., sorry for the confusion.

V3 is coming,

