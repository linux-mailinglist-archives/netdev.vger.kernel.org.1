Return-Path: <netdev+bounces-266249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F5QG2JPsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:05:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC0255391
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02AC6301F180
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F03BED22;
	Tue, 10 Mar 2026 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPdylzNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980039937E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162222; cv=pass; b=AKO9RJGXygdsCPFuQKDGy8XiKAJEFpTjYPcL98gqZDsODYxAaE+KwLL4uKn1STyYZrBtv2eyy9juvnij2Ytwn9ar3JWJB92yZMOWzPvdQhSKTs+OKfH+6CRtNRvu5Z5FfcjR3yRZwGexHOvd9kHfWAiXI1S3o835UojO3ZE5wBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162222; c=relaxed/simple;
	bh=MBo/+DJCBtPBAg/GOrVqvihj90PeTRm9an2hGLEYtcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBdNPwlrAKRal4qik7AIGNu37sy2VjZKcaYYveBOlCmRdMwEa2QkoVbx/qKKD4mCXF0tdSmcO5iO9vmvNjCOoVHNR4HEAZzrPUVpunre/t0dKaBkcDVXK7+L1alFHnlmGu49n4XaNeGecNypw/6Ypvticjkyv5MjVE7OWn/LGzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPdylzNv; arc=pass smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-4174754d693so112550fac.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773162220; cv=none;
        d=google.com; s=arc-20240605;
        b=a6W2ObxjA/PYGmif/FPiyGMD3Obb3tRPrfV2n9Qr+bRxrLMRxuIidi3oslH56lZXxM
         znbg/OTH9imr7F48yr3TVX4rWGBQPBcMJt/Y8FykI3OF1pubQtNGMl/vnW+aVBDptQXq
         z63VJijI2OhC31JAj+Ct5w43yh92Utubu/vtWIgWc3+cEYoBFSVRIPPOJzUinfYISbLl
         sh/+ce6rjCDWohz4s4Z6O/uyZ0nv0hSQevOawhI+1FwvZV/es6di7P6c+/YJdwPj0d0C
         DyzsM307396bPl/MUxCRswv7qFWbwsH1ujl30FTLERbBZ5t20kohBVBydgdRV8QxYBf6
         7Xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FR2Gqp79y8t+9qWgtj9KiChLZluaG/EMkEZUQPOEaSA=;
        fh=m+MlybpBgAvXRatjRUI4/rwZ0BxaHes2eWqCG1qWzds=;
        b=Wg2ecC8o5kfCzF8TkA91pXctWp51STI/tsLKmShD0zraBDlKhuu3cPMEWQZOCs/MZJ
         zpRJBgoCdmRzvroUZZMdCyEi4gNQIMDt/eRQW5CiFF8V5TPSreJ20hFeo4V6NSG6AZYu
         AUPrTJv+02L3qsdeB2DbizB67gr4P8c7XkVL0m/dIT/0B30a2DK6mYYViwFZB+I9rzX8
         txTtcA3qprcUZwC8pvRQ1++5DuW5MXmNRu4hdGv9pfcT4rEOvZa2mTc6ZBblLxjesN2e
         uo1oJ6JT4hiOZGpX/4FMHQ69wD+LhvNuHNNpwqOzmwrpE7EGEMJJx2uvQvVfxEg+9V4U
         WULQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162220; x=1773767020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR2Gqp79y8t+9qWgtj9KiChLZluaG/EMkEZUQPOEaSA=;
        b=YPdylzNvgdDGhgir0+R2aBHobWBVjIOI15tMXOoE29iPQkEpfPBTdW32FuFHIHPb7/
         SnqR2dKPIcas87oUWvyTRGA48aj8elHRXmWrWsTkIHcRkJrGF1NyQZ9urNRUNuL7wISr
         kUGu7If4Atf/1nGyhi4WuSeNQxFXvlgq/5MhhzdJ4EorkhSAtNueH2kIzYTgtp6T6wEh
         gwkzB6n/2QA0sIf9S5RRTwtHSf92/M+djifAsLROby1vHpN016cJ2TGo1CrDAkWfJxUq
         JfUrycuD8/W8jq3jfWIXUfUOniftdLQNeQQPEgleeM/7oiRA5POjW6+H0+qlSVNVaayO
         oYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162220; x=1773767020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FR2Gqp79y8t+9qWgtj9KiChLZluaG/EMkEZUQPOEaSA=;
        b=JgkfESn/PPrsz1mu8YY3J4CPg52C649hBrY1HZeKjPZnT/l6P1+b/CLld0+BcM/gu1
         HymnxogSWaVDH9z7zAT7usccupn3Lix5Y5zjApRRoSkXhjQ7DpLQIxuzE9MhqJp4zrbA
         kfJ7nTNd2/RfG5/RsbQks7d8wsMDaAQRiQK7jAtuAbeMlQHnirQXI5KILhyLwmmiqP+G
         t71eeLG24BodjwzE2Vpp/1CKIt47XW/srQzmwJR6QF9ofoKPBSeEC3V96rYOuujfnTu1
         jmCCz+Rcag5p1v6z3l+XGyYCJFpMoKN02pyVr8r2WunIW0GTj/+s7r7uA2YUGX3oMqbB
         ieeA==
