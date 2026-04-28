Return-Path: <netdev+bounces-281960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ3bMNTW8GkSZQEAu9opvQ
	(envelope-from <netdev+bounces-281960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:48:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5548835F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FA313011471
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9C319851;
	Tue, 28 Apr 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYOUlQGz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1723BAD9B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391311; cv=pass; b=cbvQxkeILMGPxs+H9B6bKhv+fhbc0G1BJlOhwnLzJlf2bnXcSAUBC3mjvUW0RxBDMsDC/tg2MXuDvUO8868cM3Z8Vz5NqfcaRzSi5w91vKJvIYVAp9xzsNirTKCGYYRU0QvpIa/0QNYeZlH6gLmyLUC/OVE0qflw7PP0mt006Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391311; c=relaxed/simple;
	bh=7CM++fXal+G2tkUkvJmv0H0WBsydRUNV3yA1ahpX1n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6BtZoKBkO5ofsaYKQxLr/KTwkxEu4LZenGiTLUw9u26Brg1D8xHFc6Mc4Lkr98hR2rF94NclO6RXBZQ9YjR6OEyrniKRLa/24WA58/BZKlLpn33j+0BTDN4sxxjjjGuMNZrusWwNrjSkZi9mH1bIrT5qktGrG/+FBOVaS5KdPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYOUlQGz; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506362ac5f7so94917021cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391308; cv=none;
        d=google.com; s=arc-20240605;
        b=c7EiWacVgzW7Zjc2X6T69QGDpHcI90lxkdcF5h4AdmEYhMmo8VUKC5l68oP2hoaGrU
         DSaqJ/0+scpRjEJwG/8+EdCp4fW4eA8AsvAIGeN93iJmG2nfCsTxYVTMBmtptnGbDMke
         NTlMxgDfj7W6Uf1KGztg3ncMxHqVveb5D5x+pRT6oAzaeD+SNB4qjujRkDUk4hVtrgXe
         TGQIRIdTQdIq3eA78HncATyyYGmUlXBGa06zhoEYkp+wsO2Adtk17zvoYBNehNjxjfiF
         gHhqyPrfS8LfRm7SARq6QjyQSoVFlORtOI3YttMbfq207rXZ7H+SfyeoB9uK1XQhYd86
         4quQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B1xnrEJZfwJhW7ekP5XfGETttSinvieCsiXQG2vnop4=;
        fh=KMYqjQpWVnfIrKk8+MD82lgDQgusnaVO3eEhSSQjJPk=;
        b=CR/1yVO6yC6MlokXqAVrfbmlg2nd64oUTld406Ertcq09xllt3H94L8NCuv9iBJt26
         FDkA5/yqAq45g0n6bHElx43zjolUmKsZZ8iKsBzKwgN2S1+RLdQbDBMgRixuiUiOtlsf
         HJPwI7RNnPtdHaPbFd9fTHla5lqEcLkMa+9CrXoG0y31bp9q7S8t4e2/LJdijvbeMHm0
         4iRw8cXYFQajjHOZqTZkG3DRO/XvVxOUMizSgbcOGLWeFX4YQyMjylv+6iS0WVRTLeFL
         WNyU8vZfCMOjz5qbr94OMkTbRc9oMR55CTeb+Dsv9eKFlm96vdTJOfm+l6oNc6kQtumR
         1vrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777391308; x=1777996108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1xnrEJZfwJhW7ekP5XfGETttSinvieCsiXQG2vnop4=;
        b=pYOUlQGzYa0DznIVyiigEUBBjJ2oNPezYTSx6p9GAHm0dgbmAWdpdzGxgR/CXwi+BA
         LYlaDmUu+qyrOA3uTsSC/X8RBGDuslOvvypXVVjpTEGZzHeLGCwWWsosP7ybHpnKS3ps
         UV/XLmRUYsH8Y/0pNZGj9z2lXmQpH/U+jk4GB7lLKY2Ofenhg1oyKjjqm67jUv7Id+LK
         ECgLtHeAK7ZBz7Q/Hyn2ytUVKObukIXn1ydXeg/9et2L2nQR8Sl+dg3YuGwGvb8N0XY3
         0brfAXKQNGwdoe82rRkyd68UD2+njCzq9jHWEpOrOs1DlukXMDvcI5MiIzoLQrWIhMUq
         rslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391308; x=1777996108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1xnrEJZfwJhW7ekP5XfGETttSinvieCsiXQG2vnop4=;
        b=IGyvLT7e735augxqO/MTBy2fEwqugincAlZD+lbxPzixL04a+GTa6BwRfmtgdxs8sW
         MzvqwutbdVzxHXGaQkvdFKYL/JDqywUvrNiTti6KnySFdqa+dsGtUzkTXZXcHW+KrXou
         klkb+XOR/SsR5/5tE73zwD+4L5MuynReG7bWydC2oK1zqVGPUred68t5Lx7VQgAqnaJm
         9VZzoIE5zLXp/eHmwcSZxsYNHQZGVl4Ofc3O4Kv4JrP2ZHWtKvQMHtHWxteLrIvwgzcB
         ElXUfD90eQrRwpuVSj7eHUjf7t0HY5NJi9n6MElwKTe56AcQR18TCUgtiOiRvGNVpUJq
         AzLA==
X-Forwarded-Encrypted: i=1; AFNElJ9S7oCQgYGkWrukqU2c5d4Qa2djiIsn2qyILhSkA83tEUAJns5J2pUUjjjVTMbFSCXqjw69Dq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nhdK1Nwa9MpqfeeRx+NJHmmF0e90rqHSMWAwVC/2rrxerw65
	sVOnGUnMNHy/4yrRzGgZYikl0czLvUR8uWnitxcwTOMgKSSA1yC2tvlIa25uUjCo5yKg5V6V68v
	9FRaeGdW0zmK385BH2pqWLzSHKOyXw8uZ4pLvyJ+S
X-Gm-Gg: AeBDieuEYaMio74/7KzGFris7rKTpisOF5oiiAj9qEczz9ZxM9HGYfAJ5ER1lMyM7t3
	YYteRM8YnDdUrfhvesDAooI1Yfi0UAIQ2NE4C4lDhLv55cM06rc3PCYmDD5ZE8a/Is1qeHOUjjp
	/q9LSTDhc6cBi0JAHEwe7cY0UNT2BpXkD+JshvaCKhfRlWWkIBDS7KgMqBjMrQkhfbDOtY38fJk
	V3ltij85NTy5wVA12h8o8eZtVKe1yEDrewpXe+7uhXSkIQ8VOqB34wpsJRbQYMwAoAq56Oo5kDd
	MCwLX3GuWfI9h6U+xooBJji5mySNhPXiQZn4WnoXSyKTzCK3U3kGxjwR8NsxVdxmrSFwl8JiB8/
	iv2joPqAq
X-Received: by 2002:a05:622a:552:b0:50f:c5d3:a191 with SMTP id
 d75a77b69052e-5100e10ee8cmr50783111cf.13.1777391307511; Tue, 28 Apr 2026
 08:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com> <20260427132555.1791636-3-edumazet@google.com>
 <20260427160847.5dbf1915@kernel.org>
In-Reply-To: <20260427160847.5dbf1915@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 08:48:16 -0700
X-Gm-Features: AVHnY4I7hheN0uUNybMVC9rjtMoBEzgX0af9_QV4_czFFaUTz2PmbuYVv5SVJyw
Message-ID: <CANn89iJMg7cy=1tbxbWV36Xckvt01sw9N=Hy5pcohYz8FiYzAA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] net/sched: tc_dump_qdisc_root() refactor
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0FF5548835F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281960-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 4:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 27 Apr 2026 13:25:53 +0000 Eric Dumazet wrote:
> > -     if (q_idx < s_q_idx) {
> > -             q_idx++;
> > -     } else {
> > -             if (!tc_qdisc_dump_ignore(q, dump_invisible) &&
> > -                 tc_fill_qdisc(skb, q, q->parent, NETLINK_CB(cb->skb).=
portid,
> > -                               cb->nlh->nlmsg_seq, NLM_F_MULTI,
> > -                               RTM_NEWQDISC, NULL) <=3D 0)
> > -                     goto done;
> > -             q_idx++;
> > +     if (!(q_idx < s_q_idx) &&
> > +         !tc_qdisc_dump_ignore(q, dump_invisible)) {
> > +             ret =3D tc_fill_qdisc(skb, q, q->parent,
> > +                                 NETLINK_CB(cb->skb).portid,
> > +                                 cb->nlh->nlmsg_seq, NLM_F_MULTI,
> > +                                 RTM_NEWQDISC, NULL);
> > +             if (ret < 0)
> > +                     goto out;
> >       }
> > +     q_idx++;
>
> Probably subjective but I'm not sure the
>
>         if (!(q_idx < s_q_idx) &&
>
> is more readable than the previous version?
>
> Especially for:
>
> >       hash_for_each(qdisc_dev(root)->qdisc_hash, b, q, hash) {
> > -             if (q_idx < s_q_idx) {
> > -                     q_idx++;
> > -                     continue;
> > +             if (!(q_idx < s_q_idx) &&
> > +                 !tc_qdisc_dump_ignore(q, dump_invisible)) {
> > +                     ret =3D tc_fill_qdisc(skb, q, q->parent,
> > +                                         NETLINK_CB(cb->skb).portid,
> > +                                         cb->nlh->nlmsg_seq, NLM_F_MUL=
TI,
> > +                                         RTM_NEWQDISC, NULL);
> > +                     if (ret < 0)
> > +                             goto out;
> >               }
>
> I feel like checking the ID + continue in netlink dump loop is fairly
> idiomatic.

OK, this was removing one indent level.

I will keep the double q_idx++ then.