X-Gm-Message-State: AOJu0YzU8WTP+meGc370qY8jg8g3YpyIy0lL0s3Ccj3HcqfBXh1DMsag
	G0n5uowM93VMvwD4HxihpIaMppoDB7kn08mKqBVUK1vLATB2+NHr23hFEV/HQl6lgIAao/EWPcd
	s8TjaKY0NnNEJ429iu1Z0ZXYFuTd0M7WYN+n43Nk=
X-Gm-Gg: ATEYQzzTin/peGvXijLYxZeJqxqBc6J46dHpYBG0IF0DKKFUv19Tq8vvfmFya//FfGw
	0lENb6UtlOroXRksI22Q7QpKGasp6bdVgJZVe3JKq6s3aqtWYYppcTUZUjR/E/SU2zgtxE9Zdmz
	vEhzEny7FVacJUWqlTTP/gIL8MCJdhkq5MZLbLZArrlR7tWMWyMLLG+I6VFbAm5L/mghBrIs2H+
	c0HYZOrLuBI2cusdbq8wQfa23CJvMlWH5oV7ob6qMwlIH5MyI1H2mRpkZ9qf8MCYEjWfpZpjQ+0
	pCBrUtiNn4ffrmERm+DQh7g=
X-Received: by 2002:a05:6808:1a17:b0:467:272e:883 with SMTP id
 5614622812f47-467272e1c4fmr807969b6e.1.1773162220123; Tue, 10 Mar 2026
 10:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-3-weibunny.kernel@gmail.com> <f316780b-141f-4a91-b517-71034a02aef7@gmail.com>
In-Reply-To: <f316780b-141f-4a91-b517-71034a02aef7@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 10 Mar 2026 10:03:29 -0700
X-Gm-Features: AaiRm523LaGJbKeHRQAWksz_ehkrUNhgh7qGKr9TfYohI6FsTdYcKCGrY9Jegoo
Message-ID: <CAGqc4nUMVyYYavr_z7eYSZ_H49XtfJTqvRJ3zyYt+2nd8D6BnQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B5CC0255391
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266249-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 7:25=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
>
> On 3/9/26 2:34 PM, Wei Wang wrote:
> >   +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *inf=
o)
> > +{
> > +     struct psp_dev *psd =3D info->user_ptr[0];
> > +     struct psp_assoc_dev *psp_assoc_dev;
> > +     struct net_device *assoc_dev;
> > +     u32 assoc_ifindex;
> > +     struct sk_buff *rsp;
> > +     struct net *net;
> > +     int nsid;
> > +
> > +     if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
> > +         GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
> > +             return -EINVAL;
> > +
> > +     nsid =3D nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> > +     net =3D get_net_ns_by_id(genl_info_net(info), nsid);
> > +     if (!net) {
> > +             NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_NSID]=
);
> > +             return -EINVAL;
> > +     }
>
> hmm, well I guess I still have the same comment from v2. If assoc_dev is
> in the same netns as genl_info_net(info), then userspace would need to
> create a self-referencing nsid to link them together. It might be a
> better uapi to change PSP_A_DEV_NSID to an optional attribute, and if
> not present then look for PSP_A_DEV_IFINDEX inside of genl_info_net(info)=
.

Ack. I probably missed this in the previous round. Making NSID
optional to just refer to the current user net-ns sounds good. Will
update.

